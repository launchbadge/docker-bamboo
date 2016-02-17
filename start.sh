#!/usr/bin/env bash
set -o errexit

# Create home (if not present)
mkdir -p $BAMBOO_HOME

# Start
$BAMBOO_INSTALL_DIR/bin/start-bamboo.sh -fg
