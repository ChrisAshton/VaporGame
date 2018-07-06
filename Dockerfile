FROM swift:4.1
RUN apt-get -qq update && apt-get -q -y install libssl-dev pkg-config
WORKDIR /app
