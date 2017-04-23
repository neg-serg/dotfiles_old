#!/usr/bin/env python3

import re

class ns_settings(object):
    def init_i3_win_cmds(self, hide):
        def ch_(list, ch):
            if len(list) > 1:
                ret=ch
            else:
                ret=''
            return ret

        def parse_attr_(attr):
            ret=""
            attrib_list=self.settings[tag][attr]
            if len(attrib_list)>1:
                ret+='('
            for iter,item in zip(range(len(attrib_list)),attrib_list):
                if iter+1 < len(attrib_list):
                    ret+=item+'|'
                else:
                    ret+=item
            if len(attrib_list) > 1:
                ret+=')$'
            ret+='"] '

            return ret

        def mv_scratch():
            return "move scratchpad, "

        def hide_cmd():
            if hide:
                ret = ", [con_id=__focused__] scratchpad show"
            else:
                ret = ""
            return ret

        def ret_info(key):
            if key in attr:
                lst=[item for item in self.settings[tag][key] if item != '']
                if lst != []:
                    pref="[" + '{}="'.format(attr) + ch_(self.settings[tag][attr],'^')
                    for_win_cmd=pref + parse_attr_(key) + mv_scratch() + self.parse_geom(tag) + hide_cmd()
                    return for_win_cmd
            return ''

        cmd_list=[]
        for tag in self.settings:
            for attr in self.settings[tag]:
                cmd_list.append(ret_info('class'))
                cmd_list.append(ret_info('instance'))

        self.cmd_list=filter(lambda str: str!='', cmd_list)

    def parse_geom(self, group):
        geom=re.split(r'[x+]', self.settings[group]["geom"])
        return "move absolute position {2} {3}, resize set {0} {1}".format(*geom)

    def __init__(self):
        self.cmd_list=[]

        self.settings = {
            'im' : {
                'class' : {
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
                'class' : { 'mpd-pad2' },
                'geom' : "1200x600+400+400",
                'prog': 'st -f "PragmataPro for Powerline:pixelsize=18" -c mpd-pad2 -e ncmpcpp'
            },
            'mutt': {
                'class' : { '' },
                'instance' : { 'mutt' },
                'geom' : "1250x700+293+0",
                'prog' : "st -f \'PragmataPro for Powerline:size=12\' -c mutt -e mutt",
            },
            'ranger': {
                'class' : { 'ranger' },
                'geom' : "1132x760+170+18",
                'prog' : "~/bin/scripts/run_ranger"
            },
            'teardrop': {
                'class' : { 'teardrop' },
                'geom' : "1844x704+39+4",
                'prog' : "st -c teardrop -f \'PragmataPro for Powerline:size=18\' -e ~/bin/scripts/teardrop"
            },
            'console': {
                'class' : { 'youtube-get' },
                'geom': "1339x866+247+13",
                'prog' : "/bin/true",
            }
        }
