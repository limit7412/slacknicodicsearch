FROM ruby:2.5.1

ADD ./ /app

WORKDIR /app
RUN gem install bundler
EXPOSE 80
RUN bundle install --gemfile="./Gemfile"

CMD ["bundle","exec","rackup","config.ru","-p","80","-o","0.0.0.0"]
