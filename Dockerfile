FROM tensorflow/tensorflow:latest-gpu-jupyter

# timezone
ENV TZ=Asia/Shanghai

# install vim and openssh-server
RUN apt update && apt install -y vim openssh-server && apt clean

