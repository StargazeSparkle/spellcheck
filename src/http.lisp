(in-package :spellcheck)

;; TODO:
;;     - take advantage of request reuse

(defun make-http-client (wiki lang &key cookie-jar)
    (let ((url (format nil "https://~A.fandom.com/~A/api.php" wiki lang)))
        (make-instance 'http-client :api-path url :cookie-jar cookie-jar)))

(defclass http-client ()
    ((api-path
        :initarg  :api-path
        :initform nil
        :accessor api-path)
     (cookie-jar
        :initarg  :cookie-jar
        :initform (make-instance 'drakma:cookie-jar)
        :accessor cookie-jar)))

(defmethod http-get ((object http-client) params)
    (let* ((param-str (quri:url-encode-params params))
           (path      (api-path object))
           (url       (format nil "~A?~A" path param-str)))
    (drakma:http-request url
                         :preserve-uri t
                         :cookie-jar   (cookie-jar object))))

(defmethod http-post ((object http-client) params)
    (drakma:http-request (api-path object)
                         :preserve-uri t
                         :method       :post
                         :parameters   params
                         :cookie-jar   (cookie-jar object)))