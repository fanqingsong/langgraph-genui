#!/bin/bash

# LangGraph GenUI 重启脚本
# 用于重启所有微服务

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
    echo -e "${BLUE}  LangGraph GenUI 服务重启器${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 主函数
main() {
    print_header
    
    print_message "重启所有服务..."
    
    # 先停止所有服务
    print_message "停止现有服务..."
    ./stop.sh
    
    # 等待一下
    sleep 2
    
    # 启动所有服务
    print_message "启动所有服务..."
    ./start.sh
}

# 执行主函数
main "$@"
