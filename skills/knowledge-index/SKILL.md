---
name: knowledge-index
version: 1.0.0
description: "知识库索引管理：读取、更新、同步索引。当需要查询知识库分区结构、获取文档 token、更新索引条目时使用。"
---

# knowledge-index

管理知识库索引文件 `~/.claude/projects/memory/knowledge-brain-index.md`。

**前置条件：** 已完成 `/knowledge-init` 初始化分区。

## 索引文件位置

```
~/.claude/projects/memory/knowledge-brain-index.md
```

## 操作

### 读取索引

使用 Read 工具读取索引文件，获取：
- 分区 token（重点知识区、消化文章区）
- 文档列表（标题、token、摘要预览）
- 统计信息

```
# 读取索引（使用 Claude Code Read 工具）
~/.claude/projects/memory/knowledge-brain-index.md
```

### 更新索引（新增文档）

使用 Edit 工具在对应分区的文档列表下新增条目：

```markdown
- [主题] 文档标题 - 摘要预览 (token: xxx, last_update: yyyy-mm-dd)
```

同时更新统计部分：
- 重点知识文档数 / 消化文章数
- 最后同步时间
- 更新日志

### 全量同步索引

使用 Write 工具重写整个索引文件，扫描知识库所有文档重新生成索引。

## 索引结构

详见 [index-schema.md](references/index-schema.md)

## 错误处理

| 错误 | 原因 | 解决方案 |
|------|------|---------|
| 索引文件不存在 | 未初始化 | 执行 `/knowledge-init` |
| 分区 token 为空 | 未创建分区 | 执行 `/knowledge-init` |

---

## 权限要求

本 skill 操作本地索引文件，不直接调用飞书 API。但索引中的数据来源于飞书知识库，需要：

- `wiki:node:read` - 读取知识库节点
- `docs:doc:read` - 读取文档内容