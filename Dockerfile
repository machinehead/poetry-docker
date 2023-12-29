ARG PYTHON_IMAGE_TAG=3.11-slim

FROM python:${PYTHON_IMAGE_TAG} as base

ENV POETRY_HOME /opt/poetry
ENV PATH $POETRY_HOME/bin:$PATH

ARG POETRY_VERSION=1.7.1
ENV POETRY_VERSION=${POETRY_VERSION}

FROM base as poetry-installer

RUN apt-get update && apt-get install -y --no-install-recommends curl

RUN curl -sSL https://install.python-poetry.org | python3 - --version ${POETRY_VERSION}

FROM base as result

COPY --from=poetry-installer ${POETRY_HOME} ${POETRY_HOME}

# https://medium.com/@albertazzir/blazing-fast-python-docker-builds-with-poetry-a78a66f5aed0

# Using `poetry config` instead of env vars to verify that poetry is accessible.
# Having virtualenvs in the project dir isn't really compatible with live reload,
# 'cause mounting the project dir into the container will overwrite the virtualenvs.
# So we're using a separate dir for virtualenvs.
RUN poetry config virtualenvs.create true && \
    poetry config virtualenvs.in-project false && \
    poetry config virtualenvs.path /opt/virtualenvs

ENV POETRY_CACHE_DIR /tmp/poetry_cache
