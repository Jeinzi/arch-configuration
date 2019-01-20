# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/jeinzi/.oh-my-zsh

# Text editor
export EDITOR=/usr/bin/nano
export VISUAL=/usr/bin/nano

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval $(thefuck --alias)
alias update='yaourt -Syu --aur --noconfirm'
alias suspend='systemctl suspend'
alias up='cd ..'
alias bootwin='zsh ~/.config/bootwin.sh'
alias pdf='qpdfview'

# Copy stdin to the clipboard.
alias c='tr -d "\n" | xsel -ib'

# Print battery status.
alias b='acpi -b'

# Create a directory and cd into it.
mkdirc () { mkdir "$@" && cd "$@[-1]" }

# Copy an optical disc via dd.
copy-optical () {
    if [ -z "$1" ]; then
        echo "Output filename missing."
        return 1
    fi
    if [ -f $1 ]; then
        echo "File already exists."
        return 1
    fi
    isosize -x /dev/sr0 | sed -n -E "s/sector count: ([0-9]*), sector size: ([0-9]*)/dd if=\/dev\/sr0 of=\"$1\" bs=\2 count=\1 status=progress/p" | bash -
}

# Print the duration of a media file using ffprobe.
dur () {
    if [ -z "$1" ]; then
        echo "Filename missing."
        return 1
    fi
    if [ ! -f $1 ]; then
        echo "File does not exist."
        return 1
    fi
    ffprobe "$1" 2>&1 >/dev/null | grep -oP "Duration: .*?," | tr -d ","
}
