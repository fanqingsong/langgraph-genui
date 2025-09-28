# LangGraph Weather Agent Docker 部署指南

本项目提供了多种部署方式，适应不同的网络环境和需求。

## 🚀 快速开始

### 方式一：Docker Compose 部署（推荐）

```bash
# 一键启动（使用阿里云镜像源）
./start.sh

# 使用不同镜像源
./start.sh start aliyun    # 阿里云镜像源
./start.sh start tencent   # 腾讯云镜像源
./start.sh start huawei    # 华为云镜像源
./start.sh start official  # 官方镜像源
./start.sh start local     # 本地构建模式

# 管理服务
./start.sh stop            # 停止服务
./start.sh restart         # 重启服务
./start.sh logs            # 查看日志
./start.sh status          # 查看状态
./start.sh help            # 显示帮助
```

### 方式二：本地 Python 环境部署

如果网络环境受限，无法拉取 Docker 镜像，可以使用本地 Python 环境：

```bash
# 使用本地 Python 环境启动
./start-local.sh

# 查看帮助
./start-local.sh help
```

## 📁 文件说明

### Docker 相关文件

- `Dockerfile` - 主 Dockerfile，使用阿里云镜像源
- `Dockerfile.alternative` - 备用 Dockerfile，使用腾讯云镜像源
- `docker-compose.yml` - 标准 Docker Compose 配置
- `docker-compose.local.yml` - 本地构建模式配置
- `.dockerignore` - Docker 构建忽略文件

### 启动脚本

- `start.sh` - 主启动脚本，支持多种镜像源和模式
- `start-local.sh` - 本地 Python 环境启动脚本

### 配置文件

- `env.template` - 环境变量模板
- `.env` - 环境变量文件（自动生成）

## 🔧 配置说明

### 环境变量

创建 `.env` 文件（或从 `env.template` 复制）：

```bash
# LangSmith 配置（可选）
LANGSMITH_API_KEY=lsv2_your_api_key_here
LANGSMITH_PROJECT=langgraph-weather-agent

# 应用配置
LANGGRAPH_HOST=0.0.0.0
LANGGRAPH_PORT=8123
LANGGRAPH_DEV=true
```

### 端口配置

默认端口：`8123`

如需修改端口，请同时更新：
1. `docker-compose.yml` 中的端口映射
2. `.env` 文件中的 `LANGGRAPH_PORT`
3. 启动脚本中的端口说明

## 🌐 访问应用

启动成功后，在浏览器中访问：

- **应用地址**: http://localhost:8123
- **LangGraph Studio**: http://localhost:8123

## 🐛 故障排除

### 网络连接问题

如果遇到镜像拉取超时：

1. **使用本地构建模式**：
   ```bash
   ./start.sh start local
   ```

2. **使用本地 Python 环境**：
   ```bash
   ./start-local.sh
   ```

3. **配置 Docker 镜像加速器**：
   ```bash
   # 创建或编辑 ~/.docker/daemon.json
   {
     "registry-mirrors": [
       "https://registry.cn-hangzhou.aliyuncs.com",
       "https://hub-mirror.c.163.com",
       "https://mirror.baidubce.com"
     ]
   }
   ```

### 权限问题

确保脚本有执行权限：

```bash
chmod +x start.sh start-local.sh
```

### 端口冲突

如果端口 8123 被占用：

1. 修改 `docker-compose.yml` 中的端口映射
2. 更新 `.env` 文件中的端口配置
3. 重启服务

### 查看详细日志

```bash
# Docker 模式
./start.sh logs

# 本地模式
# 日志直接显示在终端
```

## 📝 开发说明

### 热重载开发

Docker 配置已支持热重载，修改源代码后会自动重新加载。

### 添加新功能

1. 修改 `src/agent/graph.py` 添加新的节点
2. 更新 `src/agent/ui.tsx` 添加新的 UI 组件
3. 在 `langgraph.json` 中注册新的 UI 组件

### 测试

```bash
# 运行单元测试
make test

# 运行集成测试
make integration_tests
```

## 🔄 更新和维护

### 更新依赖

```bash
# 停止服务
./start.sh stop

# 重新构建
docker compose build --no-cache

# 启动服务
./start.sh
```

### 清理资源

```bash
# 停止并删除容器
./start.sh stop

# 删除镜像（可选）
docker rmi langgraph-genui-langgraph-app

# 清理未使用的资源
docker system prune
```

## 📞 支持

如果遇到问题，请检查：

1. Docker 和 Docker Compose 是否正确安装
2. 网络连接是否正常
3. 端口 8123 是否被占用
4. 查看详细日志信息

更多信息请参考 [LangGraph 官方文档](https://langchain-ai.github.io/langgraph/)。
