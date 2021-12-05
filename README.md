<img src="https://github.com/captain-otter/yet-another-homepage/blob/main/docs/header.svg" width="100%" height="300px" alt="svg-header">

<hr>

<p align="center">
 <img src="https://github.com/captain-otter/yet-another-homepage/blob/main/docs/screenshot.png?raw=true" width="100%">
</p>

## Table of Contents
- [Features](#features)
- [Quick Start](#quick-start)
- [Configuration](docs/configuration.md)
- [Styling](docs/styling.md)
- [Development](docs/development.md)

## Features
- [yaml](http://yaml.org/) configuration file
- Search
- Application Grouping
- Bookmarks
- [CSS](https://www.w3schools.com/css/) Theme Customization

## Quick Start
### Using Docker
To start container:
```sh
docker run -d \
  -p 8080:8080 \
  -v </your/local/assets/>:/www/assets \
  --restart=always \
  ghcr.io/captain-otter/yet-another-homepage
```

### Using docker-compose
Add following to your docker-compose.yml file:
```yaml
yet-another-homepage:
    image: ghcr.io/captain-otter/yet-another-homepage:release
    container_name: yet-another-homepage
    volumes:
      - ${DATADIR}/appdata/yet-another-homepage/assets/:/www/assets
    environment:
     # Needed for files to have correct access rights. Remember to change to correct values.
      - UID=1000
      - GID=1000
    ports:
      - 8080:8080
    restart: unless-stopped
```
then run the container with:
```sh
docker-compose up -d
```