DIR=$(shell basename $(CURDIR))

VERSION=`gawk '$$1 == "Version:"{print $$2}' $(DIR)/DEBIAN/control`
ARCH=`gawk '$$1 == "Architecture:"{print $$2}' $(DIR)/DEBIAN/control`
COMMIT = $(shell date "+xe%Y%m%d_%H%M%S")

SUBDIRS := $(shell find $(DIR) -type d -print)
FILTER := $(abspath .git% %.deb .publish-git .builddeb %.swp Makefile)
FILTERORIG := $(abspath .git% %.deb .publish-git .builddeb %.swp Makefile) $(shell test -e noupdate.files && cat noupdate.files) /DEBIAN%
FILES := $(filter-out $(FILTER), $(abspath $(shell find . -mindepth 1 -type f -print) ))
ORIGS := $(filter-out $(FILTERORIG), $(realpath $(subst ./$(DIR),,$(shell sudo find . -mindepth 2 -type f -print))))
FILESGIT := $(filter-out $(abspath .git%), $(abspath $(shell find . -mindepth 1 -type f -print)))


.publish-git: $(FILESGIT)
	fakeroot git add .
	fakeroot git commit -m $(COMMIT) && git push origin master || exit 0
	touch .publish-git
	
