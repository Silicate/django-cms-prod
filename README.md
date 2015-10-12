# django-CMS with uWSGI, Nginx and PostgreSQL
#### A production-ready multi-container django-CMS setup

### django-CMS web publishing platform

Easy-to-use for content editors and developer-friendly. Easy to integrate existing Django Apps. django CMS is a modern web publishing platform built with Django, the web application framework “for perfectionists with deadlines”.

django CMS offers out-of-the-box support for the common features you’d expect from a CMS, but can also be easily customised and extended by developers to create a site that is tailored to their precise needs.

### About this django-CMS setup

This Dockerfile with docker-compose allows you to build a Docker container set with a standard
and speedy setup for Django with uWSGI, Nginx and PostgreSQL. It uses the official Docker images for Nginx and PostgreSQL and links these together with the django-CMS/uWSGI container.

uWSGI from a number of benchmarks has shown to be the fastest server 
for python applications and allows lots of flexibility.

Nginx has become the standard for serving up web applications and has the 
additional benefit that it can talk to uWSGI using the uWSGI protocol, further
elinimating overhead.

PostgreSQL is the recommended relational database for working with Python web applications. PostgreSQL's feature set, active development and stability contribute to its usage as the backend for millions of applications live on the Web today.

Most of this setup comes from the excellent tutorial on 
https://uwsgi.readthedocs.org/en/latest/tutorials/Django_and_nginx.html

### Quickstart for Testing
```
git clone https://github.com/chriswayg/django-cms-uwsgi-nginx.git
cd django-cms-uwsgi-nginx
docker-compose up -d
docker-compose logs
```
- wait for django-cms installer to finish (in log: 'spawned uWSGI worker')
- login first at ```http://example.org/admin```
- then go to ```http://example.org/admin/?edit```

You can also run a debug session in the foreground by 

You should see the django-CMS sample content

### Modify Settings for Production use

In /cms a django-CMS site is created. You can also mount an existing site there.

###### Essential:

- in docker-compose.yml
    - edit passwords & hosts 
    - check ports and choose project location

###### As needed: in config/

- modify djangocms-installer options in cms_installer.ini
- add additional apps to cms_requirements.txt
- add common settings to settings_append.py
- add prodution settings to settings_production.py
- add developer settings to settings_dev.py
- check uWSGI and nginx configurations

```
docker-compose build
docker-compose up -d

```
Then check the site and the logs

### Notes:

This repo is a fork of https://github.com/dockerfiles/django-uwsgi-nginx.
Feel free to clone this and modify it to your liking. And feel free to 
contribute patches.

The  Dockerfile is not using python 3, because aldryn-people & aldryn-newsblog 
have a dependency problem with vobject: https://github.com/aldryn/aldryn-people/issues/28

---
Licensed under the Apache License, Version 2.0 (see LICENSE.md)
