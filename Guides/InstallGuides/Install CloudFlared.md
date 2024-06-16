# Install CloudFlared

```sh
apt update && 

apt upgrade -y && 

apt install sudo curl -y &&

curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb
```