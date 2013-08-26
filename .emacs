(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(require 'flymake)
(require 'flymake-cursor)

(global-set-key [f4] 'flymake-goto-next-error)

(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
   (let ((help (get-char-property (point) 'help-echo)))
    (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

; This runs flake8 via flymake. you must have flake8 installed
; via pip or whatever
(when (load "flymake" t) 
     (defun flymake-pyflakes-init () 
       (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                          'flymake-create-temp-inplace)) 
      (local-file (file-relative-name 
               temp-file 
               (file-name-directory buffer-file-name)))) 
         (list "flake8" (list local-file))))

     (add-to-list 'flymake-allowed-file-name-masks 
          '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)
