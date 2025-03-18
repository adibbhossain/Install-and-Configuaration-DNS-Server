# Install-and-Configuaration-DNS-Server
collection of necessary files to Install and Confuguration a DNS Server in Ubuntu

# DNS Server Setup using BIND

## Project Description
This project sets up a **DNS (Domain Name System) server** on Linux using **BIND** to handle domain name resolution for a network. It includes:
- Setting up **zone files** (both forward and reverse zone).
- Managing **DNS records** (A, AAAA, CNAME, MX, etc.).

## Prerequisites
- A Linux-based system (We used Ubuntu).
- Basic understanding of networking and DNS concepts.
- **BIND9** installed on your system.

## Installation

### 1. Install BIND9
```bash
sudo apt update
sudo apt install bind9
```
### 2. Add another record for the IP
```bash
sudo vim /etc/hosts/
```
After accessing the vim editor, will edit the second IP adress and add our device IP which will be the address of our DNS Server:
```bash
127.0.0.1 localhost # will remain same it is
127.0.1.1 adib-Latitude-7480.adib.local adib-Latitude-7480 # here i am using my hostname, you must be use yours
10.248.129.72 adib-Latitude-7480.adib.local adib-Latitude-7480 # here i am using my hostname, you must be use yours
```
### 3. Configure *named.conf.options* file
To preserve the original file, we will duplicate the original file and the new name will be *named.conf.options.orig*
```bash
sudo cp named.conf.options named.conf.options.orig
```
Then open vim editor to configure the *named.conf.options* file
```bash
sudo vim named.conf.options
```
Add these few lines of code inside the curly braces and save
```bash
recursion yes;
listen-on {10.248.129.72;};
allow-transfer {none;};
forwarders {
  10.248.129.72; # use your device IP which will be the address of your DNS Server
};
```
### 4. Configure *named.conf.local* file to create *forward lookup zone* and *reverse lookup zone* 
To preserve the original file, we will duplicate the original file and the new name will be *named.conf.local.orig*
```bash
sudo cp named.conf.local named.conf.local.orig
```
Then open editor to configure the *named.conf.local* file
```bash
sudo gedit named.conf.options
```
Add these few lines of code
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
### 5. Create zone files
We will create *forward lookup zone* file. First, we will duplicate *db.local* file and the duplicate files names will be *db.adib.local*
```bash
sudo cp db.local db.adib.local
```
Then open editor to configure the *db.adib.local* file
```bash
sudo gedit db.adib.local
```
Add these few lines of code
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





















