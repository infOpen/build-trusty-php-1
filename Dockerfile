FROM infopen/jenkins-slave-ubuntu-trusty-build-deb:0.2.0
MAINTAINER Alexandre Chaussier <a.chaussier@infopen.pro>

# Install additionnal GPG Key for Elastic
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | \
    sudo apt-key add -

# Install apt https transport for APT
RUN apt-get update && \
    apt-get install -y apt-transport-https

# Install additionnal repository for Elastic
RUN echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" \
    | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

# Install additionnal repository for PHP
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" \
    | sudo tee -a /etc/apt/sources.list.d/ondrej-php-trusty.list
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# Install packages to manage php jobs, includes Mysql server and ElasticSearch
RUN apt-get update && \
    apt-get install -y  elasticsearch \
                        mysql-server \
                        openjdk-7-jdk \
                        openjdk-7-jre \
                        php-pear \
                        php7.0 \
                        php7.0-cli \
                        php7.0-common \
                        php7.0-curl \
                        php7.0-dev \
                        php7.0-gd \
                        php7.0-json \
                        php7.0-mbstring \
                        php7.0-mysql \
                        php7.0-opcache \
                        php7.0-readline \
                        php7.0-xdebug \
                        php7.0-xml \
                        php7.1-common \
                        php7.1-mbstring \
                        libapache2-mod-php7.0 \
                        graphviz \
                        rlwrap \
                        xvfb

# Download and install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

# Download and install NodeJS
RUN wget -q https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/nodejs-dbg_6.10.3-1nodesource1~trusty1_amd64.deb && \
        wget -q https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/nodejs_6.10.3-1nodesource1~trusty1_amd64.deb && \
        dpkg -i ./nodejs_6.10.3-1nodesource1~trusty1_amd64.deb && \
        dpkg -i ./nodejs-dbg_6.10.3-1nodesource1~trusty1_amd64.deb && \
        rm ./nodejs-dbg_6.10.3-1nodesource1~trusty1_amd64.deb && \
        rm ./nodejs_6.10.3-1nodesource1~trusty1_amd64.deb

# Manage headless chromium browser
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --unpack google-chrome-stable_current_amd64.deb && \
    apt-get install -f -y && \
    apt-get clean && \
    rm google-chrome-stable_current_amd64.deb
