---
name: knowledge-sync
version: 1.0.0
description: "知识同步：全量扫描知识库、更新索引、深度预加载重点知识。当用户说'同步知识库'、'深度学习'、'复习知识库'时使用。"
---

# knowledge-sync

全量同步知识库，深度预加载重点知识。

**前置条件：**
1. 已完成 `/knowledge-init` 初始化分区
2. 先读取 [`../lark-shared/SKILL.md`](../lark-shared/SKILL.md)

## 触发方式

- 用户说"同步知识库"、"深度学习"、"复习知识库"
- 执行 `/sync` 命令

## 同步流程

### Step 1: 扫描知识库所有节点

```bash
# 获取知识库节点列表
lark-cli wiki nodes list \
  --params '{"space_id":"7626588551701892296"}' \
  --page-all
```

获取所有节点的 token、title、obj_type。

### Step 2: 获取每个节点详情

对每个节点：
```bash
lark-cli wiki spaces get_node --params '{"token":"<node_token>"}'
```

记录：node_token、obj_token、title、has_child。

### Step 3: 获取文档摘要

对重点知识区的文档：
```bash
lark-cli docs +fetch --doc "<obj_token>" --format pretty
```

提取摘要内容。

### Step 4: 重写索引文件

使用 Write 工具重写 `~/.claude/projects/memory/knowledge-brain-index.md`：

```markdown
---
name: knowledge-brain-index
description: 个人知识库索引
type: reference
---

# 知识库索引

## 知识库信息
...

## 分区结构
### 重点知识区
**分区 Token**: xxx

**文档列表**:
- [主题] 标题 - 摘要 (token: xxx, last_update: yyyy-mm-dd)

### 消化文章区
**分区 Token**: xxx

**文档列表**:
...

## 统计
- 重点知识文档数: X
- 消化文章数: Y
- 最后同步时间: yyyy-mm-dd hh:mm

## 更新日志
- yyyy-mm-dd: 全量同步完成
```

### Step 5: 输出同步结果

```
✅ 知识库同步完成

**统计：**
- 重点知识文档: X 篇
- 消化文章: Y 篇
- 同步时间: yyyy-mm-dd hh:mm

索引已更新，重点知识已预加载。
```

## 需要的权限

- `wiki:node:read` - 读取知识库节点
- `docs:doc:read` - 读取文档