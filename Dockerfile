FROM python:alpine

EXPOSE 8080

LABEL io.k8s.description="Simple Flask application, running on Alpine Linux." \
      io.k8s.display-name="Hello Python World" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="python,alpine,hello-world" \
      maintainer="Redpill Linpro CloudOps"

ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PIP_NO_CACHE_DIR=off

COPY bin/ /usr/bin/
WORKDIR /opt/app-root/src

RUN chown -R 1001:0 /opt/app-root && chmod -R og+rwX /opt/app-root
USER 1001

COPY requirements.txt wsgi.py /opt/app-root/src/

RUN python -mvenv /opt/app-root && \
    source /opt/app-root/bin/activate && \
    PIP_DISABLE_PIP_VERSION_CHECK=on pip install -r requirements.txt
CMD ["/usr/bin/run"]
