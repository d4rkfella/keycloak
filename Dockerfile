FROM quay.io/keycloak/keycloak:26.0.7@sha256:32d2eb0f84aaf85b3e3afef544d5b25fcd40a791d62374f327a0cb5ca9aa1da5 AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_CACHE_STACK=kubernetes
ENV KC_DB_URL_PROPERTIES=sslmode=verify-ca&sslrootcert=/etc/ssl/certs/cnpg-ca.crt

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
