#!/bin/sh

if [ -x /usr/bin/hciattach ]; then
	/usr/bin/hciattach ttyO1 csr
fi
