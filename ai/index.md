# For Agents

Zeka Stack 为 AI 开发业务项目提供工程规范、组件 Skills、离线 CLI 和 MCP。目标是让 AI 使用已有封装，产出开发者能读懂、符合项目约定的代码。当前知识对应 3.0.0-SNAPSHOT 源码快照，不能直接当成其他版本的兼容声明。

## 从这里开始

| 需要解决的问题 | 入口 |
| --- | --- |
| 怎样组织业务代码、使用基类、响应和异常 | [arch.md 工程规范](./1.arch) |
| 怎样让 Agent 按固定流程工作 | [业务与组件 Skills](./3.skills) |
| 怎样快速检索类、方法、依赖、配置 | [Go CLI](./5.cli) |
| 怎样在 Agent 客户端直接调用查询和检查 | [MCP Server](./4.mcp) |
| 怎样取得纯文本索引与全文 | [LLMs.txt](./2.llms) |

## 可直接复制的提示词

```text
请使用 Zeka Stack 开发这个业务项目。
先读取项目 AGENTS.md、POM、已有同类模块，再读取：
https://zekastack.dong4j.site/docs/arch.md
https://zekastack.dong4j.site/docs/SKILL.md

如果站点还未部署，使用源码仓库的 arch.md 和
supports/skills/zeka-stack-business-dev/SKILL.md；
已安装 CLI 时用 zeka arch、zeka doc <starter>、zeka search <keyword>。

确认框架版本与 Servlet/Reactive 选型，查询真实 API 再调用。
按业务模块划分 Controller、Service、DAO、PO、DTO、Form/Query、Converter，
复用统一响应、断言异常、持久层基类和已有工具，使用构造注入。
不要自行发明响应类、配置属性、组件方法或重复 Utils。
参考 zeka demo，并在实现前说明业务边界、数据与事务约束。
完成后按项目允许的命令编译和测试，报告实际验证与未验证事项。
```

这些公开地址需要本次站点构建部署后才会出现；本地 CLI 的知识已内嵌，可离线使用。

## 业务项目 AGENTS.md 模板

将下列内容合并到业务项目自己的约定，补充项目根包、错误码区间、数据库、授权和允许执行的验证命令。框架规范不能替代具体业务规则。

```markdown
# 业务项目协作约定

- 先读本项目 POM、现有模块和 Zeka Stack arch.md；遇到冲突先说明依据。
- 使用实际框架版本的 Skill/API，不依据训练记忆猜测方法和配置。
- 根包、Java 版本、事务和错误码区间以本项目约定为准。
- 按业务模块组织 controller/service/dao/entity，不跨层直接访问 Mapper。
- Servlet Controller 使用 RestControllerWrapper/ServletController，
  直接返回 DTO/IPage/void，由框架统一包装；不自建 ApiResponse。
- DAO/Service 复用 BaseDao/BaseService/BaseServiceImpl；
  PO 基类必须匹配真实表列，不能重复声明主键/审计字段。
- Form/DTO/Query 分开，MapStruct ExtendConverter 执行 f2p/p2d 转换。
- 错误码 implements LowestExceptionAssert，使用统一断言，不 catch 后返回 Map。
- 构造器注入；公开响应不暴露 PO 和敏感字段；分页和排序在服务端校验。
- 查询已有工具和组件后再写代码，不复制新的通用 Utils。
- 新类和关键方法注明业务约束；完成后说明实际验证与未验证项。
```

## 推荐接入流程

1. 按 [CLI 指南](./5.cli) 从本地源码构建 `zeka`。
2. 执行 `zeka skills extract --dir <项目的技能目录> --starter cubo-ssm-spring-boot-starter`；按实际依赖替换 starter。
3. 执行 `zeka setup --client <客户端> --workspace <项目绝对路径>`，审阅输出并合并到客户端配置。
4. 让 Agent 先读 `zeka_arch`，再查 `zeka_doc` / `zeka_search`，开发后使用 `zeka_doctor` / `zeka_lint`。

普通用户只需业务项目与可用二进制；不要求检出整个框架。源码仓库用于维护与构建尚未发布的首版工具。
