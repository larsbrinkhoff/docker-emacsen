Build a Docker image with multiple versions of Emacs.  Currently,
versions 22.3, 23.4, 24.5, and 25.1 are supported.  They are installed
in separate directories under /usr/local.

The image is published in Docker Hub as
[`larsbrinkhoff/emacsen`](https://hub.docker.com/r/larsbrinkhoff/emacsen/).
These are the binaries provided:
- /usr/local/emacs-22.3/bin/emacs
- /usr/local/emacs-23.4/bin/emacs
- /usr/local/emacs-24.5/bin/emacs
- /usr/local/emacs-25.1/bin/emacs
