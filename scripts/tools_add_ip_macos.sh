
run_dir="$(readlink -f $(dirname $0))"

AddBypassIP(){
	local thread_name=$1
	local _tn=$(echo $thread_name | cut -b 1-9 )

	lsof -i -n -P | grep $_tn | grep TCP | awk '
		BEGIN{
				cmd = "date +%Y-%m-%d_%H%M%S";
				cmd | getline now;
				close(cmd)
			}
			{
				idx=split($9,arr_ip_port,"->");
				ip_port_dst=arr_ip_port[idx];
				split(ip_port_dst,arr_ip,":");
				ip_dst=arr_ip[1];
				printf "\n%s,'"$thread_name"',%s", ip_dst,now
			}' >> $run_dir/../data/proxy_bypass-yinying.csv

}
