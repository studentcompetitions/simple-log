FROM ruby:2.2.3

ENV HOME /home/rails/webapp

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN bundle install --quiet

# Add the app code
ADD . $HOME

# Precompile assets
RUN rake assets:precompile
EXPOSE 3000

# Default command
CMD ["puma", "-C", "config/puma.rb"]
