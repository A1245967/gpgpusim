FROM nvidia/cuda:11.0.3-cudnn8-devel-ubuntu18.04

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set default shell as bash
SHELL ["/bin/bash", "-c"]

# install gpgpusim dependencies
RUN apt update && \
    apt install -y git vim make wget && \
    apt install -y gcc-5 g++-5 && \
    apt install -y build-essential xutils-dev bison zlib1g-dev flex libglu1-mesa-dev && \
    apt install -y doxygen graphviz && \
    apt install -y python-pmw python-ply python-numpy libpng-dev python3-matplotlib && \
    apt install -y libxi-dev libxmu-dev freeglut3-dev && \
    apt clean

# set default gcc to gcc-5 instead of gcc-9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 5 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 5 && \
    update-alternatives --config gcc && \
    update-alternatives --config g++

ENV CUDA_INSTALL_PATH=/usr/local/cuda

# install gpgpusim
ENV GPGPUSIM_PATH=/opt/gpgpu-sim_distribution
RUN git clone https://github.com/gpgpu-sim/gpgpu-sim_distribution.git $GPGPUSIM_PATH && \
    cd $GPGPUSIM_PATH && \
    source setup_environment release && \
    make -j4


# set gpgpusim environment variable
ENV PTX_SIM_USE_PTX_FILE=1.ptx
ENV PTX_SIM_KERNELFILE=_1.ptx
ENV CUOBJDUMP_SIM_FILE=jj
ENV GPGPUSIM_CONFIG=gcc-5.5.0/cuda-11000/release
ENV QTINC=/usr/include
ENV LD_LIBRARY_PATH=$GPGPUSIM_PATH/lib/gcc-5.5.0/cuda-11000/release:$LD_LIBRARY_PATH
ENV GPGPUSIM_POWER_MODEL=$GPGPUSIM_PATH/src/gpuwattch/
ENV PTXAS_CUDA_INSTALL_PATH=$CUDA_INSTALL_PATH
