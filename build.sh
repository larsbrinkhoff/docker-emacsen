. ./config.sh

if test -d emacs/.git; then
    (cd emacs && git checkout master && git pull)
else
    git clone $REPO
fi

build=""
for version in $VERSIONS; do
    rev=emacs-$version
    test $version = snapshot && rev=master
    build="$build
RUN cd /emacs && git checkout $rev && git clean -xfd
COPY bootstrap.sh /emacs
RUN cd /emacs && sh bootstrap.sh $version && make && make install"
done

cat <<EOF > Dockerfile
FROM ubuntu

ENV RDEPS libgnutls30 libncurses5
ENV BDEPS git gcc make autoconf automake libgnutls-dev libncurses-dev
ENV USERNAME root

RUN apt-get -q update && apt-get install -y \$BDEPS \$RDEPS
COPY emacs /emacs
$build
RUN apt-get purge -y \$BDEPS
RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /emacs; exit 0
EOF

echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
docker build -t larsbrinkhoff/emacsen .
