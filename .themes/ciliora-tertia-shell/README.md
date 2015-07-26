###A theme for gnome-shell _3.16_

---

####Installation

Put the `Ciliora-Tertia` folder into your `~/.themes` directory.

Install the user-themes extension and apply the theme in gnome-tweak-tool.

---

####Login Screen Theme

To apply this theme to your login screen, move the `gnome-shell-theme.gresource` file into `usr/share/gnome-shell` and restart gnome-shell.

__*Make sure that you backup the previous file before doing this!*__

__*Be very careful when doing this! You could potentially break GDM and have a hard time logging back in if you screw up.*__

---

####Tips

* To get rid of the overview background pattern, edit the gnome-shell.css file at selector `#overview`.

* To remove/change the activities icon, edit the gnome-shell.css file at selector `#panelActivities`. If you don't want to use an icon here, just get rid of that selector. The `menu-icons` folder contains a bunch of icons that you can try. :smile:

* To increase the max height of the calendar popup, edit the gnome-shell.css file at selector `#calendarArea`.

---

####Using sass

This theme is written using the css preprocessor [sass](http://sass-lang.com/).


In case you want to contribute code or report a bug, please report against the relevant sass file and **_not_** the css file!

---

In order to install/use sass:

* [Install ruby.](https://www.ruby-lang.org/en/documentation/installation/)

* [Install bundler.](http://bundler.io/#getting-started) (Used to ensure we run the same version of sass.)

* To install sass using bundler, run `bundle install` in the directory where the Gemfile is.

* Run the `parse-sass.sh` script.

* The script will compile sass and run a sass watch. [For more info check the sass docs.](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#using_sass)
