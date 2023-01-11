# Upload Asset Docker Action

This action uploads a file as a release asset. Forked from [PeerXu/upload-asset](https://github.com/PeerXu/upload-asset),
and removed logic around generating the asset names. OS + Arch, and version customizations can be done via
matrix builds and/or other variables.

## Environments

### `GITHUB_TOKEN`

**Required** set `secrets.GITHUB_TOKEN` to `env.GITHUB_TOKEN`

## Inputs

### `file`

**Required** upload file to release asset

### `with_sha1`

upload file to asset with hash in sha1 algorithm

**Default** `true`

### Example usage

    uses: gfranks/upload-asset@v1
    with:
      file: path/to/asset
      with_sha1: true
    env:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
