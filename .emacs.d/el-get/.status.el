((auctex status "installed" recipe
	 (:name auctex :website "http://www.gnu.org/software/auctex/" :description "AUCTeX is an extensible package for writing and formatting TeX files in GNU Emacs and XEmacs. It supports many different TeX macro packages, including AMS-TeX, LaTeX, Texinfo, ConTeXt, and docTeX (dtx files)." :type git :module "auctex" :url "git://git.savannah.gnu.org/auctex.git" :build
		`(("./autogen.sh")
		  ("./configure" "--without-texmf-dir" "--with-packagelispdir=$(pwd)" "--with-packagedatadir=$(pwd)" ,(cond
														       ((eq system-type 'darwin)
															"--with-lispdir=`pwd`")
														       (t ""))
		   ,(concat "--with-emacs=" el-get-emacs))
		  "make")
		:load-path
		("." "preview")
		:load
		("tex-site.el" "preview/preview-latex.el")
		:info "doc"))
 (auto-complete status "installed" recipe
		(:name auto-complete :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :depends
		       (popup fuzzy)
		       :features auto-complete-config :post-init
		       (progn
			 (add-to-list 'ac-dictionary-directories
				      (expand-file-name "dict" default-directory))
			 (ac-config-default))))
 (auto-complete-clang status "installed" recipe
		      (:name auto-complete-clang :website "https://github.com/brianjcj/auto-complete-clang" :description "Auto-complete sources for Clang. Combine the power of AC, Clang and Yasnippet." :type github :pkgname "brianjcj/auto-complete-clang" :depends auto-complete))
 (buffer-move status "installed" recipe
	      (:name buffer-move :after
		     (progn
		       (global-set-key
			(kbd "<C-S-up>")
			'buf-move-up)
		       (global-set-key
			(kbd "<C-S-down>")
			'buf-move-down)
		       (global-set-key
			(kbd "<C-S-left>")
			'buf-move-left)
		       (global-set-key
			(kbd "<C-S-right>")
			'buf-move-right))
		     :description "Swap buffers without typing C-x b on each window" :type emacswiki :features buffer-move))
 (cedet status "installed" recipe
	(:name cedet :website "http://cedet.sourceforge.net/" :description "CEDET is a Collection of Emacs Development Environment Tools written with the end goal of creating an advanced development environment in Emacs." :type bzr :url "bzr://cedet.bzr.sourceforge.net/bzrroot/cedet/code/trunk" :build
	       `(("sh" "-c" "touch `find . -name Makefile`")
		 ("make" ,(format "EMACS=%s"
				  (shell-quote-argument el-get-emacs))
		  "clean-all")
		 ("make" ,(format "EMACS=%s"
				  (shell-quote-argument el-get-emacs)))
		 ("make" ,(format "EMACS=%s"
				  (shell-quote-argument el-get-emacs))
		  "-C" "contrib"))
	       :build/berkeley-unix
	       `(("sh" "-c" "touch `find . -name Makefile`")
		 ("gmake" ,(format "EMACS=%s"
				   (shell-quote-argument el-get-emacs))
		  "clean-all")
		 ("gmake" ,(format "EMACS=%s"
				   (shell-quote-argument el-get-emacs)))
		 ("gmake" ,(format "EMACS=%s"
				   (shell-quote-argument el-get-emacs))
		  "-C" "contrib"))
	       :build/windows-nt
	       ("echo #!/bin/sh > tmp.sh & echo touch `/usr/bin/find . -name Makefile` >> tmp.sh & echo make FIND=/usr/bin/find >> tmp.sh" "sed 's/^M$//' tmp.sh  > tmp2.sh" "sh ./tmp2.sh" "rm ./tmp.sh ./tmp2.sh")
	       :features nil :lazy nil :post-init
	       (if
		   (or
		    (featurep 'cedet-devel-load)
		    (featurep 'eieio))
		   (message
		    (concat "Emacs' built-in CEDET has already been loaded!  Restart" " Emacs to load CEDET from el-get instead."))
		 (load
		  (expand-file-name "cedet-devel-load.el" pdir)))))
 (cl-lib status "installed" recipe
	 (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (color-theme-solarized status "installed" recipe
			(:name color-theme-solarized :description "Emacs highlighting using Ethan Schoonover's Solarized color scheme" :type github :pkgname "sellout/emacs-color-theme-solarized" :depends color-theme :prepare
			       (progn
				 (add-to-list 'custom-theme-load-path default-directory)
				 (autoload 'color-theme-solarized-light "color-theme-solarized" "color-theme: solarized-light" t)
				 (autoload 'color-theme-solarized-dark "color-theme-solarized" "color-theme: solarized-dark" t))))
 (color-theme-tango status "installed" recipe
		    (:name color-theme-tango :description "Color theme based on Tango Palette. Created by danranx@gmail.com" :type emacswiki :depends color-theme :prepare
			   (autoload 'color-theme-tango "color-theme-tango" "color-theme: tango" t)))
 (dropdown-list status "installed" recipe
		(:name dropdown-list :auto-generated t :type emacswiki :description "Drop-down menu interface" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/dropdown-list.el"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:load "el-get.el"))
 (emacs-goodies-el status "installed" recipe
		   (:name emacs-goodies-el :website "http://packages.debian.org/sid/emacs-goodies-el" :description "Miscellaneous add-ons for Emacs" :type http-tar :url "http://alioth.debian.org/snapshots.php?group_id=30060" :options
			  ("xzf")
			  :build
			  (let*
			      ((pdir
				(el-get-package-directory 'emacs-goodies-el))
			       (pkg-goodies-dir
				(or
				 (car
				  (directory-files pdir 'full "^pkg-goodies-el-"))
				 pdir))
			       (default-directory
				 (file-name-as-directory
				  (expand-file-name "emacs-goodies-el" pkg-goodies-dir))))
			    (el-get-verbose-message "Building commands from %s" default-directory)
			    (el-get-verbose-message "Expecting commands to run in %s" pdir)
			    (append
			     (mapcar
			      (lambda
				(patch-file)
				(list "patch" "-p1" "-f" "--no-backup-if-mismatch" "-i"
				      (expand-file-name patch-file
							(expand-file-name "emacs-goodies-el/debian/patches" pdir))
				      "-d"
				      (expand-file-name "emacs-goodies-el" pdir)))
			      (with-temp-buffer
				(insert-file-contents "debian/patches/series")
				(split-string
				 (buffer-string)
				 "\n" t)))
			     (let
				 ((makerfiles
				   (split-string
				    (shell-command-to-string "find . -name '*.make'"))))
			       (el-get-verbose-message "Makerfiles: %S" makerfiles)
			       (mapcar
				(lambda
				  (makerfile)
				  (let*
				      ((maker-dir
					(expand-file-name
					 (file-name-directory makerfile)
					 (expand-file-name "emacs-goodies-el" pdir)))
				       (maker-command
					(replace-regexp-in-string "\n" ""
								  (replace-regexp-in-string "emacs -batch"
											    (concat el-get-emacs " -batch")
											    (with-temp-buffer
											      (insert-file-contents makerfile)
											      (buffer-string))))))
				    (format "cd %s && %s" maker-dir maker-command)))
				makerfiles))))
			  :load-path
			  ("emacs-goodies-el/elisp/debian-el" "emacs-goodies-el/elisp/devscripts-el" "emacs-goodies-el/elisp/dpkg-dev-el" "emacs-goodies-el/elisp/emacs-goodies-el")
			  :features
			  (emacs-goodies-el debian-el dpkg-dev-el)
			  :post-init
			  (progn
			    (autoload 'debuild "devscripts" "Run debuild in the current directory." t)
			    (autoload 'debc "devscripts" "Run debc in the current directory." t)
			    (autoload 'debi "devscripts" "Run debi in the current directory." t)
			    (autoload 'debit "devscripts" "Run debit in the current directory." t)
			    (autoload 'debdiff "devscripts" "Compare contents of CHANGES-FILE-1 and CHANGES-FILE-2." t)
			    (autoload 'debdiff-current "devscripts" "Compare the contents of .changes file of current version with previous version;\nrequires access to debian/changelog, and being in debian/ dir." t)
			    (autoload 'debclean "devscripts" "Run debclean in the current directory." t)
			    (autoload 'pdebuild "pbuilder-mode" "Run pdebuild in the current directory." t)
			    (autoload 'pdebuild-user-mode-linux "pbuilder-mode" "Run pdebuild-user-mode-linux in the current directory." t)
			    (autoload 'pbuilder-log-view-elserv "pbuilder-log-view-mode" "Run a elserv session with log view.\n\nRunning this requires elserv.  Use elserv, and do `elserv-start' before invoking this command." t)
			    (autoload 'debuild-pbuilder "pbuilder-mode" "Run debuild-pbuilder in the current directory." t)
			    (autoload 'pbuilder-build "pbuilder-mode" "Run pbuilder-build for the given filename." t)
			    (autoload 'pbuilder-user-mode-linux-build "pbuilder-mode" "Run pbuilder-user-mode-linux for the given filename." t))))
 (escreen status "installed" recipe
	  (:name escreen :description "Emacs window session manager" :type http :url "http://www.splode.com/~friedman/software/emacs-lisp/src/escreen.el" :prepare
		 (autoload 'escreen-install "escreen" nil t)))
 (evil status "installed" recipe
       (:name evil :website "http://gitorious.org/evil/pages/Home" :description "Evil is an extensible vi layer for Emacs. It\n       emulates the main features of Vim, and provides facilities\n       for writing custom extensions." :type git :url "git://gitorious.org/evil/evil.git" :features evil :depends
	      (undo-tree goto-chg)
	      :build
	      (("make" "all" "info"))
	      :build/berkeley-unix
	      (("gmake" "all" "info"))
	      :build/darwin
	      `(("make" ,(format "EMACS=%s" el-get-emacs)
		 "all" "info"))
	      :info "doc"))
 (fuzzy status "installed" recipe
	(:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (git-modes status "installed" recipe
	    (:name git-modes :description "GNU Emacs modes for various Git-related files" :type github :pkgname "magit/git-modes"))
 (goto-chg status "installed" recipe
	   (:name goto-chg :description "Goto the point of the most recent edit in the buffer." :type emacswiki :features goto-chg))
 (goto-last-change status "installed" recipe
		   (:name goto-last-change :after
			  (progn
			    (global-set-key
			     (kbd "C-x C-/")
			     'goto-last-change))
			  :description "Move point through buffer-undo-list positions" :type emacswiki :load "goto-last-change.el"))
 (highlight-indentation status "installed" recipe
			(:name highlight-indentation :description "Function for highlighting indentation" :type git :url "https://github.com/antonj/Highlight-Indentation-for-Emacs"))
 (magit status "installed" recipe
	(:name magit :after
	       (progn
		 (global-set-key
		  (kbd "C-x C-z")
		  'magit-status))
	       :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :depends
	       (cl-lib git-modes)
	       :info "." :build
	       (if
		   (version<= "24.3" emacs-version)
		   `(("make" ,(format "EMACS=%s" el-get-emacs)
		      "all"))
		 `(("make" ,(format "EMACS=%s" el-get-emacs)
		    "docs")))
	       :build/berkeley-unix
	       (("touch" "`find . -name Makefile`")
		("gmake"))
	       :prepare
	       (require 'magit-autoloads)))
 (main-line status "installed" recipe
	    (:name main-line :website "https://github.com/jasonm23/emacs-mainline" :description "Mainline for Emacs, a powerline fork" :type github :pkgname "jasonm23/emacs-mainline" :features main-line))
 (php-mode-improved status "installed" recipe
		    (:name php-mode-improved :description "Major mode for editing PHP code. This is a version of the php-mode from http://php-mode.sourceforge.net that fixes a few bugs which make using php-mode much more palatable" :type emacswiki :load
			   ("php-mode-improved.el")
			   :features php-mode))
 (popup status "installed" recipe
	(:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :pkgname "auto-complete/popup-el"))
 (psvn status "installed" recipe
       (:name psvn :description "Subversion interface for emacs" :type http :url "http://www.xsteve.at/prg/emacs/psvn.el"))
 (smex status "installed" recipe
       (:name smex :after
	      (progn
		(setq smex-save-file "~/.emacs.d/.smex-items")
		(global-set-key
		 (kbd "M-x")
		 'smex)
		(global-set-key
		 (kbd "M-X")
		 'smex-major-mode-commands))
	      :description "M-x interface with Ido-style fuzzy matching." :type github :pkgname "nonsequitur/smex" :features smex :post-init
	      (smex-initialize)))
 (switch-window status "installed" recipe
		(:name switch-window :description "A *visual* way to choose a window to switch to" :type github :pkgname "dimitri/switch-window" :features switch-window))
 (undo-tree status "installed" recipe
	    (:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/"))
 (yasnippet status "installed" recipe
	    (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :compile "yasnippet.el" :submodule nil :build
		   (("git" "submodule" "update" "--init" "--" "snippets"))))
 (zencoding-mode status "installed" recipe
		 (:name zencoding-mode :description "Unfold CSS-selector-like expressions to markup" :type github :pkgname "rooney/zencoding" :features zencoding-mode)))
