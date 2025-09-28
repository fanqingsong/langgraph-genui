#!/bin/bash

# LangGraph GenUI 启动脚本
# 用于启动所有微服务

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 打印消息函数
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  LangGraph GenUI 微服务启动器${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 检查 Docker 是否运行
check_docker() {
    if ! docker info >/dev/null 2>&1; then
        print_error "Docker 未运行，请先启动 Docker"
        exit 1
    fi
}

# 检查环境文件
check_env_files() {
    # 检查 agent 环境文件
    if [ ! -f agent/.env ]; then
        print_warning "Agent 服务未找到 .env 文件，正在创建..."
        if [ -f agent/env.template ]; then
            cp agent/env.template agent/.env
            print_message "已从 agent/env.template 创建 agent/.env 文件"
        fi
    fi

    # 检查 chatui 环境文件
    if [ ! -f chatui/.env ]; then
        print_warning "ChatUI 服务未找到 .env 文件，正在创建..."
        if [ -f chatui/.env.example ]; then
            cp chatui/.env.example chatui/.env
            print_message "已从 chatui/.env.example 创建 chatui/.env 文件"
        fi
    fi
}

# 启动 Agent 服务
start_agent_service() {
    print_message "启动 Agent 服务..."
    
    if [ ! -d agent ]; then
        print_error "Agent 目录不存在"
        return 1
    fi
    
    cd agent
    docker compose up --build -d
    
    # 等待服务启动
    print_message "等待 Agent 服务启动..."
    sleep 10
    
    # 检查服务状态
    if docker compose ps | grep -q "Up"; then
        print_success "✅ Agent 服务启动成功！"
        cd ..
        return 0
    else
        print_error "❌ Agent 服务启动失败"
        cd ..
        return 1
    fi
}

# 启动 ChatUI 服务
start_chatui_service() {
    print_message "启动 ChatUI 服务..."
    
    if [ ! -d chatui ]; then
        print_error "ChatUI 目录不存在"
        return 1
    fi
    
    cd chatui
    docker compose up --build -d
    
    # 等待服务启动
    print_message "等待 ChatUI 服务启动..."
    sleep 15
    
    # 检查服务状态
    if docker compose ps | grep -q "Up"; then
        print_success "✅ ChatUI 服务启动成功！"
        cd ..
        return 0
    else
        print_error "❌ ChatUI 服务启动失败"
        cd ..
        return 1
    fi
}

# 主函数
main() {
    print_header
    
    # 检查 Docker
    check_docker
    
    # 检查环境文件
    check_env_files
    
    # 启动 Agent 服务
    if ! start_agent_service; then
        print_error "Agent 服务启动失败，请检查日志"
        exit 1
    fi
    
    # 启动 ChatUI 服务
    if ! start_chatui_service; then
        print_error "ChatUI 服务启动失败，请检查日志"
        exit 1
    fi
    
    # 显示访问信息
    echo ""
    print_success "🎉 所有服务启动成功！"
    echo ""
    echo -e "${CYAN}🌐 访问地址：${NC}"
    echo -e "   ${GREEN}前端对话界面:${NC} http://localhost:3000"
    echo -e "   ${GREEN}智能体 API:${NC} http://localhost:8123"
    echo -e "   ${GREEN}API 文档:${NC} http://localhost:8123/docs"
    echo -e "   ${GREEN}LangGraph Studio:${NC} https://smith.langchain.com/studio/?baseUrl=http://localhost:8123"
    echo ""
    echo -e "${CYAN}📚 使用说明：${NC}"
    echo -e "   1. 在浏览器中打开 ${GREEN}http://localhost:3000${NC} 开始对话"
    echo -e "   2. 查看 API 文档: ${GREEN}http://localhost:8123/docs${NC}"
    echo -e "   3. 使用 Studio: ${GREEN}https://smith.langchain.com/studio/?baseUrl=http://localhost:8123${NC}"
    echo ""
}

# 执行主函数
main "$@"