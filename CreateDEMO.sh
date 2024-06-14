#!/bin/bash
cat ./BridgeInterfaces.txt >> /etc/network/interfaces;
read -p "Enter number students: " Std
for i in $(seq 1 4); do
mkdir /etc/net/ifaces/vmbr$i ; cp ./vmbropt.txt /etc/net/ifaces/vmbr$i/options
done
systemctl restart network;
apt-get install python3-pip python3-venv -y;
python3 -m venv myenv;
source myenv/bin/activate;
pip3 install wldhx.yadisk-direct;
read -p "Enter the local storage name: " STORAGE
curl -L $(yadisk-direct https://disk.yandex.ru/d/cX4HEQS4_VXOTw) -o ISP-disk001.vmdk
qm create 101 --name "ISP" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr7
qm importdisk 101 ISP-disk001.vmdk $STORAGE --format qcow2
qm set 101 -ide0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
echo "ALL DONE!!!"
