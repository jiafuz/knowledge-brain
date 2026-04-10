#!/bin/bash
# SessionStart hook - 预加载知识库索引

INDEX_FILE="$HOME/.claude/projects/memory/knowledge-brain-index.md"

if [ -f "$INDEX_FILE" ]; then
    # 检查是否已初始化（有分区 token 且不是占位符）
    token_line=$(grep "分区 Token" "$INDEX_FILE" | head -1)
    if [ -n "$token_line" ] && ! echo "$token_line" | grep -q "<"; then
        echo "[knowledge-brain] 知识库索引已加载。"
        echo ""
        echo "知识库预加载内容："
        # 输出重点知识区摘要（可选，取决于是否要在 session 开始时显示）
    else
        echo "[knowledge-brain] 知识库索引未初始化，请执行 /knowledge-init 初始化知识库分区"
    fi
else
    echo "[knowledge-brain] 知识库索引不存在，请执行 /knowledge-init 初始化知识库分区"
fi