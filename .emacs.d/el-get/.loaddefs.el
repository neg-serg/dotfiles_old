;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (turn-on-bib-cite bib-cite-minor-mode) "auctex/bib-cite"
;;;;;;  "auctex/bib-cite.el" (21516 26091 718665 769000))
;;; Generated autoloads from auctex/bib-cite.el

(autoload 'bib-cite-minor-mode "auctex/bib-cite" "\
Toggle bib-cite mode.
When bib-cite mode is enabled, citations, labels and refs are highlighted
when the mouse is over them.  Clicking on these highlights with [mouse-2]
runs bib-find, and [mouse-3] runs bib-display.

\(fn ARG)" t nil)

(autoload 'turn-on-bib-cite "auctex/bib-cite" "\
Unconditionally turn on Bib Cite mode.

\(fn)" nil nil)

;;;***

;;;### (autoloads (context-mode) "auctex/context" "auctex/context.el"
;;;;;;  (21516 26091 719665 769000))
;;; Generated autoloads from auctex/context.el

(defalias 'ConTeXt-mode 'context-mode)

(autoload 'context-mode "auctex/context" "\
Major mode in AUCTeX for editing ConTeXt files.

Special commands:
\\{ConTeXt-mode-map}

Entering `context-mode' calls the value of `text-mode-hook',
then the value of `TeX-mode-hook', and then the value
of ConTeXt-mode-hook.

\(fn)" t nil)

;;;***

;;;### (autoloads (context-en-mode) "auctex/context-en" "auctex/context-en.el"
;;;;;;  (21516 26091 718665 769000))
;;; Generated autoloads from auctex/context-en.el

(autoload 'context-en-mode "auctex/context-en" "\
Major mode for editing files for ConTeXt using its english interface.

Special commands:
\\{ConTeXt-mode-map}

Entering `context-mode' calls the value of `text-mode-hook',
then the value of TeX-mode-hook, and then the value
of context-mode-hook.

\(fn)" t nil)

;;;***

;;;### (autoloads (context-nl-mode) "auctex/context-nl" "auctex/context-nl.el"
;;;;;;  (21516 26091 719665 769000))
;;; Generated autoloads from auctex/context-nl.el

(autoload 'context-nl-mode "auctex/context-nl" "\
Major mode for editing files for ConTeXt using its dutch interface.

Special commands:
\\{ConTeXt-mode-map}

Entering `context-mode' calls the value of `text-mode-hook',
then the value of TeX-mode-hook, and then the value
of context-mode-hook.

\(fn)" t nil)

;;;***

;;;### (autoloads (font-latex-setup) "auctex/font-latex" "auctex/font-latex.el"
;;;;;;  (21516 26091 726665 769000))
;;; Generated autoloads from auctex/font-latex.el

(autoload 'font-latex-setup "auctex/font-latex" "\
Setup this buffer for LaTeX font-lock.  Usually called from a hook.

\(fn)" nil nil)

;;;***

;;;### (autoloads (docTeX-mode TeX-latex-mode BibTeX-auto-store)
;;;;;;  "auctex/latex" "auctex/latex.el" (21516 26091 731665 769000))
;;; Generated autoloads from auctex/latex.el

(autoload 'BibTeX-auto-store "auctex/latex" "\
This function should be called from `bibtex-mode-hook'.
It will setup BibTeX to store keys in an auto file.

\(fn)" nil nil)

(add-to-list 'auto-mode-alist '("\\.drv\\'" . latex-mode))

(autoload 'TeX-latex-mode "auctex/latex" "\
Major mode in AUCTeX for editing LaTeX files.
See info under AUCTeX for full documentation.

Special commands:
\\{LaTeX-mode-map}

Entering LaTeX mode calls the value of `text-mode-hook',
then the value of `TeX-mode-hook', and then the value
of `LaTeX-mode-hook'.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.dtx\\'" . doctex-mode))

(autoload 'docTeX-mode "auctex/latex" "\
Major mode in AUCTeX for editing .dtx files derived from `LaTeX-mode'.
Runs `LaTeX-mode', sets a few variables and
runs the hooks in `docTeX-mode-hook'.

\(fn)" t nil)

(defalias 'TeX-doctex-mode 'docTeX-mode)

;;;***

;;;### (autoloads (multi-prompt-key-value multi-prompt) "auctex/multi-prompt"
;;;;;;  "auctex/multi-prompt.el" (21516 26091 731665 769000))
;;; Generated autoloads from auctex/multi-prompt.el

(autoload 'multi-prompt "auctex/multi-prompt" "\
Completing prompt for a list of strings.  
The first argument SEPARATOR should be the string (of length 1) to
separate the elements in the list.  The second argument UNIQUE should
be non-nil, if each element must be unique.  The remaining elements
are the arguments to `completing-read'.  See that.

\(fn SEPARATOR UNIQUE PROMPT TABLE &optional MP-PREDICATE REQUIRE-MATCH INITIAL HISTORY)" nil nil)

(autoload 'multi-prompt-key-value "auctex/multi-prompt" "\
Read multiple strings, with completion and key=value support.
PROMPT is a string to prompt with, usually ending with a colon
and a space.  TABLE is an alist.  The car of each element should
be a string representing a key and the optional cdr should be a
list with strings to be used as values for the key.

See the documentation for `completing-read' for details on the
other arguments: PREDICATE, REQUIRE-MATCH, INITIAL-INPUT, HIST,
DEF, and INHERIT-INPUT-METHOD.

The return value is the string as entered in the minibuffer.

\(fn PROMPT TABLE &optional PREDICATE REQUIRE-MATCH INITIAL-INPUT HIST DEF INHERIT-INPUT-METHOD)" nil nil)

;;;***

;;;### (autoloads (ams-tex-mode TeX-plain-tex-mode) "auctex/plain-tex"
;;;;;;  "auctex/plain-tex.el" (21516 26091 734665 769000))
;;; Generated autoloads from auctex/plain-tex.el

(autoload 'TeX-plain-tex-mode "auctex/plain-tex" "\
Major mode in AUCTeX for editing plain TeX files.
See info under AUCTeX for documentation.

Special commands:
\\{plain-TeX-mode-map}

Entering `plain-tex-mode' calls the value of `text-mode-hook',
then the value of `TeX-mode-hook', and then the value
of plain-TeX-mode-hook.

\(fn)" t nil)

(autoload 'ams-tex-mode "auctex/plain-tex" "\
Major mode in AUCTeX for editing AmS-TeX files.
See info under AUCTeX for documentation.

Special commands:
\\{AmSTeX-mode-map}

Entering AmS-tex-mode calls the value of `text-mode-hook',
then the value of `TeX-mode-hook', and then the value
of `AmS-TeX-mode-hook'.

\(fn)" t nil)

;;;***

;;;### (autoloads (preview-report-bug LaTeX-preview-setup preview-install-styles)
;;;;;;  "auctex/preview/preview" "auctex/preview/preview.el" (21516
;;;;;;  26091 739665 770000))
;;; Generated autoloads from auctex/preview/preview.el

(autoload 'preview-install-styles "auctex/preview/preview" "\
Installs the TeX style files into a permanent location.
This must be in the TeX search path.  If FORCE-OVERWRITE is greater
than 1, files will get overwritten without query, if it is less
than 1 or nil, the operation will fail.  The default of 1 for interactive
use will query.

Similarly FORCE-SAVE can be used for saving
`preview-TeX-style-dir' to record the fact that the uninstalled
files are no longer needed in the search path.

\(fn DIR &optional FORCE-OVERWRITE FORCE-SAVE)" t nil)

(autoload 'LaTeX-preview-setup "auctex/preview/preview" "\
Hook function for embedding the preview package into AUCTeX.
This is called by `LaTeX-mode-hook' and changes AUCTeX variables
to add the preview functionality.

\(fn)" nil nil)
 (add-hook 'LaTeX-mode-hook #'LaTeX-preview-setup)

(autoload 'preview-report-bug "auctex/preview/preview" "\
Report a bug in the preview-latex package.

\(fn)" t nil)

;;;***

;;;### (autoloads (TeX-submit-bug-report TeX-auto-generate-global
;;;;;;  TeX-auto-generate TeX-tex-mode) "auctex/tex" "auctex/tex.el"
;;;;;;  (21516 26091 756665 770000))
;;; Generated autoloads from auctex/tex.el

(defalias 'TeX-assoc-string (symbol-function (if (featurep 'xemacs) 'assoc 'assoc-string)) (concat "Compatibility alias that points to\n  function `assoc' with XEMACS and to function `assoc-string'\n  with GNU EMACS. See function `" (if (featurep 'xemacs) "assoc" "assoc-string") "'."))

(autoload 'TeX-tex-mode "auctex/tex" "\
Major mode in AUCTeX for editing TeX or LaTeX files.
Tries to guess whether this file is for plain TeX or LaTeX.

The algorithm is as follows:

   1) if the file is empty or `TeX-force-default-mode' is not set to nil,
      `TeX-default-mode' is chosen
   2) If \\documentstyle or \\begin{, \\section{, \\part{ or \\chapter{ is
      found, `latex-mode' is selected.
   3) Otherwise, use `plain-tex-mode'

\(fn)" t nil)

(autoload 'TeX-auto-generate "auctex/tex" "\
Generate style file for TEX and store it in AUTO.
If TEX is a directory, generate style files for all files in the directory.

\(fn TEX AUTO)" t nil)

(autoload 'TeX-auto-generate-global "auctex/tex" "\
Create global auto directory for global TeX macro definitions.

\(fn)" t nil)

(autoload 'TeX-submit-bug-report "auctex/tex" "\
Submit a bug report on AUCTeX via mail.

Don't hesitate to report any problems or inaccurate documentation.

If you don't have setup sending mail from (X)Emacs, please copy the
output buffer into your mail program, as it gives us important
information about your AUCTeX version and AUCTeX configuration.

\(fn)" t nil)

;;;***

;;;### (autoloads (LaTeX-install-toolbar TeX-install-toolbar) "auctex/tex-bar"
;;;;;;  "auctex/tex-bar.el" (21516 26091 752665 770000))
;;; Generated autoloads from auctex/tex-bar.el

(autoload 'TeX-install-toolbar "auctex/tex-bar" "\
Install toolbar buttons for TeX mode.

\(fn)" t nil)

(autoload 'LaTeX-install-toolbar "auctex/tex-bar" "\
Install toolbar buttons for LaTeX mode.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "auctex/tex-fold" "auctex/tex-fold.el" (21516
;;;;;;  26091 753665 770000))
;;; Generated autoloads from auctex/tex-fold.el
 (autoload 'TeX-fold-mode "tex-fold" "Minor mode for hiding and revealing macros and environments." t)

(defalias 'tex-fold-mode 'TeX-fold-mode)

;;;***

;;;### (autoloads (tex-font-setup) "auctex/tex-font" "auctex/tex-font.el"
;;;;;;  (21516 26091 753665 770000))
;;; Generated autoloads from auctex/tex-font.el

(autoload 'tex-font-setup "auctex/tex-font" "\
Setup font lock support for TeX.

\(fn)" nil nil)

;;;***

;;;### (autoloads (TeX-texinfo-mode) "auctex/tex-info" "auctex/tex-info.el"
;;;;;;  (21516 26091 754665 770000))
;;; Generated autoloads from auctex/tex-info.el

(defalias 'Texinfo-mode 'texinfo-mode)

(autoload 'TeX-texinfo-mode "auctex/tex-info" "\
Major mode in AUCTeX for editing Texinfo files.

Special commands:
\\{Texinfo-mode-map}

Entering Texinfo mode calls the value of `text-mode-hook'  and then the
value of `Texinfo-mode-hook'.

\(fn)" t nil)

;;;***

;;;### (autoloads (japanese-latex-mode japanese-plain-tex-mode) "auctex/tex-jp"
;;;;;;  "auctex/tex-jp.el" (21516 26091 754665 770000))
;;; Generated autoloads from auctex/tex-jp.el

(autoload 'japanese-plain-tex-mode "auctex/tex-jp" "\
Major mode in AUCTeX for editing Japanese plain TeX files.
Set `japanese-TeX-mode' to t, and enter `TeX-plain-tex-mode'.

\(fn)" t nil)

(autoload 'japanese-latex-mode "auctex/tex-jp" "\
Major mode in AUCTeX for editing Japanese LaTeX files.
Set `japanese-TeX-mode' to t, and enter `TeX-latex-mode'.

\(fn)" t nil)

;;;***

;;;### (autoloads (texmathp-match-switch texmathp) "auctex/texmathp"
;;;;;;  "auctex/texmathp.el" (21516 26091 757665 770000))
;;; Generated autoloads from auctex/texmathp.el

(autoload 'texmathp "auctex/texmathp" "\
Determine if point is inside (La)TeX math mode.
Returns t or nil.  Additional info is placed into `texmathp-why'.
The functions assumes that you have (almost) syntactically correct (La)TeX in
the buffer.
See the variable `texmathp-tex-commands' about which commands are checked.

\(fn)" t nil)

(autoload 'texmathp-match-switch "auctex/texmathp" "\
Search backward for any of the math switches.
Limit searched to BOUND.

\(fn BOUND)" nil nil)

;;;***

;;;### (autoloads nil "auctex/toolbar-x" "auctex/toolbar-x.el" (21516
;;;;;;  26091 758665 770000))
;;; Generated autoloads from auctex/toolbar-x.el
 (autoload 'toolbarx-install-toolbar "toolbar-x")

;;;***

;;;### (autoloads (global-auto-complete-mode auto-complete-mode auto-complete)
;;;;;;  "auto-complete/auto-complete" "auto-complete/auto-complete.el"
;;;;;;  (21516 26631 122689 429000))
;;; Generated autoloads from auto-complete/auto-complete.el

(autoload 'auto-complete "auto-complete/auto-complete" "\
Start auto-completion at current point.

\(fn &optional SOURCES)" t nil)

(autoload 'auto-complete-mode "auto-complete/auto-complete" "\
AutoComplete mode

\(fn &optional ARG)" t nil)

(defvar global-auto-complete-mode nil "\
Non-nil if Global-Auto-Complete mode is enabled.
See the command `global-auto-complete-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-auto-complete-mode'.")

(custom-autoload 'global-auto-complete-mode "auto-complete/auto-complete" nil)

(autoload 'global-auto-complete-mode "auto-complete/auto-complete" "\
Toggle Auto-Complete mode in all buffers.
With prefix ARG, enable Global-Auto-Complete mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Complete mode is enabled in all buffers where
`auto-complete-mode-maybe' would do it.
See `auto-complete-mode' for more information on Auto-Complete mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (ac-config-default) "auto-complete/auto-complete-config"
;;;;;;  "auto-complete/auto-complete-config.el" (21516 26631 122689
;;;;;;  429000))
;;; Generated autoloads from auto-complete/auto-complete-config.el

(autoload 'ac-config-default "auto-complete/auto-complete-config" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads (buf-move-right buf-move-left buf-move-down buf-move-up)
;;;;;;  "buffer-move/buffer-move" "buffer-move/buffer-move.el" (21516
;;;;;;  22206 425495 344000))
;;; Generated autoloads from buffer-move/buffer-move.el

(autoload 'buf-move-up "buffer-move/buffer-move" "\
Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled.

\(fn)" t nil)

(autoload 'buf-move-down "buffer-move/buffer-move" "\
Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled.

\(fn)" t nil)

(autoload 'buf-move-left "buffer-move/buffer-move" "\
Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled.

\(fn)" t nil)

(autoload 'buf-move-right "buffer-move/buffer-move" "\
Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled.

\(fn)" t nil)

;;;***

;;;### (autoloads (color-theme-solarized-light color-theme-solarized-dark
;;;;;;  color-theme-solarized) "color-theme-solarized/color-theme-solarized"
;;;;;;  "color-theme-solarized/color-theme-solarized.el" (21516 22912
;;;;;;  727526 326000))
;;; Generated autoloads from color-theme-solarized/color-theme-solarized.el

(autoload 'color-theme-solarized "color-theme-solarized/color-theme-solarized" "\
Color theme by Ethan Schoonover, created 2011-03-24.
Ported to Emacs by Greg Pfeil, http://ethanschoonover.com/solarized.

\(fn MODE)" t nil)

(autoload 'color-theme-solarized-dark "color-theme-solarized/color-theme-solarized" "\


\(fn)" t nil)

(autoload 'color-theme-solarized-light "color-theme-solarized/color-theme-solarized" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "color-theme-solarized/solarized-definitions"
;;;;;;  "color-theme-solarized/solarized-definitions.el" (21516 22912
;;;;;;  727526 326000))
;;; Generated autoloads from color-theme-solarized/solarized-definitions.el

(when (boundp 'custom-theme-load-path) (add-to-list 'custom-theme-load-path (file-name-as-directory (file-name-directory load-file-name))))

;;;***

;;;### (autoloads (color-theme-initialize color-theme-submit color-theme-install
;;;;;;  color-theme-compare color-theme-make-snapshot color-theme-analyze-defun
;;;;;;  color-theme-print color-theme-install-at-point-for-current-frame
;;;;;;  color-theme-install-at-mouse color-theme-describe color-theme-select)
;;;;;;  "color-theme/color-theme" "color-theme/color-theme.el" (17529
;;;;;;  41105 0 0))
;;; Generated autoloads from color-theme/color-theme.el

(autoload 'color-theme-select "color-theme/color-theme" "\
Displays a special buffer for selecting and installing a color theme.
With optional prefix ARG, this buffer will include color theme libraries
as well.  A color theme library is in itself not complete, it must be
used as part of another color theme to be useful.  Thus, color theme
libraries are mainly useful for color theme authors.

\(fn &optional ARG)" t nil)

(autoload 'color-theme-describe "color-theme/color-theme" "\
Describe color theme listed at point.
This shows the documentation of the value of text-property color-theme
at point.  The text-property color-theme should be a color theme
function.  See `color-themes'.

\(fn)" t nil)

(autoload 'color-theme-install-at-mouse "color-theme/color-theme" "\
Install color theme clicked upon using the mouse.
First argument EVENT is used to set point.  Then
`color-theme-install-at-point' is called.

\(fn EVENT)" t nil)

(autoload 'color-theme-install-at-point-for-current-frame "color-theme/color-theme" "\
Install color theme at point for current frame only.
Binds `color-theme-is-global' to nil and calls
`color-theme-install-at-point'.

\(fn)" t nil)

(autoload 'color-theme-print "color-theme/color-theme" "\
Print the current color theme function.

You can contribute this function to <URL:news:gnu.emacs.sources> or
paste it into your .emacs file and call it.  That should recreate all
the settings necessary for your color theme.

Example:

    (require 'color-theme)
    (defun my-color-theme ()
      \"Color theme by Alex Schroeder, created 2000-05-17.\"
      (interactive)
      (color-theme-install
       '(...
	 ...
	 ...)))
    (my-color-theme)

If you want to use a specific color theme function, you can call the
color theme function in your .emacs directly.

Example:

    (require 'color-theme)
    (color-theme-gnome2)

\(fn &optional BUF)" t nil)

(autoload 'color-theme-analyze-defun "color-theme/color-theme" "\
Once you have a color-theme printed, check for missing faces.
This is used by maintainers who receive a color-theme submission
and want to make sure it follows the guidelines by the color-theme
author.

\(fn)" t nil)

(autoload 'color-theme-make-snapshot "color-theme/color-theme" "\
Return the definition of the current color-theme.
The function returned will recreate the color-theme in use at the moment.

\(fn)" nil nil)

(autoload 'color-theme-compare "color-theme/color-theme" "\
Compare two color themes.
This will print the differences between installing THEME-A and
installing THEME-B.  Note that the order is important: If a face is
defined in THEME-A and not in THEME-B, then this will not show up as a
difference, because there is no reset before installing THEME-B.  If a
face is defined in THEME-B and not in THEME-A, then this will show up as
a difference.

\(fn THEME-A THEME-B)" t nil)

(autoload 'color-theme-install "color-theme/color-theme" "\
Install a color theme defined by frame parameters, variables and faces.

The theme is installed for all present and future frames; any missing
faces are created.  See `color-theme-install-faces'.

THEME is a color theme definition.  See below for more information.

If you want to install a color theme from your .emacs, use the output
generated by `color-theme-print'.  This produces color theme function
which you can copy to your .emacs.

A color theme definition is a list:
\([FUNCTION] FRAME-PARAMETERS VARIABLE-SETTINGS FACE-DEFINITIONS)

FUNCTION is the color theme function which called `color-theme-install'.
This is no longer used.  There was a time when this package supported
automatic factoring of color themes.  This has been abandoned.

FRAME-PARAMETERS is an alist of frame parameters.  These are installed
with `color-theme-install-frame-params'.  These are installed last such
that any changes to the default face can be changed by the frame
parameters.

VARIABLE-DEFINITIONS is an alist of variable settings.  These are
installed with `color-theme-install-variables'.

FACE-DEFINITIONS is an alist of face definitions.  These are installed
with `color-theme-install-faces'.

If `color-theme-is-cumulative' is nil, a color theme will undo face and
frame-parameter settings of previous color themes.

\(fn THEME)" nil nil)

(autoload 'color-theme-submit "color-theme/color-theme" "\
Submit your color-theme to the maintainer.

\(fn)" t nil)

(autoload 'color-theme-initialize "color-theme/color-theme" "\
Initialize the color theme package by loading color-theme-libraries.

\(fn)" t nil)

;;;***

;;;### (autoloads (el-get-checksum el-get-make-recipes el-get-cd
;;;;;;  el-get-self-update el-get-update-packages-of-type el-get-update-all
;;;;;;  el-get-version) "el-get/el-get" "el-get/el-get.el" (21516
;;;;;;  22032 981487 736000))
;;; Generated autoloads from el-get/el-get.el

(autoload 'el-get-version "el-get/el-get" "\
Message the current el-get version

\(fn)" t nil)

(autoload 'el-get-update-all "el-get/el-get" "\
Performs update of all installed packages.

\(fn &optional NO-PROMPT)" t nil)

(autoload 'el-get-update-packages-of-type "el-get/el-get" "\
Update all installed packages of type TYPE.

\(fn TYPE)" t nil)

(autoload 'el-get-self-update "el-get/el-get" "\
Update el-get itself.  The standard recipe takes care of reloading the code.

\(fn)" t nil)

(autoload 'el-get-cd "el-get/el-get" "\
Open dired in the package directory.

\(fn PACKAGE)" t nil)

(autoload 'el-get-make-recipes "el-get/el-get" "\
Loop over `el-get-sources' and write a recipe file for each
entry which is not a symbol and is not already a known recipe.

\(fn &optional DIR)" t nil)

(autoload 'el-get-checksum "el-get/el-get" "\
Compute the checksum of the given package, and put it in the kill-ring

\(fn PACKAGE &optional PACKAGE-STATUS-ALIST)" t nil)

;;;***

;;;### (autoloads (el-get-list-packages) "el-get/el-get-list-packages"
;;;;;;  "el-get/el-get-list-packages.el" (21516 22032 980487 736000))
;;; Generated autoloads from el-get/el-get-list-packages.el

(autoload 'el-get-list-packages "el-get/el-get-list-packages" "\
Display a list of packages.

\(fn)" t nil)

;;;***

;;;### (autoloads (apt-sources-mode) "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-sources"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-sources.el"
;;;;;;  (19215 18987 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-sources.el

(autoload 'apt-sources-mode "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-sources" "\
Major mode for editing apt's sources.list file.
Sets up command `font-lock-mode'.

\\{apt-sources-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads (apt-utils-search apt-utils-show-package) "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-utils"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-utils.el"
;;;;;;  (19972 48294 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-utils.el

(autoload 'apt-utils-show-package "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-utils" "\
Show information for a Debian package.
A selection of known packages is presented.  See `apt-utils-mode'
for more detailed help.  If NEW-SESSION is non-nil, generate a
new `apt-utils-mode' buffer.

\(fn &optional NEW-SESSION)" t nil)

(autoload 'apt-utils-search "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/apt-utils" "\
Search Debian packages for regular expression.
To search for multiple patterns use a string like \"foo && bar\".
The regular expression used to split the
terms (`apt-utils-search-split-regexp') is customisable.

\(fn)" t nil)

;;;***

;;;### (autoloads (deb-find deb-view-mode deb-view deb-view-dired-view)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/deb-view"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/deb-view.el"
;;;;;;  (20043 14215 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/debian-el/deb-view.el

(autoload 'deb-view-dired-view "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/deb-view" "\
View Debian package control and data files.
Press \"q\" in either window to kill both buffers
and return to the dired buffer. See deb-view.

\(fn)" t nil)

(autoload 'deb-view "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/deb-view" "\
View Debian package DEBFILE's control and data files.
Press \"q\" in either window to kill both buffers.

In dired, press ^d on the dired line of the .deb file to view.
Or, execute: ESCAPE x deb-view RETURN, and enter the .deb file name
at the prompt.

\(fn DEBFILE)" t nil)

(autoload 'deb-view-mode "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/deb-view" "\
View mode for Debian Archive Files.

\(fn)" t nil)

(autoload 'deb-find "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/deb-view" "\
Search for deb files.
Use the method specified by the variable deb-find-method, and collect
output in a buffer.  See also the variable deb-find-directory.

This command uses a special history list, so you can
easily repeat a `deb-find' command.

\(fn)" t nil)

;;;***

;;;### (autoloads (debian-bug emacs-bug-get-bug-as-email debian-bug-get-bug-as-email
;;;;;;  debian-bug-get-bug-as-file debian-bug-web-package debian-bug-web-packages
;;;;;;  debian-bug-web-this-bug-under-mouse emacs-bug-web-bug debian-bug-web-bug
;;;;;;  debian-bug-web-developer-page debian-bug-web-bugs debian-bug-intent-to-package
;;;;;;  debian-bug-request-for-package debian-bug-wnpp) "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug.el"
;;;;;;  (21226 20037 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug.el

(autoload 'debian-bug-wnpp "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Submit a WNPP bug report to Debian.
Optional argument ACTION can be provided in programs.

\(fn &optional ACTION)" t nil)

(autoload 'debian-bug-request-for-package "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Shortcut for `debian-bug-wnpp' with RFP action.

\(fn)" t nil)

(autoload 'debian-bug-intent-to-package "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Shortcut for `debian-bug-wnpp' with ITP action (for Debian developers).

\(fn)" t nil)

(autoload 'debian-bug-web-bugs "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Browse the BTS for this package via `browse-url'.
With optional argument prefix ARCHIVED, display archived bugs.

\(fn &optional ARCHIVED)" t nil)

(autoload 'debian-bug-web-developer-page "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Browse the web for this package's developer page.

\(fn)" t nil)

(autoload 'debian-bug-web-bug "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Browse the BTS for BUG-NUMBER via `browse-url'.

\(fn &optional BUG-NUMBER)" t nil)

(autoload 'emacs-bug-web-bug "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Browse the Emacs BTS for BUG-NUMBER via `browse-url'.

\(fn &optional BUG-NUMBER)" t nil)

(autoload 'debian-bug-web-this-bug-under-mouse "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Browse the BTS via `browse-url' for the bug report number under mouse.
In a program, mouse location is in EVENT.

\(fn EVENT)" t nil)

(autoload 'debian-bug-web-packages "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Search Debian web page for this package via `browse-url'.

\(fn)" t nil)

(autoload 'debian-bug-web-package "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Search Debian web page in ARCHIVE for this package via `browse-url'.

\(fn ARCHIVE)" t nil)

(autoload 'debian-bug-get-bug-as-file "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Read bug report #BUG-NUMBER as a regular file.

\(fn &optional BUG-NUMBER)" t nil)

(autoload 'debian-bug-get-bug-as-email "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Read bug report #BUG-NUMBER via Email interface.

\(fn &optional BUG-NUMBER)" t nil)

(autoload 'emacs-bug-get-bug-as-email "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Read Emacs bug report #BUG-NUMBER via Email interface.

\(fn &optional BUG-NUMBER)" t nil)

(autoload 'debian-bug "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-bug" "\
Submit a Debian bug report.

\(fn)" t nil)

;;;***

;;;### (autoloads (preseed-mode) "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/preseed"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/preseed.el"
;;;;;;  (17245 35005 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/debian-el/preseed.el

(autoload 'preseed-mode "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/preseed" "\
Major mode for editing debian-installer preseed files colourfully.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacs-bts-control debian-bts-control) "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-bts-control"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-bts-control.el"
;;;;;;  (19331 13712 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-bts-control.el

(autoload 'debian-bts-control "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-bts-control" "\
Contruct a message with initial ACTION command for control@bugs.debian.org.
Contructs a new control command line if called from within the message
being constructed.

If prefix arg is provided, use the current buffer instead instead of
creating a new outgoing email message buffer.
The current buffer is also used if the current major mode matches one listed
in `debian-bts-control-modes-to-reuse'.

\(fn ACTION &optional ARG)" t nil)

(autoload 'emacs-bts-control "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-bts-control" "\
Contruct a message with ACTION command for control@debbugs.gnu.org.
Contructs a new control command line if called from within the message
being constructed.

If prefix arg is provided, use the current buffer instead instead of
creating a new outgoing email message buffer.
The current buffer is also used if the current major mode matches one listed
in `debian-bts-control-modes-to-reuse'.

\(fn ACTION &optional ARG)" t nil)

;;;***

;;;### (autoloads (debian-changelog-mode debian-changelog-add-entry)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-changelog-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-changelog-mode.el"
;;;;;;  (21185 50125 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-changelog-mode.el

(autoload 'debian-changelog-add-entry "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-changelog-mode" "\
Add a new change entry to a debian-style changelog.
If called from buffer other than a debian/changelog, this will search
for the debian/changelog file to add the entry to.

\(fn)" t nil)

(autoload 'debian-changelog-mode "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-changelog-mode" "\
Major mode for editing Debian-style change logs.
Runs `debian-changelog-mode-hook' if it exists.

Key bindings:

\\{debian-changelog-mode-map}

If you want to use your debian.org email address for debian/changelog
entries without using it for the rest of your email, use the `customize`
interface to set it, or simply set the variable
`debian-changelog-mailing-address' in your ~/.emacs file, e.g.

 (setq debian-changelog-mailing-address \"myname@debian.org\"))

\(fn)" t nil)
(add-to-list 'auto-mode-alist '("/debian/*NEWS" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("NEWS.Debian" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("/debian/\\([[:lower:][:digit:]][[:lower:][:digit:].+-]+\\.\\)?changelog\\'" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("changelog.Debian" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("changelog.dch" . debian-changelog-mode))

;;;***

;;;### (autoloads (debian-control-mode) "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-control-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-control-mode.el"
;;;;;;  (21085 31204 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-control-mode.el

(autoload 'debian-control-mode "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-control-mode" "\
A major mode for editing Debian control files (i.e. debian/control).

\(fn)" t nil)
(add-to-list 'auto-mode-alist '("/debian/control\\'" . debian-control-mode))

;;;***

;;;### (autoloads (debian-copyright-mode) "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-copyright"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-copyright.el"
;;;;;;  (19536 19929 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-copyright.el

(autoload 'debian-copyright-mode "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/debian-copyright" "\
Mode to edit and read debian/copyright.
\\{debian-copyright-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("debian/.*copyright\\'" . debian-copyright-mode))

(add-to-list 'auto-mode-alist '("\\`/usr/share/doc/.*/copyright" . debian-copyright-mode))

;;;***

;;;### (autoloads (readme-debian-mode) "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/readme-debian"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/readme-debian.el"
;;;;;;  (19181 42024 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/readme-debian.el

(autoload 'readme-debian-mode "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/readme-debian" "\
Mode for reading and editing README.Debian files.
Upon saving the visited README.Debian file, the timestamp at the bottom
will be updated.

\\{readme-debian-mode-map}

\(fn)" t nil)
(add-to-list 'auto-mode-alist '("debian/.*README.*Debian$" . readme-debian-mode))
(add-to-list 'auto-mode-alist '("^/usr/share/doc/.*/README.*Debian.*$" . readme-debian-mode))

;;;***

;;;### (autoloads (align-all-strings align-string) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/align-string"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/align-string.el"
;;;;;;  (21516 22146 328492 708000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/align-string.el

(autoload 'align-string "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/align-string" "\
Align first occurrence of REGEXP in each line of region.
If given a prefix argument, align occurrence number COUNT on each line.

\(fn BEGIN END REGEXP COUNT)" t nil)

(autoload 'align-all-strings "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/align-string" "\
Align all occurrences of REGEXP in each line of region.
That is to say, align the first occurrence of each line with each other,
align the second occurence of each line with each other, and so on.

\(fn BEGIN END REGEXP)" t nil)

;;;***

;;;### (autoloads (all) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/all"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/all.el"
;;;;;;  (16059 54755 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/all.el

(autoload 'all "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/all" "\
Show all lines in the current buffer containing a match for REGEXP.

If a match spreads across multiple lines, all those lines are shown.

Each line is displayed with NLINES lines before and after, or -NLINES
before if NLINES is negative.
NLINES defaults to `list-matching-lines-default-context-lines'.
Interactively it is the prefix arg.

The lines are shown in a buffer named `*All*'.
Any changes made in that buffer will be propagated to this buffer.

\(fn REGEXP &optional NLINES)" t nil)

;;;***

;;;### (autoloads (apache-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/apache-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/apache-mode.el"
;;;;;;  (19103 54677 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/apache-mode.el

(autoload 'apache-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/apache-mode" "\
Major mode for editing Apache configuration files.

\(fn)" t nil)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;;;***

;;;### (autoloads (ascii-off ascii-on ascii-display ascii-customize)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ascii"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ascii.el"
;;;;;;  (21085 36431 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ascii.el

(autoload 'ascii-customize "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ascii" "\
Customize ASCII options.

\(fn)" t nil)

(autoload 'ascii-display "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ascii" "\
Toggle ASCII code display.

If ARG is null, toggle ASCII code display.
If ARG is a number and is greater than zero, turn on display; otherwise, turn
off display.
If ARG is anything else, turn on display.

\(fn &optional ARG)" t nil)

(autoload 'ascii-on "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ascii" "\
Turn on ASCII code display.

\(fn)" t nil)

(autoload 'ascii-off "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ascii" "\
Turn off ASCII code display.

\(fn)" t nil)

;;;***

;;;### (autoloads (bar-cursor-change bar-cursor-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bar-cursor"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bar-cursor.el"
;;;;;;  (21516 22146 338492 709000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bar-cursor.el

(autoload 'bar-cursor-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bar-cursor" "\
Toggle use of variable `bar-cursor-mode'.
This quasi-minor mode changes cursor to a bar cursor in insert mode,
and a block cursor in overwrite mode.  It may only be turned on and
off globally, not on a per-buffer basis (hence the quasi- designation).

Optional ARG turns mode on if ARG is a positive integer.

\(fn &optional ARG)" t nil)

(autoload 'bar-cursor-change "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bar-cursor" "\
Enable or disable advice based on value of variable `bar-cursor-mode'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bm-previous-mouse bm-previous bm-next-mouse bm-next
;;;;;;  bm-toggle-mouse bm-toggle) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm.el"
;;;;;;  (19425 29270 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm.el

(autoload 'bm-toggle "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm" "\
Toggle bookmark at point.

\(fn)" t nil)

(autoload 'bm-toggle-mouse "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm" "\
Toggle a bookmark with a mouse click.
EV is the mouse event.

\(fn EV)" t nil)

(autoload 'bm-next "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm" "\
Goto next bookmark.

\(fn)" t nil)

(autoload 'bm-next-mouse "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm" "\
Go to the next bookmark with the scroll wheel.
EV is the mouse event.

\(fn EV)" t nil)

(autoload 'bm-previous "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm" "\
Goto previous bookmark.

\(fn)" t nil)

(autoload 'bm-previous-mouse "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/bm" "\
Go to the previous bookmark with the scroll wheel.
EV is the mouse event.

\(fn EV)" t nil)

;;;***

;;;### (autoloads (boxquote-unbox boxquote-unbox-region boxquote-fill-paragraph
;;;;;;  boxquote-kill boxquote-narrow-to-boxquote-content boxquote-narrow-to-boxquote
;;;;;;  boxquote-text boxquote-where-is boxquote-shell-command boxquote-describe-key
;;;;;;  boxquote-describe-variable boxquote-describe-function boxquote-boxquote
;;;;;;  boxquote-paragraph boxquote-defun boxquote-yank boxquote-kill-ring-save
;;;;;;  boxquote-insert-buffer boxquote-insert-file boxquote-buffer
;;;;;;  boxquote-region boxquote-title) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote.el"
;;;;;;  (19103 54677 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote.el

(autoload 'boxquote-title "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Set the title of the current boxquote to TITLE.

If TITLE is an empty string the title is removed. Note that the title will
be formatted using `boxquote-title-format'.

\(fn TITLE)" t nil)

(autoload 'boxquote-region "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Draw a box around the left hand side of a region bounding START and END.

\(fn START END)" t nil)

(autoload 'boxquote-buffer "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Apply `boxquote-region' to a whole buffer.

\(fn)" t nil)

(autoload 'boxquote-insert-file "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Insert the contents of a file, boxed with `boxquote-region'.

If `boxquote-title-files' is non-nil the boxquote will be given a title that
is the result of applying `boxquote-file-title-function' to FILENAME.

\(fn FILENAME)" t nil)

(autoload 'boxquote-insert-buffer "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Insert the contents of a buffer, boxes with `boxquote-region'.

If `boxquote-title-buffers' is non-nil the boxquote will be given a title that
is the result of applying `boxquote-buffer-title-function' to BUFFER.

\(fn BUFFER)" t nil)

(autoload 'boxquote-kill-ring-save "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Like `kill-ring-save' but remembers a title if possible.

The title is acquired by calling `boxquote-kill-ring-save-title'. The title
will be used by `boxquote-yank'.

\(fn)" t nil)

(autoload 'boxquote-yank "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Do a `yank' and box it in with `boxquote-region'.

If the yanked entry was placed on the kill ring with
`boxquote-kill-ring-save' the resulting boxquote will be titled with
whatever `boxquote-kill-ring-save-title' returned at the time.

\(fn)" t nil)

(autoload 'boxquote-defun "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Apply `boxquote-region' the current defun.

\(fn)" t nil)

(autoload 'boxquote-paragraph "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Apply `boxquote-region' to the current paragraph.

\(fn)" t nil)

(autoload 'boxquote-boxquote "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Apply `boxquote-region' to the current boxquote.

\(fn)" t nil)

(autoload 'boxquote-describe-function "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Call `describe-function' and boxquote the output into the current buffer.

\(fn)" t nil)

(autoload 'boxquote-describe-variable "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Call `describe-variable' and boxquote the output into the current buffer.

\(fn)" t nil)

(autoload 'boxquote-describe-key "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Call `describe-key' and boxquote the output into the current buffer.

If the call to this command is prefixed with \\[universal-argument] you will also be
prompted for a buffer. The key defintion used will be taken from that buffer.

\(fn KEY)" t nil)

(autoload 'boxquote-shell-command "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Call `shell-command' with COMMAND and boxquote the output.

\(fn COMMAND)" t nil)

(autoload 'boxquote-where-is "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Call `where-is' with DEFINITION and boxquote the result.

\(fn DEFINITION)" t nil)

(autoload 'boxquote-text "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Insert TEXT, boxquoted.

\(fn TEXT)" t nil)

(autoload 'boxquote-narrow-to-boxquote "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Narrow the buffer to the current boxquote.

\(fn)" t nil)

(autoload 'boxquote-narrow-to-boxquote-content "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Narrow the buffer to the content of the current boxquote.

\(fn)" t nil)

(autoload 'boxquote-kill "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Kill the boxquote and its contents.

\(fn)" t nil)

(autoload 'boxquote-fill-paragraph "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Perform a `fill-paragraph' inside a boxquote.

\(fn ARG)" t nil)

(autoload 'boxquote-unbox-region "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Remove a box created with `boxquote-region'.

\(fn START END)" t nil)

(autoload 'boxquote-unbox "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/boxquote" "\
Remove the boxquote that contains `point'.

\(fn)" t nil)

;;;***

;;;### (autoloads (browse-huge-tar-copy-file-at-point browse-huge-tar-view-file-at-point
;;;;;;  browse-huge-tar-file) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-huge-tar"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-huge-tar.el"
;;;;;;  (16313 9500 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-huge-tar.el

(autoload 'browse-huge-tar-file "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-huge-tar" "\
Create a buffer containing a listing of FILENAME as a tar file.

\(fn FILENAME)" t nil)

(autoload 'browse-huge-tar-view-file-at-point "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-huge-tar" "\
Extract the file at the point into a buffer for viewing.

\(fn)" t nil)

(autoload 'browse-huge-tar-copy-file-at-point "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-huge-tar" "\
Extract the file at the point and copy to a local file OUTFILE.
This requires the value of `shell-file-name' to support redirection using \">\".

\(fn OUTFILE)" t nil)

;;;***

;;;### (autoloads (browse-kill-ring browse-kill-ring-default-keybindings)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-kill-ring"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-kill-ring.el"
;;;;;;  (21516 22146 343492 709000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-kill-ring.el

(autoload 'browse-kill-ring-default-keybindings "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-kill-ring" "\
Set up M-y (`yank-pop') so that it can invoke `browse-kill-ring'.
Normally, if M-y was not preceeded by C-y, then it has no useful
behavior.  This function sets things up so that M-y will invoke
`browse-kill-ring'.

\(fn)" t nil)

(autoload 'browse-kill-ring "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/browse-kill-ring" "\
Display items in the `kill-ring' in another buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads (button-lock-unregister-all-global-buttons button-lock-unregister-global-button
;;;;;;  button-lock-register-global-button button-lock-clear-all-buttons
;;;;;;  button-lock-extend-binding button-lock-unset-button button-lock-set-button
;;;;;;  global-button-lock-mode button-lock-mode button-lock-find-extent
;;;;;;  button-lock-button-grouping button-lock-button-pattern button-lock-button-p
;;;;;;  button-lock-button-properties button-lock) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock.el"
;;;;;;  (21436 15353 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock.el

(let ((loads (get 'button-lock 'custom-loads))) (if (member '"emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" loads) nil (put 'button-lock 'custom-loads (cons '"emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" loads))))

(autoload 'button-lock-button-properties "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Return list of properties for BUTTON.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-button-p "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Return t if BUTTON is a button-lock button.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-button-pattern "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Return pattern for BUTTON.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-button-grouping "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Return grouping for BUTTON.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-find-extent "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Find the extent of a button-lock property around some point.

POS defaults to the current point.  PROPERTY defaults to
'button-lock.

Returns a cons in the form (START . END), or nil if there
is no such PROPERTY around POS.

\(fn &optional POS PROPERTY)" nil nil)

(autoload 'button-lock-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Toggle button-lock-mode, a minor mode for making text clickable.

Button-lock uses `font-lock-mode' to create and maintain its text
properties.  Therefore this mode can only be used where
`font-lock-mode' is active.

`button-lock-set-button' may be called to create a new button.
`button-lock-clear-all-buttons' may be called to clear all button
definitions in a buffer.

When called interactively with no prefix argument, this command
toggles the mode. When called interactively, with a prefix
argument, it enables the mode if the argument is positive and
otherwise disables it.  When called from Lisp, it enables the
mode if the argument is omitted or nil, and toggles the mode if
the argument is 'toggle.

\(fn &optional ARG)" t nil)

(defvar global-button-lock-mode nil "\
Non-nil if Global-Button-Lock mode is enabled.
See the command `global-button-lock-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-button-lock-mode'.")

(custom-autoload 'global-button-lock-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" nil)

(autoload 'global-button-lock-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Toggle Button-Lock mode in all buffers.
With prefix ARG, enable Global-Button-Lock mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Button-Lock mode is enabled in all buffers where
`button-lock-maybe-turn-on' would do it.
See `button-lock-mode' for more information on Button-Lock mode.

\(fn &optional ARG)" t nil)

(autoload 'button-lock-set-button "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Attach mouse actions to text via `font-lock-mode'.

Required argument PATTERN is a regular expression to match.

Required argument ACTION is a function to call when the matching
text is clicked.  A quoted function name or a lambda expression
may be given.  The function called by ACTION must be interactive.
If ACTION is not valid the user may experience a silent failure.

If the function called by ACTION uses (interactive \"e\") it may
receive the relevant mouse event.  Note that you may wish to use
the mouse event to reposition the point.

ACTION may alternatively contain a prepared keymap, in which case
the convenience parameters :MOUSE-BINDING, :KEYBOARD-BINDING,
and :KEYBOARD-ACTION will be ignored.

Following PATTERN and ACTION is a Common Lisp-style series of
keyword/value arguments:

Setting :NO-REPLACE causes the function to have no effect when
a button already exists using the given PATTERN.  By default,
any existing button using PATTERN will be replaced.

:FACE is a font face to set on matching text, like hi-lock mode.
By default, :FACE has no properties, and :FACE-POLICY is :APPEND.
This means that other, existing text properties will take
priority, and that clickable text will not be distinguished
without a mouseover.  To change this, try adding the arguments
\":face 'link :face-policy 'prepend.\" Alternatively,
`button-lock-face' may be customized.

:MOUSE-FACE is the font face to set on mouseovers.  It defaults
to `button-lock-mouse-face'.

:FACE-POLICY sets the override policy for button faces.  Useful
values are nil, 'keep, 'prepend, and 'append (the default).  See
the documentation for OVERRIDE in `font-lock-keywords'.

:HELP-ECHO is applied to the 'help-echo text property, and may
become visible in a tooltip depending on your Emacs setup.
:HELP-TEXT is a deprecated synonym.

:KBD-HELP is applied to the 'kbd-help text property, accessible
to the user via `display-local-help',

:KBD-HELP-MULTILINE is applied to the non-standard
'kbd-help-multiline text property.

:GROUPING designates a subgroup in the pattern match to receive
the new text properties.  Subgroups, delimited by parentheses,
are numbered from 1.  The default :GROUPING is 0, indicating the
entire match.

:MOUSE-BINDING sets the mouse event which will invoke ACTION.
The default is 'mouse-1.

:KEYBOARD-BINDING sets a keyboard event which will invoke ACTION.
The format is as accepted by `kbd'.  The default is nil, meaning
no keyboard binding is in effect.  If this is set, it might also
be wise to alert the user by setting :FACE.  Note, the only
difference between :MOUSE-BINDING and :KEYBOARD-BINDING is
that :KEYBOARD-BINDING is interpreted by `kbd'.  It is possible
to pass keyboard events into :MOUSE-BINDING and vice versa.

:KEYBOARD-ACTION is an alternate event to be run by
:KEYBOARD-BINDING.  The default is nil, meaning that
:KEYBOARD-BINDING will invoke ACTION.  This is intended for cases
where ACTION is dependent on the position of the mouse.

:ADDITIONAL-PROPERTY defines an arbitrary text property which
will be set to t in for text which matches PATTERN, as optionally
modified by :GROUPING. The property 'button-lock will always be
set.

As a convenience, :MOUSE-2 through :MOUSE-5 can be used to attach
an alternate ACTION, as can :M-MOUSE-1 ..., :A-MOUSE-1 ...,
:DOUBLE-MOUSE-1 ..., :WHEEL-UP..., and :WHEEL-DOWN... The list is not
exhaustive.  For a general method of adding alternate bindings, pass
a keymap for :ACTION or use `button-lock-extend-binding'.

If :REAR-STICKY is non-nil, the rear-nonsticky text property will
not be added, as it is by default.  Changing this setting is not
recommended.

If :REMOVE is non-nil, any existing button using PATTERN will
be removed and forgotten by font-lock.

If successful, this function returns the button which was added
or removed from `font-lock-keywords'. Otherwise it returns nil.
The button value can be passed to `button-lock-extend-binding'.

\(fn PATTERN ACTION &key (face (quote button-lock-face)) (mouse-face (quote button-lock-mouse-face)) (face-policy (quote append)) HELP-ECHO HELP-TEXT KBD-HELP KBD-HELP-MULTILINE (grouping 0) (mouse-binding (quote mouse-1)) KEYBOARD-BINDING KEYBOARD-ACTION ADDITIONAL-PROPERTY REAR-STICKY REMOVE NO-REPLACE MOUSE-2 MOUSE-3 MOUSE-4 MOUSE-5 WHEEL-DOWN WHEEL-UP DOWN-MOUSE-1 DOWN-MOUSE-2 DOWN-MOUSE-3 DOWN-MOUSE-4 DOWN-MOUSE-5 DOUBLE-MOUSE-1 DOUBLE-MOUSE-2 DOUBLE-MOUSE-3 DOUBLE-MOUSE-4 DOUBLE-MOUSE-5 TRIPLE-MOUSE-1 TRIPLE-MOUSE-2 TRIPLE-MOUSE-3 TRIPLE-MOUSE-4 TRIPLE-MOUSE-5 A-MOUSE-1 A-MOUSE-2 A-MOUSE-3 A-MOUSE-4 A-MOUSE-5 A-WHEEL-DOWN A-WHEEL-UP C-MOUSE-1 C-MOUSE-2 C-MOUSE-3 C-MOUSE-4 C-MOUSE-5 C-WHEEL-DOWN C-WHEEL-UP M-MOUSE-1 M-MOUSE-2 M-MOUSE-3 M-MOUSE-4 M-MOUSE-5 M-WHEEL-DOWN M-WHEEL-UP S-MOUSE-1 S-MOUSE-2 S-MOUSE-3 S-MOUSE-4 S-MOUSE-5 S-WHEEL-DOWN S-WHEEL-UP S-MOUSE-1 S-MOUSE-2 S-MOUSE-3 S-MOUSE-4 S-MOUSE-5 S-WHEEL-DOWN S-WHEEL-UP)" nil nil)

(autoload 'button-lock-unset-button "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Equivalent to running `button-lock-set-button' with :REMOVE set to true.

The syntax is otherwise identical to `button-lock-set-button',
which see.

A single argument BUTTON object may also be passed, which was returned
from `button-lock-set-button'.

\(fn &rest BUTTON)" nil nil)

(autoload 'button-lock-extend-binding "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Add a binding to an existing button.

The principal button creation function `button-lock-set-button'
accepts only a limited subset of mouse bindings when binding
multiple actions.  This function supports arbitrary key bindings
for binding additional actions on a button.

EXISTING-BUTTON is a button value as returned by
`button-lock-set-button'.

ACTION, MOUSE-BINDING and KEYBOARD-BINDING are as documented in
`button-lock-set-button'.  It is possible to pass a nil
MOUSE-BINDING in order to set only a KEYBOARD-BINDING.

When passing a prepared keymap for ACTION, set MOUSE-BINDING
to nil.

\(fn EXISTING-BUTTON ACTION MOUSE-BINDING &optional KEYBOARD-BINDING)" nil nil)

(autoload 'button-lock-clear-all-buttons "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Remove and deactivate all button-lock buttons in the buffer.

If FORCE is non-nil, try to remove buttons even when the minor
mode is not active.

\(fn)" t nil)

(autoload 'button-lock-register-global-button "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Register a global button-lock button definition.

Arguments follow the form of `button-lock-set-button'.

The BUTTON defined here will applied each time the button-lock
minor mode is activated in a buffer.

To see an effect in any given buffer, button-lock mode must be
deactivated and reactivated.

\(fn &rest BUTTON)" nil nil)

(autoload 'button-lock-unregister-global-button "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Remove global button-lock BUTTON.

Arguments follow the form of `button-lock-set-button'.

To see an effect in any given buffer, button-lock mode must be
deactivated and reactivated.

\(fn &rest BUTTON)" nil nil)

(autoload 'button-lock-unregister-all-global-buttons "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/button-lock" "\
Remove all global button-lock buttons definitions.

To see an effect in any given buffer, button-lock mode must be
deactivated and reactivated.

\(fn)" t nil)

;;;***

;;;### (autoloads (color-theme-initialize color-theme-submit color-theme-install
;;;;;;  color-theme-compare color-theme-make-snapshot color-theme-analyze-defun
;;;;;;  color-theme-print color-theme-install-at-point-for-current-frame
;;;;;;  color-theme-install-at-mouse color-theme-describe color-theme-select)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme.el"
;;;;;;  (21516 22146 358492 710000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme.el

(autoload 'color-theme-select "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Displays a special buffer for selecting and installing a color theme.
With optional prefix ARG, this buffer will include color theme libraries
as well.  A color theme library is in itself not complete, it must be
used as part of another color theme to be useful.  Thus, color theme
libraries are mainly useful for color theme authors.

\(fn &optional ARG)" t nil)

(autoload 'color-theme-describe "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Describe color theme listed at point.
This shows the documentation of the value of text-property color-theme
at point.  The text-property color-theme should be a color theme
function.  See `color-themes'.

\(fn)" t nil)

(autoload 'color-theme-install-at-mouse "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Install color theme clicked upon using the mouse.
First argument EVENT is used to set point.  Then
`color-theme-install-at-point' is called.

\(fn EVENT)" t nil)

(autoload 'color-theme-install-at-point-for-current-frame "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Install color theme at point for current frame only.
Binds `color-theme-is-global' to nil and calls
`color-theme-install-at-point'.

\(fn)" t nil)

(autoload 'color-theme-print "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Print the current color theme function.

You can contribute this function to <URL:news:gnu.emacs.sources> or
paste it into your .emacs file and call it.  That should recreate all
the settings necessary for your color theme.

Example:

    (require 'color-theme)
    (defun my-color-theme ()
      \"Color theme by Alex Schroeder, created 2000-05-17.\"
      (interactive)
      (color-theme-install
       '(...
	 ...
	 ...)))
    (my-color-theme)

If you want to use a specific color theme function, you can call the
color theme function in your .emacs directly.

Example:

    (require 'color-theme)
    (color-theme-gnome2)

\(fn &optional BUF)" t nil)

(autoload 'color-theme-analyze-defun "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Once you have a color-theme printed, check for missing faces.
This is used by maintainers who receive a color-theme submission
and want to make sure it follows the guidelines by the color-theme
author.

\(fn)" t nil)

(autoload 'color-theme-make-snapshot "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Return the definition of the current color-theme.
The function returned will recreate the color-theme in use at the moment.

\(fn)" nil nil)

(autoload 'color-theme-compare "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Compare two color themes.
This will print the differences between installing THEME-A and
installing THEME-B.  Note that the order is important: If a face is
defined in THEME-A and not in THEME-B, then this will not show up as a
difference, because there is no reset before installing THEME-B.  If a
face is defined in THEME-B and not in THEME-A, then this will show up as
a difference.

\(fn THEME-A THEME-B)" t nil)

(autoload 'color-theme-install "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Install a color theme defined by frame parameters, variables and faces.

The theme is installed for all present and future frames; any missing
faces are created.  See `color-theme-install-faces'.

THEME is a color theme definition.  See below for more information.

If you want to install a color theme from your .emacs, use the output
generated by `color-theme-print'.  This produces color theme function
which you can copy to your .emacs.

A color theme definition is a list:
\([FUNCTION] FRAME-PARAMETERS VARIABLE-SETTINGS FACE-DEFINITIONS)

FUNCTION is the color theme function which called `color-theme-install'.
This is no longer used.  There was a time when this package supported
automatic factoring of color themes.  This has been abandoned.

FRAME-PARAMETERS is an alist of frame parameters.  These are installed
with `color-theme-install-frame-params'.  These are installed last such
that any changes to the default face can be changed by the frame
parameters.

VARIABLE-DEFINITIONS is an alist of variable settings.  These are
installed with `color-theme-install-variables'.

FACE-DEFINITIONS is an alist of face definitions.  These are installed
with `color-theme-install-faces'.

If `color-theme-is-cumulative' is nil, a color theme will undo face and
frame-parameter settings of previous color themes.

\(fn THEME)" nil nil)

(autoload 'color-theme-submit "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Submit your color-theme to the maintainer.

\(fn)" t nil)

(autoload 'color-theme-initialize "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme" "\
Initialize the color theme package by loading color-theme-libraries.

\(fn)" t nil)

;;;***

;;;### (autoloads (ctypes-read-file ctypes-auto-parse-mode ctypes-file
;;;;;;  ctypes-dir ctypes-tags ctypes-all-buffers ctypes-buffer ctypes-define-type-in-mode
;;;;;;  ctypes-define-type) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes.el"
;;;;;;  (21516 22146 348492 709000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes.el

(autoload 'ctypes-define-type "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Add a new TYPE to current major mode and inform font-lock.

When preceded by C-u the display is not updated.

Return non-nil if the type was not known before.

\(fn TYPE &optional DELAY-ACTION MODE)" t nil)

(autoload 'ctypes-define-type-in-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Add TYPE to major mode MODE and inform font-lock.

When preceded by C-u the display is not updated.

\(This function is designed for interactive use, please call
`ctypes-define-type' from Lisp programs.)

\(fn TYPE &optional DELAY-ACTION MODE)" t nil)

(autoload 'ctypes-buffer "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Search for types in buffer, inform font-lock if any is found.

When preceded by C-u the action is not performed.

Return non-nil if new types are found.

\(fn &optional BUF DELAY-ACTION MODE)" t nil)

(autoload 'ctypes-all-buffers "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Search for types in all buffers, inform font-lock about all discoveries.

When preceded by C-u the display is not updated.

Return non-nil if new types are found.

\(fn &optional DELAY-ACTION)" t nil)

(autoload 'ctypes-tags "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Search for types in files in the visited TAGS table.
Should no tags table be visited, the user will be prompted for a new.

When preceded by C-u the display is not updated.

Return non-nil if new types are found.

\(fn &optional DELAY-ACTION)" t nil)

(autoload 'ctypes-dir "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Search for types in files in a directory hierarchy.

See variable `ctypes-dir-read-file' for a description of which files
are opened during scanning, and how you can change the behavior.

When preceded by C-u the display is not updated.

Return non-nil if new types are found.

\(fn &optional DIR DELAY-ACTION)" t nil)

(autoload 'ctypes-file "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Search for types in file FILE.
Should FILE not be loaded it is read into a temporary buffer.

Return mode of file, if new types was found.

\(fn FILE &optional DELAY-ACTION)" t nil)

(autoload 'ctypes-auto-parse-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Toggle CTypes auto parse mode; search all new buffers for types.
With arg, turn types Auto Mode on if and only if arg is positive.

This a global minor mode, it does not have a private keymap, nor does
it add itself to the mode line.

Place the following in your startup file to enable this feature in
future sessions:

    (require 'ctypes)
    (ctypes-auto-parse-mode 1)

When activated, the functions in the hook `ctypes-auto-parse-mode-hook'
is called with no args.

\(fn &optional ARG)" t nil)

(autoload 'ctypes-read-file "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ctypes" "\
Load types previously saved with `ctypes-write-file'.
The name of the file is given by the optional argument FILE.
Should no file name be given the value of the variable `ctypes-file-name'
is used.

Please note that the types read will be added to the current types.

When preceded by C-u the display is not updated.

The third argument, NO-ERROR, determines whether or not we should
raise an error if there should be any problem loading the file.

Should the fourth argument, QUIETLY, be non-nil no messages are
generated when the file is loaded.

Return non-nil if new types are found.

\(fn &optional FILE DELAY-ACTION NO-ERROR QUIETLY)" t nil)

;;;***

;;;### (autoloads (dedicated-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/dedicated"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/dedicated.el"
;;;;;;  (21516 22146 365492 710000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/dedicated.el

(autoload 'dedicated-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/dedicated" "\
Toggle dedicated minor mode.
With ARG, turn minor mode on if ARG is positive, off otherwise.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (df) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/df"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/df.el"
;;;;;;  (19104 28952 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/df.el

(autoload 'df "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/df" "\
Enables display of space left on any PARTITION in mode-lines.
This display updates automatically every `df-refresh' seconds.

\(fn &optional PARTITION)" t nil)

;;;***

;;;### (autoloads (diminished-minor-modes diminish-maybe-refresh
;;;;;;  diminished-modes diminish-undo diminish) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish.el"
;;;;;;  (21516 22146 378492 710000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish.el

(autoload 'diminish "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish" "\
Diminish mode-line display of minor mode MODE to TO-WHAT (default \"\").

Interactively, enter (with completion) the name of any minor mode, followed
on the next line by what you want it diminished to (default empty string).
The response to neither prompt should be quoted.  However, in Lisp code,
both args must be quoted, the first as a symbol, the second as a string,
as in (diminish 'jiggle-mode \" Jgl\").

The mode-line displays of minor modes usually begin with a space, so
the modes' names appear as separate words on the mode line.  However, if
you're having problems with a cramped mode line, you may choose to use single
letters for some modes, without leading spaces.  Capitalizing them works
best; if you then diminish some mode to \"X\" but have abbrev-mode enabled as
well, you'll get a display like \"AbbrevX\".  This function prepends a space
to TO-WHAT if it's > 1 char long & doesn't already begin with a space.

If ANNOTATE-FLAG is nil or omitted, the normal case in interactive use, then
the variable `diminished-minor-modes' will be modified to reflect the change.

\(fn MODE &optional TO-WHAT ANNOTATE-FLAG)" t nil)

(autoload 'diminish-undo "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish" "\
Restore mode-line display of diminished mode MODE to its minor-mode value.
Do nothing if the arg is a minor mode that hasn't been diminished.

Interactively, enter (with completion) the name of any diminished mode (a
mode that was formerly a minor mode on which you invoked M-x diminish).
To restore all diminished modes to minor status, answer `diminished-modes'.
The response to the prompt shouldn't be quoted.  However, in Lisp code,
the arg must be quoted as a symbol, as in (diminish-undo 'diminished-modes).

If ANNOTATE-FLAG is nil or omitted, the normal case in interactive use, then
the variable `diminished-minor-modes' will be modified to reflect the change.

\(fn MODE &optional ANNOTATE-FLAG)" t nil)

(autoload 'diminished-modes "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish" "\
Echo all active diminished or minor modes as if they were minor.
The display goes in the echo area; if it's too long even for that,
you can see the whole thing in the *Messages* buffer.
This doesn't change the status of any modes; it just lets you see
what diminished modes would be on the mode-line if they were still minor.

\(fn)" t nil)

(autoload 'diminish-maybe-refresh "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish" "\
Should redo `diminish'ing only if something has changed.
Right now, do it regardless and hope this isn't too slow.

\(fn)" t nil)

(defvar diminished-minor-modes nil "\
List of minor modes to diminish and their mode line display strings.
The display string can be the empty string if you want the name of the mode
completely removed from the mode line.  If you prefer, you can abbreviate
the name.  For 2 characters or more will be displayed as a separate word on
the mode line, just like minor modes' names.  A single character will be
scrunched up against the previous word.  Multiple single-letter diminished
modes will all be scrunched together.

The display of undiminished modes will not be affected.")

(custom-autoload 'diminished-minor-modes "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/diminish" nil)

;;;***

;;;### (autoloads (edit-env) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/edit-env"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/edit-env.el"
;;;;;;  (21516 22146 387492 711000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/edit-env.el

(autoload 'edit-env "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/edit-env" "\
Display, edit, delete and add environment variables.

\(fn)" t nil)

;;;***

;;;### (autoloads (egocentric-update-regexp-list egocentric-mode-off
;;;;;;  egocentric-mode-on egocentric-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/egocentric"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/egocentric.el"
;;;;;;  (21516 22146 484492 715000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/egocentric.el

(autoload 'egocentric-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/egocentric" "\
Toggle egocentric mode.
Optional argument ARG is an optional boolean controling whether egocentric-mode should be turned on/off.

\(fn &optional ARG)" t nil)

(autoload 'egocentric-mode-on "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/egocentric" "\
Turn Egocentric mode on.

\(fn)" t nil)

(autoload 'egocentric-mode-off "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/egocentric" "\
Turn Egocentric mode off.

\(fn)" t nil)

(autoload 'egocentric-update-regexp-list "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/egocentric" "\
Update ``egocentric-regexp-list'' from $USER and $NAME variables.

\(fn)" t nil)

;;;***

;;;### (autoloads (eproject-compile eproject-eshell-cd-here eproject-multi-isearch-buffers
;;;;;;  eproject-todo eproject-grep eproject-revisit-project eproject-kill-project-buffers
;;;;;;  eproject-ibuffer eproject-find-file) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras.el"
;;;;;;  (19974 14166 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras.el

(autoload 'eproject-find-file "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Present the user with a list of files in the current project.
to select from, open file when selected.

\(fn)" t nil)

(autoload 'eproject-ibuffer "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Open an IBuffer window showing all buffers in the current project, or named project if PREFIX arg is supplied.

\(fn PREFIX)" t nil)

(autoload 'eproject-kill-project-buffers "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Kill every buffer in the current project, including the current buffer.

If PREFIX is specified, prompt for a project name and kill those
buffers instead.

\(fn PREFIX)" t nil)

(autoload 'eproject-revisit-project "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Given a project name, visit the root directory.

If PREFIX arg is supplied, run `eproject-find-file'.

\(fn PREFIX)" t nil)

(autoload 'eproject-grep "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Search all files in the current project for REGEXP.

\(fn REGEXP)" t nil)

(autoload 'eproject-todo "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Display a project TODO list.

Customize `eproject-todo-expressions' to control what this function looks for.

\(fn)" t nil)

(autoload 'eproject-multi-isearch-buffers "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Do a `multi-isearch' on opened buffers in the current project.

Run `eproject-open-all-project-files' first or just
`eproject-grep' if you want to search all project files.

\(fn)" t nil)

(autoload 'eproject-eshell-cd-here "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
If there is an EShell buffer, cd to the project root in that buffer.

With the prefix arg LOOK-IN-INVISIBLE-BUFFERS looks in buffers that are not currently displayed.

\(fn &optional LOOK-IN-INVISIBLE-BUFFERS)" t nil)

(autoload 'eproject-compile "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject-extras" "\
Run `compile-command' in the project root.

\(fn)" t nil)

;;;***

;;;### (autoloads (ff-paths-install) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ff-paths"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ff-paths.el"
;;;;;;  (20043 15601 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ff-paths.el

(autoload 'ff-paths-install "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/ff-paths" "\
Install ff-paths as a `find-file-not-found-hooks' and to ffap package.

\(fn)" nil nil)

;;;***

;;;### (autoloads (floatbg-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/floatbg"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/floatbg.el"
;;;;;;  (16013 59393 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/floatbg.el

(autoload 'floatbg-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/floatbg" "\
Toggle floatbg mode

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (folding-mode turn-on-folding-mode turn-off-folding-mode
;;;;;;  folding-mode-add-find-file-hook folding-keep-hooked folding-install-hooks
;;;;;;  folding-uninstall-hooks folding-mode-hook-no-regexp folding-mode-string
;;;;;;  folding-inside-mode-name folding-default-mouse-keys-function
;;;;;;  folding-default-keys-function) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding.el"
;;;;;;  (21085 36431 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding.el

(defvar folding-mode nil "\
When Non nil, Folding mode is active in the current buffer.")

(defvar folding-default-keys-function 'folding-bind-default-keys "\
*Function or list of functions used to define keys for Folding mode.
Possible values are:
  folding-bind-default-key
        The standard keymap.

  `folding-bind-backward-compatible-keys'
        Keys used by older versions of Folding mode. This function
        does not conform to Emacs 19.29 style conversions concerning
        key bindings. The prefix key is C - c

  `folding-bind-outline-compatible-keys'
        Define keys compatible with Outline mode.

  `folding-bind-foldout-compatible-keys'
        Define some extra keys compatible with Foldout.

All except `folding-bind-backward-compatible-keys' used the value of
the variable `folding-mode-prefix-key' as prefix the key.
The default is C - c @")

(custom-autoload 'folding-default-keys-function "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" t)

(defvar folding-default-mouse-keys-function 'folding-bind-default-mouse "\
*Function to bind default mouse keys to `folding-mode-map'.")

(custom-autoload 'folding-default-mouse-keys-function "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" t)

(defvar folding-inside-mode-name "Fld" "\
*Mode line addition to show inside levels of 'fold' .")

(custom-autoload 'folding-inside-mode-name "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" t)

(defvar folding-mode-string "Fld" "\
*The minor mode string displayed when mode is on.")

(custom-autoload 'folding-mode-string "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" t)

(defvar folding-mode-hook-no-regexp "RMAIL" "\
*Regexp which disable automatic folding mode turn on for certain files.")

(custom-autoload 'folding-mode-hook-no-regexp "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" t)

(defvar folding-mode-marks-alist nil "\
List of (major-mode . fold mark) default combinations to use.
When Folding mode is started, the major mode is checked, and if there
are fold marks for that major mode stored in `folding-mode-marks-alist',
those marks are used by default. If none are found, the default values
of \"{{{ \" and \"}}}\" are used.

Use function  `folding-add-to-marks-list' to add more fold marks. The function
also explains the alist use in details.

Use function `folding-set-local-variables' if you change the current mode's
folding marks during the session.")

(autoload 'folding-uninstall-hooks "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" "\
Remove hooks set by folding.

\(fn)" nil nil)

(autoload 'folding-install-hooks "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" "\
Install folding hooks.

\(fn)" nil nil)

(autoload 'folding-keep-hooked "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" "\
Make sure hooks are in their places.

\(fn)" nil nil)

(autoload 'folding-mode-add-find-file-hook "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" "\
Append `folding-mode-find-file-hook' to the list `find-file-hooks'.

This has the effect that afterwards, when a folded file is visited, if
appropriate Emacs local variable entries are recognized at the end of
the file, Folding mode is started automatically.

If `inhibit-local-variables' is non-nil, this will not happen regardless
of the setting of `find-file-hooks'.

To declare a file to be folded, put `folded-file: t' in the file's
local variables. eg., at the end of a C source file, put:

/*
Local variables:
folded-file: t
*/

The local variables can be inside a fold.

\(fn)" t nil)

(autoload 'turn-off-folding-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" "\
Turn off folding.

\(fn)" nil nil)

(autoload 'turn-on-folding-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" "\
Turn on folding.

\(fn)" nil nil)

(autoload 'folding-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/folding" "\
A folding-editor-like minor mode. ARG INTER.

These are the basic commands that Folding mode provides:

\\{folding-mode-map}

Keys starting with `folding-mode-prefix-key'

\\{folding-mode-prefix-map}

     folding-convert-buffer-for-printing:
     `\\[folding-convert-buffer-for-printing]'
     Makes a ready-to-print, formatted, unfolded copy in another buffer.

     Read the documentation for the above functions for more information.

Overview

    Folds are a way of hierarchically organizing the text in a file, so
    that the text can be viewed and edited at different levels. It is
    similar to Outline mode in that parts of the text can be hidden from
    view. A fold is a region of text, surrounded by special \"fold marks\",
    which act like brackets, grouping the text. Fold mark pairs can be
    nested, and they can have titles. When a fold is folded, the text is
    hidden from view, except for the first line, which acts like a title
    for the fold.

    Folding mode is a minor mode, designed to cooperate with many other
    major modes, so that many types of text can be folded while they are
    being edited (eg., plain text, program source code, Texinfo, etc.).

Folding-mode function

    If Folding mode is not called interactively (`(called-interactively-p 'interactive)' is nil),
    and it is called with two or less arguments, all of which are nil, then
    the point will not be altered if `folding-folding-on-startup' is set
    and `folding-whole-buffer' is called. This is generally not a good
    thing, as it can leave the point inside a hidden region of a fold, but
    it is required if the local variables set \"mode: folding\" when the
    file is first read (see `hack-local-variables').

    Not that you should ever want to, but to call Folding mode from a
    program with the default behavior (toggling the mode), call it with
    something like `(folding-mode nil t)'.

Fold marks

    For most types of folded file, lines representing folds have \"{{{\"
    near the beginning. To enter a fold, move the point to the folded line
    and type `\\[folding-shift-in]'. You should no longer be able to see
    the rest of the file, just the contents of the fold, which you couldn't
    see before. You can use `\\[folding-shift-out]' to leave a fold, and
    you can enter and exit folds to move around the structure of the file.

    All of the text is present in a folded file all of the time. It is just
    hidden. Folded text shows up as a line (the top fold mark) with \"...\"
    at the end. If you are in a fold, the mode line displays \"inside n
    folds Narrow\", and because the buffer is narrowed you can't see outside
    of the current fold's text.

    By arranging sections of a large file in folds, and maybe subsections
    in sub-folds, you can move around a file quickly and easily, and only
    have to scroll through a couple of pages at a time. If you pick the
    titles for the folds carefully, they can be a useful form of
    documentation, and make moving though the file a lot easier. In
    general, searching through a folded file for a particular item is much
    easier than without folds.

Managing folds

    To make a new fold, set the mark at one end of the text you want in the
    new fold, and move the point to the other end. Then type
    `\\[folding-fold-region]'. The text you selected will be made into a
    fold, and the fold will be entered. If you just want a new, empty fold,
    set the mark where you want the fold, and then create a new fold there
    without moving the point. Don't worry if the point is in the middle of
    a line of text, `folding-fold-region' will not break text in the middle
    of a line. After making a fold, the fold is entered and the point is
    positioned ready to enter a title for the fold. Do not delete the fold
    marks, which are usually something like \"{{{\" and \"}}}\". There may
    also be a bit of fold mark which goes after the fold title.

    If the fold markers get messed up, or you just want to see the whole
    unfolded file, use `\\[folding-open-buffer]' to unfolded the whole
    file, so you can see all the text and all the marks. This is useful for
    checking/correcting unbalanced fold markers, and for searching for
    things. Use `\\[folding-whole-file]' to fold the buffer again.

    `folding-shift-out' will attempt to tidy the current fold just before
    exiting it. It will remove any extra blank lines at the top and bottom,
    (outside the fold marks). It will then ensure that fold marks exists,
    and if they are not, will add them (after asking). Finally, the number
    of blank lines between the fold marks and the contents of the fold is
    set to 1 (by default).

Folding package customizations

    If the fold marks are not set on entry to Folding mode, they are set to
    a default for current major mode, as defined by
    `folding-mode-marks-alist' or to \"{{{ \" and \"}}}\" if none are
    specified.

    To bind different commands to keys in Folding mode, set the bindings in
    the keymap `folding-mode-map'.

    The hooks `folding-mode-hook' and `<major-mode-name>-folding-hook' are
    called before folding the buffer and applying the key bindings in
    `folding-mode-map'. This is a good hook to set extra or different key
    bindings in `folding-mode-map'. Note that key bindings in
    `folding-mode-map' are only examined just after calling these hooks;
    new bindings in those maps only take effect when Folding mode is being
    started. The hook `folding-load-hook' is called when Folding mode is
    loaded into Emacs.

Mouse behavior

    If you want folding to detect point of actual mouse click, please see
    variable `folding-mouse-yank-at-p'.

    To customise the mouse actions, look at `folding-behave-table'.

\(fn &optional ARG INTER)" t nil)

;;;***

;;;### (autoloads (framepop-display-buffer framepop-enable framepop-disable)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/framepop"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/framepop.el"
;;;;;;  (16269 22230 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/framepop.el

(autoload 'framepop-disable "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/framepop" "\
Disable automatic pop-up temporary windows.

\(fn)" t nil)

(autoload 'framepop-enable "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/framepop" "\
Enable automatic pop-up temporary windows.

\(fn)" t nil)

(autoload 'framepop-display-buffer "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/framepop" "\
Display-buffer for FramePop.
Displays BUF in a separate frame -- the FramePop frame.
BUF bay be a buffer or a buffer name.

You can display a buffer in the FramePop frame with \\[framepop-display-buffer].

Several commands are available for manipulating the FramePop frame after
typing the keymap prefix (default F2).

\\{framepop-map}

\(fn BUF)" t nil)

;;;***

;;;### (autoloads (graphviz-dot-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/graphviz-dot-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/graphviz-dot-mode.el"
;;;;;;  (19810 28840 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/graphviz-dot-mode.el

(autoload 'graphviz-dot-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/graphviz-dot-mode" "\
Major mode for the dot language. \\<graphviz-dot-mode-map> 
TAB indents for graph lines. 

\\[graphviz-dot-indent-graph]	- Indentaion function.
\\[graphviz-dot-preview]	- Previews graph in a buffer.
\\[graphviz-dot-view]	- Views graph in an external viewer.
\\[graphviz-dot-indent-line]	- Indents current line of code.
\\[graphviz-dot-complete-word]	- Completes the current word.
\\[electric-graphviz-dot-terminate-line]	- Electric newline.
\\[electric-graphviz-dot-open-brace]	- Electric open braces.
\\[electric-graphviz-dot-close-brace]	- Electric close braces.
\\[electric-graphviz-dot-semi]	- Electric semi colons.

Variables specific to this mode:

  graphviz-dot-dot-program            (default `dot')
       Location of the dot program.
  graphviz-dot-view-command           (default `doted %s')
       Command to run when `graphviz-dot-view' is executed.
  graphviz-dot-view-edit-command      (default nil)
       If the user should be asked to edit the view command.
  graphviz-dot-save-before-view       (default t)
       Automatically save current buffer berore `graphviz-dot-view'.
  graphviz-dot-preview-extension      (default `png')
       File type to use for `graphviz-dot-preview'.
  graphviz-dot-auto-indent-on-newline (default t)
       Whether to run `electric-graphviz-dot-terminate-line' when 
       newline is entered.
  graphviz-dot-auto-indent-on-braces (default t)
       Whether to run `electric-graphviz-dot-open-brace' and
       `electric-graphviz-dot-close-brace' when braces are 
       entered.
  graphviz-dot-auto-indent-on-semi (default t)
       Whether to run `electric-graphviz-dot-semi' when semi colon
       is typed.
  graphviz-dot-toggle-completions  (default nil)
       If completions should be displayed in the buffer instead of a
       completion buffer when \\[graphviz-dot-complete-word] is
       pressed repeatedly.

This mode can be customized by running \\[graphviz-dot-customize].

Turning on Graphviz Dot mode calls the value of the variable 
`graphviz-dot-mode-hook' with no args, if that value is non-nil.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.dot\\'" . graphviz-dot-mode))

;;;***

;;;### (autoloads (highlight-beyond-fill-column) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-beyond-fill-column"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-beyond-fill-column.el"
;;;;;;  (21516 22146 419492 712000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-beyond-fill-column.el

(autoload 'highlight-beyond-fill-column "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-beyond-fill-column" "\
Setup this buffer to highlight beyond the `fill-column'.

\(fn)" t nil)

;;;***

;;;### (autoloads (highlight-current-line-minor-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-current-line"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-current-line.el"
;;;;;;  (19104 31300 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-current-line.el

(autoload 'highlight-current-line-minor-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-current-line" "\
Toggle highlight-current-line minor mode.
With ARG, turn minor mode on if ARG is positive, off otherwise.
You can customize the face of the highlighted line and whether the entire
line is hightlighted by customizing the group highlight-current-line.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (home-end-end home-end-home) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/home-end"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/home-end.el"
;;;;;;  (19812 22000 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/home-end.el

(autoload 'home-end-home "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/home-end" "\
Go to beginning of line/window/buffer.
First hitting key goes to beginning of line, second in a row goes to
beginning of window, third in a row goes to beginning of buffer.

\(fn &optional ARG)" t nil)

(autoload 'home-end-end "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/home-end" "\
Go to end of line/window/buffer.
First hitting key goes to end of line, second in a row goes to end
of window, third in a row goes to end of buffer.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (htmlize-many-files-dired htmlize-many-files htmlize-file
;;;;;;  htmlize-region htmlize-buffer) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize.el"
;;;;;;  (19103 48317 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize.el

(autoload 'htmlize-buffer "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize" "\
Convert BUFFER to HTML, preserving colors and decorations.

The generated HTML is available in a new buffer, which is returned.
When invoked interactively, the new buffer is selected in the current
window.  The title of the generated document will be set to the buffer's
file name or, if that's not available, to the buffer's name.

Note that htmlize doesn't fontify your buffers, it only uses the
decorations that are already present.  If you don't set up font-lock or
something else to fontify your buffers, the resulting HTML will be
plain.  Likewise, if you don't like the choice of colors, fix the mode
that created them, or simply alter the faces it uses.

\(fn &optional BUFFER)" t nil)

(autoload 'htmlize-region "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize" "\
Convert the region to HTML, preserving colors and decorations.
See `htmlize-buffer' for details.

\(fn BEG END)" t nil)

(autoload 'htmlize-file "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize" "\
Load FILE, fontify it, convert it to HTML, and save the result.

Contents of FILE are inserted into a temporary buffer, whose major mode
is set with `normal-mode' as appropriate for the file type.  The buffer
is subsequently fontified with `font-lock' and converted to HTML.  Note
that, unlike `htmlize-buffer', this function explicitly turns on
font-lock.  If a form of highlighting other than font-lock is desired,
please use `htmlize-buffer' directly on buffers so highlighted.

Buffers currently visiting FILE are unaffected by this function.  The
function does not change current buffer or move the point.

If TARGET is specified and names a directory, the resulting file will be
saved there instead of to FILE's directory.  If TARGET is specified and
does not name a directory, it will be used as output file name.

\(fn FILE &optional TARGET)" t nil)

(autoload 'htmlize-many-files "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize" "\
Convert FILES to HTML and save the corresponding HTML versions.

FILES should be a list of file names to convert.  This function calls
`htmlize-file' on each file; see that function for details.  When
invoked interactively, you are prompted for a list of files to convert,
terminated with RET.

If TARGET-DIRECTORY is specified, the HTML files will be saved to that
directory.  Normally, each HTML file is saved to the directory of the
corresponding source file.

\(fn FILES &optional TARGET-DIRECTORY)" t nil)

(autoload 'htmlize-many-files-dired "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/htmlize" "\
HTMLize dired-marked files.

\(fn ARG &optional TARGET-DIRECTORY)" t nil)

;;;***

;;;### (autoloads (joc-toggle-buffer) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-buffer"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-buffer.el"
;;;;;;  (21516 22146 427492 713000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-buffer.el

(autoload 'joc-toggle-buffer "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-buffer" "\
Switch to previous active buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads (joc-toggle-case-by-region joc-toggle-case-by-word-backwards
;;;;;;  joc-toggle-case-by-word joc-toggle-case-backwards joc-toggle-case)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case.el"
;;;;;;  (21516 22146 423492 712000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case.el

(autoload 'joc-toggle-case "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case" "\
Toggle the case of the character under point.
If called with a PREFIX argument, it toggles that many
characters (see joc-toggle-case-stop-at-eol).  If the prefix is
negative, the case of the character before point is toggled, and
if called with a prefix argument, N characters before point will
have their case toggled (see also joc-toggle-case-backwards).

\(fn PREFIX)" t nil)

(autoload 'joc-toggle-case-backwards "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case" "\
Convenience function to toggle case of character preceeding point.
This is the same as calling joc-toggle-case with a negative
prefix (and is in fact implemented that way).

\(fn PREFIX)" t nil)

(autoload 'joc-toggle-case-by-word "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case" "\
Similar to joc-toggle-case except that the count (supplied by
the prefix argument) is of the number of words, not letters, to
be toggled.  It will start from point and move to the end of
the first word at a minimum, and then take whole words from
there.  If called with a negative prefix, then from point to
beginning of current word will have their case toggled, going
backwards for N words (see also
joc-toggle-case-by-word-backwards).  Note that the
joc-toggle-case-stop-at-eol setting will be honored.

\(fn PREFIX)" t nil)

(autoload 'joc-toggle-case-by-word-backwards "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case" "\
Convenience function to toggle case by word, backwards.
This is the same as calling joc-toggle-case-by-word with a
negative prefix (and is in fact implemented that way).

\(fn PREFIX)" t nil)

(autoload 'joc-toggle-case-by-region "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/joc-toggle-case" "\
Toggles the case of all characters in the current region.

\(fn START END)" t nil)

;;;***

;;;### (autoloads (keydef) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/keydef"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/keydef.el"
;;;;;;  (16013 59398 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/keydef.el

(autoload 'keydef "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/keydef" "\
Define the key sequence SEQ, written in kbd form, to run CMD.
CMD is automatically wrapped in an anonymous interactive function if it
is Emacs Lisp code rather than a command name. SEQ may also have the form
\(MODE SEQ) where the car is a mode name; for example

  (keydef (latex \"C-c %\") comment-region)

means to define the given key in latex-mode-map. And this will work even
if latex-mode is not loaded yet, provided that it is possible to deduce
the file that it will be loaded from, either from the autoload info or
by searching for a matching file name in the Emacs load path.

For best results, the \"mode name\" that you use here should yield the
proper foo-mode-map symbol when \"-mode-map\" is appended; although
this will normally match the mode name as given in the mode line,
Shell-script is one example I can think of where it doesn't---the map is
named sh-mode-map. The common cases that I know about, including
shell-script-mode and latex-mode, are handled as exceptions through the
variable mode-map-alist. But for other cases you will need to look up
the name of the mode-map that goes with the given mode.

\(fn SEQ &rest CMD)" nil t)

;;;***

;;;### (autoloads (lcomp-keys-mode lcomp-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/lcomp"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/lcomp.el"
;;;;;;  (19331 13881 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/lcomp.el

(defvar lcomp-mode nil "\
Non-nil if Lcomp mode is enabled.
See the command `lcomp-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `lcomp-mode'.")

(custom-autoload 'lcomp-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/lcomp" nil)

(autoload 'lcomp-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/lcomp" "\
Auto close completion window mode.

\(fn &optional ARG)" t nil)

(defvar lcomp-keys-mode nil "\
Non-nil if Lcomp-Keys mode is enabled.
See the command `lcomp-keys-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `lcomp-keys-mode'.")

(custom-autoload 'lcomp-keys-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/lcomp" nil)

(autoload 'lcomp-keys-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/lcomp" "\
Add keybindings to the completions buffer.

\\{lcomp-keys-override-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (map-lines-copy map-lines-kill copy-line map-lines)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/map-lines"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/map-lines.el"
;;;;;;  (19381 25289 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/map-lines.el

(autoload 'map-lines "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/map-lines" "\
Map a COMMAND-C (kill, copying, or a custom command) over lines matching REGEX.

\(fn COMMAND-C REGEX)" t nil)

(autoload 'copy-line "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/map-lines" "\
Copy a whole line to the kill ring.

\(fn)" t nil)

(autoload 'map-lines-kill "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/map-lines" "\
Kill all lines matching REGEX.  Yanking will insert all killed lines.

\(fn REGEX)" t nil)

(autoload 'map-lines-copy "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/map-lines" "\
Copy all lines matching REGEX to the kill ring.  Yanking will insert all such lines.

\(fn REGEX)" t nil)

;;;***

;;;### (autoloads (gfm-mode markdown-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/markdown-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/markdown-mode.el"
;;;;;;  (21085 32319 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/markdown-mode.el

(autoload 'markdown-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/markdown-mode" "\
Major mode for editing Markdown files.

\(fn)" t nil)

(autoload 'gfm-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/markdown-mode" "\
Major mode for editing GitHub Flavored Markdown files.

\(fn)" t nil)

;;;***

;;;### (autoloads (marker-visit-truncate-mark-ring marker-visit-next
;;;;;;  marker-visit-prev) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/marker-visit"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/marker-visit.el"
;;;;;;  (21516 22146 435492 713000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/marker-visit.el

(autoload 'marker-visit-prev "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/marker-visit" "\
From point, visit the nearest mark earlier in the buffer.

\(fn)" t nil)

(autoload 'marker-visit-next "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/marker-visit" "\
From point, visit the nearest mark later in the buffer.

\(fn)" t nil)

(autoload 'marker-visit-truncate-mark-ring "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/marker-visit" "\
Truncate the `mark-ring'.

\(fn)" t nil)

;;;***

;;;### (autoloads (matlab-shell matlab-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/matlab"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/matlab.el"
;;;;;;  (21085 36431 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/matlab.el

(add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))

(autoload 'matlab-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/matlab" "\
MATLAB(R) mode is a major mode for editing MATLAB dot-m files.
\\<matlab-mode-map>
Convenient editing commands are:
 \\[matlab-comment-region]   - Comment/Uncomment out a region of code.
 \\[matlab-fill-comment-line] - Fill the current comment line.
 \\[matlab-fill-region] - Fill code and comments in region.
 \\[matlab-fill-paragraph]     - Refill the current command or comment.
 \\[matlab-complete-symbol]   - Symbol completion of matlab symbolsbased on the local syntax.
 \\[matlab-indent-sexp] - Indent syntactic block of code.

Convenient navigation commands are:
 \\[matlab-beginning-of-command]   - Move to the beginning of a command.
 \\[matlab-end-of-command]   - Move to the end of a command.
 \\[matlab-beginning-of-defun] - Move to the beginning of a function.
 \\[matlab-end-of-defun] - Move do the end of a function.
 \\[matlab-forward-sexp] - Move forward over a syntactic block of code.
 \\[matlab-backward-sexp] - Move backwards over a syntactic block of code.

Convenient template insertion commands:
 \\[tempo-template-matlab-function] - Insert a function definition.
 \\[tempo-template-matlab-if] - Insert an IF END block.
 \\[tempo-template-matlab-for] - Insert a FOR END block.
 \\[tempo-template-matlab-switch] - Insert a SWITCH END statement.
 \\[matlab-insert-next-case] - Insert the next CASE condition in a SWITCH.
 \\[matlab-insert-end-block] - Insert a matched END statement.  With optional ARG, reindent.
 \\[matlab-stringify-region] - Convert plaintext in region to a string with correctly quoted chars.

Variables:
  `matlab-indent-level'		Level to indent blocks.
  `matlab-cont-level'		Level to indent continuation lines.
  `matlab-cont-requires-ellipsis' Does your MATLAB support implied elipsis.
  `matlab-case-level'		Level to unindent case statements.
  `matlab-indent-past-arg1-functions'
                                Regexp of functions to indent past the first
                                  argument on continuation lines.
  `matlab-maximum-indents'      List of maximum indents during lineups.
  `matlab-comment-column'       Goal column for on-line comments.
  `fill-column'			Column used in auto-fill.
  `matlab-indent-function-body' If non-nil, indents body of MATLAB functions.
  `matlab-functions-have-end'	If non-nil, MATLAB functions terminate with end.
  `matlab-return-function'	Customize RET handling with this function.
  `matlab-auto-fill'            Non-nil, do auto-fill at startup.
  `matlab-fill-code'            Non-nil, auto-fill code.
  `matlab-fill-strings'         Non-nil, auto-fill strings.
  `matlab-verify-on-save-flag'  Non-nil, enable code checks on save.
  `matlab-highlight-block-match-flag'
                                Enable matching block begin/end keywords.
  `matlab-vers-on-startup'	If t, show version on start-up.
  `matlab-handle-simulink'      If t, enable simulink keyword highlighting.

All Key Bindings:
\\{matlab-mode-map}

\(fn)" t nil)

(autoload 'matlab-shell "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/matlab" "\
Create a buffer with MATLAB running as a subprocess.

MATLAB shell cannot work on the MS Windows platform because MATLAB is not
a console application.

\(fn)" t nil)

;;;***

;;;### (autoloads (miniedit-install-for-xemacs miniedit-install miniedit
;;;;;;  miniedit-introduction miniedit-quick-start) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit.el"
;;;;;;  (19387 53923 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit.el

(autoload 'miniedit-quick-start "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit" "\
Provides electric help for function `miniedit-quick-start'.

\(fn)" t nil)

(autoload 'miniedit-introduction "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit" "\
Provides electric help for function `miniedit-introduction'.

\(fn)" t nil)

(autoload 'miniedit "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit" "\
The main miniedit function.

\(fn)" t nil)

(autoload 'miniedit-install "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit" "\
Install miniedit by frobbing your miniedit-local maps.

\(fn)" t nil)

(autoload 'miniedit-install-for-xemacs "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/miniedit" "\
Try to Install miniedit for Xemacs.

\(fn)" t nil)

;;;***

;;;### (autoloads (muttrc-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/muttrc-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/muttrc-mode.el"
;;;;;;  (19030 17715 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/muttrc-mode.el

(autoload 'muttrc-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/muttrc-mode" "\
Major mode for editing Muttrc files.
This function ends by invoking the function(s) `muttrc-mode-hook'.

\\{muttrc-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads (nuke-trailing-whitespace) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/nuke-trailing-whitespace"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/nuke-trailing-whitespace.el"
;;;;;;  (19104 31301 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/nuke-trailing-whitespace.el

(autoload 'nuke-trailing-whitespace "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/nuke-trailing-whitespace" "\
Nuke all trailing whitespace in the buffer.
Whitespace in this case is just spaces or tabs.
This is a useful function to put on write-file-hooks.

Unless called interactively, this function uses
`nuke-trailing-whitespace-p' to determine how to behave.
However, even if this variable is `t', this function will query for
replacement if the buffer is read-only.

\(fn)" t nil)

;;;***

;;;### (autoloads (obfuscate-url) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/obfusurl"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/obfusurl.el"
;;;;;;  (18431 47702 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/obfusurl.el

(autoload 'obfuscate-url "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/obfusurl" "\
Obfuscate an URL under `point'.

This might be useful if you're writing out an URL for someone but the URL
itself is a spoiler. The URL will still work but it won't be readable (by
most mortals anyway).

\(fn)" t nil)

;;;***

;;;### (autoloads (pack-windows) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pack-windows"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pack-windows.el"
;;;;;;  (16313 9500 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pack-windows.el

(autoload 'pack-windows "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pack-windows" "\
Resize all windows vertically to display as much information as possible.

Only windows that are on the left edge of the frame are taken into
account. The vertical space available in the frame is first divided
among all these windows. Then any window requireing less lines than it
got to display its whole buffer is shrinked, and the freed space is
divided equally among all the other windows.

If some vertical space remains afterwards, it is given in totality to
the currently selected window.

Do not shrink any window to less than `window-min-height'.

Shrink windows iteratively, performing at most `pack-windows-max-iteration'
iterations. The number of iterations really performed will be
displayed in the echo area if `pack-windows-verbose' is non-nil.

\(fn)" t nil)

;;;***

;;;### (autoloads (perldoc-perl-hook perldoc-at-point perldoc) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/perldoc"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/perldoc.el"
;;;;;;  (19536 18952 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/perldoc.el

(autoload 'perldoc "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/perldoc" "\
Run perldoc on the given STRING.
If the string is a recognised function then we can call `perldoc-function',
otherwise we call `perldoc-module'.
A non-nil interactive argument forces the caches to be updated.

\(fn &optional STRING RE-CACHE)" t nil)

(autoload 'perldoc-at-point "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/perldoc" "\
Call `perldoc' for string at point.

\(fn)" t nil)

(autoload 'perldoc-perl-hook "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/perldoc" "\
A hook which binds F1 to `perldoc-at-point'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (pod-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pod-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pod-mode.el"
;;;;;;  (19536 20515 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pod-mode.el

(autoload 'pod-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pod-mode" "\
Major mode for editing POD files (Plain Old Documentation for Perl).

Commands:\\<pod-mode-map>
\\[pod-link]  `pod-link'
\\[pod-link-section]     `pod-link-section'
\\[pod-link-module]     `pod-link-module'
\\[pod-link-module-section]     `pod-link-module-section'

Turning on pod mode calls the hooks in `pod-mode-hook'.

\(fn)" t nil)

;;;***

;;;### (autoloads (refresh-pretty-control-l pp^L-^L-display-table-entry
;;;;;;  pp^L-^L-string Pretty-Control-L) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l.el"
;;;;;;  (19416 52725 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l.el

(let ((loads (get 'Pretty-Control-L 'custom-loads))) (if (member '"emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l" loads) nil (put 'Pretty-Control-L 'custom-loads (cons '"emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l" loads))))

(defface pp^L-highlight (if (> emacs-major-version 21) '((((type x w32 mac graphic) (class color)) (:box (:line-width 3 :style pressed-button))) (t (:inverse-video t))) '((((type x w32 mac graphic) (class color)) (:foreground "Blue" :background "DarkSeaGreen1")) (t (:inverse-video t)))) "\
*Face used to highlight `pp^L-^L-vector'." :group (quote Pretty-Control-L) :group (quote faces))

(defvar pp^L-^L-string "          Section (Printable Page)          " "\
*Highlighted string displayed in place of each Control-l (^L) character.
If `pp^L-^L-string-function' is non-nil, then the string that function
returns is used instead of `pp^L-^L-string'.")

(custom-autoload 'pp^L-^L-string "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l" t)

(unless (fboundp 'define-minor-mode) (defcustom pretty-control-l-mode nil "*Toggle pretty display of Control-l (`^L') characters.\nSetting this variable directly does not take effect;\nuse either \\[customize] or command `pretty-control-l-mode'." :set (lambda (symbol value) (pretty-control-l-mode (if value 1 -1))) :initialize 'custom-initialize-default :type 'boolean :group 'Pretty-Control-L))

(autoload 'pp^L-^L-display-table-entry "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l" "\
Returns the display-table entry for Control-l (`^L') char in WINDOW.
A vector determining how a Control-l character is displayed in WINDOW.
Either a vector of characters or nil.  The characters are displayed in
place of the Control-l character.  nil means `^L' is displayed.

In effect, this concatenates `pp^L-^L-string-pre', `pp^L-^L-string',
and `pp^L-^L-string-post'.

\(fn WINDOW)" nil nil)

(if (fboundp 'define-minor-mode) (eval '(define-minor-mode pretty-control-l-mode "Toggle pretty display of Control-l (`^L') characters.\nWith ARG, turn pretty display of `^L' on if and only if ARG is positive." :init-value nil :global t :group 'Pretty-Control-L :link `(url-link :tag "Send Bug Report" ,(concat "mailto:" "drew.adams" "@" "oracle" ".com?subject=pp-c-l.el bug: &body=Describe bug here, starting with `emacs -q'.  Don't forget to mention your Emacs and library versions.")) :link '(url-link :tag "Other Libraries by Drew" "http://www.emacswiki.org/cgi-bin/wiki/DrewsElispLibraries") :link '(url-link :tag "Download" "http://www.emacswiki.org/cgi-bin/wiki/pp-c-l.el") :link '(url-link :tag "Description" "http://www.emacswiki.org/cgi-bin/wiki/PrettyControlL") :link '(emacs-commentary-link :tag "Commentary" "pp-c-l") (if pretty-control-l-mode (add-hook 'window-configuration-change-hook 'refresh-pretty-control-l) (remove-hook 'window-configuration-change-hook 'refresh-pretty-control-l)) (walk-windows (lambda (window) (let ((display-table (or (window-display-table window) (make-display-table)))) (aset display-table 12 (and pretty-control-l-mode (pp^L-^L-display-table-entry window))) (set-window-display-table window display-table))) 'no-minibuf 'visible))) (defun pretty-control-l-mode (&optional arg) "Toggle pretty display of Control-l (`^L') characters.\nWith ARG, turn pretty display of `^L' on if and only if ARG is positive." (interactive "P") (setq pretty-control-l-mode (if arg (> (prefix-numeric-value arg) 0) (not pretty-control-l-mode))) (if pretty-control-l-mode (add-hook 'window-configuration-change-hook 'refresh-pretty-control-l) (remove-hook 'window-configuration-change-hook 'refresh-pretty-control-l)) (walk-windows (lambda (window) (let ((display-table (or (window-display-table window) (make-display-table)))) (aset display-table 12 (and pretty-control-l-mode (pp^L-^L-display-table-entry window))) (set-window-display-table window display-table))) 'no-minibuf 'visible)))

(autoload 'refresh-pretty-control-l "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/pp-c-l" "\
Reinitialize `pretty-control-l-mode', if on, to update the display.

\(fn)" t nil)

;;;***

;;;### (autoloads (project-add) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/projects"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/projects.el"
;;;;;;  (19487 45802 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/projects.el

(autoload 'project-add "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/projects" "\
Add the project named NAME with root directory DIRECTORY.

\(fn NAME DIRECTORY)" t nil)

;;;***

;;;### (autoloads (protect-process-buffer-from-kill-mode protect-buffer-from-kill-mode)
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protbuf"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protbuf.el"
;;;;;;  (21516 22146 454492 714000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protbuf.el

(defvar protect-buffer-from-kill-mode nil "\
*If non-nil, then prevent buffer from being accidentally killed.
This variable is local to all buffers.")

(defvar protect-process-buffer-from-kill-mode nil "\
*If non-nil, then protect buffer with live process from being killed.
This variable is local to all buffers.")

(defvar protect-process-buffer-from-kill-preserve-function nil "\
*Function to run to determine whether to kill a process buffer.
If function returns non-nil, buffer is preserved.  Otherwise, the buffer
may be killed.

If this variable is undefined, default action is to test whether a process
object is using this buffer as a process buffer.

This variable is buffer-local when set.")

(autoload 'protect-buffer-from-kill-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protbuf" "\
Toggle `kill-buffer' protection on current buffer.
Optionally, set a PREFIX argument to set or unset protection, and specify
alternate BUFFER.

\(fn &optional PREFIX BUFFER)" t nil)

(autoload 'protect-process-buffer-from-kill-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protbuf" "\
Toggle `kill-buffer' protection on current buffer with active process.
Protection only applies as long as the buffer has an active process.
Optionally, set a PREFIX argument to set or unset protection, and specify
alternate BUFFER.

\(fn &optional PREFIX BUFFER)" t nil)

;;;***

;;;### (autoloads (protocols-clear-cache protocols-lookup) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protocols"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protocols.el"
;;;;;;  (18431 47702 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protocols.el

(autoload 'protocols-lookup "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protocols" "\
Find a protocol and display its details.

\(fn SEARCH)" t nil)

(autoload 'protocols-clear-cache "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/protocols" "\
Clear the protocols \"cache\".

\(fn)" t nil)

;;;***

;;;### (autoloads (quack-install quack-pltfile-mode quack-scheme-mode-hookfunc
;;;;;;  quack-inferior-scheme-mode-hookfunc) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/quack"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/quack.el"
;;;;;;  (21516 22146 481492 715000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/quack.el
(add-to-list 'auto-mode-alist '("\\.plt\\'" . quack-pltfile-mode))

(autoload 'quack-inferior-scheme-mode-hookfunc "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/quack" "\


\(fn)" nil nil)

(autoload 'quack-scheme-mode-hookfunc "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/quack" "\


\(fn)" nil nil)

(autoload 'quack-pltfile-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/quack" "\


\(fn)" t nil)

(autoload 'quack-install "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/quack" "\
Install quack.el into scheme-mode.

\(fn)" nil nil)

;;;***

;;;### (autoloads (rfcview-mode rfcview-find-index rfcview-find-rfc
;;;;;;  rfcview-customize) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/rfcview"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/rfcview.el"
;;;;;;  (21085 36431 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/rfcview.el

(autoload 'rfcview-customize "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/rfcview" "\
Enter the RFCview Custom group.

\(fn)" t nil)

(autoload 'rfcview-find-rfc "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/rfcview" "\
Find RFC NUMBER and view it in RFcview mode.
Interactively, prompt for the number.
See `rfcview-rfc-location-pattern' for where to search.

\(fn NUMBER)" t nil)

(autoload 'rfcview-find-index "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/rfcview" "\
Find the RFC index and hyperlink it.

\(fn)" t nil)

(autoload 'rfcview-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/rfcview" "\
Major mode for viewing Internet RFCs.

http://www.loveshack.ukfsn.org/emacs/rfcview.el
http://www.neilvandyke.org/rfcview/

Key bindings:
\\{rfcview-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads (services-clear-cache services-lookup) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/services"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/services.el"
;;;;;;  (18431 47702 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/services.el

(autoload 'services-lookup "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/services" "\
Find a service and display its details.

\(fn SEARCH PROTOCOL)" t nil)

(autoload 'services-clear-cache "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/services" "\
Clear the services \"cache\".

\(fn)" t nil)

;;;***

;;;### (autoloads (session-jump-to-last-change) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/session"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/session.el"
;;;;;;  (21516 22146 443492 713000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/session.el

(autoload 'session-jump-to-last-change "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/session" "\
Jump to the position of the last change.
Without prefix arg, jump successively to previous change positions which
differ by at least `session-jump-undo-threshold' characters by repeated
invocation of this command.  With prefix argument 0, jump to end of last
change.  With numeric prefix argument, jump to start of first change in
the ARG's undo block in the `buffer-undo-list'.

With non-numeric prefix argument (\\[universal-argument] only), set
point as oldest change position.  It might change slightly if you jump
to it due to intermediate insert/delete elements in the
`buffer-undo-list'.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (turn-on-setnu-mode setnu-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/setnu"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/setnu.el"
;;;;;;  (21516 22146 477492 715000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/setnu.el

(autoload 'setnu-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/setnu" "\
Toggle `setnu-mode'.
With prefix argument ARG, turn `setnu-mode' on if argument is positive.
When `setnu-mode' is enabled, a line number will appear at the left
margin of each line.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-setnu-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/setnu" "\
Turn on `setnu-mode'.
Useful for adding to a `major-mode' hook variable.
Example:
    (add-hook 'text-mode-hook 'turn-on-setnu-mode)
to automatically turn on line numbering when enterting `text-mode'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (shell-command-completion-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/shell-command"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/shell-command.el"
;;;;;;  (19104 31301 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/shell-command.el

(autoload 'shell-command-completion-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/shell-command" "\
Enable or disable tab-completion for some commands.
The commands are `shell-command', `shell-command-on-region', `grep',
`grep-find' and `compile'.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (show-ws-toggle-show-trailing-whitespace show-ws-toggle-show-hard-spaces
;;;;;;  show-ws-toggle-show-tabs) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/show-wspace"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/show-wspace.el"
;;;;;;  (19104 31301 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/show-wspace.el

(defalias 'toggle-show-tabs-show-ws 'show-ws-toggle-show-tabs)

(autoload 'show-ws-toggle-show-tabs "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/show-wspace" "\
Toggle highlighting of TABs, using face `show-ws-tab'.

\(fn)" t nil)

(defalias 'toggle-show-hard-spaces-show-ws 'show-ws-toggle-show-hard-spaces)

(autoload 'show-ws-toggle-show-hard-spaces "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/show-wspace" "\
Toggle highlighting of non-breaking space characters (`\240').
Uses face `show-ws-hard-space'.

\(fn)" t nil)

(defalias 'toggle-show-trailing-whitespace-show-ws 'show-ws-toggle-show-trailing-whitespace)

(autoload 'show-ws-toggle-show-trailing-whitespace "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/show-wspace" "\
Toggle highlighting of trailing whitespace.
Uses face `show-ws-trailing-whitespace'.

\(fn)" t nil)

;;;***

;;;### (autoloads (sm-add-all-headers sm-add-random-header) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/silly-mail"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/silly-mail.el"
;;;;;;  (21516 22146 447492 713000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/silly-mail.el

(autoload 'sm-add-random-header "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/silly-mail" "\
Insert a random silly mail header.
The choice of available headers is taken from `sm-mail-header-table'.
If a random header was already inserted, it it removed in favor of a new one.

\(fn)" t nil)

(autoload 'sm-add-all-headers "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/silly-mail" "\
Insert one of every kind of silly mail header defined.
The choice of available headers is taken from `sm-mail-header-table'.

\(fn)" t nil)

;;;***

;;;### (autoloads (slang-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/slang-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/slang-mode.el"
;;;;;;  (21516 22146 450492 714000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/slang-mode.el

(autoload 'slang-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/slang-mode" "\
Major mode for editing slang scripts.
The following keys are bound:
\\{slang-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads (sys-apropos) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/sys-apropos"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/sys-apropos.el"
;;;;;;  (16013 59403 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/sys-apropos.el

(autoload 'sys-apropos "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/sys-apropos" "\
Ask the system apropos command for man-pages matching QUERY.

\(fn QUERY)" t nil)

;;;***

;;;### (autoloads (tabbar-mwheel-mode tabbar-mode tabbar-local-mode
;;;;;;  tabbar-mwheel-switch-group tabbar-mwheel-switch-tab tabbar-mwheel-forward-tab
;;;;;;  tabbar-mwheel-backward-tab tabbar-mwheel-forward-group tabbar-mwheel-backward-group
;;;;;;  tabbar-mwheel-forward tabbar-mwheel-backward tabbar-press-scroll-right
;;;;;;  tabbar-press-scroll-left tabbar-press-home tabbar-forward-tab
;;;;;;  tabbar-backward-tab tabbar-forward-group tabbar-backward-group
;;;;;;  tabbar-forward tabbar-backward) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar.el"
;;;;;;  (18106 17053 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar.el

(autoload 'tabbar-backward "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the previous available tab.
Depend on the setting of the option `tabbar-cycle-scope'.

\(fn)" t nil)

(autoload 'tabbar-forward "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the next available tab.
Depend on the setting of the option `tabbar-cycle-scope'.

\(fn)" t nil)

(autoload 'tabbar-backward-group "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Go to selected tab in the previous available group.

\(fn)" t nil)

(autoload 'tabbar-forward-group "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Go to selected tab in the next available group.

\(fn)" t nil)

(autoload 'tabbar-backward-tab "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the previous visible tab.

\(fn)" t nil)

(autoload 'tabbar-forward-tab "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the next visible tab.

\(fn)" t nil)

(autoload 'tabbar-press-home "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Press the tab bar home button.
That is, simulate a mouse click on that button.
A numeric prefix ARG value of 2, or 3, respectively simulates a
mouse-2, or mouse-3 click.  The default is a mouse-1 click.

\(fn &optional ARG)" t nil)

(autoload 'tabbar-press-scroll-left "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Press the tab bar scroll-left button.
That is, simulate a mouse click on that button.
A numeric prefix ARG value of 2, or 3, respectively simulates a
mouse-2, or mouse-3 click.  The default is a mouse-1 click.

\(fn &optional ARG)" t nil)

(autoload 'tabbar-press-scroll-right "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Press the tab bar scroll-right button.
That is, simulate a mouse click on that button.
A numeric prefix ARG value of 2, or 3, respectively simulates a
mouse-2, or mouse-3 click.  The default is a mouse-1 click.

\(fn &optional ARG)" t nil)

(autoload 'tabbar-mwheel-backward "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the previous available tab.
EVENT is the mouse event that triggered this command.
Mouse-enabled equivalent of the command `tabbar-backward'.

\(fn EVENT)" t nil)

(autoload 'tabbar-mwheel-forward "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the next available tab.
EVENT is the mouse event that triggered this command.
Mouse-enabled equivalent of the command `tabbar-forward'.

\(fn EVENT)" t nil)

(autoload 'tabbar-mwheel-backward-group "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Go to selected tab in the previous available group.
If there is only one group, select the previous visible tab.
EVENT is the mouse event that triggered this command.
Mouse-enabled equivalent of the command `tabbar-backward-group'.

\(fn EVENT)" t nil)

(autoload 'tabbar-mwheel-forward-group "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Go to selected tab in the next available group.
If there is only one group, select the next visible tab.
EVENT is the mouse event that triggered this command.
Mouse-enabled equivalent of the command `tabbar-forward-group'.

\(fn EVENT)" t nil)

(autoload 'tabbar-mwheel-backward-tab "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the previous visible tab.
EVENT is the mouse event that triggered this command.
Mouse-enabled equivalent of the command `tabbar-backward-tab'.

\(fn EVENT)" t nil)

(autoload 'tabbar-mwheel-forward-tab "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the next visible tab.
EVENT is the mouse event that triggered this command.
Mouse-enabled equivalent of the command `tabbar-forward-tab'.

\(fn EVENT)" t nil)

(autoload 'tabbar-mwheel-switch-tab "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the next or previous tab according to EVENT.

\(fn EVENT)" t nil)

(autoload 'tabbar-mwheel-switch-group "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Select the next or previous group of tabs according to EVENT.

\(fn EVENT)" t nil)

(autoload 'tabbar-local-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Toggle local display of the tab bar.
With prefix argument ARG, turn on if positive, otherwise off.
Returns non-nil if the new state is enabled.
When turned on, if a local header line is shown, it is hidden to show
the tab bar.  The tab bar is locally hidden otherwise.  When turned
off, if a local header line is hidden or the tab bar is locally
hidden, it is shown again.  Signal an error if Tabbar mode is off.

\(fn &optional ARG)" t nil)

(defvar tabbar-mode nil "\
Non-nil if Tabbar mode is enabled.
See the command `tabbar-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `tabbar-mode'.")

(custom-autoload 'tabbar-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" nil)

(autoload 'tabbar-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Toggle display of a tab bar in the header line.
With prefix argument ARG, turn on if positive, otherwise off.
Returns non-nil if the new state is enabled.

\\{tabbar-mode-map}

\(fn &optional ARG)" t nil)

(defvar tabbar-mwheel-mode nil "\
Non-nil if Tabbar-Mwheel mode is enabled.
See the command `tabbar-mwheel-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `tabbar-mwheel-mode'.")

(custom-autoload 'tabbar-mwheel-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" nil)

(autoload 'tabbar-mwheel-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tabbar" "\
Toggle use of the mouse wheel to navigate through tabs or groups.
With prefix argument ARG, turn on if positive, otherwise off.
Returns non-nil if the new state is enabled.

\\{tabbar-mwheel-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (tail-command tail-file) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tail"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tail.el"
;;;;;;  (19536 20905 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tail.el

(autoload 'tail-file "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tail" "\
Tails FILE specified with argument FILE inside a new buffer.
FILE *cannot* be a remote file specified with ange-ftp syntax because it is
passed to the Unix tail command.

\(fn FILE)" t nil)

(autoload 'tail-command "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tail" "\
Tails COMMAND with arguments ARGS inside a new buffer.
It is also called by `tail-file'

\(fn COMMAND &rest ARGS)" t nil)

;;;***

;;;### (autoloads (trivial-cite) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tc"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tc.el"
;;;;;;  (16295 5169 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tc.el

(autoload 'trivial-cite "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tc" "\
A simple citation function for use in news/mailreaders.
It parses the headers via the functions defined in `tc-header-funs', then
makes a attribution for the citation using `tc-make-attribution' and indents
the inserted text with `tc-indent-citation'.
Numeric prefix arguments is how many lines of body to cite (useful for citing
mails with long attachments).
Usage:  (auto-load 'trivial-cite \"tc\" t t)
        (add-hook 'mail-citation-hook 'trivial-cite)
Bugs:  Not very intelligent about old citation marks other than '>'.
Customization:  See variables tc-fill-column, tc-remove-signature,
tc-citation-string, tc-make-attribution and tc-header-funs.

\(fn)" nil nil)

;;;***

;;;### (autoloads (thinks-maybe-region thinks-yank thinks-region
;;;;;;  thinks) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/thinks"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/thinks.el"
;;;;;;  (18431 47702 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/thinks.el

(autoload 'thinks "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/thinks" "\
Insert TEXT wrapped in a think bubble.

Prefix a call to this function with \\[universal-argument] if you don't want
the text to be filled for you.

\(fn TEXT)" t nil)

(autoload 'thinks-region "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/thinks" "\
Bubble wrap region bounding START and END.

Prefix a call to this function with \\[universal-argument] if you don't want
the text to be filled for you.

\(fn START END)" t nil)

(autoload 'thinks-yank "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/thinks" "\
Do a `yank' and bubble wrap the yanked text.

Prefix a call to this function with \\[universal-argument] if you don't want
the text to be filled for you.

\(fn)" t nil)

(autoload 'thinks-maybe-region "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/thinks" "\
If region is active, bubble wrap region bounding START and END.
If not, query for text to insert in bubble.

\(fn)" t nil)

;;;***

;;;### (autoloads (tlc-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tlc"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tlc.el"
;;;;;;  (21516 22146 458492 714000))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tlc.el

(autoload 'tlc-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tlc" "\
Major mode for editing Tlc files, or files found in tlc directories.

\(fn)" t nil)
(add-to-list 'auto-mode-alist '("\\.tlc\\'" . tlc-mode))

;;;***

;;;### (autoloads (tld) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tld"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tld.el"
;;;;;;  (18431 47702 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tld.el

(autoload 'tld "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/tld" "\
Search the TLD list.

\(fn SEARCH)" t nil)

;;;***

;;;### (autoloads (twiddle-compile twiddle-start) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/twiddle"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/twiddle.el"
;;;;;;  (16013 59409 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/twiddle.el

(autoload 'twiddle-start "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/twiddle" "\
Start a mode line display hack.
If called interactively with a prefix argument, prompt for the name of
a hack to run.  If called from lisp, optional argument HACK is the name of
a hack to run.
Named hacks are defined in the table `twiddle-hacks'.

\(fn &optional HACK)" t nil)

(autoload 'twiddle-compile "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/twiddle" "\
Like \\[compile], but run a twiddle hack during compilation.
If called with a prefix argument, prompt for a specific hack to run.

\(fn &rest COMPILE-ARGS)" t nil)

;;;***

;;;### (autoloads (underhat-region) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/under"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/under.el"
;;;;;;  (16262 60507 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/under.el

(autoload 'underhat-region "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/under" "\
Underline the region.

\(fn)" t nil)

;;;***

;;;### (autoloads (xrdb-mode) "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/xrdb-mode"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/xrdb-mode.el"
;;;;;;  (19391 54726 0 0))
;;; Generated autoloads from emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/xrdb-mode.el

(autoload 'xrdb-mode "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/xrdb-mode" "\
Major mode for editing xrdb config files.
\\{xrdb-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads nil "evil/evil-core" "evil/evil-core.el" (21516
;;;;;;  22735 517518 552000))
;;; Generated autoloads from evil/evil-core.el
 (autoload 'evil-mode "evil" "Toggle evil in all buffers" t)

;;;***

;;;### (autoloads (git-commit-mode) "git-modes/git-commit-mode" "git-modes/git-commit-mode.el"
;;;;;;  (21516 22212 757495 622000))
;;; Generated autoloads from git-modes/git-commit-mode.el

(autoload 'git-commit-mode "git-modes/git-commit-mode" "\
Major mode for editing git commit messages.

This mode helps with editing git commit messages both by
providing commands to do common tasks, and by highlighting the
basic structure of and errors in git commit messages.

\(fn)" t nil)

(dolist (pattern '("/COMMIT_EDITMSG\\'" "/NOTES_EDITMSG\\'" "/MERGE_MSG\\'" "/TAG_EDITMSG\\'" "/PULLREQ_EDITMSG\\'")) (add-to-list 'auto-mode-alist (cons pattern 'git-commit-mode)))

;;;***

;;;### (autoloads (git-rebase-mode) "git-modes/git-rebase-mode" "git-modes/git-rebase-mode.el"
;;;;;;  (21516 22212 758495 622000))
;;; Generated autoloads from git-modes/git-rebase-mode.el

(autoload 'git-rebase-mode "git-modes/git-rebase-mode" "\
Major mode for editing of a Git rebase file.

Rebase files are generated when you run 'git rebase -i' or run
`magit-interactive-rebase'.  They describe how Git should perform
the rebase.  See the documentation for git-rebase (e.g., by
running 'man git-rebase' at the command line) for details.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("/git-rebase-todo\\'" . git-rebase-mode))

;;;***

;;;### (autoloads (gitattributes-mode) "git-modes/gitattributes-mode"
;;;;;;  "git-modes/gitattributes-mode.el" (21516 22212 758495 622000))
;;; Generated autoloads from git-modes/gitattributes-mode.el

(autoload 'gitattributes-mode "git-modes/gitattributes-mode" "\
A major mode for editing .gitattributes files.
\\{gitattributes-mode-map}

\(fn)" t nil)

(dolist (pattern '("/\\.gitattributes\\'" "/\\.git/info/attributes\\'" "/git/attributes\\'")) (add-to-list 'auto-mode-alist (cons pattern #'gitattributes-mode)))

;;;***

;;;### (autoloads (gitconfig-mode) "git-modes/gitconfig-mode" "git-modes/gitconfig-mode.el"
;;;;;;  (21516 22212 758495 622000))
;;; Generated autoloads from git-modes/gitconfig-mode.el

(autoload 'gitconfig-mode "git-modes/gitconfig-mode" "\
A major mode for editing .gitconfig files.

\(fn)" t nil)

(dolist (pattern '("/\\.gitconfig\\'" "/\\.git/config\\'" "/git/config\\'" "/\\.gitmodules\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitconfig-mode)))

;;;***

;;;### (autoloads (gitignore-mode) "git-modes/gitignore-mode" "git-modes/gitignore-mode.el"
;;;;;;  (21516 22212 758495 622000))
;;; Generated autoloads from git-modes/gitignore-mode.el

(autoload 'gitignore-mode "git-modes/gitignore-mode" "\
A major mode for editing .gitignore files.

\(fn)" t nil)

(dolist (pattern (list "/\\.gitignore\\'" "/\\.git/info/exclude\\'" "/git/ignore\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitignore-mode)))

;;;***

;;;### (autoloads (goto-last-change-reverse goto-last-change) "goto-chg/goto-chg"
;;;;;;  "goto-chg/goto-chg.el" (21516 22731 331518 369000))
;;; Generated autoloads from goto-chg/goto-chg.el

(autoload 'goto-last-change "goto-chg/goto-chg" "\
Go to the point where the last edit was made in the current buffer.
Repeat the command to go to the second last edit, etc.

To go back to more recent edit, the reverse of this command, use \\[goto-last-change-reverse]
or precede this command with \\[universal-argument] - (minus).

It does not go to the same point twice even if there has been many edits
there. I call the minimal distance between distinguishable edits \"span\".
Set variable `glc-default-span' to control how close is \"the same point\".
Default span is 8.
The span can be changed temporarily with \\[universal-argument] right before \\[goto-last-change]:
\\[universal-argument] <NUMBER> set current span to that number,
\\[universal-argument] (no number) multiplies span by 4, starting with default.
The so set span remains until it is changed again with \\[universal-argument], or the consecutive
repetition of this command is ended by any other command.

When span is zero (i.e. \\[universal-argument] 0) subsequent \\[goto-last-change] visits each and
every point of edit and a message shows what change was made there.
In this case it may go to the same point twice.

This command uses undo information. If undo is disabled, so is this command.
At times, when undo information becomes too large, the oldest information is
discarded. See variable `undo-limit'.

\(fn ARG)" t nil)

(autoload 'goto-last-change-reverse "goto-chg/goto-chg" "\
Go back to more recent changes after \\[goto-last-change] have been used.
See `goto-last-change' for use of prefix argument.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads (goto-last-change) "goto-last-change/goto-last-change"
;;;;;;  "goto-last-change/goto-last-change.el" (21516 22513 348508
;;;;;;  807000))
;;; Generated autoloads from goto-last-change/goto-last-change.el

(autoload 'goto-last-change "goto-last-change/goto-last-change" "\
Set point to the position of the last change.
Consecutive calls set point to the position of the previous change.
With a prefix arg (optional arg MARK-POINT non-nil), set mark so \\[exchange-point-and-mark]
will return point to the current position.

\(fn &optional MARK-POINT MINIMAL-LINE-DISTANCE)" t nil)

;;;***

;;;### (autoloads (highlight-indentation-current-column-mode highlight-indentation-set-offset
;;;;;;  highlight-indentation-mode) "highlight-indentation/highlight-indentation"
;;;;;;  "highlight-indentation/highlight-indentation.el" (21516 26110
;;;;;;  1666 571000))
;;; Generated autoloads from highlight-indentation/highlight-indentation.el

(autoload 'highlight-indentation-mode "highlight-indentation/highlight-indentation" "\
Highlight indentation minor mode highlights indentation based
on spaces

\(fn &optional ARG)" t nil)

(autoload 'highlight-indentation-set-offset "highlight-indentation/highlight-indentation" "\
Set indentation offset localy in buffer, will prevent
highlight-indentation from trying to guess indentation offset
from major mode

\(fn OFFSET)" t nil)

(autoload 'highlight-indentation-current-column-mode "highlight-indentation/highlight-indentation" "\
Hilight Indentation minor mode displays
a vertical bar corresponding to the indentation of the current line

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (magit-run-gitk magit-run-git-gui-blame magit-run-git-gui
;;;;;;  magit-add-change-log-entry-other-window magit-add-change-log-entry
;;;;;;  magit-init magit-branch-manager magit-wazzup magit-diff-stash
;;;;;;  magit-diff-unstaged magit-diff-staged magit-diff-working-tree
;;;;;;  magit-diff magit-interactive-resolve magit-save-index magit-cherry
;;;;;;  magit-reflog-head magit-reflog magit-file-log magit-log-long-ranged
;;;;;;  magit-log-long magit-log-ranged magit-log magit-bisect-run
;;;;;;  magit-bisect-skip magit-bisect-bad magit-bisect-good magit-bisect-reset
;;;;;;  magit-bisect-start magit-submodule-sync magit-submodule-init
;;;;;;  magit-submodule-update-init magit-submodule-update magit-stash-snapshot
;;;;;;  magit-stash magit-delete-tag magit-tag magit-commit-squash
;;;;;;  magit-commit-fixup magit-commit-reword magit-commit-extend
;;;;;;  magit-commit-amend magit-commit magit-push magit-push-tags
;;;;;;  magit-pull magit-remote-update magit-fetch-current magit-fetch
;;;;;;  magit-reset-working-tree magit-reset-head-hard magit-reset-head
;;;;;;  magit-interactive-rebase magit-rename-remote magit-remove-remote
;;;;;;  magit-add-remote magit-rename-branch magit-delete-branch
;;;;;;  magit-create-branch magit-checkout magit-merge-abort magit-merge
;;;;;;  magit-show magit-dired-jump magit-unstage-all magit-stage-all
;;;;;;  magit-status magit-show-commit magit-git-command) "magit/magit"
;;;;;;  "magit/magit.el" (21516 22223 228496 81000))
;;; Generated autoloads from magit/magit.el

(autoload 'magit-git-command "magit/magit" "\
Execute a Git subcommand asynchronously, displaying the output.
With a prefix argument run Git in the root of the current
repository.  Non-interactively run Git in DIRECTORY with ARGS.

\(fn ARGS DIRECTORY)" t nil)

(autoload 'magit-show-commit "magit/magit" "\
Show information about COMMIT.

\(fn COMMIT &optional NOSELECT)" t nil)

(autoload 'magit-status "magit/magit" "\
Open a Magit status buffer for the Git repository containing DIR.
If DIR is not within a Git repository, offer to create a Git
repository in DIR.

Interactively, a prefix argument means to ask the user which Git
repository to use even if `default-directory' is under Git
control.  Two prefix arguments means to ignore `magit-repo-dirs'
when asking for user input.

Depending on option `magit-status-buffer-switch-function' the
status buffer is shown in another window (the default) or the
current window.  Non-interactively optional SWITCH-FUNCTION
can be used to override this.

\(fn DIR &optional SWITCH-FUNCTION)" t nil)

(autoload 'magit-stage-all "magit/magit" "\
Add all remaining changes in tracked files to staging area.
With a prefix argument, add remaining untracked files as well.
\('git add [-u] .').

\(fn &optional INCLUDING-UNTRACKED)" t nil)

(autoload 'magit-unstage-all "magit/magit" "\
Remove all changes from staging area.
\('git reset --mixed HEAD').

\(fn)" t nil)

(autoload 'magit-dired-jump "magit/magit" "\
Visit current item in dired.
With a prefix argument, visit in other window.

\(fn &optional OTHER-WINDOW)" t nil)

(autoload 'magit-show "magit/magit" "\
Display and select a buffer containing FILE as stored in REV.

Insert the contents of FILE as stored in the revision REV into a
buffer.  Then select the buffer using `pop-to-buffer' or with a
prefix argument using `switch-to-buffer'.  Non-interactivity use
SWITCH-FUNCTION to switch to the buffer, if that is nil simply
return the buffer, without displaying it.

\(fn REV FILE &optional SWITCH-FUNCTION)" t nil)

(autoload 'magit-merge "magit/magit" "\
Merge REVISION into the current 'HEAD', leaving changes uncommitted.
With a prefix argument, skip editing the log message and commit.
\('git merge [--no-commit] REVISION').

\(fn REVISION &optional DO-COMMIT)" t nil)

(autoload 'magit-merge-abort "magit/magit" "\
Abort the current merge operation.

\(fn)" t nil)

(autoload 'magit-checkout "magit/magit" "\
Switch 'HEAD' to REVISION and update working tree.
Fails if working tree or staging area contain uncommitted changes.
If REVISION is a remote branch, offer to create a local branch.
\('git checkout [-b] REVISION').

\(fn REVISION)" t nil)

(autoload 'magit-create-branch "magit/magit" "\
Switch 'HEAD' to new BRANCH at revision PARENT and update working tree.
Fails if working tree or staging area contain uncommitted changes.
\('git checkout -b BRANCH REVISION').

\(fn BRANCH PARENT)" t nil)

(autoload 'magit-delete-branch "magit/magit" "\
Delete the BRANCH.
If the branch is the current one, offers to switch to `master' first.
With prefix, forces the removal even if it hasn't been merged.
Works with local or remote branches.
\('git branch [-d|-D] BRANCH' or 'git push <remote-part-of-BRANCH> :refs/heads/BRANCH').

\(fn BRANCH &optional FORCE)" t nil)

(autoload 'magit-rename-branch "magit/magit" "\
Rename branch OLD to NEW.
With prefix, forces the rename even if NEW already exists.
\('git branch [-m|-M] OLD NEW').

\(fn OLD NEW &optional FORCE)" t nil)

(autoload 'magit-add-remote "magit/magit" "\
Add the REMOTE and fetch it.
\('git remote add REMOTE URL').

\(fn REMOTE URL)" t nil)

(autoload 'magit-remove-remote "magit/magit" "\
Delete the REMOTE.
\('git remote rm REMOTE').

\(fn REMOTE)" t nil)

(autoload 'magit-rename-remote "magit/magit" "\
Rename remote OLD to NEW.
\('git remote rename OLD NEW').

\(fn OLD NEW)" t nil)

(autoload 'magit-interactive-rebase "magit/magit" "\
Start a git rebase -i session, old school-style.

\(fn COMMIT)" t nil)

(autoload 'magit-reset-head "magit/magit" "\
Switch 'HEAD' to REVISION, keeping prior working tree and staging area.
Any differences from REVISION become new changes to be committed.
With prefix argument, all uncommitted changes in working tree
and staging area are lost.
\('git reset [--soft|--hard] REVISION').

\(fn REVISION &optional HARD)" t nil)

(autoload 'magit-reset-head-hard "magit/magit" "\
Switch 'HEAD' to REVISION, losing all changes.
Uncomitted changes in both working tree and staging area are lost.
\('git reset --hard REVISION').

\(fn REVISION)" t nil)

(autoload 'magit-reset-working-tree "magit/magit" "\
Revert working tree and clear changes from staging area.
\('git reset --hard HEAD').

With a prefix arg, also remove untracked files.
With two prefix args, remove ignored files as well.

\(fn &optional ARG)" t nil)

(autoload 'magit-fetch "magit/magit" "\
Fetch from REMOTE.

\(fn REMOTE)" t nil)

(autoload 'magit-fetch-current "magit/magit" "\
Run fetch for default remote.

If there is no default remote, ask for one.

\(fn)" t nil)

(autoload 'magit-remote-update "magit/magit" "\
Update all remotes.

\(fn)" t nil)

(autoload 'magit-pull "magit/magit" "\
Run git pull.

If there is no default remote, the user is prompted for one and
its values is saved with git config.  If there is no default
merge branch, the user is prompted for one and its values is
saved with git config.  With a prefix argument, the default
remote is not used and the user is prompted for a remote.  With
two prefix arguments, the default merge branch is not used and
the user is prompted for a merge branch.  Values entered by the
user because of prefix arguments are not saved with git config.

\(fn)" t nil)

(autoload 'magit-push-tags "magit/magit" "\
Push tags to a remote repository.

Push tags to the current branch's remote.  If that isn't set push
to \"origin\" or if that remote doesn't exit but only a single
remote is defined use that.  Otherwise or with a prefix argument
ask the user what remote to use.

\(fn)" t nil)

(autoload 'magit-push "magit/magit" "\
Push the current branch to a remote repository.

This command runs the `magit-push-remote' hook.  By default that
means running `magit-push-dwim'.  So unless you have customized
the hook this command behaves like this:

With a single prefix argument ask the user what branch to push
to.  With two or more prefix arguments also ask the user what
remote to push to.  Otherwise use the remote and branch as
configured using the Git variables `branch.<name>.remote' and
`branch.<name>.merge'.  If the former is undefined ask the user.
If the latter is undefined push without specifing the remote
branch explicitly.

Also see option `magit-set-upstream-on-push'.

\(fn)" t nil)

(autoload 'magit-commit "magit/magit" "\
Create a new commit on HEAD.
With a prefix argument amend to the commit at HEAD instead.
\('git commit [--amend]').

\(fn &optional AMENDP)" t nil)

(autoload 'magit-commit-amend "magit/magit" "\
Amend the last commit.
\('git commit --amend').

\(fn)" t nil)

(autoload 'magit-commit-extend "magit/magit" "\
Amend the last commit, without editing the message.
With a prefix argument do change the committer date, otherwise
don't.  The option `magit-commit-extend-override-date' can be
used to inverse the meaning of the prefix argument.
\('git commit --no-edit --amend [--keep-date]').

\(fn &optional OVERRIDE-DATE)" t nil)

(autoload 'magit-commit-reword "magit/magit" "\
Reword the last commit, ignoring staged changes.

With a prefix argument do change the committer date, otherwise
don't.  The option `magit-commit-rewrite-override-date' can be
used to inverse the meaning of the prefix argument.

Non-interactively respect the optional OVERRIDE-DATE argument
and ignore the option.

\('git commit --only --amend').

\(fn &optional OVERRIDE-DATE)" t nil)

(autoload 'magit-commit-fixup "magit/magit" "\
Create a fixup commit.
With a prefix argument the user is always queried for the commit
to be fixed.  Otherwise the current or marked commit may be used
depending on the value of option `magit-commit-squash-commit'.
\('git commit [--no-edit] --fixup=COMMIT').

\(fn &optional COMMIT)" t nil)

(autoload 'magit-commit-squash "magit/magit" "\
Create a squash commit.
With a prefix argument the user is always queried for the commit
to be fixed.  Otherwise the current or marked commit may be used
depending on the value of option `magit-commit-squash-commit'.
\('git commit [--no-edit] --fixup=COMMIT').

\(fn &optional COMMIT FIXUP)" t nil)

(autoload 'magit-tag "magit/magit" "\
Create a new tag with the given NAME at REV.
With a prefix argument annotate the tag.
\('git tag [--annotate] NAME REV').

\(fn NAME REV &optional ANNOTATE)" t nil)

(autoload 'magit-delete-tag "magit/magit" "\
Delete the tag with the given NAME.
\('git tag -d NAME').

\(fn NAME)" t nil)

(autoload 'magit-stash "magit/magit" "\
Create new stash of working tree and staging area named DESCRIPTION.
Working tree and staging area revert to the current 'HEAD'.
With prefix argument, changes in staging area are kept.
\('git stash save [--keep-index] DESCRIPTION')

\(fn DESCRIPTION)" t nil)

(autoload 'magit-stash-snapshot "magit/magit" "\
Create new stash of working tree and staging area; keep changes in place.
\('git stash save \"Snapshot...\"; git stash apply stash@{0}')

\(fn)" t nil)

(autoload 'magit-submodule-update "magit/magit" "\
Update the submodule of the current git repository.
With a prefix arg, do a submodule update --init.

\(fn &optional INIT)" t nil)

(autoload 'magit-submodule-update-init "magit/magit" "\
Update and init the submodule of the current git repository.

\(fn)" t nil)

(autoload 'magit-submodule-init "magit/magit" "\
Initialize the submodules.

\(fn)" t nil)

(autoload 'magit-submodule-sync "magit/magit" "\
Synchronizes submodule's remote URL configuration.

\(fn)" t nil)

(autoload 'magit-bisect-start "magit/magit" "\
Start a bisect session.

Bisecting a bug means to find the commit that introduced it.
This command starts such a bisect session by asking for a know
good and a bad commit.  To move the session forward use the
other actions from the bisect popup (\\<magit-status-mode-map>\\[magit-key-mode-popup-bisecting]).

\(fn BAD GOOD)" t nil)

(autoload 'magit-bisect-reset "magit/magit" "\
After bisecting cleanup bisection state and return to original HEAD.

\(fn)" t nil)

(autoload 'magit-bisect-good "magit/magit" "\
While bisecting, mark the current commit as good.
Use this after you have asserted that the commit does not contain
the bug in question.

\(fn)" t nil)

(autoload 'magit-bisect-bad "magit/magit" "\
While bisecting, mark the current commit as bad.
Use this after you have asserted that the commit does contain the
bug in question.

\(fn)" t nil)

(autoload 'magit-bisect-skip "magit/magit" "\
While bisecting, skip the current commit.
Use this if for some reason the current commit is not a good one
to test.  This command lets Git choose a different one.

\(fn)" t nil)

(autoload 'magit-bisect-run "magit/magit" "\
Bisect automatically by running commands after each step.

\(fn CMDLINE)" t nil)

(autoload 'magit-log "magit/magit" "\


\(fn &optional RANGE)" t nil)

(autoload 'magit-log-ranged "magit/magit" "\


\(fn RANGE)" t nil)

(autoload 'magit-log-long "magit/magit" "\


\(fn &optional RANGE)" t nil)

(autoload 'magit-log-long-ranged "magit/magit" "\


\(fn RANGE)" t nil)

(autoload 'magit-file-log "magit/magit" "\
Display the log for the currently visited file or another one.
With a prefix argument show the log graph.

\(fn FILE &optional USE-GRAPH)" t nil)

(autoload 'magit-reflog "magit/magit" "\
Display the reflog of the current branch.
With a prefix argument another branch can be chosen.

\(fn REF)" t nil)

(autoload 'magit-reflog-head "magit/magit" "\
Display the HEAD reflog.

\(fn)" t nil)

(autoload 'magit-cherry "magit/magit" "\
Show commits in a branch that are not merged in the upstream branch.

\(fn HEAD UPSTREAM)" t nil)

(autoload 'magit-save-index "magit/magit" "\
Add the content of current file as if it was the index.

\(fn)" t nil)

(autoload 'magit-interactive-resolve "magit/magit" "\
Resolve a merge conflict using Ediff.

\(fn FILE)" t nil)

(autoload 'magit-diff "magit/magit" "\
Show differences between two commits.
RANGE should be a range (A..B or A...B) but can also be a single
commit.  If one side of the range is omitted, then it defaults
to HEAD.  If just a commit is given, then changes in the working
tree relative to that commit are shown.

\(fn RANGE &optional WORKING ARGS)" t nil)

(autoload 'magit-diff-working-tree "magit/magit" "\
Show differences between a commit and the current working tree.

\(fn REV)" t nil)

(autoload 'magit-diff-staged "magit/magit" "\
Show differences between the index and the HEAD commit.

\(fn)" t nil)

(autoload 'magit-diff-unstaged "magit/magit" "\
Show differences between the current working tree and index.

\(fn)" t nil)

(autoload 'magit-diff-stash "magit/magit" "\
Show changes in a stash.
A Stash consist of more than just one commit.  This command uses
a special diff range so that the stashed changes actually were a
single commit.

\(fn STASH &optional NOSELECT)" t nil)

(autoload 'magit-wazzup "magit/magit" "\
Show a list of branches in a dedicated buffer.
Unlike in the buffer created by `magit-branch-manager' each
branch can be expanded to show a list of commits not merged
into the selected branch.

\(fn BRANCH)" t nil)

(autoload 'magit-branch-manager "magit/magit" "\
Show a list of branches in a dedicated buffer.

\(fn)" t nil)

(autoload 'magit-init "magit/magit" "\
Create or reinitialize a Git repository.
Read directory name and initialize it as new Git repository.

If the directory is below an existing repository, then the user
has to confirm that a new one should be created inside; or when
the directory is the root of the existing repository, whether
it should be reinitialized.

Non-interactively DIRECTORY is always (re-)initialized.

\(fn DIRECTORY)" t nil)

(autoload 'magit-add-change-log-entry "magit/magit" "\
Find change log file and add date entry and item for current change.
This differs from `add-change-log-entry' (which see) in that
it acts on the current hunk in a Magit buffer instead of on
a position in a file-visiting buffer.

\(fn &optional WHOAMI FILE-NAME OTHER-WINDOW)" t nil)

(autoload 'magit-add-change-log-entry-other-window "magit/magit" "\
Find change log file in other window and add entry and item.
This differs from `add-change-log-entry-other-window' (which see)
in that it acts on the current hunk in a Magit buffer instead of
on a position in a file-visiting buffer.

\(fn &optional WHOAMI FILE-NAME)" t nil)

(autoload 'magit-run-git-gui "magit/magit" "\
Run `git gui' for the current git repository.

\(fn)" t nil)

(autoload 'magit-run-git-gui-blame "magit/magit" "\
Run `git gui blame' on the given FILENAME and COMMIT.
Interactively run it for the current file and the HEAD, with a
prefix or when the current file cannot be determined let the user
choose.  When the current buffer is visiting FILENAME instruct
blame to center around the line point is on.

\(fn COMMIT FILENAME &optional LINENUM)" t nil)

(autoload 'magit-run-gitk "magit/magit" "\
Run Gitk for the current git repository.
Without a prefix argument run `gitk --all', with
a prefix argument run gitk without any arguments.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads (magit-blame-mode) "magit/magit-blame" "magit/magit-blame.el"
;;;;;;  (21516 22223 224496 81000))
;;; Generated autoloads from magit/magit-blame.el

(autoload 'magit-blame-mode "magit/magit-blame" "\
Display blame information inline.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "magit/magit-key-mode" "magit/magit-key-mode.el"
;;;;;;  (21516 22223 224496 81000))
;;; Generated autoloads from magit/magit-key-mode.el

(defvar magit-key-mode-groups '((dispatch (actions ("b" "Branching" magit-key-mode-popup-branching) ("B" "Bisecting" magit-key-mode-popup-bisecting) ("c" "Committing" magit-key-mode-popup-committing) ("d" "Diff worktree" magit-diff-working-tree) ("D" "Diff" magit-diff) ("f" "Fetching" magit-key-mode-popup-fetching) ("F" "Pulling" magit-key-mode-popup-pulling) ("g" "Refresh Buffers" magit-refresh-all) ("l" "Logging" magit-key-mode-popup-logging) ("m" "Merging" magit-key-mode-popup-merging) ("M" "Remoting" magit-key-mode-popup-remoting) ("P" "Pushing" magit-key-mode-popup-pushing) ("o" "Submoduling" magit-key-mode-popup-submodule) ("r" "Rewriting" magit-key-mode-popup-rewriting) ("R" "Rebasing" magit-rebase-step) ("s" "Show Status" magit-status) ("S" "Stage all" magit-stage-all) ("t" "Tagging" magit-key-mode-popup-tagging) ("U" "Unstage all" magit-unstage-all) ("v" "Show Commit" magit-show-commit) ("V" "Show File" magit-show) ("w" "Wazzup" magit-wazzup) ("X" "Reset worktree" magit-reset-working-tree) ("y" "Cherry" magit-cherry) ("z" "Stashing" magit-key-mode-popup-stashing) ("!" "Running" magit-key-mode-popup-running) ("$" "Show Process" magit-display-process))) (logging (man-page "git-log") (actions ("l" "Short" magit-log) ("L" "Long" magit-log-long) ("h" "Head Reflog" magit-reflog-head) ("f" "File log" magit-file-log) ("rl" "Ranged short" magit-log-ranged) ("rL" "Ranged long" magit-log-long-ranged) ("rh" "Reflog" magit-reflog)) (switches ("-m" "Only merge commits" "--merges") ("-s" "No merge commits" "--no-merges") ("-do" "Date Order" "--date-order") ("-f" "First parent" "--first-parent") ("-i" "Case insensitive patterns" "-i") ("-pr" "Pickaxe regex" "--pickaxe-regex") ("-g" "Show Graph" "--graph") ("-n" "Name only" "--name-only") ("-am" "All match" "--all-match") ("-al" "All" "--all")) (arguments ("=r" "Relative" "--relative=" read-directory-name) ("=c" "Committer" "--committer=" read-from-minibuffer) ("=>" "Since" "--since=" read-from-minibuffer) ("=<" "Before" "--before=" read-from-minibuffer) ("=a" "Author" "--author=" read-from-minibuffer) ("=g" "Grep messages" "--grep=" read-from-minibuffer) ("=G" "Grep patches" "-G" read-from-minibuffer) ("=L" "Trace evolution of line range [long log only]" "-L" magit-read-file-trace) ("=s" "Pickaxe search" "-S" read-from-minibuffer) ("=b" "Branches" "--branches=" read-from-minibuffer) ("=R" "Remotes" "--remotes=" read-from-minibuffer))) (running (actions ("!" "Git Subcommand (from root)" magit-git-command-topdir) (":" "Git Subcommand (from pwd)" magit-git-command) ("g" "Git Gui" magit-run-git-gui) ("k" "Gitk" magit-run-gitk))) (fetching (man-page "git-fetch") (actions ("f" "Current" magit-fetch-current) ("a" "All" magit-remote-update) ("o" "Other" magit-fetch)) (switches ("-p" "Prune" "--prune"))) (pushing (man-page "git-push") (actions ("P" "Push" magit-push) ("t" "Push tags" magit-push-tags)) (switches ("-f" "Force" "--force") ("-d" "Dry run" "-n") ("-u" "Set upstream" "-u"))) (pulling (man-page "git-pull") (actions ("F" "Pull" magit-pull)) (switches ("-f" "Force" "--force") ("-r" "Rebase" "--rebase"))) (branching (man-page "git-branch") (actions ("v" "Branch manager" magit-branch-manager) ("b" "Checkout" magit-checkout) ("c" "Create" magit-create-branch) ("r" "Rename" magit-rename-branch) ("k" "Delete" magit-delete-branch)) (switches ("-t" "Set upstream configuration" "--track") ("-m" "Merged to HEAD" "--merged") ("-M" "Merged to master" "--merged=master") ("-n" "Not merged to HEAD" "--no-merged") ("-N" "Not merged to master" "--no-merged=master")) (arguments ("=c" "Contains" "--contains=" magit-read-rev-with-default) ("=m" "Merged" "--merged=" magit-read-rev-with-default) ("=n" "Not merged" "--no-merged=" magit-read-rev-with-default))) (remoting (man-page "git-remote") (actions ("v" "Remote manager" magit-branch-manager) ("a" "Add" magit-add-remote) ("r" "Rename" magit-rename-remote) ("k" "Remove" magit-remove-remote))) (tagging (man-page "git-tag") (actions ("t" "Create" magit-tag) ("k" "Delete" magit-delete-tag)) (switches ("-a" "Annotate" "--annotate") ("-f" "Force" "--force") ("-s" "Sign" "--sign"))) (stashing (man-page "git-stash") (actions ("v" "View" magit-diff-stash) ("z" "Save" magit-stash) ("s" "Snapshot" magit-stash-snapshot) ("a" "Apply" magit-stash-apply) ("p" "Pop" magit-stash-pop) ("k" "Drop" magit-stash-drop)) (switches ("-k" "Keep index" "--keep-index") ("-u" "Include untracked files" "--include-untracked") ("-a" "Include all files" "--all"))) (committing (man-page "git-commit") (actions ("c" "Commit" magit-commit) ("a" "Amend" magit-commit-amend) ("e" "Extend" magit-commit-extend) ("r" "Reword" magit-commit-reword) ("f" "Fixup" magit-commit-fixup) ("s" "Squash" magit-commit-squash)) (switches ("-a" "Stage all modified and deleted files" "--all") ("-e" "Allow empty commit" "--allow-empty") ("-v" "Show diff of changes to be committed" "--verbose") ("-n" "Bypass git hooks" "--no-verify") ("-s" "Add Signed-off-by line" "--signoff") ("-R" "Claim authorship and reset author date" "--reset-author")) (arguments ("=A" "Override the author" "--author=" read-from-minibuffer) ("=S" "Sign using gpg" "--gpg-sign=" magit-read-gpg-secret-key))) (merging (man-page "git-merge") (actions ("m" "Merge" magit-merge) ("A" "Abort" magit-merge-abort)) (switches ("-ff" "Fast-forward only" "--ff-only") ("-nf" "No fast-forward" "--no-ff") ("-sq" "Squash" "--squash")) (arguments ("-st" "Strategy" "--strategy=" read-from-minibuffer))) (rewriting (actions ("b" "Begin" magit-rewrite-start) ("s" "Stop" magit-rewrite-stop) ("a" "Abort" magit-rewrite-abort) ("f" "Finish" magit-rewrite-finish) ("d" "Diff pending" magit-rewrite-diff-pending) ("*" "Set unused" magit-rewrite-set-unused) ("." "Set used" magit-rewrite-set-used))) (apply-mailbox (man-page "git-am") (actions ("J" "Apply Mailbox" magit-apply-mailbox)) (switches ("-s" "add a Signed-off-by line to the commit message" "--signoff") ("-3" "allow fall back on 3way merging if needed" "--3way") ("-k" "pass -k flag to git-mailinfo" "--keep") ("-c" "strip everything before a scissors line" "--scissors") ("-p" "pass it through git-apply" "-p") ("-r" "override error message when patch failure occurs" "--resolvemsg") ("-d" "lie about committer date" "--committer-date-is-author-date") ("-D" "use current timestamp for author date" "--ignore-date") ("-b" "pass -b flag to git-mailinfo" "--keep-non-patch")) (arguments ("=p" "format the patch(es) are in" "--patch-format=" read-from-minibuffer))) (submodule (man-page "git-submodule") (actions ("u" "Update" magit-submodule-update) ("b" "Both update and init" magit-submodule-update-init) ("i" "Init" magit-submodule-init) ("s" "Sync" magit-submodule-sync))) (bisecting (man-page "git-bisect") (actions ("b" "Bad" magit-bisect-bad) ("g" "Good" magit-bisect-good) ("k" "Skip" magit-bisect-skip) ("r" "Reset" magit-bisect-reset) ("s" "Start" magit-bisect-start) ("u" "Run" magit-bisect-run))) (diff-options (actions ("s" "Set" magit-set-diff-options) ("d" "Set default" magit-set-default-diff-options) ("c" "Save default" magit-save-default-diff-options) ("r" "Reset to default" magit-reset-diff-options) ("h" "Toggle Hunk Refinement" magit-diff-toggle-refine-hunk)) (switches ("-m" "Show smallest possible diff" "--minimal") ("-p" "Use patience diff algorithm" "--patience") ("-h" "Use histogram diff algorithm" "--histogram") ("-b" "Ignore whitespace changes" "--ignore-space-change") ("-w" "Ignore all whitespace" "--ignore-all-space") ("-W" "Show surrounding functions" "--function-context")))) "\
Holds the key, help, function mapping for the log-mode.
If you modify this make sure you reset `magit-key-mode-keymaps'
to nil.")
 (mapc (lambda (g) (eval `(autoload ',(intern (concat "magit-key-mode-popup-" (symbol-name (car g)))) "magit-key-mode" ,(concat "Key menu for " (symbol-name (car g))) t))) magit-key-mode-groups)

;;;***

;;;### (autoloads (turn-on-magit-stgit magit-stgit-mode magit-stgit-show
;;;;;;  magit-stgit-goto magit-stgit-discard magit-stgit-rebase magit-stgit-repair
;;;;;;  magit-stgit-refresh) "magit/magit-stgit" "magit/magit-stgit.el"
;;;;;;  (21516 22223 225496 81000))
;;; Generated autoloads from magit/magit-stgit.el

(autoload 'magit-stgit-refresh "magit/magit-stgit" "\
Refresh a StGit patch.

\(fn &optional PATCH)" t nil)

(autoload 'magit-stgit-repair "magit/magit-stgit" "\
Repair StGit metadata if branch was modified with git commands.
In the case of Git commits these will be imported as new patches
into the series.

\(fn)" t nil)

(autoload 'magit-stgit-rebase "magit/magit-stgit" "\
Rebase a StGit patch series.

\(fn)" t nil)

(autoload 'magit-stgit-discard "magit/magit-stgit" "\
Discard a StGit patch.

\(fn PATCH)" t nil)

(autoload 'magit-stgit-goto "magit/magit-stgit" "\
Set PATCH as target of StGit push and pop operations.

\(fn PATCH)" nil nil)

(autoload 'magit-stgit-show "magit/magit-stgit" "\
Show diff of a StGit patch.

\(fn PATCH)" t nil)

(autoload 'magit-stgit-mode "magit/magit-stgit" "\
StGit support for Magit

\(fn &optional ARG)" t nil)

(autoload 'turn-on-magit-stgit "magit/magit-stgit" "\
Unconditionally turn on `magit-stgit-mode'.

\(fn)" nil nil)

(custom-add-option 'magit-mode-hook #'magit-stgit-mode)

;;;***

;;;### (autoloads (turn-on-magit-svn magit-svn-mode magit-svn-fetch-externals
;;;;;;  magit-svn-remote-update magit-svn-dcommit magit-svn-rebase
;;;;;;  magit-svn-create-tag magit-svn-create-branch magit-svn-find-rev)
;;;;;;  "magit/magit-svn" "magit/magit-svn.el" (21516 22223 225496
;;;;;;  81000))
;;; Generated autoloads from magit/magit-svn.el

(autoload 'magit-svn-find-rev "magit/magit-svn" "\
Find commit for svn REVISION in BRANCH.

\(fn REV &optional BRANCH)" t nil)

(autoload 'magit-svn-create-branch "magit/magit-svn" "\
Create svn branch NAME.

\(fn NAME)" t nil)

(autoload 'magit-svn-create-tag "magit/magit-svn" "\
Create svn tag NAME.

\(fn NAME)" t nil)

(autoload 'magit-svn-rebase "magit/magit-svn" "\
Run git-svn rebase.

\(fn)" t nil)

(autoload 'magit-svn-dcommit "magit/magit-svn" "\
Run git-svn dcommit.

\(fn)" t nil)

(autoload 'magit-svn-remote-update "magit/magit-svn" "\
Run git-svn fetch.

\(fn)" t nil)

(autoload 'magit-svn-fetch-externals "magit/magit-svn" "\
Loops through all external repos found by `magit-svn-external-directories'
   and runs git svn fetch, and git svn rebase on each of them.

\(fn)" t nil)

(autoload 'magit-svn-mode "magit/magit-svn" "\
SVN support for Magit

\(fn &optional ARG)" t nil)

(autoload 'turn-on-magit-svn "magit/magit-svn" "\
Unconditionally turn on `magit-svn-mode'.

\(fn)" nil nil)

(custom-add-option 'magit-mode-hook #'magit-svn-mode)

;;;***

;;;### (autoloads (turn-on-magit-topgit magit-topgit-mode) "magit/magit-topgit"
;;;;;;  "magit/magit-topgit.el" (21516 22223 225496 81000))
;;; Generated autoloads from magit/magit-topgit.el

(autoload 'magit-topgit-mode "magit/magit-topgit" "\
Topgit support for Magit

\(fn &optional ARG)" t nil)

(autoload 'turn-on-magit-topgit "magit/magit-topgit" "\
Unconditionally turn on `magit-topgit-mode'.

\(fn)" nil nil)

(custom-add-option 'magit-mode-hook #'magit-topgit-mode)

;;;***

;;;### (autoloads (global-magit-wip-save-mode magit-wip-save-mode)
;;;;;;  "magit/magit-wip" "magit/magit-wip.el" (21516 22223 225496
;;;;;;  81000))
;;; Generated autoloads from magit/magit-wip.el

(autoload 'magit-wip-save-mode "magit/magit-wip" "\
Magit support for committing to a work-in-progress ref.

When this minor mode is turned on and a file is saved inside a
writable git repository then it is also committed to a special
work-in-progress ref.

\(fn &optional ARG)" t nil)

(defvar global-magit-wip-save-mode nil "\
Non-nil if Global-Magit-Wip-Save mode is enabled.
See the command `global-magit-wip-save-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-magit-wip-save-mode'.")

(custom-autoload 'global-magit-wip-save-mode "magit/magit-wip" nil)

(autoload 'global-magit-wip-save-mode "magit/magit-wip" "\
Toggle Magit-Wip-Save mode in all buffers.
With prefix ARG, enable Global-Magit-Wip-Save mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Magit-Wip-Save mode is enabled in all buffers where
`turn-on-magit-wip-save' would do it.
See `magit-wip-save-mode' for more information on Magit-Wip-Save mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (php-mode php-file-patterns php-mode-to-use) "php-mode-improved/php-mode-improved"
;;;;;;  "php-mode-improved/php-mode-improved.el" (21516 22163 22493
;;;;;;  440000))
;;; Generated autoloads from php-mode-improved/php-mode-improved.el

(defvar php-mode-to-use (progn (require 'mumamo nil t) (if (fboundp 'nxhtml-mumamo-turn-on) 'nxhtml-mumamo-turn-on (if (fboundp 'html-mumamo-turn-on) 'html-mumamo-turn-on 'php-mode))) "\
Major mode turn on function to use for php files.")

(custom-autoload 'php-mode-to-use "php-mode-improved/php-mode-improved" t)

(defvar php-file-patterns '("\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'") "\
List of file patterns for which to automatically invoke `php-mode'.")

(custom-autoload 'php-file-patterns "php-mode-improved/php-mode-improved" nil)

(autoload 'php-mode "php-mode-improved/php-mode-improved" "\
Major mode for editing PHP code.

\\{php-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads (svn-status svn-checkout) "psvn/psvn" "psvn/psvn.el"
;;;;;;  (21516 22142 813492 554000))
;;; Generated autoloads from psvn/psvn.el

(autoload 'svn-checkout "psvn/psvn" "\
Run svn checkout REPOS-URL PATH.

\(fn REPOS-URL PATH)" t nil)
 (defalias 'svn-examine 'svn-status)

(autoload 'svn-status "psvn/psvn" "\
Examine the status of Subversion working copy in directory DIR.
If ARG is -, allow editing of the parameters. One could add -N to
run svn status non recursively to make it faster.
For every other non nil ARG pass the -u argument to `svn status', which
asks svn to connect to the repository and check to see if there are updates
there.

If there is no .svn directory, examine if there is CVS and run
`cvs-examine'. Otherwise ask if to run `dired'.

\(fn DIR &optional ARG)" t nil)

;;;***

;;;### (autoloads (smex-initialize smex-major-mode-commands smex)
;;;;;;  "smex/smex" "smex/smex.el" (21516 22208 757495 447000))
;;; Generated autoloads from smex/smex.el

(autoload 'smex "smex/smex" "\


\(fn)" t nil)

(autoload 'smex-major-mode-commands "smex/smex" "\
Like `smex', but limited to commands that are relevant to the active major mode.

\(fn)" t nil)

(autoload 'smex-initialize "smex/smex" "\


\(fn)" t nil)

;;;***

;;;### (autoloads (switch-window delete-other-window) "switch-window/switch-window"
;;;;;;  "switch-window/switch-window.el" (21516 22165 327493 542000))
;;; Generated autoloads from switch-window/switch-window.el

(autoload 'delete-other-window "switch-window/switch-window" "\
Display an overlay in each window showing a unique key, then
ask user which window to delete

\(fn)" t nil)

(autoload 'switch-window "switch-window/switch-window" "\
Display an overlay in each window showing a unique key, then
ask user for the window where move to

\(fn)" t nil)

;;;***

;;;### (autoloads (global-undo-tree-mode undo-tree-mode) "undo-tree/undo-tree"
;;;;;;  "undo-tree/undo-tree.el" (21516 22709 546517 413000))
;;; Generated autoloads from undo-tree/undo-tree.el

(autoload 'undo-tree-mode "undo-tree/undo-tree" "\
Toggle undo-tree mode.
With no argument, this command toggles the mode.
A positive prefix argument turns the mode on.
A negative prefix argument turns it off.

Undo-tree-mode replaces Emacs' standard undo feature with a more
powerful yet easier to use version, that treats the undo history
as what it is: a tree.

The following keys are available in `undo-tree-mode':

  \\{undo-tree-map}

Within the undo-tree visualizer, the following keys are available:

  \\{undo-tree-visualizer-mode-map}

\(fn &optional ARG)" t nil)

(defvar global-undo-tree-mode nil "\
Non-nil if Global-Undo-Tree mode is enabled.
See the command `global-undo-tree-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-undo-tree-mode'.")

(custom-autoload 'global-undo-tree-mode "undo-tree/undo-tree" nil)

(autoload 'global-undo-tree-mode "undo-tree/undo-tree" "\
Toggle Undo-Tree mode in all buffers.
With prefix ARG, enable Global-Undo-Tree mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Undo-Tree mode is enabled in all buffers where
`turn-on-undo-tree-mode' would do it.
See `undo-tree-mode' for more information on Undo-Tree mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (yas-global-mode yas-minor-mode) "yasnippet/yasnippet"
;;;;;;  "yasnippet/yasnippet.el" (21516 22183 213494 326000))
;;; Generated autoloads from yasnippet/yasnippet.el

(autoload 'yas-minor-mode "yasnippet/yasnippet" "\
Toggle YASnippet mode.

When YASnippet mode is enabled, `yas-expand', normally bound to
the TAB key, expands snippets of code depending on the major
mode.

With no argument, this command toggles the mode.
positive prefix argument turns on the mode.
Negative prefix argument turns off the mode.

Key bindings:
\\{yas-minor-mode-map}

\(fn &optional ARG)" t nil)

(defvar yas-global-mode nil "\
Non-nil if Yas-Global mode is enabled.
See the command `yas-global-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `yas-global-mode'.")

(custom-autoload 'yas-global-mode "yasnippet/yasnippet" nil)

(autoload 'yas-global-mode "yasnippet/yasnippet" "\
Toggle Yas minor mode in all buffers.
With prefix ARG, enable Yas-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Yas minor mode is enabled in all buffers where
`yas-minor-mode-on' would do it.
See `yas-minor-mode' for more information on Yas minor mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (zencoding-preview zencoding-expand-yas zencoding-mode
;;;;;;  zencoding-expand-line) "zencoding-mode/zencoding-mode" "zencoding-mode/zencoding-mode.el"
;;;;;;  (21516 22189 201494 589000))
;;; Generated autoloads from zencoding-mode/zencoding-mode.el

(autoload 'zencoding-expand-line "zencoding-mode/zencoding-mode" "\
Replace the current line's zencode expression with the corresponding expansion.
If prefix ARG is given or region is visible call `zencoding-preview' to start an
interactive preview.

Otherwise expand line directly.

For more information see `zencoding-mode'.

\(fn ARG)" t nil)

(autoload 'zencoding-mode "zencoding-mode/zencoding-mode" "\
Minor mode for writing HTML and CSS markup.
With zen coding for HTML and CSS you can write a line like

  ul#name>li.item*2

and have it expanded to

  <ul id=\"name\">
    <li class=\"item\"></li>
    <li class=\"item\"></li>
  </ul>

This minor mode defines keys for quick access:

\\{zencoding-mode-keymap}

Home page URL `http://www.emacswiki.org/emacs/ZenCoding'.

See also `zencoding-expand-line'.

\(fn &optional ARG)" t nil)

(autoload 'zencoding-expand-yas "zencoding-mode/zencoding-mode" "\


\(fn)" t nil)

(autoload 'zencoding-preview "zencoding-mode/zencoding-mode" "\
Expand zencode between BEG and END interactively.
This will show a preview of the expanded zen code and you can
accept it or skip it.

\(fn BEG END)" t nil)

;;;***

;;;### (autoloads nil nil ("auctex/auctex.el" "auctex/auto-loads.el"
;;;;;;  "auctex/lpath.el" "auctex/preview/auto.el" "auctex/preview/preview-latex.el"
;;;;;;  "auctex/preview/prv-emacs.el" "auctex/preview/prv-install.el"
;;;;;;  "auctex/preview/prv-xemacs.el" "auctex/tex-buf.el" "auctex/tex-mik.el"
;;;;;;  "auctex/tex-site.el" "auctex/tex-style.el" "auctex/tex-wizard.el"
;;;;;;  "auto-complete-clang/auto-complete-clang.el" "auto-complete/auto-complete-pkg.el"
;;;;;;  "cedet/cedet-build.el" "cedet/cedet-devel-load.el" "cedet/cedet-ediff.el"
;;;;;;  "cedet/cedet-emacs-merge.el" "cedet/cedet-remove-builtin.el"
;;;;;;  "cedet/cedet-update-changelog.el" "cedet/cedet-update-version.el"
;;;;;;  "color-theme-solarized/color-theme-solarized-pkg.el" "color-theme-solarized/solarized-dark-theme.el"
;;;;;;  "color-theme-solarized/solarized-light-theme.el" "color-theme-tango/color-theme-tango.el"
;;;;;;  "color-theme/color-theme-autoloads.el" "dropdown-list/dropdown-list.el"
;;;;;;  "el-get/el-get-autoloads.el" "el-get/el-get-build.el" "el-get/el-get-byte-compile.el"
;;;;;;  "el-get/el-get-core.el" "el-get/el-get-custom.el" "el-get/el-get-dependencies.el"
;;;;;;  "el-get/el-get-install.el" "el-get/el-get-methods.el" "el-get/el-get-notify.el"
;;;;;;  "el-get/el-get-recipes.el" "el-get/el-get-status.el" "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-el-loaddefs.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/debian-el.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/debian-el/gnus-BTS.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/devscripts-el/devscripts.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/devscripts-el/pbuilder-log-view-mode.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/devscripts-el/pbuilder-mode.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/dpkg-dev-el-loaddefs.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/dpkg-dev-el/dpkg-dev-el.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/auto-fill-inhibit.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/clipper.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/coffee.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme-library.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/color-theme_seldefcustom.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/csv-mode.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/dict.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/dir-locals.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/emacs-goodies-build.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/emacs-goodies-custom.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/emacs-goodies-el.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/emacs-goodies-loaddefs.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/eproject.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/filladapt.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/highlight-completion.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/initsplit.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/keywiz.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/maplev.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/minibuf-electric.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/minibuffer-complete-cycle.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/mutt-alias.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/todoo.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/toggle-option.el"
;;;;;;  "emacs-goodies-el/emacs-goodies-el/elisp/emacs-goodies-el/upstart-mode.el"
;;;;;;  "escreen/escreen.el" "evil/evil-command-window.el" "evil/evil-commands.el"
;;;;;;  "evil/evil-common.el" "evil/evil-digraphs.el" "evil/evil-ex.el"
;;;;;;  "evil/evil-integration.el" "evil/evil-macros.el" "evil/evil-maps.el"
;;;;;;  "evil/evil-pkg.el" "evil/evil-repeat.el" "evil/evil-search.el"
;;;;;;  "evil/evil-states.el" "evil/evil-tests.el" "evil/evil-types.el"
;;;;;;  "evil/evil-vars.el" "evil/evil.el" "fuzzy/fuzzy.el" "magit/magit-autoloads.el"
;;;;;;  "magit/magit-version.el" "main-line/main-line.el" "popup/popup.el"
;;;;;;  "yasnippet/yasnippet-debug.el" "yasnippet/yasnippet-tests.el")
;;;;;;  (21516 26631 546842 377000))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
