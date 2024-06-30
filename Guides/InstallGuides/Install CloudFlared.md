# *A zero trust network access tunnel to securely expose services to the internet*
https://github.com/cloudflare/cloudflared
## Install Debian
## Install CloudFlared
Install prerequisites: curl
```sh
sudo apt update && 
sudo apt upgrade -y && 
sudo apt install curl -y
```
Go to Cloudflare.com > Zero Trust > Networks > Tunnels > Create a Tunnel > Select Debian Install > Copy install code
```sh
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install #unique-tunnel-key
```
Under the tunnel on Cloudflare.com > Public Hostname tab > add a public hostname

Set domain (Must purchase a public domain name from Cloudflare) and an optional subdomain

Set http(s) and the ip address and port of your web service

If using https with self signed certificate (browser privacy warning), go to Additional application settings > TLS > check 'No TLS Verify'
