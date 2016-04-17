#/bin/zsh

FG='#dcdcdc'
BG='#000000'
fg_title="#abd4e2"

fn_="PragmataPro for Powerline"
wfn_="Weather Icons"
fn1="${fn_}:size=11"      
fnT="${fn_}:bold:size=11"  
fn_14="${fn_}:bold:size=14"
wic_13="${wfn_}:size=13"  
wic_16="${wfn_}:size=16"   
wic_45="${wfn_}:size=45"

icons1="Ionicons:size=13"
icons2="Typicons:size=16"
icons3="Ionicons:size=16"
icons4="Typicons:size=13"

forecast_data_=$(readlink -f ~/tmp/forecast.json)

declare -A weather_icon_list
weather_icon_list=(
    ["clear-day"]=""
    ["clear-night"]=""
    ["rain"]=""
    ["snow"]=""
    ["sleet"]=""
    ["wind"]=""
    ["fog"]=""
    ["cloudy"]=""
    ["partly-cloudy-day"]=""
    ["partly-cloudy-night"]=""
    ["hail"]=""
    ["thunderstorm"]=""
    ["tornado"]=""
    ["N"]=""
    ["E"]=""
    ["S"]=""
    ["W"]=""
    ["NE"]=""
    ["NW"]=""
    ["SE"]=""
    ["SW"]=""
)

# ---- Today info ----
today_sum=$(jshon -e daily < ${forecast_data_} | \
            jq '.data[0].summary' | \
            tr -d '"'
)
today_icon=$(grep $(jshon -e daily < ${forecast_data_} | \
                    jq '.data[0].icon' | \
                    grep -o '[^\"]*') \
             weather_icon_list | \
             awk 'NR==1' | \
             grep -o "\"[^\"]*\"" | \
             grep -o "[^\"]*"
)

# Temperature levels
today_temp_max=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
      jq '.data[0].temperatureMax'
     )
)
today_temp_min=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[0].temperatureMin')
)

sunriseTimeStamp=$(jshon -e daily < ${forecast_data_} | jq '.data[0].sunriseTime')
sunsetTimeStamp=$(jshon -e daily < ${forecast_data_} | jq '.data[0].sunsetTime')

sunriseTime=$(date -ud @${sunriseTimeStamp})
sunsetTime=$(date -ud @${sunsetTimeStamp})

sunrise=$(date -d "${sunriseTime}" +'%H:%M')
sunset=$(date -d "${sunsetTime}" +'%H:%M')

# Moon phase
lunationNumber=$(jshon -e daily < ${forecast_data_} | jq '.data[0].moonPhase')

# ---------- Currently
current_sum=$(jshon -e currently < ${forecast_data_} | jq '.summary' | tr -d '"')
current_icon=$(grep $(jshon -e currently < ${forecast_data_} | jq '.icon' | \
    grep -o '[^\"]*') weather_icon_list | \
    awk 'NR==1' | \
    grep -o "\"[^\"]*\"" | \
    grep -o "[^\"]*")
current_temp=$(printf "%0.0f\n" \
    $(jshon -e currently < ${forecast_data_} | \
    jq '.temperature'))

cloudiness=$(jshon -e currently < ${forecast_data_} | jq '.cloudCover')
if (( $(bc -l <<< "${cloudiness} != 0") )); then
    if [[ "${cloudiness}" = "1" ]]; then
        cloudiness=$(bc -l <<< "${cloudiness} * 100")
    else
        cloudiness=$(bc -l <<<  "${cloudiness} * 100"| tr -d '.00')
    fi
else
    cloudiness="${cloudiness}"
fi

# Humidity
humidity=$(jshon -e currently < ${forecast_data_} | jq '.humidity')
if (( $(bc -l <<<  "${humidity} != 0") )); then
    if [[ "${humidity}" = "1" ]]; then
        humidity=$(bc -l <<<  "${humidity} * 100")
    else
        humidity=$(bc -l <<< "${humidity} * 100"| tr -d '.00')
    fi
else
    humidity="${humidity}"
fi

# Wind info
windSpeed=$(jshon -e currently < ${forecast_data_} | jq '.windSpeed')

# Getting today's wind Speed and wind Bearing
if (( $(bc -l <<<  "${windSpeed} != 0" ) )); then
    wind_bearing=$(jshon -e currently < ${forecast_data_} | jq '.wind_bearing')
else
    wind_bearing="n/a"
fi

# Getting today's wind direction name
if [[ "${wind_bearing}" = "n/a" ]]; then
    wind_dir="n/a"
else
    if (( "${wind_bearing}" >= 0 )) && (( "${wind_bearing}" <= 11 )); then
        wind_dir="N"
    elif (( "${wind_bearing}" > 11 )) && (( "${wind_bearing}" <= 79 )); then
        wind_dir="NE"
    elif (( "${wind_bearing}" > 79 )) && (( "${wind_bearing}" <= 101 )); then
        wind_dir="E"
    elif (( "${wind_bearing}" > 101 )) && (( "${wind_bearing}" <= 169 )); then
        wind_dir="SE"
    elif (( "${wind_bearing}" > 169 )) && (( "${wind_bearing}" <= 191 )); then
        wind_dir="S"
    elif (( "${wind_bearing}" > 191 )) && (( "${wind_bearing}" <= 259 )); then
        wind_dir="SW"
    elif (( "${wind_bearing}" > 259 )) && (( "${wind_bearing}" <= 281 )); then
        wind_dir="W"
    elif (( "${wind_bearing}" > 281 )) && (( "${wind_bearing}" <= 349 )); then
        wind_dir="NW"
    else
        wind_dir="N"
    fi
fi

wind_icon=$(grep $(grep -o '[^\"]*' <<<  ${wind_dir}) weather_icon_list | \
    awk 'NR==1' | \
    grep -o "\"[^\"]*\"" | \
    grep -o "[^\"]*")

# ---- Next 7 day forecast
next7DAYsum=$(jshon -e daily < ${forecast_data_} | jq '.summary')

# Tomorrow
next_name=$(date --date='+1 day' +'%a' | tr '[:lower:]' '[:upper:]')
next_sum=$(jshon -e daily < ${forecast_data_} | \
    jq '.data[1].summary' | \
    tr -d '"')
next_icon=$(grep $(jshon -e daily < ${forecast_data_} | \
    jq '.data[1].icon' | \
    grep -o '[^\"]*') \
    weather_icon_list | \
    awk 'NR==1' | \
    grep -o "\"[^\"]*\"" | \
    grep -o "[^\"]*")
next_temp_max=$(printf "%0.0f\n" $(jshon -e daily < ${forecast_data_} | jq '.data[1].temperatureMax'))
next_temp_min=$(printf "%0.0f\n" $(jshon -e daily < ${forecast_data_} | jq '.data[1].temperatureMin'))

# Sunrise, Sunset
next_sunriseTimeStamp=$(jshon -e daily < ${forecast_data_} | jq '.data[1].sunriseTime')
next_sunsetTimeStamp=$(jshon -e daily < ${forecast_data_} | jq '.data[1].sunsetTime')

next_sunriseTime=$(date -ud @${next_sunriseTimeStamp})
next_sunsetTime=$(date -ud @${next_sunsetTimeStamp})

next_sunrise=$(date -d "${next_sunriseTime}" +'%H:%M')
next_sunset=$(date -d "${next_sunsetTime}" +'%H:%M')

next_cloudiness=$(jshon -e daily < ${forecast_data_} | jq '.data[1].cloudCover')
if (( $(bc -l <<< "${next_cloudiness} != 0") )); then
    if [[ "${next_cloudiness}" = "1" ]]; then
        next_cloudiness=$(bc -l <<<  "${next_cloudiness} * 100")
    else
        next_cloudiness=$(bc -l <<< "${next_cloudiness} * 100" | tr -d '.00')
    fi
else
    next_cloudiness="${next_cloudiness}"
fi

next_humidity=$(jshon -e daily < ${forecast_data_} | jq '.data[1].humidity')

if (( $(echo "${next_humidity} != 0" | bc -l) )); then
    if [[ "${next_humidity}" = "1" ]]; then
        next_humidity=$(bc -l <<<  "${next_humidity} * 100")
    else
        next_humidity=$(bc -l <<<  "${next_humidity} * 100"| tr -d '.00')
    fi
else
    next_humidity="${next_humidity}"
fi

# 3rd day
day3_name=$(date --date='+2 day' +'%a' | tr '[:lower:]' '[:upper:]')
day3_sum=$(jshon -e daily < ${forecast_data_} | jq '.data[2].summary' | tr -d '"')
day3_icon=$(grep $(jshon -e daily < ${forecast_data_} | \
                   jq '.data[2].icon' | \
                   grep -o '[^\"]*') \
            weather_icon_list | \
            awk 'NR==1' | \
            grep -o "\"[^\"]*\"" | \
            grep -o "[^\"]*" \
)

day3_temp_max=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
      jq '.data[2].temperatureMax') \
)
day3_temp_min=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[2].temperatureMin') \
)

# 4th day
day4_name=$(date --date='+3 day' +'%a' | \
            tr '[:lower:]' '[:upper:]' \
           )
day4_sum=$(jshon -e daily < ${forecast_data_} | \
           jq '.data[3].summary' | \
           tr -d '"' \
           )
day4_icon=$(grep $(jshon -e daily < ${forecast_data_} | \
                   jq '.data[3].icon' | \
                   grep -o '[^\"]*') \
            weather_icon_list | \
            awk 'NR==1' | \
            grep -o "\"[^\"]*\"" | \
            grep -o "[^\"]*" \
)
day4_temp_max=$(printf "%0.0f\n" \
                $(jshon -e daily < ${forecast_data_} | \
                jq '.data[3].temperatureMax') \
               )
day4_temp_min=$(printf "%0.0f\n" \
                $(jshon -e daily < ${forecast_data_} | \
                  jq '.data[3].temperatureMin') \
               )

# 5th day
day5_name=$(date --date='+4 day' +'%a' | tr '[:lower:]' '[:upper:]')
day5_sum=$(jshon -e daily < ${forecast_data_} | \
           jq '.data[4].summary' | \
           tr -d '"' \
)
day5_icon=$(grep $(jshon -e daily < ${forecast_data_} | \
                   jq '.data[4].icon' | \
                   grep -o '[^\"]*') \
            weather_icon_list | \
            awk 'NR==1' | \
            grep -o "\"[^\"]*\"" | \
            grep -o "[^\"]*" \
)
day5_temp_max=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[4].temperatureMax') \
)
day5_temp_min=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[4].temperatureMin') \
)

# 6th day
day6_name=$(date --date='+5 day' +'%a' | tr '[:lower:]' '[:upper:]')
day6_sum=$(jshon -e daily < ${forecast_data_} | jq '.data[5].summary' | tr -d '"')
day6_icon=$(grep $(jshon -e daily < ${forecast_data_} | \
                   jq '.data[5].icon' | \
                   grep -o '[^\"]*') \
            weather_icon_list | \
            awk 'NR==1' | \
            grep -o "\"[^\"]*\"" | \
            grep -o "[^\"]*" \
)
day6_temp_max=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[5].temperatureMax') \
)
day6_temp_min=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[5].temperatureMin') \
)

# 7th day
day7_name=$(date --date='+6 day' +'%a' | tr '[:lower:]' '[:upper:]')
day7_sum=$(jshon -e daily < ${forecast_data_} | \
           jq '.data[6].summary' | \
           tr -d '"' \
)
day7_icon=$(grep $(jshon -e daily < ${forecast_data_} | \
                   jq '.data[6].icon' | \
                   grep -o '[^\"]*') \
            weather_icon_list | \
            awk 'NR==1' | \
            grep -o "\"[^\"]*\"" | \
            grep -o "[^\"]*" \
)
day7_temp_max=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[6].temperatureMax') \
)
day7_temp_min=$(printf "%0.0f\n" \
    $(jshon -e daily < ${forecast_data_} | \
    jq '.data[6].temperatureMin') \
)

(
    echo "   ^fn(${fn_14})${current_temp}°, ${current_sum}  ^fn(${fn1})"
    echo "   ^p(+50;-9)^fn(${wic_45})${current_icon}^fn(${fn1})^p() ^p(+75)^fg(#87d7ff)${today_temp_min}°^fg()^fn(${icons2})^fn($fn1)^p(+2)^fg(#ff8b8b)${today_temp_max}°^fg()^p()  ${wind_dir} ^fn(${wic_16})${wind_icon}^fn(${fn1}) ${windSpeed} m/s"
    echo "   ^p(+50;-36)^fn(${wic_45})${current_icon}^fn(${fn1})^p() ^p(+75)^fn(${wic_16})^fn(${fn1}) ${humidity}%  ^fn(${icons3})^fn($fn1) ${cloudiness}%"
    echo "   ^p(+50;-63)^fn(${wic_45})${current_icon}^fn(${fn1})^p()^p(+82)^fg(#ffd7af)^fn(${wic_13})^fn(${fn1})^fg() ${sunrise}  ^fg(#ffafaf)^fn(${wic_13})^fn(${fn1})^fg() ${sunset}"
    echo "   ${today_sum}"
    echo "   ^fg(#666666)-----------------------------------------------------"
    echo "   ^bg(#222222)^fn(${fn_14}) ${next_name} ^fn(${fn1})^bg()  ^fn(${wic_16})${next_icon}^fn(${fn1}) ^p(;+2)^fg(#87d7ff)${next_temp_min}°^fg()^fn(${icons4})^fn(${fn1})^p(+3)^fg(#ff8b8b)${next_temp_max}°^fg()^p()   ^fg(#ffd7af)^fn(${wic_13})^fn(${fn1})^fg() ${next_sunrise} ^fg(#ffafaf)^fn(${wic_13})^fn(${fn1})^fg() ${next_sunset}  ^fn(${wic_16})^fn(${fn1}) ${next_humidity}%"
    echo "   ${next_sum}"
    echo "   ^bg(#222222)^fn(${fn_14}) ${day3_name} ^fn(${fn1})^bg()  ^fn(${wic_16})${day3_icon}^fn(${fn1}) ^p(;+2)^fg(#87d7ff)${day3_temp_min}°^fg()^fn(${icons4})^fn(${fn1})^p(+3)^fg(#ff8b8b)${day3_temp_max}°^fg()"
    echo "   ${day3_sum}"
    echo "   ^bg(#222222)^fn(${fn_14}) ${day4_name} ^fn(${fn1})^bg()  ^fn(${wic_16})${day4_icon}^fn(${fn1}) ^p(;+2)^fg(#87d7ff)${day4_temp_min}°^fg()^fn(${icons4})^fn(${fn1})^p(+3)^fg(#ff8b8b)${day4_temp_max}°^fg()"
    echo "   ${day4_sum}"
    echo "   ^bg(#222222)^fn(${fn_14}) ${day5_name} ^fn(${fn1})^bg()  ^fn(${wic_16})${day5_icon}^fn(${fn1}) ^p(;+2)^fg(#87d7ff)${day5_temp_min}°^fg()^fn(${icons4})^fn(${fn1})^p(+3)^fg(#ff8b8b)${day5_temp_max}°^fg()"
    echo "   ${day5_sum}"
    echo "^bg(#666666)^fg(#222222)   Powered by forecast.io   "
) | dzen2 -p -x 582 -y 28 -w 420 \
    -bg ${BG} -fg ${FG} \
    -h 27 -l 14 -sa l -ta l \
    -e 'onstart=uncollapse;button1=exit;button3=exit' \
    -fn "${fn1}"
