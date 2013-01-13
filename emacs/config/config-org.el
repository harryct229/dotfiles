
(eval-after-load 'org-mode
  '(progn
     (if (file-directory-p "~/Dropbox/org")
         (setq org-directory "~/Dropbox/org/")
       (setq org-directory "~/"))

     (setq org-default-notes-file "~/Dropbox/org/inbox.org"

           org-completion-use-ido t
           org-outline-path-complete-in-steps nil
           org-log-done t
           org-use-fast-todo-selection t
           org-treat-S-cursor-todo-selection-as-state-change nil
           org-footnote-auto-label 'plain
           org-special-ctrl-a/e t
           org-hide-leading-stars t

           org-todo-state-tags-triggers
           '(("CANCELLED" ("CANCELLED" . t))
             ("WAITING" ("WAITING" . t))
             ("HOLD" ("WAITING" . t) ("HOLD" . t))
             (done ("WAITING") ("HOLD"))
             ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
             ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
             ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))

           org-todo-keywords
           '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
             (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))
           )))

(defun tung/make-mini-frame-with-title (title)
  (modify-frame-parameters
   nil
   `((name . ,title)
     (width . 80) (height . 15)
     (vertical-scroll-bar . nil)
     (menu-bar-line . nil) (tool-bar-lines . nil))))


;; Org Agenda
(defun tung/agenda-frame ()
  (tung/make-mini-frame-with-title "Agenda")
  (if (fboundp 'x-focus-frame)
      (x-focus-frame nil))
  (let ((org-agenda-window-setup 'current-window))
    (org-agenda-list)))

;; (add-hook
;;  'org-agenda-mode-hook
;;  (lambda ()
;;    (if (string= (frame-parameter nil 'name) "Agenda")
;;        (tung/set-key 'local "x" (lambda () (org-agenda-exit) (delete-frame)))
;;      (tung/set-key 'local "x" 'org-agenda-exit))))


;; Org Capture
(eval-after-load 'org-mode
  '(setq org-capture-templates
         '(("t" "Todo"
            entry (file (format "%s/inbox.org" org-directory))
            "* TODO %?\n  %i\n  %a")

           ("x" "Note with Clipboard"
            entry (file (format "%s/notes.org" org-directory))
            "* %?\n  %i\n  %x")

           ("n" "Note"
            entry (file (format "%s/notes.org" org-directory))
            "* %?\n  %i\n  %a")

           ;; dedicated templates
           ("s" "Save link for reading"
            entry (file+headline (format "%s/links.org" org-directory) "Unsorted")
            "* %:description\n  %:link\n  %U"))))

(defun tung/capture-frame ()
  (tung/make-mini-frame-with-title "Capture")
  (if (fboundp 'x-focus-frame)
        (x-focus-frame nil))
  (org-capture)
  (linum-mode -1)
  (delete-other-windows))

(defun tung/capture-wrap (fun)
  (let ((capture-frame? (string= (frame-parameter nil 'name) "Capture Frame")))
    (if capture-frame?
        (make-frame-invisible))
    (funcall fun)
    (if capture-frame?
        (delete-frame))))

(defun tung/capture-frame-finalize ()
  (interactive)
  (tung/capture-wrap #'org-capture-finalize))

(defun tung/capture-frame-kill ()
  (interactive)
  (tung/capture-wrap #'org-capture-kill))

(defun tung/capture-frame-refile ()
  (interactive)
  (tung/capture-wrap #'org-capture-refile))

;; (add-hook
;;  'org-capture-mode-hook
;;  (lambda()
;;    (tung/fill-keymap 'local
;;                      "C-o C-c" #'tung/capture-frame-finalize
;;                      "C-o C-k" #'tung/capture-frame-kill
;;                      "C-o C-w" #'tung/capture-frame-refile)))

;; (tung/fill-keymap global-map
;;                   "C-o a" 'org-agenda
;;                   "C-o l" 'org-store-link
;;                   "C-o c" 'org-capture)


(eval-after-load 'evil
  '(progn
     (evil-define-key 'normal org-mode-map
       "zo" 'show-all
       (kbd "RET") 'org-open-at-point
       (kbd "M-m") 'hide-body
       (kbd "M-c") 'org-cycle
       ;; (kbd "M-j") 'org-metadown
       ;; (kbd "M-k") 'org-metaup
       (kbd "M-h") 'org-metaleft
       (kbd "M-l") 'org-metaright)
     (evil-define-key 'insert org-mode-map
       (kbd "M-j") 'org-metadown
       (kbd "M-k") 'org-metaup
       (kbd "M-h") 'org-metaleft
       (kbd "M-l") 'org-metaright)))


(provide 'config-org)
