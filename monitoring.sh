#!/bin/bash
    architectur=$(uname -a)
    cpuphysical=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
    cpuvirtual=$(cat /proc/cpuinfo | grep processor | wc -l)
    memoryusage=$(free --mega | grep Mem | awk '{printf("%d/%dMB (%.2f%%)\n", $3, $2, ($3 / $2) * 100 )}')
    fulldisk=$(df -BG | grep '^/dev/' | grep -v '/boot' | awk '{ft += $2} END {print ft}')
    usagedisk=$(df -BM | grep '^/dev/' | grep -v '/boot' | awk '{ut += $3} END {print ut}')
    pordisk=$(df -BM | grep '^/dev/' | grep -v '/boot' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
    cpuload=$(mpstat 1 1 | grep Average | awk '{printf "%.2f\n", 100 - $NF}')
    lastboot=$(uptime -s | cut -c-16)
    lvmu=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
    ctcp=$(ss -t | grep ESTAB | wc -l)
    ulog=$(users | tr " " "\n" | uniq | wc -l)
    ip=$(hostname -I)
    mac=$(ip link | grep "ether" | awk '{print $2}')
    cmds=$( hyj)
    wall "    #Architecture: $architectur
        #CPU physical: $cpuphysical
        #vCPU: $cpuvirtual
        #Memory Usage: $memoryusage
        #Disk Usage: $usagedisk/${fulldisk}Gb ($pordisk%)
        #CPU load: $cpuload
        #Last boot: $lastboot
        #LVM use: $lvmu
        #Connections TCP: $ctcp ESTABLISHED
        #User log: $ulog
        #Network: IP $ip ($mac)
        #Sudo: $cmds cmd"