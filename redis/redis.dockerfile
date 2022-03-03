FROM redis:alpine

COPY config/sysctl.conf /etc/sysctl.conf
