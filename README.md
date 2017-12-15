[![Build Status](https://travis-ci.org/larsbrinkhoff/docker-emacsen.svg?branch=master)](https://travis-ci.org/larsbrinkhoff/docker-emacsen)

Build a Docker image with multiple versions of Emacs.  Currently,
versions 22.3, 23.4, 24.5, 25.3, and the latest development snapshot
are supported.  They are installed in separate directories under
/usr/local.

The image is published in Docker Hub as
[`larsbrinkhoff/emacsen`](https://hub.docker.com/r/larsbrinkhoff/emacsen/).
These are the binaries provided:
- /usr/local/emacs-22.3/bin/emacs
- /usr/local/emacs-23.4/bin/emacs
- /usr/local/emacs-24.5/bin/emacs
- /usr/local/emacs-25.3/bin/emacs
- /usr/local/emacs-snapshot/bin/emacs

Among other things, it can be used to test Emacs packages.  For an
example, see how `forth-mode` is tested in [Wercker](http://wercker.com):
https://github.com/larsbrinkhoff/forth-mode/blob/master/wercker.yml
