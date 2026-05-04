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


# 多租户示例

展示 `cubo-mybatis-spring-boot-starter` 的三种多租户数据隔离方案。

## 子模块说明

| 子模块 | 隔离方式 | 说明 |
|--------|---------|------|
| cubo-mybatis-spring-boot-sample-tenant-field | 字段隔离 | SQL 中自动追加租户字段条件 |
| cubo-mybatis-spring-boot-sample-tenant-table | 表隔离 | SQL 中动态替换表名 |
| cubo-mybatis-spring-boot-sample-tenant-table-by-sharding | 分片路由 | 自定义分片算法按租户路由 |

## 相关链接

- [[cubo-starter/cubo-mybatis-spring-boot/index|数据访问层]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-mybatis-spring-boot-sample/cubo-mybatis-spring-boot-sample-tenant](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-mybatis-spring-boot-sample/cubo-mybatis-spring-boot-sample-tenant)

<!-- 代码链接 -->
