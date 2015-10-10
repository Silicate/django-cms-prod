FROM python:2.7
# not using python 3, because aldryn-people & aldryn-newsblog have a 
# dependency problem: https://github.com/aldryn/aldryn-people/issues/28

ENV LANG=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    PIP_REQUIRE_VIRTUALENV=false 

# installs uWSGI and django-CMS with plugins 
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt && \
	mkdir -v /uwsgi/

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install netcat nano && \
    apt-get clean && rm -r /var/lib/apt/lists/*

COPY ./config/ /config/

VOLUME [ "/cms", "/config", "/uwsgi"]

EXPOSE 8000
WORKDIR /cms

# Install django-CMS site on first-run of container
ENTRYPOINT ["/config/docker-entrypoint"]

CMD ["/usr/local/bin/uwsgi", "--ini", "/config/uwsgi.ini"]
