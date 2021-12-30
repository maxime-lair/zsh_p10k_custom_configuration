#!/bin/sh

echo "Testing zsh.."
command -v zsh > /dev/null 2>&1 || { echo >&2 "I require zsh, aborting."; exit 1;}
echo "zsh installed"

echo "Testing git.."
command -v git > /dev/null 2>&1 || { echo >&2 "I require git to install dependency, aborting."; exit 1;}

SCRIPT_DIR="$(dirname $(readlink -f "$0"))"

echo "Testing oh-my-zsh"
[ -f $HOME/.oh-my-zsh/oh-my-zsh.sh ] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "oh-my-zsh installed"

echo "Testing powerlevel10k installation"
if [ ! -f $HOME/.p10k.zsh ]; then
	if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	fi
fi
		
echo "Powerlevel10k installed"

# Not needed since we package our own .zshrc
#grep -v "^ZSH_THEME" $HOME/.zshrc > /tmp/temp.zshrc && mv /tmp/temp.zshrc $HOME/.zshrc
#echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' > ~/.zshrc

echo "Copying powerlevel10k configuration file from $SCRIPT_DIR to $HOME"
[ -f $HOME/.p10k.zsh ] && cp $HOME/.p10k.zsh $HOME/.p10k.zsh.old
cp $SCRIPT_DIR/.p10k.zsh $HOME/.p10k.zsh
echo "Copied powerlevel10k theme."

echo "Copying .zshrc from $SCRIPT_DIR to $HOME"
[ -f $HOME/.zshrc ] && cp $HOME/.zshrc $HOME/.zshrc.old || echo "Creating new .zshrc"
cp $SCRIPT_DIR/.zshrc $HOME/.zshrc
echo "zshrc copy ok"

# Install plugins
[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 

[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Starting zsh in 2 seconds.."
echo "zsh will be set as default shell"
sleep 2
chsh -s $(which zsh)
zsh

