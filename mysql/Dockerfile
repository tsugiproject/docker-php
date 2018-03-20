
# Tsugi plus mysql
# docker build --tag tsugi_mysql .
# docker run -p 8080:80 -p 3306:3306 -e BOB=42 -dit d3e979c9935d

# docker run -p 8080:80 -p 3306:3306 -e BOB=42 -v /var/lib/mysql -dit d3e979c9935d

# mysql -u root --host=127.0.0.1 --port=3306 -p

# See: https://gist.github.com/sheikhwaqas/9088872 

FROM tsugi_base:latest

COPY tsugi-startup.sh /usr/local/bin

# Install.
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  export LC_ALL=C.UTF-8 && \
  echo ======= Update 1 && \
  apt-get update && \
  echo ======= Install MySQL && \
  echo "mysql-server-5.5 mysql-server/root_password password root" | sudo debconf-set-selections && \
  echo "mysql-server-5.5 mysql-server/root_password_again password root" | sudo debconf-set-selections &&\
  apt-get -y install mysql-server-5.5 && \
  # echo ======= Securing Installation && \
  # echo -e "root\nn\nY\nY\nY\nY\n" | mysql_secure_installation && \
  echo ======= Cleanup Starting && \
  df && \
  rm -rf /var/lib/apt/lists/* && \
  df && \
  echo ======= Cleanup Done 

#  apt-get install -y mailutils

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

EXPOSE 80 443 3306
ENTRYPOINT ["bash", "/usr/local/bin/tsugi-startup.sh"]

# Define default command.
CMD ["bash"]
