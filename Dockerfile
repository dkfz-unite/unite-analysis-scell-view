FROM python:3.10-slim AS base

FROM base AS install
RUN apt-get update
RUN apt-get install -y build-essential
RUN pip install cellxgene

FROM install AS final
CMD ["cellxgene", "launch", "--backed", "--disable-diffexp", "--disable-annotations", "--host", "0.0.0.0", "--title", " ", "/data/result.h5ad"]
