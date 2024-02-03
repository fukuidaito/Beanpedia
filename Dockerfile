FROM ruby:3.1

WORKDIR /app
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV NODE_VERSION=19
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn libvips

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY yarn.lock /app/yarn.lock


RUN bundle install
RUN yarn install

CMD ["rails", "server", "-b", "0.0.0.0"]