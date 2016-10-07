version="$1"

OPTS="--without-makeinfo --with-crt-dir=/usr/lib/x86_64-linux-gnu --prefix=/usr/local/emacs-$version"

if test -f INSTALL.CVS; then
    ln -s /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/crt1.o
    ln -s /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/crti.o
    ln -s /usr/lib/x86_64-linux-gnu/crtn.o /usr/lib/crtn.o
    CPPFLAGS=-P ./configure $OPTS && make bootstrap
    exit 0
fi

if test \! -f autogen.sh; then
    ./configure $OPTS && make bootstrap
    exit 0
fi

if grep BZR autogen.sh && test -f configure; then
    ./configure $OPTS && make bootstrap
    exit 0
fi

./autogen.sh && ./configure $OPTS
