# vim:set ft=dockerfile:
ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG VERSION
ARG SCM_REF
ARG BUILD_TAG
ARG CLID
ARG PACKAGES

LABEL com.customer.sample.version=${VERSION}
LABEL com.customer.sample.scm-ref=${SCM_REF}
LABEL com.customer.sample.build-tag=${BUILD_TAG}

COPY --chown=nuxeo:0 target/WEBUI-1142-package-*.zip /home/nuxeo/local-packages/WEBUI-1142-package.zip
COPY --chown=nuxeo:0 nuxeo-web-ui-3.0.19.zip /home/nuxeo/local-packages/nuxeo-web-ui-3.0.19.zip

RUN /install-packages.sh --offline /home/nuxeo/local-packages/WEBUI-1142-package.zip
RUN /install-packages.sh --offline /home/nuxeo/local-packages/nuxeo-web-ui-3.0.19.zip
