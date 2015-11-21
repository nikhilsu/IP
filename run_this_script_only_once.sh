sudo cp script_to_update_host_IP.sh /usr/local/bin/script_to_update_host_IP.sh

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>Label</key>
	    <string>com.tw.changingIP</string>

    <key>ThrottleInterval</key>
    	<integer>18000</integer>
    
    <key>ProgramArguments</key>
        <array>
                <string>/usr/local/bin/script_to_update_host_IP.sh</string>
        </array>
    
    <key>StartInterval</key>
    	<integer>18000</integer>

    <key>KeepAlive</key>
    	<true/>
</dict>
</plist>
" |cat>script_to_update_host_IP.plist

chmod +x script_to_update_host_IP.plist
sudo chown root:wheel script_to_update_host_IP.plist
sudo mv script_to_update_host_IP.plist /Library/LaunchDaemons/

sudo launchctl load /Library/LaunchDaemons/script_to_update_host_IP.plist