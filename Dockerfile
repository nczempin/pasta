#FROM ruby:2.3-slim
#FROM ruby:1.8
#FROM hublogix/minimal-ruby

# HAs Ubumntu, ruby1.8, ... and I trust the guy who built it :P
FROM palladius/septober:v1.2


RUN apt-get update \
 && apt-get install -qq -y --no-install-recommends \
    build-essential \
    nodejs \
    libpq-dev \
    git \
    tzdata \
    libxml2-dev \
    libxslt-dev \
    libsqlite3-dev \
    ssh \
 && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /opt/pasta

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# change to . if you move Dockerfile to /
ADD . $APP_HOME

RUN bundle install

ENV GEM_HOME /opt/pasta/vendor/bundle
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_BIN $BUNDLE_PATH/bin
ENV DESCRIPTION "This experiment was tried in 2019. Not sure it works today"

EXPOSE 8080

ENTRYPOINT [ "./entrypoint-8080.sh" ]
CMD ["echo", "Ciao a tutti. Change CMD if you want to run bash or something.." ]
