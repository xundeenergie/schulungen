DIRS := Gimp
FILTER := $(abspath $(shell find . -name .git -printf %p%%\\n) %.deb %.swp %Makefile)
FILES := $(filter-out $(FILTER), $(abspath $(shell for i in $(DIRS);do find $$i -mindepth 1 -type f -print;done))) README.md
MAKEFILES := $(shell for i in $(DIRS); do find $$i -mindepth 1 -maxdepth 1 -name Makefile;done)
FILESGIT := $(filter-out $(abspath .git%), $(abspath $(shell find . -mindepth 1 -type f -print)))
COMMIT = $(shell date "+xe%Y%m%d_%H%M%S")



all: .publish-git 
	@#for i in $(FILES);do echo $$i;done
	@#touch .publish .publish-git
	
update:
	@for i in $(DIRS); do make -C $$i .update; done

update-makefiles: $(MAKEFILES)
	@for i in $?; do echo update $$i; cp -vu Makefile-repos $$i; done

.list: $(FILES)
	@for i in $(FILES) ;do echo $$i;done
	@touch .list


.publish-git: $(FILESGIT)
	fakeroot git add .
	fakeroot git commit -m $(COMMIT) && git push origin master || exit 0
	touch .publish-git
	
