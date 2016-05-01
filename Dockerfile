FROM infopen/jenkins-slave-ubuntu-trusty-build-deb:0.2.0
MAINTAINER Alexandre Chaussier <a.chaussier@infopen.pro>

# Install additionnal GPG Key for Elastic
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | \
    sudo apt-key add -

# Install additionnal GPG Key for Node
RUN wget -qO - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | \
    sudo apt-key add -

# Install apt https transport for APT
RUN apt-get update && \
    apt-get install -y apt-transport-https

# Install additionnal repository for Elastic
RUN echo "deb http://packages.elastic.co/elasticsearch/1.4/debian stable main" \
    | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.4.list

# Install additionnal repository for Node
RUN echo "deb https://deb.nodesource.com/node_5.x trusty main" \
    | sudo tee -a /etc/apt/sources.list.d/nodejs-5.x.list

# Install additionnal repository for Node src
RUN echo "deb-src https://deb.nodesource.com/node_5.x trusty main" \
    | sudo tee -a /etc/apt/sources.list.d/nodejs-5.x-src.list

# Install packages to manage php jobs, includes Mysql server and ElasticSearch
RUN apt-get update && \
    apt-get install -y  elasticsearch \
                        mysql-server \
                        nodejs \
                        openjdk-7-jdk \
                        openjdk-7-jre \
                        php-pear \
                        php5 \
                        php5-cli \
                        php5-common \
                        php5-curl \
                        php5-gd \
                        php5-imagick \
                        php5-mcrypt \
                        php5-mysql \
                        php5-xdebug \
                        php5-xsl \
                        graphviz \
                        libgv-php5 \
                        xvfb

# Download and install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

# Manage headless chromium browser
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --unpack google-chrome-stable_current_amd64.deb && \
    apt-get install -f -y && \
    apt-get clean && \
    rm google-chrome-stable_current_amd64.deb
