# **Born2beroot - 42 Network**  

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

### **5. System Monitoring**  
- Install and configure **system monitoring tools** such as:  
  - `lsblk` - View disk partitions.  
  - `df -h` - Monitor disk usage.  
  - `top` / `htop` - Check system performance.  
  - `crontab` - Automate system updates and logs.  

