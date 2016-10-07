#!/bin/sh

set -ex
. /x/config.sh

for v in $VERSIONS; do
    /usr/local/emacs-$v/bin/emacs --batch --eval '(kill-emacs 0)'
done

exit 0
