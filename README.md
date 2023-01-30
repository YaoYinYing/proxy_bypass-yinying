# proxy_bypass-yinying

## Overview
A repository that contains a list of domain/IP addresses that will not use a proxy.

## Usage
This repository provides a script to update the IP/domain list and another script to apply the proxy bypassing settings on MacOS.

### Updating the IP/domain List
You can append IP/domain addresses to the `ip` column in the file `data/proxy_bypass-yinying.csv`. Here's how:

1. Source the script `<repo>/scripts/tools_add_ip_macos.sh`.
```shell
source <repo>/scripts/tools_add_ip_macos.sh
```
2. Find the thread name you wish to bypass proxy settings for. You can do this by running the following command:
```shell
lsof -i -n -P
```

3. Append the IP/thread name/datetime to the list. Ensure that the proxy is disabled when doing this.
```shell
AddBypassIP NeteaseMusic
AddBypassIP WeChat
```

### Applying the Proxy Bypassing on MacOS
To apply the proxy bypassing settings on MacOS, run the following command:
```shell
sh <repo>/scripts/apply_bypass_macos.sh
```
