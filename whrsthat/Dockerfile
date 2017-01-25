FROM ruby:2.2.0

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get install -y nodejs libgmp-dev libqt4-webkit libqt4-dev libxml2-dev ruby-json libxslt1-dev libpq-dev build-essential

ENV APP_HOME /app

ENV RAILS_ENV production 

ENV DATABASE_URL postgres://postgres:postgres@postgres/whrsthat_production

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN bundle install

ADD *bower* $APP_HOME/

RUN npm install -g bower coffee-script && /bin/bash -c 'cd /app && bower install --allow-root'

ADD . $APP_HOME

CMD bundle exec rackup -s Puma --host 0.0.0.0 --port 80