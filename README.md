# bioawk
Small compatibility-focused container for `bioawk`.

## Quick Usage

```bash
# Pull the image
docker pull docker.io/picotainers/bioawk:latest

# Run the tool
docker run --rm docker.io/picotainers/bioawk:latest bioawk --help
```

## How to use

```bash
docker run --rm -v "$(pwd):/data" docker.io/picotainers/bioawk:latest --help
```
