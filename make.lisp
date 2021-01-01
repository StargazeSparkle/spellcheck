(ql:quickload "spellcheck")
(in-package :spellcheck)
(sb-ext:save-lisp-and-die "spellcheck"
                          :toplevel #'main
                          :executable t
                          :compression 9)