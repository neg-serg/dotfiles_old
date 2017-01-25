; http://www.gnu.org/software/guile/guile.html
; Version: 1.8.6

; List of modifier: Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock), Mod3 (CapsLock), Mod4, Mod5 (Scroll).

(grab-all-keys)
; (ungrab-all-keys)
; (remove-all-keys)
(debug)

;(set-numlock! #t) ; Now you can use numlock as modifier
;(set-scrolllock! #t) ; Now you can use numlock as modifier
;(set-capslock! #t) ; Now you can use numlock as modifier

;(xbindkey '(Mod4 shift space) "notionflux -e 'toggle_frame_transp()'")
;(xbindkey '(Mod4 F11) "notionflux -e 'rofi.mainmenu()'")
;(xbindkey '(Mod1 Tab) "notionflux -e 'core.goto_previous()'")
;(xbindkey '(Mod4 slash) "notionflux -e 'core.goto_previous()'")
;(xbindkey '(Mod4 f) "notionflux -e 'ncmpcpp()'")
;(xbindkey '(Mod4 d) "notionflux -e 'console()'")

;;; Double click test
;(xbindkey-function '(control w)
;          (let ((count 0))
;            (lambda ()
;              (set! count (+ count 1))
;              (if (> count 1)
;              (begin
;               (set! count 0)
;               (run-command "xterm"))))))

;; Time double click test:
;;  - short double click -> run an xterm
;;  - long  double click -> run an rxvt
;(xbindkey-function '(shift w)
;          (let ((time (current-time))
;            (count 0))
;            (lambda ()
;              (set! count (+ count 1))
;              (if (> count 1)
;              (begin
;               (if (< (- (current-time) time) 1)
;               (run-command "xterm")
;               (run-command "rxvt"))
;               (set! count 0)))
;              (set! time (current-time)))))


;; Chording keys test: Start differents program if only one key is
;; pressed or another if two keys are pressed.
;; If key1 is pressed start cmd-k1
;; If key2 is pressed start cmd-k2
;; If both are pressed start cmd-k1-k2 or cmd-k2-k1 following the
;;   release order
;(define (define-chord-keys key1 key2 cmd-k1 cmd-k2 cmd-k1-k2 cmd-k2-k1)
;    "Define chording keys"
;  (let ((k1 #f) (k2 #f))
;    (xbindkey-function key1 (lambda () (set! k1 #t)))
;    (xbindkey-function key2 (lambda () (set! k2 #t)))
;    (xbindkey-function (cons 'release key1)
;               (lambda ()
;             (if (and k1 k2)
;                 (run-command cmd-k1-k2)
;                 (if k1 (run-command cmd-k1)))
;             (set! k1 #f) (set! k2 #f)))
;    (xbindkey-function (cons 'release key2)
;               (lambda ()
;             (if (and k1 k2)
;                 (run-command cmd-k2-k1)
;                 (if k2 (run-command cmd-k2)))
;             (set! k1 #f) (set! k2 #f)))))

; Example:
;   Shift + b:1                   start an xterm
;   Shift + b:3                   start an rxvt
;   Shift + b:1 then Shift + b:3  start gv
;   Shift + b:3 then Shift + b:1  start xpdf

;(define-chord-keys '(shift "b:1") '(shift "b:3")
;  "xterm" "rxvt" "gv" "xpdf")

;; Here the release order have no importance
;; (the same program is started in both case)
;(define-chord-keys '(alt "b:1") '(alt "b:3")
;  "gv" "xpdf" "xterm" "xterm")
