-- Create a statusbar
mod_statusbar.create{
    -- First screen, bottom left corner
    screen=0,
    pos='bl',
    fullsize=true,
    systray=true,
    template="%date"..
    "[ %>workspace_name ]"..
    "[ %exec_xkb ]"..
    "[ net: %netmon_kbsin/%netmon_kbsout ]"..
    "%filler"..
    "%>exec_kt"..
    "%systray%systray_stalone"
}

-- Launch ion-statusd. This must be done after creating any statusbars
-- for necessary modules to be parsed from the templates.
mod_statusbar.launch_statusd{
    date={ date_format='[ %H:%M ]',
        --date_format='[ %H:%M ][ %a %d %b %y ]',
    },

    exec = {
        xkb={program = "~/bin/mon/klay",retry_delay = 1 * 300,},
        kt={program ="~/bin/mon/crntsng.sh",retry_delay=1 * 1000,},
    }
}

