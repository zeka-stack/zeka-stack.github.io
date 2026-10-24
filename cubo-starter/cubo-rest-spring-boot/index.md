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


# REST API

当前内容对照 3.0.0-SNAPSHOT 源码维护。业务优先采用框架的基类与组件，不复制基础设施实现。

## 组件定位

按应用类型选择 Servlet 或 Reactive，提供 REST 配置与异常处理。

当前入口 `cubo-rest-servlet-spring-boot-starter` 直接依赖：`cubo-rest-servlet`, `spring-boot-starter-web`, `spring-boot-starter-undertow`, `log4j-web`。底层实现通过 starter 传递引入，不重复手动拼装。


## Starter 选型

- [cubo-rest-reactive-spring-boot-starter](https://zekastack.dong4j.site/docs/skills/cubo-rest-reactive-spring-boot-starter/SKILL.md)：独立的依赖、选型和编码约定。
- [cubo-rest-servlet-spring-boot-starter](https://zekastack.dong4j.site/docs/skills/cubo-rest-servlet-spring-boot-starter/SKILL.md)：独立的依赖、选型和编码约定。

Servlet 与 Reactive 分别选对应 starter；下述业务写法为 Servlet，WebFlux 不使用 ServletController / Advice / Filter。

## 推荐业务写法

Servlet 业务 Controller 使用 `@RestControllerWrapper("/accounts")`，继承 `ServletController`，构造注入 Service，返回 DTO、集合、IPage 或 void，由 Advice 包装成 `Result<T>`。已有显式 `R.succeed()` 写法保持一致。失败使用 `BaseCodes.PARAM_VERIFY_ERROR` 等真实错误码，业务枚举实现 LowestExceptionAssert；不得引用不存在的 ResultCodeEnum。

自动包装要求包名符合 RestUtils 判定：默认包含 `dev.dong4j.zeka`，自定义根包通过 JVM `-DPARENT_PACKAGE_NAME=...` 并验证接口。原始文件下载用 `@OriginalResponse`。

Query/Form/DTO 继承 BaseQuery/BaseForm/BaseDTO；使用 Jakarta Validation 和 OpenAPI 注解，Controller 不直连 Mapper。


## 配置与真实默认值

`zeka-stack.rest.enabled` 控制相应自动配置；read-timeout / write-timeout 默认 5000ms，connect-timeout 默认 3000ms；json.date-format 默认 yyyy-MM-dd HH:mm:ss，json.time-zone 来自 DEFAULT_TIME_ZONE（GMT+8），default-property-inclusion 为 non_null。

Servlet 的 `zeka-stack.rest.xss.enable-xss-filter` 默认 true；enable-global-cache-filter、enable-exception-filter 默认 true；enable-global-parameter-filter 默认 false。这些 Servlet 配置不应当作 WebFlux 的同等能力。


## 自动配置与扩展

ServletGlobalExceptionAutoConfiguration 在 Servlet 类路径和 Web 类型满足时装配 ErrorAttributes、错误 Controller / Handler；对应 Bean 有缺失条件。RestTemplate 的默认 Bean 有 MissingBean 条件；HTTP 工厂和其他辅助 Bean 不都可直接替换。

Reactive 使用 WebfluxGlobalExceptionAutoConfiguration / WebFluxAutoConfiguration，装配对应 ErrorAttributes 与 ErrorWebExceptionHandler；不得注册 Servlet Advice / Filter 代替。


## 验证要求

变更后验证实际应用上下文、接口与依赖版本。文档中的示例不是完整业务授权或运行可靠性保证；配置存在不代表所有环境均装配相同能力。框架工程规范维护在根目录 arch.md，可通过 zeka arch / zeka demo 离线查询。

## 深入阅读

- [detail-api-version-control](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-api-version-control.html)
- [detail-design](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-design.html)
- [detail-okhttp-connection-pool-configuration](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-okhttp-connection-pool-configuration.html)
- [detail-parameter-validation](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-parameter-validation.html)
- [detail-spring-boot-3-upgrade](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-spring-boot-3-upgrade.html)
- [detail-unified-exception-handler](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-unified-exception-handler.html)
- [detail-unified-response-wrapper](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-unified-response-wrapper.html)
- [detail-xss-protection](https://zekastack.dong4j.site/docs/cubo-starter/cubo-rest-spring-boot/detail-xss-protection.html)

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter/cubo-rest-spring-boot](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter/cubo-rest-spring-boot)

<!-- 代码链接 -->
