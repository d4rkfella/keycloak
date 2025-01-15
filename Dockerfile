FROM quay.io/keycloak/keycloak:26.1.0@sha256:7e3a06e8e2d1ac0a1461202f8a288e8fa0e15f40fd908927ac0694d3643460d0 AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.1.0@sha256:7e3a06e8e2d1ac0a1461202f8a288e8fa0e15f40fd908927ac0694d3643460d0
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_CACHE_STACK=kubernetes
ENV KC_DB_URL_PROPERTIES=?sslmode=verify-full&sslrootcert=/etc/ssl/certs/cnpg-ca.crt

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
