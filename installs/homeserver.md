sudo apt update
sudo apt upgrade -y

# https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# docker
brew install docker-compose

# for *.local address
sudo apt install avahi-daemon

