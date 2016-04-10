# build-trusty-php-1

[![Build Status](https://travis-ci.org/infOpen/build-trusty-php-1.svg?branch=master)](https://travis-ci.org/infOpen/build-trusty-php-1)

Dockerfile used to build a base jenkins slave image used to build ubuntu trusty
packages for php apps, with some dependencies :
- mysql
- nodejs
- elasticsearch

## Warning

We use gosu to build packages with a non root user.
To be used with jenkins user, need to set setuid so take care about commands
launch in container with gosu.

