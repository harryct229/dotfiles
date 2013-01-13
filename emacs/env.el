
(defun tung/add-to-path (paths)
  (dolist (path paths)
    (push (expand-file-name path) exec-path)
    (setenv "PATH" (concat (expand-file-name path) ":" (getenv "PATH")))))

;; Homebrew
(tung/add-to-path '("~/local/bin"))

;; rbenv
(tung/add-to-path '("~/.rbenv/bin"
                    "~/.rbenv/shims"))

;; System
(tung/add-to-path '("/usr/local/bin"
                    "/Applications/Xcode.app/Contents/Developer/usr/bin"))

