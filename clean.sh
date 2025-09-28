#!/bin/bash

# LangGraph GenUI 清理脚本
# 用于清理所有微服务相关资源

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
    echo -e "${BLUE}  LangGraph GenUI 服务清理器${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 清理所有服务
clean_all_services() {
    print_message "清理所有服务..."
    
    # 停止所有服务
    print_message "停止所有服务..."
    ./stop.sh
    
    # 删除镜像
    print_message "删除相关镜像..."
    docker rmi langgraph-genui-agent-langgraph-app 2>/dev/null || true
    docker rmi langgraph-genui-chatui-chatui 2>/dev/null || true
    
    # 清理网络
    print_message "清理网络..."
    docker network prune -f
    
    # 清理未使用的镜像
    print_message "清理未使用的镜像..."
    docker image prune -f
    
    print_success "✅ 清理完成"
}

# 主函数
main() {
    print_header
    clean_all_services
}

# 执行主函数
main "$@"
