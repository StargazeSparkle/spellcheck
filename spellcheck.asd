(defsystem :spellcheck
    :depends-on
        (:arrow-macros
         :drakma
         :quri
         :cl-json
         :access
         :unix-opts)
    :components ((:module "src"
                  :serial t
                  :components
                    ((:file "package")
                     (:file "http")
                     (:file "mediawiki")
                     (:file "spellcheck")))))