
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 20) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (set-background-color "black"))))
 '(tool-bar-mode nil)
 '(menu-bar-mode 0))

(add-to-list 'load-path "~/.emacs.d/")

(require 'font-lock)
(global-font-lock-mode t)
(require 'color-theme)

(require 'ibuffer)
(require 'ido)
(menu-bar-mode 0)

;; modify emacs frame-title
(setq frame-title-format
  '("" invocation-name ": "(:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))

(require 'auto-complete)
(require 'auto-complete-config)
(require 'python-mode)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c")
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

(require 'gccsense)

(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key (kbd "C-c .") 'ac-complete-gccsense)))

(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           color theme            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(color-theme-initialize)
(setq color-theme-is-global t)
(setq color-theme-is-cumulative t)
(setq color-theme-load-all-themes nil)

(require 'color-theme-tango-2)
(require 'color-theme-subdued)
(color-theme-tango-2)

(add-hook 'message-mode-hook 'color-theme-tangotango)
(add-hook 'gnus-article-mode-hook 'color-theme-tangotango)

(add-hook 'after-make-frame-functions
	  (lambda (frame)
	    (set-variable 'color-theme-is-global nil)
	    (select-frame frame)
	    (if window-system
		(color-theme-tangotango)
	      (color-theme-tty-dark))))


(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching
(setq ido-cannot-complete-command 'ido-next-match
  ido-default-buffer-method 'selected-window
  ido-default-file-method 'selected-window
  ido-auto-merge-work-directories-length -1)

(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(set-face-attribute 'default nil :height 100)
(setq require-final-newline t)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-a" 'goto-line)
(global-set-key "\M-z" 'new-frame)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq indent-tabs-mode nil)
(setq tab-width 2)
(setq standard-indent 2)
(setq-default py-indent-offset 2)
(setq-default python-indent 2)
(setq-default js-indent-level 2)


(setq c-default-style "bsd"
      indent-tabs-mode nil
      c-basic-offset 2
      c-indent-level 2)

(setq c-mode-hook
    (function (lambda ()
		(c-set-style "bsd")
                (setq indent-tabs-mode nil)
		(setq c-basic-offset 2)
                (setq c-indent-level 2))))
(setq python-mode-hook
    (function (lambda ()
		(c-set-style "bsd")
                (setq indent-tabs-mode nil)
		(setq c-basic-offset 2)
                (setq c-indent-level 2))))
(setq c++-mode-hook
    (function (lambda ()
		(c-set-style "bsd")
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2)
		(setq c-basic-offset 2)
		)))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(default ((t (:inherit nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 136 :width normal :foundry "unknown" :family "Inconsolata")))))

(server-start)
