;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    cyberpunk-theme))
  ;;   ein
  ;;   elpy
  ;;   flycheck
  ;;   cyberpunk-theme
  ;;   py-autopep8))
    

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'cyberpunk t) ;; load cyberpunk theme
(global-linum-mode t) ;; enable line numbers globally
(setq ring-bell-function 'ignore) 

;; REQUIRE PACKAGES
;; --------------------------------------
(require 'better-defaults)

