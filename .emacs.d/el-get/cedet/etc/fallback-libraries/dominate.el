;;; dominate.el --- copied from Emacs 24 files.el

;; Copyright (C) 1985-1987, 1992-2014 Free Software Foundation, Inc.

;; Maintainer: FSF
;; Package: emacs

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Contains `locate-dominating-file' from Emacs 24 for use with versions
;; of emacs that don't support a 'function' input as NAME.

(require 'files)

;; This uses locate-dominating-stop-dir-regexp which is also defined in
;; emacs 23.

(defun locate-dominating-file (file name)
  "Look up the directory hierarchy from FILE for a directory containing NAME.
Stop at the first parent directory containing a file NAME,
and return the directory.  Return nil if not found.
Instead of a string, NAME can also be a predicate taking one argument
\(a directory) and returning a non-nil value if that directory is the one for
which we're looking.

NOTE: The version of this function you are using is from Emacs 24.3.1,
backported for use in CEDET."
  ;; We used to use the above locate-dominating-files code, but the
  ;; directory-files call is very costly, so we're much better off doing
  ;; multiple calls using the code in here.
  ;;
  ;; Represent /home/luser/foo as ~/foo so that we don't try to look for
  ;; `name' in /home or in /.
  (setq file (abbreviate-file-name file))
  (let ((root nil)
        ;; `user' is not initialized outside the loop because
        ;; `file' may not exist, so we may have to walk up part of the
        ;; hierarchy before we find the "initial UID".  Note: currently unused
        ;; (user nil)
        try)
    (while (not (or root
                    (null file)
                    ;; FIXME: Disabled this heuristic because it is sometimes
                    ;; inappropriate.
                    ;; As a heuristic, we stop looking up the hierarchy of
                    ;; directories as soon as we find a directory belonging
                    ;; to another user.  This should save us from looking in
                    ;; things like /net and /afs.  This assumes that all the
                    ;; files inside a project belong to the same user.
                    ;; (let ((prev-user user))
                    ;;   (setq user (nth 2 (file-attributes file)))
                    ;;   (and prev-user (not (equal user prev-user))))
                    (string-match locate-dominating-stop-dir-regexp file)))
      (setq try (if (stringp name)
                    (file-exists-p (expand-file-name name file))
                  (funcall name file)))
      (cond (try (setq root file))
            ((equal file (setq file (file-name-directory
                                     (directory-file-name file))))
             (setq file nil))))
    (if root (file-name-as-directory root))))

(provide 'cedet/dominate)
