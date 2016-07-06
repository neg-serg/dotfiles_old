Style: Minimalistic Tabs {{{
-----------------------------------------------------------------------------
style -name minitabs chrome://* <<EOM
#TabsToolbar toolbarbutton {
  display: none !important;
}
.tabbrowser-tabs {
  background: #282a2e !important;
}
.tabbrowser-tab {
  -moz-appearance: none !important;
  -moz-border-radius: 0 !important;
  background: #282a2e !important;
  border: none !important;
  color: #707880 !important;
  font-family: Terminus !important;
  font-size: 9pt !important;
  height: 18px !important;
  margin: 0 !important;
  min-height: 0 !important;
  padding: 0 0.5ex !important;
}
.tabbrowser-tab:not([pinned]) {
  max-width: 100px !important;
  min-width: 100px !important;
}
.tabbrowser-tab:not([fadein]) {
  max-width: 1px !important;
  min-width: 1px !important;
}
.tabbrowser-tab:hover {
  background: #f0c674 !important;
  color: #282a2e !important;
}
.tabbrowser-tab[selected] {
  background: #282a2e !important;
  color: #f0c674 !important;
}
@-moz-document url-prefix(about:blank) {*{background-color:#000000;}}
EOM
