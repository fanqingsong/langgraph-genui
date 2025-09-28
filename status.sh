#!/bin/bash

# LangGraph GenUI 状态查看脚本
# 用于查看所有微服务状态

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
    echo -e "${BLUE}  LangGraph GenUI 服务状态${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 查看服务状态
view_status() {
    print_message "服务状态："
    echo ""
    
    # Agent 服务状态
    if [ -d agent ]; then
        echo -e "${BLUE}Agent 服务状态：${NC}"
        cd agent
        docker compose ps
        cd ..
        echo ""
    fi
    
    # ChatUI 服务状态
    if [ -d chatui ]; then
        echo -e "${BLUE}ChatUI 服务状态：${NC}"
        cd chatui
        docker compose ps
        cd ..
        echo ""
    fi
}

# 主函数
main() {
    print_header
    view_status
}

# 执行主函数
main "$@"
