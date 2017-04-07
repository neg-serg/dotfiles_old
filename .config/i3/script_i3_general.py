import i3ipc
from subprocess import check_output

i3 = i3ipc.Connection()

def find_visible_windows(windows_on_workspace):
    visible_windows = []
    for w in windows_on_workspace:
        try:
            xprop = check_output(['xprop', '-id', str(w.window)]).decode()
        except FileNotFoundError:
            raise SystemExit("The `xprop` utility is not found!"
                            " Please install it and retry.")
        if '_NET_WM_STATE_HIDDEN' not in xprop:
            visible_windows.append(w)

    return visible_windows

def get_windows_on_ws():
    return filter(
        lambda x: x.window,
        i3.get_tree()
        .find_focused()
        .workspace()
        .descendents()
    )
