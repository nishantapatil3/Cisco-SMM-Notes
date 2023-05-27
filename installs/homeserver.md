#### Basics
```
sudo apt update
sudo apt upgrade -y
```

#### Install Brew
https://brew.sh
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### docker
```
brew install docker-compose
```

#### for *.local address
```
sudo apt install avahi-daemon
```

#### Immich
```
alias immich='docker run -it --rm -v "$(pwd):/import" ghcr.io/immich-app/immich-cli:latest'
immich upload --key cencqAYjYUsDDbbFQljw3a6FZHxjgyLFhN9KMgZu0 --server http://homeserver.local:2283/api --recursive .
```
