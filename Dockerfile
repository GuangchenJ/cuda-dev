FROM nvcr.io/nvidia/tensorrt:22.03-py3

ARG PREFIX=/usr/local

# env
ENV TZ=Asia/Shanghai \
    OPENCV_VERSION=4.5.5 \
    CMAKE_VERSION=3.23.0 \
    GRPC_VERSION=1.45.1

# Change timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Install some pkg
RUN apt update &&  \
    apt autoremove cmake && \
    hash -r && \
    apt upgrade && \
    apt install -y vim openssh-server cmake build-essential python3-pip unzip wget  git\
    openssl libssl-dev autoconf libtool pkg-config automake \
    libass-dev libfreetype6-dev libgnutls28-dev nasm libvpx-dev libfdk-aac-dev libopus-dev \
    libgtk-3-dev libgtk-3-dev  libmp3lame-dev libsdl2-dev libva-dev libvdpau-dev libvorbis-dev libxcb1-dev \
    libxcb-shm0-dev libxcb-xfixes0-dev meson ninja-build texinfo yasm libunistring-dev libaom-dev \
    libavcodec-dev  libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev  \
    libjpeg-dev libpng-dev libtiff-dev gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev zlib1g-dev \
    libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev && \
    apt autoclean

# Download, Compile and Install CMake
RUN mkdir /tmp/cmake && \
    cd /tmp/cmake && \
    wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz && \
    tar -zxf cmake-${CMAKE_VERSION}.tar.gz && \
    cd cmake-${CMAKE_VERSION} && \
    ./bootstrap && \
    make -j $(nproc) && \
    make install

# Download, Compile and Install OpenCV
RUN mkdir /tmp/opencv && \
    cd /tmp/opencv && \
    wget -q -O opencv.zip https://github.com/ls \
    opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip -q opencv.zip && \
    wget -q -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
    unzip -q opencv_contrib.zip && \
    mkdir /tmp/opencv/opencv-${OPENCV_VERSION}/build && cd /tmp/opencv/opencv-${OPENCV_VERSION}/build && \
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv/opencv_contrib-${OPENCV_VERSION}/modules \
#    -D WITH_FFMPEG=YES \
    -D INSTALL_C_EXAMPLES=NO \
    -D INSTALL_PYTHON_EXAMPLES=NO \
    -D BUILD_ANDROID_EXAMPLES=NO \
    -D BUILD_DOCS=NO \
    -D BUILD_TESTS=NO \
    -D BUILD_PERF_TESTS=NO \
    -D BUILD_EXAMPLES=NO \
    -D BUILD_opencv_java=NO \
    -D BUILD_opencv_python=NO \
    -D BUILD_opencv_python2=NO \
    -D BUILD_opencv_python3=NO \
    -D OPENCV_GENERATE_PKGCONFIG=YES .. && \
    make -j $(nproc) && \
    make install && \
    cd && rm -rf /tmp/opencv

# Download, Compile and Install gRPC C++
RUN export MY_INSTALL_DIR=/usr/local && \
    cd /tmp && \
    git clone --recurse-submodules -b v${GRPC_VERSION} --depth 1 --shallow-submodules https://github.com/grpc/grpc && \
    cd grpc && \
    mkdir -p cmake/build && \
    pushd cmake/build && \
    cmake -DgRPC_INSTALL=ON \
          -DgRPC_BUILD_TESTS=OFF \
          -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
          ../.. && \
    make -j $(nproc) && \
    make install && \
    popd && \
    cd && rm -rf /tmp/grpc
