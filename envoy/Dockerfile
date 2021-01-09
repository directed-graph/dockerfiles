
FROM envoyproxy/envoy:v1.16.2

COPY envoy/envoy.yaml /etc/envoy/envoy.yaml

ENTRYPOINT [ \
    "/usr/local/bin/envoy", \
    "-c", "/etc/envoy/envoy.yaml", \
    "-l", "trace", \
    "--log-path", "/tmp/envoy_info.log"]
