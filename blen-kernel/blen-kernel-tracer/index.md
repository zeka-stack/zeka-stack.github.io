---
published: 2022.07.04
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


# 链路追踪

## 概述

`blen-kernel-tracer` 是 Zeka.Stack 框架的链路追踪模块，提供了分布式系统的链路追踪功能。该模块支持请求链路追踪、性能监控、调用链分析等功能，帮助开发者快速定位和解决系统问题。

## 主要功能

### 1. 链路追踪

- 支持分布式请求追踪
- 支持调用链分析
- 支持性能监控

### 2. 监控支持

- 支持请求监控
- 支持性能指标收集
- 支持异常监控

### 3. 日志集成

- 支持结构化日志
- 支持链路 ID 传递
- 支持日志关联

## 核心特性

### 1. 分布式追踪

- 支持跨服务调用追踪
- 支持异步调用追踪
- 支持消息队列追踪

### 2. 性能监控

- 支持响应时间监控
- 支持吞吐量监控
- 支持错误率监控

### 3. 可视化支持

- 支持调用链可视化
- 支持性能图表
- 支持异常分析

## 依赖关系

### 核心依赖

- 无外部依赖，基于 `blen-kernel-common` 模块

## 使用方式

### 1. 添加依赖

```xml
<dependency>
    <groupId>dev.dong4j</groupId>
    <artifactId>blen-kernel-tracer</artifactId>
    <version>${blen-kernel.version}</version>
</dependency>
```

### 2. 基础使用

```java
@Service
public class UserService {

    public User getUser(Long id) {
        // 链路追踪会自动记录方法调用
        return userRepository.findById(id);
    }
}
```

### 3. 自定义追踪

```java
@Component
public class CustomTracer {

    public void trace(String operation, Runnable task) {
        // 自定义追踪逻辑
        long startTime = System.currentTimeMillis();
        try {
            task.run();
        } finally {
            long duration = System.currentTimeMillis() - startTime;
            log.info("操作 {} 耗时 {}ms", operation, duration);
        }
    }
}
```

## 配置说明

### 追踪配置

```yaml
blen:
  tracer:
    enabled: true
    sampling:
      rate: 1.0
    export:
      endpoint: http://tracer-server:9411/api/v2/spans
```

## 版本历史

- **1.0.0**: 初始版本，基础追踪功能

## 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这个模块。

## 许可证

MIT License

---

## 📦 代码示例

查看完整代码示例：

[blen-kernel/blen-kernel-tracer](https://github.com/dong4j/zeka.stack/tree/main/blen-kernel/blen-kernel-tracer)

<!-- 代码链接 -->
