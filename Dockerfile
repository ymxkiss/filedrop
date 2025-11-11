# => Build container
FROM ubuntu:20.04 as build

# 解决Ubuntu交互提示问题，避免构建卡住
ENV DEBIAN_FRONTEND=noninteractive

# set version label
ARG BUILD_DATE
ARG VERSION
ARG VITE_APP_NAME

LABEL build_version="filedrop version: ${VERSION}, Build Date: ${BUILD_DATE}"

# 安装基础依赖（bash默认已存在，补充curl和证书用于安装Node.js）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    curl \
    ca-certificates && \
    # 清理apt缓存，减小镜像体积
    rm -rf /var/lib/apt/lists/*

# 安装Node.js 20.x（与原node:20-alpine版本匹配，确保corepack兼容性）
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    # 再次清理缓存
    rm -rf /var/lib/apt/lists/*

# 启用corepack（Node.js 20自带，需手动激活）
RUN corepack enable

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY . /app

# 执行构建及清理（移除原apk命令，依赖已通过apt安装）
RUN corepack yarn install && \
    corepack yarn build && \
    mv web/build web_build && \
    rm -rf web && \
    rm -rf node_modules && \
    corepack yarn cache clean && \
    rm -rf /root/.npm

# 重复安装及清理（保持原逻辑）
RUN corepack yarn install && \
    corepack yarn cache clean && \
    rm -rf /root/.npm

EXPOSE 5000

ENV WS_STATIC_ROOT ../web_build
CMD ["corepack", "yarn", "start:prod"]
