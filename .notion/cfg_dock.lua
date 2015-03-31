--
-- Notion dock module configuration
--

-- Create a dock
mod_dock.create{
    -- Dock mode: embedded|floating
    mode="embedded",
    -- The screen to create the dock on
    screen=0,
    -- Corner or side of the screen to place the dock on.
    -- For embedded dock the valid values are: tl|tr|bl|br
    -- For floating dock the following are also valid: tc|bc|ml|mc|mr
    pos="bl",
    -- Growth direction: left|right|up|down
    grow="right",
    -- Whether new dockapps should be added automatically to this dock
    is_auto=true,
    -- Show floating dock initially?
    floating_hidden=false,
    -- Name of the dock
    name="*dock*",
}


-- For floating docks, you may want the following toggle binding.
defbindings("WScreen", {
    bdoc("Toggle floating dock."),
    -- kpress(META.."D", "mod_dock.set_floating_shown_on(_, 'toggle')")
})
