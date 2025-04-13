FROM debian:bookworm
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

# Update and install cross-platform build dependencies
RUN apt update && apt install -y \
    build-essential \
    cmake \
    file \
    gcc \
    gcc-aarch64-linux-gnu \
    gcc-mingw-w64-x86-64 \
    g++ \
    g++-aarch64-linux-gnu \
    g++-mingw-w64-x86-64 \
    libgsl-dev \
    libreadline6-dev \
    libsdl2-gfx-dev \
    libncurses5-dev \
    libwebp-dev \
    meson \
    mingw-w64 \
    mingw-w64-tools \
    xutils-dev \
    clang \
    llvm \
    libz-dev \
    curl \
    git \
    wget \
    zip \
    unzip \
    xz-utils

# Install osxcross dependencies for macOS cross-compilation
RUN apt install -y \
    libxml2-dev \
    libssl-dev \
    libbz2-dev \
    zlib1g-dev \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev

# Set C++11 as the standard for g++, MinGW, ARM64, and macOS
ENV CXXFLAGS="-std=c++11"
ENV CXXFLAGS_MINGW="-std=c++11"
ENV CXXFLAGS_AARCH64="-std=c++11"
ENV CXXFLAGS_MACOS="-std=c++11"

# Install other dependencies
RUN apt install -y make xterm sudo build-essential git zip curl valgrind clang-format

# bash as default
SHELL ["/bin/bash", "-c"]

ARG SDL_VERSION=2.30.11
ARG SDL_TTF_VERSION=2.22.0
ARG SDL_IMAGE_VERSION=2.8.2
ARG SDL_MIXER_VERSION=2.8.0
ARG SDL_NET_VERSION=2.2.0
ARG SDL3_VERSION=3.1.6

ADD fn.sh /
RUN source /fn.sh \
&& install_emsdk \
&& install_sdl1 \
&& install_sdl2 SDL2 ${SDL_VERSION} \
&& install_sdl2 SDL2_ttf ${SDL_TTF_VERSION} \
&& install_sdl2 SDL2_image ${SDL_IMAGE_VERSION} \
&& install_sdl2 SDL2_mixer ${SDL_MIXER_VERSION} \
&& install_sdl2 SDL2_net ${SDL_NET morir} \
&& install_sdl3 SDL3 ${SDL3_VERSION} \
&& install_sdl2_macos SDL2 ${SDL_VERSION} \
&& install_sdl2_macos SDL2_ttf ${SDL_TTF_VERSION} \
&& install_sdl2_macos SDL2_image ${SDL_IMAGE_VERSION} \
&& install_sdl2_macos SDL2_mixer ${SDL_MIXER_VERSION} \
&& install_sdl2_macos SDL2_net ${SDL_NET_VERSION} \
&& install_sdl3_macos SDL3 ${SDL3_VERSION}

EXPOSE 8080