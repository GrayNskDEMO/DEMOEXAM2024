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
qm create 101 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1 --net0 virtio,bridge=vmbr1 --net0 virtio,bridge=vmbr1
qm importdisk 101 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 101 -sata0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
qm create 102 --name "HQ-R" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr7
qm importdisk 102 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 102 -sata0 $STORAGE:102/vm-102-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
qm create 101 --name "ISP" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr7
qm importdisk 101 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 101 -ide0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
qm create 101 --name "ISP" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr7
qm importdisk 101 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 101 -ide0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
qm create 101 --name "ISP" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr7
qm importdisk 101 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 101 -ide0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
qm create 101 --name "ISP" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr7
qm importdisk 101 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 101 -ide0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
echo "ALL DONE!!!"
