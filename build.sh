VERSIONS="22.3 23.4 24.5 25.1"
REPO=git://git.savannah.gnu.org/emacs.git
#https://github.com/emacs-mirror/emacs

if test -d emacs; then
    (cd emacs && git pull)
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
RUN rm -rf /emacs /var/lib/apt/lists/*
EOF

docker build -t larsbrinkhoff/emacsen .
#docker push larsbrinkhoff/emacsen:latest
