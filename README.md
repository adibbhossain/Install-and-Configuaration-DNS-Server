# Install-and-Configuaration-DNS-Server
This repository contains all necessary files and configurations to **install and configure a DNS Server** on Ubuntu using **BIND9**.

## Project Description
This project sets up a **DNS (Domain Name System) server** on Linux using **BIND** to handle domain name resolution for a network. It includes:
- Setting up **zone files** (both forward and reverse zone).
- Managing **DNS records** (A, AAAA, CNAME, MX, etc.).

## Prerequisites
- A Linux-based system (We used Ubuntu).
- Basic understanding of networking and DNS concepts.
- **BIND9** installed on your system.

## Installation and Configuration Steps

### 1. Install `BIND9`
```bash
sudo apt update
sudo apt install bind9
```
### 2. Configure the `/etc/hosts` file
Edit the `/etc/hosts` file to add the device IP address that will serve as the DNS Server.
```bash
sudo vim /etc/hosts/
```
Example configuration (replace `adib-Latitude-7480` with your hostname and `10.248.129.72` with your IP):
```bash
127.0.0.1 localhost
127.0.1.1 adib-Latitude-7480.adib.local adib-Latitude-7480 
10.248.129.72 adib-Latitude-7480.adib.local adib-Latitude-7480
```
### 3. Configure `named.conf.options` file
Before modifying, create a backup:
```bash
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options.orig
```
Now, open the file:
```bash
sudo vim /etc/bind/named.conf.options
```
Add the following inside the `{}` block:
```bash
recursion yes;
listen-on {10.248.129.72;};
allow-transfer {none;};
forwarders {
  10.248.129.72; # # Use your DNS Server's IP
};
```
### 4. Configure `named.conf.local`
Backup the file:
```bash
sudo cp /etc/bind/named.conf.local /etc/bind/named.conf.local.orig
```
Edit the file:
```bash
sudo gedit /etc/bind/named.conf.local
```
Add these entries for **forward and reverse lookup zones:**
```bash
// forward lookup zone
zone "adib.local" IN {
	type master;
	file "/etc/bind/db.adib.local";
};
// reverse lookup zone
zone "129.248.10.in-addr.arpa" IN {
	type master;
	file "/etc/bind/db.129.248.10";
};
```
### 5. Create the *Forward Lookup Zone* File
Duplicate the sample `db.local` file:
```bash
sudo cp /etc/bind/db.local /etc/bind/db.adib.local
```
Edit the file:
```bash
sudo gedit /etc/dind/db.adib.local
```
Modify the file to match your domain settings:
```bash
$TTL 86400
@   IN  SOA  ns1.adib.local. root.adib.local. (
        2024031501 ; Serial
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400 )    ; Minimum TTL
;
@   IN  NS  ns1.adib.local.
ns1 IN  A   10.248.129.72
www IN  A   10.248.129.72
ftp IN  A   10.248.129.72
@   IN  MX  10 mail
mail IN  A   10.248.129.72
@   IN  AAAA ::1
```
### 6. Create the *Reverse Lookup Zone* File
Duplicate the sample `db.127` file:
```bash
sudo cp /etc/bind/db.127 /etc/bind/db.129.248.10
```
Edit the file:
```bash
sudo gedit /etc/bind/db.129.248.10
```
Modify the file:
```bash
$TTL 86400
@   IN  SOA  ns1.adib.local. root.adib.local. (
        2024031501 ; Serial
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400 )    ; Minimum TTL
;
@   IN  NS  ns1.adib.local.
72  IN  PTR ns1.adib.local.
72  IN  PTR www.adib.local.
72  IN  PTR ftp.adib.local.
72  IN  PTR mail.adib.local.
```
### 7. Restart and Check BIND Service
```bash
sudo service bind9 restart
sudo service bind9 status
```
### 9. Update the `resolv.conf` File
To ensure our system uses the new DNS server, we must update the `resolv.conf` file.
First, remove the existing `resolv.conf`:
```bash
sudo rm /etc/resolv.conf
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```
Then, create a symbolic link to keep it dynamic:
```bash
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```
Now, edit the file:
```bash
sudo gedit /etc/resolv.conf
```
Update it with your new DNS Server IP:
```bash
nameserver 10.248.129.72
search localdomain
```

### 10. Test the DNS Server
Using `nslookup`
```bash
nslookup www.adib.local
```
Expected Output:
```bash
Server:		10.248.129.72 
Address:	10.248.129.72#53

Name:	www.adib.local # My DNS server name
Address: 10.248.129.72 # My DNS server IP address
```













