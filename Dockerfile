FROM debian:buster
#Notre OS

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget 
RUN apt-get -y install nginx
RUN apt-get -y install openssl
RUN apt-get install -y mariadb-server mariadb-client
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-mbstring php-zip php-gd php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
#RUN tous les logiciels ce dont j'ai besoin pour mon server

COPY srcs/init.sh ./
COPY srcs/wp-config.php ./
COPY srcs/config.inc.php ./
COPY srcs/default ./

CMD bash /init.sh
# The main purpose of a CMD is to provide defaults for an executing container, je lui donne le fichier pour init le container

#Dans un server
# il y a un OS: debian buster
# un server HTTP: NGINX, pour faire en sorte que les clients aient acces a nos URL
# un server-side programming language : PHP, It provides an interface to users to make requests, give instructions to the server to process. Server side coding is also responsible for user authentication, and data security.
# une base de données