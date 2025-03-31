FROM fluent/fluentd:v1.17.1-1.0

USER root

RUN apk add --no-cache --update --virtual .build-deps sudo build-base ruby-dev && \
  gem install elasticsearch -v 7.17 && gem install fluent-plugin-elasticsearch

USER fluent