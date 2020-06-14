#!/bin/bash

if [ $(ps ax | grep [s]sh-agent | wc -l) -gt 0 ] ; then
    echo "ssh-agent is already running"
else
    eval $(ssh-agent -s)
    if [ "$(ssh-add -l)" == "The agent has no identities." ] ; then
        ssh-add /home/kory/projects/ModExtractor/.ssh/id_rsa
    fi

    # Don't leave extra agents around: kill it on exit. You may not want this part.
    #trap "ssh-agent -k" exit
fi

if python3 /home/kory/projects/ModExtractor/powerblockCheck.py 2>&1 >/dev/null; then
	echo "none in stock"
else
	echo "in stock!" >> /home/kory/projects/ModExtractor/README.md
	cd /home/kory/projects/ModExtractor/ && git add .
	cd /home/kory/projects/ModExtractor/ && git commit -m "test commit"
	cd /home/kory/projects/ModExtractor/ && git push
fi

if test -f /home/kory/projects/ModExtractor/geckodriver.log; then
	rm /home/kory/projects/ModExtractor/geckodriver.log
fi
