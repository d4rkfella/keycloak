FROM quay.io/keycloak/keycloak:26.0.8@sha256:8fb7bfca18df664a4f9a9c49fc36e34d65e43fe618169e3044730cc9a1f1d2cf AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.0.8@sha256:8fb7bfca18df664a4f9a9c49fc36e34d65e43fe618169e3044730cc9a1f1d2cf
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_CACHE_STACK=kubernetes
ENV KC_DB_URL_PROPERTIES=?sslmode=verify-full&sslrootcert=/etc/ssl/certs/cnpg-ca.crt

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
