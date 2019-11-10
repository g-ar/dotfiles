;; C-h v package-activated-list
;; ac-anaconda dash anaconda-mode f dash s s dash pythonic f dash s s dash auto-complete popup auctex c-eldoc cedit cider spinner queue pkg-info epl dash clojure-mode clojure-mode company-anaconda s dash anaconda-mode f dash s s dash pythonic f dash s s dash company company-jedi jedi-core python-environment deferred epc ctable concurrent deferred company ctags elpy yasnippet pyvenv highlight-indentation find-file-in-project company ess exec-path-from-shell expand-region find-file-in-project ggtags haskell-mode highlight-indentation htmlize jedi auto-complete popup jedi-core python-environment deferred epc ctable concurrent deferred jedi-core python-environment deferred epc ctable concurrent deferred magit magit-popup dash async git-commit with-editor dash async dash with-editor dash async dash async magit-popup dash async material-theme ox-reveal org ox-rst org paredit popup projectile pkg-info epl dash python-environment deferred pythonic f dash s s dash pyvenv queue rainbow-delimiters s smex spinner web-mode with-editor dash async wolfram-mode yasnippet

(global-visual-line-mode 1); Proper line wrapping
(global-hl-line-mode 1); Highlight current row

;;(set-default-font "Terminus-9")
;;(set-fontset-font t '(#x1d4ee . #x1f5fe) (font-spec :family "FreeSerif"))

(tool-bar-mode -1)
(menu-bar-mode -1)

(setq line-number-mode t)
(setq column-number-mode t)

(toggle-frame-fullscreen)

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(require 're-builder)
(setq reb-re-syntax 'string)
(setq frame-title-format "%b") ; display buffer name instead of emacs@system-name
(show-paren-mode 1); Matches parentheses and such in every mode
(set-fringe-mode '(0 . 0)); Disable fringe
(setq inhibit-splash-screen t); Disable splash screen
(setq visible-bell t); Flashes on error
(setq gdb-many-windows t); for multiple gdb windows
(setq calendar-week-start-day 1); Calender should start on Monday
(add-to-list 'default-frame-alist '(height . 59)); Default frame height.
(set-face-attribute 'default nil :height 120)  ;; font size, 12pt
;;; AUCTeX
;; Customary Customization, p. 1 and 16 in the manual, and http://www.emacswiki.org/emacs/AUCTeX#toc2
(setq TeX-parse-self t); Enable parse on load.
(setq TeX-auto-save t); Enable parse on save.
(setq-default TeX-master nil)

(setq path-to-ctags "~/bin/ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "find %s -type f -name \"*.[ch]\" | etags -" path-to-ctags (directory-file-name dir-name)))
)
   
(setq x-select-enable-clipboard t) ; copy from emacs to clipboard
(setq org-src-fontify-natively t)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))
(autoload 'qml-mode "qml-mode" "Editing Qt Declarative." t)
(add-to-list 'auto-mode-alist '("\\.qml$" . qml-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)

(require 'ido)
(ido-mode t)

(setq TeX-PDF-mode t); PDF mode (rather than DVI-mode)

(setq org-default-notes-file (expand-file-name "~/notes.org"))
;; Bind Org Capture to C-c r
(global-set-key "\C-cr" 'org-capture)

; (add-hook 'TeX-mode-hook 'flyspell-mode); Enable Flyspell mode for TeX modes such as AUCTeX. Highlights all misspelled words.
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode); Enable Flyspell program mode for emacs lisp mode, which highlights all misspelled words in comments and strings.
(setq ispell-dictionary "english"); Default dictionary. To change do M-x ispell-change-dictionary RET.
(add-hook 'TeX-mode-hook
          (lambda () (TeX-fold-mode 1))); Automatically activate TeX-fold-mode.
(setq LaTeX-babel-hyphen nil); Disable language-specific hyphen insertion.

;; " expands into csquotes macros (for this to work babel must be loaded after csquotes).
(setq LaTeX-csquotes-close-quote "}"
      LaTeX-csquotes-open-quote "\\enquote{")

;; LaTeX-math-mode http://www.gnu.org/s/auctex/manual/auctex/Mathematics.html
(add-hook 'TeX-mode-hook 'LaTeX-math-mode)

;;; RefTeX
;; Turn on RefTeX for AUCTeX http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
(add-hook 'TeX-mode-hook 'turn-on-reftex)

;; export org to rst
;(require 'ox-rst) 

;; start in orgmode
(setq inhibit-splash-screen t      
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)
(setq make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(eval-after-load 'reftex-vars; Is this construct really needed?
  '(progn
     (setq reftex-cite-prompt-optional-args t); Prompt for empty optional arguments in cite macros.
     ;; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
     (setq reftex-plug-into-AUCTeX t)
     ;; So that RefTeX also recognizes \addbibresource. Note that you
     ;; can't use $HOME in path for \addbibresource but that "~"
     ;; works.
     (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
;     (setq reftex-default-bibliography '("UNCOMMENT LINE AND INSERT PATH TO YOUR BIBLIOGRAPHY HERE")); So that RefTeX in Org-mode knows bibliography
     (setcdr (assoc 'caption reftex-default-context-regexps) "\\\\\\(rot\\|sub\\)?caption\\*?[[{]"); Recognize \subcaptions, e.g. reftex-citation
     (setq reftex-cite-format; Get ReTeX with biblatex, see http://tex.stackexchange.com/questions/31966/setting-up-reftex-with-biblatex-citation-commands/31992#31992
           '((?t . "\\textcite[]{%l}")
             (?a . "\\autocite[]{%l}")
             (?c . "\\cite[]{%l}")
             (?s . "\\smartcite[]{%l}")
             (?f . "\\footcite[]{%l}")
             (?n . "\\nocite{%l}")
             (?b . "\\blockcquote[]{%l}{}")))))

(setq-default indent-tabs-mode nil)  ; No tabs, use spaces
(setq c-basic-indent 4)
(setq tab-width 4)

;; Fontification (remove unnecessary entries as you notice them) http://lists.gnu.org/archive/html/emacs-orgmode/2009-05/msg00236.html http://www.gnu.org/software/auctex/manual/auctex/Fontification-of-macros.html
(setq font-latex-match-reference-keywords
      '(
        ;; biblatex
        ("printbibliography" "[{")
        ("addbibresource" "[{")
        ;; Standard commands
        ;; ("cite" "[{")
        ("Cite" "[{")
        ("parencite" "[{")
        ("Parencite" "[{")
        ("footcite" "[{")
        ("footcitetext" "[{")
        ;; ;; Style-specific commands
        ("textcite" "[{")
        ("Textcite" "[{")
        ("smartcite" "[{")
        ("Smartcite" "[{")
        ("cite*" "[{")
        ("parencite*" "[{")
        ("supercite" "[{")
        ; Qualified citation lists
        ("cites" "[{")
        ("Cites" "[{")
        ("parencites" "[{")
        ("Parencites" "[{")
        ("footcites" "[{")
        ("footcitetexts" "[{")
        ("smartcites" "[{")
        ("Smartcites" "[{")
        ("textcites" "[{")
        ("Textcites" "[{")
        ("supercites" "[{")
        ;; Style-independent commands
        ("autocite" "[{")
        ("Autocite" "[{")
        ("autocite*" "[{")
        ("Autocite*" "[{")
        ("autocites" "[{")
        ("Autocites" "[{")
        ;; Text commands
        ("citeauthor" "[{")
        ("Citeauthor" "[{")
        ("citetitle" "[{")
        ("citetitle*" "[{")
        ("citeyear" "[{")
        ("citedate" "[{")
        ("citeurl" "[{")
        ;; Special commands
        ("fullcite" "[{")))

(setq font-latex-match-textual-keywords
      '(
        ;; biblatex brackets
        ("parentext" "{")
        ("brackettext" "{")
        ("hybridblockquote" "[{")
        ;; Auxiliary Commands
        ("textelp" "{")
        ("textelp*" "{")
        ("textins" "{")
        ("textins*" "{")
        ;; supcaption
        ("subcaption" "[{")))

(setq font-latex-match-variable-keywords
      '(
        ;; amsmath
        ("numberwithin" "{")
        ;; enumitem
        ("setlist" "[{")
        ("setlist*" "[{")
        ("newlist" "{")
        ("renewlist" "{")
        ("setlistdepth" "{")
        ("restartlist" "{")))
        
;; Extras

(add-hook 'LaTeX-mode-hook
      (lambda ()
        (TeX-add-symbols "displaystyle")  ;; add this macro to autocompletion list: C-c C-m -> displaystyle
        ;(LaTeX-add-environments "bar")
        )
)

;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}\n
      \\usepackage{amsmath}\n
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[12pt]{letter}\n
      \\usepackage[margin=1in]{geometry}\n
      \\usepackage{amsmath}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  
  ;; article class

  (add-to-list 'org-export-latex-classes

  '("article"
     "\\documentclass[12pt]{article}\n
      \\usepackage[margin=1in]{geometry}\n
      \\usepackage{amsmath}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
     
                    
;; autocomplete
;; (add-to-list 'load-path "~/.emacs.d/lisp")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (defun auto-complete-for-go ()
;;   (auto-complete-mode 1))

;; (defun auto-complete-for-nim ()
;;   (auto-complete-mode 1))

;; (defun auto-complete-for-qml ()
;;   (auto-complete-mode 1))

;; (add-hook 'qml-mode-hook 'auto-complete-for-qml)
;; (add-hook 'go-mode-hook 'auto-complete-for-go)
;; (add-hook 'nim-mode-hook 'auto-complete-for-nim)
;; (add-to-list 'ac-modes 'go-mode)
;; (add-to-list 'ac-modes 'nim-mode)
;; (add-to-list 'ac-modes 'qml-mode)
;; (add-to-list 'ac-modes 'org-mode)   ; auto complete for orgmode
;; (add-to-list 'ac-modes 'web-mode)   ; ac for html
;; (ac-set-trigger-key "s-<tab>")      ; and bind it to super - tab


;; (
;;  if (string-equal emacs-version "26.1")

;;     (
;;      (add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20180916.2115")
;;   (require 'yasnippet)
;;   (yas/global-mode t)
;;   (setq ac-source-yasnippet nil)
;;   (setq mode-require-final-newline nil)  ; no newlines after snippet
;;   (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
;; (defun yas/org-very-safe-expand ()
;;   (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
;;           (add-hook 'org-mode-hook
;;             (lambda ()
;;                 (make-variable-buffer-local 'yas/trigger-key)
;;                 (setq yas/trigger-key [tab])
;;                 (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
;;                 (define-key yas/keymap [tab] 'yas/next-field)))

;;           )
;;   )

;; something's not working with lower version, commenting so that the init gets loaded by both 26.1 and 24.3
;; (add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20180916.2115")
;; (require 'yasnippet)
;; (yas/global-mode t)
;; (setq ac-source-yasnippet nil)
;; (setq mode-require-final-newline nil)  ; no newlines after snippet
;; (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)




; (require 'fasm-mode)
; (autoload 'fasm-mode "fasm-mode.el"  "Major mode for FASM" t)
; (add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

(defun insert-frac ()
  "We insert  \\frac{}{} and position point before the first right brace."
  (interactive)
  (progn
    (insert "\\frac{}{}")
    (backward-char)
    (backward-char)
    (backward-char)))
(defun insert-leftb ()
  "We insert  \\left("
  (interactive)
  (progn
    (insert "\\left(")
    ))
(defun insert-rightb ()
  "We insert  \\right)"
  (interactive)
  (progn
    (insert "\\right)")
    ))
(defun sqroot ()
  "We insert  \\sqrt{}"
  (interactive)
  (progn
    (insert "\\sqrt{}")
    (backward-char)
    ))
   
(defun search-replace-dot ()
  "move to next dot and replace with space"
  (interactive)
  (progn
    (search-forward ".")
    (delete-backward-char 1)
;    (insert " ")
    ))
      


                    
(setq LaTeX-math-list (quote ( 
    ("M-s" (lambda ()(interactive)(sqroot)) "" nil)
    ("M-d" (lambda (llimit ulimit)(interactive "sEnter ll: \nsEnter ul: ")(insert "\\int_{" llimit "}^{" ulimit "} \\, ")) "" nil)
    ("M-i" (lambda() (interactive)(insert "\\int \\, ")))
    ("M-b" (lambda() (interactive)(insert "\\binom{}{} \\, ") (dotimes '7 (backward-char))))
    ("8" (lambda() (interactive)(insert "\\infty")))
    )))

;; duplicate line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "C-;") 'duplicate-line)


(defun matrix (mtype nr nc)
  "We insert  a specified matrix"
  (interactive "p")
    (cond 
        ((= mtype 1) (insert "\\begin{bmatrix}\n"))
        ((= mtype 2) (insert "\\begin{Bmatrix}\n"))
        ((= mtype 3) (insert "\\begin{vmatrix}\n"))
        ((= mtype 4) (insert "\\begin{pmatrix}\n")) )
    (dotimes 'nr (dotimes '(- nc 1) (insert " . &")) (insert " . \\\\\n") )
    (cond 
        ((= mtype 1) (insert "\\end{bmatrix}\n"))
        ((= mtype 2) (insert "\\end{Bmatrix}\n"))
        ((= mtype 3) (insert "\\end{vmatrix}\n"))
        ((= mtype 4) (insert "\\end{pmatrix}\n")) )
    (dotimes '(+ nr 1) (previous-line))
    (delete-char 1)
    )

;  (require 'color-theme)
;  (color-theme-initialize)
;  (color-theme-dark-laptop)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
; (load-theme 'manoj-dark)
; (load-theme 'deeper-blue)
(load-theme 'cyberpunk t)

;; (autoload 'j-mode "j-mode.el"  "Major mode for J." t)
;; (autoload 'bison-mode "bison-mode.el"  "Major mode for lex and yacc" t)
;; (autoload 'j-shell "j-mode.el" "Run J from emacs." t)
(setq auto-mode-alist
      (cons '("\\.[ly]" . bison-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.ij[rstp]" . j-mode) auto-mode-alist))
(global-set-key (kbd "M-s-t") 'toggle-truncate-lines)  ;; line wrapping 
(global-set-key (kbd "s-f")   'insert-frac)
(global-set-key (kbd "C-(") 'insert-leftb)
(global-set-key (kbd "C-)") 'insert-rightb)
(global-set-key (kbd "s-[") (lambda (ll ul) (interactive "nEnter nr: \nnEnter nc: ") (matrix 1 ll ul)))
(global-set-key (kbd "s-{") (lambda (ll ul) (interactive "nEnter nr: \nnEnter nc: ") (matrix 2 ll ul)))
(global-set-key (kbd "s-|") (lambda (ll ul) (interactive "nEnter nr: \nnEnter nc: ") (matrix 3 ll ul)))
(global-set-key (kbd "s-(") (lambda (ll ul) (interactive "nEnter nr: \nnEnter nc: ") (matrix 4 ll ul)))
(global-set-key (kbd "s-/") (lambda (ll ul) (interactive "nEnter nr: \nnEnter nc: ") (matrix 5 ll ul)))
(global-set-key (kbd "s-.") 'search-replace-dot)
(global-set-key (kbd "s-t")  "\C-u\M-! date +\"%d/%m/%Y  %R:%S\"")
(global-set-key "\M-n"  'next-buffer)
(global-set-key "\M-p"  'previous-buffer)

(setq c-default-style "linux"
      c-basic-offset 4)

;; Disable auto save
(setq auto-save-default nil)


;; Standard package.el + MELPA setup
;; (See also: https://github.com/milkypostman/melpa#usage)
(require 'package)
(add-to-list 'package-archives
;             '("melpa" . "http://melpa.milkbox.net/packages/") t)
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Standard Jedi.el setting
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Type:
;;     M-x package-install RET jedi RET
;;     M-x jedi:install-server RETURN-NIL
;; Then open Python file.

(defun jedi-goto-def ()
  (local-set-key (kbd "M-.") 'jedi:goto-definition))

;; (add-hook 'python-mode-hook 'anaconda-mode)
(defun run-python-once ()
  (remove-hook 'python-mode-hook 'run-python-once)
  (run-python (python-shell-parse-command)))

(add-hook 'python-mode-hook 'run-python-once)
(add-hook 'python-mode-hook 'jedi-goto-def)
(add-hook 'python-mode-hook 'eldoc-mode)
;; (eval-after-load "company"
;;  '(progn
;;    (add-to-list 'company-backends 'company-anaconda)
;;    ))
  
; C auto completion   
(semantic-mode 1)

(require 'semantic/ia)
(require 'semantic/bovine/gcc)

;; Semantic
;(global-semantic-idle-completions-mode t)
;(global-semantic-decoration-mode t)
;(global-semantic-highlight-func-mode t)
;(global-semantic-show-unmatched-syntax-mode t)

(defun my:add-semantic-to-ac()
    (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-ac)


;; CC-mode
(add-hook 'c-mode-hook '(lambda ()
        (setq ac-sources (append '(ac-source-semantic) ac-sources))
        (local-set-key (kbd "RET") 'newline-and-indent)
;        (linum-mode t)
        ))

;; Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (expand-file-name
             "~/.emacs.d/elpa/auto-complete-20150618.1949/dict"))
(setq ac-comphist-file (expand-file-name
             "~/.emacs.d/ac-comphist.dat"))
(ac-config-default)

(add-hook 'c-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))


(defun add-py-debug ()  
      "add debug code and move line down"  
    (interactive)  
    (insert "import pdb; pdb.set_trace();")
    (kbd "<tab>"))  

(global-set-key (kbd "<f9>") 'add-py-debug)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (fsharp-mode emoji-display irony nyan-mode emojify rmsbolt xcscope wsd-mode wolfram-mode web-mode w3 undo-tree tiny tern-auto-complete sqlup-mode sonic-pi solarized-theme smex skewer-mode shm scad-mode rust-mode restclient rainbow-delimiters racket-mode quickrun pungi projectile powerline paredit ox-reveal ox-nikola org-webpage org-page nim-mode move-text material-theme markdown-mode magit kotlin-mode julia-mode json-reformat intero icicles go-complete go-autocomplete ggtags flycheck-kotlin expand-region exec-path-from-shell elpy el-get ecb ctags-update ctags csv-mode csharp-mode company-tern company-qml company-ghci company-anaconda cider cedit c-eldoc auto-complete-sage auctex ac-etags ac-anaconda))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun my-python-send-region (&optional beg end)
  (interactive)
  (kbd "C-a")
 (setq beg (point))
 (python-nav-end-of-statement)
 (setq end (point))
 (python-shell-send-region beg end))

 (add-hook 'python-mode-hook
       (lambda ()
         (define-key python-mode-map "\C-cn" 'my-python-send-region)))

;; (split-window-right)
(setq split-height-threshold nil) 
(setq split-width-threshold 80)  ;; emacs to split vertically instead of horizontally to show new buffer

(setq org-element-use-cache nil)

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (R . t)
    (calc . t)
    (C . t)
    (latex . t)
    (shell . t)))

