#!/usr/bin/env bash
set -Eeuo pipefail

mkdir -p supabase-cache
cd supabase-cache

IMAGES=$(docker images --format="{{.Repository}}:{{.Tag}}")

for IMAGE in $IMAGES; do
  echo "Exporting image $IMAGE..."
  TARGET_FILE_NAME="$(echo "$IMAGE" | base64).tar.gz"
  docker save "$IMAGE" | pigz >"$TARGET_FILE_NAME"
  echo "Exported to $TARGET_FILE_NAME"
done
