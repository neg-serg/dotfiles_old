#!/usr/bin/env python3
class cycle_settings(object):
    settings={}

    def __init__(self):
        self.settings = {
            'web' : {
                'classes' : {
                    'Firefox',
                    'Tor Browser',
                    'Chromium',
                },
                'prog':"firefox",
                'priority':'Firefox',
            },
            'vid':{
                'classes': {'mpv'},
                'priority':'mpv',
                'usual_fullscreen':True,
            },
            'steam':{
                'classes': {
                    'wine',
                    'dota2',
                    'darkest.bin.x86_64',
                    'Steam',
                    'steam',
                },
                'prog':"steam",
            },
            'doc':{
                'classes': {
                    'Zathura',
                },
            },
            'vm':{
                'classes': {
                    'VirtualBox',
                    'vmware'
                },
            },
            'term':{
                'classes': { 'MainTerminal' },
                'instances': { 'MainTerminal' },
                'prog':"~/bin/term",
            },
            'wim':{
                'classes': { '' },
                'instances': { 'nwim', 'wim' },
                'prog':"~/bin/nwim",
            },
            'jetbrains-idea':{
                'classes': {
                    'jetbrains-idea',
                    'clion',
                    'andrond-studio',
                },
                'prog':"~/bin/scripts/jetbrains.sh idea",
            },
            'jetbrains-clion':{
                'classes': {
                    '^jetbrains-jetbrains-idea.*',
                    '^jetbrains-clion.*',
                    '^jetbrains-andrond-studio.*',
                },
                'prog':"~/bin/scripts/jetbrains.sh clion",
            },
        }
