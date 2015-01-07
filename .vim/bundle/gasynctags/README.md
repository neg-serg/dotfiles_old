# Clighter: Plugin to automatically setup Gnu Global for Vim
## Intro
gasynctags is a vim plugin that can generate the tag(by Gnu Global) for vim
automatically and add the generated tag to vim cscope database. Because
generating the tag for a big project will take very long time, gasynctags
calls gnu global in background to eliminate performance down of vim.

gasynctags provides the following features:

    * Automatically generates tag asynchronously.
    * Setup convenient key maps and wrapper function to call cscope functions of vim 

## Requirements

The gasynctags plugin requires the following:

* Vim version 7.x(or above) with python2 enabled
* Gnu Global

gasynctags currently works only at linux platform, others have not been tested.

## Options

### g:gasynctags_autostart
gasynctags will automatically start with Vim if set g:gasynctags_autostart to `1`,
otherwise, you have to manually start gasynctags by GasynctagsEnable command.

Default: `1`
```vim
let g:gasynctags_autostart = 0
```

### g:gasynctags_gtags_exe
gasynctags use $PATH/gtags as the executable file of gnu gtags if
gasynctags_gtags_exe is `''`

Default: `''`
```vim
let g:gasynctags_gtags_exe = '/opt/gtags'
```

### g:gasynctags_global_exe
gasynctags use $PATH/global as the executable file of gnu global if
gasynctags_global_exe is `''`

Default: `''`
```vim
let g:gasynctags_global_exe = '/opt/global'
```
### g:gasynctags_gtags_cscope_exe
gasynctags use $PATH/gtags-cscope as the executable file of gnu gtags-global
if gasynctags_gtags_cscope_exe is `''`

Default: `1`
```vim
let g:gasynctags_gtags_cscope_exe = '/opt/gtags-cscope'
```

## Commands
gasynctags provides command to control it

## Enable gasynctags
	`GasynctagsEnable`

## Disable gasynctags
	`GasynctagsDisable`
