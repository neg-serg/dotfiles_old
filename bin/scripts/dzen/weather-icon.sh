#!/bin/zsh

forecast_data_=$(readlink -f ~/tmp/forecast.json)
status_=$(jshon -Q -e currently < ${forecast_data_})

if [[ "${status_}" = "" ]]; then
	info="^fg(#666666)^fn(PragmataPro for Powerline:size=10)No Access"
else
    icon=$(grep $(jshon -e currently < ${forecast_data_} | \
                  jq '.icon' | \
                  grep -o '[^\"]*' \
                 ) \
           weather_icon_list | \
           awk 'NR==1' | \
           grep -o "\"[^\"]*\"" | \
           grep -o "[^\"]*"
    )
    temp=$(printf "%0.0f\n" \
        $(jshon -e currently < ${forecast_data_} | \
          jq '.temperature' \
         )
    )
	info="^fn(Weather Icons:size=13)${icon}^fn() ${temp}°F"
fi

builtin printf "${info}\n"
