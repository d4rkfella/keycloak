FROM quay.io/keycloak/keycloak:26.0.4@sha256:d3cf176da1028a50657e1bcf995e58b6f1aef23a76a43dd7f9934264525cd9a7 AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_CACHE_STACK=kubernetes

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
