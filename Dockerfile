FROM nvidia/cuda:11.6.0-devel-ubuntu20.04

# timezone
ENV TZ Asia/Shanghai

# install vim and openssh-server
RUN apt update && apt install -y vim openssh-server && apt clean
