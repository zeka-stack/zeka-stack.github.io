---
published: 2022.05.16
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


# 组合器模块

组合器只聚合依赖，不定义新的配置或 Bean。下面的内容以当前 POM 为准，不能把规划能力当成已经提供的功能。

| 入口 | 实际依赖 |
| --- | --- |
| cubo-framework-spring-boot-starter | cubo-launcher-spring-boot-starter、cubo-logsystem-log4j2-spring-boot-starter |
| cubo-ssm-spring-boot-starter | framework、rest-servlet、openapi-knife4j、endpoint-servlet、mybatis、spring-boot-starter-actuator |

framework 不包含 REST 或数据库；SSM 不包含 messaging。按需要额外选择 Kafka/RocketMQ starter。版本通过业务 BOM 管理，避免重复引入 framework 或混入 Reactive。

## 使用方式

```xml
<dependency>
    <groupId>dev.dong4j</groupId>
    <artifactId>cubo-ssm-spring-boot-starter</artifactId>
</dependency>
```

启动类 extends ZekaStarter；Servlet Controller 使用 RestControllerWrapper / ServletController，返回 DTO 或 void 交由统一 Advice 包装。业务错误使用 BaseCodes 或 LowestExceptionAssert，DAO / Service 复用 BaseDao / BaseService / BaseServiceImpl，不创建自定义 ApiResponse。

## 配置与扩展

配置归各组件所有：zeka-stack.app、logging、rest、mybatis、openapi、endpoint。组合器没有额外的“统一覆盖”开关，也不承诺所有 Bean 都能直接替换。根据各自动配置的实际条件定制并验证应用上下文。

## 自包含 Skills

- [framework Skill](https://zekastack.dong4j.site/docs/skills/cubo-framework-spring-boot-starter/SKILL.md)
- [SSM Skill](https://zekastack.dong4j.site/docs/skills/cubo-ssm-spring-boot-starter/SKILL.md)

业务完整范例可使用 zeka demo，规范使用 zeka arch。

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter/cubo-combiner-spring-boot](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter/cubo-combiner-spring-boot)

<!-- 代码链接 -->
