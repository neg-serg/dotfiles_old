#!/usr/bin/env python3
import Xlib.threaded
import Xlib
import Xlib.display
from Xlib import Xatom, X
import i3ipc.i3ipc as i3ipc
import subprocess
import colorsys
import random

i3ipc.WorkspaceEvent = lambda data, conn: data
i3ipc.GenericEvent = lambda data: data
i3ipc.WindowEvent = lambda data, conn: data
i3ipc.BarconfigUpdateEvent = lambda data: data
i3ipc.BindingEvent = lambda data: data
i3ipc.Con = lambda data, parent, conn: data
i3 = i3ipc.Connection()

backgrounds = {}
colors = {}

c = {
	"i3.focused.bdr":   (0.50, 0.60),
	"i3.focused.bg":    (0.66, 0.47),
	"i3.focused.ind":   (0.81, 0.96),
	"i3.ifocused.bdr":  (0.00, 0.20),
	"i3.ifocused.bg":   (0.10, 0.42),
	"i3.ifocused.ind":  (0.10, 0.31),
	"i3.unfocused.bdr": (0.00, 0.20),
	"i3.unfocused.bg":  (0.00, 0.13),
	"i3.unfocused.ind": (0.10, 0.02),
	"i3.bar.bg":        (0.00, 0.14),
	"i3.bar.text":      (0.00, 0.86),
	"i3.bar.sep":       (0.00, 0.40),
}

def hsv2rgb(h, s, v):
	rgb = colorsys.hsv_to_rgb(h % 1, s % 1, v % 1)
	return int(rgb[0] * 0xFF) << 16 | int(rgb[1] * 0xFF) << 8 | int(rgb[2] * 0xFF)

def mkrand(seed):
	seed = sum(map(ord, seed), 29)
	rand = random.Random(seed)
	hue = rand.random()
	return hue, rand

def change_workspace(name):
	display = Xlib.display.Display()
	screen = display.screen()
	root = screen.root

	w, h = screen.width_in_pixels, screen.height_in_pixels

	if (name, w, h) not in backgrounds:
		hue, rand = mkrand(name)
		backgrounds[name, w, h] = gen_bg(root.create_pixmap(w, h, screen.root_depth), hue, rand)
	id = backgrounds[name, w, h].id
	root.change_property(display.get_atom("_XROOTPMAP_ID"), Xatom.PIXMAP, 32, [id])
	root.change_property(display.get_atom("ESETROOT_PMAP_ID"), Xatom.PIXMAP, 32, [id])
	root.change_attributes(background_pixmap=id)
	display.sync()

	if name not in colors:
		hue, rand = mkrand(name)
		colors[name] = gen_colors(hue)
	proc = subprocess.Popen(["xrdb", "-merge"], stdin=subprocess.PIPE)
	proc.communicate(input=colors[name].encode())
	proc.wait()
	i3.command("reload")

def gen_bg(pixmap, hue, rand):
	from scipy.spatial import Voronoi
	geom = pixmap.get_geometry()
	w, h = geom.width, geom.height

	border = [(w // 2, 0 - h), (w // 2, h + h), (0 - w, h // 2), (w + w, h // 2)]
	points = [(rand.random() * w, rand.random() * h) for _ in range(160)]
	vor = Voronoi(border + points)
	polys = [[(int(v[0]), int(v[1])) for v in vor.vertices[region]] for region in vor.regions]

	def randcolor(rand, hue):
		h = (rand() * 2 - 1) / 360 * 12
		s = rand() * 0.8 + 0.2
		v = rand() * 0.8 + 0.2
		return hsv2rgb(hue + h, s, v)

	paint = pixmap.create_gc()
	for verts in polys:
		paint.change(foreground=randcolor(rand.random, hue))
		pixmap.fill_poly(paint, X.Convex, X.CoordModeOrigin, verts)
	return pixmap

def gen_colors(hue):
	colormap = []
	for k, (s, v) in c.items():
		colormap.append("%s:#%06X" % (k, hsv2rgb(hue, s, v)))
	return "\n".join(colormap)

for output in i3.get_outputs():
	if output["current_workspace"]:
		change_workspace(output["current_workspace"])


def workspace_event(i3, evt):
	if evt["change"] != "focus":
		return
	change_workspace(evt["current"]["name"])
i3.on("workspace", workspace_event)
i3.subscriptions = 0xFF
i3.main()
