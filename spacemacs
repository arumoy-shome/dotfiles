;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-additional-packages '(base16-theme)
   dotspacemacs-excluded-packages '(avy
                                    editorconfig
                                    eval-sexp-fu
                                    expand-region
                                    hungry-delete
                                    move-text
                                    password-generator
                                    string-inflection
                                    uuidgen
                                    column-enforce-mode
                                    hide-comnt
                                    hl-anything
                                    indent-guide
                                    vi-tilde-fringe
                                    evil-tutor
                                    evil-search-highlight-persist
                                    evil-mc
                                    evil-exchange
                                    evil-args
                                    evil-iedit-state
                                    evil-indent-plus
                                    evil-lion
                                    evil-numbers
                                    evil-visual-mark-mode
                                    evil-lisp-state
                                    define-word
                                    google-translate
                                    dumb-jump
                                    request
                                    open-junk-file
                                    paradox
                                    fancy-battery
                                    neotree
                                    company-emoji
                                    company-cheat-sheet-plus
                                    gnuplot
                                    htmlize
                                    mu4e
                                    org-pomodoro
                                    org-present
                                    ox-twbs
                                    ox-gfm
                                    ox-reveal
                                    helm-purpose
                                    ivy-purpose
                                    spacemacs-purpose-popwin
                                    window-purpose)

   dotspacemacs-configuration-layers
   '(
     ;; utilities
     (spell-checking :variables
                     spell-checking-enable-by-default t
                     enable-flyspell-auto-completion t)
     (org :variables
          org-projectile-file "~/Dropbox/org/projects.org")
     (version-control :variables
                      version-control-diff-side 'right
                      version-control-diff-tool 'diff-hl
                      version-control-global-margin t)
     helm
     auto-completion
     git
     vinegar
     pandoc
     ;; languages
     )
   ))

(defun dotspacemacs/init ()
  "Initialization function.
  This function is called at the very startup of Spacemacs initialization
  before layers configuration.
  You should not put any user code in there besides modifying the variable
  values."
  (setq-default
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-elpa-https nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists nil
   dotspacemacs-scratch-mode 'org-mode
   dotspacemacs-themes '(base16-dracula
                         base16-ocean
                         base16-tomorrow-night
                         )
   dotspacemacs-default-font '("Source Code Pro"
                               :size 15
                               :weight light
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-distinguish-gui-tab t
   dotspacemacs-default-layout-name "aru"
   dotspacemacs-display-default-layout t
   dotspacemacs-auto-save-file-location nil
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-use-non-native t
   dotspacemacs-line-numbers 'relative
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-config ()
  ;; fox mode line color
  (setq ns-use-srgb-colorspace nil)
  ;; default settings
  (setq-default
   tab-width 2
   powerline-default-separator 'slant
   )

  ;; org settings
  (with-eval-after-load 'org
    ;; default directory of all org documents
    (setq org-directory "~/Dropbox/org"
          ;; set directory for org to look into for tasks
          org-agenda-files '("~/Dropbox/org/tasks.org")
          ;; org capture settings
          ;; template for blog ideas
          org-capture-templates
          ;; todo templates inspired by the Bullet Journal
          ;; tasks to be done today
          '(("t" "Today" entry (file+headline "~/Dropbox/org/tasks.org" "Today")
             "* TODO %?\nSCHEDULED: %t")
            ;; tasks to be done this week
            ("w" "Week" entry (file+headline "~/Dropbox/org/tasks.org" "Week")
             "* TODO %?")
            ;; tasks to be done this month
            ("m" "Month" entry (file+headline "~/Dropbox/org/tasks.org" "Month")
             "* TODO %?")
            ;; future log
            ("f" "Future" entry (file+headline "~/Dropbox/org/tasks.org" "Future log")
             "* TODO %?"))
          ;; define some global todo states
          org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i@/!)" "BLOCKED(b@/!)" "|" "DONE(d!)" "CANCELED(c@)")
                              (sequence "QUESTION(q)" "|"))
          ;; dim the blocked tasks in agenda view
          org-agenda-dim-blocked-tasks t
          ;; insert clocking info into the CLOCKING drawer
          org-clock-into-drawer "CLOCKING"
          ;; ignore tasks which are scheduled or have a deadline from
          ;; the global todo list i.e. C-c a t
          ;; essentially it now only shows tasks that can be done anytime
          org-agenda-todo-ignore-scheduled t
          ;; do not show tasks that are done in the week/day agenda view
          org-agenda-skip-scheduled-if-done t)
    )
  ;; show 80 char column in programming mode
  (add-hook 'prog-mode-hook 'spacemacs/toggle-fill-column-indicator-on)
  ;; insert a new line at 80 char automatically in all text modes
  ;; this modifies the buffer
  (add-hook 'text-mode-hook 'turn-on-auto-fill)
  ;; wrap long lines near end of window
  ;; this is just a visual change, it does not change the actual file
  (global-visual-line-mode t)
  ;; edit git commit messages in emacs
  (global-git-commit-mode t)
  ;; spaceline config
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-input-method-off)
  (spaceline-toggle-buffer-encoding-abbrev-off)
  ;; Don't litter my init file
  (setq custom-file "~/.spacemacs.d/custom.el")
  (load custom-file 'noerror)
  )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (symon string-inflection password-generator org-brain helm-purpose window-purpose imenu-list evil-org evil-lion editorconfig browse-at-remote helm-themes helm-swoop helm-projectile helm-mode-manager helm-gitignore request helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag flyspell-correct-helm ace-jump-helm-line xterm-color ws-butler winum which-key wgrep volatile-highlights use-package toc-org spaceline powerline smex smeargle shell-pop restart-emacs rainbow-delimiters popwin persp-mode pcre2el pandoc-mode ox-pandoc ht orgit org-projectile org-category-capture org-plus-contrib org-download org-bullets multi-term mmm-mode markdown-toc markdown-mode magit-gitflow macrostep lorem-ipsum linum-relative link-hint ivy-hydra info+ hydra hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation help-fns+ helm-make helm helm-core google-translate golden-ratio gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flyspell-popup flyspell-correct-ivy flyspell-correct flx-ido flx fill-column-indicator eyebrowse exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired f s evil-surround evil-numbers evil-nerd-commenter evil-matchit evil-magit magit magit-popup git-commit ghub let-alist with-editor evil-lisp-state smartparens evil-escape evil-ediff evil-anzu anzu evil goto-chg undo-tree eshell-z eshell-prompt-extras esh-help dash elisp-slime-nav diminish diff-hl define-word counsel-projectile projectile pkg-info epl counsel swiper ivy company-statistics company clean-aindent-mode bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed async aggressive-indent adaptive-wrap ace-window ace-link avy ac-ispell auto-complete popup base16-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-themes helm-swoop helm-projectile helm-mode-manager helm-gitignore request helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag flyspell-correct-helm ace-jump-helm-line xterm-color ws-butler winum which-key wgrep volatile-highlights use-package toc-org spaceline powerline smex smeargle shell-pop restart-emacs rainbow-delimiters popwin persp-mode pcre2el pandoc-mode ox-pandoc ht orgit org-projectile org-category-capture org-plus-contrib org-download org-bullets multi-term mmm-mode markdown-toc markdown-mode magit-gitflow macrostep lorem-ipsum linum-relative link-hint ivy-hydra info+ hydra hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation help-fns+ helm-make helm helm-core google-translate golden-ratio gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flyspell-popup flyspell-correct-ivy flyspell-correct flx-ido flx fill-column-indicator eyebrowse exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired f s evil-surround evil-numbers evil-nerd-commenter evil-matchit evil-magit magit magit-popup git-commit ghub let-alist with-editor evil-lisp-state smartparens evil-escape evil-ediff evil-anzu anzu evil goto-chg undo-tree eshell-z eshell-prompt-extras esh-help dash elisp-slime-nav diminish diff-hl define-word counsel-projectile projectile pkg-info epl counsel swiper ivy company-statistics company clean-aindent-mode bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed async aggressive-indent adaptive-wrap ace-window ace-link avy ac-ispell auto-complete popup base16-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
