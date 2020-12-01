#!/bin/bash
#
# Copyright (c) 2019, 2020, Oracle and/or its affiliates. All rights reserved.
#

function log() {
    while IFS= read -r line; do
        DATE=`date '+%Y-%m-%d %H:%M:%S.%N'`
        echo "<$DATE>  $line"
    done
}

fileName=$(basename $BASH_SOURCE)
scriptsDir='/u01/scripts'
logs_dir='/u01/logs'

mkdir -p ${scriptsDir}
mkdir -p ${logs_dir}

#create log files
log_file="${logs_dir}/bootstrap.log"
touch $log_file

#unzip scripts
python ${scriptsDir}/bootstrap.py 2>&1 | log >> $log_file
#Get exit code for bootstrap.py
exit_code_array=( "${PIPESTATUS[@]}" )
exit_code="${exit_code_array[0]}"
if [ $exit_code -ne 0 ]; then
    msg="Error executing bootstrap.py -> $exit_code"
    echo ${msg} | log >> $log_file
    #Create marker manually because the scripts might not be there (because bootstrap.py unzips them)
    echo ${msg} >/u01/.markers/.provFailedMarker
    exit $exit_code
fi

touch ${logs_dir}/provisioning_cmd.out
touch ${logs_dir}/provisioning.log

chown -R opc:opc /u01
chmod -R +x /u01

wls_version=$(python ${scriptsDir}/metadata/databag.py wls_version)
admin_mount_path=$(python ${scriptsDir}/metadata/databag.py admin_mount_path)
create_policies=$(python ${scriptsDir}/metadata/databag.py create_policies)

####Checking version
${scriptsDir}/clogging/shellLogging.py Info "0001" $fileName $exit_code
sh ${scriptsDir}/bootstrap/check_versions.sh
exit_code=$?

if [ $exit_code -ne 0 ]; then
    ${scriptsDir}/clogging/shellLogging.py Error "0001" $fileName $exit_code
    python ${scriptsDir}/status/markers.py create-failure-file '.provFailedMarker' $wls_version "Failed in version script's version check."
fi

#execute provisioner if check version is successful
if [ $exit_code -eq 0 ]; then
    touch /tmp/provisioning.log

    ${scriptsDir}/clogging/shellLogging.py Info "0044" $fileName

    sudo su - opc -c "python  ${scriptsDir}/provisioning_actions/provisioner.py"
    exit_code=$?

    if [ $exit_code -ne 0 ]; then
        ${scriptsDir}/clogging/shellLogging.py Error "0037" $fileName $exit_code
        python ${scriptsDir}/status/markers.py create-failure-file '.provFailedMarker' $wls_version "Failed to execute provisioner script."
    fi

    #log final status to provisioning_cmd.out
    sh ${scriptsDir}/utils/oke_status.sh
fi

#update dynamic group only if policies were created during provisioning
if [ "$create_policies" == "true" ]; then
    sudo su - opc -c "sh ${scriptsDir}/bootstrap/update_dynamic_groups.sh"
fi

${scriptsDir}/clogging/shellLogging.py Info "0069" $fileName
#clean up script
sh ${scriptsDir}/bootstrap/tidyup.sh

${scriptsDir}/clogging/shellLogging.py Info "0071" $fileName
