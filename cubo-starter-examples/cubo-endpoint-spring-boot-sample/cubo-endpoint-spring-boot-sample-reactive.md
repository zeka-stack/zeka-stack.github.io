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


# 运维端点示例（Reactive）

基于 Spring WebFlux 的运维端点示例，展示 `cubo-endpoint-reactive-spring-boot-starter` 在响应式环境下的健康检查和指标暴露能力。

## 运行方式

```bash
mvn spring-boot:run
```

启动后访问端点页面：http://localhost:8080/actuator

## 演示特性

- 响应式环境下的健康检查端点
- 非阻塞的指标采集和暴露
- WebFlux 环境下的管理端点集成

## 相关链接

- [[cubo-starter/cubo-endpoint-spring-boot/index|运维端点]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-endpoint-spring-boot-sample/cubo-endpoint-spring-boot-sample-reactive](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-endpoint-spring-boot-sample/cubo-endpoint-spring-boot-sample-reactive)

<!-- 代码链接 -->
