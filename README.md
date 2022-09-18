# Supabase CLI Action

This action downloads and installs the Supabase CLI `supabase` binary into the PATH of a GitHub Actions runner.

It was also planned to implement caching for the required docker images.
However, this is currently disabled by default as it takes longer than just redownloading the images every time.

## Example

```yaml
name: Check migrations

on:
  push:

jobs:
  test:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - name: Setup Supabase CLI
        uses: bickoSiTiEff/setup-supabase-action@v1.0.0
        with:
          version: 1.4.6
      - name: Start project
        run: supabase start
      - name: Stop project
        run: supabase stop
```

## Parameters

Required:

* `version`: The version of the CLI to install. The `v` version prefix should **not** be included. Example: `version: 1.4.6`

Optional:

* `architecture`: The architecture of the server this action is running on. Currently there are only `amd64` and `arm64` binaries available. The default is `amd64`
* `use-dockerhub`: If this is set to `true` then an environment variable will be set to use Docker Hub instead of ECR. There are currently rate-limiting issues with using ECR in GitHub Actions. The default is `true`.
* `enable-binary-cache`: If this is set to `true` then the downloaded supabase binary will be cached using `actions/cache`. The default is `true`.
* `enable-docker-cache` If this is set to `true` then the downloaded docker images will be cached using `actions/cache`. This is currently very inefficient so the default is `false`.