#!/usr/bin/env bash

set -e

REPO_URL="$1"
TUNNEL_TOKEN="$2"

# Get the HA API token.
read -r HA_API_TOKEN < <(docker exec homeassistant printenv SUPERVISOR_TOKEN)

# Get the HA API IP address.
read -r HA_IP_ADDRESS < <(jq '.data.ip_address' --raw-output < <(ha supervisor info --raw-json))

# Define the HA API caller.
ha_api_call() {
  curl -sSL -H "Authorization: Bearer $HA_API_TOKEN" "${@:2}" "http://$HA_IP_ADDRESS/$1"
}

# Add the repo.
ha_api_call \
  store/repositories \
  -X POST \
  -d '{"repository": "'"$REPO_URL"'"}'

# Get the slug.
read -r HA_CLOUDFLARED_ID < <( \
  jq '.data.addons[] | select(.name == "Cloudflared") | .slug' --raw-output < <(ha_api_call store/addons) \
)

# Ensure installed.
ha_api_call \
  "store/addons/$HA_CLOUDFLARED_ID/install" \
  -X POST

# Configure.
ha_api_call \
  "addons/$HA_CLOUDFLARED_ID/options" \
  -X POST \
  -d '{"options": {"tunnel_token": "'"$TUNNEL_TOKEN"'", "external_hostname": "", "additional_hosts": []}}'

# Start (may exit non-zero).
jq -e 'select(.result == "ok")' < <(ha_api_call "addons/$HA_CLOUDFLARED_ID/restart" -X POST)
