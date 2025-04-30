FROM quay.io/keycloak/keycloak:26.2.2 AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.2.2
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_CACHE_STACK=kubernetes

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

LABEL org.opencontainers.image.source="https://github.com/keycloak/keycloak"
