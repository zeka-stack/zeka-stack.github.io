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


# 日志系统示例（Log4j2）

基于 Log4j2 的日志体系示例，展示 `cubo-logsystem-log4j2-spring-boot-starter` 的结构化日志和动态日志管理能力。

## 运行方式

```bash
mvn spring-boot:run
```

## 演示特性

| 特性 | 演示类 | 说明 |
|------|--------|------|
| 动态日志级别 | `ChangeLogLevelTest` | 运行时修改日志级别，无需重启 |
| 日志格式切换 | `ChangeLogSystemPatternTest` | 动态切换日志输出格式 |
| 日志文件名变更 | `ChangeLogFileNameTest` | 动态修改日志文件名 |
| 日志配置变更 | `ChangeLogConfigTest` | 运行时更新完整日志配置 |
| 显示调用位置 | `ChangeEnableShowLocationTest` | 开启/关闭日志中的代码位置信息 |

## 测试验证

```bash
mvn test
```

## 相关链接

- [[cubo-starter/cubo-logsystem-spring-boot/index|日志系统]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-logsystem-spring-boot-sample/cubo-logsystem-spring-boot-sample-log4j2](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-logsystem-spring-boot-sample/cubo-logsystem-spring-boot-sample-log4j2)

<!-- 代码链接 -->
