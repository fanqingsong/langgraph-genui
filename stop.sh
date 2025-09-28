#!/bin/bash

# LangGraph GenUI 停止脚本
# 用于停止所有微服务

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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
    echo -e "${BLUE}  LangGraph GenUI 服务停止器${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 停止所有服务
stop_all_services() {
    print_message "停止所有服务..."
    
    # 停止 chatui 服务
    if [ -d chatui ]; then
        print_message "停止 ChatUI 服务..."
        cd chatui
        docker compose down 2>/dev/null || true
        cd ..
    fi
    
    # 停止 agent 服务
    if [ -d agent ]; then
        print_message "停止 Agent 服务..."
        cd agent
        docker compose down 2>/dev/null || true
        cd ..
    fi
    
    print_success "✅ 所有服务已停止"
}

# 主函数
main() {
    print_header
    stop_all_services
}

# 执行主函数
main "$@"
