;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;;;;;;;;;;; START PAGE
;;(setq initial-buffer-choice "~/.config/doom/start.org")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (define-minor-mode start-mode                                                           ;;
;;   "Provide functions for custom start page."                                            ;;
;;   :lighter " start"                                                                     ;;
;;   :keymap (let ((map (make-sparse-keymap)))                                             ;;
;;           ;;(define-key map (kbd "M-z") 'eshell)                                        ;;
;;             (evil-define-key 'normal start-mode-map                                     ;;
;;               (kbd "1") '(lambda () (interactive) (find-file "~/.config/doom/config.org"))   ;;
;;               (kbd "2") '(lambda () (interactive) (find-file "~/.config/doom/init.el"))      ;;
;;               (kbd "3") '(lambda () (interactive) (find-file "~/.config/doom/packages.el"))) ;;
;;           map))                                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq initial-buffer-choice "~/.config/doom/dashboard.org")                                                     ;;
;;                                                                                                                 ;;
;; (define-minor-mode start-mode                                                                                   ;;
;;   "Provide functions for custom start page."                                                                    ;;
;;   :lighter " start"                                                                                             ;;
;;   :keymap (let ((map (make-sparse-keymap)))                                                                     ;;
;;           ;;(define-key map (kbd "M-z") 'eshell)                                                                ;;
;;             (evil-define-key 'normal start-mode-map                                                             ;;
;;               (kbd "1") '(lambda () (interactive) (find-file "~/.config/doom/dashboard.org"))                        ;;
;;               (kbd "2") '(lambda () (interactive) (find-file "~/.config/doom/init.el"))                              ;;
;;               (kbd "3") '(lambda () (interactive) (find-file "~/.config/doom/packages.el")))                         ;;
;;           map))                                                                                                 ;;
;;                                                                                                                 ;;
;; (add-hook 'start-mode-hook 'read-only-mode) ;; make start.org read-only; use 'SPC t r' to toggle off read-only. ;;
;; (provide 'start-mode)                                                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; BOOKMARKS location 
(setq bookmark-default-file "~/Documents/emacs_bookmarks<F9>")
;;;; BOOKMARKS KEYBNDS

(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks"                          "L" #'list-bookmarks
       :desc "Set bookmark"                            "m" #'bookmark-set
       :desc "Delete bookmark"                         "M" #'bookmark-set
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))
;;;; BUFFERS


(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(evil-define-key 'normal ibuffer-mode-map
  (kbd "f c") 'ibuffer-filter-by-content
  (kbd "f d") 'ibuffer-filter-by-directory
  (kbd "f f") 'ibuffer-filter-by-filename
  (kbd "f m") 'ibuffer-filter-by-mode
  (kbd "f n") 'ibuffer-filter-by-name
  (kbd "f x") 'ibuffer-filter-disable
  (kbd "g h") 'ibuffer-do-kill-lines
  (kbd "g H") 'ibuffer-update)


;;;;;; DIRED

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file"           "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
(use-package all-the-icons)
(use-package all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; (setq delete-by-moving-to-trash t
;;       trash-directory "~/.local/share/Trash/files/")



;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Amro Abdul"
      user-mail-address "abdulvahitamro2gmail.com")


;;;;;;;;; EMACS CALENDAR
(defun dt/insert-todays-date (prefix)
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%A, %B %d, %Y")
                 ((equal prefix '(4)) "%m-%d-%Y")
                 ((equal prefix '(16)) "%Y-%m-%d"))))
    (insert (format-time-string format))))

(require 'calendar)
(defun dt/insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))

(map! :leader
      (:prefix ("i d" . "Insert date")
        :desc "Insert any date"    "a" #'dt/insert-any-date
        :desc "Insert todays date" "t" #'dt/insert-todays-date))
;;;; BEACON
(beacon-mode 1)
(setq beacon-color "#0ff")

;;;;;;; TABS in EMACS (need to enable/uncomment tabs in init.el)
(setq centaur-tabs-set-bar 'over
      centaur-tabs-set-icons t
      centaur-tabs-gray-out-icons 'buffer
      centaur-tabs-height 24
      centaur-tabs-set-modified-marker t
      centaur-tabs-style "bar"
      centaur-tabs-modified-marker "•")
(map! :leader
      :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
      :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)
(evil-define-key 'normal centaur-tabs-mode-map (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
                                               (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
                                               (kbd "g <down>")  'centaur-tabs-forward-group
                                               (kbd "g <up>")    'centaur-tabs-backward-group)



;;;;;;;; LINE SETTINGS
(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines"      "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers"            "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines"          "t" #'toggle-truncate-lines))
;;;;;;; COLORS SETTINGS

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )
;;; MARKDOWN
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

;;; MINIMAP
(setq minimap-window-location 'right)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle minimap-mode" "m" #'minimap-mode))

;;;;;;;;;;;;; bottom status bar 
(set-face-attribute 'mode-line nil :font "Ubuntu Mono-11")
(setq doom-modeline-height 30     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

;;;;;; NEOTREE

(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree"  "d n" #'neotree-dir)


;;;;;;;;;;;;;;;;; RANDOM SPLASH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (let ((alternatives '("doom.svg"                                     ;;
;;                       "doomEmacsDoomOne.svg"                         ;;
;;                       "doomEmacsTokyoNight.svg"                      ;;
;;                       "doomEmacsDracula.svg"                         ;;
;;                       "doomWithShadow.svg")))                        ;;
;;   (setq fancy-splash-image                                           ;;
;;         (concat doom-private-dir "splash/"                           ;;
;;                 (nth (random (length alternatives)) alternatives)))) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq fancy-splash-image (expand-file-name "splash/doom-emacs-arabic-logo.svg" doom-private-dir))


;;battery
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                           ; On laptops it's nice to know how much power you have



;;;;;;;;;;;;;; FONT CONFIG

(setq doom-font (font-spec :family " SauceCodePro Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 14)
      doom-big-font (font-spec :family "SauceCodePro Nerd Font" :size 22)
      web-mode-markup-indent-offset 2
      css-indent-offset 2
       json-reformat:indent-width 2
      web-mode-code-indent-offset 2
      web-mode-css-indent-offset 2)
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq +magit-hub-features t)

(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
(map! :leader
      :desc "Load new theme" "h t" #'counsel-load-theme)



;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/")


;;;;;;;;;;; MOUSE SUPPORT FOR TERMINAL
(xterm-mouse-mode 1)


;;;;;;;;;;; SHELL
(setq shell-file-name "/bin/fish"
      vterm-max-scrollback 5000)
(map! :leader
      :desc "VTERM POP-UP Toggle" "v t" #'+vterm/toggle)



;;;;;;;;;; WINNER MODE
(map! :leader
      (:prefix ("w" . "window")
       :desc "Winner redo" "<right>" #'winner-redo
       :desc "Winner undo" "<left>" #'winner-undo))



;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;;;;;; ELFEED (RSS)
;; (setq elfeed-goodies/entry-pane-size 0.5)
;;
;; (evil-define-key 'normal elfeed-show-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)
;; (evil-define-key 'normal elfeed-search-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)
;; (setq elfeed-feeds (quote
;;                     (("https://www.reddit.com/r/linux.rss" reddit linux)
;;                      ("https://www.reddit.com/r/commandline.rss" reddit commandline))))

;;;;  Emacs Multimedia System
;; (emms-all)
;; (emms-default-players)
;; (emms-mode-line 1)
;; (emms-playing-time 1)
;; (setq emms-source-file-default-directory "~/Music/"
;;       emms-playlist-buffer-name "*Music*"
;;       emms-info-asynchronously t
;;       emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)
;; (map! :leader
;;       (:prefix ("a" . "EMMS audio player")
;;        :desc "Go to emms playlist"      "a" #'emms-playlist-mode-go
;;        :desc "Emms pause track"         "x" #'emms-pause
;;        :desc "Emms stop track"          "s" #'emms-stop
;;        :desc "Emms play previous track" "p" #'emms-previous
;;        :desc "Emms play next track"     "n" #'emms-next))

;;;;; EMOJIs
(use-package emojify
  :hook (after-init . global-emojify-mode))

;;;;; PASSWORD STORE (default gnu pass)
(use-package! password-store)

(use-package telega
  :load-path  "~/telega.el"
  :commands (telega)
  :defer t)

;;;;;;; RUN telega using a docker instance
;;(setq telega-use-docker t)

;;;;;;;;; EDNC  notifications in EMACS
(ednc-mode 1)

(defun show-notification-in-buffer (old new)
  (let ((name (format "Notification %d" (ednc-notification-id (or old new)))))
    (with-current-buffer (get-buffer-create name)
      (if new (let ((inhibit-read-only t))
                (if old (erase-buffer) (ednc-view-mode))
                (insert (ednc-format-notification new t))
                (pop-to-buffer (current-buffer)))
        (kill-buffer)))))

(add-hook 'ednc-notification-presentation-functions
          #'show-notification-in-buffer)

(evil-define-key 'normal ednc-view-mode-map
  (kbd "d")   'ednc-dismiss-notification
  (kbd "RET") 'ednc-invoke-action
  (kbd "e")   'ednc-toggle-expanded-view)

;;; EMACS WORLD WEB EWW
(setq browse-url-browser-function 'eww-browse-url)
(map! :leader
      :desc "Search web for text between BEG/END"
      "s w" #'eww-search-words
      (:prefix ("e" . "evaluate/ERC/EWW")
       :desc "Eww web browser" "w" #'eww
       :desc "Eww reload page" "R" #'eww-reload))

(defun +data-hideshow-forward-sexp (arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (require 'evil-indent-plus)
      (let ((range (evil-indent-plus--same-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

(add-to-list 'hs-special-modes-alist '(yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

(with-eval-after-load 'rjsx-mode
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil)
  (define-key rjsx-mode-map ">" nil))

(setq vue-mode-packages
  '(vue-mode))

(setq vue-mode-excluded-packages '())

(defun vue-mode/init-vue-mode ()
  "Initialize my package"
  (use-package vue-mode))


(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
;; tabnine autocmplete
(after! company
  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
  (setq company-show-quick-access t)
  (setq company-idle-delay 0)
)

(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))
;;(use-package auto-complete :ensure t)
;;(progn (ac-config-default)
;;(global-auto-complete-mode t)))
;;(setq ac-auto-show-menu 0.2)



;;;;;;;;;;;;;;;;;;;;;; ORG MODE
;;;;TODO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (map! :leader                                                                                                                                ;;
;;       :desc "Org babel tangle" "m B" #'org-babel-tangle)                                                                                     ;;
;; (after! org                                                                                                                                  ;;
;;   (setq org-directory "~/nc/Org/"                                                                                                            ;;
;;         org-default-notes-file (expand-file-name "notes.org" org-directory)                                                                  ;;
;;         org-ellipsis " ▼ "                                                                                                                   ;;
;;         org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")                                                                   ;;
;;         org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists                                            ;;
;;         org-log-done 'time                                                                                                                   ;;
;;         org-hide-emphasis-markers t                                                                                                          ;;
;;         ;; ex. of org-link-abbrev-alist in action                                                                                            ;;
;;         ;; [[arch-wiki:Name_of_Page][Description]]                                                                                           ;;
;;         org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list                                                     ;;
;;           '(("google" . "http://www.google.com/search?q=")                                                                                   ;;
;;             ("arch-wiki" . "https://wiki.archlinux.org/index.php/")                                                                          ;;
;;             ("ddg" . "https://duckduckgo.com/?q=")                                                                                           ;;
;;             ("wiki" . "https://en.wikipedia.org/wiki/"))                                                                                     ;;
;;         org-table-convert-region-max-lines 20000                                                                                             ;;
;;         org-todo-keywords        ; This overwrites the default Doom org-todo-keywords                                                        ;;
;;           '((sequence                                                                                                                        ;;
;;              "TODO(t)"           ; A task that is ready to be tackled                                                                        ;;
;;              "BLOG(b)"           ; Blog writing assignments                                                                                  ;;
;;              "GYM(g)"            ; Things to accomplish at the gym                                                                           ;;
;;              "PROJ(p)"           ; A project that contains other tasks                                                                       ;;
;;              "VIDEO(v)"          ; Video assignments                                                                                         ;;
;;              "WAIT(w)"           ; Something is holding up this task                                                                         ;;
;;              "|"                 ; The pipe necessary to separate "active" states and "inactive" states                                      ;;
;;              "DONE(d)"           ; Task has been completed                                                                                   ;;
;;              "CANCELLED(c)" )))) ; Task has been cancelled                                                                                   ;;
;; (after! org                                                                                                                                  ;;
;;   (setq org-agenda-files '("~/nc/Org/agenda.org")))                                                                                          ;;
;;                                                                                                                                              ;;
;; (setq                                                                                                                                        ;;
;;    ;; org-fancy-priorities-list '("[A]" "[B]" "[C]")                                                                                         ;;
;;    ;; org-fancy-priorities-list '("❗" "[B]" "[C]")                                                                                          ;;
;;    org-fancy-priorities-list '("🟥" "🟧" "🟨")                                                                                               ;;
;;    org-priority-faces                                                                                                                        ;;
;;    '((?A :foreground "#ff6c6b" :weight bold)                                                                                                 ;;
;;      (?B :foreground "#98be65" :weight bold)                                                                                                 ;;
;;      (?C :foreground "#c678dd" :weight bold))                                                                                                ;;
;;    org-agenda-block-separator 8411)                                                                                                          ;;
;;                                                                                                                                              ;;
;; (setq org-agenda-custom-commands                                                                                                             ;;
;;       '(("v" "A better agenda view"                                                                                                          ;;
;;          ((tags "PRIORITY=\"A\""                                                                                                             ;;
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))                                                          ;;
;;                  (org-agenda-overriding-header "High-priority unfinished tasks:")))                                                          ;;
;;           (tags "PRIORITY=\"B\""                                                                                                             ;;
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))                                                          ;;
;;                  (org-agenda-overriding-header "Medium-priority unfinished tasks:")))                                                        ;;
;;           (tags "PRIORITY=\"C\""                                                                                                             ;;
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))                                                          ;;
;;                  (org-agenda-overriding-header "Low-priority unfinished tasks:")))                                                           ;;
;;           (tags "customtag"                                                                                                                  ;;
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))                                                          ;;
;;                  (org-agenda-overriding-header "Tasks marked with customtag:")))                                                             ;;
;;                                                                                                                                              ;;
;;           (agenda "")                                                                                                                        ;;
;;           (alltodo "")))))                                                                                                                   ;;
;; (use-package! org-auto-tangle                                                                                                                ;;
;;   :defer t                                                                                                                                   ;;
;;   :hook (org-mode . org-auto-tangle-mode)                                                                                                    ;;
;;   :config                                                                                                                                    ;;
;;   (setq org-auto-tangle-default t))                                                                                                          ;;
;;                                                                                                                                              ;;
;; (defun dt/insert-auto-tangle-tag ()                                                                                                          ;;
;;   "Insert auto-tangle tag in a literate config."                                                                                             ;;
;;   (interactive)                                                                                                                              ;;
;;   (evil-org-open-below 1)                                                                                                                    ;;
;;   (insert "#+auto_tangle: t ")                                                                                                               ;;
;;   (evil-force-normal-state))                                                                                                                 ;;
;;                                                                                                                                              ;;
;; (map! :leader                                                                                                                                ;;
;;       :desc "Insert auto_tangle tag" "i a" #'dt/insert-auto-tangle-tag)                                                                      ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-doom-one ()                                                                                                             ;;
;;   "Enable Doom One colors for Org headers."                                                                                                  ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#51afef" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#c678dd" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#98be65" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#da8548" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#5699af" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#a9a1e1" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#46d9ff" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#ff6c6b" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-dracula ()                                                                                                              ;;
;;   "Enable Dracula colors for Org headers."                                                                                                   ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#8be9fd" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#bd93f9" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#50fa7b" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#ff79c6" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#9aedfe" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#caa9fa" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#5af78e" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#ff92d0" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-gruvbox-dark ()                                                                                                         ;;
;;   "Enable Gruvbox Dark colors for Org headers."                                                                                              ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#458588" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#b16286" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#98971a" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#fb4934" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#83a598" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#d3869b" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#d79921" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#8ec07c" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-monokai-pro ()                                                                                                          ;;
;;   "Enable Monokai Pro colors for Org headers."                                                                                               ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#78dce8" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#ab9df2" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#a9dc76" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#fc9867" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#ff6188" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#ffd866" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#78dce8" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#ab9df2" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-nord ()                                                                                                                 ;;
;;   "Enable Nord colors for Org headers."                                                                                                      ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#81a1c1" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#b48ead" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#a3be8c" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#ebcb8b" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#bf616a" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#88c0d0" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#81a1c1" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#b48ead" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-oceanic-next ()                                                                                                         ;;
;;   "Enable Oceanic Next colors for Org headers."                                                                                              ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#6699cc" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#c594c5" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#99c794" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#fac863" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#5fb3b3" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#ec5f67" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#6699cc" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#c594c5" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-palenight ()                                                                                                            ;;
;;   "Enable Palenight colors for Org headers."                                                                                                 ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#82aaff" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#c792ea" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#c3e88d" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#ffcb6b" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#a3f7ff" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#e1acff" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#f07178" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#ddffa7" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-solarized-dark ()                                                                                                       ;;
;;   "Enable Solarized Dark colors for Org headers."                                                                                            ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#268bd2" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#d33682" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#859900" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#b58900" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#cb4b16" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#6c71c4" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#2aa198" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#657b83" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-solarized-light ()                                                                                                      ;;
;;   "Enable Solarized Light colors for Org headers."                                                                                           ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#268bd2" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#d33682" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#859900" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#b58900" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#cb4b16" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#6c71c4" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#2aa198" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#657b83" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; (defun dt/org-colors-tomorrow-night ()                                                                                                       ;;
;;   "Enable Tomorrow Night colors for Org headers."                                                                                            ;;
;;   (interactive)                                                                                                                              ;;
;;   (dolist                                                                                                                                    ;;
;;       (face                                                                                                                                  ;;
;;        '((org-level-1 1.7 "#81a2be" ultra-bold)                                                                                              ;;
;;          (org-level-2 1.6 "#b294bb" extra-bold)                                                                                              ;;
;;          (org-level-3 1.5 "#b5bd68" bold)                                                                                                    ;;
;;          (org-level-4 1.4 "#e6c547" semi-bold)                                                                                               ;;
;;          (org-level-5 1.3 "#cc6666" normal)                                                                                                  ;;
;;          (org-level-6 1.2 "#70c0ba" normal)                                                                                                  ;;
;;          (org-level-7 1.1 "#b77ee0" normal)                                                                                                  ;;
;;          (org-level-8 1.0 "#9ec400" normal)))                                                                                                ;;
;;     (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face))) ;;
;;     (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))                                   ;;
;;                                                                                                                                              ;;
;; ;; Load our desired dt/org-colors-* theme on startup                                                                                         ;;
;; (dt/org-colors-doom-one)                                                                                                                     ;;
;;                                                                                                                                              ;;
;; (use-package ox-man)                                                                                                                         ;;
;; (use-package ox-gemini)                                                                                                                      ;;
;;                                                                                                                                              ;;
;; (setq org-journal-dir "~/nc/Org/journal/"                                                                                                    ;;
;;       org-journal-date-prefix "* "                                                                                                           ;;
;;       org-journal-time-prefix "** "                                                                                                          ;;
;;       org-journal-date-format "%B %d, %Y (%A) "                                                                                              ;;
;;       org-journal-file-format "%Y-%m-%d.org")                                                                                                ;;
;;                                                                                                                                              ;;
;; (setq org-publish-use-timestamps-flag nil)                                                                                                   ;;
;; (setq org-export-with-broken-links t)                                                                                                        ;;
;; (setq org-publish-project-alist                                                                                                              ;;
;;       '(("distro.tube without manpages"                                                                                                      ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/"                                                                                    ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/"                                                                         ;;
;;          :recursive t                                                                                                                        ;;
;;          :exclude "org-html-themes/.*\\|man-org/man*"                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man0p"                                                                                                                            ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man0p/"                                                                      ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man0p/"                                                           ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man1"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man1/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man1/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man1p"                                                                                                                            ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man1p/"                                                                      ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man1p/"                                                           ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man2"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man2/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man2/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man3"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man3/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man3/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man3p"                                                                                                                            ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man3p/"                                                                      ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man3p/"                                                           ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man4"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man4/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man4/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man5"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man5/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man5/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man6"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man6/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man6/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man7"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man7/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man7/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("man8"                                                                                                                             ;;
;;          :base-directory "~/nc/gitlab-repos/distro.tube/man-org/man8/"                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/man-org/man8/"                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;          ("org-static"                                                                                                                       ;;
;;          :base-directory "~/Org/website"                                                                                                     ;;
;;          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"                                                                ;;
;;          :publishing-directory "~/public_html/"                                                                                              ;;
;;          :recursive t                                                                                                                        ;;
;;          :exclude ".*/org-html-themes/.*"                                                                                                    ;;
;;          :publishing-function org-publish-attachment)                                                                                        ;;
;;          ("dtos.dev"                                                                                                                         ;;
;;          :base-directory "~/nc/gitlab-repos/dtos.dev/"                                                                                       ;;
;;          :base-extension "org"                                                                                                               ;;
;;          :publishing-directory "~/nc/gitlab-repos/dtos.dev/html/"                                                                            ;;
;;          :recursive t                                                                                                                        ;;
;;          :publishing-function org-html-publish-to-html                                                                                       ;;
;;          :headline-levels 4             ; Just the default for this project.                                                                 ;;
;;          :auto-preamble t)                                                                                                                   ;;
;;                                                                                                                                              ;;
;;       ))                                                                                                                                     ;;
;;                                                                                                                                              ;;
;; (after! org                                                                                                                                  ;;
;;   (setq org-roam-directory "~/nc/Org/roam/"                                                                                                  ;;
;;         org-roam-graph-viewer "/usr/bin/brave"))                                                                                             ;;
;;                                                                                                                                              ;;
;; (map! :leader                                                                                                                                ;;
;;       (:prefix ("n r" . "org-roam")                                                                                                          ;;
;;        :desc "Completion at point" "c" #'completion-at-point                                                                                 ;;
;;        :desc "Find node"           "f" #'org-roam-node-find                                                                                  ;;
;;        :desc "Show graph"          "g" #'org-roam-graph                                                                                      ;;
;;        :desc "Insert node"         "i" #'org-roam-node-insert                                                                                ;;
;;        :desc "Capture to node"     "n" #'org-roam-capture                                                                                    ;;
;;        :desc "Toggle roam buffer"  "r" #'org-roam-buffer-toggle))                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
