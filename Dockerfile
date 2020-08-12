
FROM ubuntu:18.04

# exposing port 80
EXPOSE 80

# installing required tools
RUN apt-get update && apt-get install -y python python-pip \
nginx dirmngr gnupg

# Installing passenger
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7

RUN apt-get install -y apt-transport-https ca-certificates

RUN sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'

RUN apt-get update && apt-get install -y libnginx-mod-http-passenger

# Integratiing Passenger to nginx
RUN if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi

# Creating code directory
RUN mkdir -p /var/www/myapp/code

COPY . /var/www/myapp/code

# removing default configuration file
RUN rm -f /etc/nginx/sites-enabled/default

#Copyng the webapp confguration
COPY webapp.conf /etc/nginx/sites-enabled/myapp.conf

# install required python modules
RUN pip install -r /var/www/myapp/code/requirements.txt

# port access logs to stdout and error logs to stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log \ 	
    && ln -sf /dev/stderr /var/log/nginx/error.log 

# run the nginx with daemon off
CMD ["nginx", "-g", "daemon off;"]