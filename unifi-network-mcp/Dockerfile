ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.12-alpine3.20
FROM ${BUILD_FROM}

# Install Python and pip
RUN apk add --no-cache python3 py3-pip

# Create a non-root user
RUN addgroup -g 1000 mcp && \
    adduser -D -u 1000 -G mcp mcp

WORKDIR /app

# Copy add-on files
COPY run.sh /run.sh
RUN chmod +x /run.sh

USER mcp

# Install unifi-network-mcp directly from PyPI
RUN pip3 install --no-cache-dir unifi-network-mcp

EXPOSE 3000

ENV PYTHONUNBUFFERED=1

CMD ["/run.sh"]
