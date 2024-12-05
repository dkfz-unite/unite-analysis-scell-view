FROM python:3.10-slim AS base
EXPOSE 80
EXPOSE 443
ENV FILE_PATH=data.h5ad

FROM base AS install
RUN apt-get update
RUN apt-get install -y build-essential nginx
RUN pip install --no-cache-dir cellxgene
COPY ./nginx.conf /etc/nginx/sites-available/default

FROM install AS final
CMD service nginx start && cellxgene launch --backed --disable-diffexp --disable-annotations --title " " /data/${FILE_PATH}
# ENTRYPOINT cellxgene launch --backed --disable-diffexp --disable-annotations --host 0.0.0.0 --port 80 --title " " /data/${FILE_PATH}
