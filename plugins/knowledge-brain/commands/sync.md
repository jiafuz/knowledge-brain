---
description: 全量同步知识库索引，深度预加载重点知识
allowed-tools: [Read, Write, Bash]
---

# /sync 命令

全量扫描知识库，更新索引，深度预加载重点知识区全文。

## 执行流程

1. **检查初始化状态**
   - 读取索引文件，确认分区 token 存在

2. **扫描知识库节点**
   ```bash
   lark-cli wiki nodes list \
     --params '{"space_id":"7626588551701892296"}' \
     --page-all \
     --as user
   ```

3. **获取每个分区下的子节点**
   - 分别获取重点知识区和消化文章区的子节点
   ```bash
   lark-cli wiki nodes list \
     --params '{"space_id":"7626588551701892296","parent_node_token":"<分区token>"}' \
     --as user
   ```

4. **获取文档内容和摘要**
   - 对每个文档节点，获取 obj_token
   - 调用 `lark-cli docs +fetch --doc "<obj_token>" --format pretty`
   - 提取摘要预览（前 200 字）

5. **重写索引文件**
   - 使用 Write 工具更新索引
   - 更新文档列表、统计、同步时间

6. **输出同步结果**
   ```
   ✅ 知识库同步完成
   
   **重点知识区：** X 篇文档
   **消化文章区：** Y 篇文档
   **同步时间：** yyyy-mm-dd hh:mm
   
   重点知识已预加载到索引。
   ```