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
    crux
    exec-path-from-shell
    auto-highlight-symbol
    smartparens))
  ;;   py-autopep8))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-refresh-contents)
            (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(require 'better-defaults)
(require 'smartparens)
(require 'crux)

;; smartparens
(add-hook 'prog-mode-hook 'turn-on-smartparens-mode)

;; auto-highlight-symbol
(global-auto-highlight-symbol-mode)
(define-key auto-highlight-symbol-mode-map (kbd "M-p") 'ahs-backward)
(define-key auto-highlight-symbol-mode-map (kbd "M-n") 'ahs-forward)
(setq ahs-idle-interval 1.0)

(load-theme 'cyberpunk t) ;; load cyberpunk theme
(setq inhibit-startup-message t) ;; hide the startup message
(global-linum-mode t) ;; enable line numbers globally
(column-number-mode t)
(setq ring-bell-function 'ignore)

;; PROGRAMMING CONFIGURATION
;; --------------------------------------
;; use space to indent by default
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; PYTHON CONFIGURATION
;; --------------------------------------
(elpy-enable)
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; C++ CONFIGURATION
;; --------------------------------------
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(setq c-default-style "linux"
      c-basic-offset 4)

(sp-local-pair 'c++-mode "{" nil :post-handlers
               '((my-create-newline-and-enter-sexp "RET")))

(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

;; Keyboard Shortcuts
;; --------------------------------------
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-c s") 'crux-transpose-windows)
(global-set-key (kbd "C-c o") 'crux-open-with)
(global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
(global-set-key (kbd "C-c I") 'crux-find-user-init-file)
(global-set-key (kbd "C-c w") 'wdired-change-to-wdired-mode)

(global-set-key (kbd "C-c W") 'whitespace-cleanup)

;; TODO
;; --------------------------------------
;; code completion with C-p and C-n
;; tab for code completion
;; consider removing indentation highlighting in python
;; goto definition new hotkeys
;; C-s stops at line
;; python auto-pep8?
;; breadcrumb

;; init.el ends here
