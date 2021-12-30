# zsh_p10k_custom_configuration

The zsh theme I'm currently using, with plugins list.

Will soon be packaged in .dotfile with ansible playbook for automatic install

Using zsh + oh-my-zsh + powerlevel10k

## Credits:

Oh My Zsh: https://ohmyz.sh/

Powerlevel10k theme: https://github.com/romkatv/powerlevel10k

## Theme

![theme_zsh](https://user-images.githubusercontent.com/72258375/147758195-9b8d2bb9-3e30-414f-9e44-e9ec521e737a.gif)

## Install

Install all dependencies (zsh, oh-my-zsh and powerlevel10k) with install script (assumes you have ZSH already installed):

![image](https://user-images.githubusercontent.com/72258375/147749851-6ac4e528-ac6d-42a0-a563-e026f7b8f783.png)

It checks for oh-my-zsh, powerlevel10k, and install them if needed. It saves previous config file in _.old_

## Functionalities

It uses all powerlevel10k features, you can uncomment and use the one you had like

### Plugin options

Located in `.zshrc`, change it at will, [check out more plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)

```
git
zsh-autosuggestions
colored-man-pages
docker
ssh-agent
vi-mode
zsh-syntax-highlighting # Has to be last plugin to load !!
```

### Prompt options

I moved all prompts onto the left, so It wouldnt bother me when I copy and paste on articles.

```
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    time                    # current time
    background_jobs         # presence of background jobs
    dir                     # current directory
    vcs                     # git status
    
    ## ENV
    aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
    aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
    azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
    gcloud                  # google cloud cli account and project (https://cloud.google.com/)
    google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
    anaconda                # conda environment (https://conda.io/)
    pyenv                   # python environment (https://github.com/pyenv/pyenv)
    goenv                   # go environment (https://github.com/syndbg/goenv)
    nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
    nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
    nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
    rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
    rvm                     # ruby version from rvm (https://rvm.io)
    luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
    jenv                    # java version from jenv (https://github.com/jenv/jenv)
    plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
    phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
    scalaenv                # scala version from scalaenv (https://github.com/scalaenv/scalaenv)
    haskell_stack           # haskell version from stack (https://haskellstack.org/)
    kubecontext             # current kubernetes context (https://kubernetes.io/)
    terraform               # terraform workspace (https://www.terraform.io)
    
    ## TOOLS
    toolbox                 # toolbox name (https://github.com/containers/toolbox)
    ranger                  # ranger shell (https://github.com/ranger/ranger)
    nnn                     # nnn shell (https://github.com/jarun/nnn)
    xplr                    # xplr shell (https://github.com/sayanarijit/xplr)
    vim_shell               # vim shell indicator (:sh)
    midnight_commander      # midnight commander shell (https://midnight-commander.org/)
    vi_mode                 # vi mode (you don't need this if you've enabled prompt_char)
    
    ## CONTEXT BEFORE PROMPT
    context                 # user@hostname
    
    ## OPTIONS - UNCOMMENT AND PLACE WHERE YOU DEEM IT BEST
    # prompt_char           # prompt symbol
    # direnv                # direnv status (https://direnv.net/)
    # asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
    # virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    # os_icon               # os identifier
    # node_version          # node.js version
    # go_version            # go version (https://golang.org)
    # rust_version          # rustc version (https://www.rust-lang.org)
    # dotnet_version        # .NET version (https://dotnet.microsoft.com)
    # php_version           # php version (https://www.php.net/)
    # laravel_version       # laravel php framework version (https://laravel.com/)
    # java_version          # java version (https://www.java.com/)
    # package               # name@version from package.json (https://docs.npmjs.com/files/package.json)
    # fvm                     # flutter version management (https://github.com/leoafarias/fvm)
    # terraform_version     # terraform version (https://www.terraform.io)
    # nordvpn               # nordvpn connection status, linux only (https://nordvpn.com/)
    # nix_shell             # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
    # vpn_ip                # virtual private network indicator
    # load                  # CPU load
    # disk_usage            # disk usage
    # ram                   # free RAM
    # swap                  # used swap
    # todo                  # todo items (https://github.com/todotxt/todo.txt-cli)
    # timewarrior           # timewarrior tracking status (https://timewarrior.net/)
    # taskwarrior           # taskwarrior task count (https://taskwarrior.org/)
    # ip                    # ip address and bandwidth usage for a specified network interface
    # public_ip             # public IP address
    # proxy                 # system-wide http/https/ftp proxy
    # battery               # internal battery
    # wifi                  # wifi speed
    # example               # example user-defined segment (see prompt_example function below)
```

## Color palette

Included is a color palette script, be sure your $TERM is in 256-color

![image](https://user-images.githubusercontent.com/72258375/147749414-d95b96fb-988a-497f-9241-1688b4797166.png)


