# Resolves the IP of a node on the network given its MacAddress
##Make sure to run the scripts using SUDO. Steps to be followed :-
  - take a backup of your /etc/hosts : sudo cp /etc/hosts ~/hosts.backup 
  - sudo ./run_this_script_only_once.sh
  - sudo ./script_to_update_host_IP.sh

The script is configured to run as Daemon. Polls for the IP every 5 hours.
