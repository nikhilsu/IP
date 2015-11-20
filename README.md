# Resolves the IP of a node on the network given its MacAddress
##Make sure to run the script using SUDO
  - take a backup of your /etc/hosts : sudo cp /etc/hosts ~/hosts.backup 
  - sudo ./script_to_update_host_IP.sh

The script is configured to run as Daemon. Polls for the IP every 5 hours.
