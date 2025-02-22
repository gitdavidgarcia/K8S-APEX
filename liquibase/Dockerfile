# Builder Stage
FROM eclipse-temurin:17-jre-jammy

# Create liquibase user
RUN groupadd --gid 1001 liquibase && \
    useradd --uid 1001 --gid liquibase --create-home --home-dir /liquibase liquibase && \
    chown liquibase /liquibase

# Install necessary dependencies
#RUN apt-get update && \
#    apt-get -yqq install krb5-user libpam-krb5 --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/*

# Download and install Liquibase
WORKDIR /liquibase

ARG LIQUIBASE_VERSION=4.31.0
ARG LB_SHA256=ffcf80c34c8b05a50c32c423ad2899aa9e7a5cd40097628f2bc739b70654962d

RUN wget -q -O liquibase-${LIQUIBASE_VERSION}.tar.gz "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz" && \
    echo "$LB_SHA256 *liquibase-${LIQUIBASE_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    ln -s /liquibase/liquibase /usr/local/bin/liquibase && \
    ln -s /liquibase/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh && \
    liquibase --version

ARG LPM_VERSION=0.2.8
ARG LPM_SHA256=ad46e7f0ca67e39ddbf1435c0bd2879be8a43340c7b627a2da45c07787574200
ARG LPM_SHA256_ARM=2a2e46f2260f46ccd39f487dca161b4e04d97664160925c5e415bd9b54a23e1a

# Download and Install lpm
RUN apt-get update && \
    apt-get -yqq install unzip --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /liquibase/bin && \
    arch="$(dpkg --print-architecture)" && \
    case "$arch" in \
      amd64)  DOWNLOAD_ARCH=""  ;; \
      arm64)  DOWNLOAD_ARCH="-arm64" && LPM_SHA256=$LPM_SHA256_ARM ;; \
      *) echo >&2 "error: unsupported architecture '$arch'" && exit 1 ;; \
    esac && wget -q -O lpm-${LPM_VERSION}-linux${DOWNLOAD_ARCH}.zip "https://github.com/liquibase/liquibase-package-manager/releases/download/v${LPM_VERSION}/lpm-${LPM_VERSION}-linux${DOWNLOAD_ARCH}.zip" && \
    echo "$LPM_SHA256 *lpm-${LPM_VERSION}-linux${DOWNLOAD_ARCH}.zip" | sha256sum -c - && \
    unzip lpm-${LPM_VERSION}-linux${DOWNLOAD_ARCH}.zip -d bin/ && \
    rm lpm-${LPM_VERSION}-linux${DOWNLOAD_ARCH}.zip && \
    ln -s /liquibase/bin/lpm /usr/local/bin/lpm && \
    lpm --version

# Set LIQUIBASE_HOME environment variable
#COPY java ./java
#RUN ln -s ./j* ./latest
#COPY sqlcl/ /liquibase/sqlcl
#ENV  JAVA_HOME=/liquibase/java/latest
#RUN chown liquibase:liquibase /liquibase/java -R
RUN wget -q -O sqlcl-latest.zip "https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip"
RUN unzip sqlcl-latest.zip
RUN chown liquibase:liquibase /liquibase/sqlcl -R
ENV LIQUIBASE_HOME=/liquibase
# Marker which indicates this is a Liquibase docker container
ENV DOCKER_LIQUIBASE=true

COPY ./liquibase/docker-entrypoint.sh ./
#COPY liquibase.docker.properties ./
COPY ./liquibase/sqls/ ./
# Set user and group
USER liquibase:liquibase

ENTRYPOINT ["/liquibase/docker-entrypoint.sh"]
CMD ["--help"]
