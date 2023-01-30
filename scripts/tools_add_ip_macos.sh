# Read the absolute path of the run directory
run_dir="$(readlink -f $(dirname $0))"

# Function to add an IP to the bypass list
AddBypassIP(){
	# Get the thread name as the first argument
	local thread_name=$1
	# Get the first 9 characters of the thread name
	local _tn=$(echo $thread_name | cut -b 1-9 )

	# Use lsof to list open files and their IP addresses, then filter for the relevant thread name and TCP connections
	lsof -i -n -P | grep $_tn | grep TCP | awk '
		# In the AWK script
		BEGIN{
			# Get the current date and time and store it in the "now" variable
			cmd = "date +%Y-%m-%d_%H%M%S";
			cmd | getline now;
			close(cmd)
		}
		# For each filtered line
		{
			# Split the line to get the destination IP and port, and extract the IP
			idx=split($9,arr_ip_port,"->");
			ip_port_dst=arr_ip_port[idx];
			split(ip_port_dst,arr_ip,":");
			ip_dst=arr_ip[1];
			# Print the destination IP, the thread name, and the current date and time to the CSV file
			printf "\n%s,'"$thread_name"',%s", ip_dst,now
		}' >> $run_dir/../data/proxy_bypass-yinying.csv
	}

