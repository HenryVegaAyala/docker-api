FROM mysql:5.7.33

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y pv