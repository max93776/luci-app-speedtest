# luci-app-speedtest
This repo contains a speedtest app for the OpenMPTCProuter LuCI:
- download/upload iperf3 speedtest via web-ui
- entry in `acl.d` for access control
- entry in `menu.d` for web-ui menu
## Installation
- After cloning in OpenMPTCProuter as root:
	```bash
	cd luci-app-speedtest
	cp luasrc/view/speedtest.htm /usr/lib/lua/luci/view/
	cp luasrc/controller/speedtest.lua /usr/lib/lua/luci/controller
	cp root/usr/share/luci/menu.d/luci-app-speedtest.json /usr/share/luci/menu.d
	cp root/usr/share/rpcd/acl.d/luci-app-speedtest.json /usr/share/rpcd/acl.d
	reboot
	```
- Make sure to edit line 23 in `speedtest.lua` (speedtest server IP!) for example:
	```lua
	...
	cmd = "iperf3 -c a209.speedtest.wobcom.de" -- insert your server here
	...
	```
- List of public iperf3 servers can be found [here](https://iperf3serverlist.net/)
## Usage
- select number of parallel connections
- select download or upload
- press button
![image](https://github.com/user-attachments/assets/0f7559ac-c031-4cb1-82df-67681729da9c)
