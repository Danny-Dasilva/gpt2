FROM nvidia/cuda:10.0-cudnn7-devel

ENV DEBIAN_FRONTEND=noninteractive


# python installation
ENV PYTHON_VERSION 3.7.1
ENV HOME /root
ENV PYTHON_ROOT $HOME/local/python-$PYTHON_VERSION
ENV PATH $PYTHON_ROOT/bin:$PATH
ENV PYENV_ROOT $HOME/.pyenv
RUN apt-get update && apt-get upgrade -y \
 && apt-get install -y \
    gdebi \
    nano \
    git \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    unzip \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
 && git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
 && $PYENV_ROOT/plugins/python-build/install.sh \
 && /usr/local/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT \
 && rm -rf $PYENV_ROOT

# cudnn reinstall
RUN apt remove --allow-change-held-packages -y libcudnn7 libcudnn7-dev
RUN wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7_7.5.0.56-1+cuda10.0_amd64.deb 
RUN wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7-dev_7.5.0.56-1+cuda10.0_amd64.deb 
RUN dpkg -i libcudnn7_7.5.0.56-1+cuda10.0_amd64.deb
RUN dpkg -i libcudnn7-dev_7.5.0.56-1+cuda10.0_amd64.deb

RUN pip install tensorflow-gpu==1.14
# change this to my repo
RUN cd /home && git clone https://github.com/Danny-Dasilva/gpt2.git
# install requirements
Run cd /home/gpt2 && pip3 install -r requirements.txt 
# tensorflow and object detection api installation


RUN python3 download_model.py 117M
# RUN python3 download_model.py 345M

WORKDIR /home/gpt2