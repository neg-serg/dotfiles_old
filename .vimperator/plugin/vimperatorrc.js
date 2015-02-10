(function() {

  // load plugins {{{
    // migemized_find
  liberator.globalVariables.plugin_loader_plugins = `
    _libly
    appendAnchor
    auto_reload
    auto_source
    copy
    feedSomeKeys_3
    googlesuggeset
    hints-ext
    multi_requestor
    readitlater
    removetabs
    sbmcommentsviewer
    slideshare
    speakerdeck
    subscldr
    walk-input
  `.toString().split(/\s+/).filter(function(n) !/^!/.test(n));
  // }}}

})();

mappings.addUserMap(
  [modes.COMMAND_LINE],
  ['<C-a>'],
  'Go to head.',
  function() {
    let e = Editor.getEditor();
    let m = e.value.match(/^\s*\S+\s/);

    if (!m) {
      editor.executeCommand("cmd_beginLine", 1);
      return;
    }

    if(e.selectionStart <= m[0].length) {
      editor.executeCommand("cmd_beginLine", 1);
      return;
    }

    editor.executeCommand("cmd_beginLine", 1);
    editor.executeCommand("cmd_wordNext", 1);
    editor.executeCommand("cmd_charNext", 1);
  }
);

// vim: set ft=javascript :
