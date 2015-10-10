FROM python:2.7
# not using python 3, because aldryn-people & aldryn-newsblog have a 
# dependency problem: https://github.com/aldryn/aldryn-people/issues/28

ENV LANG=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    PIP_REQUIRE_VIRTUALENV=false \
    TERM=xterm

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        netcat nano && \
    apt-get clean && rm -r /var/lib/apt/lists/*

# install uWSGI, djangocms-installer & PostgreSQL adapter
# TODO: move /requirements-cms.txt back to config
COPY ./requirements-cms.txt /requirements-cms.txt
RUN pip install -r /requirements-cms.txt && \
	mkdir -v /uwsgi/ && \
    chown -Rv www-data:www-data /uwsgi

COPY ./config/ /config/
COPY ./scripts/ /usr/local/bin/

VOLUME [ "/cms", "/config", "/uwsgi"]

EXPOSE 8000
WORKDIR /cms

# Install django-CMS site on first-run of container
ENTRYPOINT ["docker-entrypoint"]

CMD ["uwsgi", "--ini", "/config/uwsgi.ini"]
