
;; Extracted from https://github.com/hlissner/doom-emacs/blob/develop/early-init.el

;; Emacs HEAD (27+) introduces early-init.el, which is run before init.el,
;; before package and UI initialization happens.

;; In Emacs 27+, package initialization occurs before `user-init-file' is
;; loaded, but after `early-init-file'. Doom handles package initialization, so
;; we must prevent Emacs from doing it early!
;; (setq package-enable-at-startup nil)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early.
;;(setq tool-bar-mode nil
;;      menu-bar-mode nil)
;;(when (fboundp 'set-scroll-bar-mode)
;;  (set-scroll-bar-mode nil))

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
;;(setq frame-inhibit-implied-resize t)

;; Ignore X resources; its settings would be redundant with the other settings
;; in this file and can conflict with later config (particularly where the
;; cursor color is concerned).
;;(advice-add #'x-apply-session-resources :override #'ignore)
;;(setq gc-cons-threshold 64000000)
;;(add-hook 'after-init-hook #'(lambda ()
;;                               ;; restore after startup
;;                               (setq gc-cons-threshold 800000)))

;;(when window-system
;;  (scroll-bar-mode -1)
;;  (tool-bar-mode -1))
;;(menu-bar-mode -1)

;; Determine which actually sets the font
;; font
;; (add-to-list 'default-frame-alist '(font . "Fira Code"))
;; (setq font-lock-maximum-decoration 3)
;; (set-face-attribute 'default nil :height 165)
;; (set-fontset-font "fontset-default" nil
;;                   (font-spec :size 12 :name "Fira Code"))

;; Setting English Font
;; (set-face-attribute
;;  'default nil :stipple nil :height 130 :width 'normal :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant 'normal :weight 'normal :foundry "outline" :family "DejaVu Sans Mono for Powerline")



(add-hook 'before-save-hook 'delete-trailing-whitespace)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)

(setq-default save-place t)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode)
;;(global-prettify-symbols-mode)


;; store auto-save and backup files in ~/.emacs.d/backups/
;;(defvar --backup-dir (concat user-emacs-directory "backups"))
;;(unless (file-exists-p --backup-dir)
;;  (make-directory --backup-dir t))
;;
;;;; don’t save customizations to init file
;;(setq custom-file (concat user-emacs-directory ".emacs-customize.el"))
;;(if (file-exists-p custom-file)
;;    (load custom-file))

;;(setq backup-by-copying t
;;      delete-old-versions t
;;      kept-new-versions 5
;;      kept-old-versions 1
;;      version-control t
;;      require-final-newline t
;;      ispell-program-name "hunspell"
;;
;;      ;;version-control
;;      vc-follow-symlinks t
;;      inhibit-startup-screen t
;;      auto-save-default t
;;
;;      backup-directory-alist `((".*" . ,--backup-dir))
;;      auto-save-file-name-transforms `((".*" ,--backup-dir t))
;;
;;      user-mail-address "robert.sheynin@gmail.com"
;;      graphviz-dot-dot-program "@graphviz@/bin/dot"
;;      graphviz-dot-view-command "@graphviz@/bin/dotty"
;;      graphviz-dot-preview-extension "svg"
;;      graphviz-dot-auto-preview-on-save t
;;      user-full-name "Robert Sheynin"
;;      nix-indent-function 'nix-indent-line
;;      )

;;(global-set-key (kbd "<end>") 'end-of-line)
;;(global-set-key (kbd "<home>") 'beginning-of-line)
;;(global-set-key (kbd "<ESC> <ESC>") 'dabbrev-expand)
;;(column-number-mode)

;;(setq-default sentence-end-double-space nil
;;              indent-tabs-mode nil
;;              ispell-program-name "@spelling@/bin/hunspell"
;;              )
;;
;;
;;(defun loader-after-plugins ()
;;
;;  (add-to-list 'load-path "@jupyter@")
;;  (require 'jupyter)
;;
;;  (eval-after-load 'rng-loc
;;    '(add-to-list 'rng-schema-locating-files "@schemas@"))
;;
;;
;;  (global-set-key (kbd "C-s") 'swiper)
;;  (global-set-key (kbd "M-x") 'counsel-M-x)
;;  (global-set-key (kbd "C-x C-f") 'counsel-find-file) ;; 'counsel-projectile-find-file)
;;  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;;  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;;  (global-set-key (kbd "<f1> l") 'counsel-find-library)
;;  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;;
;;  )
;;
;;(add-hook 'after-init-hook #'global-flycheck-mode)
;;(add-hook 'after-init-hook #'loader-after-plugins)
