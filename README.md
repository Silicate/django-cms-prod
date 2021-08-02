# --possibly.click django-CMS with uWSGI, Nginx and PostgreSQL
#### A production-ready multi-container django CMS setup

--Forked for Production/proof of concept for my portfolio style website at http://possibly.click; doesnt work out of the box for me yet/initially (on googles cloud compute services). I will add notes along the way of extra details I think would help similarly inexperienced users and for comic relief. I may update the docker files to use the latest Django-CMS a long with any plugins that I think will be useful down the road. I don't really know what I am doing so bear with me and please feel free to send any suggestions, critique, knowledge or advice my way, thanks. 

A big thank you to Chriswayg for the initial code for which without I weould be a lot more lost than I currently am.

## django-CMS web publishing platform

Easy-to-use for content editors and developer-friendly. Easy to integrate existing Django Apps. django CMS is a modern web publishing platform built with Django, the web application framework “for perfectionists with deadlines”.

--why does this sound too good to be true? I think i would describe it like this:
'a fairy tale app as elusive as a devine goddess for which broken tutorials abound; your deadlines be damned she has other plans anyways'

django CMS offers out-of-the-box support for the common features you’d expect from a CMS, but can also be easily customised and extended by developers to create a site that is tailored to their precise needs.

--if i could even open that box that would be good

## About this django-CMS setup

This Dockerfile with docker-compose allows you to build a Docker container set with a standard
and speedy setup for django-CMS with uWSGI, Nginx and PostgreSQL. It builds a django-CMS/uWSGI container and links this together with the official Docker images for Nginx and PostgreSQL as well as a Data volume container.

--i really wish it was this easy

- **uWSGI** from a number of benchmarks has shown to be the fastest server 
for python applications and allows lots of flexibility.

--not to be confused with wysiwyg


- **Nginx** has become the standard for serving up web applications and has the 
additional benefit that it can talk to uWSGI using the uWSGI protocol, further
elinimating overhead.

--includes a free clever russian back-door to your site 

- **PostgreSQL** is the recommended relational database for working with Python web applications. PostgreSQL's feature set, active development and stability contribute to its usage as the backend for millions of applications live on the Web today.

--Puts hair on your neck

Much of this setup comes from the excellent tutorial on 
https://uwsgi.readthedocs.org/en/latest/tutorials/Django_and_nginx.html

## Quickstart for Testing
Run the following commands to get started:
```
git clone https://github.com/chriswayg/django-cms-prod.git
cd django-cms-prod
docker-compose up -d
docker-compose logs
```
- wait for django-cms installer to finish (in log: 'spawned uWSGI worker')
- login first at ```http://example.org/admin```
- then go to ```http://example.org/?edit```
 
You should now see the django-CMS sample Bootstrap content.

You can also run a debug session in the foreground with:
```
docker exec -it djangocmsprod_uwsgi_1 mode-dev
```

--This does not work out of box for me I'm getting this error:

```~/django-cms-prod$ docker-compose up -d
ERROR: The Compose file './docker-compose.yml' is invalid because:
uwsgi.environment.CMS_ALLOWED_HOSTS contains ["*"], which is an invalid type, it should be a string, number, or a null"
```

## Modify Settings for Production use

A django-CMS site is created in /cms. You can also mount an existing project there.

###### Essential:

- in ```docker-compose.yml```
    - edit passwords & hosts 
    - check ports and choose project location

--These are pretty vauge instructions, I'm beginning to think this is a little fishy as this should be listed above the test code if it's essential.
I will need to add more context to this because i have questions.


###### As needed: in ```config/```

- modify djangocms-installer options in ```cms_installer.ini```

--modify which options?

- add additional apps to ```cms_requirements.txt```

--need to do some research on what would be good to add to the build

- add common settings to ```settings_append.py```
- add prodution settings to ```settings_production.py```
- add developer settings to ```settings_dev.py```
- check uWSGI settings in ```uwsgi.ini```
- check nginx configuration in ```nginx/conf.d/djangocms.conf

--these instructions needs context/more information

- ```

After editing the configurations run:
```
docker-compose build
docker-compose up -d
```
### Notes:

This repo(origianally) is a fork of https://github.com/dockerfiles/django-uwsgi-nginx.
Feel free to clone this and modify it to your liking. And feel free to 
contribute patches.

The Dockerfile is using the official Python 2.7 image, not Python 3 even though django-CMS should run fine with it. The main reason is, that aldryn-people & aldryn-newsblog 
have a dependency problem with vobject: https://github.com/aldryn/aldryn-people/issues/28

---
Licensed under the Apache License, Version 2.0 (see LICENSE.md)
