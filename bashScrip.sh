#!/bin/bash

if ps -p $SSH_AGENT_PID > /dev/nul; then
  echo "ssh-agent is already running"
else
  eval `ssh-agent -s`
  ssh-add /home/kory/.ssh/id_rsa
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
