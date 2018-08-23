BASE:=book
BOOKNAME:=`ls -1 $(BASE)`
SRC:=book/$(BOOKNAME)
IMAGE:=andreacensi/duckuments:devel

all:
	cat README.md

compile:
	make clean; make compile-docker; echo;echo;echo;echo;echo;echo;echo; echo "The HTML files can be found under duckuments-dist/$(BOOKNAME)/out"; echo; echo; echo

include resources/makefiles/setup.Makefile
