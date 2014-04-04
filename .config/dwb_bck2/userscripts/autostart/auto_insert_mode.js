//!javascript 

var uris = [
    new RegExp(RegExp.escape("google.com/reader")),
    new RegExp(RegExp.escape("vk.com")),
//    new RegExp(RegExp.escape("mail.google.com"))
];

var check = function (wv) 
{
    var uri = wv.uri;
    if (uris.some(function(value) { return value.test(uri); }))
        execute("insert_mode");
    return false;
};
var checkWithLag = function(wv) {
    var uri = wv.uri;
    if (uris.some(function(value) { return value.test(uri); }))
    {
        timerStart(25, function() {
            execute("insert_mode");
            return false;
        });
    }
}

signals.connect("loadFinished", check);
signals.connect("tabFocus", checkWithLag);
