#!/bin/bash
#Создание интерфейса для машины ISP0 -доступ в интернет для всех стендов
#cat ./BridgeInterfaces.txt >> /etc/network/interfaces.new;
echo auto vmbr1 >> /etc/network/interfaces;
echo iface vmbr1 inet manual >> /etc/network/interfaces.new;
echo         bridge-ports none >> /etc/network/interfaces.new;
echo         bridge-stp off >> /etc/network/interfaces.new;
echo         bridge-fd 0 >> /etc/network/interfaces.new;
echo #ISP0 >> /etc/network/interfaces.new;
#Создание интерфейсов для виртуальных машин
for s in $(seq 1 10); do
for i in $(seq 1 4); do
echo auto vmbr11 >> /etc/network/interfaces.new;
echo iface vmbr11 inet manual >> /etc/network/interfaces.new;
echo         bridge-ports none >> /etc/network/interfaces.new;
echo         bridge-stp off >> /etc/network/interfaces.new;
echo         bridge-fd 0 >> /etc/network/interfaces.new;
case $i in
  1)
    echo #ISP-HQ-R >> /etc/network/interfaces.new;
    ;;
  2)
    echo #ISP-HQ-R >> /etc/network/interfaces.new;
    ;;
  3)
    echo #ISP-HQ-R >> /etc/network/interfaces.new;
    ;;
  4)
    echo #ISP-HQ-R >> /etc/network/interfaces.new;
    ;;
esac
echo #ISP-HQ-R
done
done
