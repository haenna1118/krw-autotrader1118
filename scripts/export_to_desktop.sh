#!/usr/bin/env bash
set -euo pipefail

# export_to_desktop.sh
# Usage:
#  - To copy to a local host-mounted Desktop path set HOST_DESKTOP_PATH, e.g.
#      HOST_DESKTOP_PATH=/home/user/Desktop ./scripts/export_to_desktop.sh
#  - Or to copy to a remote host via scp set REMOTE_USER_HOST (user@host) and
#    optionally REMOTE_PORT.
#      REMOTE_USER_HOST=user@1.2.3.4 REMOTE_PORT=2222 ./scripts/export_to_desktop.sh

ZIP_PATH="/workspaces/krw-autotrader1118.zip"
REPO_DIR="/workspaces/krw-autotrader1118"

ensure_zip() {
  if [ -f "$ZIP_PATH" ]; then
    echo "Found existing $ZIP_PATH"
    return 0
  fi
  echo "Creating ZIP at $ZIP_PATH..."
  (cd "$REPO_DIR" && zip -r "$ZIP_PATH" .)
}

copy_to_local() {
  local dest="$1"
  if [ -d "$dest" ]; then
    echo "Copying $ZIP_PATH -> $dest/"
    cp "$ZIP_PATH" "$dest/"
    echo "Copied to $dest/"
    return 0
  else
    echo "Local destination not a directory: $dest" >&2
    return 1
  fi
}

copy_to_remote() {
  local remote="$1"
  local port_opt=""
  if [ -n "${REMOTE_PORT:-}" ]; then
    port_opt="-P ${REMOTE_PORT}"
  fi
  echo "Transferring $ZIP_PATH -> ${remote}:~/Desktop/"
  scp $port_opt "$ZIP_PATH" "${remote}:~/Desktop/"
}

main() {
  ensure_zip

  # 1) If HOST_DESKTOP_PATH provided and exists, copy there
  if [ -n "${HOST_DESKTOP_PATH:-}" ]; then
    if copy_to_local "$HOST_DESKTOP_PATH"; then
      exit 0
    fi
  fi

  # 2) If REMOTE_USER_HOST provided, try scp
  if [ -n "${REMOTE_USER_HOST:-}" ]; then
    copy_to_remote "$REMOTE_USER_HOST"
    exit 0
  fi

  # 3) No automatic destination available — print instructions
  cat <<'EOF'
No desktop destination configured.

Options:
  - Set HOST_DESKTOP_PATH to a host-mounted path (container can write there):
      HOST_DESKTOP_PATH=/home/you/Desktop ./scripts/export_to_desktop.sh

  - Or provide a remote host and optional port to scp to the remote Desktop:
      REMOTE_USER_HOST=user@host REMOTE_PORT=2222 ./scripts/export_to_desktop.sh

  - Or use VS Code Explorer to Download the file `/workspaces/krw-autotrader1118.zip`.
EOF
  exit 2
}

main "$@"
