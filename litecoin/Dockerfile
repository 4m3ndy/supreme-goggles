FROM ubuntu:20.04

RUN groupadd -g 1001 litecoin && useradd -md /home/litecoin -u 1001 -g 1001 litecoin \
  && apt-get update -y \
  && apt-get upgrade -y && apt-get dist-upgrade -y \ 
  && apt-get install -y curl gnupg \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex \
  && for key in \
    0xFE3348877809386C \
  ; do \
    gpg --no-tty --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --no-tty --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --no-tty --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done

ARG LITECOIN_VERSION 0.18.1

ENV LITECOIN_VERSION=$LITECOIN_VERSION
ENV LITECOIN_DATA=/home/litecoin/.litecoin

RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
  && curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && grep $(sha256sum litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz | awk '{ print $1 }') litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

RUN mkdir -p "$LITECOIN_DATA" \
    && chmod 770 "$LITECOIN_DATA" || echo "Could not chmod $LITECOIN_DATA (may not have appropriate permissions)" \
   && chown -R litecoin "$LITECOIN_DATA" || echo "Could not chown $LITECOIN_DATA (may not have appropriate permissions)"

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/litecoin/.litecoin"]

EXPOSE 9332 9333 19332 19333 19444

USER litecoin

ENTRYPOINT ["/entrypoint.sh"]

CMD ["litecoind"]
