FROM mysql:5.7.33 as mysql

RUN apt-get upgrade -y
RUN apt-get update
#RUN apt-get install -y pv