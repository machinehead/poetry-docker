FROM python:3.11 as poetry-installer

RUN apt update
RUN apt install -y pipx

# Instead of using `pipx ensurepath`, we just modify the PATH:
ENV PATH /root/.local/bin:$PATH

RUN pipx install poetry==1.7.1

FROM python:3.11 as result

COPY --from=poetry-installer /root/.local /root/.local
# Path to poetry binary installed by pipx:
ENV PATH /root/.local/bin:$PATH

# https://medium.com/@albertazzir/blazing-fast-python-docker-builds-with-poetry-a78a66f5aed0

# Using `poetry config` instead of env vars to verify that poetry is accessible
RUN poetry config virtualenvs.create true && \
    poetry config virtualenvs.in-project true
