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


# 运维端点示例（Servlet）

基于 Spring MVC 的运维端点示例，展示 `cubo-endpoint-servlet-spring-boot-starter` 在 Servlet 环境下的健康检查和指标暴露能力。

## 运行方式

```bash
mvn spring-boot:run
```

启动后访问端点页面：http://localhost:8080/actuator

## 演示特性

| 特性 | 说明 |
|------|------|
| 健康检查端点 | 应用健康状态自动检测和报告 |
| 指标暴露 | JVM、HTTP、自定义指标的采集与暴露 |
| 管理端点 | 应用运行时管理操作 |

## 相关链接

- [[cubo-starter/cubo-endpoint-spring-boot/index|运维端点]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-endpoint-spring-boot-sample/cubo-endpoint-spring-boot-sample-servlet](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-endpoint-spring-boot-sample/cubo-endpoint-spring-boot-sample-servlet)

<!-- 代码链接 -->
