#!/bin/bash
set -e

OUTPUT_FILE="${1:-ufw-config.txt}"

sudo ufw --force reset

# Limit connections to ports 6050-6055
sudo ufw limit 6050:6055/tcp

# Allow management panel on eth0
sudo ufw allow in on eth0 to any port 8099

# Reject access to admin panel
sudo ufw reject 3005

# Enable firewall
sudo ufw --force enable

# Save configuration
sudo ufw status > "$OUTPUT_FILE"
