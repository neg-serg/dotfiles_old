;;; fields-utest.el --- 
;;
;; Copyright (C) 2011 Eric M. Ludlam
;;
;; Author: Eric M. Ludlam <eric@siege-engine.com>
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see http://www.gnu.org/licenses/.


;;; Commentary:
;;
;; 

(require 'srecode)
(require 'srecode/fields)

;;; Code:

;; Test out field modification w/out using srecode templates.
;;
(defvar srecode-field-utest-text
  "This is a test buffer.

It is filled with some text."
  "Text for tests.")

(defvar srecode-field-utest-filename
  (expand-file-name
   (concat (make-temp-name "srecode-field-test-") ".txt")
   temporary-file-directory))

;;;###autoload
(defun srecode-field-utest ()
  "Test the srecode field manager."
  (interactive)
  (if (featurep 'xemacs)
      (message "There is no XEmacs support for SRecode Fields.")
    (srecode-field-utest-impl)))

(defun srecode-field-utest-impl ()
  "Implementation of the SRecode field utest."
  (save-excursion
    (find-file srecode-field-utest-filename)
    (erase-buffer)
    (goto-char (point-min))
    (insert srecode-field-utest-text)
    (set-buffer-modified-p nil)

    ;; Test basic field generation.
    (let ((srecode-field-archive nil)
          (f nil))

      (end-of-line)
      (forward-word -1)

      (setq f (srecode-field "Test"
                             :name "TEST"
                             :start 6
                             :end 8))

      (when (or (not (slot-boundp f 'overlay)) (not (oref f overlay)))
        (error "Field test: Overlay info not created for field"))

      (when (and (overlayp (oref f overlay))
               (not (overlay-get (oref f overlay) 'srecode-init-only)))
        (error "Field creation overlay is not tagged w/ init flag"))

      (srecode-overlaid-activate f)

      (when (or (not (overlayp (oref f overlay)))
                (overlay-get (oref f overlay) 'srecode-init-only))
        (error "New field overlay not created during activation"))

      (when (not (= (length srecode-field-archive) 1))
        (error "Field test: Incorrect number of elements in the field archive"))
      (when (not (eq f (car srecode-field-archive)))
        (error "Field test: Field did not auto-add itself to the field archive"))

      (when (not (overlay-get (oref f overlay) 'keymap))
        (error "Field test: Overlay keymap not set"))

      (when (not (string= "is" (srecode-overlaid-text f)))
        (error "Field test: Expected field text 'is', not %s"
               (srecode-overlaid-text f)))

      ;; Test deletion.
      (srecode-delete f)

      (when (slot-boundp f 'overlay)
        (error "Field test: Overlay not deleted after object delete"))
      )

    ;; Test basic region construction.
    (let* ((srecode-field-archive nil)
           (reg nil)
           (fields
            (list
             (srecode-field "Test1" :name "TEST-1" :start 5 :end 10)
             (srecode-field "Test2" :name "TEST-2" :start 15 :end 20)
             (srecode-field "Test3" :name "TEST-3" :start 25 :end 30)

             (srecode-field "Test4" :name "TEST-4" :start 35 :end 35))
            ))

      (when (not (= (length srecode-field-archive) 4))
        (error "Region Test: Found %d fields.  Expected 4"
               (length srecode-field-archive)))

      (setq reg (srecode-template-inserted-region "REG"
                                                  :start 4
                                                  :end 40))

      (srecode-overlaid-activate reg)

      ;; Make sure it was cleared.
      (when srecode-field-archive
        (error "Region Test: Did not clear field archive"))

      ;; Auto-positioning.
      (when (not (eq (point) 5))
        (error "Region Test: Did not reposition on first field"))

      ;; Active region
      (when (not (eq (srecode-active-template-region) reg))
        (error "Region Test: Active region not set"))

      ;; Various sizes
      (mapc (lambda (T)
              (if (string= (object-name-string T) "Test4")
                  (progn
                    (when (not (srecode-empty-region-p T))
                      (error "Field %s is not empty"
                             (object-name T)))
                    )
                (when (not (= (srecode-region-size T) 5))
                  (error "Calculated size of %s was not 5"
                         (object-name T)))))
            fields)

      ;; Make sure things stay up after a 'command'.
      (srecode-field-post-command)
      (when (not (eq (srecode-active-template-region) reg))
        (error "Region Test: Active region did not stay up"))

      ;; Test field movement.
      (when (not (eq (srecode-overlaid-at-point 'srecode-field)
                     (nth 0 fields)))
        (error "Region Test: Field %s not under point"
               (object-name (nth 0 fields))))

      (srecode-field-next)

      (when (not (eq (srecode-overlaid-at-point 'srecode-field)
                     (nth 1 fields)))
        (error "Region Test: Field %s not under point"
               (object-name (nth 1 fields))))

      (srecode-field-prev)

      (when (not (eq (srecode-overlaid-at-point 'srecode-field)
                     (nth 0 fields)))
        (error "Region Test: Field %s not under point"
               (object-name (nth 0 fields))))

      ;; Move cursor out of the region and have everything cleaned up.
      (goto-char 42)
      (srecode-field-post-command)
      (when (srecode-active-template-region)
        (error "Region Test: Active region did not clear on move out"))

      (mapc (lambda (T)
              (when (slot-boundp T 'overlay)
                (error "Overlay did not clear off of of field %s"
                       (object-name T))))
            fields)

      ;; End of LET
      )

    ;; Test variable linkage.
    (let* ((srecode-field-archive nil)
           (f1 (srecode-field "Test1" :name "TEST" :start 6 :end 8))
           (f2 (srecode-field "Test2" :name "TEST" :start 28 :end 30))
           (f3 (srecode-field "Test3" :name "NOTTEST" :start 35 :end 40))
           (reg (srecode-template-inserted-region "REG" :start 4 :end 40))
           )
      (srecode-overlaid-activate reg)

      (when (not (string= (srecode-overlaid-text f1)
                          (srecode-overlaid-text f2)))
        (error "Linkage Test: Init strings are not ="))
      (when (string= (srecode-overlaid-text f1)
                     (srecode-overlaid-text f3))
        (error "Linkage Test: Init string on dissimilar fields is now the same"))

      (goto-char 7)
      (insert "a")

      (when (not (string= (srecode-overlaid-text f1)
                          (srecode-overlaid-text f2)))
        (error "Linkage Test: mid-insert strings are not ="))
      (when (string= (srecode-overlaid-text f1)
                     (srecode-overlaid-text f3))
        (error "Linkage Test: mid-insert string on dissimilar fields is now the same"))

      (goto-char 9)
      (insert "t")

      (when (not (string= (srecode-overlaid-text f1) "iast"))
        (error "Linkage Test: tail-insert failed to captured added char"))
      (when (not (string= (srecode-overlaid-text f1)
                        (srecode-overlaid-text f2)))
        (error "Linkage Test: tail-insert strings are not ="))
      (when (string= (srecode-overlaid-text f1)
                     (srecode-overlaid-text f3))
        (error "Linkage Test: tail-insert string on dissimilar fields is now the same"))

      (goto-char 6)
      (insert "b")

      (when (not (string= (srecode-overlaid-text f1) "biast"))
        (error "Linkage Test: tail-insert failed to captured added char"))
      (when (not (string= (srecode-overlaid-text f1)
                        (srecode-overlaid-text f2)))
        (error "Linkage Test: tail-insert strings are not ="))
      (when (string= (srecode-overlaid-text f1)
                     (srecode-overlaid-text f3))
        (error "Linkage Test: tail-insert string on dissimilar fields is now the same"))

      ;; Cleanup
      (srecode-delete reg)
      )

    (set-buffer-modified-p nil)

    (message "   All field tests passed.")
    (when (file-exists-p srecode-field-utest-filename)
      (delete-file srecode-field-utest-filename))
    ))


(provide 'cedet/srecode/fields-utest)

;;; fields-utest.el ends here
