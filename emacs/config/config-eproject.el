
(require 'eproject)
(require 'eproject-extras)

(eval-after-load 'eproject
  '(progn
     (setq eproject-completing-read-function
           'eproject--ido-completing-read)

     (defun eproject-ack (pattern)
       (interactive "sAck pattern: ")
       (let* ((root (eproject-root))
              (default-directory root)
              (files (eproject-list-project-files-relative root)))
         (ack-and-a-half pattern t default-directory)))

     (define-project-type scm-generic (generic)
       (or (look-for ".git") (look-for ".hg"))
       :irrelevant-files (append '() tung/ignore-patterns))

     (define-project-type ruby (generic)
       (or (look-for "Rakefile") (look-for "Gemfile") (look-for "config.ru")
           (look-for "\.gemspec=$"))
       :irrelevant-files (append '("vendor" "coverage/" "doc/" "docs/" ".rbenv-version" "tmp/")
                                 tung/ignore-patterns))

     (define-project-type node-js (generic)
       (or (look-for "package.json") (look-for "Cakefile") (look-for "node_modules"))
       :irrelevant-files (append '("node_modules")
                                 tung/ignore-patterns))
     ))

(defmacro ffa-finder (prefix prompt)
  `(lambda ()
     (interactive)
     (find-file (ido-completing-read
                 ,prompt
                 (mapcar #'eproject--shorten-filename
                         (eproject-list-project-files))
                 nil t
                 ,prefix))))

(eval-after-load 'evil
  '(progn
     (tung/fill-keymap evil-normal-state-map
                       "C-f g" #'eproject-ack
                       "C-f m" (ffa-finder "app/models/" "Model: ")
                       "C-f c" (ffa-finder "app/controllers/" "Controller: ")
                       "C-f v" (ffa-finder "app/views/" "View: ")
                       "C-f t" (ffa-finder "spec/" "Spec: ")
                       "C-f h" (ffa-finder "app/helpers/" "Helper: ")
                       "C-f j" (ffa-finder "app/assets/javascripts/" "JS: ")
                       "C-f s" (ffa-finder "app/assets/stylesheets/" "CSS: "))))


(provide 'config-eproject)
