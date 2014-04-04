zfm
===

2013-02-23 - 22:33 : I've just don't some major refactoring/flow simplifications, and there's a possibility
of the app quitting unexpectedly in some lesser used case. (v0.1.15). 

zsh file explorer/manager for fast navigation and running commands on files or groups of files.

This is a file navigator or explorer that attempts to make as many operations as possible on single keys so that a user can quickly navigate and execute commands. It is hoped that such paths will become second nature.

There are 3 modes:
  * VIM mode - vim motions and actions along with count
  * HINT mode - all files in view have a single key shortcut which invokes the file or enters a dir
  * INS mode - first 9 files are hotkeyed by number. Typing alpha characters filters files reducing the list. This is useful for large lists. 

  It is easy to switch between modes. ESCAPE moves to VIM mode. From vim mode, ";" toggles HINT mode, and "i" goes to INS mode.

The first 9 files or dirs in any view are given hotkeys from 1-9. After that with each successive key the files are reduced. This actually makes file navigation very fast. (This is in INS mode and in HINT mode.) In VIM mode numbers will mean a count. Jump to HINT mode using ; or use count-j or count-k to move and hit ENTER or "o" or "e".

In VIM mode, you can also jump to a file *without* opening it, using "f". This is like EasyMotion and will give the same HINT for each file, but instead of opening it, will position the cursor at that point.

The "," key (lower case of "&lt;") is used to go up directory levels. There are many other shortcuts that allow for other usual operations to be done fast such as accessing favorite directories and files, and navigating deep structures quickly.

Paging of long listings is done using Alt-n and Alt-p (now SPACE pages too, Ctrl-Space selects). 

The motivation of yet another file manager is to automate as many file-related operations as I can: browsing, operating on multiple files, today's files, filtering file lists. I also use ``z``, ``v``, ``vifm``, and various other great utilities. For example, i often run a locate command and then wish to further filter it, or sort on date and then open a file. Or use ack to search files and then open some. These use cases are easy with this utility. 

If I only wish to open a file for editing, it can be easier to type "m" (or whatever alias you use) and hit the shortcut, rather than type "vim abc TAB" etc etc especially if you set ZFM_DEFAULT_MODE to "HINT".

A Quick Session
---------------

You may either place all these files in your $HOME/bin folder (there are internal links to each other). Or place them somewhere in path and set a ZFM_DIR variable to that path.

In your shell, type "zfm.zsh"


If you like it, alias m or some other unused character to ~/bin/zfm.zsh in your shell and later in your .zshrc.

    alias m='~/bin/zfm.zsh'

Now type "m":

The following assumes you are using VIM mode (that is currently the default startup mode). Please check the bottom left (prompt) to see what mode you are in, I have now changed to default to HINT, since I usually want to jump to a file straight, and not navigate. (Use ESC to go to VIM, or hit the leader key twice (backslash)).

(In VIM mode) You can navigate using j and k with count, or gg G , use ENTER or "e" to open a file or directory. ENTER will open the file in your EDITOR, whereas "e" gives you options of various programs to run, or give your own command to run on the file. Multiple files can be opened using "oo" with count, or combinations such as "oG" or "o(count)gg" etc. "x" selects single files.
Use "e" to see a menu of options for that filetype or dir. MENU-1 may also be used to get a set of options for the file. MENU-2 gives options for selected files (such as zipping, searching, diffing, etc).

Note that file numbering in VIM mode is absolute if you type "g" or the last command was a "gg" command. If you use "j" or "k", numbering becomes relative.

If your directory has fewer than 15 files, you should get a long list. Otherwise, you will get 2 or 3 columns with just file names. You can toggle long listing with the toggle key "=" and "l" (Toggle-l).

However, VIM mode is not the fastest mode to open a file that is far away from the cursor. You can press ";" to go to HINT mode and select the shortcut. You can also just jump to a file with "f" and the shortcut. This is like Vimperator's hint mode.


A lot of this documention refers to INS mode which was the default mode prior to my writing the VIM mode. Let's type "i" from VIM mode to go to INS mode.

You should see a listing of your directory with 9 files hot-keyed with numbers and the rest with the first letter.
Press a hotkey. If it is a directory, you will automatically change into it. If its a file, you will get a menu of file options. (As of writing, now we automatically open the file using EDITOR). (MENU -> Options can be used to switch off default open behavior to get a menu).

Let's say you want to navigate to the "tmp" directory. 
Type "t". You will see "t" on the left of your prompt, and the list is filtered to "t*". 
In my case, "tmp" is the 2nd entry so i press 2. If i use this often I only need press "t2" to get to tmp. 
I could also press "tm" and if there is no other entry starting with "tm" we automatically go into "tmp".

You may also press "backspace" to erase the pattern one by one. Please note that the pattern accumulates. Usually a stray untrapped key results in the pattern being cleared completely. Otherwise, the "," (BACK key) will take you a level up and clear the pattern.

Press the ZFM_GOTO_KEY (currently "+" (plus sign)). You are prompted for a path. Type /usr/local/lib, pressing the tab after lo and li. Press ENTER to jump to that directory.

Press "?" to see what keys are available. This should work in menu's too.

Press the colon (":") and type an arbitrary shell command. You can type "q" or "quit" to quit, help or ? should show you some canned actions.

Currently "q" is never mapped to a file, it quits. This is a feature cum bug. I need to find another quit key and release the "q" so the "qt" guys don't sue me :)  (Update: Ctrl-\ always exits without checking any key. Ctrl-Q exits if you are in your default mode, if you are in some other mode, it comes back to default mode.)

Type "/" (slash), now you can edit the pattern for filtering files, without the characters being interpreted as commands. You can type a number (if your file contains a number), or even characters that form a valid grep regex. Press Enter when done.

Sometimes the file you want to select is within view, but is beyond the firt nine. You can toggle to HINT (earlier called FULL_INDEXING) using the ";" character, or using the Toggle Menu Key (=). Now press the character that indexes the file. If the first few characters are common among many files, then this can be very helpful.

*The Menu*

At present I have a menu triggered by pressing the backtick (lower tilde). This could change based on feedback or be configured. It allows seeing file listings, recursive listings, see just the directories in the current dir or jumping to recently used files etc. These views allow multiple selection of files so that actions can be executed on these files.

One example is "ft". After triggering the menu with MENU_KEY, "f" jumps to "File listing" and "t" shows a listing of files modified today.

If you are editing many files, rather than press "v" each time for your EDITOR (in the File Operations menu), select "a" for auto-open and enter your editor name. Now whenever a text file is selected your editor will open it. For other kinds of files, go to Menu => Options and provide the application for major file types.

Users of the autojump utility "z" (brew install z or see github rupa/z), can use MENU-k (backtick k) to see directories from their $HOME/.z database, type in a number to select, or press a couple of keys to drill down to the dir and press ENTER.

Users of vim can use MENU-l or MENU-v, files from your $HOME/.viminfo will be displayed and can be selected. "l" allows single file selection, "v" allows multiple file selection. These 2 features allow you to very quickly jump to dirs or files with a couple of keystrokes. Users of other utilities such as autojump can configure reading dirs from their database in zfmdirs.

If you wish to change the sort order of your listing, try MENU-s. To filter your listings to only files/dirs/links, recent files etc, try MENU-F.

There are some interfaces to ack and ag for viewing files containing some text. MENU-f and MENu-r give you the option to ack for this dir or recursively. File names can then be selected for viewing.

To search for a file in the current heirarchy, press MENU-/ or Alt-/  and enter a pattern. You will see filename containing that pattern and can select one or more for viewing or running a command on.

Press MENU-a to search files containing a string using ack. You can select from the matching file list, the selected files will be opened in VIM at the position of the first match.

To toggle various modes, use the TOGGLE_KEY (default =)  you can switch to "all files", "match from start of filename", "ignore case match", "approximate match" and various others.

###Edge Cases:###

While navigating a directory which has many files with numbers, you may be unable to access certain numbered files. There is a check for numbered files that clash with the numbered hotkey (M_SWITCH_OFF_DUPE_CHECK) that can be set. I have not used this by default just to reduce processing.

Some dirs such as Downloads may contain very long file names containing the same first 10 or 20 characters. In such case, drilling down is tedious. A quicker option is to have HINT Mode. In this all files are indexed using 1-9, then a-zA-Z. However, this is not the default, since the user has to scan the list to see what the hotkey is. I have found that drilling down is much faster -- the first 2 characters of a file or dir often are all we need to get into a dir or get a file.

Other downloaded files may contain funny or unusual characters such as quotes or brackets that i ignore or use for other purposes. Let me know if this is an issue, or use FULL_INDEXING for these cases. Full indexing is available with the TOGGLE_KEY or directly with single quote. You may also use "/" to edit the pattern and use numbers, brackets etc.

###Match from start or anywhere:###

(INS MODE) The default when you type characters is to match from start. If you type "^" anywhere during the command, the match toggles between start and match anywhere in string. Once you start remembering file positions, it helps to always keep in the match-from-start position.

###Matching dot-files###

You can no longer type a dot for matching files in INS Mode. You may either use the TOGGLE KEY (=) to enable hidden files, or use the edit_regex ("/") to add something like ".*" inside a pattern. This way the dot remains consisently for popping directories, just as the comma goes to the parent directory.

###Sorting and Filtering###

You can change the sort order of listings by pressing the ZFM_MENU_KEY (backtick). You can also filter the lists in the menu so you only see today's files or recent files etc whenever you visit a directory.

###Multiple Selection of files###

There are 3 ways of Multiple Selection. One is from the menu: select any file listing or recursive listing and choose the line numbers. Press ENTER when done and chose a command, or enter a command to execute. This way you may zip or move or delete or view multiple files.

The second way is from the file manager itself. There is a toggle key for SELECTION_MODE (currently @). After toggling selection on, any files selected will go into an array. When toggling off, a menu of operations for multiple files appears (zip, move, trash, or enter your own command).

Space bar also allows use to select several files. In Vim mode, "x" selects (toggles) and moves to next file. Currently, "y" is also mapped to selection, yy Y and other combinations such as yG y10gg etc will also work.
The open command "o" can be used to open selected files using the "s" selector, "os". ":file" will also show the options for multiple selection such as vim, vimdiff, git mv, git add etc. "C-o" is also mapped to File Open and will show a menu for selected files. 

The first method from the menu, allows you to select based on a query such as recent files, todays files,
files for an extension etc while keeping the file manager as-is. 

Single files may also be selected or deselected using the Ctrl-Spacebar key while positioned on a file. You can use arrow keys to move around the list. 

### Finding a file based on filename###

This is similar to the `find` command but uses zsh, to find a file given a string. Matches are displayed and can be filtered based on more keys, and files may be selected and edited. Currently, the location of this is MENU-/ or Alt-/. I often find it faster from the prompt to type "m", Alt-/, type in a couple characters of the file name, and then select the file than any other alternative. (If you have Vim open in the right heirarchy, you can always press Ctrl-P which is superior). Similarly using ack/ag or locate from within zfm is often faster than from the prompt if you wish to select files for editing.

###Searching based on file content###

I've interfaced with `ag` and `ack` to provide a list of files from which files may be selected.
MENU-f 9 (ack) searches current dir, MENU-r 9 (ack) searches recursively.

MENU-a now directly uses ack (consequent to some reordering of commands in the menu).

###Using zsh's globbing###

The zsh pattern used for filename globbing may be changed. The default is '*'. Currently, editing this is mapped to "C-e". Note that this pattern persists even after changing directories. You will have to clear it using the same option. You may even change the pattern to "**/*" to get recursive file listing, however try not to do this in your HOME directory, or any directory with thousands of files as it could take a few seconds to generat e a listing.


###Miscellaneous###

There are other keys also mapped to some actions. Will document as i go. and these keys are not fixed yet.

e.g. navigate to a *sibling* directory. Press "[" (square bracket open) to see sibling directories. Select one to jump to it.  

The menu offers directories from the "*dirs*" command. I think this only works if you source the file, otherwise the new shell does not execute .zshrc and do contains a blank "dirs". This helps to jump to oft viewed directories.  

The menu option "filejump" shows files from your .viminfo file, so you can jump to recent files. If you use some other editor, the file zfmfiles can be configured to output recent files from some other source or database.

Provided an option for doing what "*cd OLD NEW*" does. It will offer parts of the current path, select one, and see the alternatives and select the other. Hopes to be faster than typing this on the command line. These things are required for jumping between large project structures.  Need to figure out what key to map it to, currently "]" (square bracket clase).  

Currently, I am using zsh v5.0.x (homebrew OSX Mountain Lion) inside iTerm and tmux.

##Supplying frequent/recent files and directories##

You can interface with your frequent files and directories utilities using `zfmfiles` and `zfmdirs`.
Currently, I use rupa's Z utility, so `zfmdirs` pulls out directory names from the $HOME/.z database.
Similarly, `zfmfiles` lists files from my $HOME/.viminfo file. You can replace the code in these
files to interface with autojump or whatever other utility you use. I'd rather use an existing tool for this that re-invent the same functionality (all these utilities hook into cd or chpwd)

##Bookmarks##

Update: moved bookmark to main folder, since it is integral to quick movement. It is no longer an addon.

If you've got the addons directory correctly located (ZFM_DOTDIR) you should be able to use the bookmark feature. Use the "m" key (Vim mode, Alt-m in all modes) to save locations a to z in each dir. Locations A to Z are across directories. To access the bookmarks use the single quote char. This can be a fast way of moving across the filesystem.

Currently, if you have not set a bookmark for a character, then the cursor moves to the first (or next) file starting with that char. So this is a fast way to jump to another location (in addition to using the "f" key, or going into HINT mode).

##Other addons##

I've just added a preview addon, it prints the first 25 lines of a file on the right side (currently mapped to forward-slash-p (leader-p). The preview gets erase after a key-stroke since the list reprints. It's just something i tried out for fun.

##Issues##

I've tested this out only on OSX Mountain Lion using TERM=screen-256color. I use zsh-5.0.x (latest homebrew).

It's very possible that your arrow keys, function keys, or PgDn/Home/End do not work. You'll have to update the codes for your system in zfm_menu.zsh (init_key_codes). On you command-line, enter C-v and enter the key, that's what you should have in the program. Send me the codes, so i can add them. 

Since I clear the screen prior to printing, an error message thrown up by zsh could get hidden. This rarely happens, usually when I make a change to the code and there's a syntax error (missing bracket, quote etc). This can also happen if some files are missing in your install. The keys will not work. (e.g., j and k will not work in VIM mode). You can scroll up to see the error. I've not found a way of handling zsh's own errors, ideally the program should exit on these errors.

As of 0.1.13, zfm doesn't write to any files or save state. It should do so soon, so visited dirs and files and bookmarks can be used across sessions.

## SAVING CONFIG ##

I have just taken a cautious approach to saving config. This is since one can have multiple instances of zfm running with bookmarks added to each one. First, i do not save upon exit. I also only save if there is already a $HOME/.zfminfo file. So if you want bookmarks saved, then please `touch ~/.zfminfo` else nothing is written. To save you can either give the command `:write` or quit using ":wq" or ":x".

Also, the bookmarks are *appended* to the existing file to prevent multiple sessions from clobbering each other. So you can edit the differences after writing. Local bookmarks are now stored not as positions but as filenames. This means that despite sort order or changes to directory entries the bookmark is gauranteed to get you to the file as long as it exists. ":marks" displays global and local marks.

## Other points ##

* 2013-02-23 - 21:17 : Pressing ":" now will not show the previous command. It will show a blank string just as vim does, you can use the up arrow to get to history, to run previous commands. THis is so the user does not need to clear the line to run a command each time, especially if one is exiting using ":q" or ":wq" or "x".
(Thanks to Bart Shaefer for telling me how to get history working with vared inside a script).
   
   ":p" or ":pwd" will put the current dir into clipboard using `pbcopy`, this in case the user wishes to quit and immediately `cd` to that directory and work there.


##Changes##

* 2013-02-23 - 22:28 : I don't think there are any more feature plans, only bug-fixes or tweaks.
I'll be using the HINT mode as my default and seeing how it goes. I'll keep my eyes open for faster ways of navigating or doing stuff in HINT mode.

A summary of version-wise changes. 

(not updated for a long time, too many changes and additions)

###0.1.8###

    * since about 0.1.7 a VIM mode has been introduced. Check bindings to see how to enter it.
    Currently Leader-z (\-z). You can run your favorite "gg" "12j", "k", "gh", "o" etc.
    Most mapping are from vim. I am taking some shortcuts from Vimperator such as "f" for hints 
    (full index toggling in our case), some from gmail ("o" for opening file under cursor, "x"
    for toggling selection), and some from vifm ("gh" goto parent dir).

    I've made the earlier default mode into INS mode (in which as you type filtering happens). 
    However, those of us used to vim cannot stop typing j and k.

    I am working out the MODE thing. Should vim shortcuts just be an addition to the existing mode (as in gmails web interface), or should it totally replace the same. At present, I am trying to ensure that VIM mode still respects the earlier 
    mappings so one does not need to learn a new set of mapping from those in the earlier mode. Should be able to move effortlessly between INS and VIM mode.

###0.1.1###

	*  Trying to not print if no change, like an unused key -- actually that's 
    not a big deal for the change. However, it has resulted in changing when screen
    clearng happens, so that the read is always in one place. This may actually be neater
    but debug statements and errors get cleared. User will have to scroll up to check.

	*  More importantly, I've broken arrow key stuff into an addon, and i am
    sourcing addons. You can use arrow keys go up dirs, or pop back, or go into dirs
    and of course to traverse the displayed list.
    Pressing ENTER on a file will bring up the options for the file.

###0.1.0###

    * Putting filetypes in datastructures along with menu options so user can modify or override
    Similarly, items can be defined to map to a command or set of commands which can take user
    input through interpolation.

    This is alpha, changes a lot and is being tested out. This was required since users will have different prefs of what executables or commands they like to run with which extensions.

###0.0.2###

    Too many small changes to document. You can see the git log or tags listing for details.

    * you can select single or multiple files in all views (except for directory listings). Press ENTER
    for finishing selection, ESCAPE to cancel.

###0.0.1w###

    * fuzzyselectrow allows multiple selection too, on pressing ENTER
      Trying to standardize the select to one only - currently the select single 
      and multiple is a bit confusing. 

###0.0.1t###
    
    * display size and mtime if 15 rows only
    * filter for showing links (MENU F(ilter) LINKS)
    * pressing Enter in listing selects first item

###0.0.1r###

    * (In fuzzy search ) Enter selects during dir and file searches (BACKTICK k and BACKTICK l).
    This is like using Control-P or Control-P. Automatic selection as you
    type keys was dangerous.

###0.0.1o###

    * Selected items are bold faced

###0.0.1m###

    * Quick selection of recent files using sort of fuzzy matching. Earlier one had to 
    select based on row number.  MENU_KEY + l (select one), MENU_KEY + v (select multiple based on line numbers).

###0.0.1l###

    * Quick selection of directories to jump to through menu (backtick - k). This 
    picks up database from "z"'s database. Filters dirs as you type and goes into 
    first unique match.

###0.0.1k###

    * Added zfmcommands.zsh so user can add own menu and commands which will
    be picked up in when one presses $MENU_KEY (default backtick) + "c".

###0.0.1j###

    * Changed some file names to zfm prefix

###0.0.1i###

    * interface with `z` utility and `viminfo` through zfmdirs and zfmfiles.

###0.0.1g###

    * auto-editing on selection AUTO_TEXT_ACTION etc
    * do not clear pattern on selection, allow it to persist, clear when dir changed

##Installation##

You can either run this as an external application in its own shell or source the file. I suggest NOT sourcing it in the beginning.

Advantages of sourcing:

- you can navigate to a directory and when you exit, you remain in that directory 
- able to use "dirs" command to select recently used directories
- changes in preferences will remain in effect when you run zfm again. 

Disadvantages:

- in some cases I have changed a setting such as GLOB_DOTS which could affect your
  environment if you expect it to be off. I will try removing that soon.
- There are variables that are not local that will pollute your shell

Advantages of not sourcing:
- When you exit you remain where you were (you may want this)
- Any changes to environment do not affect your shell

Disadvantage:

- Unable to use "dirs" command to get frequent directories.
- Preferences changed will not be saved (I am not using any config
file at present)


If you want to source the zfm.zsh file then you must remove the last line which calls myzfm.
Now you can put this in your .zshrc:

    source ~/bin/zfm.zsh
    alias m=myzfm

*************************************************

Please use and give feedback. How can navigation be made faster / easier. 
What common use cases have i missed?
(I am new to zsh, btw. Please point me to links on advanced zsh scripting).

