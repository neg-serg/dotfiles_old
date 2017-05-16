#!/usr/bin/env python3

import os.path
import socket
from psutil import net_connections
import subprocess
from sys import argv

class wim_runner(object):
    def __init__(self):
        self.settings={
            "use_neovim":True,
            "debug":True,
        }

        self.font="PragmataPro for Powerline"
        self.fsize=20

        self.sock_path=os.path.realpath(os.path.expandvars("$HOME/1st_level/nvim.socket"))
        self.socket_ = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

        self.vim_commands={
            "to_normal": "<C-\><C-N>:call<SPACE>foreground()<CR>",
        }

        self.timeout=0.1

        if self.settings["use_neovim"]:
            self.wim_name="nwim"
        else:
            self.wim_name="wim"

    def dprint(self, debug_string):
        if self.settings["debug"]:
            print(debug_string)

    def print_windows(window, indent):
        children = window.query_tree().children
        for w in children:
            self.dprint(indent, window.get_wm_class())
            print_windows(w, indent+'-')

    def wim_goto(self):
        def there_is(wm_):
            pipe = subprocess.Popen('pidof {}'.format(wm_).split(), stdout=subprocess.PIPE)
            pid, _ = pipe.communicate()
            return pid != b''

        if there_is("notion"):
            self.dprint("there is notion: go to win with it")
            subprocess.Popen(["notionflux", "-e", "app.byclass('', '{}')".format(self.wim_name)], stdout=subprocess.PIPE)
        elif there_is("i3"):
            self.dprint("there is i3: go to win with it")
            subprocess.Popen(["i3-msg", '[instance={}]'.format(self.wim_name), "focus"], stdout=subprocess.PIPE)

    def process_list(timer, *args):
        return

    def eprocess_list(timer, *args):
        return

    def create_wim_server_from_scratch(self):
        subprocess.Popen([
                            "st",
                            "-f",
                            "{}:pixelsize={}".format(self.font, self.fsize),
                            "-c",
                            self.wim_name,
                            "-e" "tmux", "-S", self.sock_path, "new", "-s", "nvim", "-n", "nvim",
                            "nvr", "--servername", "NVIM", "&&", "tmux", "-S", self.sock_path, "switch-client" "-t" "nvim",
                        ], shell=True, stdout=subprocess.PIPE)

    def wim_run(mode, *args):
        if mode == "default":
            proc=process_list
        elif mode == "embedded":
            proc=eprocess_list

        if len(args):
            p = subprocess.Popen('xdotool search --classname {}'.format(self.wim_name).split(), stdout=subprocess.PIPE)
            wid, _ = p.communicate()

            if wid == "":
                self.dprint("creating new {} server").format(self.wim_name)
                self.create_wim_server_from_scratch()
                self.dprint("eval {} proc").format(self.wim_name)
                proc(self.timeout, args)
            else:
                self.dprint("eval {} proc").format(self.wim_name)
                self.create_wim_server_from_scratch()
                proc(self.timeout, args)

    def print_args(self, *args):
        self.dprint(":: printing args ::")
        for arg in args:
            self.dprint(arg)

    def main(self, *args):
        def socket_is_used_():
            return bool(list(filter(lambda i: i.laddr == self.sock_path, conns)) != [])

        def no_approp_win():
            ret_=True

            import redis
            r=redis.StrictRedis(host='localhost', port=6379, db=0)
            count_=(int(r.hmget('count_dict', 'wim')[0]))

            if count_ > 0:
                ret_=False
            return ret_

        try:
            conns=net_connections(kind='unix')
            print(files)
            # x11 window is closed, but tmux connection exists
            if socket_is_used_() and no_approp_win():
                # do not wait for call result
                subprocess.Popen([
                    "st",
                    "-f", "{}:pixelsize={}".format(self.font, self.fsize),
                    "-c", "{}".format(self.wim_name),
                    "-e", "tmux", "-S", self.sock_path, "attach-session", "-d", "-t", "nvim"
                ])
            elif not socket_is_used_():
                self.dprint("let's create tmux+nvim server from scratch")
                self.print_args(args)
                self.create_wim_server_from_scratch()
            elif not len(args) - 1:
                self.dprint("Let's jump to target window")
                self.print_args(args)
                self.wim_goto()
        except Exception as e:
            print("something's wrong. Exception is {}".format(e))
        finally:
            self.socket_.close()

if __name__ == '__main__':
    run_=wim_runner()
    args=argv
    run_.main(args)

# function vim_file_open() (
#     local file_name="$(resolve_file ${line})"
#     file_name=$(bash -c "printf %q '${file_name}'")
#     { vim --servername ${vim_server_name} --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null \
#         || { while [[ $(vim --servername ${vim_server_name} --remote-expr "g:vim_is_started" 2>/dev/null) != "on" ]]; do
#             sleep ${wim_timer}
#         done \
#         && vim --servername ${vim_server_name} --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null } } && {
#         local file_size=$(stat -c%s "${file_name}" 2>/dev/null | \
#                           numfmt --to=iec-i --suffix=B | \
#                           sed "s/\([KMGT]iB\|B\)/$fg[green]&/")
#         local file_length=$(wc -l ${file_name} 2>/dev/null| \
#             grep -owE '[0-9]* '| \
#             tr -d ' ')
#         local sz_msg=$(_zwrap "sz$(_zfg 237)~$fg[white]${file_size}")
#         local len_msg=$(_zwrap "len$(_zfg 237)=$fg[white]${file_length}")
#         local new_file_msg=$(_zwrap new_file)
#         local dir_msg=$(_zwrap directory)
#         local pref=$(_zwrap ">>")
#         if [[ ! -e "${file_name}" ]]; then
#             <<< "${pref} $(_zfwrap ${file_name}) $(_zdelim) ${new_file_msg}"
#         elif [[ -f "${file_name}" ]] && [[ ! -d "${file_name}" ]]; then
#             <<< "${pref} $(_zfwrap ${file_name}) $(_zdelim) ${sz_msg} $(_zdelim) ${len_msg}${syn_msg}"
#         else
#             if [[ -d "${file_name}" ]]; then
#                 if [[ $(readlink -f ${file_name}) == $(readlink -f $(pwd)) ]]; then
#                     <<< "${pref} $(_zfwrap "current dir") $(_zdelim) ${dir_msg}"
#                 else
#                     <<< "${pref} ${fancy_name} $(_zdelim) ${dir_msg}"
#                 fi
#             fi
#         fi
#     }
#     unset file_name
# )

# function process_list() {
#     sleep "$1"; shift
#     while getopts ":b:a:c:" opt; do
#         case ${opt} in
#             a|c) after="${OPTARG}" ;;
#             b) before="${before}${OPTARG}" ;;
#             --) shift ; break ;;
#         esac
#     done
#     shift $((OPTIND-1))
#     [[ ${after#:} != ${after} && ${after%<CR>} == ${after} ]] && after="${after}<CR>"
#     [[ ${before#:} != ${before} && ${before%<CR>} == ${before} ]] && before="${before}<CR>"
#     local cmd="${to_normal}${before}${after}"
#     if [[ ${cmd} == ${to_normal} ]]; then
#         for line; do vim_file_open; done
#     else
#         vim --servername ${vim_server_name} --remote-send "${cmd}"
#         for line; do vim_file_open; done
#     fi
#     unset before; unset after
# }

# function eprocess_list() {
#     wim_goto
#     sleep "$1"; shift
#     for line; do vim --servername ${vim_server_name} --remote-wait "$@"; done
# }

# function v {
#     while read -r arg; do
#         wim_run ${arg[@]}
#     done <<< "$(printf '%q\n' "$@")"
#     wim_goto
# }

# function wim_embed { wim_run "__wim_embed" "$@" }

# function wdiff {
#     local prev_
#     local arg2_
#     # or it's maybe better to use :windo diffthis
#     if [[ $# == 2 ]]; then
#         prev_="$1"
#         wim_run "" && v -b":tabnew" && \
#         { wim_run $1; shift } && v -b":diffthis" && \
#         { v -b":vs" && {
#             if [[ -d $1 ]]; then
#                 arg2_="$1/$(basename ${prev_})"
#             else
#                 arg2_="$1"
#             fi
#             wim_run ${arg2_};
#             shift
#         } && v -b":diffthis" }
#     fi
# }

# function nwim_run(){
#     local proc="nprocess_list"
#     [[ $1 == "__nwim_embed" ]] && {proc="eprocess_list"; shift}
#     local wid=$(xdotool search --classname nwim)
#     if [[ -z "${wid}" ]]; then
#         st -f "${nwim_font}:pixelsize=${nwim_font_size}" -c 'nwim' -e bash -c "tmux -S ${nwim_sock_path} new -s nvim -n nvim \"nvim\" && \
#             tmux -S ${nwim_sock_path} switch-client -t nvim" 2>/dev/null &!
#         eval ${proc} ${nwim_timer} "$@"
#     else
#         eval ${proc} ${nwim_timer} "$@"
#     fi
# }

# function nwim_goto() {
#     if [[ $(pidof notion) && -x $(which notionflux) ]]; then
#         notionflux -e "app.byclass('', 'nwim')" > /dev/null
#     else
#         if [[ -x $(which wmctrl) ]]; then
#             wmctrl -i -a $(wmctrl -l -x|awk '/nwim.nwim/{print $1}')
#         elif [[ -x $(which xdotool) ]]; then
#             xdotool windowfocus $(xdotool search --class nwim)
#         fi
#     fi
# }

# function nvim_file_open() (
#     local file_name="$(resolve_file ${line})"
#     file_name=$(bash -c "printf %q '${file_name}'")
#     { nvr --servername ${HOME}/1st_level/nvim.socket --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null \
#         || { while [[ $(nvr --servername ${HOME}/1st_level/nvim.socket --remote-expr "g:nvim_is_started" 2>/dev/null) != "on" ]]; do
#             sleep ${nwim_timer}
#         done \
#         && nvr --servername ${HOME}/1st_level/nvim.socket --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null } } && {
#         local file_size=$(stat -c%s "${file_name}" 2>/dev/null | \
#                           numfmt --to=iec-i --suffix=B | \
#                           sed "s/\([KMGT]iB\|B\)/$fg[green]&/")
#         local file_length=$(wc -l ${file_name} 2>/dev/null| \
#             grep -owE '[0-9]* '| \
#             tr -d ' ')
#         local sz_msg=$(_zwrap "sz$(_zfg 237)~$fg[white]${file_size}")
#         local len_msg=$(_zwrap "len$(_zfg 237)=$fg[white]${file_length}")
#         local new_file_msg=$(_zwrap new_file)
#         local dir_msg=$(_zwrap directory)
#         local pref=$(_zwrap ">>")
#         if [[ ! -e "${file_name}" ]]; then
#             <<< "${pref} $(_zfwrap ${file_name}) $(_zdelim) ${new_file_msg}"
#         elif [[ -f "${file_name}" ]] && [[ ! -d "${file_name}" ]]; then
#             <<< "${pref} $(_zfwrap ${file_name}) $(_zdelim) ${sz_msg} $(_zdelim) ${len_msg}${syn_msg}"
#         else
#             if [[ -d "${file_name}" ]]; then
#                 if [[ $(readlink -f ${file_name}) == $(readlink -f $(pwd)) ]]; then
#                     <<< "${pref} $(_zfwrap "current dir") $(_zdelim) ${dir_msg}"
#                 else
#                     <<< "${pref} ${fancy_name} $(_zdelim) ${dir_msg}"
#                 fi
#             fi
#         fi
#     }
#     unset file_name
# )
