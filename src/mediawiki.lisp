(in-package :spellcheck)

;; call this first to set up the http client
(defun mw-init (wiki lang)
    (progn 
        (http-init (format nil "https://~A.fandom.com/~A/api.php" wiki lang))
        (format t "Set wiki to: ~A.~A~%" lang wiki)))