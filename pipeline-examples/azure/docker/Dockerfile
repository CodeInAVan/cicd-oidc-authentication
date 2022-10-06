FROM python:3-alpine

# versions to install
ARG TUVOK_VERSION=v0.1.4

# pre-reqs for toolbox & tuvok
RUN apk --update add bash git openssh openssl curl wget py-pip jq
#RUN wget https://github.com/rackspace-infrastructure-automation/tfenv/archive/v0.6.0.zip -O - | unzip -d /var/opt - \
#  && chmod +x /var/opt/tfenv-0.6.0/bin/* /var/opt/tfenv-0.6.0/libexec/* \
#  && ln -s /var/opt/tfenv-0.6.0/bin/* /usr/local/bin

# # awscli
# RUN pip install --upgrade pip && pip install --progress-bar=off awscli

# install tuvok
RUN pip install git+https://github.com/rackerlabs/tuvok.git@$TUVOK_VERSION
# RUN pip install azure-identity==1.10.0
# RUN pip install azure-keyvault==4.2.0
RUN pip install python-terraform==0.10.1
# RUN pip install azure-storage-blob==12.13.1

# az cli
# RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev cargo make
# RUN pip install --upgrade pip
# RUN pip install azure-cli

# # gcp cli
# RUN curl -sSL https://sdk.cloud.google.com > /tmp/gcl && bash /tmp/gcl --install-dir=~/gcloud --disable-prompts
# ENV PATH $PATH:/root/gcloud/google-cloud-sdk/bin

# tfenv
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git /var/opt/tfenv \
  && chmod +x /var/opt/tfenv/bin/* /var/opt/tfenv/libexec/* \
  && ln -s /var/opt/tfenv/bin/* /usr/local/bin

# recent terraform versions
RUN tfenv install 1.3.1
#RUN tfenv install 0.14.11
#RUN tfenv install 0.13.7
#RUN tfenv install 0.12.31
#RUN tfenv install 0.11.14
#RUN tfenv install 0.11.8
#RUN tfenv install 0.11.7

RUN tfenv use 1.3.1
#RUN tfenv use 0.11.8

# scripts from toolbox
COPY ./bin/* /rackspace/
#RUN ln -s /var/opt/rackspace/bin/* /usr/local/bin/
WORKDIR /rackspace