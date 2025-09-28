#!/bin/bash

# LangGraph GenUI 日志查看脚本
# 用于查看微服务日志

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
    echo -e "${BLUE}  LangGraph GenUI 服务日志${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 显示帮助
show_help() {
    echo "用法: $0 [服务名]"
    echo ""
    echo "服务名:"
    echo "  agent     查看 Agent 服务日志"
    echo "  chatui    查看 ChatUI 服务日志"
    echo "  all       查看所有服务日志（默认）"
    echo ""
    echo "示例:"
    echo "  $0              # 查看所有服务日志"
    echo "  $0 agent        # 查看 Agent 服务日志"
    echo "  $0 chatui       # 查看 ChatUI 服务日志"
}

# 查看 Agent 服务日志
view_agent_logs() {
    print_message "查看 Agent 服务日志..."
    if [ -d agent ]; then
        cd agent
        docker compose logs -f
    else
        print_error "Agent 目录不存在"
        exit 1
    fi
}

# 查看 ChatUI 服务日志
view_chatui_logs() {
    print_message "查看 ChatUI 服务日志..."
    if [ -d chatui ]; then
        cd chatui
        docker compose logs -f
    else
        print_error "ChatUI 目录不存在"
        exit 1
    fi
}

# 查看所有服务日志
view_all_logs() {
    print_message "查看所有服务日志..."
    echo -e "${YELLOW}按 Ctrl+C 退出日志查看${NC}"
    echo ""
    
    # 使用 docker compose logs 查看所有服务
    if command -v docker-compose >/dev/null 2>&1; then
        docker-compose logs -f
    else
        print_warning "未找到 docker-compose 命令，请分别查看各服务日志"
        echo "Agent 服务日志: $0 agent"
        echo "ChatUI 服务日志: $0 chatui"
    fi
}

# 主函数
main() {
    local service="${1:-all}"
    
    case "$service" in
        "agent")
            print_header
            view_agent_logs
            ;;
        "chatui")
            print_header
            view_chatui_logs
            ;;
        "all")
            print_header
            view_all_logs
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            print_error "未知服务: $service"
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"
