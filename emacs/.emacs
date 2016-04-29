(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "e26780280b5248eb9b2d02a237d9941956fc94972443b0f7aeec12b5c15db9f3" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "bd115791a5ac6058164193164fd1245ac9dc97207783eae036f0bfc9ad9670e0" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" default)))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(ros-completion-function (quote ido-completing-read))
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INSTALLING ALL THE PACKAGES WE WANT

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'cl)

(defvar my-packages
  '(auctex deft expand-region gist magit markdown-mode cmake-mode
	   deferred projectile python elpy jedi python-environment flx-ido
	   smex volatile-highlights yaml-mode fic-ext-mode yasnippet
	   ibuffer ido smartparens winner dash cc-mode guess-offset
	   auto-complete powerline git-gutter hlinum rainbow-delimiters
	   paredit sublime-themes graphviz-dot-mode dockerfile-mode
	   flycheck)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONFIGURATION

;; theme and visuals
(load-theme 'spolsky t)

(global-linum-mode t)
(require 'hlinum)
(hlinum-activate)

(require 'git-gutter)
(global-git-gutter-mode t)
(git-gutter:linum-setup)

;;(require 'rainbow-delimiters)
;;(global-rainbow-delimiters-mode t)

(require 'fic-ext-mode)
(add-hook 'c-mode-common-hook 'fic-ext-mode)
(add-hook 'emacs-lisp-mode-hook 'fic-ext-mode)
(add-hook 'python-mode-hook 'fic-ext-mode)

(require 'cc-mode)
(setq c-default-style "linux"
          c-basic-offset 2)
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

(require 'powerline)
(powerline-default-theme)

;; better buffer switching
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;;compilation
(setq compile-command "cd ../../../..; catkin_make")
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq compilation-scroll-output 1)


(when (fboundp 'winner-mode)
  (winner-mode 1))
;;autoclose the compilation buffer
(setq compilation-finish-functions 'compile-autoclose)
  (defun compile-autoclose (buffer string)
     (cond ((string-match "finished" string)
          (bury-buffer "*compilation*")
          (winner-undo)
          (message "Build successful."))
         (t
          (message "Compilation exited abnormally: %s" string))))

(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))

;; misc
(fset 'yes-or-no-p 'y-or-n-p)
(if (eq window-system 'x)
    (shell-command "xmodmap -e 'clear Lock' -e 'keycode 66 = F13'"))
(global-set-key [f13] 'execute-extended-command)

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

(require 'windmove)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<down>") 'windmove-down)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'smartparens-config)
(smartparens-global-mode t)

(require 'yasnippet)
(yas-global-mode 1)

;;email and identity
(setq user-mail-address "ugo@shadowrobot.com")
(setq user-full-name "Ugo Cupcic")

;; modify emacs frame-title
(setq frame-title-format
  '("" invocation-name ": "(:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))

;;start emacs server
(server-start)

;; add slack
(defun slackcat (&optional b e)
  "Upload contents of region to slack chat."
  (interactive "r")
  (shell-command-on-region b e "slackcat"))

;;better python
;; (when (require 'elpy nil t)
;;   (elpy-enable))
;; (elpy-use-ipython)
;; (setq elpy-rpc-backend "jedi")
;; (jedi:install-server)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

;;auto complete
(require 'auto-complete-config)
(ac-config-default)

(require 'gist)
(setq gist-view-gist t)
;;TODO doxymacs

(require 'graphviz-dot-mode)
(require 'dockerfile-mode)

;;project
(projectile-global-mode)
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;;fuzzy matching for M-x
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; check python as we write it
(add-hook 'after-init-hook #'global-flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           ROS stuffs             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;TODO get rosemacs from https://github.com/moesenle/rosemacs-debs.git
;;     automatically

(add-to-list 'load-path "/home/ugo/.emacs.d/rosemacs-debs")

(setenv "PATH" (concat "/opt/ros/indigo/bin:"
		       (getenv "PATH")))

(require 'rosemacs)
(invoke-rosemacs)
(global-set-key "\C-x\C-r" ros-keymap)

(require 'rng-loc)
(push (concat (ros-package-path "rosemacs") "/rng-schemas.xml") rng-schema-locating-files)
(add-to-list 'auto-mode-alist '("\.launch$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\.test$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\.machine$" . nxml-mode))
(add-to-list 'auto-mode-alist '("manifest.xml" . nxml-mode))
(add-to-list 'auto-mode-alist '("\.xacro$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\.urdf$" . nxml-mode))

(add-to-list 'auto-mode-alist '("\.rosinstall$" . yaml-mode))

(add-to-list 'auto-mode-alist '("\.md$" . markdown-mode))

(add-to-list 'auto-mode-alist '("\.cfg$" . python-mode))

;; Add ROS message files to gdb-script mode for syntax highlighting
(add-to-list 'auto-mode-alist '("\\.msg\\'" . gdb-script-mode))
(add-to-list 'auto-mode-alist '("\\.srv\\'" . gdb-script-mode))
(add-to-list 'auto-mode-alist '("\\.action\\'" . gdb-script-mode))

;; Add ROS standard message types to gdb-script-mode for different highlighting
(font-lock-add-keywords 'gdb-script-mode
                        '(("\\<\\(bool\\|int8\\|uint8\\|int16\\|uint16\\|int32\\|uint32\\|int64\\|uint64\\|float32\\|float64\\|string\\|time\\|duration\\)\\>" . font-lock-builtin-face)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
