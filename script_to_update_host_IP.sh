#!/bin/bash

local_computer=0 
mac_address_of_the_goserver="24:ee:9a:d9:e9:91"

local_mac_addresses=`ifconfig|grep "ether"|awk '{print $2}'`

for mac_address in $local_mac_addresses; do
	if [[ "$mac_address" == "$mac_address_of_the_goserver" ]]; then
		local_computer=1
	fi
done

arp=`sudo /usr/bin/find /usr -name arp-scan`
if [[ "$arp" == "" ]]; then
        /usr/local/bin/brew install arp-scan
fi

if [[ "$local_computer" == "0" ]]; then
	ip=`sudo /usr/local/bin/arp-scan --interface=en0 --localnet|grep "$mac_address_of_the_goserver" |awk '{print $1}'`
else
	ip="127.0.0.1"
fi

add_and_remove_from_file() {
	line_number_in_hosts_file_to_be_removed=`grep -n "$1" /etc/hosts | awk -F ":" '{print $1}'`
	updated_hosts_file_contents=`cat /etc/hosts|awk -v line="$line_number_in_hosts_file_to_be_removed" '{if(NR!=line) print $0}'`
	content_to_be_appended_to_etc_hosts_file="$ip\t$1"

	echo -e "$updated_hosts_file_contents" | cat>temp_hosts
	echo -e "$content_to_be_appended_to_etc_hosts_file" | cat>>temp_hosts
	sudo mv temp_hosts /etc/hosts
	rm -rf temp_hosts
}



if [[ "$ip" != "" ]]; then
	add_and_remove_from_file "dell"
fi