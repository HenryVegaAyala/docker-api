FROM mysql:5.7.33

RUN apt-get update
RUN apt-get install -y pv