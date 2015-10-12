# django-CMS with uWSGI, Nginx and Postgres 

#### A production-ready multi-container docker-compose

### django-CMS

What is it?

### About this django-CMS setup

features, intention

### How to use / Quickstart


This Dockerfile and docker-compose allows you to build a Docker container with a standard
and speedy setup for Django with uWSGI and Nginx.

uWSGI from a number of benchmarks has shown to be the fastest server 
for python applications and allows lots of flexibility.

Nginx has become the standard for serving up web applications and has the 
additional benefit that it can talk to uWSGI using the uWSGI protocol, further
elinimating overhead. 

Most of this setup comes from the excellent tutorial on 
https://uwsgi.readthedocs.org/en/latest/tutorials/Django_and_nginx.html

### Build and run


### Test

login first at http://example.com:80/admin
then go to http://example.com:80/admin/?edit

You should see the django-CMS sample content

### How to insert your application

In /cms currently a django-CMS site is created. You can also mount an existing site there.

This repo is a fork of https://github.com/dockerfiles/django-uwsgi-nginx,

Feel free to clone this and modify it to your liking. And feel free to 
contribute patches.

### Dockerfile notes:
 - not using python 3, because aldryn-people & aldryn-newsblog have a dependency problem with vobject: https://github.com/aldryn/aldryn-people/issues/28

# Licensed under the Apache License, Version 2.0 (see LICENSE.md)

...