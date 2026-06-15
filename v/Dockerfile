FROM debian:stable-slim AS build

WORKDIR /opt/vlang

RUN apt-get -qq update && \
  apt-get -qy install --no-install-recommends \
    build-essential \
    git && \
  {{#build_deps.length}}
  apt-get -y install {{#build_deps}}{{.}} {{/build_deps}} && \
  {{/build_deps.length}}
  rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/vlang:$PATH \
  GIT_SSL_NO_VERIFY=1


# Pin V to a fixed commit for reproducible builds (instead of moving master).
# Shallow-fetch just that commit. Bump the SHA to update the compiler.
RUN git -C /opt/vlang init -q && \
  git -C /opt/vlang fetch --depth 1 https://github.com/vlang/v 065a450b86f6459b1e4398fe7b0594bbfcc2d691 && \
  git -C /opt/vlang checkout -q FETCH_HEAD && \
  make -C /opt/vlang

RUN ln -s /opt/vlang/v /usr/bin/v

{{#download}}
  RUN {{{.}}}
{{/download}}

WORKDIR /app

{{#files}}
  COPY '{{source}}' '{{target}}'
{{/files}}

{{#bootstrap}}
  RUN {{{.}}}
{{/bootstrap}}

RUN v {{#build_flags}} {{{.}}} {{/build_flags}} . -o server



FROM debian:stable-slim

WORKDIR /app

RUN apt-get -qq update && \
  apt-get -y install --no-install-recommends curl liburing2 && \
  rm -rf /var/lib/apt/lists/*

# Copy the built binary
COPY --from=build /app /app

HEALTHCHECK --interval=30s --timeout=10s --retries=3 --start-period=40s \
  CMD curl --fail http://0.0.0.0:3000 || exit 1

ENTRYPOINT {{{command}}}
