FROM hiroara/myenv:latest

# Build deps
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      software-properties-common \
      && \
    rm -rf /var/lib/apt/lists/*

# Ruby
RUN apt-add-repository -y ppa:rael-gc/rvm && \
    apt-get update && \
    apt-get install -y rvm && \
    rm -rf /var/lib/apt/lists/*
ENV RUBY_VERSION=2.7.2
RUN /usr/share/rvm/bin/rvm install $RUBY_VERSION && \
    /usr/share/rvm/bin/rvm alias create default $RUBY_VERSION

COPY ./bundle/config /root/.bundle/config
COPY ./scripts/init.sh /tmp/ruby-init.sh

ENTRYPOINT ["/tmp/ruby-init.sh"]
CMD ["/bin/bash", "--login"]
