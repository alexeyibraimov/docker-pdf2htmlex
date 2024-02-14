FROM ubuntu:trusty

RUN apt-get update && apt-get install -y build-essential checkinstall git cmake

RUN apt-get install -y poppler-data autotools-dev libjpeg-dev libtiff4-dev libpng12-dev \
		       libgif-dev libxt-dev autoconf automake libtool bzip2 libxml2-dev libuninameslist-dev \
		       libspiro-dev python-dev libpango1.0-dev libcairo2-dev chrpath uuid-dev uthash-dev libopenjpeg-dev \
		       sudo packaging-dev pkg-config python-dev g++ xz-utils wget cron

ADD offline/poppler-0.26.5.tar.xz /
RUN cd / && cd poppler-0.26.5 && ./configure --prefix=/usr --enable-xpdf-headers && make && make install

ADD offline/freetype-2.6.3.tar.gz /
RUN cd / && cd freetype-2.6.3 && ./configure && make && make install

ADD offline/fontconfig-2.12.0.tar.bz2 /
RUN cd / && cd fontconfig-2.12.0 && ./configure && make && make install

ADD offline/fontforge.tar.gz /
RUN cd / && cd fontforge && ./autogen.sh && ./configure --prefix=/usr && make && make install && ldconfig

ADD offline/pdf2htmlEX.tar.gz /
RUN cd / && cd pdf2htmlEX && cmake . -DENABLE_SVG=ON && make && make install

RUN rm /usr/sbin/invoke-rc.d
RUN dpkg-divert --rename --remove /usr/sbin/invoke-rc.d

COPY createdir.sh /
RUN chmod a+x /createdir.sh

# Copy the cron file to the container
COPY cronfile /etc/cron.d/cronfile

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cronfile

# Apply the cron job
RUN crontab /etc/cron.d/cronfile

RUN mkdir -p /pdf2html

VOLUME /pdf2html

WORKDIR /

ENTRYPOINT ["cron","-f"]
