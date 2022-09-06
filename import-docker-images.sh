#!/usr/bin/env bash
set -Eeuo pipefail

mkdir -p supabase-cache
cd supabase-cache

for FILENAME in *.tar.gz; do
  IMAGE=$(basename "$FILENAME" .tar.gz | base64 -d)
  echo "Importing image from $FILENAME as $IMAGE..."
  docker load -i "$FILENAME"
done

echo "Finished importing!"
