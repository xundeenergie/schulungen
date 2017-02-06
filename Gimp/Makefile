FILESGIT := $(filter-out $(abspath .git%), $(abspath $(shell find . -mindepth 1 -type f -print)))
COMMIT = $(shell date "+xe%Y%m%d_%H%M%S")


.publish-git: $(FILESGIT)
	fakeroot git add .
	fakeroot git commit -m $(COMMIT) && git push origin master || exit 0
	touch .publish-git
	
