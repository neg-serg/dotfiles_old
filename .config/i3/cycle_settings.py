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
                'priority':'mpv',
            },
            'doc':{
                'classes': {
                    'Zathura',
                },
            },
        }
