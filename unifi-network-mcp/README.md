# UniFi Network MCP Server Add-on for Home Assistant

[![Open your Home Assistant instance and show the add-on repository dialog with this repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbelikh%2Fhassio-addons)

This add-on runs to [UniFi Network MCP Server](https://github.com/sirkirby/unifi-network-mcp) in Home Assistant OS. It exposes your UniFi Network Controller as a set of MCP tools that can be used by LLMs (like Claude Desktop) or other MCP-compatible clients.

## Features

- Full MCP server implementation for UniFi Network Controller
- Access to 80+ UniFi tools including:
  - **Devices**: List, reboot, rename, adopt, upgrade devices
  - **Clients**: List, block, unblock, rename, and manage clients
  - **Networks**: List and manage network configurations
  - **WLANs**: List and manage wireless networks
  - **Firewall**: List and manage firewall rules
  - **Port Forwarding**: List and manage port forwards
  - **QoS**: List and manage traffic shaping rules
  - **VPN**: List and manage VPN servers and clients
  - **Statistics**: Get network, client, and device stats
  - **Events**: List events and alarms
- Configurable permissions to enable/disable mutating operations
- Support for UniFi OS and standalone controllers
- Context-optimized tool loading (lazy mode by default)

## Installation

1. Create a folder `addons/unifi-network-mcp` in your Home Assistant configuration directory
2. Place all add-on files in that folder
3. In Home Assistant, go to **Settings** → **Add-ons** → **Add-ons Store**
4. Click to three dots in the top right → **Install add-on from repository**
5. Navigate to your addons folder and select `unifi-network-mcp`
6. Click **Install**

## Configuration

### Required Settings

| Option | Description |
|---------|-------------|
| **Host** | IP address or hostname of your UniFi Controller |
| **Username** | Admin username for the controller |
| **Password** | Admin password for the controller |

### Optional Settings

| Option | Description | Default |
|---------|-------------|----------|
| **Port** | HTTPS port of the controller | 443 |
| **Site** | Site name (UniFi multi-site) | default |
| **Verify SSL** | Verify SSL certificate | false |
| **Controller Type** | `auto`, `proxy` (UniFi OS), or `direct` (standalone) | auto |
| **HTTP Enabled** | Enable optional HTTP SSE endpoint | false |
| **Auto Confirm** | Skip confirmation for mutating operations (automation use) | false |
| **Tool Registration Mode** | `lazy`, `eager`, or `meta_only` | lazy |

### Tool Filtering

- **Enabled Categories**: Comma-separated list of categories to load (e.g., `clients,devices,stats`)
- **Enabled Tools**: Comma-separated list of specific tools to register

### Permissions

By default, all high-risk operations are disabled for safety. You can enable specific permissions:

| Category | Permissions | Default |
|----------|-------------|----------|
| **Clients** | Create, Delete, Update, Reconnect | Off |
| **Devices** | Adopt, Reboot, Rename, Upgrade | Off |
| **Firewalls** | Create, Delete, Update | Create/Update On |
| **Hotspots** | Create, Delete, Update | Create/Update On |
| **Networks** | Create, Delete, Update | Off |
| **Port Forwards** | Create, Delete, Update | Create/Update On |
| **QoS** | Create, Delete, Update | Create/Update On |
| **Routes** | Create, Delete, Update | Off |
| **Traffic Routes** | Create, Delete, Update | Off |
| **User Groups** | Create, Delete, Update | Create/Update On |
| **VPNs** | Create, Delete, Update | Off |
| **WLANs** | Create, Delete, Update | Off |

⚠️ **Security Note**: Only enable permissions you actually need. Read-only operations are always available.

## Usage

### With Claude Desktop

1. Install and start this add-on
2. Open Claude Desktop settings
3. Edit your MCP server configuration:

```json
{
  "mcpServers": {
    "unifi-network-mcp": {
      "command": "docker",
      "args": [
        "exec",
        "-i",
        "addon_unifi_network_mcp",
        "unifi-network-mcp"
      ],
      "env": {
        "UNIFI_HOST": "192.168.1.1",
        "UNIFI_USERNAME": "admin",
        "UNIFI_PASSWORD": "your-password"
      }
    }
  }
}
```

4. Restart Claude Desktop
5. Start a conversation: "Show me all UniFi devices" or "List my top 5 clients by bandwidth"

### With mcporter

If you're using [mcporter](https://mcporter.dev) (as in your Home Assistant setup):

```bash
# Configure local MCP server
mcporter config add unifi-mcp "stdio" \
  --command "docker exec -i addon_unifi_network_mcp unifi-network-mcp"

# List available tools
mcporter list unifi-mcp --schema

# Call a tool
mcporter call unifi-mcp.unifi_list_devices
```

## Add-on Files

- `config.json` - Add-on configuration schema
- `Dockerfile` - Container build instructions
- `run.sh` - Entry point script
- `README.md` - This file

## Security Considerations

- This add-on gives LLMs access to your UniFi Controller
- **Do not** enable HTTP mode unless running behind a secure reverse proxy
- Keep permissions minimal - only enable what you need
- Use read-only tools by default for analysis
- Mutating operations require confirmation (unless `auto_confirm` is enabled)
- For automation workflows, set `auto_confirm: true` but be extra careful

## Troubleshooting

### Connection Issues

- Verify controller IP and credentials
- Try setting `controller_type` explicitly: `proxy` for UniFi OS, `direct` for standalone
- Check firewall allows access from Home Assistant to controller

### Permission Errors

- High-risk operations are disabled by default
- Enable specific permissions in the add-on configuration
- Restart the add-on after changing permissions

### Add-on Won't Start

- Check logs: **Add-ons** → **UniFi Network MCP Server** → **Log**
- Ensure host, username, and password are set
- Verify network connectivity to UniFi Controller

## License

MIT License - Based on [unifi-network-mcp](https://github.com/sirkirby/unifi-network-mcp) by @sirkirby

## Support

- [UniFi Network MCP GitHub](https://github.com/sirkirby/unifi-network-mcp)
- [MCP Documentation](https://modelcontextprotocol.io)
