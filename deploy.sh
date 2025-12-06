#!/bin/bash

# 部署脚本：按顺序执行图片转换、文档同步、构建和部署

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 服务器配置
SERVER_ALIAS="aliyun"
REMOTE_DIR="/var/www/zeka-stack/dist"

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="${SCRIPT_DIR}/.vitepress/dist"

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Zeka Stack 部署工具${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 步骤 1: 图片转换为 WebP
echo -e "${YELLOW}[步骤 1/4] 图片转换为 WebP 格式...${NC}"
echo ""

if [ ! -f "${SCRIPT_DIR}/convert-images-to-webp.sh" ]; then
  echo -e "${RED}错误: 找不到 convert-images-to-webp.sh 脚本${NC}"
  exit 1
fi

# 添加执行权限
chmod +x "${SCRIPT_DIR}/convert-images-to-webp.sh"

# 执行图片转换脚本
bash "${SCRIPT_DIR}/convert-images-to-webp.sh"

if [ $? -ne 0 ]; then
  echo -e "${RED}图片转换失败，终止部署${NC}"
  exit 1
fi

echo ""
echo -e "${GREEN}✓${NC} 图片转换完成"
echo ""

# 步骤 2: 同步文档
echo -e "${YELLOW}[步骤 2/4] 同步文档到 docs 目录...${NC}"
echo ""

if [ ! -f "${SCRIPT_DIR}/sync-docs.sh" ]; then
  echo -e "${RED}错误: 找不到 sync-docs.sh 脚本${NC}"
  exit 1
fi

# 添加执行权限
chmod +x "${SCRIPT_DIR}/sync-docs.sh"

# 执行文档同步脚本
bash "${SCRIPT_DIR}/sync-docs.sh"

if [ $? -ne 0 ]; then
  echo -e "${RED}文档同步失败${NC}"
  exit 1
fi

echo ""
echo -e "${GREEN}✓${NC} 文档同步完成"
echo ""

# 步骤 3: 构建文档
echo -e "${YELLOW}[步骤 3/4] 构建文档站点...${NC}"
echo ""

cd "${SCRIPT_DIR}"

# 检查 node_modules 是否存在
if [ ! -d "node_modules" ]; then
  echo -e "${YELLOW}正在安装依赖...${NC}"
  npm install
  if [ $? -ne 0 ]; then
    echo -e "${RED}依赖安装失败${NC}"
    exit 1
  fi
fi

# 执行构建
npm run build

if [ $? -ne 0 ]; then
  echo -e "${RED}文档构建失败${NC}"
  exit 1
fi

echo ""
echo -e "${GREEN}✓${NC} 文档构建完成"
echo ""

# 步骤 4: 部署到服务器
echo -e "${YELLOW}[步骤 4/4] 部署到服务器 ${SERVER_ALIAS}:${REMOTE_DIR}...${NC}"
echo ""

# 检查构建产物是否存在
if [ ! -d "${DIST_DIR}" ]; then
  echo -e "${RED}错误: 构建产物目录不存在: ${DIST_DIR}${NC}"
  exit 1
fi

# 在远程服务器创建目录（如果不存在）
ssh ${SERVER_ALIAS} "mkdir -p ${REMOTE_DIR}"

if [ $? -ne 0 ]; then
  echo -e "${RED}无法连接到服务器或创建目录失败${NC}"
  exit 1
fi

# 使用 rsync 同步文件（增量同步，删除远程多余文件）
rsync -avz --delete --progress "${DIST_DIR}/" "${SERVER_ALIAS}:${REMOTE_DIR}/"

if [ $? -ne 0 ]; then
  echo -e "${RED}文件上传失败${NC}"
  exit 1
fi

echo ""
echo -e "${GREEN}✓${NC} 部署完成"
echo ""

# 完成
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}🎉 全部部署完成！${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}部署信息:${NC}"
echo -e "  - 服务器: ${BLUE}${SERVER_ALIAS}${NC}"
echo -e "  - 目录: ${BLUE}${REMOTE_DIR}${NC}"
echo ""
echo -e "${YELLOW}本地命令:${NC}"
echo -e "  - 运行 ${BLUE}npm run dev${NC} 启动开发服务器"
echo -e "  - 运行 ${BLUE}npm run build${NC} 构建文档"
echo -e "  - 运行 ${BLUE}npm run preview${NC} 预览构建结果"
echo ""
