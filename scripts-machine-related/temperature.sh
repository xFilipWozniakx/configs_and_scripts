#!/usr/bin/bash
# skrypt monitorujacy temperatury
# /usr/bin/sensors

if [ -f /var/log/temperature.json ]; then
       echo ''
else
       echo 'create temperature.json'
       touch /var/log/temperature.json
fi

while true; do
	TIME_STAMP=$(date "+%m-%d %H:%M:%S")
	CPU=$(sensors | awk '/Package id 0/ {print $4}') 
	BIOS=$(sensors | awk '/acpitz-acpi-0/ {f=1} f && /temp1:/ {print $2; f=0}')
	SSD=$(sensors | awk '/Composite:/ {print $2}')
	PCH=$(sensors | awk '/pch_cannonlake-virtual-0/ {f=1} f && /temp1:/ {print $2; f=0}')
	
	echo "{\"TIME\":\"$TIME_STAMP\",\"CPU\":\"$CPU\",\"SSD\":\"$SSD\",\"BIOS\":\"$BIOS\",\"CHIP\":\"$PCH\"}" >> /var/log/temperature.json
	sleep 1
done 


