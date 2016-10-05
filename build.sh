. ./config.sh

if test -d emacs/.git; then
    (cd emacs && git checkout master && git pull)
else
    git clone $REPO
fi

build=""
for version in $VERSIONS; do
    build="$build
RUN cd /emacs && git checkout emacs-$version && git clean -xfd
COPY bootstrap.sh /emacs
RUN cd /emacs && sh bootstrap.sh $version && make && make install"
done

cat <<EOF > Dockerfile
FROM debian

ENV RDEPS libgnutls-deb0-28 libncurses5
ENV BDEPS git gcc make autoconf automake libgnutls28-dev libncurses-dev
ENV USERNAME root

RUN apt-get -q update -m && apt-get install -y \$BDEPS \$RDEPS
COPY emacs /emacs
$build
RUN apt-get purge -y \$BDEPS
RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /emacs; exit 0
EOF

docker build -t larsbrinkhoff/emacsen:${TAG:-latest} .
