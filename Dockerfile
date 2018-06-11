FROM arm32v7/ubuntu:xenial
MAINTAINER Fabio Magalhaes<fabio.magalhaes@gmail.com>

ENV PYTHONPATH /opt/movidius/mvnc/python:${PYTHONPATH}
ARG TF_VERSION
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y python-pip
RUN apt-get install -y wget
RUN apt-get install -y sudo
RUN apt-get install -y nano
RUN apt-get install -y lsb-release
RUN apt-get install -y python3-pip
RUN apt-get install -y udev

RUN git clone https://github.com/movidius/ncsdk.git /ncsdk
RUN git clone https://github.com/movidius/ncappzoo.git /ncappzoo

RUN pip install --upgrade pip
#RUN pip install tensorflow-gpu==1.4.1
RUN pip3 install --upgrade pip
#RUN pip3 install opencv-python
#RUN pip3 install opencv-contrib-python

#TESTAR DEPOIS
#VER SE EXISTEM DEPENDÊNCIAS
#RUN curl -O https://ci.tensorflow.org/view/Nightly/job/nightly-pi-python3/92/artifact/output-artifacts/tensorflow-1.4.0-cp34-none-any.whl
#RUN mv tensorflow-1.4.0-cp34-none-any.whl tensorflow-1.4.0-cp35-none-any.whl
#RUN pip3 install tensorflow-1.4.0-cp35-none-any.whl
#RUN rm tensorflow-1.4.0-cp35-none-any.whl

WORKDIR /ncsdk

#RUN apt-get install dialog
#RUN export TERM=linux && make install
RUN make install
#RUN make examples

# Go to NCSDK root
#WORKDIR /
#RUN git clone https://github.com/tensorflow/tensorflow.git tf-${TF_VERSION}
#RUN git clone https://github.com/tensorflow/models.git tf-models
#RUN cd tf-${TF_VERSION} && git checkout ${TF_VERSION} && cd ..
#ENV TF_SRC_PATH=/tf-${TF_VERSION}
#ENV TF_MODELS_PATH=/tf-models

# we only check with tensorflow example
#WORKDIR /ncappzoo/tensorflow
WORKDIR /ncappzoo/apps
#RUN make

ENV CCACHE_CPP2=1
ENV CCACHE_MAXSIZE=1G
ENV DISPLAY :0
#ENV PATH "/usr/lib/ccache:$PATH"
ENV TERM=xterm
# Some QT-Apps/Gazebo don't not show controls without this
ENV QT_X11_NO_MITSHM 1

CMD ["bash"]
