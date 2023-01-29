#!/bin/sh

# make it stop if error occurs
set -e 

batch_size=10

run_dir="$(readlink -f $(dirname $0))"

echo "$run_dir"

# Get the active network interface
active_interface=$(route -n get default | grep interface | awk '{print $2}')
echo "Active interface device: $active_interface"

# Get the list of all hardware ports and get the active network interface device ID
active_interface_name=$(networksetup -listallhardwareports | sed -n '1!G;h;$p' |awk '{ret = match($0, "Device: '$active_interface'");if(ret>0){getline;print $3}}')
echo "$active_interface_name is in use."

# Read the IP addresses or domains from the 'bypass.csv' file
IFS=','
bypass_list=""

echo "Open CSV file: $(readlink -f $run_dir/../data/proxy_bypass-yinying.csv)"
while read -r ip note
do
    # skip the header
    if [[ "$ip" == ip ]];then continue;fi

    echo "Gather $ip to $active_interface_name because of $note"
    bypass_list="$bypass_list $ip"

done < $run_dir/../data/proxy_bypass-yinying.csv

echo "Bypassing proxy for $bypass_list"
echo networksetup -setproxybypassdomains "$active_interface_name" "$bypass_list"
networksetup -setproxybypassdomains "$active_interface_name" "$bypass_list"


echo "Proxy bypass settings updated"