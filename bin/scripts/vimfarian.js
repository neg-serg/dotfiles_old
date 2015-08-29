// ==UserScript==
// @name          Vimafarian
// @author	      Adrian Rollett
// @namespace     ACR
// @description   vimperator clone for Safari/GreaseKit
// @exclude       http://gmail.com/*
// @include       *
// ==/UserScript==
//
// CREDITS
// http://vimperator.org/trac/wiki/Vimperator (of course)
// http://www.openjs.com/scripts/events/keyboard_shortcuts/
// http://www.quirksmode.org/js/keys.html
// other sites too numerous to name...
//
// @TODOs
// the 'y' key sure would be nice, but seems technically impossible
//   to implement correctly at the moment
// motion ranges are needed...

// @BUGS
// help HUD pops up at top of page even when page is scrolled down

// globals
// this is hacky, necessitated by the lack of a js function for going
// to the user's home page in safari
var homePage='http://reluctanthacker.rollett.org/software/vimafarian/';
var pressed;
var actionCount=1;
var debug=1;
var suspend=false;

function log(input) {
  if (debug) {
    window.console.log(input);
  }
}

log(history);

// functions
function goToBottom() {
  var sh=document.body.scrollHeight;
  var oh=document.body.offsetHeight;
  if (sh > oh) window.scrollTo(0,sh);
  else window.scrollTo(0,oh);
  return false;
}

function openNewTab() {
  // Change "_blank" to something like "newWindow" to load all links in the same new window
  var newWindow = window.open('', 'New Tab', 'location=1,resizable=1,scrollbars=1');
  newWindow.focus();
  return false;
}

function upOneDir(docHref) {
  var lastSlash = docHref.lastIndexOf('/');
  var lengthOfHref = docHref.length;
  if (lengthOfHref == (lastSlash + 1)) {
    // if we're already at the top level, quit!
    if (charCount(docHref, '/') <= 3) {
      return docHref;
    }
    docHref = docHref.substr(0, (lengthOfHref - 2));
    var lastSlash = docHref.lastIndexOf('/');
  }
  return docHref.substr(0, (lastSlash + 1));
}

function upToTop(docHref) {
  var endIndex = 0;
  var counter = 0;
  var myArray = docHref.toLowerCase().split('');
  for (i=0; i < myArray.length; i++)
  {
    if (myArray[i] == '/')
    {
      counter++;
    }
    if (counter == 2) {
      endIndex = i;
    }
  }
  if (endIndex != 0) {
    return docHref.substr(0, (endIndex + 1));
  } else {
    return docHref;
  }
}

function charCount(myString, myChar) {
  var counter = 0;
  var myArray = myString.toLowerCase().split('');
  for (i=0;i<myArray.length;i++)
  {
    if (myArray[i] == myChar)
    {
      counter++;
    }
  }
  return counter;
}

document.addEventListener('keypress',
	function(e){

    var element;
    if(e.target) element=e.target;
    else if(e.srcElement) element=e.srcElement;
    if(element.nodeType==3) element=element.parentNode;

    if(element.tagName == 'INPUT' || element.tagName == 'TEXTAREA') return;

		var keyNum;

    if (e.which) {
			keyNum = e.which;
      // here's where we find out the keyNum for ctrl chars
      // alert(keyNum);
		}

    if (e.keyCode) {
      keyCode = e.keyCode;
    }

		var keyChar = String.fromCharCode(keyNum);

    // ctrl-z functionality
    if (keyNum == 26) {
      if (suspend) {
        suspend = false;
        window.status = '';
      } else {
        suspend = true;
        window.status = '-- Vimafarian suspended --';
      }
    }

    if (!suspend) {
      // action Counts
      if (keyChar > 1 && keyChar < 10) {
        actionCount = parseInt(keyChar);
      }
      // Multi-key functions
      else if (keyChar == 'g') {
        // emulates 'gg'
        if (pressed == 'g') {
          window.scrollTo(0,0);
          pressed = '';
        } else {
          pressed = 'g';
        }
      }
      else if (keyChar == 'h') {
        // emulates 'gh'
        if (pressed == 'g') {
          // go to user's home page
          window.location=homePage;
          pressed = '';
        }
        else {
          window.scrollBy(-50,0);
        }
      }
      else if (keyChar == 'u') {
        // emulates 'gu'
        if (pressed == 'g') {
          // go up one level
          newHref = upOneDir(window.location.href);
          if (newHref != window.location.href) {
            window.location=newHref;
          }
          pressed = '';
        }
      }
      else if (keyChar == 'U') {
        // emulates 'gU'
        if (pressed == 'g') {
          // go up one level
          newHref = upToTop(window.location.href);
          if (newHref != window.location.href) {
            window.location=newHref;
          }
          pressed = '';
        }
      }

      // Movement functions
      // scroll to bottom
      else if (keyChar == 'G') {
        goToBottom();
      }
      // scroll up
      else if (keyChar == 'j') {
        window.scrollBy(0,50);
      }
      // scroll down
      else if (keyChar == 'k') {
        window.scrollBy(0,-50);
      }
      else if (keyChar == 'l') {
        window.scrollBy(50,0);
      }
      // scroll down one page
      // ctrl-f
      else if (keyNum == 6) {
        window.scrollBy(0, window.innerHeight);
      }
      // scroll up one page
      // ctrl-b
      else if (keyNum == 2) {
        window.scrollBy(0, -window.innerHeight);
      }
      // scroll down half page
      // ctrl-d
      else if (keyNum == 4) {
        window.scrollBy(0, (window.innerHeight / 2));
      }
      // scroll up half page
      // ctrl-u
      else if (keyNum == 21) {
        window.scrollBy(0, -(window.innerHeight / 2));
      }

      // Navigation functions
      // go back one page
      // ctrl-o
      else if (keyNum == 15) {
        if (actionCount > history.length) {
          actionCount = history.length - 1;
        }
        history.go(-actionCount);
        actionCount = 1;
      }
      // go forward one page
      // ctrl-i
      else if (keyNum == 9) {
        currentHref = window.location.href;
        if (actionCount == 1) {
          history.go(1);
        } else {
          while (actionCount > 1) {
            log(actionCount);
            if (!history.go(actionCount)) {
              actionCount = actionCount - 1;
            } else {
              break;
            }
          }
        }
        actionCount = 1;
      }

      // Browser functions
      // stop loading current page
      // ctrl-c
      else if (keyNum == 3) {
        window.stop();
      }
      // close window
      else if (keyChar == 'd') {
        window.open('', '_self', '');
        top.window.close();
      }
      else if (keyChar == 'r') {
        window.location.reload();
      }
      else if (keyChar == 't') {
        openNewTab();
      }
      else if (keyChar == 'y') {
        var y=window.location.href;
        alert(y);
      }
    }
	},
true);
