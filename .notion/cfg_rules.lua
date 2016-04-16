-------------------------------------[[ KLUDGES ]]----------------------------------
defwinprop{
    lazy_resize=true,     -- Resize lazy because it's faster
    new_group=true,       -- Create a new group if needed
	ignore_cfgrq=false,   -- Configure requests shouldn't be ignored
}
-------------------------------------[[ TERM ]]-------------------------------------
defwinprop{class="URxvt",instance="MainTerminal",transient_mode="off",target="term"
,ignore_max_size=false,ignore_min_size=false,ignore_aspect=false,ignore_resizeinc=true}
defwinprop{instance="mutt",transient_mode="off",target="mutt"}
defwinprop{class="URxvt",instance="code",transient_mode="off",ignore_cfgrq=true,target="notes"}
defwinprop{class="yakuake",instance="*",transient_mode="off",ignore_cfgrq=true,float=true}
defwinprop{name="float_",float=true}
-------------------------------------[[ WEB ]]---------------------------------------
defwinprop{class="Chromium",transient_mode="off",transient_mode="off",jumpto=true,target="web",tag="www"}
defwinprop{class="chromium",transient_mode="off",transient_mode="off",jumpto=true,target="web",tag="www"}
defwinprop{class="Chromium-www",transient_mode="off",transient_mode="off",target="web",tag="www"}
defwinprop{class="yandex-browser-beta",transient_mode="off",transient_mode="off",target="web",tag="www"}
defwinprop{class="Opera",instance="startupdialog",transient_mode="off",target="web"}
defwinprop{instance="opera",transient_mode="off",transient_mode="off",target="web",tag="www"}
defwinprop{class="Dwb",transient_mode="off",jumpto="on",target="web",tag="www"}
defwinprop{class="Tor Browser",transient_mode="off",jumpto="on",target="web",tag="www"}
defwinprop{class="Firefox",transient_mode="off",jumpto="on",target="web",tag="www"}
defwinprop{class="Firefox",role="Manager",instance="Download",transient_mode="off",jumpto="off",target="firefox-dialog"}
defwinprop{class="Firefox",instance="Dialog",float=true}
defwinprop{class="Firefox",role="Organizer",target="firefox-dialog"}
defwinprop{class="Firefox",instance="firefox",role="GtkFileChooserDialog",
    max_size = {w=1024,h=768},
    min_size = {w=800,h=600},
    float=true,
}
defwinprop{class="Conkeror",instance="Navigator",transient_mode="off",target="web",tag="www"}
defwinprop{class="Iceweasel",role="www",transient_mode="off",jumpto="on",target="web",tag="www"}
defwinprop{class="Icecat",role="www",transient_mode="off",jumpto="on",target="web",tag="www"}
defwinprop{class="Navigator",role="www",transient_mode="off",jumpto="on",target="web",tag="www"}
defwinprop{class="Vimprobable2",role="vimprobable2",transient_mode="off",jumpto="on",target="web",tag="www"}
-------------------------------------[[ IM ]]---------------------------------------
defwinprop{instance="kopete",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{instance="skype",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{class="Telegram",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{class="telegram",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{class="telegram-desktop",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{name="Telegram",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{instance="finch",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{instance="centerim",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{instance="centerim",jumpto=false,winlist_ignore=true,transient_mode="off",target="im"}
defwinprop{instance="weechat-curses",jumpto=false,winlist_ignore=true,transient_mode="off",target="chat"}
defwinprop{instance="_weechat_",jumpto=false,winlist_ignore=true,transient_mode="off",target="weechat"}
-------------------------------------[[ DOC ]]---------------------------------------
defwinprop{class="Okular",instance="okular",transient_mode="off",jumpto=true,target="doc", tag="pdf"}
defwinprop{name="Open Document*",class="Okular",instance="okular",transient_mode="off",jumpto=true,target="doc",float=true}
defwinprop{class="Apvlv",instance="apvlv",transient_mode="off",jumpto=true,target="doc",tag="pdf"}
defwinprop{class="Zathura",instance="zathura",transient_mode="off",jumpto=true,target="doc",tag="pdf"}
defwinprop{class="Xpdf",instance="openDialog_popup",ignore_cfgrq=true,tag="pdf"}
defwinprop{class="Evince",instance="evince",transient_mode="off",jumpto=true,target="doc",tag="pdf"}
defwinprop{class="XDvi",target="doc",tag="pdf"}
defwinprop{class="libreoffice*",instance="*",target="doc",tag="writer"}
defwinprop{class="abiword",instance="*",target="doc",tag="writer"}
defwinprop{class="atril",instance="*",target="doc",tag="writer"}
defwinprop{class="guncharmap",instance="*",target="doc",tag="writer"}
defwinprop{class="Cr3",instance="cr3",target="doc",tag="reader"}
-------------------------------------[[ MEDIA ]]---------------------------------------
defwinprop{class="gmpc",target="media"}
defwinprop{class="MPlayer",jumpto=true,transient_mode="off",target="media",tag="video"}
defwinprop{class="mplayer2",jumpto=true,transient_mode="off",target="media",tag="video"}
defwinprop{class="mpv",jumpto=true,transient_mode="off", target="media",tag="video"}
defwinprop{class="mpv",instance="webcam_mpv",target="_webcam_"}
defwinprop{class="feh",float=true,ignore_cfgrq=true,transient_mode="current"}
defwinprop{class="qiv",jumpto="on",transient_mode="normal",float=true}
defwinprop{class="cheese",target="media",jumpto=true,transient_mode="off",float=false}
-------------------------------------[[ DEV ]]--------------------------------------
defwinprop{class="Gvim",instance="gvim",target="dev",jumpto=true,transient_mode="off",userpos=true,
tag="editor", ignore_max_size=true,ignore_min_size=true,ignore_aspect=true,ignore_resizeinc=true }
defwinprop{class="Atom",target="dev",jumpto=true,transient_mode="off",tag="aeditor"}
defwinprop{instance="subl3|sublime_text",target="dev",jumpto=true,transient_mode="off",userpos=true, tag="editor" }
defwinprop{class="URxvt",instance="wim",target="dev",jumpto=true,transient_mode="off",
tag="editor",transparent=false
-- ignore_max_size=true, ignore_min_size=true,ignore_resizeinc=true,
}
defwinprop{class="wim",target="dev",jumpto=true,transient_mode="off", tag="editor",transparent=false }
defwinprop{class="nwim",target="dev",jumpto=true,transient_mode="off", tag="editor",transparent=false }
defwinprop{class="Qvim",instance="qvim",target="dev",jumpto=true,transient_mode="off",
ignore_max_size=false,ignore_min_size=false,ignore_aspect=false,ignore_resizeinc=true,
tag="editor"
}
defwinprop{class="Emacs",instance="emacs",target="dev",lazyresize=true,jumpto=true, tag="geditor"}
defwinprop{class="Emacs",instance="emacs",name="Question",float=true, tag="geditor"}
defwinprop{class="com-sun-javaws-Main",instance="sun-awt-X11-XFramePeer",target="topcoder"}
-----------------------------------[[ IDEA ]]--------------------------------------
defwinprop{class="jetbrains-idea",instance="*",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-idea-ce",instance="sun-awt-X11-XDialogPeer",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-idea",instance="sun-awt-X11-XWindowPeer",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-idea",instance="sun-awt-X11-XDialogPeer",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-idea",instance="sun-awt-X11-XFramePeer",target="jetbrains",floating=true,transient_mode="off",tag="ide"}
----------------------------------[[ WEBSTORM ]]-----------------------------------
defwinprop{class="jetbrains-webstorm",instance="*",target="jetbrains",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-webstorm-ce",instance="sun-awt-X11-XDialogPeer",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-webstorm",instance="sun-awt-X11-XWindowPeer",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-webstorm",instance="sun-awt-X11-XDialogPeer",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-webstorm",instance="sun-awt-X11-XFramePeer",target="jetbrains",floating=true,transient_mode="off",tag="ide"}
----------------------------------[[  CLION   ]]-----------------------------------
defwinprop{class="jetbrains-clion",instance="*",target="jetbrains",target="jetbrains",floating=true,transient_mode="current",tag="ide"}
defwinprop{class="jetbrains-clion",instance="sun-awt-X11-XWindowPeer",target="jetbrains",floating=true,transient_mode="current",target="jetbrains",tag="ide"}
defwinprop{class="jetbrains-clion",instance="sun-awt-X11-XDialogPeer",target="jetbrains",floating=true,transient_mode="current",target="jetbrains",tag="ide"}
defwinprop{class="jetbrains-clion",instance="sun-awt-X11-XFramePeer",target="jetbrains",floating=true,transient_mode="off",target="jetbrains",tag="ide"}
-------------------------------[[ ANDROID STUDIO ]]--------------------------------
defwinprop{class="jetbrains-android-studio",instance="sun-awt-X11-XDialogPeer",target="jetbrains",floating=true,transient_mode="current", tag="ide"}
defwinprop{class="jetbrains-android-studio",instance="sun-awt-X11-XWindowPeer",target="jetbrains",floating=true,transient_mode="current", tag="ide"}
defwinprop{class="jetbrains-android-studio",instance="sun-awt-X11-XDialogPeer",target="jetbrains",floating=true,transient_mode="current", tag="ide"}
defwinprop{class="jetbrains-android-studio",instance="sun-awt-X11-XFramePeer",target="jetbrains",floating=true,transient_mode="off", tag="ide"}
-------------------------------------[[ VM ]]--------------------------------------
defwinprop{class="vmware",instance="Vmware",target="vm",jumpto=true,transient_mode="off",float=true,tag="virt"}
defwinprop{class="VirtualBox",jumpto=true,target="vm",transient_mode="off",tag="virt"}
defwinprop{class="Vmware",jumpto=true,target="vm",transient_mode="on",tag="virt"}
defwinprop{class="QEMU",jumpto=true,target="vm",transient_mode="on",tag="virt"}
defwinprop{class="spicec",instance="spicec",jumpto=true,target="vm",transient_mode="on",tag="virt"}
defwinprop{instance="spicy",jumpto=true,target="vm",transient_mode="on",tag="virt"}
-------------------------------------[[   GRARPHIC  ]]-----------------------------
defwinprop{class="Gimp",target="graphic",acrobatic=true,tag="graphic",tag="graph"}
defwinprop{class="inkscape",target="graphic",tag="graph"}
defwinprop{class="simple-scan",target="graph"}
defwinprop{class="gthumb",target="graph"}
defwinprop{class="Gimp",target="graphic",jumpto=true,role="gimp-file-open",transient_mode="off",float=true,tag="graph"}
defwinprop{class="Gimp",target="graphic",jumpto=true,role="gimp-file-save",transient_mode="off",float=true,tag="graph"}
defwinprop{class="Gimp",target="graphic",jumpto=true,role="gimp-message-dialog",transient_mode="off",float=true,tag="graph"}
defwinprop{class="Gimp",target="graphic",jumpto=true,role="gimp-image-new",transient_mode="off",float=true,tag="graph"}
defwinprop{class="Gimp",target="graphic",jumpto=true,role="gimp-toolbox-color-dialog",transient_mode="off",float=true,tag="graph"}
-------------------------------------[[ TRAY'n'DOCK ]]------------------------------
defwinprop{class="stalonetray",instance="stalonetray",statusbar="*",float=true,target="stalonetray"}
defwinprop{is_dockapp=true,statusbar="*",float=true}
-------------------------------------[[   ADMIN  ]]---------------------------------
defwinprop{instance="remmina",target="admin",jumpto=true,tag="admin"}
defwinprop{instance="htop_term",target="admin",jumpto=true,tag="admin"}
defwinprop{instance="glances_term",target="admin",jumpto=true,tag="admin"}
defwinprop{instance="gparted",target="admin",jumpto=true,tag="admin"}
defwinprop{instance="gnome-disks",target="admin",jumpto=true,tag="admin"}
defwinprop{instance="seahorse",target="admin",jumpto=true,tag="admin"}
-------------------------------------[[  WINE  ]]------------------------------------
defwinprop{class="Crossover",target="wine",jumpto=true,tag="virt",float=true}
defwinprop{class="Wine",target="wine",jumpto=true,tag="virt"}
defwinprop{name=".*.exe",target="wine",jumpto=true,tag="virt"}
defwinprop{name="wine.*",target="wine",jumpto=true,tag="virt"}
defwinprop{name="explorer.exe",target="wine",jumpto=true,tag="virt"}
defwinprop{name="Explorer.exe",target="wine",jumpto=true,tag="virt"}
defwinprop{class="explorer.exe",target="wine",jumpto=true,tag="virt"}
defwinprop{class="Explorer.exe",target="wine",jumpto=true,tag="virt"}
-------------------------------------[[ TORRENT ]]-----------------------------------
defwinprop{class="Ktorrent",winlist_ignore=true,transient_mode="off",instance="ktorrent",target="torrent",tag="torrent"}
defwinprop{class="Vuze",winlist_ignore=true,transient_mode="off",target="torrent",tag="torrent",float=false}
defwinprop{class="Vuze",is_transient=true,winlist_ignore=true,transient_mode="off",target="torrent",tag="torrent",float=true}
-------------------------------------[[  ETC  ]]-------------------------------------
defwinprop{class="UE4Editor",floating=true,transient_mode="off",target="unreal",tag="unreal"}
defwinprop{class="Xfce*",float=true}
defwinprop{class="Xmessage",float=true}
defwinprop{class="com-sun-javaws-Main",float=true}
defwinprop{class="Steam",target="wine",jumpto=true,tag="virt"}
defwinprop{instance="recoll",jumpto=false,winlist_ignore=true,target="search"}
defwinprop{instance="stardict",jumpto=true,winlist_ignore=true,transient_mode="off",winlist_ignore=true,target="float"}
defwinprop{instance="lxappearance",jumpto=true,winlist_ignore=true,transient_mode="off",winlist_ignore=true,target="float"}
defwinprop{class="rdesktop",instance="rdesktop",transient_mode="off",jumpto=true,target="rdesktop"}
defwinprop{class="Conky",winlist_ignore=true,float=true}
defwinprop{class="URxvt",instance="mpd-pad",winlist_ignore=true,transient_mode="off",target="ncmpcpp"}
defwinprop{class="URxvt",instance="mpd-pad2",winlist_ignore=true,transient_mode="off",target="ncmpcpp"}
defwinprop{class="mpd-pad2",instance="*",winlist_ignore=true,transient_mode="off",target="ncmpcpp"}
defwinprop{instance="mpd-pad2",winlist_ignore=true,transient_mode="off",target="ncmpcpp"}
defwinprop{role="mpd",target="ncmpcpp"}
defwinprop{class="Tilda",instance="tilda",winlist_ignore=true,transient_mode="off",float=true}
defwinprop{class="Guake",instance="guake",winlist_ignore=true,transient_mode="off",float=true}
defwinprop{class="Pavucontrol",instance="pavucontrol",winlist_ignore=true,transient_mode="off",target="float"}
defwinprop{instance="wicd",winlist_ignore=true,transient_mode="off",target="wicd"}
defwinprop{instance="ranger",winlist_ignore=true,transient_mode="off",target="ranger"}
defwinprop{class="ranger",winlist_ignore=true,transient_mode="off",target="ranger"}
defwinprop{class="caja",winlist_ignore=true,transient_mode="off",target="ranger"}
defwinprop{instance="console",winlist_ignore=true,transient_mode="off",target="console"}
defwinprop{instance="gdb",winlist_ignore=true,transient_mode="off",target="gdb"}
defwinprop{instance="mixer",winlist_ignore=true,transient_mode="off",target="alsa"}
defwinprop{instance="htop",winlist_ignore=true,transient_mode="off",target="top"}
defwinprop{instance="gcolor2",winlist_ignore=true,transient_mode="off",jumpto=true,target="float"}
defwinprop{instance="gpick",winlist_ignore=true,transient_mode="off",jumpto=true,target="float"}
defwinprop{class="Nicotine",instance="nicotine",transient_mode="off",target="nicotine",tag="soulseek"}
defwinprop{class="Nicotine.py",instance="nicotine.py",transient_mode="off",target="nicotine",tag="soulseek"}
defwinprop{class="*",instance="*",transparent=false}
