/* ------------------------------
Make sure you press D to activate dark theme
------------------------------ */

register_user_stylesheet(
    make_css_data_uri(
        ["select,option,input { color: #bbb !important; background-color: #333 !important; }"+
         "code, pre { font-family: DejaVu Sans Mono !important; "+
         "font-size: 12px !important; }"+
         "span.__conkeror_hint {"+
         " line-height: 1.5ems !important;"+
         // ' font-family: Dina !important; '+
         ' font-family: Ubuntu !important; '+
         // 'font-weight: bold !important; '+
         ' padding: 3px !important;'+
         // ' font-family: Tamsyn !important; '+
         // ' font-style: italic !important;'+
         ' font-weight: normal !important;'+
         " font-size: 12px !important;"+
         "}\n"]));

// toggle dark mode, adapted from philjackson's darken function
color_theme_toggle = {};

function global_color_theme(name, key, styles) {
    interactive_cmd = "toggle-" + name + "-mode";
    color_theme_toggle[name] = false;
    interactive(interactive_cmd, "",
                function (I) {
                    if (color_theme_toggle[name]) {
                        for(x in styles) {
                            unregister_user_stylesheet(styles[x]);
                        }

                        color_theme_toggle[name] = false;
                    } else {
                        for(x in styles) {
                            register_user_stylesheet(styles[x]);
                        }
                        color_theme_toggle[name] = true;
                    }
                });
    define_key(default_global_keymap, key, interactive_cmd);
}

global_color_theme(
    "dark", "D",
    [make_css_data_uri(
        ['*:not(img) {'+
         // 'h1, h2, p, a, div, span, table, td, th tr, ul, li, strong, input, select, textarea, body {'+
         'font-style: normal !important;'+ // italics is hard to read with gohu
         // 'background: #303030 !important;'+

         'background: #404040 !important;'+
         'color: #cccccc !important; '+
         'text-shadow: 0px 0px 0px black !important;'+ // fix ugly shadows


         // 'letter-spacing: 0 !important;'+ // don't scrunch words
         // '*:not(img) { background: #262626 !important; '+
         // 'color: #f6f3e8 !important; '+
         // 'color: #686868 !important; '+
         // 'font-family: GohuFont, Tamsyn !important; '+
         // 'font-family: OhSnap !important; '+
         // 'font-family: Dina !important; '+
         // 'font-family: DejaVu Sans !important; '+
         // 'font-family: Inconsolata !important; '+
         // 'font-family: MonteCarlo !important; '+
         // 'font-family: Terminus !important; '+
         // 'font-family: EnvyPn !important; '+
         // 'font-family: Ubuntu Mono !important; '+
         'font-family: Ubuntu !important; '+
         // 'font-weight: lighter !important; '+
         // 'font-size: 10pt !important; '+
         'font-size: 12pt !important; '+
         '-moz-border-bottom-colors: #505050 #505050 !important; '+
         '-moz-border-top-colors: #505050 #505050 !important; '+
         '-moz-border-right-colors: #505050 #505050 !important; '+
         '-moz-border-left-colors: #505050 #505050 !important; '+
         'box-shadow: 0 0 0 black !important; '+
         '-moz-box-shadow: 0 0 0 black !important; '+
         'border-color: #505050 !important; '+
         'text-decoration: none !important;'+
         // inventing on principles
         // 'color: #abb1ad !important; '+
         // 'background: #454545 !important;'+
         ' }',
         // 'p { line-height: 1.5em !important;}',
         'code, pre, code *, pre * { color: #f6f3e8 !important; background-color: #353535 !important; }',
         ':link, :link * { color: #8ac6f2 !important}',
         ':visited, :visited * { color: #95e454 !important}',

         'h1,h2,h3,h4,h5,h6 { color: white !important}',
         '.literallink:link { color: #3afdff !important; background-color: #008b8b !important; text-decoration: none !important}',
         '.literallink:visited { color: #ff57fd !important; background-color: darkmagenta !important; text-decoration: none !important}',
         'em { background-color: #505050 !important;}',
         // form elements
         'input:focus, textarea:focus { '+
         // + 'color: #dd4ca7 !important; '
         // 'background-color: blue !important; '+
         // 'border-color: red !important; '+
         'border: solid 1px red !important; '+
         // 'background-image: -moz-linear-gradient(top left, #5b9602 0%, #334502 100%) !important; '+
         ' }',
         // submit button
         'input[type="submit"]:hover { }',
         'input[type="submit"]:focus { }',

         // youtube html5 player
         'div#watch-video-container *, div#video-player-html5 * { background-color: transparent !important; }',

         // brown
         // '*:not(img) { color: #eeddcc !important; '+
         // 'background: #472d1e !important; }',
         // ':link, :link * { color: #66bbff !important}',
         // ':visited, :visited * { color: #aabb00 !important}',
         // 'h1,h2,h3,h4,h5,h6 { color: #aa8866 !important}',
         // 'code, pre, code *, pre * { color: #ba9 !important; background-color: #1c1008 !important; }',

         'span.__conkeror_hint {'+
         // 'background-color: #104e8b !important;'+
         'color: white !important;'+
         // + 'font-family: GohuFont !important;'
         // + 'line-height: 14px !important;'
         'font-size: 14px !important;'+
         '}'
         ], $url_prefixes = ["http", "about"]),

     make_css_data_uri(
         ['em { background-color: #444444 !important;}'
         ], $url_prefixes = ["http://www.google.com/reader"]),

     make_css_data_uri(
         ['.vh { color: white; '+
          'background-color: #444 !important;}',
          '.TC { border-width: 0px !important; }', // remove extra lines on inbox
          '.xY { height: 10pt !important; }', // keep message list from being too tall
          // '.oZ-jd,.hF,.hG,', // old cursor class
          'div.ar, div.as { display: none !important; }', // hide labels
          'td.bAIpgd.aAotqb, td.PF.xY.PE { background: red !important;}', // make cursor red

          // 'div.tk3N6e-Jo-qE2ISc { display: none !important;}', // checkbox unchecked
          // 'div.T-Jo-Jp { display: visible !important; color: blue !important }', // checkbox checked
          // 'tr.x7 { background-color: blue !important }', // checkbox checked
          // 'div.oZ-x3 { display: none !important; }', // hide checkbox

          'div.gs { margin-left: 0px !important; }', // message spacing from avatar
          'div.X9rihb { display: none !important; }', // avatar
          'div.J-J5-Ji { }', // search box
          'div.no { none !important; }', // top bar with gmail and search box
          'td.GcwpPb-uq0Mrf { display: none !important; }', // search button
          '.im { color: #99968b !important;}', // quoted text
          'span.hP { color: #ff5996 !important;}', // subject: message view title
          'span.h4 { color: #777 !important;}', // show quoted text link
          '.gG { color: #777 !important;}', // show details header names
          '.nr { color: #8ac6f2 !important;}',
          // hide
          'table.Bs tr td.Bu:nth-child(3),'+ // side area (ads etc)
          // '.gB table,'+ // reply and forward buttons
          '.hj,'+ // popout, print, etc buttons
          '.D,'+ // button bar
          'table.hX,'+ // tags on top of message view
          '.av,'+ // tags in message list
          '.T8uMgc,'+ // chat area
          '.VP5otc-U4m8q,'+ // bottom button bar
          '.l2,.ov,'+ // bottom info
          '#gb'+ // google bar
          ' { display: none !important;}'
         ], $domains = "mail.google.com"),

     make_css_data_uri(
         [':link img { border: dashed 1px #008b8b !important; margin: 5px !important; }',
          ':visited img { border: dashed 1px darkmagenta !important; margin: 5px !important; }'
         ], $domains = ["bbs.archlinux.org",
                        "crunchbang.org",
                       "google.com"]),

     make_css_data_uri(
         ['#entries { padding-left: 5px !important; padding-right: 5px !important; }', // don't add padding on left side
          'div#current-entry div.card { border: solid 2px #8968cd !important;} ',
          'div#current-entry div.card:-moz-window-inactive { border-color: #777 ! important; }',
          '#message-area-container { display: none !important; }',
          "#message-area-container div.goog-inline-block { display: none !important: }",
          "div.section-minimize { display: none !important; }",
          '.entry { background-color: #444 !important; }',
          'div.item-star-active { background: transparent url(http://www.google.com/reader/ui/3904077461-entry-action-icons.png) no-repeat !important; background-position: -64px -33px !important;}',
          // hide
          '#viewer-footer, '+ // next prev buttons
          '#chrome-header, '+ // tag name, expanded/list
          '#viewer-header-container, '+ // showing new items, mark and folder buttons
          '#top-bar,'+ // logo and search
          "#lhn-recommendations,"+ // explore sidebar
          "#lhn-friends,"+ // followers sidebar
          "#overview-selector,"+ // home
          "#your-items-tree-container,"+ // your stuff, shared items
          "#trends-selector,"+ // trends
          "#directory-selector,"+ // browse for stuff
          ".entry-actions,"+ // browse for stuff
          "#gb,"+ // google bar
          '#title-and-status-holder,'+ // all items, sort by
          '.card-actions,'+ // social links
          '#scroll-filler-recs-message'+ // no more articles message
          '{ display: none !important;}'
         ], $url_prefixes = ["http://www.google.com/reader",
                             "https://www.google.com/reader"]),

     hacker_news_box("#8968cd"),

     make_css_data_uri(
         ['.k { font-weight: bold !important }', // keyword
          'a, h1, code, pre {text-shadow: 0px 0px 0px black !important; }', // ugly shadows
          // named builtin? .nb named function .nf
          // commented cause gh's clojure highlighting marks lots of the code with this
          // '.nv { color: #ff5996 !important } ', // function name/variable name
          '.nv { color: #aaa !important } ', // function name/variable name
          '.s { color: #95e454 !important } ', // string
          '.c1 { color: #99968b !important; '+
          'font-style: normal !important; }', // comment
          '.x { background-color: #666666 !important }', // added/deleted portion
          '.gi, .gi .x { color: #1AFF84 !important }', // inserted line
          '.gd, .gd .x { color: #ff0080 !important }' // deleted line
         ], $domains = "github.com")]);

global_color_theme(
    "light", "L",
    [make_css_data_uri(
        ['*:not(img) { background: #edebe8 ! important; color: #2c2d32 !important; font-family: MonteCarlo !important; }',
         ':link, :link * { color: #1856ba !important }',
         ':visited, :visited * { color: #95e454 !important }']
        , $url_prefixes = ["http", "about"])]);

global_color_theme(
    "grey", "A",
    [make_css_data_uri(
        ['*:not(img) { background: #4c4c4c ! important; color: #cccccc !important }',
         ':link, :link * { color: #8ac6f2 !important }',
         ':visited, :visited * { color: #95e454 !important }']
            , $url_prefixes = ["http", "about"])]);

global_color_theme(
    "gnome+", "M-d",
    [make_css_data_uri(
        ['*:not(img) { background: darkslategrey !important; color: wheat !important; }',
         'em { color: salmon !important; }',
         ':link, :link * { color: aquamarine !important }',
         ':visited, :visited * { color: salmon !important }']
        , $url_prefixes = ["http", "about"]),
     hacker_news_box("LightSalmon")
    ]);

// global_color_theme(
// "grey", "A",
// [make_css_data_uri(
// ['*:not(img) { background: #535353 ! important; color: #ffffff !important }',
// ':link, :link * { color: #8ac6f2 !important }',
// ':visited, :visited * { color: #95e454 !important }'])]);

// global_color_theme(
// "beige", "Q",
// [make_css_data_uri(
// ['*:not(img) { background: #f5deb3 ! important; color: #000000 !important; font-family: GohuFont, Tamsyn !important; font-size: 10pt !important; }',
// ':link, :link * { color: #005f87 !important }',
// ':visited, :visited * { color: #d75f00 !important }'])]);


function hacker_news_box(color) {
    return make_css_data_uri(
         [".current { border: solid 2px " + color + " !important; }"+
          "td.default { border :solid 2px transparent !important; }"+
          ".current-comment > td.default { border: solid 2px " + color + " !important; }"
         ], $domains = ["news.ycombinator.com"]);
};

