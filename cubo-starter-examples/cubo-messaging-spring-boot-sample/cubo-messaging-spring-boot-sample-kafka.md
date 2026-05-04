---
published: 2022.05.23
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


# 消息中间件示例（Kafka）

基于 Kafka 的消息处理示例，展示 `cubo-messaging-kafka-spring-boot-starter` 的消息发送和消费能力。

## 运行方式

需要先启动 Kafka 服务，然后运行示例：

```bash
mvn spring-boot:run
```

## 演示特性

| 特性 | 演示类 | 说明 |
|------|--------|------|
| Kafka 模板发送 | `KafkaTemplateTest` | 使用 `KafkaTemplate` 发送消息 |
| 消息模板 | `MessageTemplateTest` | 统一消息模板的使用方式 |
| 业务对象 | `Order` / `Payment` | 业务领域对象作为消息体的序列化方式 |

## 相关链接

- [[cubo-starter/cubo-messaging-spring-boot/index|消息处理]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-messaging-spring-boot-sample/cubo-messaging-spring-boot-sample-kafka](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-messaging-spring-boot-sample/cubo-messaging-spring-boot-sample-kafka)

<!-- 代码链接 -->
