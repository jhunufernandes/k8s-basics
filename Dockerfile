
FROM python:3.11-alpine AS base

LABEL maintainer="Jhunu Fernandes jhunu.fernandes@gmail.com"

ENV SRC_PATH=/app

WORKDIR ${SRC_PATH}

COPY requirements.txt ${SRC_PATH}/requirements.txt

RUN apk add --no-cache build-base libffi-dev openssl-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del build-base libffi-dev openssl-dev

FROM base AS final

COPY /main.py ${SRC_PATH}/main.py

EXPOSE 80

ENTRYPOINT ["uvicorn"]

CMD ["main:app", "--host", "0.0.0.0", "--port", "80"]
