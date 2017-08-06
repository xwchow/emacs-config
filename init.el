;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package cyberpunk-theme :ensure t
  :init (load-theme 'cyberpunk t))

(use-package magit :ensure t
  :init (global-set-key (kbd "C-x g") 'magit-status))

(use-package flycheck :ensure t)
(use-package try :ensure t)
(use-package crux :ensure t
  :init (progn
		  (global-set-key (kbd "C-c s") 'crux-transpose-windows)
		  (global-set-key (kbd "C-c o") 'crux-open-with)
		  (global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
		  (global-set-key (kbd "C-c I") 'crux-find-user-init-file)))

(require 'company)

(use-package which-key :ensure t
  :config (which-key-mode))

(use-package org-bullets :ensure t
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ace-window :ensure t
  :init (global-set-key [remap other-window] 'ace-window))

;; swiper
(use-package swiper  :ensure t
  :init  (use-package counsel :ensure t)
  :config  (progn
			 (ivy-mode 1)
			 (setq ivy-use-virtual-buffers t)
			 (setq enable-recursive-minibuffers t)
			 (global-set-key "\C-s" 'swiper)
			 (global-set-key "\C-r" 'swiper)
			 (global-set-key (kbd "M-x") 'counsel-M-x)
			 (global-set-key (kbd "C-x C-f") 'counsel-find-file)
			 ))

(use-package smartparens :ensure t
  :init (add-hook 'prog-mode-hook 'turn-on-smartparens-mode))

;; auto-highlight-symbol
(use-package auto-highlight-symbol :ensure t
  :init (progn
		  (global-auto-highlight-symbol-mode)
		  (define-key auto-highlight-symbol-mode-map (kbd "M-p") 'ahs-backward)
		  (define-key auto-highlight-symbol-mode-map (kbd "M-n") 'ahs-forward)
		  (setq ahs-idle-interval 1.0)
		  ))

;; Basic config
;; --------------------------------------
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(column-number-mode t)
(global-linum-mode t)
(show-paren-mode t)
(setq ring-bell-function 'ignore)

;; Set default font
(set-face-attribute 'default nil
					:family "Ubuntu Mono"
					:height 120
					:weight 'normal
					:slant 'normal
					:width 'normal)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(setq ibuffer-default-sorting-mode 'major-mode)

;; PROGRAMMING CONFIGURATION
;; --------------------------------------
;; use space to indent by default
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Python config (elpy)
;; --------------------------------------
(use-package elpy :ensure t
  :init
  (progn
    (use-package ein :ensure t)
    (elpy-enable)
    (setq elpy-rpc-python-command "python3")
    (elpy-use-ipython "ipython3")
    (add-hook 'elpy-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'elpy-format-code) ;; auto-format on save
                (local-set-key (kbd "C-=") 'elpy-goto-definition)
                (local-set-key (kbd "C--") 'pop-tag-mark)
                ))))

;; use flycheck instead of flymake
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; C++ CONFIGURATION
;; --------------------------------------
(defun my-c++-mode-hook ()
  (flycheck-mode)
  (company-mode)
  (setq flycheck-clang-language-standard "c++14"))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
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
(global-set-key (kbd "C-c w") 'wdired-change-to-wdired-mode)
(global-set-key (kbd "C-c W") 'whitespace-mode)

(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-n") 'company-select-next)

;; TODO
;; --------------------------------------
;; breadcrumb
;; highlight symbol only highlights in current view


;; init.el ends here
