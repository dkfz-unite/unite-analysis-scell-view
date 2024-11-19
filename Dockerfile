FROM python:3.10-slim AS base
EXPOSE 80
ENV FILE_PATH=data.h5ad

FROM base AS install
RUN apt-get update
RUN apt-get install -y build-essential
RUN pip install cellxgene

FROM install AS final
ENTRYPOINT cellxgene launch --backed --disable-diffexp --disable-annotations --host 0.0.0.0 --port 80 --title " " /data/${FILE_PATH}
