---
published: 2026.05.04
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


# Cubo Starter 示例工程

Cubo Starter 的配套示例工程集合，展示各 Starter 组件的使用方式和最佳实践。

## 示例列表

| 示例 | 说明 | 运行方式 |
|------|------|---------|
| cubo-rest-spring-boot-sample | REST API 规范示例 | Servlet / Reactive 两种模式 |
| cubo-logsystem-spring-boot-sample | 日志体系示例 | Log4j2 / Record / SLF4J 三种模式 |
| cubo-mybatis-spring-boot-sample | 数据访问层示例 | 单库 / 多库 / Active Record / 多租户 |
| cubo-openapi-spring-boot-sample | API 文档示例 | Knife4j / Dubbo 两种模式 |
| cubo-messaging-spring-boot-sample | 消息中间件示例 | Kafka / RocketMQ / 多通道混合 |
| cubo-endpoint-spring-boot-sample | 运维端点示例 | Servlet / Reactive / 非 Web 三种模式 |
| cubo-launcher-spring-boot-sample | 应用启动器示例 | 原始 / Patch / Thin 三种模式 |

## 快速运行

```bash
# 构建整个示例工程
./mvnw clean install -DskipTests

# 运行某个示例（以 REST Servlet 为例）
cd cubo-rest-spring-boot-sample/cubo-rest-spring-boot-sample-servlet
../../mvnw spring-boot:run
```

## 建议阅读顺序

1. 先从 `cubo-rest-spring-boot-sample` 入手，了解统一异常、响应和参数校验
2. 再看 `cubo-logsystem-spring-boot-sample`，了解日志规范
3. 按需查看其他示例

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples)

<!-- 代码链接 -->
