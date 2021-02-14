#!/usr/bin/env bash
set -euo pipefail

echo "Updating themes.."
git submodule update --init

echo "Using hugo $(hugo version)"

echo "Building blog.."
exec hugo --config ipfs_config.yaml
