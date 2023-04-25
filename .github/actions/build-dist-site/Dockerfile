ARG RUBY_VERSION=3.1.2
FROM ruby:$RUBY_VERSION

RUN apt-get update \
  && apt-get install -y \
  build-essential \
  locales

RUN \
  echo "en_US UTF-8" > /etc/locale.gen && \
  locale-gen en-US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]