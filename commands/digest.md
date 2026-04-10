---
description: 消化内容并存入知识库
argument-hint: <链接或内容>
allowed-tools: [Read, Write, Edit, WebFetch, Bash]
---

# /digest 命令

消化用户提供的链接或内容，提炼摘要存入知识库。

## 执行流程

1. **检查初始化状态**
   - 读取 `~/.claude/projects/memory/knowledge-brain-index.md`
   - 如果分区 token 为空，先执行初始化

2. **识别来源类型**
   - 检查 `$ARGUMENTS` 是否包含 URL
   - 飞书文档 → lark-doc +fetch
   - 互联网文章 → WebFetch
   - 纯文本 → 直接处理

3. **提炼摘要**
   - 按结构化格式生成摘要

4. **智能分类**
   - 分析主题关键词
   - 判断分区（重点知识区/消化文章区）

5. **存入知识库**
   ```bash
   lark-cli docs +create \
     --wiki-space "7626588551701892296" \
     --wiki-node "<分区token>" \
     --title "<标题>" \
     --markdown "<摘要>"
   ```

6. **更新索引**
   - 使用 Edit 更新索引文件

## 输出

```
✅ 已存入知识库

**文档：** [标题](飞书链接)
**分区：** 重点知识区/消化文章区 - [主题]
**摘要预览：** xxx
```