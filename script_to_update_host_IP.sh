#!/bin/bash

local_computer=0 
mac_address_of_the_goserver="a0:99:9b:0d:96:1d"

local_mac_addresses=`ifconfig|grep "ether"|awk '{print $2}'`

for mac_address in local_mac_addresses; do
	if [[ "$mac_address" == "$mac_address_of_the_goserver" ]]; then
		local_computer=1
	fi
done

if [[ "$local_computer" == "0" ]]; then
	arp=`which arp-scan`

	if [[ "$arp" == "" ]]; then
		os=`uname -v|grep "^Darwin"`
		if [[ "$os" == "" ]]; then
			sudo apt-get install -y arp-scan
		else
			brew install arp-scan
		fi
	fi

	ip=`sudo arp-scan --interface=en0 --localnet|grep "$mac_address_of_the_goserver" |awk '{print $1}'`

	content_to_be_appended_to_etc_hosts_file="$ip\tgoserver.com"

else
	content_to_be_appended_to_etc_hosts_file="127.0.0.1\tgoserver.com"

fi

line_number_in_hosts=`grep -n "goserver.com" /etc/hosts | awk -F ":" '{print $1}'`
 
updated_contents=`cat /etc/hosts|awk -v line="$line_number_in_hosts" '{if(NR!=line) print $0}'`

echo -e "$updated_contents" | cat>temp_hosts
echo -e "$content_to_be_appended_to_etc_hosts_file" | cat>>temp_hosts
sudo mv temp_hosts /etc/hosts
rm -rf temp_hosts
# cat temp_hosts