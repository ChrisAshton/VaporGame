# Build image
FROM swift:4.1 as builder
RUN apt-get -qq update && apt-get -q -y install \
  libssl-dev pkg-config docker # package dependencies here
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
EXPOSE SQLITE_PATH 8080
CMD ["./Run", "serve", "--env", "production", "--hostname", "0.0.0.0"]

# docker build -t vaporgame:dev -f Dockerfile . && docker run -it -p 8080:8080 -v "$PWD":/app --rm vaporgame:dev
