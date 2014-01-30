-- Adapted from look_brownsteel.lua
-- CME: oh, specifying iso8859 encoding seems to fix the problem with helvetica.
-- CME: modified for legible fonts (helvetica at 14 pixels gets garbled on certain X servers: Xlib problem?); not many large bitmap X fonts to choose from, but aqui seems respectable enough.
-- clean 16-pixel?
-- tradegothic?
-- Dammit, why does aqui keep on not working?
-- Oh, artwiz-aleczapka-en provides a replacement package that fixes some problems with artwiz.  Works!  Also adds ISO-8859 encoding.
-- Available border styles for border_style: "elevated", "inlaid", "ridge", "groove"
-- CME: TODO: try to figure out how not to put any border frame on the dock (in case I even get gnome-/ROX-panel working nicely with ion3).
-- Note: Ion3 will (optionally) save the look setting in the default session settings, e.g. ~/.ion3/default-session--0/look.lua (in case you're wondering where the look setting comes from normally!).
-- To investigate: "actnotify", "stdisp".
-- 
--[[
frame
stdisp
stdisp-statusbar
--]]
--
-- Oh, note that you can set transparent_background = true for frames, and the X root window will show through.  Try xsetroot -solid green to see it!  Also, note that Ion3 stipples tabs being dragged with the X root window contents.  Also(!), note that transparent areas on the scratchpad workspace show the root window, not whatever windows appear to be behind the frame.


if not gr.select_engine("de") then return end

de.reset()


-- Some colour utilities (for generating bevelled colour schemes) and colour definitions:
dopath("colour_utils")
dopath("colours")
-- The ability to combine table properties (a la set/relational union) is handy (I'm surprised Lua doesn't have a built-in thing for this):
dopath("union")


-- Overall default colour scheme:
-- (what we'll want to be able to do is put these in a separate file and just include a scheme from here)
-- Should these be RGB strings or "color" library color objects?  Does it matter, since they're stringifiable?
-- style_colour I'll call the default standard fall-back-to background colour for anything.
local style_colour = ion3_grey
--local style_foreground_colour = colors.new("#C0C0C0")	-- I think we kind of have to define foreground (text) colours explicitly.  NOTE: this is currently not used!  bevelled_colours() determines the foreground colour automatically.  Which might be fine if it did a better job.  Which now it does.  (!)  So now we don't defined the foreground colours separately at all.  Simpler, but less control.  Blah.
local style_selected_colour = ibm_blue  -- This is for selected items (very dark colours don't work properly yet)
local style_alert_colour = ion3_alert_red
local style_modal_colour = beos_yellow


-- Extra derived individual colours:
--local style_selected_colour = colour_style_active.background_colour

-- These may no longer be necessary (use style_colour_scheme.XX_colour instead):
local style_background_colour = bevelled_colours(style_colour).background_colour
--local style_foreground_colour = bevelled_colours(style_colour).foreground_colour	-- Foreground colour now defined explicitly above.
local style_highlight_colour = bevelled_colours(style_colour).highlight_colour
local style_shadow_colour = bevelled_colours(style_colour).shadow_colour

-- If anything, we should have a table that defines these (save a little processing)
-- Again, should the colour components be RGB hex strings or "color" objects?  For ease of use with Ion, make them RGB hex strings.
-- NOTE: background_colour for many objects actually affects what you might think is the padding!
-- With my colour utility functions, this is now very easy (and parameterised):
local style_colour_scheme = bevelled_colours(style_colour)


-- Some font definitions: main ones that would be reused would be default global font, fixed font, window title font, and menu font.

-- Some basic font aliases first:
local aqui = "-screwtop-aquitweaked-medium-r-bold-*-10-*-*-*-*-*-*-*"
local lucidaterminal = "-*-lucidaterminal-bold-r-normal-*-10-*-*-*-*-*-*-*"
local helvetica = "-*-helvetica-medium-r-normal-*-14-*-*-*-*-*-iso8859-*"

local style_font_general = aqui
--local style_font_general = "-screwtop-charcoal-medium-r-normal-*-12-*-*-*-*-*-*-*"
--local style_font_fixed = "-screwtop-lucy-medium-r-normal--12-120-75-75-p-69-macroman-1"	-- From work
local style_font_fixed = lucidaterminal
-- "-*-fixed-bold-r-normal-*-18-*-*-*-*-*-*-*",
-- "-*-helvetica-medium-r-normal-*-14-*-*-*-*-*-iso8859-*",
-- "-*-aqui-medium-r-normal-*-13-*-*-*-*-*-*-*",
local style_font_title = style_font_general
--local style_font_title = "-screwtop-aquitweaked-medium-r-bold--11-110-75-75-p-90-iso8859-1"
--local style_font_title = "-artwiz-aqui-medium-r-bold--11-110-75-75-p-90-iso8859-1"
--local style_font_title = "-*-helvetica-bold-r-*-*-11-*-*-*-*-*-*-*"
--local style_font_menu = "-*-helvetica-bold-r-*-*-14-*-*-*-*-*-*-*"
local style_font_menu = style_font_general
--local style_font_menu = "-screwtop-aquitweaked-medium-r-bold--11-110-75-75-p-90-iso8859-1"
--local style_font_menu = "-*-helvetica-medium-r-normal-*-11-*-*-*-*-*-iso8859-*"
--local style_font_menu = "-screwtop-lucy-*-*-*-*-*-*-*-*-*-*-*-*"

-- Other fonts to sort out:
--	font = "-*-lucidaterminal-bold-r-normal-*-10-*-*-*-*-*-*-*",
--	font = "-*-fixed-bold-r-normal-*-18-*-*-*-*-*-*-*",
--	font = "-*-helvetica-medium-r-normal-*-14-*-*-*-*-*-iso8859-*",
--	font = "-*-aqui-medium-r-normal-*-13-*-*-*-*-*-*-*",
--	font = "-*-tradegothic-medium-r-condensed-*-18-*-*-*-*-*-*-*",
--	font = "-*-lucidaterminal-bold-r-normal-*-10-*-*-*-*-*-*-*",
--	font = "-*-fixed-bold-r-normal-*-18-*-*-*-*-*-*-*",
--	font = "-*-aqui-medium-r-normal-*-13-*-*-*-*-*-*-*",	--borken somehow
--    font = "-artwiz-aqui-medium-r-bold--11-110-75-75-p-90-iso8859-1",
--	font = "aqui",
--	font = "-*-helvetica-medium-r-normal-*-12-*-*-*-*-*-iso8859-*",
--	font = "-artwiz-aqui-medium-r-normal--13-130-75-75-p-120-*",
--	font = "-*-aqui-medium-r-normal-*-13-*-*-*-*-*-iso8859-*",
--	font = "-*-tradegothic-medium-r-condensed-*-18-*-*-*-*-*-*-*",
--	font = "-*-lucidaterminal-bold-r-normal-*-10-*-*-*-*-*-*-*",
--	font = "-*-fixed-bold-r-normal-*-18-*-*-*-*-*-*-*",

-- Root style; does this even have a padding_colour?  I think most of the colour things make more sense to be defined at the frame or tab level.
de.defstyle("*", union(style_colour_scheme, {
	padding_pixels = 4,
	highlight_pixels = 1,
	shadow_pixels = 1,
	border_style = "elevated",
	font = style_font_general,
	text_align = "center",
}))


de.defstyle("frame", union(style_colour_scheme, {
	based_on = "*",

--	transparent_background = true,	-- This could be a reasonable alternative to a black background.  You could always set the X root window to black, anyway.
	background_colour = "black",	-- This is the primary window background (used when the window frame is larger than the client window extent).

	-- I think padding_pixels is just for floating frames.
	padding_pixels = 4,
	highlight_pixels = 2,
	shadow_pixels = 2,
}))


-- I think floating frames ought to have bigger borders so that they can be resized more easily.
-- It looks a bit "clunky" but form follows function, dammit! :)
de.defstyle("frame-floating", {
	based_on = "frame",
	bar = "outside",
	padding_pixels = 6,	-- 8 is maybe TOO big and friendly. :)
	border_style = "ridge",
	spacing = 1,
	-- Why is the following not working?:  maybe substyles don't work for "frame-floating"?
--	de.substyle("*-active-selected", bevelled_colours(style_alert_colour)),
--	de.substyle("*-active-selected", {padding_colour = style_selected_colour,	highlight_colour = colour_gtk_active_highlight,	shadow_colour = colour_gtk_active_shadow, foreground_colour = colour_gtk_active_foreground,}),
--	de.substyle("inactive-selected", {padding_colour = style_selected_colour,	highlight_colour = colour_gtk_active_highlight,	shadow_colour = colour_gtk_active_shadow, foreground_colour = colour_gtk_active_foreground,}),
--	de.substyle("active-unselected", {padding_colour = style_selected_colour,	highlight_colour = colour_gtk_active_highlight,	shadow_colour = colour_gtk_active_shadow, foreground_colour = colour_gtk_active_foreground,}),
--	de.substyle("inactive-unselected", {padding_colour = style_selected_colour,	highlight_colour = colour_gtk_active_highlight,	shadow_colour = colour_gtk_active_shadow, foreground_colour = colour_gtk_active_foreground,}),
})


-- Transient windows are basically floating too, so we'll derive from "frame-floating" here.
de.defstyle("frame-transient",
	union(bevelled_colours(style_modal_colour), {
	based_on = "frame-floating",
	padding_pixels = 2,
	border_style = "elevated",	-- Like the traditional modal dialogs in Mac OS and Windows.
}))


-- And the tab style for transient widows?
-- (these look more sensible without recessed bevelling, because they normally never appear in groups)
-- BTW, should this def be moved to the general "tabs" area below?  Or stay here, keeping the transient tab style with the transient frame style?
de.defstyle("tab-frame-transient", {
	based_on = "tab",
	highlight_pixels = 2,	-- Not sure why these aren't inherited by default...
	shadow_pixels = 2,
	-- I think "unselected" is probably inapplicable for transient frames.
	-- In fact, you could argue that these should stay active-looking even when not, since they're modal.
 	de.substyle("*-selected", bevelled_colours(style_selected_colour)),
--	de.substyle("active-selected", bevelled_colours(style_selected_colour)),
--	de.substyle("inactive-selected", inactive_colours(bevelled_colours(style_selected_colour))),
})


-- "frame-unknown" matches the scratchpad workspace, which is floating and should therefore have big borders.
-- These are kind of modal, so we'll colour the frame with the modal colour.
de.defstyle("frame-unknown", union(bevelled_colours(style_modal_colour), {
	based_on = "frame-floating",
	bar = "inside",	-- Appropriate, since there can only be one scratchpad workspace, and it's useful to have it visually differentiated from other floating windows that may be visible.
	background_colour = "black",	-- TODO: factor out into some kind of style_background_colour.
}))


-- It might make sense for tiled frames to have to border/frame at all, so that the edge of the window content actually reaches the edge of the screen, for example (for mouse "scooting").  But actually there always seems to be a one pixel edge that I can't get rid of.  Oh, well.  We'll leave it at 2 pixels then (it's not so heavy that it look ugly, but not too small that it's hard to grab).
de.defstyle("frame-tiled", {
	based_on = "frame",
	border_style = "inlaid",

	padding_pixels = 1,
	spacing = 1,	-- Space around client window and tab area.  A single black pixel looks quite good.  TODO: make this style_inside_border_margin?

	highlight_pixels = 2,
	shadow_pixels = 2,
})


-- General style for tabs, which includes not just the tabs in frames, but also menu items (these are actually tabs too!).
-- de.defstyle("tab", {})


-- Style for tabs for tabbed tabbing, obviously.
-- Actually, much of this should probably more correctly go into "tab-frame".  "tab" is also used for menu items.
de.defstyle("tab-frame", {
	based_on = "*",
	text_align = "center", 
	font = style_font_title,

	padding_pixels = 3,	-- 5 is really as small as this should go; looks like this should generally be an odd number.  However, my tweaked aqui font has more padding, so less needed here (3).
	highlight_pixels = 2,
	shadow_pixels = 2,
	spacing = 1,	-- This is the horizontal space between tabs only!  Again, 1 pixel to be consistent with the 1-px black frame around items generally.  TODO: perhaps factor this out as style_inside_border_margin or something.

	de.substyle("active-selected", recessed_colours(style_selected_colour)),
	de.substyle("active-unselected", unselected_colours(bevelled_colours(unselected_colour(style_selected_colour)))),
	de.substyle("inactive-selected", inactive_colours(recessed_colours(style_selected_colour))),
	de.substyle("inactive-unselected", unselected_colours(inactive_colours(bevelled_colours(unselected_colour(style_selected_colour))))),

	-- Old code, prior to creating the table-based unselected_colours() function, which deals with foreground colour.
--	de.substyle("active-selected", recessed_colours(style_selected_colour)),
--	de.substyle("active-unselected", bevelled_colours(unselected_colour(style_selected_colour))),
--	de.substyle("inactive-selected", inactive_colours(recessed_colours(style_selected_colour))),
--	de.substyle("inactive-unselected", inactive_colours(bevelled_colours(unselected_colour(style_selected_colour)))),

--	de.substyle("tagged", bevelled_colours(style_modal_colour)),	-- Hmm, document, but doesn't seem to do anything.
--	de.substyle("dragged", bevelled_colours(style_alert_colour)),	-- Hmm, document, but doesn't seem to do anything.
})



-- Even though the scratchpad workspace is tiled, its tabs aren't matched by "tab-tiled", hence this:
-- Oh, I think there'll still be a problem due to floating frames still possibly being tiled.  Maybe ditch "tab-tiled"/"tab"/"tab-unknown" distinction.
--de.defstyle("tab-unknown", {background_colour = "green"})


-- CME: input objects, e.g. the Run menu, Workspace create/move-to menu.
-- CME: I think this is the input object, not the text field itself.
-- CME: For some reason, this seems to affect tab context menus on the secondary display as well.
de.defstyle("input", {
	based_on = "*",
	-- CME: font?
	font = style_font_menu,
--	text_align = "center",	-- no effect?

	padding_pixels = 8,	-- This is the padding around the entire menu, not each item, sadly.
	spacing = 1,	--  ...and "spacing" only affects the space between the menu edln and the menu options.
	-- AFAICT, there's no way to add vertical spacing between the menu list items (other than tweaking the font!).

	highlight_pixels = 2,
	shadow_pixels = 2,
--	border_style = "groove",
--	border_style = "inlaid",
	border_style = "elevated",

	-- Should we use the active or modal colour here?  Why not both?!
	de.substyle("*-cursor", bevelled_colours(style_modal_colour)),
	de.substyle("*-selection", bevelled_colours(style_selected_colour)),
})



--[[
--	"GRAPHICAL" (MOUSE/CONTEXT) MENUS
--]]

-- "input-menu" is actually the top-level element (main frame) of the graphical (mouse/context) menus for the root window and tabs.  It's not something to do with the other "input-" objects, AFAICT.  Most of the relevant stuff (such as background colour of selected item) is set in tab-menuentry, but you can change the frame style for the whole menu block here.
de.defstyle("input-menu", {
	based_on = "*",
	font = style_font_menu,

	-- A single black line around the whole menu block could look nice:
	padding_pixels = 1,	-- Has effect!  1 pixel outline in keeping with other 1-pixel black borders elsewhere.
	padding_colour = "black",	-- This is the colour of the border around the menu block.
	background_colour = "black",	-- This is effectively the colour of the vertical space between menu items.
	highlight_pixels = 0,	-- You could enlarge these if you want, but it starts looking a bit busy...
	shadow_pixels = 0,
--	spacing = 0,	-- No effect?  See "tab-menuentry" instead.
})


-- "tab-menuentry" is the actual menu items within the menu blocks.  I guess it's "tab-" because they are rendered like tabs??
de.defstyle("tab-menuentry", {
	based_on = "*",

	font = style_font_menu,
	text_align = "left",

	padding_pixels = 3,	-- As with tabs, give the text some room to breathe.
	spacing = 1,	-- This is the vertical space between menu items/buttons (outside their individual frames).  Note that this does NOT create a dead zone between the items!  The "spacing" area is still part of the previous item's active area.
	shadow_pixels = 2,
	highlight_pixels = 2,

	de.substyle("selected", recessed_colours(style_modal_colour)),
})



-- Alerts from windows appearing on other workspaces:
de.defstyle("actnotify", bevelled_colours(style_alert_colour))


-- This style is for the co-ordinate display while moving/resizing, not the (double-pixel XOR-ed) frame!
de.defstyle("moveres_display", bevelled_colours(style_modal_colour))


-- "stdisp" is any status display (including the dock and statusbar).
de.defstyle("stdisp", {
	based_on = "*",
	background_colour = "green",
	foreground_colour = "yellow",
})

-- Can we define a style for the statusbar as well?  Bevelling (at least on the top) might be nice.  Yep: "stdisp-statusbar" is it.
de.defstyle("stdisp-statusbar", {
	based_on = "*",	-- Maybe should be based on stdisp?
	font = style_font_general,
	-- Shadow and highlight kind of happen automatically for normal full-screen frames, if using inlaid borders for tiled frames, so don't double-up on the bevelling here.  It's only on a "desktoppy" screen that the lack of beveling appears.
	highlight_pixels = 0,
	shadow_pixels = 0,
--	padding_pixels = 4,	-- No effect?
	spacing = 4,
})



gr.refresh()

