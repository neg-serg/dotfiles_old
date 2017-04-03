#!/usr/bin/env python3
class ns_settings(object):
    group_list=[]
    ns_data=""
    settings={}

    def __init__(self):
        self.settings = {
            'im' : {
                'classes' : {
                    'TelegramDesktop',
                    'Telegram-desktop',
                    'telegram-desktop',
                    'skypeforlinux',
                    'ViberPC',
                    'finch',
                },
                'geom' : "528x1029+1372+127"
            },
            'ncmpcpp': {
                'classes' : { 'mpd-pad2' },
                'geom' : "1200x600+400+400",
                'prog': 'st -f "PragmataPro for Powerline:pixelsize=18" -c mpd-pad2 -e ncmpcpp'
            },
            'mutt': {
                'classes' : { '' },
                'instances' : { 'mutt' },
                'geom' : "1250x700+293+0",
                'prog' : "st -f \'PragmataPro for Powerline:size=12\' -c mutt -e mutt",
            },
            'ranger': {
                'classes' : { 'ranger' },
                'geom' : "1132x760+170+18",
                'prog' : "~/bin/scripts/run_ranger"
            },
            'teardrop': {
                'classes' : { 'teardrop' },
                'geom' : "1823x489+38+0",
                'prog' : "st -c teardrop -f \'PragmataPro for Powerline:size=10\' -e ~/bin/scripts/teardrop"
            }
        }

        for group in self.settings:
            self.group_list.append(group)

        self.ns_data="/tmp/ns_data"
