FROM continuumio/miniconda3:24.3.0-0

WORKDIR /app

COPY ./environment.yml .

RUN conda env create -f ./environment.yml

COPY . .

WORKDIR /app/src
