#!/bin/bash
if python3 powerblockCheck.py 2>&1 >/dev/null; then
	echo "none in stock"
else
	echo "in stock!" >> README.md
	git add .
	git commit -m "test commit"
	git push
fi

if test -f ./geckodriver.log; then
	rm ./geckodriver.log
fi
