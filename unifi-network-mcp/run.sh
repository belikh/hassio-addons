#!/usr/bin/with-contenv bashio
set -e

# Map add-on options to environment variables
export UNIFI_HOST=$(bashio::options 'host')
export UNIFI_USERNAME=$(bashio::options 'username')
export UNIFI_PASSWORD=$(bashio::options 'password')
export UNIFI_PORT=$(bashio::options 'port')
export UNIFI_SITE=$(bashio::options 'site')
export UNIFI_VERIFY_SSL=$(bashio::options 'verify_ssl')
export UNIFI_CONTROLLER_TYPE=$(bashio::options 'controller_type')
export UNIFI_MCP_HTTP_ENABLED=$(bashio::options 'http_enabled')
export UNIFI_AUTO_CONFIRM=$(bashio::options 'auto_confirm')
export UNIFI_TOOL_REGISTRATION_MODE=$(bashio::options 'tool_registration_mode')

# Optional: Filter tools by category
ENABLED_CATEGORIES=$(bashio::options 'enabled_categories')
if [ -n "$ENABLED_CATEGORIES" ]; then
    export UNIFI_ENABLED_CATEGORIES="$ENABLED_CATEGORIES"
fi

# Optional: Filter specific tools
ENABLED_TOOLS=$(bashio::options 'enabled_tools')
if [ -n "$ENABLED_TOOLS" ]; then
    export UNIFI_ENABLED_TOOLS="$ENABLED_TOOLS"
fi

# Set allowed hosts for reverse proxy support
export UNIFI_MCP_ALLOWED_HOSTS=$(bashio::options 'allowed_hosts')

# Map permissions to environment variables
export UNIFI_PERMISSIONS_CLIENTS_CREATE=$(bashio::options.permissions 'clients_create')
export UNIFI_PERMISSIONS_CLIENTS_DELETE=$(bashio::options.permissions 'clients_delete')
export UNIFI_PERMISSIONS_CLIENTS_UPDATE=$(bashio::options.permissions 'clients_update')
export UNIFI_PERMISSIONS_DEVICES_ADOPT=$(bashio::options.permissions 'devices_adopt')
export UNIFI_PERMISSIONS_DEVICES_REBOOT=$(bashio::options.permissions 'devices_reboot')
export UNIFI_PERMISSIONS_DEVICES_UPDATE=$(bashio::options.permissions 'devices_update')
export UNIFI_PERMISSIONS_DEVICES_UPGRADE=$(bashio::options.permissions 'devices_upgrade')
export UNIFI_PERMISSIONS_FIREWALLS_CREATE=$(bashio::options.permissions 'firewalls_create')
export UNIFI_PERMISSIONS_FIREWALLS_DELETE=$(bashio::options.permissions 'firewalls_delete')
export UNIFI_PERMISSIONS_FIREWALLS_UPDATE=$(bashio::options.permissions 'firewalls_update')
export UNIFI_PERMISSIONS_HOTSPOTS_CREATE=$(bashio::options.permissions 'hotspots_create')
export UNIFI_PERMISSIONS_HOTSPOTS_DELETE=$(bashio::options.permissions 'hotspots_delete')
export UNIFI_PERMISSIONS_HOTSPOTS_UPDATE=$(bashio::options.permissions 'hotspots_update')
export UNIFI_PERMISSIONS_NETWORKS_CREATE=$(bashio::options.permissions 'networks_create')
export UNIFI_PERMISSIONS_NETWORKS_DELETE=$(bashio::options.permissions 'networks_delete')
export UNIFI_PERMISSIONS_NETWORKS_UPDATE=$(bashio::options.permissions 'networks_update')
export UNIFI_PERMISSIONS_PORT_FORWARDS_CREATE=$(bashio::options.permissions 'port_forwards_create')
export UNIFI_PERMISSIONS_PORT_FORWARDS_DELETE=$(bashio::options.permissions 'port_forwards_delete')
export UNIFI_PERMISSIONS_PORT_FORWARDS_UPDATE=$(bashio::options.permissions 'port_forwards_update')
export UNIFI_PERMISSIONS_QOS_CREATE=$(bashio::options.permissions 'qos_create')
export UNIFI_PERMISSIONS_QOS_DELETE=$(bashio::options.permissions 'qos_delete')
export UNIFI_PERMISSIONS_QOS_UPDATE=$(bashio::options.permissions 'qos_update')
export UNIFI_PERMISSIONS_ROUTES_CREATE=$(bashio::options.permissions 'routes_create')
export UNIFI_PERMISSIONS_ROUTES_DELETE=$(bashio::options.permissions 'routes_delete')
export UNIFI_PERMISSIONS_ROUTES_UPDATE=$(bashio::options.permissions 'routes_update')
export UNIFI_PERMISSIONS_TRAFFIC_ROUTES_CREATE=$(bashio::options.permissions 'traffic_routes_create')
export UNIFI_PERMISSIONS_TRAFFIC_ROUTES_DELETE=$(bashio::options.permissions 'traffic_routes_delete')
export UNIFI_PERMISSIONS_TRAFFIC_ROUTES_UPDATE=$(bashio::options.permissions 'traffic_routes_update')
export UNIFI_PERMISSIONS_USERGROUPS_CREATE=$(bashio::options.permissions 'usergroups_create')
export UNIFI_PERMISSIONS_USERGROUPS_DELETE=$(bashio::options.permissions 'usergroups_delete')
export UNIFI_PERMISSIONS_USERGROUPS_UPDATE=$(bashio::options.permissions 'usergroups_update')
export UNIFI_PERMISSIONS_VPNS_CREATE=$(bashio::options.permissions 'vpns_create')
export UNIFI_PERMISSIONS_VPNS_DELETE=$(bashio::options.permissions 'vpns_delete')
export UNIFI_PERMISSIONS_VPNS_UPDATE=$(bashio::options.permissions 'vpns_update')
export UNIFI_PERMISSIONS_WLANS_CREATE=$(bashio::options.permissions 'wlans_create')
export UNIFI_PERMISSIONS_WLANS_DELETE=$(bashio::options.permissions 'wlans_delete')
export UNIFI_PERMISSIONS_WLANS_UPDATE=$(bashio::options.permissions 'wlans_update')

# Validate required fields
if [ -z "$UNIFI_HOST" ] || [ -z "$UNIFI_USERNAME" ] || [ -z "$UNIFI_PASSWORD" ]; then
    bashio::log.error "Required configuration missing: host, username, and password must be set"
    exit 1
fi

# Add uv bin to PATH
export PATH="/root/.local/bin:$PATH"

bashio::log.info "Starting UniFi Network MCP Server..."
bashio::log.info "Connecting to UniFi Controller at ${UNIFI_HOST}:${UNIFI_PORT}"

# Start the MCP server in stdio mode (default)
# The server will communicate over stdin/stdout for MCP protocol
exec unifi-network-mcp
