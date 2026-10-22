---
published: 2022.04.25
---

<p style="text-align:center; white-space:nowrap; overflow-x:auto; padding-bottom:4px;">
  <img src="https://img.shields.io/badge/Spring%20Boot-3.x-6DB33F?style=flat-square&amp;logo=spring" alt="Spring Boot 3.x" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/JDK-17%2B-007396?style=flat-square&amp;logo=java" alt="JDK17+" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/AI-enabled-FF6B6B?style=flat-square" alt="AI" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5-guided-845EC2?style=flat-square" alt="最佳实践" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E6%B5%8B%E8%AF%95%E9%A9%B1%E5%8A%A8-TDD-1F7A8C?style=flat-square" alt="测试驱动" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E5%8D%95%E4%BD%93%E6%9E%B6%E6%9E%84-supported-5C7AEA?style=flat-square" alt="单体架构" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E5%BE%AE%E6%9C%8D%E5%8A%A1%E6%9E%B6%E6%9E%84-ready-1B9AAA?style=flat-square" alt="微服务架构" style="display:inline-block; vertical-align:middle;" />
</p>


# API 文档

当前内容对照 3.0.0-SNAPSHOT 源码维护。业务优先采用框架的基类与组件，不复制基础设施实现。

## 组件定位

HTTP Knife4j 或 Dubbo 元数据文档，按技术栈选择。

当前入口 `cubo-openapi-knife4j-spring-boot-starter` 直接依赖：`cubo-openapi-knife4j`。底层实现通过 starter 传递引入，不重复手动拼装。


## Starter 选型

- [cubo-openapi-dubbo-spring-boot-starter](https://zekastack.dong4j.site/docs/skills/cubo-openapi-dubbo-spring-boot-starter/SKILL.md)：独立的依赖、选型和编码约定。
- [cubo-openapi-knife4j-spring-boot-starter](https://zekastack.dong4j.site/docs/skills/cubo-openapi-knife4j-spring-boot-starter/SKILL.md)：独立的依赖、选型和编码约定。

## 推荐业务写法

HTTP API 使用 @Tag / @Operation / @Schema，查询对象使用 @ParameterObject；文档必须与真实路径、校验和返回模型一致，统一响应以 Result 契约为准。

Dubbo 变体为 Dubbo 接口文档能力，当前 starter 传递引入 endpoint-servlet，不能视为纯 RPC 或纯 Reactive 无 Web 依赖。不要将两个变体视为同一套自动装配。


## 配置与真实默认值

`zeka-stack.openapi.enabled` 为自动配置开关。Knife4j 自动配置受 Servlet、类路径与非生产 Profile 约束；不能假定生产会开放 doc.html。原生 springdoc / knife4j 参数遵循项目实际依赖版本。


## 自动配置与扩展

OpenAPIAutoConfiguration 标记组件，Knife4jAutoConfiguration 提供 Knife4jOpenApiCustomizer 和 JakartaProductionSecurityFilter（非生产 Servlet 条件）。这些 Bean 没有统一的 MissingBean 覆盖保证，不盲目重复注册。

Dubbo 能力由 cubo-openapi-dubbo 引入，具体可用端点以部署时实际接口元数据和环境验证。


## 验证要求

变更后验证实际应用上下文、接口与依赖版本。文档中的示例不是完整业务授权或运行可靠性保证；配置存在不代表所有环境均装配相同能力。框架工程规范维护在根目录 arch.md，可通过 zeka arch / zeka demo 离线查询。

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter/cubo-openapi-spring-boot](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter/cubo-openapi-spring-boot)

<!-- 代码链接 -->
