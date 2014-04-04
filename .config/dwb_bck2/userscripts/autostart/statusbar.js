//!javascript

Signal.connect("statusBarChange", function(wv, data) {
    // uri
    var uri = util.markupEscape(wv.uri);
    if (data.ssl == "trusted") 
        uri = "<span foreground='#0f0'>" + uri + "</span>";
    else if (data.ssl == "untrusted") 
        uri = "<span foreground='#f00'>" + uri + "</span>";

    // history
    var statusText = " ";
    if (data.canGoBack || data.canGoForward) {
        statusText += "[";
        if (data.canGoBack)
            statusText += "+";
        if (data.canGoForward)
            statusText += "-";
        statusText += "] ";
    }

    // Scroll
    var adjustment = wv.parent.vadjustment;

    var lower = adjustment.lower;
    var upper = adjustment.upper - adjustment.pageSize + lower;
    var value = adjustment.value;

    if (upper == lower)
        statusText += "[all]";
    else if (value == lower)
        statusText += "[top]";
    else if (value == upper)
        statusText += "[bot]";
    else 
    {
        statusText += "[";
        var perc = Math.round(value * 100 / upper);
        if (perc < 10)
            statusText += " ";
        statusText += perc + "%]";
    }
    // Number of tab
    statusText += "[" + (tabs.number + 1) + "/" + tabs.length + "]";

    // Progressbar
    var progressBarLength = 20;
    var progress = wv.progress;
    if (progress > 0 && progress < 1) 
    {
        var len = Math.round(progress * progressBarLength);
        statusText += "[" + Array(len + 1).join("=") + Array(progressBarLength - len + 1).join(" ") + "] ";
    }

    gui.uriLabel.label = uri;
    gui.statusLabel.label = statusText;
    return true;
});
