auto vmbr1
iface vmbr1 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
#ISP-HQ-R

auto vmbr2
iface vmbr2 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
#ISP-BR-R

auto vmbr3
iface vmbr3 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
#HQ-R-HQ-SW

auto vmbr4
iface vmbr4 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
#BR-R-BR-SW
