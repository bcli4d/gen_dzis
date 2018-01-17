FROM     ubuntu:14.04
MAINTAINER WIlliam Clifford "bcliffor@systemsbiology.org"


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
#RUN gcloud init

#RUN apt-get -q -y install python2.7

#Install openslide-python
RUN apt-get -q -y install openslide-tools
RUN apt-get -q -y install python-openslide

