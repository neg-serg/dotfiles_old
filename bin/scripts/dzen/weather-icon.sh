#!/bin/zsh

status_=$(cat ~/tmp/forecast.json | jshon -Q -e currently)

if [[ "${status_}" = "" ]]; then
	info="^fg(#666666)^fn(PragmataPro for Powerline:size=10)No Access"
else
    icon=$(grep $(cat ~/tmp/forecast.json | \
                  jshon -e currently | \
                  jq '.icon' | \
                  grep -o '[^\"]*') \
           weather_icon_list | \
           awk 'NR==1' | \
           grep -o "\"[^\"]*\"" | \
           grep -o "[^\"]*"
    )
    temp=$(printf "%0.0f\n" $(cat ~/tmp/forecast.json | jshon -e currently | jq '.temperature'))
	info="^fn(Weather Icons:size=13)${icon}^fn() ${temp}°F"
fi

echo "${info}"
