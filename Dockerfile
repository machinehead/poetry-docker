FROM python:3.11

RUN apt update
RUN apt install -y pipx
RUN pipx ensurepath

RUN pipx install poetry
