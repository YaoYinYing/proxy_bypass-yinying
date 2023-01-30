# proxy_bypass-yinying
A list of domain/IP that will not use proxy.


## Usage

### Update IP/domain list
Append ip/address to the `ip` column `data/proxy_bypass-yinying.csv`.
```shell
# function that will be used.
source <repo>/scripts/tools_add_ip_macos.sh

# find the thread name you wish to bypass proxy settings.
lsof -i -n -P

# append ip/thread name/datetime to the list. the proxy must be disabled.
AddBypassIP NeteaseMusic
AddBypassIP WeChat

```

### Apply the proxy bypassing


#### MacOS
```shell
sh <repo>/scripts/apply_bypass_macos.sh

```
