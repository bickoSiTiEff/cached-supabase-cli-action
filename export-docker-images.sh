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

  TARGET_FILE_NAME="$(echo "$IMAGE" | base64).txt"

  if [ -f "$TARGET_FILE_NAME" ]; then
    echo "Skipping image $IMAGE because it is already exported..."
    continue
  fi

  echo "Exporting image $IMAGE..."
  docker tag "$IMAGE" "localhost:46318/$IMAGE" || echo "ERROR while tagging localhost:46318/$IMAGE" # ignore errors
  docker push "localhost:46318/$IMAGE" || echo "ERROR while pushing localhost:46318/$IMAGE" # ignore errors
  touch "$TARGET_FILE_NAME"
  echo "Exported $IMAGE and marked as $TARGET_FILE_NAME"
done
