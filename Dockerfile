FROM ruby:2.7.8

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler -v 2.4.22

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install gems
RUN bundle _2.4.22_ install

# Copy application code
COPY . .

# Create necessary directories
RUN mkdir -p tmp/pids tmp/sockets log
RUN chmod -R 777 tmp log

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"] 