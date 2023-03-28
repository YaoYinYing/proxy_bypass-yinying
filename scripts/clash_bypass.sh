#!/bin/sh

# make it stop if error occurs
set -e 


run_dir="$(readlink -f $(dirname $0))"

# Read the IP addresses or domains from the 'bypass.csv' file
IFS=','
bypass_list=""

while read -r ip note
do
    # skip the header
    if [[ "$ip" == ip ]]; then 
        echo 'bypass:';
    # 10.*
    elif [[ "$ip" =~ "^[[:digit:]]{1,3}.\*" ]]; then 
        echo "  - ${ip%\.*}.0.0.0/8"
    # 10.20.*
    elif [[ "$ip" =~ "^[[:digit:]]{1,3}.[[:digit:]]{1,3}.\*" ]]; then 
        echo "  - ${ip%\.*}.0.0/16"
    # 10.20.30.*
    elif [[ "$ip" =~ "^[[:digit:]]{1,3}.[[:digit:]]{1,3}.[[:digit:]]{1,3}.\*" ]]; then 
        echo "  - ${ip%\.*}.0/24"
    # 10.20.30.40
    elif [[ "$ip" =~ "^[[:digit:]]{1,3}.[[:digit:]]{1,3}.[[:digit:]]{1,3}.[[:digit:]]{1,3}" ]];then
        echo "  - $ip"
    # *.edu.cn
    elif [[ "$ip" =~ "^\*" ]];then 
        echo "  - \"$ip\""
    # full.address.link
    else
        echo "  - $ip"
    fi

done < $run_dir/../data/proxy_bypass-yinying.csv



