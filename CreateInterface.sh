#!/bin/bash
#Создание интерфейса для машины ISP0 -доступ в интернет для всех стендов
#cat ./BridgeInterfaces.txt >> /etc/network/interfaces.new;
FileInt=/etc/network/interfaces.new1
echo -e '\n'auto vmbr1 >> $FiileInt;
echo iface vmbr1 inet manual >> $FiileInt;
echo -e '\t'bridge-ports none >> $FiileInt;
echo -e '\t'bridge-stp off >> $FiileInt;
echo -e '\t'bridge-fd 0 >> $FiileInt;
echo \#ISP0 >> $FiileInt;
#Создание интерфейсов для виртуальных машин
for s in $(seq 1 20); do
for i in $(seq 1 4); do
IntNum=vmbr$s$i
echo -e '\n'auto ${IntNum} >> $FiileInt;
echo iface ${IntNum} inet manual >> $FiileInt;
echo -e '\t'bridge-ports none >> $FiileInt;
echo -e '\t'bridge-stp off >> $FiileInt;
echo -e '\t'bridge-fd 0 >> $FiileInt;
case $i in
  1)
    echo \#ISP-HQ-R >> $FiileInt;
    ;;
  2)
    echo \#ISP-BR-R >> $FiileInt;
    ;;
  3)
    echo \#HQ-R-HQ-SRV >> $FiileInt;
    ;;
  4)
    echo \#BR-R-BR-SRV >> $FiileInt;
    ;;
esac
done
done
