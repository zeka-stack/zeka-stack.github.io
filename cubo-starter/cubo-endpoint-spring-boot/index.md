---
published: 2022.05.02
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


# 端点管理

当前内容对照 3.0.0-SNAPSHOT 源码维护。业务优先采用框架的基类与组件，不复制基础设施实现。

## 组件定位

按 Servlet / Reactive 暴露启动信息、探测及初始化扩展。

当前入口 `cubo-endpoint-servlet-spring-boot-starter` 直接依赖：`cubo-endpoint-servlet`, `spring-boot-starter-web`, `spring-boot-starter-undertow`。底层实现通过 starter 传递引入，不重复手动拼装。


## Starter 选型

- [cubo-endpoint-reactive-spring-boot-starter](https://zekastack.dong4j.site/docs/skills/cubo-endpoint-reactive-spring-boot-starter/SKILL.md)：独立的依赖、选型和编码约定。
- [cubo-endpoint-servlet-spring-boot-starter](https://zekastack.dong4j.site/docs/skills/cubo-endpoint-servlet-spring-boot-starter/SKILL.md)：独立的依赖、选型和编码约定。

## 推荐业务写法

复用 `InitializationService` 扩展预热，按实际初始化流程设计幂等、超时和失败语义。Servlet 与 Reactive 启动信息实现不同，不把内部项目详情端点直接开放到公网。

此组件不是完整的监控或授权系统，健康探测、存活与业务就绪要按项目需求区分。


## 配置与真实默认值

`zeka-stack.endpoint.enabled` 控制带相应 ConditionalOnEnabled 的自动配置。注意 ProjectInfoEndpointAutoConfiguration 仅检查 Servlet Web 条件，不受该开关统一关闭，不能把 enabled=false 当作关闭所有内部端点的安全策略。端点访问由应用网关/安全配置约束。


## 自动配置与扩展

EndpointAutoConfiguration 在 Web 环境、Endpoint 类与开关满足时装配 PreloadComponent（缺少相应 Bean）。ServletStartInfoAutoConfiguration / ReactiveStartInfoAutoConfiguration 按 Web 类型装配启动信息和 InitializationService（缺失时）。Reactive 的 routerFunction 提供 /start 与 /check；不能仅凭 @ReadOperation 推断任意方法已作为 Actuator 端点发布。


## 验证要求

变更后验证实际应用上下文、接口与依赖版本。文档中的示例不是完整业务授权或运行可靠性保证；配置存在不代表所有环境均装配相同能力。框架工程规范维护在根目录 arch.md，可通过 zeka arch / zeka demo 离线查询。

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter/cubo-endpoint-spring-boot](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter/cubo-endpoint-spring-boot)

<!-- 代码链接 -->
