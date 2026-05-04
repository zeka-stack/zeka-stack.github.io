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


# 多租户示例（表隔离）

基于表（行）隔离的多租户方案示例，通过在 SQL 中动态替换表名实现不同租户的数据隔离。

## 运行方式

```bash
mvn spring-boot:run
```

## 演示特性

| 特性 | 演示类 | 说明 |
|------|--------|------|
| 租户处理器 | `MyTenantHandler` | 根据租户标识动态替换 SQL 中的表名 |
| 租户上下文 | `MyContext` | 维护当前请求的租户标识 |
| MyBatis-Plus 配置 | `MybatisPlusConfig` | 表级多租户拦截器的注册与配置 |
| Mapper 层 | `UserMapper` | 按租户自动路由到对应表 |

## 相关链接

- [[cubo-starter/cubo-mybatis-spring-boot/index|数据访问层]]Mybatis-Plus 实现分表

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-mybatis-spring-boot-sample/cubo-mybatis-spring-boot-sample-tenant/cubo-mybatis-spring-boot-sample-tenant-table](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-mybatis-spring-boot-sample/cubo-mybatis-spring-boot-sample-tenant/cubo-mybatis-spring-boot-sample-tenant-table)

<!-- 代码链接 -->
