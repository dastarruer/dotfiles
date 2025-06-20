Install spotify: 
```bash
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpgecho "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.listsudo apt-get update && sudo apt-get install spotify-client
```

Install spicetify
https://spicetify.app/docs/advanced-usage/installation/

Get started
https://spicetify.app/docs/getting-started/

Spicetify cli
https://spicetify.app/docs/advanced-usage/command-line-interface

Install catppuccin through the marketplace