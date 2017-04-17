#!/usr/bin/env python3

import os.path
import socket
from psutil import net_connections
import subprocess

def printWindowHierrarchy(window, indent):
    children = window.query_tree().children
    for w in children:
        print(indent, window.get_wm_class())
        printWindowHierrarchy(w, indent+'-')

class wim_runner(object):
    def __init__(self):
        self.font="PragmataPro for Powerline"
        self.fsize=20
        self.sock_path=os.path.realpath(os.path.expandvars("$HOME/1st_level/nvim.socket"))
        self.socket_ = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

    def main(self):
        def socket_is_used_():
            return bool(list(filter(lambda i: i.laddr == self.sock_path, conns)) != [])

        def no_approp_win():
            name_="circled"
            fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/'+name_+'.fifo'))

            with open(fifo_,"w") as fp:
                fp.write("info wim\n")

            import redis
            r=redis.StrictRedis(host='localhost', port=6379, db=0)
            count_=int(r.get('count'))
            if count_ > 0:
                r.delete('count')
                return False

            r.delete('count')
            return True

        try:
            conns=net_connections(kind='unix')
            # x11 window is closed, but tmux connection exists
            if socket_is_used_() and no_approp_win():
                # do not wait for call result
                subprocess.Popen([
                    "st",
                    "-f", "{}:pixelsize={}".format(self.font, self.fsize),
                    "-c", "nwim",
                    "-e", "tmux", "-S", self.sock_path, "attach-session", "-d", "-t", "nvim"
                ])
            else:
                # let's create tmux+nvim server from scratch
                print("lets the butthurt flow through you!")
        except Exception as e:
            print("something's wrong. Exception is {}".format(e))
        finally:
            self.socket_.close()

if __name__ == '__main__':
    run_=wim_runner()
    run_.main()

