FROM c3h3/r-nlp:crawlers-sftp

MAINTAINER Chia-Chi Chang <c3h3.tw@gmail.com>

RUN apt-get update && \
    apt-get install -y libmysqlclient-dev

RUN mkdir /BeATradeR 
ADD . /BeATradeR
RUN cd /BeATradeR && Rscript installPackages.R

WORKDIR /BeATradeR

RUN chmod 777 -R /BeATradeR

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

