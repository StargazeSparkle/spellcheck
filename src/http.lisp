(in-package :spellcheck)

;; TODO:
;;     - take advantage of request reuse

;; cookie jar stores cookie headers in order to maintain a login state
(defvar *http-cookie-jar* nil)

;; api path stores the full url to api.php on the wiki
(defvar *http-api-path* nil)

;; must be called first before any http requests can be made
(defun http-init (url)
    (progn
        (push (cons "application" "json") drakma:*text-content-types*)
        (setq *http-cookie-jar* (make-instance 'drakma:cookie-jar))
        (setq *http-api-path* url)))

;; http get request
;; params must be a nested cons
(defun http-get (params)
    (let ((uri (format nil
                       "~A?~A"
                       *http-api-path*
                       (quri:url-encode-params params))))
        (drakma:http-request uri
                             :preserve-uri t
                             :cookie-jar *http-cookie-jar*)))

;; http post request
;; params must be a nested cons
(defun http-post (params)
    (drakma:http-request *http-api-path*
                         :preserve-uri t
                         :method :post
                         :parameters params
                         :cookie-jar *http-cookie-jar*))