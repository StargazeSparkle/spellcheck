sbcl := sbcl --load

all:
	$(sbcl) make.lisp


clean:
	rm -rf spellcheck


.PHONY: clean