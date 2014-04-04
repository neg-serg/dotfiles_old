//!javascript
//<downloadhandler___SCRIPT
extensions.load("downloadhandler", {
//<downloadhandler___CONFIG
   handler : [
     // Each handler must have 2 or 3 properties:
     //
     // command : command to execute, must contain %f which will be replaced with
     //           the filepath, this property is mandatory
     //
     // extension : a filename extension, optional
     //
     // mimeType  : a mimetype, optional
     //
     
     // { command : "xpdf %f", mimeType : "application/pdf" }
     // { command : "xdvi %f", extension : "dvi" }
     
   ]
//>downloadhandler___CONFIG
});
//>downloadhandler___SCRIPT
//<perdomainsettings___SCRIPT
extensions.load("perdomainsettings", {
//<perdomainsettings___CONFIG
// Only webkit builtin settings can be set, for a list of settings see 
// http://webkitgtk.org/reference/webkitgtk/unstable/WebKitWebSettings.html
// All settings can also be used in camelcase, otherwise they must be quoted.
// 
// The special domain suffix .tld matches all top level domains, e.g. 
// example.tld matches example.com, example.co.uk, example.it ... 
//
// Settings based on uri will override host based settings and host based
// settings will override domain based settings. Settings for domains/hosts/uris
// with without tld suffix will override settings for
// domains/hosts/uris with tld suffix respectively, e.g. 
//      "example.com" : { enableScripts : true }, 
//      "example.tld" : { enableScripts : false } 
// will enable scripts on example.com but not on example.co.uk, example.it, ... 


// Settings applied based on the second level domain
domains : {
//      "example.com" : { "auto-load-images" : false }, 
//      "google.tld" : { enableScripts : false, autoLoadImages : false }, 
},

//Settings applied based on the hostname
hosts : {
//    "www.example.com" : { autoLoadImages : true } 
},

// Settings applied based on the uri
uris : {
//  "http://www.example.com/foo/" : { autoLoadImages : true } }, 
},

//>perdomainsettings___CONFIG
});
//>perdomainsettings___SCRIPT
