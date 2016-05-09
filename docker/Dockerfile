FROM ubuntu:16.04
MAINTAINER Yoshihisa AMAKATA <amakata@flatz.jp>
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y ruby-dev ruby-bundler
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# RUN gem install markerd

# Default command
CMD ["/bin/bash --login"]
