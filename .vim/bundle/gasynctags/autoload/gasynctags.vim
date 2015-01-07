python << endpython
import subprocess
import os.path

def start_update_tags():
    if hasattr(start_update_tags, 'proc') and start_update_tags.proc.poll() is None:
        return
    
    with open(os.devnull, 'w') as shutup:
        if os.path.isfile('GTAGS'):
            args = [vim.vars['gasynctags_global_exe'], "-u"] 
            start_update_tags.proc = subprocess.Popen(args, stdout = shutup, stderr = shutup) 
endpython


fun! gasynctags#Enable()
    if exists("s:gasynctags_enabled")
        return
    endif

    augroup GasyncTagsEnable
        au!
        au BufWritePost * py start_update_tags()
    augroup END

    py start_update_tags()

    let s:gasynctags_enabled = 1
endf

fun! gasynctags#Disable()
    au! GasyncTagsEnable

    silent! unlet s:gasynctags_enabled
endf
