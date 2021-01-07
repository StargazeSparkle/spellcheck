(in-package :spellcheck)

(defun mediawiki/make (wiki lang &key cookie-jar)
    (progn
        (let* ((http-client     (http-client/make wiki
                                                  lang
                                                  :cookie-jar cookie-jar))
              (mediawiki-client (make-instance    'mediawiki
                                                  :http-client http-client)))
            mediawiki-client)))

(defclass mediawiki ()
    ((http
        :initarg  :http-client
        :initform nil
        :accessor mediawiki/http-client)))

(defmethod mediawiki/login ((client mediawiki) username password)
    (progn
        (let* ((username username)
               (password password)
               (res (http/post (mediawiki/http-client client)
                               '(("action"     . "login")
                                 ("lgname"     . username)
                                 ("lgpassword" . password)
                                 ("format"     . "json"))))
               (lgtoken (access:accesses (json:decode-json-from-string res)
                                         'query
                                         'tokens
                                         'logintoken)))
            (print (http/post (mediawiki/http-client client)
                       '(("action"     . "login")
                         ("lgname"     . username)
                         ("lgpassword" . password)
                         ("lgtoken"    . lgtoken)
                         ("format"     . "json")))))))