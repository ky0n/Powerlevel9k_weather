# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hendrik/.oh-my-zsh"
export ZSH_CUSTOM="/usr/share/zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="zsh-theme-powerlevel9k/powerlevel9k"

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_DISABLE_PROMPT=false

# Powerlevel9k colors: https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_CUSTOM_ARCH_ICON="echo \"\uF312 \""
POWERLEVEL9K_CUSTOM_ARCH_ICON_BACKGROUND=233
POWERLEVEL9K_CUSTOM_ARCH_ICON_FOREGROUND=041

POWERLEVEL9K_STATUS_OK_BACKGROUND=grey19

POWERLEVEL9K_TIME_BACKGROUND=041
POWERLEVEL9K_TIME_FOREGROUND=black

POWERLEVEL9K_IP_BACKGROUND=027

POWERLEVEL9K_BATTERY_BACKGROUND=
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND=220
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND=047
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=165
POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
POWERLEVEL9K_BATTERY_LOW_FOREGROUND=124
POWERLEVEL9K_BATTERY_VERBOSE=false

#zsh_wifi_signal(){
#    local signal=$(nmcli device wifi | grep '*' | awk '{print $7}')
#    local color='%F{yellow}'
#    [[ $signal -gt 75 ]] && color='%F{green}'
#    [[ $signal -lt 50 ]] && color='%F{red}'
#    echo -n "%{$color%}\uf230  $signal%{%f%}" # \uf230 is 
#    echo "索$signal"
#}
# POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"

zsh_weather(){
    tmpdir=/tmp/powerlevel_weather
    if [ -d "$tmpdir" ]; then
        local old_time=$(cat $tmpdir/time)  
        if [ $(expr $old_time - $(date +%s)) -gt 300 ]; then
            #für Darmstadt
            #local lat=49.87
            #local lng=8.64
            #local woeid=$(curl --silent https://www.metaweather.com/api/location/search/\?lattlong=$lat,$lng | jq '.[0].woeid')
            local woeid=650272
            local weather=$(curl --silent https://www.metaweather.com/api/location/$woeid/ | jq '.consolidated_weather | .[0]')
            local temp=$(echo $weather | jq '.the_temp' | awk '{print substr($0, 0, 4)}')
            local weather_abbr=$(echo $weather | jq '.weather_state_abbr')
            #echo $weather_time
            case $weather_abbr in
                "\"sn\"")
                    symbol="\uFA97";;
                "\"sl\"")
                    symbol="\uE317";;
                "\"h\"")
                    symbol="\uFA91";;
                "\"t\"")
                    symbol="\uE31C";;
                "\"hr\"")
                    symbol="\uE318";;
                "\"lr\"")
                    symbol="\uE319";;
                "\"s\"")
                    symbol="\uE309";;
                "\"hc\"")
                    symbol="\uE312";;
                "\"lc\"")
                    symbol="\uE30C";;
                "\"c\"")
                    symbol="\uE30D";;
            esac
            local powerlevel_weather="$symbol  \u23A2$temp\E339 \uF2C8"
            echo $powerlevel_weather > $tmpdir/weather
            echo $(date +%s) > $tmpdir/time
        else
            local powerlevel_weather=$(cat $tmpdir/weather)
        fi
    else
        #local tmpdir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")
        mkdir $tmpdir
        #für Darmstadt
        #local lat=49.87
        #local lng=8.64
        #local woeid=$(curl --silent https://www.metaweather.com/api/location/search/\?lattlong=$lat,$lng | jq '.[0].woeid')
        local woeid=650272
        local weather=$(curl --silent https://www.metaweather.com/api/location/$woeid/ | jq '.consolidated_weather | .[0]')
        local temp=$(echo $weather | jq '.the_temp' | awk '{print substr($0, 0, 4)}')
        local weather_abbr=$(echo $weather | jq '.weather_state_abbr')
        #echo $weather_time
        case $weather_abbr in
            "\"sn\"")
                symbol="\uFA97";;
            "\"sl\"")
                symbol="\uE317";;
            "\"h\"")
                symbol="\uFA91";;
            "\"t\"")
                symbol="\uE31C";;
            "\"hr\"")
                symbol="\uE318";;
            "\"lr\"")
                symbol="\uE319";;
            "\"s\"")
                symbol="\uE309";;
            "\"hc\"")
                symbol="\uE312";;
            "\"lc\"")
                symbol="\uE30C";;
            "\"c\"")
                symbol="\uE30D";;
        esac
        local powerlevel_weather="$symbol  \u23A2$temp\uE339 \uF2C8"
        echo $powerlevel_weather > $tmpdir/weather
        echo $(date +%s) > $tmpdir/time
    fi
    echo $powerlevel_weather
}

POWERLEVEL9K_CUSTOM_WEATHER="zsh_weather"
POWERLEVEL9K_CUSTOM_WEATHER_BACKGROUND=143
POWERLEVEL9K_CUSTOM_WEATHER_FOREGROUND=black

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_arch_icon dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time ip battery custom_weather)

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
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
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting extract ng z)

# other usable plugins: zsh-autosuggestions

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


#function googler(){
#    googler --count=5 --noprompt $1
#}

### history configuration ###
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=100000

setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt histignoredups # remove older identical commands
############################

alias google='googler --count=5 --noprompt'

# exectue ls -a after every cd
function chpwd() {
    emulate -L zsh
    ls -a
}

# needed by javafx?
export PATH_TO_FX=/programs/jdk-11.0.2
