#!/bin/bash
./CreateInterface.sh

for s in $(seq 1 20); do
for i in $(seq 1 4); do
mkdir /etc/net/ifaces/vmbr$s$i ; cp ./vmbropt.txt /etc/net/ifaces/vmbr$s$i/options
done
done
systemctl restart network;
#apt-get install python3-pip python3-venv -y;
#python3 -m venv myenv;
#source myenv/bin/activate;
#pip3 install wldhx.yadisk-direct;
#read -p "Enter the local storage name: " STORAGE
#curl -L $(yadisk-direct https://disk.yandex.ru/d/cX4HEQS4_VXOTw) -o ISP-disk001.vmdk
#curl -L $(yadisk-direct https://disk.yandex.ru/d/1_vGyrhtlGtQpw) -o HQ-SRV-disk001.vmdk
#curl -L $(yadisk-direct https://disk.yandex.ru/d/RKc3dBcAuFQ4tg) -o CLI-disk001.vmdk
for s in $(seq 1 20); do
echo "Create"$s" stend!!!"
case $s in
  1)
    STORAGE=disk1;
    ;;
  2)
    STORAGE=disk2;
    ;;
  3)
    STORAGE=disk3;
    ;;
  4)
    STORAGE=disk4;
    ;;
  5)
    STORAGE=disk5;
    ;;
  6)
    STORAGE=disk6;
    ;;
  7)
    STORAGE=disk1;
    ;;
  8)
    STORAGE=disk2;
    ;;
  9)
    STORAGE=disk3;
    ;;
  10)
    STORAGE=disk4;
    ;;
  11)
    STORAGE=disk5;
    ;;
  12)
    STORAGE=disk6;
    ;;
  13)
    STORAGE=disk1;
    ;;
  14)
    STORAGE=disk2;
    ;;
  15)
    STORAGE=disk3;
    ;;
  16)
    STORAGE=disk4;
    ;;      
  17)
    STORAGE=disk5:
    ;;
  18)
    STORAGE=disk6;
    ;;
  19)
    STORAGE=disk1;
    ;;
  20)
    STORAGE=disk2;    
esac
#read -p "Enter the local storage name: " STORAGE
let s1=$s+10
Vm=(${s1})
IntNum=vmbr$s
qm create ${Vm}1 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1 --net1 virtio,bridge=${IntNum}1 --net2 virtio,bridge=${IntNum}2
qm importdisk ${Vm}1 ../image/ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}1 -sata0 $STORAGE:${Vm}1/vm-${Vm}1-disk-0.qcow2 --boot order=sata0
echo "ISP"$s" is done!!!"
qm create ${Vm}2 --name "HQ-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}1 --net1 virtio,bridge=${IntNum}3  
qm importdisk ${Vm}2 ../image/ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}2 -sata0 $STORAGE:${Vm}2/vm-${Vm}2-disk-0.qcow2 --boot order=sata0
echo "HQ-R"$s" is done!!!"
qm create ${Vm}3 --name "BR-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}2 --net1 virtio,bridge=${IntNum}4
qm importdisk ${Vm}3 ../image/ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}3 -sata0 $STORAGE:${Vm}3/vm-${Vm}3-disk-0.qcow2 --boot order=sata0
echo "BR-R"$s" is done!!!"
qm create ${Vm}4 --name "HQ-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}3
qm importdisk ${Vm}4 ../image/ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}4 -sata0 $STORAGE:${Vm}4/vm-${Vm}4-disk-0.qcow2 --boot order=sata0
echo "HQ-SRV"$s" is done!!!"
qm create ${Vm}5 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=${IntNum}4
qm importdisk ${Vm}5 ../image/ISP-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}5 -sata0 $STORAGE:${Vm}5/vm-${Vm}5-disk-0.qcow2 --boot order=sata0
echo "BR-SRV"$s" is done!!!"
qm create ${Vm}6 --name "CLI" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr1
qm importdisk ${Vm}6 ../image/CLI-disk001.vmdk $STORAGE --format qcow2
qm set ${Vm}6 -sata0 $STORAGE:${Vm}6/vm-${Vm}6-disk-0.qcow2 --boot order=sata0
echo "CLI"$s" is done!!!"
done
echo "ALL DONE!!!"
