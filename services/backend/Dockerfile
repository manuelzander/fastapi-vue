ARG VIRTUAL_ENV_PATH="/opt/build_venv"

FROM python:3.9-buster AS build
SHELL ["/bin/bash", "-o", "pipefail", "-o", "errexit", "-o", "nounset", "-o", "xtrace", "-c"]
ARG VIRTUAL_ENV_PATH

RUN python -m venv $VIRTUAL_ENV_PATH /opt/pip_venv ; \
    /opt/pip_venv/bin/pip install --upgrade --no-cache pip ; \
    /opt/pip_venv/bin/pip install --no-cache poetry

COPY pyproject.toml poetry.lock ./
RUN VIRTUAL_ENV="$VIRTUAL_ENV_PATH" /opt/pip_venv/bin/poetry install

FROM python:3.9-buster
SHELL ["/bin/bash", "-o", "pipefail", "-o", "errexit", "-o", "nounset", "-o", "xtrace", "-c"]
ARG VIRTUAL_ENV_PATH

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/home/manuel/app/src
ENV PATH="$VIRTUAL_ENV_PATH/bin:$PATH"

RUN  useradd --create-home --shell /bin/bash manuel

COPY --from=build "$VIRTUAL_ENV_PATH" "$VIRTUAL_ENV_PATH"
COPY --chown=manuel:manuel . /home/manuel/app

WORKDIR /home/manuel/app
USER manuel