-- Some colour manipulation functions to make Ion3 colour scheme management a bit easier.
-- CME 2009-11
-- Includes functions for generating tables of Ion3 colour schemes for bevelled/embossed appearance from a single colour, and functions for deriving "inactive" and "unselected" colours from a starting colour.  You can then easily combine these to derive a whole colour scheme automatically from just a few starting colours (which you can then easily change to try out different colours).
-- It's probably optimised a bit for dark, saturated "active" colours (or at least is not very thoroughly tested for pale colour schemes).

-- One complicating factor here is that Ion3 wants RGB hex strings a la "#80A0C0", but if we want to take advantage of Takhteyev's "colors" library, it's more convenient to define colours as "colors" objects.  They will automatically be stringified if required, but watch out for types and conversions.  Maybe even consider apps Hungarian notation?!

-- NOTE: use hex, not names when defining colours (colors lib can't handle them).  Is there a function I can just call to map colour names to hex strings?

-- TODO: for unselected colour schemes, it would be nice to reduce the contrast between foreground and background, if we can.


-- TODO (well, DONE, actually): consider flattening (i.e. un-bevelling) the colour scheme for inactive items.


-- This makes use of Yuri Takhteyev's "colors" library, available at:
-- http://sputnik.freewisdom.org/lib/colors/
require("colors")

-- This may be an alternative library:
-- http://sourceforge.net/apps/mediawiki/pipmak/index.php?title=Library_color.lua



-- RGB-based perceptual brightness model (for generating contrasting foreground colours etc. automatically).
-- http://www.nbdtech.com/blog/archive/2008/04/27/Calculating-the-Perceived-Brightness-of-a-Color.aspx
-- http://alienryderflex.com/hsp.html
-- Argument is a "colors" library object.
function perceived_colour_brightness(colour)
	r, g, b = colors.hsl_to_rgb(colour.H, colour.S, colour.L)	-- Convert colour to RGB.
	return math.sqrt(0.241 * r ^ 2  +  0.691 * g ^ 2  +  0.068 * b ^ 2)	-- Brightness weighted according to component sensitivity.
end



-- TODO: automatically derive the highlight and shadow colour from the main background colour.  And perhaps also foreground colour?
-- Also, automatically derive recessed versions of each bevelled colour scheme.  Ion's border_style = "inlaid" is not just "raised" with the colours switched around (the padding is different).

-- Table-returning functions should do the trick, I think:
-- function bevelled_colours(base_colour) ...
-- function recessed_colours(base_colour) ...

-- This is the easy one: just swap the highlight and shadow colours around (argument is a table):
-- NOTE: this should be deprecated in favour of recessed_colours, which derives the colour scheme from a single source colour!
function recessed_colours_from_scheme(base_colour_scheme)
	t = {}
	t.background_colour = base_colour_scheme.background_colour
	t.highlight_colour = base_colour_scheme.shadow_colour
	t.shadow_colour = base_colour_scheme.highlight_colour
	t.foreground_colour = base_colour_scheme.foreground_colour
	return t
end

-- Derive the highlight colour from the base background colour (a "colors" library colour object):
-- Hmm, should these return a "color" object or an RGB string?
-- This might also have to adjust for perceived brightness, to avoid getting too bright with pale colours, and too dark with dark base colours.
function highlight_colour(base_colour)
--	return base_colour:lighten_by(1.3):to_rgb()
	return base_colour:desaturate_by(1.4):lighten_by(1.25):to_rgb()	-- Pretty good.
--	return base_colour:desaturate_by(1.4):lighten_by(perceived_colour_brightness(base_colour) * 0.5 + 1.15):to_rgb()	-- May need a more complex formula here.
end

-- ...similarly for shadow colour:
-- TODO: this possibly darkens too much for pale colours, so adjust for that somehow.
function shadow_colour(base_colour)
	return base_colour:lighten_by(perceived_colour_brightness(base_colour) * 0.2 + 0.634):to_rgb()	-- Better, at least on pale colours.
--	return base_colour:lighten_by(0.634):to_rgb()	-- Pretty good for a first attempt.
end


-- For completeness, we'll factor out a function for deriving a suitable foreground colour for a given background.  This can be further tweaked by other functions for unselected colour schemes.
function foreground_colour(base_colour)
	if perceived_colour_brightness(base_colour) < 0.5 then
		-- Ah, problem here if we're starting with black, I think, as you can't lighten it!  And, generally, the amount you want to lighten by is more for darker colours (up to infinity for black).  TODO: fix.  Somehow.
		return base_colour:desaturate_by(0.5):lighten_by(2.8):to_rgb()	-- was lighten_by(2.4), but that was a bit dark for very dark base_colour.
	else
		return base_colour:desaturate_by(0.5):lighten_by(0.25):to_rgb()
	end
end

-- Return a table matching Ion3's colour scheme data from a single base colour (as a "color" library object):
-- NOTE: returned colours are HTML-style strings for direct use in Ion3.
-- Maybe take foreground_colour in as second argument for now...
function bevelled_colours(base_colour)
	colour_scheme = {}
	colour_scheme.background_colour = base_colour:to_rgb()
	colour_scheme.padding_colour = colour_scheme.background_colour
	colour_scheme.highlight_colour = highlight_colour(base_colour)
	colour_scheme.shadow_colour = shadow_colour(base_colour)
	colour_scheme.foreground_colour = foreground_colour(base_colour)
	return colour_scheme
end


-- Generate a "recessed bevel" colour scheme from a base "colors" object (just the bevelled colours with shadow and highlight swapped).
function recessed_colours(base_colour)
	-- Reuse bevelled_colour() function for the basic setup:
	colour_scheme = bevelled_colours(base_colour)
	-- Then swap shadow and highlight:
	original_shadow_colour = colour_scheme.shadow_colour
	colour_scheme.shadow_colour = colour_scheme.highlight_colour
	colour_scheme.highlight_colour = original_shadow_colour
	return colour_scheme
end



-- And also a function for deriving the colours for unselected and inactive elements (more specifically, active-unselected, inactive-selected and inactive-unselected).
-- Probably just one function for each, and apply whatever combination is required for the element status.
-- Actually, maybe if the colour scheme is pale, then darkening it might actually make it more prominent.  Hmm.
-- And, CTTOI, a desaturated colour scheme is hardly going to be affected by desaturating further when inactive.  Hmm.
-- Perhaps shifting the colour towards the background colour would be a good idea (you'd have to pass that as well, of course).  Would be easy to do in the inactive_colours() function, which would have the background colour available.  Or perhaps towards black or white depending on the lightness of the background colour.


-- "selected" / "unselected" in Ion3 relates to whether the item is the foreground one in a tabbed stack.
-- Usually the unselected colour will just be a "toned-down" version of the selected ("highlight", if you will) colour.
-- This function will calculate that toned-down colour, for tabs (etc.?) other than the selected one in the current frame (I think this could be applied to both active and inactive frames equally well).
function unselected_colour(base_colour)
	-- If dark, darken; if light, lighten
	if perceived_colour_brightness(base_colour) < 0.5 then
		return base_colour:desaturate_by(0.3):lighten_by(0.7)	-- lighten_by(0.7) or more like (1.7)??
	else
		return base_colour:desaturate_by(0.15):lighten_by(1.1)	-- Do we really want to lighten these?  Sometimes darkening de-emphasises.  Confused.  It's 2:45 am.
	end
	-- Actually, maybe we can just use a single function and take the perceived brightness into account.
--	return base_colour:desaturate_by(0.3):lighten_by(1.2 * perceived_colour_brightness(base_colour))
--	return base_colour:desaturate_by(0.2):lighten_by(1.5 - (base_colour.L * 2))
end

-- We could do with a table-returning unselected_colours() as well, which could tweak the foreground colour independently of the background.  This would be important for a "greying out" effect for non-selected tabs within a frame, for example.
-- The correct way to do this would be to take the base colour table and leave it unchanged, except for the foreground colour.  Whoops, first time I applied unselected_colour() to each element!
function unselected_colours(base_colour_table)
	t = {}
	for i,v in pairs(base_colour_table) do
		print(i .. " -> " .. v)
		t[i] = v
	end
	-- Or is there a table copy command?
	
	-- Tweak the foreground colour for lower contrast:
	print(t.background_colour .. " " .. t.foreground_colour)
	lightening_factor = perceived_colour_brightness(colors.new(t.background_colour)) - perceived_colour_brightness(colors.new(t.foreground_colour))* 0.6 + 1.0	-- TODO: will probably need to tweak function this depending on whether > or < 1, given how lighten_by seems to behave.
	print("lightening_factor = " .. lightening_factor)
	-- Ah, there's some clipping going on here.  Suppose the background is red, and the foreground is calculated to be white, we end up with grey here, not a shade of red.
	t.foreground_colour = colors.new(t.foreground_colour):lighten_by(lightening_factor):to_rgb()
	-- So, instead, derived the foreground colour anew from the background colour.  Somehow.  Can't use foreground_colour().  Um...I guess we need a floating-point colour library, huh?
	return t
end

-- "active" / "inactive" in Ion3 means whether the item is in the frame that has focus.  Just a greying-out + dimming effect is probably suitable here.
-- Derive the inactive background colour from an existing background colour.
function inactive_colour(base_colour)
	return base_colour:desaturate_by(0.65):lighten_by(0.65)	-- :to_rgb()? Or is inactive_colour() only used internally?
end


-- Process an entire table of colours, turning each into it's inactivated version.
-- We also make the look unbevelled, since the bevelling is an affordance suggesting something clickable, and the tabs are only clickable when the frame is in focus.
function inactive_colours(base_colour_table)
	t = {}
	for i,v in pairs(base_colour_table) do
		t[i] = inactive_colour(colors.new(v)):to_rgb()
	end
	-- Make un-bevelled:
	t.highlight_colour = t.background_colour
	t.shadow_colour = t.background_colour
	return t
end


