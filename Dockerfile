FROM python:3.9

VOLUME [ "/docs" ]
WORKDIR /docs
CMD [ "mkdocs", "serve", "-a", "0.0.0.0:8000" ]

ADD requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt
