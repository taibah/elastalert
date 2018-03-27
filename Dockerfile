FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install build-essential python-setuptools python2.7 python2.7-dev libssl-dev git tox
RUN easy_install pip
RUN git clone https://github.com/Yelp/elastalert.git
RUN cd /elastalert/ && pip install -r requirements.txt
RUN pip install python-dateutil==2.6.0
RUN python setup.py install 
RUN apt -y remove git
RUN apt -y autoremove
RUN apt -y clean
RUN mkdir /etc/elastalert
RUN useradd -ms /bin/bash elastalert
RUN chown elastalert:elastalert /etc/elastalert
USER elastalert
STOPSIGNAL SIGTERM

CMD elastalert --verbose --config /etc/elastalert/config.yaml
