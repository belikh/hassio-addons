#!/usr/bin/with-contenv bashio
set -e

# Map add-on options to environment variables
export UNIFI_HOST="${UNIFI_HOST:-$(bashio::options 'host' 2>/dev/null || echo '')}"
export UNIFI_USERNAME="${UNIFI_USERNAME:-$(bashio::options 'username' 2>/dev/null || echo '')}"
export UNIFI_PASSWORD="${UNIFI_PASSWORD:-$(bashio::options 'password' 2>/dev/null || echo '')}"
export UNIFI_PORT="${UNIFI_PORT:-$(bashio::options 'port' 2>/dev/null || echo '')}"
export UNIFI_SITE="${UNIFI_SITE:-$(bashio::options 'site' 2>/dev/null || echo '')}"
export UNIFI_VERIFY_SSL="${UNIFI_VERIFY_SSL:-$(bashio::options 'verify_ssl' 2>/dev/null || echo '')}"
export UNIFI_CONTROLLER_TYPE="${UNIFI_CONTROLLER_TYPE:-$(bashio::options 'controller_type' 2>/dev/null || echo '')}"
export UNIFI_MCP_HTTP_ENABLED="${UNIFI_MCP_HTTP_ENABLED:-$(bashio::options 'http_enabled' 2>/dev/null || echo '')}"
export UNIFI_AUTO_CONFIRM="${UNIFI_AUTO_CONFIRM:-$(bashio::options 'auto_confirm' 2>/dev/null || echo '')}"
export UNIFI_TOOL_REGISTRATION_MODE="${UNIFI_TOOL_REGISTRATION_MODE:-$(bashio::options 'tool_registration_mode' 2>/dev/null || echo '')}"

# Map enabled_categories and enabled_tools
UNIFI_ENABLED_CATEGORIES="${UNIFI_ENABLED_CATEGORIES:-$(bashio::options 'enabled_categories' 2>/dev/null || echo '')}"
UNIFI_ENABLED_TOOLS="${UNIFI_ENABLED_TOOLS:-$(bashio::options 'enabled_tools' 2>/dev/null || echo '')}"

if [ -n "$UNIFI_ENABLED_CATEGORIES" ]; then
    export UNIFI_ENABLED_CATEGORIES="$UNIFI_ENABLED_CATEGORIES"
fi

if [ -n "$UNIFI_ENABLED_TOOLS" ]; then
    export UNIFI_ENABLED_TOOLS="$UNIFI_ENABLED_TOOLS"
fi

# Map allowed_hosts
UNIFI_ALLOWED_HOSTS="${UNIFI_ALLOWED_HOSTS:-$(bashio::options 'allowed_hosts' 2>/dev/null || echo '')}"

if [ -n "$UNIFI_ALLOWED_HOSTS" ]; then
    export UNIFI_MCP_ALLOWED_HOSTS="$UNIFI_ALLOWED_HOSTS"
fi

# Map permissions to environment variables
export UNIFI_PERMISSIONS_CLIENTS_CREATE="${UNIFI_PERMISSIONS_CLIENTS_CREATE:-$(bashio::options.permissions 'clients_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_CLIENTS_DELETE="${UNIFI_PERMISSIONS_CLIENTS_DELETE:-$(bashio::options.permissions 'clients_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_CLIENTS_UPDATE="${UNIFI_PERMISSIONS_CLIENTS_UPDATE:-$(bashio::options.permissions 'clients_update' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_CLIENTS_RECONNECT="${UNIFI_PERMISSIONS_CLIENTS_RECONNECT:-$(bashio::options.permissions 'clients_reconnect' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_DEVICES_ADOPT="${UNIFI_PERMISSIONS_DEVICES_ADOPT:-$(bashio::options.permissions 'devices_adopt' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_DEVICES_REBOOT="${UNIFI_PERMISSIONS_DEVICES_REBOOT:-$(bashio::options.permissions 'devices_reboot' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_DEVICES_RENAME="${UNIFI_PERMISSIONS_DEVICES_RENAME:-$(bashio::options.permissions 'devices_rename' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_DEVICES_UPGRADE="${UNIFI_PERMISSIONS_DEVICES_UPGRADE:-$(bashio::options.permissions 'devices_upgrade' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_FIREWALLS_CREATE="${UNIFI_PERMISSIONS_FIREWALLS_CREATE:-$(bashio::options.permissions 'firewalls_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_FIREWALLS_DELETE="${UNIFI_PERMISSIONS_FIREWALLS_DELETE:-$(bashio::options.permissions 'firewalls_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_FIREWALLS_UPDATE="${UNIFI_PERMISSIONS_FIREWALLS_UPDATE:-$(bashio::options.permissions 'firewalls_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_HOTSPOTS_CREATE="${UNIFI_PERMISSIONS_HOTSPOTS_CREATE:-$(bashio::options.permissions 'hotspots_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_HOTSPOTS_DELETE="${UNIFI_PERMISSIONS_HOTSPOTS_DELETE:-$(bashio::options.permissions 'hotspots_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_HOTSPOTS_UPDATE="${UNIFI_PERMISSIONS_HOTSPOTS_UPDATE:-$(bashio::options.permissions 'hotspots_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_NETWORKS_CREATE="${UNIFI_PERMISSIONS_NETWORKS_CREATE:-$(bashio::options.permissions 'networks_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_NETWORKS_DELETE="${UNIFI_PERMISSIONS_NETWORKS_DELETE:-$(bashio::options.permissions 'networks_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_NETWORKS_UPDATE="${UNIFI_PERMISSIONS_NETWORKS_UPDATE:-$(bashio::options.permissions 'networks_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_PORT_FORWARDS_CREATE="${UNIFI_PERMISSIONS_PORT_FORWARDS_CREATE:-$(bashio::options.permissions 'port_forwards_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_PORT_FORWARDS_DELETE="${UNIFI_PERMISSIONS_PORT_FORWARDS_DELETE:-$(bashio::options.permissions 'port_forwards_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_PORT_FORWARDS_UPDATE="${UNIFI_PERMISSIONS_PORT_FORWARDS_UPDATE:-$(bashio::options.permissions 'port_forwards_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_QOS_CREATE="${UNIFI_PERMISSIONS_QOS_CREATE:-$(bashio::options.permissions 'qos_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_QOS_DELETE="${UNIFI_PERMISSIONS_QOS_DELETE:-$(bashio::options.permissions 'qos_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_QOS_UPDATE="${UNIFI_PERMISSIONS_QOS_UPDATE:-$(bashio::options.permissions 'qos_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_ROUTES_CREATE="${UNIFI_PERMISSIONS_ROUTES_CREATE:-$(bashio::options.permissions 'routes_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_ROUTES_DELETE="${UNIFI_PERMISSIONS_ROUTES_DELETE:-$(bashio::options.permissions 'routes_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_ROUTES_UPDATE="${UNIFI_PERMISSIONS_ROUTES_UPDATE:-$(bashio::options.permissions 'routes_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_TRAFFIC_ROUTES_CREATE="${UNIFI_PERMISSIONS_TRAFFIC_ROUTES_CREATE:-$(bashio::options.permissions 'traffic_routes_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_TRAFFIC_ROUTES_DELETE="${UNIFI_PERMISSIONS_TRAFFIC_ROUTES_DELETE:-$(bashio::options.permissions 'traffic_routes_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_TRAFFIC_ROUTES_UPDATE="${UNIFI_PERMISSIONS_TRAFFIC_ROUTES_UPDATE:-$(bashio::options.permissions 'traffic_routes_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_USERGROUPS_CREATE="${UNIFI_PERMISSIONS_USERGROUPS_CREATE:-$(bashio::options.permissions 'usergroups_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_USERGROUPS_DELETE="${UNIFI_PERMISSIONS_USERGROUPS_DELETE:-$(bashio::options.permissions 'usergroups_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_USERGROUPS_UPDATE="${UNIFI_PERMISSIONS_USERGROUPS_UPDATE:-$(bashio::options.permissions 'usergroups_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_VPNS_CREATE="${UNIFI_PERMISSIONS_VPNS_CREATE:-$(bashio::options.permissions 'vpns_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_VPNS_DELETE="${UNIFI_PERMISSIONS_VPNS_DELETE:-$(bashio::options.permissions 'vpns_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_VPNS_UPDATE="${UNIFI_PERMISSIONS_VPNS_UPDATE:-$(bashio::options.permissions 'vpns_update' 2>/dev/null || echo '')}"

export UNIFI_PERMISSIONS_WLANS_CREATE="${UNIFI_PERMISSIONS_WLANS_CREATE:-$(bashio::options.permissions 'wlans_create' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_WLANS_DELETE="${UNIFI_PERMISSIONS_WLANS_DELETE:-$(bashio::options.permissions 'wlans_delete' 2>/dev/null || echo '')}"
export UNIFI_PERMISSIONS_WLANS_UPDATE="${UNIFI_PERMISSIONS_WLANS_UPDATE:-$(bashio::options.permissions 'wlans_update' 2>/dev/null || echo '')}"

# Validate required fields
if [ -z "$UNIFI_HOST" ] || [ -z "$UNIFI_USERNAME" ] || [ -z "$UNIFI_PASSWORD" ]; then
    bashio::log.error "Required configuration missing: host, username, and password must be set"
    exit 1
fi

# Log startup info
bashio::log.info "Starting UniFi Network MCP Server..."
bashio::log.info "Connecting to UniFi Controller at ${UNIFI_HOST}:${UNIFI_PORT}"

# Start the MCP server in stdio mode (default)
# The server communicates over stdin/stdout using MCP protocol
exec unifi-network-mcp
