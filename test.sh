#!/bin/bash

# Define variables
DNS_SERVER_IP="10.248.129.72" 
DOMAIN="adib.local"
REVERSE_IP_ARPA="129.248.10.in-addr.arpa"
REVERSE_IP="129.248.10"

# Function to check service status
echo "Checking BIND9 service status..."
systemctl is-active --quiet bind9 && echo "✅ BIND9 is running" || echo "❌ BIND9 is not running"

# Check for syntax errors in BIND configuration
echo "Checking named.conf syntax..."
named-checkconf && echo "✅ named.conf syntax is correct" || echo "❌ named.conf has syntax errors"

# Check forward zone file
echo "Checking forward lookup zone file syntax..."
named-checkzone "$DOMAIN" /etc/bind/db.$DOMAIN && echo "✅ Forward lookup zone file is correct" || echo "❌ Forward lookup zone file has errors"

# Check reverse zone file
echo "Checking reverse lookup zone file syntax..."
named-checkzone "$REVERSE_IP_ARPA" /etc/bind/db.$REVERSE_IP && echo "✅ Reverse lookup zone file is correct" || echo "❌ Reverse lookup zone file has errors"

# Test forward DNS resolution
echo "Testing forward lookup for www.$DOMAIN..."
nslookup www.$DOMAIN $DNS_SERVER_IP || echo "❌ Forward lookup failed"

# Test reverse DNS resolution
echo "Testing reverse lookup for $DNS_SERVER_IP..."
nslookup $DNS_SERVER_IP $DNS_SERVER_IP || echo "❌ Reverse lookup failed"

# Display resolver configuration
echo "Checking current nameserver settings..."
cat /etc/resolv.conf | grep nameserver

echo "✅ DNS Testing Completed."

