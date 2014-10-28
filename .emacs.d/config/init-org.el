(add-hook
 'org-load-hook
 (lambda ()
   (unless (file-exists-p org-directory)
     (make-directory org-directory))

   (setq my-inbox-org-file (concat org-directory "/inbox.org"))

   (setq org-default-notes-file my-inbox-org-file)
   (setq org-log-done t)

   (setq org-startup-indented t)
   (setq org-indent-indentation-per-level 3)

   (setq org-agenda-files `(,org-directory))
   (setq org-capture-templates
         '(("t" "Todo" entry (file+headline my-inbox-org-file "INBOX")
            "* TODO %?\n%U\n%a\n")
           ("n" "Note" entry (file+headline my-inbox-org-file "NOTES")
            "* %? :NOTE:\n%U\n%a\n")
           ("m" "Meeting" entry (file my-inbox-org-file)
            "* MEETING %? :MEETING:\n%U")
           ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
            "* %?\n%U\n")))

   (setq org-use-fast-todo-selection t)
   (setq org-treat-S-cursor-todo-selection-as-state-change nil)
   (setq org-todo-keywords
         '((sequence "TODO(t)" "NEXT(n@)" "|" "DONE(d)")
           (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)")))

   (setq org-todo-state-tags-triggers
         ' (("CANCELLED" ("CANCELLED" . t))
            ("WAITING" ("WAITING" . t))
            ("TODO" ("WAITING") ("CANCELLED"))
            ("NEXT" ("WAITING") ("CANCELLED"))
            ("DONE" ("WAITING") ("CANCELLED"))))

   (setq org-refile-targets '((nil :maxlevel . 9)
                              (org-agenda-files :maxlevel . 9)))
   (setq org-completion-use-ido t)

   (after 'org-mobile
     (setq org-mobile-directory (concat org-directory "/MobileOrg"))
     (unless (file-exists-p org-mobile-directory)
       (make-directory org-mobile-directory))
     (setq org-mobile-inbox-for-pull (concat org-directory "/from-mobile.org")))

   (after 'evil
     (add-hook 'org-capture-mode-hook 'evil-insert-state))

   (when (boundp 'org-plantuml-jar-path)
     (org-babel-do-load-languages
      'org-babel-load-languages
      '((plantuml . t))))

   (add-hook 'org-mode-hook (lambda ()
                              (when (or (executable-find "aspell")
                                        (executable-find "ispell")
                                        (executable-find "hunspell"))
                                (flyspell-mode))))))


(provide 'init-org)
