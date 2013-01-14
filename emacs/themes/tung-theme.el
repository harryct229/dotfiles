(deftheme tung
  "tung-theme
   Created : Sat Dec 22 20:02:57 2012 - Tung Dao <me@tungdao.com>
   licence : MIT

   My custom version based on Badwolf. Support things that I used.")

(let  ((class '((class color) (min-colors 89)))
       ;; named colors
       (plain "#e5e5e5")

       (snow "#ffffff")
       (coal "#000000")

       (brightgravel "#d0d0d0")
       (lightgravel "#8a8a8a")
       (gravel "#767676")
       (mediumgravel "#626262")
       (deepgravel "#444444")
       (darkgravel "#303030")
       (blackgravel "#121212")
       (blackestgravel "#080808")

       (dalespale "#ffd75f")
       (dirtyblonde "#ffd787")
       (taffy "#ff0000")
       (saltwatertaffy "#87ffaf")

       (tardis "#00afff")
       (orange "#ffaf00")
       (lime "#afff00")
       (dress "#ff87af")
       (toffee "#af875f")
       (coffee "#875f5f")
       (darkroast "#88633f")
      )

  (custom-theme-set-faces
   'tung

   ;; Basics
   `(default                                   ((t (:foreground ,plain       :background ,blackgravel                   ))))
   `(cursor                                    ((t (                         :background ,tardis                        ))))
   `(region                                    ((t (                         :background ,deepgravel                    ))))
   `(highlight                                 ((t (:foreground nil          :background ,tardis                        ))))
   `(hl-line                                   ((t (:foreground nil          :background ,darkgravel                    ))))
   `(minibuffer-prompt                         ((t (:foreground ,orange                                                 ))))
   `(escape-glyph                              ((t (:foreground ,taffy       :background ,dress                         ))))

   ;; Font-lock stuff
   `(font-lock-builtin-face                    ((t (:foreground ,taffy                                                  ))))
   `(font-lock-constant-face                   ((t (:foreground ,taffy                                                  ))))
   `(font-lock-comment-face                    ((t (:foreground ,gravel                                                 ))))
   `(font-lock-comment-delimiter-face          ((t (:foreground ,gravel                                                 ))))
   `(font-lock-doc-face                        ((t (:foreground ,snow                                                   ))))
   `(font-lock-doc-string-face                 ((t (:foreground ,snow                                                   ))))
   `(font-lock-function-name-face              ((t (:foreground ,orange                                                 ))))
   `(font-lock-keyword-face                    ((t (:foreground ,taffy                                                  ))))
   `(font-lock-negation-char-face              ((t (:foreground ,taffy                                                  ))))
   `(font-lock-preprocessor-face               ((t (:foreground ,lime                                                   ))))
   `(font-lock-string-face                     ((t (:foreground ,dirtyblonde                                            ))))
   `(font-lock-type-face                       ((t (:foreground ,dress                                                  ))))
   `(font-lock-variable-name-face              ((t (:foreground ,orange                                                 ))))
   `(font-lock-warning-face                    ((t (:foreground ,dress                                                  ))))

   ;; UI related
   `(link                                      ((t (:foreground ,tardis                                                 ))))
   `(fringe                                    ((t (:foreground ,mediumgravel                                           ))))
   ;; `(mode-line                                 ((t (:foreground ,gray-1      :background ,gray-3bg  :box nil :height 120))))
   ;; `(mode-line-inactive                        ((t (:foreground ,gray-6      :background ,gray-3bg  :box nil :height 120))))
   ;; `(vertical-border                           ((t (:foreground ,gray-5      :background ,background                    ))))

   ;; Linum
   `(linum                                     ((t (:foreground ,mediumgravel                                           ))))

   ;; show-paren-mode
   `(show-paren-match                          ((t (:foreground nil          :background ,blackestgravel                ))))
   `(show-paren-mismatch                       ((t (                         :background ,taffy                         ))))

   ;; ido
   `(ido-only-match                            ((t (:foreground ,lime                                                   ))))
   `(ido-subdir                                ((t (:foreground ,coffee                                                 ))))

   ;; whitespace-mode
   ;; `(whitespace-empty                          ((t (:foreground ,yellow-1bg  :background ,yellow-1                      ))))
   ;; `(whitespace-hspace                         ((t (:foreground ,gray-2                                                 ))))
   ;; `(whitespace-indentation                    ((t (:foreground ,gray-2                                                 ))))
   ;; `(whitespace-line                           ((t (                         :background ,gray-2                        ))))
   ;; `(whitespace-newline                        ((t (:foreground ,gray-2                                                 ))))
   ;; `(whitespace-space                          ((t (:foreground ,gray-2                                                 ))))
   ;; `(whitespace-space-after-tab                ((t (:foreground ,gray-2                                                 ))))
   ;; `(whitespace-tab                            ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-trailing                       ((t (                         :background ,taffy                         ))))

   ;; flyspell-mode
   `(flyspell-incorrect                        ((t (:underline ,taffy                                                   ))))
   `(flyspell-duplicate                        ((t (:underline ,taffy                                                   ))))

   ;; magit
   `(magit-diff-add                            ((t (:foreground ,lime                                                   ))))
   `(magit-diff-del                            ((t (:foreground ,taffy                                                  ))))
   `(magit-item-highlight                      ((t (                         :background ,mediumgravel                  ))))

   ;; highlight-indentation-mode
   ;; `(highlight-indentation-face                ((t (                         :background ,gray-1bg                      ))))
   ;; `(highlight-indentation-current-column-face ((t (                         :background ,gray-4                        ))))

   ;; ECB
   ;; `(ecb-default-general-face                  ((t (:foreground ,gray-3      :background ,gray-1bg                      ))))
   ;; `(ecb-default-highlight-face                ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   ;; `(ecb-method-face                           ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   ;; `(ecb-tag-header-face                       ((t (                         :background ,blue-2bg                      ))))

   ;; org-mode
   ;; `(org-date                                  ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))
   ;; `(org-done                                  ((t (:foreground ,green-1     :background ,green-1bg                     ))))
   ;; `(org-hide                                  ((t (:foreground ,gray-2      :background ,gray-1bg                      ))))
   ;; `(org-link                                  ((t (:foreground ,blue-1      :background ,blue-1bg                      ))))
   ;; `(org-todo                                  ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   )


  (custom-theme-set-variables
   'tung

   ;; `(powerline-color1 ,gray-6)
   ;; `(powerline-color2 ,gray-3bg)
   `(Linum-format "%7i ")
   ;; `(fringe-mode 4)

   ;; Fill Column Indicator mode
   ;; `(fci-rule-color ,gray-6)
   ;; `(fci-rule-character-color ,gray-6)

   `(ansi-color-names-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [,coal ,taffy ,lime ,orange ,tardis ,dress ,saltwatertaffy ,snow])
   `(ansi-term-color-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [,coal ,taffy ,lime ,orange ,tardis ,dress ,saltwatertaffy ,snow])
   )
  )

;; Rainbow delimiters

(defun tung-rainbow-delim-set-face ()
  (set-face-attribute 'rainbow-delimiters-depth-1-face nil :foreground "#d97a35")
  (set-face-attribute 'rainbow-delimiters-depth-2-face nil :foreground "#deae3e")
  (set-face-attribute 'rainbow-delimiters-depth-3-face nil :foreground "#81af34")
  (set-face-attribute 'rainbow-delimiters-depth-4-face nil :foreground "#4e9f75")
  (set-face-attribute 'rainbow-delimiters-depth-5-face nil :foreground "#11535F")
  (set-face-attribute 'rainbow-delimiters-depth-6-face nil :foreground "#00959e")
  (set-face-attribute 'rainbow-delimiters-depth-7-face nil :foreground "#8700ff")
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil :background "#ef3000"))
(eval-after-load "rainbow-delimiters" '(tung-rainbow-delim-set-face))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'tung)
