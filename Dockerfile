FROM golang:latest
MAINTAINER hteen <i@hteen.cn>

RUN apt-get update && apt-get install -y git make openssl

RUN git clone https://github.com/tutumcloud/ngrok.git /ngrok
RUN apt-get -ys clean

ADD *.sh /

ENV DOMAIN **None**
ENV MY_FILES /myfiles
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

EXPOSE 4443
EXPOSE 80
EXPOSE 443

CMD /bin/sh
