# build with `docker build -t localethereum/client-python .`
FROM python:2.7.11

RUN apt-get update && \
    apt-get install -y build-essential automake pkg-config libtool libffi-dev libgmp-dev

WORKDIR /app

RUN git clone https://github.com/ethereum/pydevp2p.git --branch develop pydevp2p && \
    git clone https://github.com/ethereum/pyethapp.git --branch develop pyethapp && \
    git clone https://github.com/ethereum/pyethereum.git --branch develop pyethereum && \
    git clone https://github.com/ethereum/sharding.git --branch develop sharding

RUN cd pydevp2p && \
    python setup.py install

RUN cd pyethereum && \
    git submodule init && \
    git submodule update --recursive

RUN cd sharding && \
    pip install -r requirements.txt

RUN cd pyethapp && \
    pip install -e .


ENTRYPOINT ["/usr/local/bin/pyethapp"]
