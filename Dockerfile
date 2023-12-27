FROM python:3.11

RUN apt update
RUN apt install -y pipx

# Instead of using `pipx ensurepath`, we just modify the PATH:
ENV PATH /root/.local/bin:$PATH

# TODO: pin poetry version
RUN pipx install poetry

# TODO: multistage build to not carry over apt/pipx

# RUN which poetry
# /root/.local/bin/poetry

# RUN ls -la /root/.local/bin
# drwxr-xr-x 2 root root 4096 Dec 27 19:02 .
# drwxr-xr-x 4 root root 4096 Dec 27 19:02 ..
# lrwxrwxrwx 1 root root   41 Dec 27 19:02 poetry -> /root/.local/pipx/venvs/poetry/bin/poetry

# RUN ls -la /root/.local/bin/poetry
# lrwxrwxrwx 1 root root 41 Dec 27 19:02 /root/.local/bin/poetry -> /root/.local/pipx/venvs/poetry/bin/poetry

# https://medium.com/@albertazzir/blazing-fast-python-docker-builds-with-poetry-a78a66f5aed0

# Using `poetry config` instead of env vars to verify that poetry is accessible
RUN poetry config virtualenvs.create true
