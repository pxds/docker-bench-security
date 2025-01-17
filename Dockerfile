FROM alpine:3.13

LABEL \
  org.label-schema.name="docker-bench-security" \
  org.label-schema.url="https://dockerbench.com" \
  org.label-schema.vcs-url="https://github.com/docker/docker-bench-security.git"

RUN apk add --no-cache iproute2 \
                       docker-cli \
                       dumb-init

COPY . /usr/local/bin/

HEALTHCHECK CMD exit 0

WORKDIR /usr/local/bin

RUN sed -i 's/\r$//' docker-bench-security.sh && \
    sed -i 's/\r$//' functions/functions_lib.sh && \
    sed -i 's/\r$//' functions/helper_lib.sh && \
    sed -i 's/\r$//' functions/output_lib.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "sh", "docker-bench-security.sh" ]
CMD [""]
