#!/usr/bin/env bash
set -Eeuo pipefail

mkdir -p docker-images-cache
cd docker-images-cache

for FILENAME in *.txt; do
  echo "Found marker file '$FILENAME'"
  IMAGE=$(basename "$FILENAME" .txt | base64 -d)
  echo "Importing image $IMAGE..."
  docker pull "localhost:46318/$IMAGE" || echo "ERROR while pulling localhost:46318/$IMAGE"
done

echo "Finished importing!"
