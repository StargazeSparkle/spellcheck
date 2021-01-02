(in-package :spellcheck)

;; call this first to set up the http client
(defun mw-init (wiki lang)
    (let ((client (make-http-client wiki lang)))
        (print (http-get client '(("action" "help"))))))