# Licensed under the Apache License, Version 2.0 (see LICENSE.md)

FROM ubuntu:precise

MAINTAINER Christian Wagner <chriswayg@gmail.com>

# install required packages
# add nginx stable ppa & update & install latest stable nginx
# add a few utilities
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise-updates main restricted" | tee -a /etc/apt/sources.list.d/precise-updates.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        python python-dev \
        python-setuptools \
        python-software-properties \
        sqlite3 \
        supervisor \
        unzip \
        wget \
        patch \
        nano && \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        nginx && \
    apt-get clean && rm -r /var/lib/apt/lists/*

# install pip
# install uwsgi now because it takes a little while
RUN easy_install pip && \
    pip install uwsgi

# install our code
COPY . /home/docker/code/

# setup all the configfiles
# run pip install
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default && \
    ln -s /home/docker/code/nginx-app.conf /etc/nginx/sites-enabled/ && \
    ln -s /home/docker/code/supervisor-app.conf /etc/supervisor/conf.d/ && \
    pip install -r /home/docker/code/app/requirements.txt

# install django, normally you would remove this step because your project would already
# be installed in the code/app/ directory
RUN django-admin.py startproject website /home/docker/code/app/ && \
    cd /home/docker/code/app && ./manage.py syncdb --noinput

EXPOSE 80 8000
WORKDIR /home/docker/code/app/

CMD ["supervisord", "-n"]
