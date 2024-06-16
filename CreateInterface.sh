#!/bin/bash
cat ./BridgeInterfaces.txt >> /etc/network/interfaces;
#Создание интерфейса для машины ISP0 -доступ в интернет для всех стендов
#cat ./BridgeInterfaces.txt >> /etc/network/interfaces;
echo auto vmbr1 >> /etc/network/interfaces;
echo iface vmbr1 inet manual >> /etc/network/interfaces;
echo         bridge-ports none >> /etc/network/interfaces;
echo         bridge-stp off >> /etc/network/interfaces;
echo         bridge-fd 0 >> /etc/network/interfaces;
echo #ISP0 >> /etc/network/interfaces;
#Создание интерфейсов для виртуальных машин
for s in $(seq 1 10); do
for i in $(seq 1 4); do
echo auto vmbr11 >> /etc/network/interfaces;
echo iface vmbr11 inet manual >> /etc/network/interfaces;
echo         bridge-ports none >> /etc/network/interfaces;
echo         bridge-stp off >> /etc/network/interfaces;
echo         bridge-fd 0 >> /etc/network/interfaces;
case $i in
  1)
    echo #ISP-HQ-R >> /etc/network/interfaces;
    ;;
  2)
    echo #ISP-HQ-R >> /etc/network/interfaces;
    ;;
  3)
    echo #ISP-HQ-R >> /etc/network/interfaces;
    ;;
  4)
    echo #ISP-HQ-R >> /etc/network/interfaces;
    ;;
esac
echo #ISP-HQ-R
done
