#!/bin/bash
set -euo pipefail

# Check output filename
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <output-file>"
    exit 1
fi

OUTPUT_FILE="$1"

# 1. Database: allow local application access
ufw allow in on lo from 127.0.0.1 to any port 3306 proto tcp
ufw reject 3306/tcp

# 2. Admin panel: allow trusted IP, reject others
ufw insert 1 allow from 192.168.32.55 to any port 3005
ufw reject 3005

# 3. Management panel: allow via eth0
ufw allow in on eth0 to any port 8099

# 4. Rate-limit new connections on ports 6050-6055
ufw limit 6050:6055/tcp

# 5. Export UFW rules
ufw status > "$OUTPUT_FILE"

