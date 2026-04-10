---
description: 初始化知识库分区结构
allowed-tools: [Read, Write, Bash]
---

# /knowledge-init 命令

初始化知识库分区，创建"重点知识区"和"消化文章区"两个子页面。

## 知识库信息

- 知识空间 ID: `7626588551701892296`
- 根节点 Token: `YtRxwiuMWiZMyokRrXfc4K80ngc`
- URL: https://uih.feishu.cn/wiki/YtRxwiuMWiZMyokRrXfc4K80ngc

## 执行流程

1. **检查是否已初始化**
   - 读取 `~/.claude/projects/memory/knowledge-brain-index.md`
   - 如果分区 token 已存在，提示已初始化

2. **创建"重点知识区"分区**
   ```bash
   lark-cli wiki nodes create \
     --params '{"space_id":"7626588551701892296"}' \
     --data '{"node_type":"origin","obj_type":"docx","parent_node_token":"YtRxwiuMWiZMyokRrXfc4K80ngc","title":"重点知识区"}' \
     --as user
   ```
   - 从返回结果提取 `node.node_token` 作为重点知识区 token

3. **创建"消化文章区"分区**
   ```bash
   lark-cli wiki nodes create \
     --params '{"space_id":"7626588551701892296"}' \
     --data '{"node_type":"origin","obj_type":"docx","parent_node_token":"YtRxwiuMWiZMyokRrXfc4K80ngc","title":"消化文章区"}' \
     --as user
   ```
   - 从返回结果提取 `node.node_token` 作为消化文章区 token

4. **创建初始索引文件**
   ```bash
   # 使用 Write 工具创建索引文件
   ```

   索引内容：
   ```markdown
   ---
   name: knowledge-brain-index
   description: 个人知识库索引
   type: reference
   ---

   # 知识库索引

   ## 知识库信息
   - 知识空间 ID: 7626588551701892296
   - Token: YtRxwiuMWiZMyokRrXfc4K80ngc
   - URL: https://uih.feishu.cn/wiki/YtRxwiuMWiZMyokRrXfc4K80ngc

   ## 分区结构

   ### 重点知识区
   **分区 Token**: <Step 2 获取的 token>
   **分区 URL**: https://uih.feishu.cn/wiki/<token>

   **文档列表**:
   （暂无）

   ### 消化文章区
   **分区 Token**: <Step 3 获取的 token>
   **分区 URL**: https://uih.feishu.cn/wiki/<token>

   **文档列表**:
   （暂无）

   ## 统计
   - 重点知识文档数: 0
   - 消化文章数: 0
   - 最后同步时间: yyyy-mm-dd hh:mm

   ## 更新日志
   - yyyy-mm-dd: 初始化分区结构
   ```

5. **输出初始化结果**
   ```
   ✅ 知识库初始化完成

   **分区已创建：**
   - 重点知识区: [链接]
   - 消化文章区: [链接]

   现可以使用 `/digest` 消化内容入库。
   ```