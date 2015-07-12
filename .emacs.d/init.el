(set-default-font "Pragmata Pro for Powerline-17")
(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(add-to-list 'load-path (concat user-emacs-directory "config"))

(require 'cl)
(require 'init-packages)
(require 'init-util)

(let ((base (concat user-emacs-directory "elisp")))
  (add-to-list 'load-path base)
  (dolist (dir (directory-files base t))
    (when (and (file-directory-p dir)
               (not (equal (file-name-nondirectory dir) ".."))
               (not (equal (file-name-nondirectory dir) ".")))
      (add-to-list 'load-path dir))))

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(defcustom dotemacs-modules
  '(init-core

    init-eshell
    init-org
    init-erc
    init-eyecandy

    init-smartparens
    ;; init-autopair

    init-yasnippet
    ;; init-auto-complete
    ;; init-company

    init-projectile
    init-helm
    init-ido

    init-vcs
    init-flycheck

    init-vim
    init-stylus
    init-js
    ;; init-go
    init-web
    init-lisp
    init-markdown

    init-misc
    init-evil
    init-bindings
    init-macros
    init-cedet

    init-solarized
    init-overrides)
  "Set of modules enabled in dotemacs."
  :group 'dotemacs)

(dolist (module dotemacs-modules)
  (require module))

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

;; the exact path may differ -- check it
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

;; Semantic

;(global-semantic-idle-completions-mode t)
;(global-semantic-decoration-mode t)
;(global-semantic-highlight-func-mode t)
;(global-semantic-show-unmatched-syntax-mode t)

;; CC-mode
(add-hook 'c-mode-common-hook '(lambda ()
        (setq ac-sources (append '(ac-source-semantic) ac-sources))
))
;; Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (expand-file-name
             "~/.emacs.d/elpa/auto-complete-20140824.1658/dict"))
(setq ac-comphist-file (expand-file-name
             "~/.emacs.d/ac-comphist.dat"))
(ac-config-default)
;; Autocomplete
;; start after 3 characters were typed
(setq ac-auto-start 3)
;; show menu immediately...
(setq ac-auto-show-menu t)
;; explicit call to auto-complete
(define-key ac-mode-map [(meta return)] 'auto-complete)

(require 'sdcv-mode)
(global-set-key (kbd "C-c d") 'sdcv-search)
(require 'mu4e)

;; default
(setq mu4e-maildir "~/.local/mail/gmail")
(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)
       ("/[Gmail].Trash"       . ?t)
       ("/[Gmail].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
   user-mail-address "serg.zorg@gmail.com"
   user-full-name  "Sergey Miroshnichenko"
   mu4e-compose-signature
    (concat
      "Foo X. Bar\n"
      "http://www.example.com\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
   smtpmail-auth-credentials
     '(("smtp.gmail.com" 587 "USERNAME@gmail.com" nil))
   smtpmail-default-smtp-server "smtp.gmail.com"
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)
