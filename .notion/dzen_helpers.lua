--       @www  data  gtd  gtd  code  text  play  pics  game  adm  news            
--= { "", "", "", "", "", "", "", "", "", ""}
--⮁ M ⮁
--⮁ F ⮁
--⮁ T ⮁
--  [ ("power-right"        , "\xe0b0")  -- 
--  , ("power-left"         , "\xe0b2")  -- 
--  , ("power-right-bracket", "\xe0b1")  -- 
--  , ("power-left-bracket" , "\xe0b3")  -- 
--  , ("power-branch"       , "\xe0a0")  -- 
--  , ("power-lock"         , "\xe0a2")  -- 
--  ]
--  -- http://ionicons.com/
--  ionicons = withFont "Ionicons"
--  [ ("ion-battery-charge" , "\xf111")
--  , ("ion-battery-low"    , "\xf112")
--  , ("ion-battery-mid"    , "\xf115")
--  , ("ion-battery-high"   , "\xf114")
--  , ("ion-battery-full"   , "\xf113")
--  , ("ion-volume-high"    , "\xf257")
--  , ("ion-volume-low"     , "\xf258")
--  , ("ion-volume-medium"  , "\xf259")
--  , ("ion-volume-mute"    , "\xf25a")
--  , ("ion-close"          , "\xf128")
--  ]
--  -- https://octicons.github.com/
--  octicons = withFont "octicons"
--  [ ("octicon-bug"           , "\xf091")
--  , ("octicon-browser"       , "\xf0c5")
--  , ("octicon-question"      , "\xf02c")
--  , ("octicon-mirror"        , "\xf024")
--  , ("octicon-unfold"        , "\xf039")
--  , ("octicon-screen-full"   , "\xf066")
--  , ("octicon-screen-normal" , "\xf067")
--  , ("octicon-puzzle"        , "\xf0c0")
--  , ("octicon-rocket"        , "\xf033")
--  , ("octicon-light-bulb"    , "\xf000")
--  , ("octicon-dashboard"     , "\xf07d")
--  , ("octicon-mail"          , "\xf03b")
--  , ("octicon-mail-read"     , "\xf03c")
--  ]
--  -- http://typicons.con (battery)
--  typicons = withFont "Typicons"
--  [ ("typcn-battery-charge" , "\xe02a")
--  , ("typcn-battery-low"    , "\xe02d")
--  , ("typcn-battery-mid"    , "\xe02e")
--  , ("typcn-battery-high"   , "\xe02c")
--  , ("typcn-battery-full"   , "\xe02b")
--  , ("typcn-volume-down"    , "\xe132")
--  , ("typcn-volume-mute"    , "\xe133")
--  , ("typcn-volume-up"      , "\xe134")
--  , ("typcn-volume"         , "\xe135")
--  , ("typcn-flag"           , "\xe074")
--  , ("typcn-plug"           , "\xe0cd")
--  , ("typcn-time"           , "\xe120")
--  ]
--  -- http://adamwhitcroft.com/climacons (nice weather icons)
--  climacons = withFont "Climacons\\-Font"
--  [ ("climacon-cloud"                    , "\xe000")
--  , ("climacon-cloud-sun"                , "\xe001")
--  , ("climacon-cloud-moon"               , "\xe002")
--  , ("climacon-rain"                     , "\xe003")
--  , ("climacon-rain-sun"                 , "\xe004")
--  , ("climacon-rain-moon"                , "\xe005")
--  , ("climacon-showers"                  , "\xe006")
--  , ("climacon-showers-sun"              , "\xe007")
--  , ("climacon-showers-moon"             , "\xe008")
--  , ("climacon-downpour"                 , "\xe009")
--  , ("climacon-downpour-sun"             , "\xe00a")
--  , ("climacon-downpour-moon"            , "\xe00b")
--  , ("climacon-drizzle"                  , "\xe00c")
--  , ("climacon-drizzle-sun"              , "\xe00d")
--  , ("climacon-drizzle-moon"             , "\xe00e")
--  , ("climacon-sleet"                    , "\xe00f")
--  , ("climacon-sleet-sun"                , "\xe010")
--  , ("climacon-sleet-moon"               , "\xe011")
--  , ("climacon-hail"                     , "\xe012")
--  , ("climacon-hail-sun"                 , "\xe013")
--  , ("climacon-hail-moon"                , "\xe014")
--  , ("climacon-flurries"                 , "\xe015")
--  , ("climacon-flurries-sun"             , "\xe016")
--  , ("climacon-flurries-moon"            , "\xe017")
--  , ("climacon-snow"                     , "\xe018")
--  , ("climacon-snow-sun"                 , "\xe019")
--  , ("climacon-snow-moon"                , "\xe01a")
--  , ("climacon-fog"                      , "\xe01b")
--  , ("climacon-fog-sun"                  , "\xe01c")
--  , ("climacon-fog-moon"                 , "\xe01d")
--  , ("climacon-haze"                     , "\xe01e")
--  , ("climacon-haze-sun"                 , "\xe01f")
--  , ("climacon-haze-moon"                , "\xe020")
--  , ("climacon-wind"                     , "\xe021")
--  , ("climacon-wind-cloud"               , "\xe022")
--  , ("climacon-wind-sun"                 , "\xe023")
--  , ("climacon-wind-moon"                , "\xe024")
--  , ("climacon-lightning"                , "\xe025")
--  , ("climacon-lightning-sun"            , "\xe026")
--  , ("climacon-lightning-moon"           , "\xe027")
--  , ("climacon-sun"                      , "\xe028")
--  , ("climacon-sunset"                   , "\xe029")
--  , ("climacon-sunrise"                  , "\xe02a")
--  , ("climacon-sun-low"                  , "\xe02b")
--  , ("climacon-sun-lower"                , "\xe02c")
--  , ("climacon-moon"                     , "\xe02d")
--  , ("climacon-moon-new"                 , "\xe02e")
--  , ("climacon-moon-first-crescent"      , "\xe02f")
--  , ("climacon-moon-first-half"          , "\xe030")
--  , ("climacon-moon-first-three-quarter" , "\xe031")
--  , ("climacon-moon-full"                , "\xe032")
--  , ("climacon-moon-last-three-quarter"  , "\xe033")
--  , ("climacon-moon-last-half"           , "\xe034")
--  , ("climacon-moon-last-crescent"       , "\xe035")
--  , ("climacon-snowflake"                , "\xe036")
--  , ("climacon-tornado"                  , "\xe037")
--  , ("climacon-thermometer-empty"        , "\xe038")
--  , ("climacon-thermometer-low"          , "\xe039")
--  , ("climacon-thermometer-medium-low"   , "\xe03a")
--  , ("climacon-thermometer-medium-high"  , "\xe03b")
--  , ("climacon-thermometer-high"         , "\xe03c")
--  , ("climacon-thermometer-full"         , "\xe03d")
--  , ("climacon-celcius"                  , "\xe03e")
--  , ("climacon-farenheit"                , "\xe03f")
--  , ("climacon-compass"                  , "\xe040")
--  , ("climacon-compass-north"            , "\xe041")
--  , ("climacon-compass-east"             , "\xe042")
--  , ("climacon-compass-south"            , "\xe043")
--  , ("climacon-compass-west"             , "\xe044")
--  , ("climacon-umbrella"                 , "\xe045")
--  , ("climacon-sunglasses"               , "\xe046")
--  , ("climacon-cloud-refresh"            , "\xe047")
--  , ("climacon-cloud-down"               , "\xe048")
--  , ("climacon-cloud-up"                 , "\xe049")
--  ]
--  -- https://dribbble.com/shots/1426626-Leksico-free-icon-font
--  leksico = withFont "Leksico" $ leksicoDates
--            ++ [("leksico-close", "\218")]
--  leksicoDates = makeIcon `fmap` zip ([1..31] :: [Int])
--                 "\256\257\258\259\262\263\269\268\274\275\276\277\260\
--                 \\261\332\299\298\300\301\302\303\362\360\361\361\365\
--                 \\366\367\371\370\374"
--      where makeIcon (day, code) = (printf "leksico-%02d" day, [code])

function wrp(tmplte, left_side, right_side)
    local bracket_color = "#287373"
    local fg_color      = "#cccccc"
    local left_side     = left_side or "[ "
    local right_side    = right_side or " ]"
    local function setcol(color)
        return "^fg(".. color .. ")"
    end
    return setcol(bracket_color) .. left_side ..
           setcol(fg_color) .. tmplte .. setcol(bracket_color) 
           .. right_side .. setcol(fg_color)
end

function dzen_update()
    local template = ""
    if date then
        template = template.."^pa(2;)^bg(#000000)^ba()"..wrp(date).."^ba()^bg()"
    end
    if ws_curr then
            template = template..wrp(ws_curr)
    end
    if kbd_template then
            template = template..wrp(kbd_template)
    end
    if netmon then 
        template = template..wrp("net: " .. netmon)
    end
    dzen_pipe:write(template..'\n')
end
