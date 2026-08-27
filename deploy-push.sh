#!/usr/bin/env bash
# ============================================================
# 钱兔子官网 · 一键推送到 GitHub（Vercel 自动部署）
# ------------------------------------------------------------
# 用法：
#   1. 把下面 REPO_URL 改成你的 GitHub 仓库地址
#   2. 在「钱兔子官网」目录里运行：  bash deploy-push.sh
#
# 说明：
#   - 首次运行会添加 remote 并推送 main 分支
#   - 之后每次运行，若有未提交改动会自动提交（带时间戳）再推送
#   - Vercel 连上该仓库后，推送即触发自动部署
# ============================================================

# ↓↓↓ 改成你的 GitHub 仓库地址（New repository 后复制的 URL）↓↓↓
REPO_URL="https://github.com/He1987-Ll1992/qiantu-website.git"

# 切到脚本所在目录（钱兔子官网）
cd "$(dirname "$0")" || exit 1

# 配置 remote（已存在则更新，不存在则添加）
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REPO_URL"
  echo "✓ 已更新 remote origin -> $REPO_URL"
else
  git remote add origin "$REPO_URL"
  echo "✓ 已添加 remote origin -> $REPO_URL"
fi

git branch -M main

# 有未提交改动就自动提交（带时间戳）
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -q -m "更新网站 $(date +%Y-%m-%d_%H:%M)"
  echo "✓ 已提交本地改动"
fi

git push -u origin main
echo ""
echo "✅ 推送完成 → 去 Vercel 导入该仓库即可自动部署"
