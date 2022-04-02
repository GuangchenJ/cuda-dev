FROM nvcr.io/nvidia/tensorrt:22.03-py3 AS builder

# Timezone
ENV TZ=Asia/Shanghai
ENV OPENCV_VERSION=4.5.5

# Change timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Install vim and openssh-server
RUN apt update \
    && apt install -y cmake build-essential unzip wget libgtk-3-dev \
    && libgtk-3-dev  libavcodec-dev  libavformat-dev libswscale-dev libv4l-dev \
    && libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    && gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    && libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev \
    && libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
    && apt clean
RUN #wget https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz \
#    && tar -zxvf pkg-config-0.29.2.tar.gz \
#    && cd pkg-config-0.29.2/ \
#    && ./configure --with-internal-glib \
#    && make \
#    && make check \
#    && make install \
#    && cd .. \
#    && rm -rf pkg-config-0.29.2

RUN mkdir /tmp/opencv && \
    cd /tmp/opencv && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip opencv.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
    unzip opencv_contrib.zip && \
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

RUN apk del ${DEV_DEPS} && \
    rm -rf /var/cache/apk/*

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64
ENV CGO_CPPFLAGS -I/usr/local/include
ENV CGO_CXXFLAGS "--std=c++1z"
ENV CGO_LDFLAGS "-L/usr/local/lib -lopencv_core -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d -lopencv_plot -lopencv_tracking"


FROM nvcr.io/nvidia/tensorrt:22.03-py3

RUN #wget https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz \
#    && tar -zxvf pkg-config-0.29.2.tar.gz \
#    && cd pkg-config-0.29.2/ \
#    && ./configure --with-internal-glib \
#    && make \
#    && make check \
#    && make install \
#    && cd .. \
#    && rm -rf pkg-config-0.29.2

COPY --from=builder /usr/local/lib64 /usr/local/lib64
COPY --from=builder /usr/local/lib64/pkgconfig/opencv4.pc /usr/local/lib64/pkgconfig/opencv4.pc
COPY --from=builder /usr/local/include/opencv4/opencv2 /usr/local/include/opencv4/opencv2

# Install vim and openssh-server
RUN apt update  \
    && apt install -y vim openssh-server cmake build-essential python3-pip unzip wget libgtk-3-dev \
    && libgtk-3-dev  libavcodec-dev  libavformat-dev libswscale-dev libv4l-dev \
    && libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    && gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    && libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev \
    && libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
    && apt clean
