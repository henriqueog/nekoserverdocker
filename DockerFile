FROM phusion/baseimage

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get update
RUN apt-add-repository ppa:ondrej/apache2 -y
RUN apt-get dist-upgrade -y
RUN apt-get install apache2 -y
RUN apt-get install wget -y
RUN apt-get install libgc-dev -y
RUN apt-get install libapache2-mod-neko -y
RUN apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV HAXE_VERSION 4.0.0

ENV NEKO_VERSION-WITH-HIFEN 2-3-0
ENV NEKO_VERSION 2.3.0

RUN cd /tmp/
RUN wget -c https://github.com/HaxeFoundation/neko/releases/download/v${NEKO_VERSION-WITH-HIFEN}/neko-${NEKO_VERSION}-linux64.tar.gz

RUN tar xvzf neko-${NEKO_VERSION}-linux64.tar.gz
RUN mkdir -p /usr/lib/neko
RUN rm -rf /usr/lib/neko/neko
RUN rm -rf /usr/lib/neko/nekotools
RUN cp -r neko-${NEKO_VERSION}-linux64/* /usr/lib/neko

RUN rm -rf /usr/bin/neko
RUN rm -rf /usr/bin/nekoc
RUN rm -rf /usr/bin/nekotools
RUN rm -rf /usr/lib/libneko.so

RUN ln -s /usr/lib/neko/neko /usr/bin/neko
RUN ln -s /usr/lib/neko/nekoc /usr/bin/nekoc
RUN ln -s /usr/lib/neko/nekotools /usr/bin/nekotools
RUN ln -s /usr/lib/neko/libneko.so /usr/lib/libneko.so

RUN rm -rf neko-${NEKO_VERSION}-linux
RUN rm neko-${NEKO_VERSION}-linux64.tar.gz

RUN wget -c http://haxe.org/website-content/downloads/${HAXE_VERSION}/downloads/haxe-${HAXE_VERSION}-linux64.tar.gz

RUN mkdir -p /usr/lib/haxe
RUN rm -rf /usr/lib/haxe/haxe
RUN tar xvzf haxe-${HAXE_VERSION}-linux64.tar.gz -C /usr/lib/haxe --strip-components=1

RUN rm -rf /usr/bin/haxe
RUN rm -rf /usr/bin/haxelib
RUN rm -rf /usr/bin/haxedoc

RUN ln -s /usr/lib/haxe/haxe /usr/bin/haxe
RUN ln -s /usr/lib/haxe/haxelib /usr/bin/haxelib

RUN mkdir -p /usr/lib/haxe/lib
RUN chmod -R 777 /usr/lib/haxe/lib

RUN rm haxe-${HAXE_VERSION}-linux64.tar.gz

RUN a2enmod rewrite
RUN a2enmod deflate
RUN a2enmod headers
RUN a2enmod session
RUN a2enmod xml2enc
RUN a2enmod neko

RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
