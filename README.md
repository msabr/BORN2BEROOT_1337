# **Born2beroot - 42 Network**  
<div align="center">
<img src="Born2beroot.png"/>
</div>

## **Overview**  
Born2beroot is a system administration project that introduces the fundamentals of **virtualization, server security, and Linux configuration**. The goal is to set up a **secure Debian-based virtual machine** while implementing essential security measures and user management.  

## **Project Scope**  
In this project, you will:  
- Install and configure a **Debian-based virtual machine** (using VirtualBox or UTM).  
- Set up a **custom user and groups** with specific permissions.  
- Implement **UFW (Uncomplicated Firewall)** for security.  
- Enforce strong **password policies** and **sudo rules**.  
- Configure **SSH** to allow remote connections securely.  
- Implement **disk partitioning and LVM (Logical Volume Manager)**.  
- Set up and use **monitoring tools** to track system performance.  

## **Learning Outcomes**  
- Understanding **virtualization** and **system setup**.  
- Strengthening knowledge of **Linux security best practices**.  
- Managing **users, permissions, and groups** effectively.  
- Implementing and maintaining **firewall configurations**.  
- Learning **LVM partitioning** for flexible disk management.  
- Using **monitoring tools** to track system health.  

## **Setup Instructions**  
### **1. Install Debian and Configure Virtual Machine**  
- Use **VirtualBox** (or **UTM for macOS**).  
- Install a **minimal Debian environment** without a GUI.  

### **2. User and Group Management**  
- Create a **new user** with **sudo privileges**.  
- Configure **password expiration policies** to enforce security.  

### **3. Security Enhancements**  
- Install and configure **UFW (Uncomplicated Firewall)**.  
- Disable **root login via SSH** and change the default SSH port.  
- Implement strong **password policies** using `pam_pwquality`.  

### **4. LVM Partitioning**  
- Use **LVM (Logical Volume Manager)** for flexible storage allocation.  
- Set up separate partitions for **root, home, and swap**.  

## **System Monitoring Script**  
As part of the project, a **system monitoring script** is required to display important system metrics. Below is the script that **automatically runs every 10 minutes**, sending a message to all logged-in users via `wall`.  

### **Script:**
```bash
#!/bin/bash

# System Architecture
architectur=$(uname -a)

# CPU Information
cpuphysical=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
cpuvirtual=$(grep -c "processor" /proc/cpuinfo)

# Memory Usage
memoryusage=$(free --mega | awk '/Mem/ {printf("%d/%dMB (%.2f%%)\n", $3, $2, ($3 / $2) * 100 )}')

# Disk Usage
fulldisk=$(df -BG | awk '/^\/dev/ && !/boot/ {sum += $2} END {print sum}')
usagedisk=$(df -BM | awk '/^\/dev/ && !/boot/ {sum += $3} END {print sum}')
pordisk=$(df -BM | awk '/^\/dev/ && !/boot/ {used+=$3} {total+=$2} END {printf("%.2f"), (used/total)*100}')

# CPU Load
cpuload=$(mpstat 1 1 | awk '/Average/ {printf "%.2f\n", 100 - $NF}')

# Last Boot Time
lastboot=$(uptime -s | cut -c-16)

# LVM Usage
lvmu=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")

# Established TCP Connections
ctcp=$(ss -t state established | wc -l)

# Logged-in Users
ulog=$(who | cut -d " " -f1 | sort -u | wc -l)

# Network Information
ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | awk '/ether/ {print $2}')

# Sudo Commands Executed
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

# Display System Information
wall "  
    #Architecture: $architectur
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
    #Sudo: $cmds commands executed"

