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


# 消息中间件示例（多通道混合）

同时集成 Kafka 和 RocketMQ 的示例，展示 `cubo-messaging-spring-boot` 在多消息中间件共存场景下的统一抽象能力。

## 运行方式

需要同时启动 Kafka 和 RocketMQ 服务，然后运行示例：

```bash
mvn spring-boot:run
```

## 演示特性

- 多消息中间件同时接入
- 统一消息发送接口
- 不同中间件的通道隔离和路由

## 相关链接

- [[cubo-starter/cubo-messaging-spring-boot/index|消息处理]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-messaging-spring-boot-sample/cubo-messaging-spring-boot-sample-all](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-messaging-spring-boot-sample/cubo-messaging-spring-boot-sample-all)

<!-- 代码链接 -->
