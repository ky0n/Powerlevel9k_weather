zsh_weather(){
    tmpdir=/tmp/powerlevel_weather
    powerlevel_weather=''
    if [ -d "$tmpdir" ]; then
        local old_time=$(cat $tmpdir/time)  
        local old_weather=$(cat $tmpdir/weather)
        if [[ $old_weather != *[0-9]* ]] | [ $(expr $(date +%s) - $old_time) -gt 300 ]; then
            echo $(requestWeather)
        else
            echo $(cat $tmpdir/weather)
        fi
    else
        mkdir $tmpdir
        echo $(requestWeather)
    fi
}

requestWeather(){
    local confdir="$(echo $HOME)/.config"
    if [[ ! -d $confdir ]]; then
        mkdir -p "$confdir"
    fi
    if [ -f $confdir/powerline_weather ]; then
        woeid=$(cat $confdir/powerline_weather)
    else
        echo "Configuring powerline weather for first time usage" >&2
        echo "Enter your latitude" >&2
        read lat
        echo "Enter your longitude" >&2
        read lng
        weather_data=$(curl --silent https://www.metaweather.com/api/location/search/\?lattlong=$lat,$lng | jq '.[0]')
        echo "Weather for $(echo $weather_data | jq '.title')" >&2
        woeid=$(echo $weather_data | jq '.woeid')
        echo $woeid > $confdir/powerline_weather
    fi
    local weather=$(curl --silent https://www.metaweather.com/api/location/$woeid/ | jq '.consolidated_weather | .[0]')
    local temp=$(echo $weather | jq '.the_temp' | LC_ALL=C xargs /usr/bin/printf '%.*f\n' 1)
    local weather_abbr=$(echo $weather | jq '.weather_state_abbr')
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
    local powerlevel_weather="$symbol ⎮$temp "
    echo $powerlevel_weather > $tmpdir/weather
    echo $(date +%s) > $tmpdir/time
    echo $powerlevel_weather
}

POWERLEVEL9K_CUSTOM_WEATHER="zsh_weather"
POWERLEVEL9K_CUSTOM_WEATHER_BACKGROUND=221
POWERLEVEL9K_CUSTOM_WEATHER_FOREGROUND=blac

# add 'custom_weather' to the powerlevel9k prompt elements to use the weather element
# like POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_weather)