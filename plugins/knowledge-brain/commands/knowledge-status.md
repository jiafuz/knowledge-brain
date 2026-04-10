---
description: 查看知识库当前状态
allowed-tools: [Read, Bash]
---

# /knowledge-status 命令

查看知识库当前状态：初始化状态、分区信息、文档统计。

## 执行流程

1. **读取索引文件**
   - 使用 Read 读取 `~/.claude/projects/memory/knowledge-brain-index.md`

2. **判断状态**
   - 索引不存在 → 未初始化
   - 分区 token 为空 → 分区未创建
   - 有 token 无文档 → 已初始化但无内容
   - 有文档 → 正常状态

3. **获取实时知识库信息**
   ```bash
   lark-cli wiki spaces get_node \
     --params '{"token":"YtRxwiuMWiZMyokRrXfc4K80ngc"}' \
     --as user
   ```

4. **输出状态**

**未初始化：**
```
❌ 知识库未初始化

请执行 /knowledge-init 初始化分区结构。
```

**已初始化：**
```
✅ 知识库状态

**知识库：** 个人知识库
**URL：** https://uih.feishu.cn/wiki/YtRxwiuMWiZMyokRrXfc4K80ngc

**分区结构：**
- 重点知识区: [链接] - X 篇文档
- 消化文章区: [链接] - Y 篇文档

**最后同步：** yyyy-mm-dd hh:mm

💡 使用 /digest 存入新知识，/sync 全量同步。
```