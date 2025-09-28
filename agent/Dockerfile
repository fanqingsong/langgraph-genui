# 使用华为云镜像源
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/python:3.11-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# 配置 pip 使用国内镜像源
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \
    pip config set global.trusted-host mirrors.aliyun.com && \
    pip config set global.timeout 300 && \
    pip config set global.retries 5

# 配置 apt 使用国内镜像源
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装 Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# 复制项目文件
COPY pyproject.toml ./
COPY langgraph.json ./
COPY src/ ./src/

# 安装 Python 依赖（使用国内镜像源）
RUN pip install --no-cache-dir --timeout 300 --retries 5 -e . "langgraph-cli[inmem]==0.4.0"

# 暴露端口
EXPOSE 8123

# 启动命令
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "8123"]
