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
#### Ubuntu:
```bash
sudo apt update
sudo apt install bind9

