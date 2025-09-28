#!/bin/bash

# LangGraph GenUI 帮助脚本
# 用于显示所有可用命令

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

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  LangGraph GenUI 帮助信息${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 显示帮助信息
show_help() {
    print_header
    echo ""
    echo -e "${CYAN}可用命令：${NC}"
    echo ""
    echo -e "${GREEN}  ./start.sh${NC}          启动所有服务"
    echo -e "${GREEN}  ./stop.sh${NC}           停止所有服务"
    echo -e "${GREEN}  ./restart.sh${NC}        重启所有服务"
    echo -e "${GREEN}  ./status.sh${NC}         查看服务状态"
    echo -e "${GREEN}  ./logs.sh${NC}           查看所有服务日志"
    echo -e "${GREEN}  ./logs.sh agent${NC}     查看 Agent 服务日志"
    echo -e "${GREEN}  ./logs.sh chatui${NC}    查看 ChatUI 服务日志"
    echo -e "${GREEN}  ./clean.sh${NC}          清理所有服务"
    echo -e "${GREEN}  ./help.sh${NC}           显示帮助信息"
    echo ""
    echo -e "${CYAN}服务说明：${NC}"
    echo ""
    echo -e "${YELLOW}Agent 服务 (端口 8123)${NC}"
    echo "  - LangGraph 智能体后端服务"
    echo "  - 提供 API 接口"
    echo "  - 支持 LangGraph Studio"
    echo ""
    echo -e "${YELLOW}ChatUI 服务 (端口 3000)${NC}"
    echo "  - 前端对话界面"
    echo "  - 基于 Next.js + React"
    echo "  - 与 Agent 服务通信"
    echo ""
    echo -e "${CYAN}访问地址：${NC}"
    echo ""
    echo -e "  ${GREEN}前端对话界面:${NC} http://localhost:3000"
    echo -e "  ${GREEN}智能体 API:${NC} http://localhost:8123"
    echo -e "  ${GREEN}API 文档:${NC} http://localhost:8123/docs"
    echo -e "  ${GREEN}LangGraph Studio:${NC} https://smith.langchain.com/studio/?baseUrl=http://localhost:8123"
    echo ""
    echo -e "${CYAN}使用示例：${NC}"
    echo ""
    echo "  # 启动所有服务"
    echo "  ./start.sh"
    echo ""
    echo "  # 查看服务状态"
    echo "  ./status.sh"
    echo ""
    echo "  # 查看 Agent 服务日志"
    echo "  ./logs.sh agent"
    echo ""
    echo "  # 停止所有服务"
    echo "  ./stop.sh"
    echo ""
    echo "  # 清理所有资源"
    echo "  ./clean.sh"
    echo ""
}

# 主函数
main() {
    show_help
}

# 执行主函数
main "$@"
