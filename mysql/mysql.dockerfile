FROM mysql:5.7.33

RUN apt-get update \
    && apt-get install -y pv