#!/bin/sh

echo "Beginning OSX Configuration ..."
echo -e "\e[1;34mBeginning OSX Configuration ...\e[0m"
echo -e "\e[1;34m   -> Initial setup ...\e[0m"
#
# Correct /usr/local ownership
#
sudo chown -R $(whoami) /usr/local

#
# Update .bash_profile with aliases, environment variables
#
cat << 'EOF' >> ~/.bash_profile
alias nuget="mono --runtime=v4.0.30319 /usr/local/bin/nuget.exe"
alias ll="ls -lh"
alias la="ls -la"
alias lt="ls- latr"

export CPATH="$CPATH:/usr/local/opt/readline/include"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/readline/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/opt/readline/lib"

export CPATH="$CPATH:/usr/local/opt/openssl/include"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/opt/openssl/lib"
export PATH="/usr/local/opt/openssl/bin:$PATH"

export CPATH="$CPATH:/usr/local/opt/icu4c/include"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/icu4c/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/opt/icu4c/lib"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
EOF

echo -e "\e[1;34m   -> Installing Xcode command line tools ...\e[0m"
#
# Install Xcode command line tools
#
xcode-select --install

echo -e "\e[1;34m   -> Installing Homebrew ...\e[0m"
#
# Homebrew
#
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#
# Install Cask
#
brew install caskroom/cask/brew-cask

echo -e "\e[1;34m   -> Installing openSSL ...\e[0m"
#
# Install openssl
#
brew install openssl


#
# Brew packages that I use alot.
#
echo -e "\e[1;34m   -> Installing git ...\e[0m"
brew install git
echo -e "\e[1;34m   -> Updating bash ...\e[0m"
brew install bash
echo -e "\e[1;34m   -> Installing wget ...\e[0m"
brew install wget
echo -e "\e[1;34m   -> Installing node ...\e[0m"
brew install node
echo -e "\e[1;34m   -> Installing jq ...\e[0m"
brew install jq

#
# Some cask packages that I like.
#
echo -e "\e[1;34m   -> Installing Chrome ...\e[0m"
brew cask install google-chrome
echo -e "\e[1;34m   -> Installing gimp ...\e[0m"
brew cask install gimp
echo -e "\e[1;34m   -> Installing iterm2 ...\e[0m"
brew cask install iterm2
echo -e "\e[1;34m   -> Installing slack ...\e[0m"
brew cask install slack
echo -e "\e[1;34m   -> Installing xquartz ...\e[0m"
brew cask install xquartz
open /usr/local/Caskroom/xquartz/2.7.11/XQuartz.pkg
echo -e "\e[1;34m   -> Installing ffmpeg ...\e[0m"
brew install ffmpeg
echo -e "\e[1;34m   -> Installing imagemagic ...\e[0m"
brew install imagemagic
echo -e "\e[1;34m   -> Installing gifsicle ...\e[0m"
brew install gifsicle
echo -e "\e[1;34m   -> Installing pkg-config ...\e[0m"
brew install pkg-config
echo -e "\e[1;34m   -> Installing screengif ...\e[0m"
brew install screengif
echo -e "\e[1;34m   -> Installing gs ...\e[0m"
brew install ghostscript
cd /usr/local/share/ghostscript/
wget "https://superb-sea2.dl.sourceforge.net/project/gs-fonts/gs-fonts/8.11%20%28base%2035%2C%20GPL%29/ghostscript-fonts-std-8.11.tar.gz"
tar xzvf ghostscript-fonts-std-8.11.tar.gz

echo -e "\e[1;34m   -> Installing virtualbox ...\e[0m"
brew cask install virtualbox

#
# Brew install dotnet pre-reqs
#
echo -e "\e[1;34m   -> Installing dotnet pre-reqs ...\e[0m"
mkdir -p /usr/local/lib
ln -s /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/
ln -s /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/

#
# Install dotnet SDK 1.0.1
#
echo -e "\e[1;34m   -> Installing dotnet ...\e[0m"
wget https://download.microsoft.com/download/F/D/5/FD52A2F7-65B6-4912-AEDD-4015DF6D8D22/dotnet-dev-osx-x64.1.0.1.tar.gz
#
# Install dotnet core 1.1.1
#
wget https://download.microsoft.com/download/9/5/6/9568826C-E3F6-44A7-9F75-DD8E6AB29543/dotnet-osx-x64.1.1.1.tar.gz

sudo mkdir -p /opt/dotnet/core /opt/dotnet/sdk
sudo tar zxf dotnet-dev-osx-x64.1.0.1.tar.gz -C /opt/dotnet/sdk
sudo tar zxf dotnet-osx-x64.1.1.1.tar.gz -C /opt/dotnet/core
sudo ln -s /opt/dotnet/core/dotnet /usr/local/bin

echo -e "\e[1;34m   -> Installing NuGet ...\e[0m"
wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
sudo mv nuget.exe /opt/dotnet
sudo ln -s /opt/dotnet/nuget.exe /usr/local/bin

#
# Install Mono
#
echo -e "\e[1;34m   -> Installing Mono ...\e[0m"
brew install mono
mozroots --import --sync

#
# Install Xamarin Studio
#
echo -e "\e[1;34m   -> Installing Xamarin Studio ...\e[0m"
brew cask install xamarin-studio

#
# Brew prune and cleanup
#
echo -e "\e[1;34m   -> Performing post-install cleanup ...\e[0m"
brew prune
brew cask cleanup

echo -e "\e[1;34mInstallation Complete!\e[0m"
echo ""
