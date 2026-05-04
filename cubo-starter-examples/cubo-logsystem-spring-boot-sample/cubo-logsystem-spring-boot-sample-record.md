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


# 日志系统示例（Record）

日志记录存储示例，展示 `cubo-logsystem-record-spring-boot-starter` 将日志持久化到数据库的能力。

## 运行方式

```bash
mvn spring-boot:run
```

## 演示特性

| 特性 | 演示类 | 说明 |
|------|--------|------|
| 系统日志存储 | `SystemLogStorageService` | 系统操作日志写入数据库 |
| API 日志存储 | `ApiLogStorageService` | HTTP 请求/响应日志写入数据库 |
| 错误日志存储 | `ErrorLogStorageService` | 异常错误日志写入数据库 |
| 日志配置 | `LoggingConfiguration` | 日志存储的自定义配置 |

## 相关链接

- [[cubo-starter/cubo-logsystem-spring-boot/index|日志系统]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-logsystem-spring-boot-sample/cubo-logsystem-spring-boot-sample-record](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-logsystem-spring-boot-sample/cubo-logsystem-spring-boot-sample-record)

<!-- 代码链接 -->
