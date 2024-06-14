#!/bin/bash
for s in $(seq 1 10); do
qm create $s01 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1 --net1 virtio,bridge=vmbr$s1 --net2 virtio,bridge=vmbr$s2
qm importdisk $s01 ISP-disk001.vmdk $STORAGE --format qcow2
qm set $s01 -sata0 $STORAGE:$s01/vm-$s01-disk-0.qcow2 --boot order=sata0
echo "ISP"$s" is done!!!"
qm create $s02 --name "HQ-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr$s1 --net1 virtio,bridge=vmbr$s3  
qm importdisk $s02 ISP-disk001.vmdk $STORAGE --format qcow2
qm set $s02 -sata0 $STORAGE:$s02/vm-$s02-disk-0.qcow2 --boot order=sata0
echo "HQ-R"$s" is done!!!"
qm create $s03 --name "BR-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr$s2 --net1 virtio,bridge=vmbr$s4
qm importdisk $s03 ISP-disk001.vmdk $STORAGE --format qcow2
qm set $s03 -sata0 $STORAGE:$s03/vm-$s03-disk-0.qcow2 --boot order=sata0
echo "BR-R"$s" is done!!!"
qm create $s04 --name "HQ-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr$s3
qm importdisk $s04 HQ-SRV-disk001.vmdk $STORAGE --format qcow2
qm set $s04 -sata0 $STORAGE:$s04/vm-$s04-disk-0.qcow2 --boot order=sata0
echo "HQ-SRV"$s" is done!!!"
qm create $s05 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr$s4
qm importdisk $s05 HQ-SRV-disk001.vmdk $STORAGE --format qcow2
qm set $s05 -sata0 $STORAGE:$s05/vm-$s05-disk-0.qcow2 --boot order=sata0
echo "BR-SRV"$s" is done!!!"
qm create $s06 --name "CLI" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1
qm importdisk $s06 CLI-disk001.vmdk $STORAGE --format qcow2
qm set $s06 -sata0 $STORAGE:$s06/vm-$s06-disk-0.qcow2 --boot order=sata0
echo "CLI"$s" is done!!!"
done
echo "ALL DONE!!!"
