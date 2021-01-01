(in-package spellcheck)

(defun start-bot (options)
    (let ((wiki (getf options :wiki))
          (lang (getf options :lang)))
        (format t "~A.~A~%" lang wiki)))

(defun print-help ()
    (progn
        (opts:describe :prefix "Spellchecker bot usage:"
                       :args   "[keywords]")
        (uiop:quit)))

(defun process-opts ()
    (multiple-value-bind (options free-args)
            (opts:get-opts)
        (cond
            ;; l & w
            ((and (getf options :wiki)
                  (getf options :lang))
                (start-bot options))
            ;; h
            ((getf options :help) (print-help))
            ;; nil
            (t (print-help)))))

(defun make-opts ()
    (opts:define-opts
        (:name :help
               :description "Prints this help message."
               :short #\h
               :long "help")
        (:name :lang
               :description "Set the language code of the wiki."
               :short #\l
               :long "lang"
               :arg-parser #'identity)
        (:name :wiki
               :description "Set the subdomain of the wiki."
               :short #\w
               :long "wiki"
               :arg-parser #'identity)))

(defun main ()
    (progn 
        (make-opts)
        (process-opts)))