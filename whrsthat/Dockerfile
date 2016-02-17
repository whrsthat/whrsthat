FROM ruby:2.2.0

RUN apt-get update -qq && apt-get install -y build-essential curl

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN apt-get install -y nodejs

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN bundle install

ADD *bower* $APP_HOME/

RUN npm install -g bower && /bin/bash -c 'cd /app && bower install --allow-root'

ADD . $APP_HOME

ENV RAILS_ENV production 

CMD bundle exec passenger start --address 0.0.0.0 --port 80