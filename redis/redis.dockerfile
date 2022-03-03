FROM redis:alpine

ADD config/sysctl.conf /etc/sysctl.conf
