FROM quay.io/keycloak/keycloak:latest@sha256:089b5898cb0ba151224c83aef3806538582880029eb5ea71c2afd00b627d4907 as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_CACHE_STACK=kubernetes

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
