FROM ubuntu:focal

ARG FUNCTION_DIR="/app"

RUN apt-get update \
&& apt-get install -y lsb-release wget gnupg python3 python3-pip \
&& sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
&& wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
&& apt-get update \
&& apt-get install -y postgresql-client-11

WORKDIR ${FUNCTION_DIR}

COPY app/* ${FUNCTION_DIR}/

RUN pip install --target ${FUNCTION_DIR} awslambdaric
RUN pip install -r requirements.txt

ENTRYPOINT [ "/usr/bin/python3", "-m", "awslambdaric" ]
CMD [ "app.handler" ]