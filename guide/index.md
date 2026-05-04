# Zeka Stack 使用指南

## 简介 

Zeka Stack 是一套面向企业级 Java 微服务开发的工程体系，提供从构建规范、基础内核、Starter 组件到中间件编排的全栈能力。

## 你能在这里做什么

- **了解框架**：通过[简介](./1.introduction)了解 Zeka Stack 的定位、分层设计和核心价值
- **快速上手**：通过[快速开始](./2.quick-start)从零构建并运行第一个示例工程
- **查找资源**：通过[资源汇总](./3.resources)找到源码、示例、模块文档和推荐学习路径

## 适用场景

| 适合 | 不适合 |
|------|--------|
| 需要统一构建规范的团队 | 只需要单个工具类库 |
| Spring Boot 3.x + JDK 17 的新项目 | 无法升级到 JDK 17 的遗留项目 |
| 希望规范异常、日志、接口风格 | 只做原型验证，不关心工程规范 |
| 需要中间件统一接入（Nacos、Sentinel 等） | 不使用 Spring 生态 |

## 仓库结构概览

Zeka Stack 采用分层架构，每一层解决不同层级的问题：

```
Arco 构建基础层     → 统一构建配置、依赖管理、编译时增强
Blen Kernel        → 通用基础能力：统一异常、日志、校验、链路追踪
Cubo Starter       → Spring Boot Starter 集合：REST、MyBatis、日志、OpenAPI...
Domi Suite         → 基础微服务套件：认证、网关、用户管理
Eiko Orch          → 中间件编排：APM、缓存、调度、流控
Felo Space         → 业务示例工程：商城、支付
```

对于大多数使用者，建议从 **Cubo Starter** 和 **示例工程**入手。
