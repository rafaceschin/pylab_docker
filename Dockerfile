FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

#Base configuration for neurodebian
RUN apt-get update && apt-get install -y\
    wget\
    gnupg\ 
    python=2.7.15*\
    python-pip\
    ants=2.2.0*\
    graphviz=2.40.1*\
    liblapack-dev \
    gfortran \
    nodejs \ 
    npm \
# pip
    && pip install \
    wheel \
    numpy==1.13.3 \
    networkx==1.11 \
    traits==4.6.0 \
    nipy==0.4.2 \
    nipype==1.1.9 \
    matplotlib==2.1.1 \
    jupyter==1.0.0 \
    jupyterlab==0.33.12

RUN pip install \
    pymc==2.3.6 \ 
    && jupyter labextension install jupyterlab_vim \
    && rm -rf /var/lib/apt/lists/* 

EXPOSE 8888
RUN mkdir /.local && chmod -R 777 /.local

COPY . /app

# Command to run at startup
# run with: 
# docker run -it --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>
# Tip: Set up a bashrc function:
# function JLAB { docker run -it --user=$UID:$UID -p 8888:8888 -v $(pwd):/data <container_name>; }
WORKDIR /data
ENTRYPOINT ["/bin/bash", "/app/startup.sh"]
CMD [""]


