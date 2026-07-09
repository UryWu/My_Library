### 企查查的mcp连接配置

已经给Qclaw了。

[企查查丨智能体数据平台](https://agent.qcc.com/profile/api-key?copied=1&activated=1)

每搜索一次扣5积分，现在有586积分。

#### mcp配置

```json
{
  "mcpServers": {
    "qcc-company": {
      "url": "https://agent.qcc.com/mcp/company/stream",
      "headers": {
        "Authorization": "Bearer MTCx2kqbJHpnzYQdDJ0N8B7c5gIdTLFN8rQpdHelDYghqDiN"
      }
    },
    "qcc-risk": {
      "url": "https://agent.qcc.com/mcp/risk/stream",
      "headers": {
        "Authorization": "Bearer MTCx2kqbJHpnzYQdDJ0N8B7c5gIdTLFN8rQpdHelDYghqDiN"
      }
    },
    "qcc-ipr": {
      "url": "https://agent.qcc.com/mcp/ipr/stream",
      "headers": {
        "Authorization": "Bearer MTCx2kqbJHpnzYQdDJ0N8B7c5gIdTLFN8rQpdHelDYghqDiN"
      }
    },
    "qcc-operation": {
      "url": "https://agent.qcc.com/mcp/operation/stream",
      "headers": {
        "Authorization": "Bearer MTCx2kqbJHpnzYQdDJ0N8B7c5gIdTLFN8rQpdHelDYghqDiN"
      }
    },
    "qcc-executive": {
      "url": "https://agent.qcc.com/mcp/executive/stream",
      "headers": {
        "Authorization": "Bearer MTCx2kqbJHpnzYQdDJ0N8B7c5gIdTLFN8rQpdHelDYghqDiN"
      }
    },
    "qcc-history": {
      "url": "https://agent.qcc.com/mcp/history/stream",
      "headers": {
        "Authorization": "Bearer MTCx2kqbJHpnzYQdDJ0N8B7c5gIdTLFN8rQpdHelDYghqDiN"
      }
    }
  }
}
```



#### [企业相关skill](https://agent.qcc.com/skills)