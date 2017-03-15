FROM       centos:7
MAINTAINER "CC" <ducvn@basicnc.jp>
ENV        container docker
RUN        (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
           rm -f /lib/systemd/system/multi-user.target.wants/*;\
           rm -f /etc/systemd/system/*.wants/*;\
           rm -f /lib/systemd/system/local-fs.target.wants/*; \
           rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
           rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
           rm -f /lib/systemd/system/basic.target.wants/*; \
           rm -f /lib/systemd/system/anaconda.target.wants/*; \

           yum install -y git; \
           yum install -y openssh-server openssh-clients; \
           yum install -y iproute iproute-devel; \
           yum -y install epel-release; \
           yum -y install gperf freetype-devel libxml2-devel python-lxml git-all libtool; \
           yum -y install npm bzip2; \
           yum -y install wget unzip; \

           passwd root -d; \
           sed -i "s/^.*PermitEmptyPasswords.*$/PermitEmptyPasswords yes/g" /etc/ssh/sshd_config; \
           sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication yes/g" /etc/ssh/sshd_config; \

           mkdir -p /src/python; mkdir -p /src/node; \

           cd /src/python; \
           curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py; \
           python get-pip.py; \
           pip install -U six; \

           cd /src/; \
           git clone http://anongit.freedesktop.org/git/fontconfig; cd /src/fontconfig; \
           ./autogen.sh --prefix=/tmp/fontconfig --sysconfdir=/tmp/fontconfig/etc --bindir=/tmp/fontconfig/usr/bin --enable-libxml2; \
           make; make install; \

           wget -O IPAfont00303.zip http://ipafont.ipa.go.jp/old/ipafont/IPAfont00303.php; \
           unzip IPAfont00303.zip; \
           mkdir -p /tmp/fontconfig/usr/share/fonts; \
           mv IPAfont00303/*.ttf /tmp/fontconfig/usr/share/fonts; \

           cd /src/node; \
           npm install phantomjs-prebuilt; \
           mv /src/node/node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs /tmp/phantomjs-prebuilt;

VOLUME     [ "/run", "/tmp" ]
CMD        [ "/usr/sbin/init" ]
