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


# SqlExecuteTimeoutEvent

当 sql 执行时间超过 `zeka-stack.mybatis.performmax-time` 配置的时间会发送 `SqlExecuteTimeoutEvent` 事件, 目前需要业务端自己处理此事件, 推荐存入
mongodb, 后期将通过消息总线统一存储.

# 新增配置

```yaml
zeka-stack:
  mybatis:
    # sql 耗时超过此时间将发送 SqlExecuteTimeoutEvent, 单位毫秒
    performmax-time: 300
    # 输出到日志的 sql 日志是否格式化
    sql-format: false
```

# todo

1. 统一使用 `p6spy` 代替 `PerformanceInterceptor`;
2. 重写 `P6spyAutoConfiguration`, 完成如下功能:
    1. 记录所有的 SQL;
    2. 如果超过配置的执行时间, 则发送 `SqlExecuteTimeoutEvent` 事件;
    3. 自动替换 url, 兼容老的 url, 无需业务端配置;
    4. 修改 `spring.datasource.driver-class-name` 为 `com.p6spy.engine.spy.P6SpyDriver`, 无需业务端配置 (
       dev.dong4j.zeka.kernel.common.constant.ConfigKey.DruidConfigKey.DRIVER_CLASS);
3. 使用消息总线统一存储 SQL 慢日志;
