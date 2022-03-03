FROM redis:alpine

COPY config/sysctl.conf /etc/sysctl.conf

RUN sysctl -p