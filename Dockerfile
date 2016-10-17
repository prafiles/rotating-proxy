FROM resin/rpi-raspbian:latest
MAINTAINER prafiles

ENV tors=16
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tor polipo haproxy libssl-dev wget curl git build-essential zlib1g-dev libyaml-dev libssl-dev

RUN update-rc.d -f tor remove
RUN update-rc.d -f polipo remove

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -L https://get.rvm.io | bash -s stable --ruby    

ADD start.rb /usr/local/bin/start.rb
RUN chmod +x /usr/local/bin/start.rb

ADD haproxy.cfg.erb /usr/local/etc/haproxy.cfg.erb

RUN bash -c "source /usr/local/rvm/scripts/rvm && gem install excon -v 0.44.4"

EXPOSE 5566 1936

CMD bash -c "source /usr/local/rvm/scripts/rvm && ruby /usr/local/bin/start.rb"