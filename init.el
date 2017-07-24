;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------
(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    cyberpunk-theme
    ein
    elpy
    flycheck
    magit
    crux))
  ;;   py-autopep8))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-refresh-contents)
            (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(require 'better-defaults)
(load-theme 'cyberpunk t) ;; load cyberpunk theme

(setq inhibit-startup-message t) ;; hide the startup message
(global-linum-mode t) ;; enable line numbers globally
(column-number-mode t)
(setq ring-bell-function 'ignore)

;; PYTHON CONFIGURATION
;; --------------------------------------
(elpy-enable)
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Keyboard Shortcuts
;; --------------------------------------
(global-set-key (kbd "C-x g") 'magit-status)

(require 'crux)
(global-set-key (kbd "C-c s") 'crux-transpose-windows)
(global-set-key (kbd "C-c o") 'crux-open-with)
(global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
(global-set-key (kbd "C-c I") 'crux-find-user-init-file)

;; TODO
;; --------------------------------------
;; code completion with C-p and C-n
;; tab for code completion
;; consider removing indentation highlighting in python
;; goto definition new hotkeys
;; C-s stops at line
;; python auto-pep8?

;; init.el ends here
