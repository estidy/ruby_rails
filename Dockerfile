ARG RUBY_VERSION=3.1.1

FROM ruby:${RUBY_VERSION}

ARG RAILS_VERSION=7.0.2.3
ARG USER=docker
ARG USER_UID=1000
ARG USER_GID=$USER_UID

### INSTALL NODE ###
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

### ADITIONAL PACKAGES ###
# To compile and install native addons from npm you may also need to install build tools: build-essential 
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends nodejs yarn python2 \
    && apt-get clean

### SETUP CURRENT USER ###
RUN useradd -m ${USER} --uid=${USER_UID} | chpasswd
USER ${USER_UID}:${USER_GID}
WORKDIR /home/${USER}

### INSTALL RAILS ###
RUN echo 'gem: --no-document' >> ~/.gemrc
RUN gem install rails -v ${RAILS_VERSION}

