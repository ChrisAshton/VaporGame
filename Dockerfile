# Build image
FROM swift:4.1 as builder
RUN apt-get -qq update && apt-get -q -y install \
  your-dependencies-here # e.g. libmysqlclient-dev
WORKDIR /app
COPY . .
RUN mkdir -p /build/lib && cp -R /usr/lib/swift/linux/*.so /build/lib
RUN swift build -c release && mv `swift build -c release --show-bin-path` /build/bin

# Production image
FROM ubuntu:16.04
RUN apt-get -qq update && apt-get install -y \
  libssl-dev pkg-config \
  && rm -r /var/lib/apt/lists/*
WORKDIR /app
COPY Resources/ ./Resources/
COPY Public/ ./Public/
COPY --from=builder /build/bin/Run .
COPY --from=builder /build/lib/* /usr/lib/
EXPOSE 8080
CMD ["./Run", "serve", "--env", "production", "--hostname", "0.0.0.0"]
