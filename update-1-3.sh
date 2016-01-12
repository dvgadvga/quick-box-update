#!/bin/bash
#
# [Quick Box Update Script]
#
# GitHub:   https://github.com/JMSDOnline/quick-box
# Author:   Jason Matthews
# URL:      https://jmsolodesigns.com/code-projects/quick-box/seedbox-installer
#
# 

# Download the needed scripts for Quick Box
curl -LO https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/v1-3/quickbox-update-v1-3.sh

# Convert all shell scripts to executable
chmod +x *.sh

# Start the Install
./quickbox-update-v1-3.sh
