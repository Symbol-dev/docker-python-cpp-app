FROM ubuntu:18.04
LABEL maintainer="Teppei Fujisawa <fujisawa@symbol.company>"
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 LANGUAGE=C:en

RUN apt update -y && apt upgrade -y

RUN apt install -y python3 python3-pip python3-venv ca-certificates tar gzip curl

# use gcc 8 for full c++14 function
RUN apt install -y gcc-8 g++-8 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# update keyrings.alt for poetry bug
RUN pip install -U keyrings.alt

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
ENV PATH /root/.poetry/bin:$PATH

