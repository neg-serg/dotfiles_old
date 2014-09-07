;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ede-android-project ede-android-load) "ede/android"
;;;;;;  "android.el" (21516 23376 455347 0))
;;; Generated autoloads from android.el

(autoload 'ede-android-load "ede/android" "\
Return an Android Project object if there is a match.
Return nil if there isn't one.
Argument DIR is the directory it is created for.
ROOTPROJ is nil, since there is only one project.

\(fn DIR &optional ROOTPROJ)" nil nil)

(ede-add-project-autoload (ede-project-autoload "android" :name "ANDROID ROOT" :file 'ede/android :proj-file "AndroidManifest.xml" :load-type 'ede-android-load :class-sym 'ede-android-project :new-p t :safe-p t))

(eieio-defclass-autoload 'ede-android-project '(ede-project) "ede/android" "Project for Android applications.")

;;;***

;;;### (autoloads (ede-ant-project ede-ant-load) "ede/ant" "ant.el"
;;;;;;  (21516 23376 455347 0))
;;; Generated autoloads from ant.el

(defconst ede-ant-project-file-name "build.xml" "\
name of project file for Ant projects")

(autoload 'ede-ant-load "ede/ant" "\
Return a Leiningen Project object if there is a match.
Return nil if there isn't one.
Argument DIR is the directory it is created for.
ROOTPROJ is nil, since there is only one project.

\(fn DIR &optional ROOTPROJ)" nil nil)

(eieio-defclass-autoload 'ede-ant-project '(ede-jvm-base-project) "ede/ant" "EDE Ant project class.")

(ede-add-project-autoload (ede-project-autoload "ant" :name "Ant" :file 'ede/ant :proj-file (if (featurep 'ede/ant) ede-ant-project-file-name "build.xml") :load-type 'ede-ant-load :class-sym 'ede-ant-project :new-p nil :safe-p t) 'generic)

;;;***

;;;### (autoloads (ede-arduino-load ede-arduino-file ede-arduino-root)
;;;;;;  "ede/arduino" "arduino.el" (21516 23376 455347 0))
;;; Generated autoloads from arduino.el

(autoload 'ede-arduino-root "ede/arduino" "\
Get the root project directory for DIR.
The only arduino sketches allowed are those configured by the arduino IDE
in their sketch directory.

If BASEFILE is non-nil, then convert root to the project basename also.

\(fn &optional DIR BASEFILE)" nil nil)

(autoload 'ede-arduino-file "ede/arduino" "\
Get a file representing the root of this arduino project.
It is a file ending in .pde or .ino that has the same basename as
the directory it is in.  Optional argument DIR is the directory
to check.

\(fn &optional DIR)" nil nil)

(autoload 'ede-arduino-load "ede/arduino" "\
Return an Arduino project object if there is one.
Return nil if there isn't one.
Argument DIR is the directory it is created for.
ROOTPROJ is nil, sinc there is only one project for a directory tree.

\(fn DIR &optional ROOTPROJ)" nil nil)

(ede-add-project-autoload (ede-project-autoload "arduino" :name "ARDUINO SKETCH" :file 'ede/arduino :root-only nil :proj-root-dirmatch (ede-project-autoload-dirmatch "arduino" :fromconfig (if (boundp 'ede-arduino-preferences-file) ede-arduino-preferences-file "~/.arduino/preferences.txt") :configregex "^sketchbook.path=\\([^\n]+\\)$" :configregexidx 1) :proj-file 'ede-arduino-file :load-type 'ede-arduino-load :class-sym 'ede-arduino-project :safe-p t :new-p t) 'unique)

;;;***

;;;### (autoloads (ede-cpp-root-project) "ede/cpp-root" "cpp-root.el"
;;;;;;  (21516 23376 455347 0))
;;; Generated autoloads from cpp-root.el

(eieio-defclass-autoload 'ede-cpp-root-project '(ede-project eieio-instance-tracker) "ede/cpp-root" "EDE cpp-root project class.\nEach directory needs a project file to control it.")

;;;***

;;;### (autoloads (ede-project-sort-targets ede-customize-current-target
;;;;;;  ede-customize-project) "ede/custom" "custom.el" (21516 23376
;;;;;;  455347 0))
;;; Generated autoloads from custom.el

(autoload 'ede-customize-project "ede/custom" "\
Edit fields of the current project through EIEIO & Custom.

\(fn)" t nil)

(defalias 'customize-project 'ede-customize-project)

(autoload 'ede-customize-current-target "ede/custom" "\
Edit fields of the current target through EIEIO & Custom.

\(fn)" t nil)

(defalias 'customize-target 'ede-customize-current-target)

(autoload 'ede-project-sort-targets "ede/custom" "\
Create a custom-like buffer for sorting targets of current project.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "ede/emacs" "emacs.el" (21516 23376 455347
;;;;;;  0))
;;; Generated autoloads from emacs.el

(ede-add-project-autoload (ede-project-autoload "emacs" :name "EMACS ROOT" :file 'ede/emacs :proj-file "src/emacs.c" :load-type 'ede-emacs-load :class-sym 'ede-emacs-project :new-p nil :safe-p t) 'unique)

;;;***

;;;### (autoloads (ede-find-file) "ede/files" "files.el" (21516 23376
;;;;;;  455347 0))
;;; Generated autoloads from files.el

(autoload 'ede-find-file "ede/files" "\
Find FILE in project.  FILE can be specified without a directory.
There is no completion at the prompt.  FILE is searched for within
the current EDE project.

\(fn FILE)" t nil)

;;;***

;;;### (autoloads (ede-enable-generic-projects) "ede/generic" "generic.el"
;;;;;;  (21516 23376 455347 0))
;;; Generated autoloads from generic.el

(autoload 'ede-enable-generic-projects "ede/generic" "\
Enable generic project loaders.

\(fn)" t nil)

;;;***

;;;### (autoloads (ede-java-root-project) "ede/java-root" "java-root.el"
;;;;;;  (21516 23376 455347 0))
;;; Generated autoloads from java-root.el

(eieio-defclass-autoload 'ede-java-root-project '(ede-jvm-base-project eieio-instance-tracker) "ede/java-root" "EDE java-root project class.\nEach directory needs a project file to control it.")

;;;***

;;;### (autoloads (ede-jvm-base-project) "ede/jvm-base" "jvm-base.el"
;;;;;;  (21516 23376 455347 0))
;;; Generated autoloads from jvm-base.el

(eieio-defclass-autoload 'ede-jvm-base-project '(ede-project) "ede/jvm-base" "Base project class for JVM-base projects.")

;;;***

;;;### (autoloads (ede-lein2-project ede-lein2-load) "ede/lein2"
;;;;;;  "lein2.el" (21516 23376 455347 0))
;;; Generated autoloads from lein2.el

(defconst ede-lein2-project-file-name "project.clj" "\
name of project file for Lein2 projects")

(autoload 'ede-lein2-load "ede/lein2" "\
Return a Leiningen Project object if there is a match.
Return nil if there isn't one.
Argument DIR is the directory it is created for.
ROOTPROJ is nil, since there is only one project.

\(fn DIR &optional ROOTPROJ)" nil nil)

(eieio-defclass-autoload 'ede-lein2-project '(ede-jvm-base-project) "ede/lein2" "EDE Leiningen2 project class.")

(ede-add-project-autoload (ede-project-autoload "lein2" :name "Lein2" :file 'ede/lein2 :proj-file (if (featurep 'ede/lein2) ede-lein2-project-file-name "project.clj") :load-type 'ede-lein2-load :class-sym 'ede-lein2-project :new-p nil :safe-p t) 'generic)

;;;***

;;;### (autoloads (ede-linux-load) "ede/linux" "linux.el" (21516
;;;;;;  23376 455347 0))
;;; Generated autoloads from linux.el

(autoload 'ede-linux-load "ede/linux" "\
Return an Linux Project object if there is a match.
Return nil if there isn't one.
Argument DIR is the directory it is created for.
ROOTPROJ is nil, since there is only one project.

\(fn DIR &optional ROOTPROJ)" nil nil)

(ede-add-project-autoload (ede-project-autoload "linux" :name "LINUX ROOT" :file 'ede/linux :proj-file "scripts/ver_linux" :load-type 'ede-linux-load :class-sym 'ede-linux-project :new-p nil :safe-p t) 'unique)

;;;***

;;;### (autoloads (ede-enable-locate-on-project) "ede/locate" "locate.el"
;;;;;;  (21516 23376 455347 0))
;;; Generated autoloads from locate.el

(autoload 'ede-enable-locate-on-project "ede/locate" "\
Enable an EDE locate feature on PROJECT.
Attempt to guess which project locate style to use
based on `ede-locate-setup-options'.

\(fn &optional PROJECT)" t nil)

;;;***

;;;### (autoloads (ede-m3-install) "ede/m3" "m3.el" (21516 23376
;;;;;;  455347 0))
;;; Generated autoloads from m3.el

(autoload 'ede-m3-install "ede/m3" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads (ede-make-check-version) "ede/make" "make.el" (21516
;;;;;;  23376 455347 0))
;;; Generated autoloads from make.el

(autoload 'ede-make-check-version "ede/make" "\
Check the version of GNU Make installed.
The check passes if the MAKE version is no high enough, or if it
is not GNU make.
If NOERROR is non-nil, return t for success, nil for failure.
If NOERROR is nil, then throw an error on failure.  Return t otherwise.

\(fn &optional NOERROR)" t nil)

;;;***

;;;### (autoloads (ede-maven2-project ede-maven2-load) "ede/maven2"
;;;;;;  "maven2.el" (21516 23376 455347 0))
;;; Generated autoloads from maven2.el

(autoload 'ede-maven2-load "ede/maven2" "\
Return a Maven Project object if there is a match.
Return nil if there isn't one.
Argument DIR is the directory it is created for.
ROOTPROJ is nil, since there is only one project.

\(fn DIR &optional ROOTPROJ)" nil nil)

(eieio-defclass-autoload 'ede-maven2-project '(ede-jvm-base-project) "ede/maven2" "Project Type for Maven2 based Java projects.")

(ede-add-project-autoload (ede-project-autoload "maven2" :name "MAVEN2" :file 'ede/maven2 :proj-file (if (featurep 'ede/lein2) ede-maven2-project-file-name "pom.xml") :load-type 'ede-maven2-load :class-sym 'ede-maven2-project :new-p nil :safe-p t) 'generic)

;;;***

;;;### (autoloads (ede-speedbar-file-setup) "ede/speedbar" "speedbar.el"
;;;;;;  (21516 23376 455347 0))
;;; Generated autoloads from speedbar.el

(autoload 'ede-speedbar-file-setup "ede/speedbar" "\
Setup some keybindings in the Speedbar File display.

\(fn)" nil nil)

;;;***

;;;### (autoloads (ede-vc-project-directory ede-upload-html-documentation
;;;;;;  ede-upload-distribution ede-edit-web-page ede-web-browse-home)
;;;;;;  "ede/system" "system.el" (21516 23376 455347 0))
;;; Generated autoloads from system.el

(autoload 'ede-web-browse-home "ede/system" "\
Browse the home page of the current project.

\(fn)" t nil)

(autoload 'ede-edit-web-page "ede/system" "\
Edit the web site for this project.

\(fn)" t nil)

(autoload 'ede-upload-distribution "ede/system" "\
Upload the current distribution to the correct location.
Use /user@ftp.site.com: file names for FTP sites.
Download tramp, and use /r:machine: for names on remote sites w/out FTP access.

\(fn)" t nil)

(autoload 'ede-upload-html-documentation "ede/system" "\
Upload the current distributions documentation as HTML.
Use /user@ftp.site.com: file names for FTP sites.
Download tramp, and use /r:machine: for names on remote sites w/out FTP access.

\(fn)" t nil)

(autoload 'ede-vc-project-directory "ede/system" "\
Run `vc-dir' on the current project.

\(fn)" t nil)

;;;***

;;;### (autoloads (ede-update-version) "ede/util" "util.el" (21516
;;;;;;  23376 455347 0))
;;; Generated autoloads from util.el

(autoload 'ede-update-version "ede/util" "\
Update the current projects main version number.
Argument NEWVERSION is the version number to use in the current project.

\(fn NEWVERSION)" t nil)

;;;***

;;;### (autoloads nil nil ("auto.el" "autoconf-edit.el" "base.el"
;;;;;;  "detect.el" "dired.el" "makefile-edit.el" "pconf.el" "pmake.el"
;;;;;;  "proj-archive.el" "proj-aux.el" "proj-comp.el" "proj-elisp.el"
;;;;;;  "proj-info.el" "proj-misc.el" "proj-obj.el" "proj-prog.el"
;;;;;;  "proj-scheme.el" "proj-shared.el" "proj.el" "project-am.el"
;;;;;;  "shell.el" "source.el" "srecode.el") (21516 23378 812836
;;;;;;  671000))

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
