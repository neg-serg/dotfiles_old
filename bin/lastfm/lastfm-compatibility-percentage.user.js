// ==UserScript==
// @name           Last.fm Compatibility Percentage
// @namespace      http://iso5.net/lastfm/
// @description    Display the percentage value in the compatibility bar on user pages
// @include        http://www.last.fm/user/*
// @exclude        http://www.last.fm/user/*/*

/*
 * Last.fm Compatibility Percentage
 * 2008-07-26: Version 0.1
 *
 * 2008-09-20: Version 0.2
 * Adjustments for recent layout changes
 *
 * 2009-01-30: Version 0.3
 * Regex adjustemnt for float numbers
 *
 * This bit of code is released into the Public Domain by http://www.last.fm/user/iriebob/
 */

(function() {
    var i = window.setInterval("iso5_checkTasteometer()", 200);
    var count = 0;

    unsafeWindow.iso5_checkTasteometer = function() {
        try {
            var d = document.getElementById('tasteometer');
            var s = d.getElementsByTagName('span')[1].style.width;
            var r = /^([0-9.,]+)(%)$/;
            r.exec(s);
            if (RegExp.$2 == "%") {
                var p = d.getElementsByTagName('p')[0];
                p.firstChild.nextSibling.nextSibling.nextSibling.innerHTML +=  " (" + s + ")";
                clearInterval(i);
			}
            else {
                count++;
            }
        } catch (e) {
            count++;
        }
        if (count > 50) {
            clearInterval(i);
        }
    }
})();
