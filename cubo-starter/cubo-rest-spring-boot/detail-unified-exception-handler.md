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


# 统一异常处理

当前版本已提供全局处理器，业务应复用 BaseCodes / LowestExceptionAssert，不再复制一套全局 Advice。本说明针对真实实现，示例省略业务类型。

## 处理链

| 层 | 实际类型 | 作用 |
| --- | --- | --- |
| 公共异常 | kernel.common.exception.GlobalExceptionHandler | LowestException、校验异常、网络及兜底异常 |
| Servlet | kernel.web.exception.ServletGlobalExceptionHandler | Servlet 参数与请求相关异常 |
| REST Servlet | starter.rest.advice.RestGlobalExceptionHandler | 继承 Servlet 处理链，接入 REST |
| Servlet 错误属性 | ZekaServletExceptionErrorAttributes | 与默认错误入口协作 |
| Reactive | ZekaWebfluxExceptionErrorAttributes / JsonErrorWebExceptionHandler | WebFlux 对应错误处理，不套用 Servlet Advice |

各类型使用 dev.dong4j.zeka 包前缀。实际装配由 ServletGlobalExceptionAutoConfiguration / WebfluxGlobalExceptionAutoConfiguration 的类路径、Web 类型、开关与 MissingBean 条件决定。

## 业务代码

```java
// 公共参数或数据约束直接使用框架断言。
BaseCodes.PARAM_VERIFY_ERROR.isTrue(valid);
BaseCodes.DATA_ERROR.notNull(account);
BaseCodes.OPTION_FAILURE.isTrue(updatedCount == 1);
```

业务错误枚举 implements LowestExceptionAssert，提供 Integer code / String message，直接调用枚举 notNull/isTrue/notBlank/fail 创建 LowestException。错误码区间按项目分配，不能临时使用 HTTP 状态码冒充业务码。

正常 Controller 返回 DTO/void，Advice 包装结果。显式包装使用 R.succeed / R.failed；Result 是模型，没有 Result.fail 或 Result.success 静态工厂。不要捕获所有异常再返回错误 Map 或伪成功。

## 环境与信息暴露

GlobalExceptionHandler.buildResult 在生产环境返回错误码与业务消息，非生产环境附加异常上下文 extend。兜底 backstopHandle 在生产使用 SERVER_ERROR 的受控消息，非生产可以使用 SERVER_INNER_ERROR 并附上下文。

不要在业务错误消息放数据库 SQL、请求凭据或完整隐私字段；环境配置错误可能改变输出，必须验证实际生产 Profile 和响应。自定义处理器时不能绕过统一模型，也不能假定所有异常都对应相同 HTTP 状态。

## 验证

覆盖 LowestException、字段校验、请求参数异常、未知异常、生产/非生产输出与 traceId。新增异常处理扩展需要验证异常处理器优先级，避免宽泛 Advice 抢占已有链路。
