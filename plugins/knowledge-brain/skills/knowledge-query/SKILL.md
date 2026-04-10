---
name: knowledge-query
version: 1.0.0
description: "智能问答：根据问题语义按需加载知识库内容回答。当需要查询知识库内容、基于预加载知识回答问题时自动触发。"
---

# knowledge-query

智能判断问题关联，按需加载知识库内容回答。

**前置条件：** 索引文件已初始化（通过 `/knowledge-init`）

## 工作流程

### Step 1: 读取索引

使用 Read 工具读取 `~/.claude/projects/memory/knowledge-brain-index.md`

### Step 2: 分析问题语义

判断问题可能关联的主题：
- 提及"技术"、"架构"、"代码" → 技术主题
- 提及"产品"、"设计"、"用户" → 产品主题
- 提及"管理"、"团队"、"流程" → 管理主题
- 无明确主题 → 关键词模糊匹配

### Step 3: 决定加载策略

详见 [query-strategy.md](references/query-strategy.md)

| 策略 | 条件 | 操作 |
|------|------|------|
| 全量加载主题 | 明确指向某主题 | 加载该主题下所有文档 |
| 相关文档加载 | 模糊关键词 | 加载最相关 1-3 篇 |
| 不加载 | 与知识库无关 | 直接回答 |

### Step 4: 按需加载原文

从索引获取文档 token：
```bash
lark-cli docs +fetch --doc "<token>" --format pretty
```

### Step 5: 回答问题

结合知识库内容和已有知识回答。

## 回退机制

索引不存在或无相关文档时，直接用已有知识回答，标注来源。