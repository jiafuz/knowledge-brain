# 知识库索引结构定义

## 索引文件位置

`~/.claude/projects/memory/knowledge-brain-index.md`

## 索引结构模板

以下为索引文件的完整结构：

```markdown
---
name: knowledge-brain-index
description: 个人知识库索引，用于快速检索和预加载
type: reference
---

# 知识库索引

## 知识库信息
- 知识空间 ID: 7626588551701892296
- Token: YtRxwiuMWiZMyokRrXfc4K80ngc
- URL: https://uih.feishu.cn/wiki/YtRxwiuMWiZMyokRrXfc4K80ngc

## 分区结构

### 重点知识区
**分区 Token**: <初始化时填充>
**分区 URL**: <初始化时填充>

**文档列表**:
- [主题] 文档标题 - 摘要预览 (token: xxx, last_update: yyyy-mm-dd)

### 消化文章区
**分区 Token**: <初始化时填充>
**分区 URL**: <初始化时填充>

**文档列表**:
- [主题] 文章标题 - 摘要预览 (token: xxx, last_update: yyyy-mm-dd)

## 统计
- 重点知识文档数: X
- 消化文章数: Y
- 最后同步时间: yyyy-mm-dd hh:mm

## 更新日志
- yyyy-mm-dd: 初始化索引
- yyyy-mm-dd: 新增文档 [标题]
```

## 索引操作

| 操作 | 方法 | 说明 |
|------|------|------|
| 初始化索引 | Write | 创建空索引文件 |
| 读取索引 | Read | 获取分区 token 和文档列表 |
| 更新索引 | Edit | 新增文档条目、更新统计 |
| 全量同步 | Write | 重写整个索引文件 |