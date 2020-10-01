FROM ruby:2.7.1-alpine

ENV BUILD_PACKAGES="build-base libxml2-dev libxslt-dev sqlite-dev tzdata"

RUN apk add --no-cache $BUILD_PACKAGES

ENV BUNDLER_VERSION=2.1.4

RUN echo "install: --no-document --no-post-install-message\nupdate: --no-document --no-post-install-message" > /etc/gemrc

RUN gem install bundler -v $BUNDLER_VERSION

ENV APP_HOME /app

WORKDIR $APP_HOME

RUN bundle config build.nokogiri --use-system-libraries

COPY . ./

RUN chmod +x ./docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]
