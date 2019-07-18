# Create 'base' from a Ruby/Alpine image.
FROM ruby:2.6.3-alpine3.10 as base

# Create 'builder' from 'base'.
FROM base as builder

# Install dependencies so that gems will bundle properly. This list need not be
# optimized because 'builder' is an intermediate container.
RUN apk update \
  && apk upgrade \
  && apk add build-base \
  && apk add mariadb-dev \
  && apk add sqlite-dev

# Set up Bundler variables.
ENV BUNDLER_VERSION 2.0.1

# Bundle gems.
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN gem update --system \
  && gem install bundler -v "$BUNDLER_VERSION" \
  && bundle install \
  && rm -rf /usr/local/bundle/bundler/gems/*/.git /usr/local/bundle/cache/

# Create the final image from 'base'.
FROM base

# Install packages.
RUN apk update --no-cache \
  && apk upgrade --no-cache \
  && apk add --no-cache bash tzdata curl git mariadb-dev sqlite-dev\
  && rm -rf /var/cache/apk/*

# Copy in the app code.
RUN mkdir /app /files
WORKDIR /app
COPY . /app/

# Update bundler.
ENV BUNDLER_VERSION 2.0.1
RUN gem update --system \
    && gem install bundler -v "$BUNDLER_VERSION"

# Copy in the bundled gems from 'builder'.
COPY --from=builder /usr/local/bundle /usr/local/bundle/

# Never run as root!
RUN addgroup -g 1000 -S drosas \
  && adduser -u 1000 -S drosas -G drosas \
  && chown drosas:drosas /app /files
USER drosas

# Start the app.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
