(in-package :spellcheck)

;; TODO:
;;     - take advantage of request reuse

(defun http-client/make (wiki lang &key cookie-jar)
    (let ((url (format nil
                       "https://~A.fandom.com/~A/api.php"
                       wiki
                       lang)))
        (make-instance 'http-client
                       :api-path url
                       :cookie-jar cookie-jar)))

(defclass http-client ()
    ((api-path
        :initarg  :api-path
        :initform nil
        :accessor http/api-path)
     (cookie-jar
        :initarg  :cookie-jar
        :initform (make-instance 'drakma:cookie-jar)
        :accessor http/cookie-jar)))

(defmethod http/get ((object http-client) params)
    (let* ((param-str (quri:url-encode-params params))
           (path      (http/api-path object))
           (url       (format nil "~A?~A" path param-str)))
    (drakma:http-request url
                         :preserve-uri t
                         :cookie-jar   (http/cookie-jar object))))

(defmethod http/post ((object http-client) params)
    (drakma:http-request (http/api-path object)
                         :preserve-uri t
                         :method       :post
                         :content-type "application/x-www-form-urlencoded"
                         :parameters   params
                         :cookie-jar   (http/cookie-jar object)))