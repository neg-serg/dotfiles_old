#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>

int main(void) {
    XEvent e;
    Display *disp = XOpenDisplay(NULL);

    if (!disp) return EXIT_FAILURE;

    XQueryPointer(disp, RootWindow(disp, DefaultScreen(disp)), &e.xbutton.root,
                  &e.xbutton.window, &e.xbutton.x_root, &e.xbutton.y_root,
                  &e.xbutton.x, &e.xbutton.y, &e.xbutton.state);
    printf("%d %d\n", e.xbutton.x, e.xbutton.y);
    XCloseDisplay(disp);
    return EXIT_SUCCESS;
}
