#!/bin/bash
cat ./BridgeInterfaces.txt >> /etc/network/interfaces;
for s in $(seq 1 10); do
for i in $(seq 1 4); do
mkdir /etc/net/ifaces/vmbr$s$i ; cp ./vmbropt.txt /etc/net/ifaces/vmbr$s$i/options
done
done
systemctl restart network;
apt-get install python3-pip python3-venv -y;
python3 -m venv myenv;
source myenv/bin/activate;
pip3 install wldhx.yadisk-direct;
read -p "Enter the local storage name: " STORAGE
curl -L $(yadisk-direct https://disk.yandex.ru/d/cX4HEQS4_VXOTw) -o ISP-disk001.vmdk
curl -L $(yadisk-direct https://disk.yandex.ru/d/1_vGyrhtlGtQpw) -o HQ-SRV-disk001.vmdk
curl -L $(yadisk-direct https://disk.yandex.ru/d/RKc3dBcAuFQ4tg) -o CLI-disk001.vmdk
qm create 101 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1 --net0 virtio,bridge=vmbr11 --net0 virtio,bridge=vmbr12
qm importdisk 101 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 101 -sata0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=sata0
echo "ISP is done!!!"
qm create 102 --name "HQ-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr11 --net0 virtio,bridge=vmbr13  
qm importdisk 102 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 102 -sata0 $STORAGE:102/vm-102-disk-0.qcow2 --boot order=sata0
echo "HQ-R is done!!!"
qm create 103 --name "BR-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr12 --net0 virtio,bridge=vmbr14
qm importdisk 103 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 103 -sata0 $STORAGE:103/vm-103-disk-0.qcow2 --boot order=sata0
echo "BR-R is done!!!"
qm create 104 --name "HQ-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr13
qm importdisk 104 HQ-SRV-disk001.vmdk $STORAGE --format qcow2
qm set 104 -sata0 $STORAGE:104/vm-104-disk-0.qcow2 --boot order=sata0
echo "HQ-SRV is done!!!"
qm create 105 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr14
qm importdisk 105 HQ-SRV-disk001.vmdk $STORAGE --format qcow2
qm set 105 -sata0 $STORAGE:105/vm-105-disk-0.qcow2 --boot order=sata0
echo "BR-SRV is done!!!"
qm create 106 --name "CLI" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1
qm importdisk 106 CLI-disk001.vmdk $STORAGE --format qcow2
qm set 106 -sata0 $STORAGE:106/vm-106-disk-0.qcow2 --boot order=sata0
echo "CLI is done!!!"
echo "ALL DONE!!!"
