# Unite Single Cell RNA Analysis Data Viewer

## General
The service is a custom Cell-x-Gene installation, configured to view created dataset in readonly mode.

The following list of predefined options apply:
- `--backed` - to save RAM, the dataset is loaded to memory only partially.
- `--disable-diffexp` - partial dataset load makes differential expression analysis very slow, so this option is disabled.
- `--disable-annotations` - annotations are provided externally, so this option is disabled.
- `--host 0.0.0.0` - portal is hosted on localhost, so it can be accessed outside container.

Service runs `launch` command by default, so the portal is in read mode by default.

## Configuration
To configure the application, change environment variables:
- `FILE_PATH` - Path to a dataset file to be opened (`data.h5ad`).

Service expects a folder with dataset file to be mounted to `/data` location in container, e.g.
```text
-v ./data:/data:rw
```

> [!NOTE]
> In case a different dataset has to be displayed, the service requires to be restarted or new instance to be created with new configuration.

## Installation

### Docker Compose
The easiest way to install the application is to use docker-compose:
- Environment configuration and installation scripts: https://github.com/dkfz-unite/unite-environment
- Single cell RNA analysis data viwer configuration and installation scripts: https://github.com/dkfz-unite/unite-environment/tree/main/applications/unite-analysis-scell-view

### Docker
[Dockerfile](Dockerfile) is used to build an image of the application.
To build an image run the following command:
```
docker build -t unite.analysis.scell.view:latest .
```

All application components should run in the same docker network.
To create common docker network if not yet available run the following command:
```bash
docker network create unite
```

To run application in docker run the following command:
```bash
docker run \
--name unite.analysis.scell.view \
--restart unless-stopped \
--net unite \
--net-alias view.scell.analysis.unite.net \
--rm \
-p 127.0.0.1:53022:80 \
-e ASPNETCORE_ENVIRONMENT=Release \
-e FILE_PATH=data.h5ad
-v ./data:/data:rw \
-d \
unite.analysis.scell.view:latest
```
