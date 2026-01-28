ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install dependencies
RUN apk add --no-cache \
    curl \
    python3 \
    py3-pip

# Install uv for faster package management
RUN curl -fsSL https://astral.sh/uv/install.sh | sh

# Create a non-root user
RUN addgroup -g 1000 mcp && \
    adduser -D -u 1000 -G mcp mcp

# Set up the installation directory
WORKDIR /app

# Copy the entrypoint script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Switch to non-root user
USER mcp

# Install unifi-network-mcp using uv
RUN /root/.local/bin/uv pip install unifi-network-mcp

# Expose HTTP port (optional, for SSE mode)
EXPOSE 3000

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Run the MCP server via the entrypoint script
CMD ["/run.sh"]
