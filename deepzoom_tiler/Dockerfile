FROM     ubuntu:14.04
#FROM gcr.io/google_appengine/base
MAINTAINER William Clifford "bcliffor@systemsbiology.org"


### update
RUN apt-get -q update
RUN apt-get -q -y upgrade
#RUN apt-get -q -y dist-upgrade
#RUN apt-get -q -y install openssh-server

RUN apt-get -q -y install curl

RUN apt-get install lsb-release

#Install Cloud SDK
RUN apt-get remove google-cloud-sdk
RUN rm -rf /usr/lib/google-cloud-sdk
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get -q -y update && apt-get install -q -y google-cloud-sdk

RUN apt-get -q -y update && apt-get -q -y upgrade
RUN apt-get -q -y install gcc python-dev python-setuptools
RUN easy_install -U pip
RUN pip uninstall -y crcmod
RUN pip install -U crcmod

#Install openslide-python
RUN apt-get -q -y install openslide-tools
RUN pip install openslide-python

#RUN mkdir -p /usr/share/doc/python-openslide/examples/deepzoom/
#ADD ./openslide-python/examples/deepzoom/deepzoom_tile.py /usr/share/doc/python-openslide/examples/deepzoom/deepzoom_tile.py

RUN apt-get -q -y install git

RUN git clone https://github.com/bcli4d/openslide-python.git /usr/share/doc/python-openslide
RUN cd /usr/share/doc/python-openslide && git checkout fix_deepzoom_tile

CMD ["/bin/bash"]