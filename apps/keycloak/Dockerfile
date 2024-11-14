FROM quay.io/keycloak/keycloak:26.0.4@sha256:cb3c2f071b3fd1a00051699ac95acf72fdd464d0e23804150169fd3037cff506 AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_CACHE_STACK=kubernetes

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
