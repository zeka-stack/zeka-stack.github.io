---
published: 2022.04.04
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


# REST 组件设计

## 模块边界

core 下包含 common、servlet、reactive；autoconfigure 绑定配置并按技术栈装配；两个具体 starter 分别提供 Servlet 和 WebFlux 的依赖入口。core 中存在 Spring Web 等依赖，不能笼统称为无 Spring 依赖的纯业务库。

## 业务入口

Servlet 使用 @RestControllerWrapper / ServletController，构造注入 Service，返回 DTO/IPage/void，由 ResponseWrapperAdvice 包装 Result。不要复制一套全局异常处理器或 ApiResponse。默认包前缀 dev.dong4j.zeka，自定义包需要 JVM PARENT_PACKAGE_NAME 与接口验证。

WebFlux 按 Reactor 与当前 WebfluxGlobalExceptionAutoConfiguration 使用，不套用 Servlet Advice、Filter 或 ServletController；阻塞式持久化调用需要明确线程调度边界。

## 配置与扩展

RestProperties 的前缀 zeka-stack.rest，read/write timeout 默认 5000ms，connect timeout 为 3000ms。没有 servlet.enabled / reactive.enabled，技术栈由依赖与 WebApplication 条件决定。JSON、XSS、连接池及过滤器的真实配置见 [组件概述](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/index.html)。

统一异常来自框架既有处理器，通用错误 BaseCodes 与业务 LowestExceptionAssert 转为 Result。只有具体 Bean 声明 MissingBean 条件时才按该条件覆盖；不要通过返回 null 或重复注册全局处理器禁用能力。

## 实现与验证

[响应包装](detail-unified-response-wrapper.md) 记录了实际实现摘录及注解契约；[参数校验](detail-parameter-validation.md)、[XSS](detail-xss-protection.md) 和 [异常处理](detail-unified-exception-handler.md) 说明对应能力。新业务代码遵守 arch.md，使用 zeka demo 对照完整模块，验证实际响应和校验行为。
