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

# Create virtual environment as ROOT, then switch to mcp
RUN python3 -m venv /app/venv && \
    chown -R mcp:mcp /app/venv

USER mcp

ENV PATH="/app/venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

# Install unifi-network-mcp in venv
RUN pip3 install --no-cache-dir unifi-network-mcp

EXPOSE 3000

CMD ["/run.sh"]
