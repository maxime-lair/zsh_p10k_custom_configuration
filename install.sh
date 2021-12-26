#!/usr/bin/env bash

# Credit for script template: https://betterdev.blog/minimal-safe-bash-script-template/

# Variable needed for URL/THEME
OZSH_URL="https://raw.github.com/ohmyzsh/"
OZSH_FULL="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
PLUGIN_LIST="git zsh-autosuggestions zsh-syntax-highlighting zsh-completions docker"

# Set debug mode in case of script failure for full trace
set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

# Get current working directory
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-global]
This script will install ozsh for your user with powerlevel10k custom theme.
You can install it for all users (existing and future) by using the global parameter

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-g, --global    Install 
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
  msg "Script is done, quitting."
}

setup_colors() {
  if [[ -t 2 ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  global=0

  while :; do
    case "${1-}" in
    -h | --help) 
        usage
        ;;
    -v | --verbose) 
        set -x
        shift
        ;;
    -g | --global) 
        global=1
        shift
        ;;
    -?*) 
        die "Unknown option: $1"
        ;;
    *) 
        break 
        ;;
    esac
  done

  return 0
}

check_zsh() {
    msg "${YELLOW} Checking dependency for zsh shell ${NOFORMAT}"
    if command -v zsh &> /dev/null; then
        msg "${GREEN} zsh is installed, continuing.. ${NOFORMAT}"
    else
        msg "${RED} zsh is NOT installed ${NOFORMAT}"
        msg "Please install it through your package manager, for example:"
        msg "sudo apt install zsh"
        die "Missing dependency (zsh)"
    fi
}

check_curl_wget() {
    msg "${YELLOW} Checking dependency, we need either wget or curl and internet access to install ozsh ${NOFORMAT}"
    dependency=''
    msg "${YELLOW} Testing curl access..${NOFORMAT}"
    if command -v curl &> /dev/null; then
        msg "${GREEN} Curl is installed${NOFORMAT}"
        dependency='curl'
    else
        msg "${ORANGE} Curl failed, testing wget.. ${NOFORMAT}"
        if command -v wget &> /dev/null; then
            msg "${GREEN} wget installed, we can continue the installation ${NOFORMAT}"
            dependency='wget'
        else
            msg "${RED} wget is not installed, unable to proceed further ${NOFORMAT}"
            msg "${RED} Please install either curl or wget to continue ${NOFORMAT}"
            die "Missing dependency (curl or wget)"
        fi
    fi

    msg "${YELLOW} Testing web access to download ozsh install script ${NOFORMAT}"
    if ( [[ "${dependency}" = "curl" ]] && curl -sL --fail ${OZSH_URL} -o /dev/null; ) || ( [[ "${dependency}" = "wget" ]] && wget --spider --server-response ${OZSH_URL} 2>&1 | grep -c '200\ OK' -eq 1 ); then
        msg "${PURPLE} Web access is up, continuing the installation. ${NOFORMAT}"
    else
        msg "${RED} No web access to ${OZSH_URL}, check your connectivity ${NOFORMAT}"
        die "Missing web access"
    fi
}

global_install() {

    msg "${BLUE}You selected a global installation, buckle up..${NOFORMAT}"
    msg "This installation will install oh-my-zsh in /usr/share directory so It can be accessed system-wide."
    msg "This shell will be applied to ALL users (whether existing or future)."
    msg "User cache will be created under each user's home."
    msg "You can modify the theme by accessing it in /usr/share"


    


}

local_install() {

    msg "${BLUE} Default installation on local user $(whoami) ${NOFORMAT}"

    mkdir -p "$HOME"/.fonts

    if [[ ${dependency} = "curl" ]]; then
        msg "Starting installation with curl.."
        sh -c "$(curl -fsSL ${OZSH_FULL})"

        # Install fonts
        cd "$HOME"/.fonts 
        curl -O -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
        curl -O -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
        curl -O -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
        curl -O -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
        cd -

    else
        msg "Starting installation with wget.."
        sh -c "$(wget ${OZSH_FULL} -O -)"

        # Install fonts
        wget -q --show-progress -N https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P "$HOME"/.fonts/
        wget -q --show-progress -N https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P "$HOME"/.fonts/
        wget -q --show-progress -N https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P "$HOME"/.fonts/
        wget -q --show-progress -N https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P "$HOME"/.fonts/

    fi

    msg "${CYAN} Installing fonts ${NOFORMAT}"
    fc-cache -fv "$HOME"/.fonts

    # Add plugins
    sed -i "s#^plugins=.*#plugins=(${PLUGIN_LIST})#" "$HOME"/.zshrc

    msg "${BLUE} Ozsh installation complete, changing your default shell.. ${NOFORMAT}"
    chsh -s "$(which zsh)"
    zsh

    # Installing powerlevel10k theme

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
    sed -i 's#^ZSH_THEME.*#ZSH_THEME="powerlevel10k/powerlevel10k"#' "$HOME"/.zshrc
    
    cd "${script_dir}"
    mv .p10k.zsh "$HOME"/.p10k.zsh

    ## reload
    zsh
    
    msg "${GREEN} Installation complete !${NOFORMAT}"

}

parse_params "$@"
setup_colors

# Received all needed informations

msg "${RED}Read parameters:${NOFORMAT}"
msg "- global: ${global}"

# Check dependency: zsh
check_zsh

# Check dependency: curl or wget
check_curl_wget

# Check if global or local installation
## Global requires sudo right
if [[ ${global} -eq 1 ]]; then
    global_install
else
    local_install
fi

cleanup


