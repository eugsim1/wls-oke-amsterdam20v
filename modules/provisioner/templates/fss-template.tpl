{
	"image": {
		"pullPolicy": "IfNotPresent",
		"pullSecret": "${ocir_secret_name}"
	},
	"storageClass": {
		"create": true,
		"provisionerName": "oracle.com",
		"mntTargetId": "${mount_target_id}"
	},
	"volumeMounts": {
		"mountPath": "${nfs_mount_path}"
	},
	"volumes": {
		"claimName": "${fss_chart_name}-pvc"
	},
	"persistence": {
		"enabled": true,
		"ip": "${nfs_mount_ip}",
		"path": "${nfs_mount_path}",
		"accessMode": "ReadWriteMany",
		"size": "100Gi"
	},
	"resources": {},
	"nodeSelector": {},
	"tolerations": [],
	"affinity": {}
}