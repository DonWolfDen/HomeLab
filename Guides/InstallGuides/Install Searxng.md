# *A self-hosted, no-tracking search engine that aggregates results from multiple search engines*
https://github.com/searxng
## Install Debian
## Install Docker
## Install Portainer
## Install Searxng

Pull files from git
```sh
cd /etc/docker/
sudo git clone https://github.com/searxng/searxng-docker.git
```
Change default secret
```sh
cd /etc/docker/searxng-docker
sudo sed -i "s|ultrasecretkey|$(openssl rand -hex 32)|g" searxng/settings.yml
```
Fix html method so back button works
```sh
sudo nano searxng/settings.yml
```
Under the server: heading, add this variable
```yml
server:
  method: "GET"
```
## Add more settings to settings.yml

Add a root heading called general:
```yml
general:
  debug: false    # Debug mode for development
  instance_name: "Dongle"    # Displayed name
  contact_url: false    # mailto:contact@example.com
  enable_metrics: true    # record stats
```
Add a root heading called search
```yml
search:
  autocomplete: "google"
  safe_search: 0    # 0: None, 1: Moderate, 2: Strict
```

Create volumes in portainer
- caddy-data
- caddy-config
- valkey-data

## Compose Searxng
Add environment variables
- SEARXNG_HOSTNAME=$localIPaddress
- LETSENCRYPT_EMAIL=$emailToCreateCertificates
