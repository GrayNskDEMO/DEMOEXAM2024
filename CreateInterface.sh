#!/bin/bash
#cat ./BridgeInterfaces.txt >> /etc/network/interfaces.new;
FileInt=/etc/network/interfaces
#Создание интерфейсов для виртуальных машин
for s in $(seq 1 20); do
for i in $(seq 1 4); do
IntNum=vmbr$s$i
echo -e '\n'auto ${IntNum} >> $FileInt;
echo iface ${IntNum} inet manual >> $FileInt;
echo -e '\t'bridge-ports none >> $FileInt;
echo -e '\t'bridge-stp off >> $FileInt;
echo -e '\t'bridge-fd 0 >> $FileInt;
case $i in
  1)
    echo \#ISP-HQ-R >> $FileInt;
    ;;
  2)
    echo \#ISP-BR-R >> $FileInt;
    ;;
  3)
    echo \#HQ-R-HQ-SRV >> $FileInt;
    ;;
  4)
    echo \#BR-R-BR-SRV >> $FileInt;
    ;;
esac
done
done
