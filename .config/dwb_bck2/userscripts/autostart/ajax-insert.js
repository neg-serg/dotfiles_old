//!javascript

var onKeyPress = Signal("keyPress", function(wv, event) {
    if (event.name == "Return")
    {
        var tagName = JSON.parse(wv.focusedFrame.inject("return document.activeElement.tagName"));
        if (tagName == "INPUT")
            util.normalMode();
    }
});

Signal.connect("changeMode", function(wv, mode) {
    if (mode == Modes.InsertMode)
        onKeyPress.connect();
    else
        onKeyPress.disconnect();
});
