
# Tsugi base PHP docker

# docker build --tag tsugi_base .
# docker run -p 8080:80 -p 3306:3306 -e BOB=42 -dit tsugi_base:latest

# To redo
# docker container prune
# docker image rm tsugi_dev:latest tsugi_mysql:latest tsugi_base:latest

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  export DEBIAN_FRONTEND=noninteractive && \
  export LC_ALL=C.UTF-8 && \
  locale -a && \
  env && \
  echo ======= Update 1 && \
  apt-get update && \
  echo ======= Upgrade && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y ca-certificates && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C && \
  echo ======= Update 2 && \
  apt-get update && \
  add-apt-repository -y ppa:ondrej/php && \
  add-apt-repository -y ppa:ondrej/apache2 && \
  add-apt-repository -y ppa:ondrej/mysql-5.6 && \
  add-apt-repository -y ppa:certbot/certbot && \
  apt-get update && \
  apt-get install -y apache2 && \
  apt-get install -y php7.2 && \
  apt-get install -y libapache2-mod-php7.2 php7.2-mysql php7.2-curl php7.2-json && \
  apt-get install -y php7.2-mbstring php7.2-zip php7.2-xml php7.2-gd && \
  apt-get install -y php7.2-apc && \
  apt-get install -y php7.2-intl && \
  apt-get install -y mysql-client && \
  apt-get install -y nfs-common && \
  a2enmod -q rewrite dir expires headers && \
  phpenmod mysqlnd pdo_mysql intl && \
  echo ======= Installing Postfix && \
  echo "postfix postfix/mailname string example.com" | debconf-set-selections &&\
  echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections &&\
  apt-get install -y mailutils &&\
  echo ======= Cleanup Start && \
  df && \
  apt-get --purge -y remove software-properties-common && \
  apt-get -y autoclean && \
  apt-get -y clean && \
  apt-get -y autoremove && \
  rm -rf /var/lib/apt/lists/* && \
  echo ======= Cleanup Done && \
  df && \
  echo ======= Cleanup Done 

#  apt-get install -y mailutils

# Setup files
COPY monitor-apache.sh tsugi-base-startup.sh /usr/local/bin/
COPY apache2.conf /etc/apache2

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root


EXPOSE 80 443
ENTRYPOINT ["bash", "/usr/local/bin/tsugi-base-startup.sh"]

# Define default command.  (Should never get here)
CMD ["bash"]
