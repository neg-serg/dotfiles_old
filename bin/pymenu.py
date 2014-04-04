#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
Script:       pymenu
Version:      1.3
Author:       Michel Lavoie
Date:         2013-03-20
Description:  1.0 (2013-03-20)
             This script generates an application menu with dmenu from the
             *.desktop files in /usr/share/applications, sorted by category.
             It is meant to complement i3's base menu (which doesn't list
             applications by category).
             1.1 (2013-03-20)
             Added requirements.
             1.2 (2013-03-20)
             Added a filter to consider only files ending in *.desktop.
             1.3 (2013-03-20)
             Added a filter to remove '%' arguments from 'Exec' statements.
Requirements: python3
             dmenu2
"""

import os, sys, sqlite3, configparser
import subprocess as sub

# Configuration
desktop_path = '/usr/share/applications/'
lines = 20
width = 200

#==============================================================================
# Class:       Dbapps
# Description: Wrapper for the Sqlite3 database containing the installed
#              applications references.
#==============================================================================
class Dbapps:
    def __init__(self, dbase_path):
        self.path = dbase_path
        if os.path.exists(self.path):
            self.conn = sqlite3.connect(self.path)
            self.cursor = self.conn.cursor()
        else:
            self.rescan()

    def close(self):
        self.cursor.close()

    # Re-create the database and rescan the *.desktop files
    def rescan(self):
        try:
            os.remove(self.path)
        except FileNotFoundError:
            pass
        self.conn = sqlite3.connect(self.path)
        self.cursor = self.conn.cursor()

        self.cursor.executescript("""
                                 CREATE TABLE apps
                                 (
                                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                                  name TEXT NOT NULL UNIQUE,
                                  comment TEXT,
                                  path TEXT
                                 );

                                 CREATE TABLE cats
                                 (
                                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                                  name TEXT NOT NULL UNIQUE
                                 );

                                 CREATE TABLE app_cat
                                 (
                                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                                  app INTEGER,
                                  cat INTEGER
                                 )
                                 """)

        applications = os.listdir(desktop_path)
        config = configparser.RawConfigParser()

        #print(applications)
        for app in applications:
            if app[-8:] == '.desktop':
                #print('***', app, '***')
                config.read(os.path.join(desktop_path, app))

                try:
                    n = config['Desktop Entry']['Name'].capitalize()
                    p = config['Desktop Entry']['Exec'].split('%')[0]
                except KeyError:
                    #print('KeyError:', app)
                    continue

                try:
                    c = config['Desktop Entry']['Comment'].capitalize()
                except KeyError:
                    c = ''

                try:
                    categories = config['Desktop Entry']['Categories'].split(';')
                except KeyError:
                    categories = ('Uncategorized',)

                #print('Adding', n)
                self.cursor.execute("""INSERT OR IGNORE INTO apps
                                   (name, comment, path) VALUES
                                   (?, ?, ?)""",
                                    [n, c, p])

                qry = self.cursor.execute("""SELECT id FROM apps
                                         WHERE name=?""",
                                          [n])
                app_id = qry.fetchone()[0]

                for cat in categories:
                    if len(cat):
                        c = cat.capitalize()
                        #print('Adding', cat)
                        self.cursor.execute("""INSERT OR IGNORE INTO cats
                                           (name) VALUES
                                           (?)""",
                                            [c])

                        qry = self.cursor.execute("""SELECT id FROM cats
                                                 WHERE name=?""",
                                                  [c])
                        cat_id = qry.fetchone()[0]

                        #print('Adding', app, cat)
                        self.cursor.execute("""INSERT OR IGNORE INTO app_cat
                                           (app, cat) VALUES
                                           (?, ?)""",
                                            [app_id, cat_id])
        self.conn.commit()

    # Return all categories, sorted by name
    def get_cats(self):
        qry = self.cursor.execute("""SELECT name FROM cats ORDER BY name""")
        return qry.fetchall()

    # Return all applications, sorted by name
    # If 'cat' is specified only the applications in this category are returned
    def get_apps(self, cat=None):
        if cat is None:
            qry = self.cursor.execute("""SELECT * FROM apps ORDER BY name""")
        else:
            qry = self.cursor.execute("""SELECT * FROM apps
                                     LEFT OUTER JOIN app_cat ON app=apps.id
                                     LEFT OUTER JOIN cats ON cats.id=cat
                                     WHERE cats.name=?
                                     ORDER BY apps.name""",
                                      [cat])
        return qry.fetchall()

    # Count the number of applications
    # If 'cat' is specified only the applications in this category are returned
    def count_apps(self, cat=None):
        if cat is None:
            qry = self.cursor.execute("""SELECT * FROM apps ORDER BY name""")
        else:
            qry = self.cursor.execute("""SELECT * FROM apps
                                     LEFT OUTER JOIN app_cat ON app=apps.id
                                     LEFT OUTER JOIN cats ON cats.id=cat
                                     WHERE cats.name=?
                                     ORDER BY apps.name""",
                                      [cat])
        return len(qry.fetchall())

    # Get the 'Exec' statement from the *.desktop file
    def get_path(self, app):
        qry = self.cursor.execute("""SELECT path FROM apps
                                 WHERE name=?""",
                                  [app])
        return qry.fetchone()[0]

#==============================================================================
# Class:       Dmenu
# Description: Wrapper around dmenu which generates the application menus with
#              the information stocked in the Dbapps class and handles dmenu
#              itself.
#==============================================================================
class Dmenu:
    def __init__(self, dbase_path, lines=lines, width=width):
        self.db = Dbapps(dbase_path)
        self.populate()
        self.options = ' -i -b -l ' + str(lines) + ' -w ' + str(width)

    # Run dmenu with the appropriate input/options
    def run(self):
        p = sub.Popen('echo "' + self.menu['main'][:-1] + '" | dmenu' + self.options,
                      shell=True,
                      stdout=sub.PIPE,
                      stderr=sub.PIPE,
                      universal_newlines=True)
        submenu = p.communicate()[0].strip('\n')

        if len(submenu):
            if submenu == 'Refresh menu':
                self.db.rescan()
            else:
                p = sub.Popen('echo "' + self.menu[submenu][:-1] + '" | dmenu' + self.options,
                              shell=True,
                              stdout=sub.PIPE,
                              stderr=sub.PIPE,
                              universal_newlines=True)
                selection = p.communicate()[0].strip('\n')

                if len(selection):
                    path = self.db.get_path(selection)
                    p = sub.Popen(path, shell=True)

    # Generate the main menu and submenus
    def populate(self):
        self.menu = dict()
        cats = self.db.get_cats()
        self.menu['main'] = str()
        for cat in cats:
            self.menu['main'] += str(cat[0]) + '\n'
            self.menu[str(cat[0])] = str()
            for app in self.db.get_apps(cat[0]):
                self.menu[str(cat[0])] += str(app[1]) + '\n'
        self.menu['main'] += 'Refresh menu\n'

# Main stuff that happens when the script is called...
try:
    dbase_path = os.path.join(os.getenv('HOME'), '.pymenu.db')
    dmenu = Dmenu(dbase_path=dbase_path)
    dmenu.run()
finally:
    dmenu.db.close()

