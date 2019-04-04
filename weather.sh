weather_time=0
zsh_weather(){
    local lat=49.87
    local lng=208.64
    local woeid=$(curl https://www.metaweather.com/api/location/search/\?lattlong=$lat,$lng | jq '.[0].woeid')
    local weather_abbr=$(curl https://www.metaweather.com/api/location/$woeid/ | jq '.consolidated_weather | .[0].weather_state_abbr')
    local symbol
    case $weather_abbr in 
        "\"lc\"")
            symbol="\uE319";;
        ha)
            echo $weather_abbr
            echo "nothing matches";;
    esac
    echo $symbol
}