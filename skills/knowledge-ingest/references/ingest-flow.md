# 内容消化流程详解

## 来源类型识别

| 来源类型 | 识别特征 | 处理方法 |
|---------|---------|---------|
| 镜书群消息链接 | URL 包含 `/chat/` 或 `oc_` 开头 | 调用 lark-im 获取消息内容 |
| 镜书文档链接 | URL 包含 `/docx/`、`/doc/`、`/wiki/` | 调用 lark-doc +fetch 获取内容 |
| 互联网文章链接 | 外部 URL（非飞书域名） | 调用 WebFetch 抓取内容 |
| 粘贴文本 | 无 URL，纯文本 | 直接处理 |

## 处理流程

### Step 1: 识别来源类型

检查输入内容是否包含 URL：
- 包含飞书 URL → 判断是群消息还是文档
- 包含外部 URL → 互联网文章
- 无 URL → 粘贴文本

### Step 2: 获取原文内容

**飞书文档链接：**
```bash
# wiki 链接需先获取 obj_token
lark-cli wiki spaces get_node --params '{"token":"<wiki_token>"}'

# 获取文档内容
lark-cli docs +fetch --doc "<obj_token>" --format pretty
```

**飞书群消息链接：**
```bash
# 调用 lark-im skill 获取消息内容
# 参考 ../lark-im/SKILL.md
```

**互联网文章链接：**
使用 WebFetch 工具抓取内容。

### Step 3: 智能提炼摘要

生成结构化摘要：

```markdown
## 背景
[内容背景简述，1-2句话]

## 核心观点
- [关键要点 1]
- [关键要点 2]
- ...

## 原文链接
[原始链接/来源信息]

## 行动建议（可选）
[如有实践指导则记录]

## 延伸思考（可选）
[关联知识、后续待深入了解的点]
```

### Step 4: 智能分类

分析内容关键词判断主题：
- 技术：编程、架构、API、工具、框架
- 产品：需求、设计、用户、迭代
- 管理：团队、流程、协作、决策
- 其他：无法归类时使用"其他"

判断分区：
- 内容是核心知识、重要参考 → 重点知识区
- 内容是一般文章、资讯、待判断价值 → 消化文章区

### Step 5: 存入知识库

**创建分区子页面（按主题）：**
```bash
lark-cli wiki nodes create \
  --params '{"space_id":"7626588551701892296"}' \
  --data '{"node_type":"origin","obj_type":"docx","parent_node_token":"<分区token>","title":"<主题名>"}'
```

**创建文档：**
```bash
lark-cli docs +create \
  --wiki-space "7626588551701892296" \
  --wiki-node "<主题分区token>" \
  --title "<文档标题>" \
  --markdown "<摘要内容>"
```

### Step 6: 更新索引

调用 knowledge-index skill 更新索引文件。