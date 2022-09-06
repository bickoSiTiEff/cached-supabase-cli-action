#!/usr/bin/env bash
set -Eeuo pipefail

EXISTING_IMAGES=$(cat existing-docker-containers.txt)

mkdir -p supabase-cache
cd supabase-cache

IMAGES=$(docker images --format="{{.Repository}}:{{.Tag}}")

for IMAGE in $IMAGES; do

  if grep -Fxq "$IMAGE" <(echo "$EXISTING_IMAGES"); then
    echo "Skipping image $IMAGE because it is builtin..."
    continue
  fi

  TARGET_FILE_NAME="$(echo "$IMAGE" | base64).tar.gz"

  if [ -f "$TARGET_FILE_NAME" ]; then
    echo "Skipping image $IMAGE because it is already exported..."
    continue
  fi

  echo "Exporting image $IMAGE..."
  docker save "$IMAGE" | pigz >"$TARGET_FILE_NAME"
  echo "Exported to $TARGET_FILE_NAME"

done
