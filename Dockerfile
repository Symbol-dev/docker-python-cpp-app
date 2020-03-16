FROM ubuntu:18.04
LABEL maintainer="Teppei Fujisawa <fujisawa@symbol.company>, Hayashi Toshiaki <hayashi@symbol.company>"
ENV DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 LANG=C.UTF-8 LANGUAGE=C:en
SHELL ["/bin/bash", "-c"]

RUN apt update && apt install --no-install-recommends -y gcc-8 g++-8 && rm -rf /var/lib/apt/lists/
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8

RUN apt update && apt install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN curl https://pyenv.run | bash
ENV PATH /root/.pyenv/shims:/root/.pyenv/bin:$PATH

ENV PYTHON_VERSION 3.6.10
RUN pyenv install ${PYTHON_VERSION}
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
RUN pyenv global ${PYTHON_VERSION}
RUN pyenv local ${PYTHON_VERSION}

# Upgrade pip
ENV PIP_MAJOR_VERSION 20.0.0
RUN pip install --upgrade pip~=${PIP_MAJOR_VERSION}

ENTRYPOINT ["bash"]
