import subprocess
import re


HLWM_FONT=b"-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"
HLWM_NB_COLOR=b"#000000"
HLWM_NF_COLOR=b"#ffffff"
HLWM_SB_COLOR=b"#9fbc00"
HLWM_SF_COLOR=b"#000000"

DMENU_OPTS=[b"-b",
  b"-fn", HLWM_FONT,
  b"-nb", HLWM_NB_COLOR,
  b"-nf", HLWM_NF_COLOR,
  b"-sb", HLWM_SB_COLOR,
  b"-sf", HLWM_SF_COLOR]

def hc(*args):
    process = subprocess.Popen(["herbstclient"] + list(args), stdout=subprocess.PIPE)
    return process.communicate()[0]


def run_dmenu(menu, *args):
    """ Run dmenu
        args : args passed to dmenu
        menu: list of possible choices
    returns the selected choice


    """
    process = subprocess.Popen(["dmenu"] + DMENU_OPTS + list(args),
        stdout=subprocess.PIPE,
        stdin=subprocess.PIPE)
    process.stdin.write(b"\n".join(menu)+b"\n")
    out = process.communicate()[0]
    return out.strip()


def list_all_tags():
    tags = hc("tag_status")
    return [x[1:] for x in tags.split()]

def list_empty_tags():
    tags = hc("tag_status")
    return [x[1:] for x in tags.split() if x.startswith(b".")]

def id2name(win_id):
    process = subprocess.Popen(["xprop", "-id", win_id, "WM_NAME"],
        stdout=subprocess.PIPE)
    out = process.communicate()[0]
    return out.split(b"=")[1].strip()

def names2tag():
    res = dict()
    for tag in list_all_tags():
        ids = hc("dump", tag)
        ids = re.findall(b"0x\w+", ids)
        for id in ids:
            name = id2name(id)
            res[name] = tag
    return res
