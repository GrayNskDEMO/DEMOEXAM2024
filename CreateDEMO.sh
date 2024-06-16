#!/bin/bash
cat ./BridgeInterfaces.txt >> /etc/network/interfaces;
#Создание интерфейса для машины ISP0 -доступ в интернет для всех стендов
cat ./BridgeInterfaces.txt >> /etc/network/interfaces;
echo auto vmbr1 >> /etc/network/interfaces;
echo iface vmbr11 inet manual >> /etc/network/interfaces;
echo         bridge-ports none >> /etc/network/interfaces;
echo         bridge-stp off >> /etc/network/interfaces;
echo         bridge-fd 0 >> /etc/network/interfaces;
echo #ISP0 >> /etc/network/interfaces;
#Создание интерфейсов для виртуальных машин
for s in $(seq 1 10); do
for i in $(seq 1 4); do
cat ./BridgeInterfaces.txt >> /etc/network/interfaces;
echo auto vmbr11
iface vmbr11 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
#ISP-HQ-R
done
done
mkdir /etc/net/ifaces/vmbr1 ; cp ./vmbropt.txt /etc/net/ifaces/vmbr1/options
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
for s in $(seq 1 10); do
let s1=$s+10
Vm=(${s1})
IntNum=vmbr$s
qm create ${Vm}1 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1 --net1 virtio,bridge=${IntNum}1 --net2 virtio,bridge=${IntNum}2
qm importdisk ${Vm}1 ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}1 -sata0 $STORAGE:${Vm}1/vm-${Vm}1-disk-0.qcow2 --boot order=sata0
echo "ISP"$s" is done!!!"
qm create ${Vm}2 --name "HQ-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}1 --net1 virtio,bridge=${IntNum}3  
qm importdisk ${Vm}2 ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}2 -sata0 $STORAGE:${Vm}2/vm-${Vm}2-disk-0.qcow2 --boot order=sata0
echo "HQ-R"$s" is done!!!"
qm create ${Vm}3 --name "BR-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}2 --net1 virtio,bridge=${IntNum}4
qm importdisk ${Vm}3 ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}3 -sata0 $STORAGE:${Vm}3/vm-${Vm}3-disk-0.qcow2 --boot order=sata0
echo "BR-R"$s" is done!!!"
qm create ${Vm}4 --name "HQ-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}3
qm importdisk ${Vm}4 HQ-SRV-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}4 -sata0 $STORAGE:${Vm}4/vm-${Vm}4-disk-0.qcow2 --boot order=sata0
echo "HQ-SRV"$s" is done!!!"
qm create ${Vm}5 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}4
qm importdisk ${Vm}5 HQ-SRV-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}5 -sata0 $STORAGE:${Vm}5/vm-${Vm}5-disk-0.qcow2 --boot order=sata0
echo "BR-SRV"$s" is done!!!"
qm create ${Vm}6 --name "CLI" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1
qm importdisk ${Vm}6 CLI-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}6 -sata0 $STORAGE:${Vm}6/vm-${Vm}6-disk-0.qcow2 --boot order=sata0
echo "CLI"$s" is done!!!"
done
echo "ALL DONE!!!"
