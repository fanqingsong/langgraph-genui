# LangGraph GenUI 微服务架构

这是一个基于 LangGraph 的微服务架构项目，包含智能体服务和前端对话界面两个独立的微服务。

## 项目结构

```
langgraph-genui/
├── agent/                    # 智能体微服务
│   ├── src/                 # 智能体源代码
│   ├── langgraph.json       # LangGraph 配置
│   ├── pyproject.toml       # Python 项目配置
│   ├── requirements.txt     # Python 依赖
│   ├── Dockerfile          # 智能体 Docker 配置
│   ├── docker-compose.yml  # 智能体 Docker Compose 配置
│   ├── start.sh            # 智能体启动脚本
│   └── README.md           # 智能体服务说明
├── chatui/                  # 前端对话界面微服务
│   ├── src/                 # 前端源代码
│   ├── public/              # 静态资源
│   ├── package.json         # Node.js 项目配置
│   ├── Dockerfile          # 前端 Docker 配置
│   ├── docker-compose.yml  # 前端 Docker Compose 配置
│   ├── start.sh            # 前端启动脚本
│   └── README.md           # 前端服务说明
└── README.md               # 项目总体说明
```

## 微服务说明

### 1. Agent 服务 (端口 8123)
- **功能**: LangGraph 智能体后端服务
- **技术栈**: Python + LangGraph + Docker
- **API**: 提供智能体 API 接口
- **Studio**: 支持 LangGraph Studio 可视化界面

### 2. ChatUI 服务 (端口 3000)
- **功能**: 前端对话界面
- **技术栈**: Next.js + React + TypeScript + Docker
- **特性**: 基于 [agent-chat-ui](https://github.com/langchain-ai/agent-chat-ui) 项目

## 快速开始

### 方式1: 统一启动（推荐）
使用根目录的统一启动脚本，同时启动两个服务：

```bash
./start.sh
```

### 方式2: 分别启动两个服务

#### 启动智能体服务
```bash
cd agent
./start.sh
```

#### 启动前端界面
```bash
cd chatui
./start.sh
```

### 方式3: 使用 Docker Compose
直接使用根目录的 docker-compose.yml：

```bash
docker compose up --build -d
```

## 访问地址

- **前端对话界面**: http://localhost:3000
- **智能体 API**: http://localhost:8123
- **API 文档**: http://localhost:8123/docs
- **LangGraph Studio**: https://smith.langchain.com/studio/?baseUrl=http://localhost:8123

## 服务管理

### 统一管理（推荐）
使用根目录的独立脚本管理所有服务：

```bash
./start.sh           # 启动所有服务
./stop.sh            # 停止所有服务
./restart.sh         # 重启所有服务
./status.sh          # 查看所有服务状态
./logs.sh            # 查看所有服务日志
./logs.sh agent      # 查看 Agent 服务日志
./logs.sh chatui     # 查看 ChatUI 服务日志
./clean.sh           # 清理所有服务
./help.sh            # 显示帮助信息
```

### 分别管理
如果需要单独管理某个服务：

#### 智能体服务管理
```bash
cd agent
./start.sh start    # 启动服务
./start.sh stop     # 停止服务
./start.sh restart  # 重启服务
./start.sh logs     # 查看日志
./start.sh status   # 查看状态
```

#### 前端服务管理
```bash
cd chatui
./start.sh start    # 启动服务
./start.sh stop     # 停止服务
./start.sh restart  # 重启服务
./start.sh logs     # 查看日志
./start.sh status   # 查看状态
```

## 技术特性

### 智能体服务
- 🌤️ 智能天气查询
- 🎨 LangGraph Studio 可视化界面
- 🐳 Docker 容器化部署
- 🚀 国内镜像源优化

### 前端服务
- 💬 现代化对话界面
- 📱 响应式设计
- 🔄 实时消息流
- 🎨 美观的 UI 组件

## 开发说明

### 环境要求
- Docker & Docker Compose
- Node.js 18+ (本地开发)
- Python 3.11+ (本地开发)

### 本地开发

#### 智能体服务本地开发
```bash
cd agent
./start-local.sh
```

#### 前端服务本地开发
```bash
cd chatui
npm install
npm run dev
```

## 配置说明

### 环境变量
每个服务都有独立的 `.env` 文件配置：

- `agent/.env`: 智能体服务配置
- `chatui/.env`: 前端服务配置

### 服务间通信
- 前端服务通过 HTTP API 与智能体服务通信
- 默认配置下，前端服务连接到 `http://agent:8123`

## 故障排除

### 常见问题

1. **端口冲突**
   - 智能体服务使用端口 8123
   - 前端服务使用端口 3000
   - 确保这些端口未被占用

2. **服务启动失败**
   - 检查 Docker 是否正常运行
   - 查看服务日志：`./start.sh logs`

3. **前端无法连接智能体**
   - 确保智能体服务已启动
   - 检查网络配置

## 许可证

请查看 [LICENSE](LICENSE) 文件了解详细信息。

## 贡献

欢迎提交 Issue 和 Pull Request！

---

**提示**: 首次使用建议先启动前端服务，它会自动管理智能体服务的启动。