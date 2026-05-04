---
published: 2022.06.27
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


# SPI 机制

## 概述

`blen-kernel-spi` 是 Zeka.Stack 框架的 SPI (Service Provider Interface) 模块，提供了服务提供者接口的实现，支持动态服务发现和加载。该模块基于
Java SPI 机制，提供了更强大的服务扩展能力。

## 主要功能

### 1. SPI 工具类

- **SpiStringUtils**: SPI 字符串工具类
- 支持 SPI 相关的字符串处理
- 提供便捷的工具方法

### 2. 并发支持

- **ConcurrentHashSet**: 并发哈希集合
- 支持线程安全的集合操作
- 提供高性能的并发数据结构

### 3. URL 处理

- **URL**: URL 工具类
- 支持 URL 解析和构建
- 提供 URL 相关的工具方法

### 4. 编译器支持

- **AbstractCompiler**: 抽象编译器
- **JdkCompiler**: JDK 编译器实现
- 支持动态代码编译
- 支持运行时代码生成

## 核心特性

### 1. 服务发现

- 基于 Java SPI 机制
- 支持动态服务加载
- 支持服务优先级管理

### 2. 动态编译

- 支持运行时代码编译
- 支持多种编译器实现
- 支持类加载器管理

### 3. 并发安全

- 线程安全的数据结构
- 支持高并发场景
- 提供性能优化

## 依赖关系

### 核心依赖

- **blen-kernel-common**: 基础功能依赖
- **spring-context**: Spring 上下文支持
- **jakarta.servlet:jakarta.servlet-api**: Servlet API

## 使用方式

### 1. 添加依赖

```xml
<dependency>
    <groupId>dev.dong4j</groupId>
    <artifactId>blen-kernel-spi</artifactId>
    <version>${blen-kernel.version}</version>
</dependency>
```

### 2. 服务提供者实现

```java
public class CustomServiceProvider implements ServiceProvider {

    @Override
    public String getServiceName() {
        return "custom-service";
    }

    @Override
    public Object getService() {
        return new CustomServiceImpl();
    }
}
```

### 3. 服务发现

```java
@Service
public class ServiceDiscovery {

    public <T> T getService(Class<T> serviceClass) {
        ServiceLoader<T> serviceLoader = ServiceLoader.load(serviceClass);
        return serviceLoader.findFirst().orElse(null);
    }
}
```

### 4. 动态编译

```java
@Service
public class DynamicCompiler {

    private final JdkCompiler compiler = new JdkCompiler();

    public Class<?> compile(String className, String sourceCode) {
        return compiler.compile(className, sourceCode);
    }
}
```

## 配置说明

### SPI 配置

```properties
# SPI 配置
blen.spi.enabled=true
blen.spi.scan-packages=com.example.spi
```

## 版本历史

- **1.0.0**: 初始版本，基础 SPI 功能

## 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这个模块。

## 许可证

MIT License

---

## 📦 代码示例

查看完整代码示例：

[blen-kernel/blen-kernel-spi](https://github.com/dong4j/zeka.stack/tree/main/blen-kernel/blen-kernel-spi)

<!-- 代码链接 -->
