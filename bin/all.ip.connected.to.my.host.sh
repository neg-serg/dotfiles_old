netstat -lantp | grep ESTABLISHED |awk '{print }' | awk -F: '{print }' | sort -u
