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


# 端点管理示例

## 概述

本示例项目展示了如何使用 `cubo-endpoint-spring-boot` 组件进行应用监控和管理，支持 Servlet 和 Reactive 两种 Web 技术栈。

## 子模块说明

### 1. cubo-endpoint-spring-boot-sample-servlet

**Servlet 端点示例**，展示了：

- 应用信息端点
- 健康检查端点
- 性能监控端点
- 自定义管理端点

### 2. cubo-endpoint-spring-boot-sample-reactive

**Reactive 端点示例**，展示了：

- 响应式环境下的端点管理
- 非阻塞的监控数据收集

### 3. cubo-endpoint-spring-boot-sample-noweb

**非 Web 应用端点示例**，展示了：

- 非 Web 环境下的端点访问
- 通过 JMX 访问端点

## 快速开始

### 运行 Servlet 示例

```bash
cd cubo-endpoint-spring-boot-sample-servlet
mvn spring-boot:run
```

访问端点：

- 应用信息：http://localhost:8080/actuator/info
- 健康检查：http://localhost:8080/actuator/health
- 所有端点：http://localhost:8080/actuator

### 运行 Reactive 示例

```bash
cd cubo-endpoint-spring-boot-sample-reactive
mvn spring-boot:run
```

## 高阶用法

### 1. 自定义应用信息

```yaml
info:
  app:
    name: @project.name@
    version: @project.version@
    description: 应用描述
  build:
    time: @maven.build.timestamp@
```

### 2. 健康检查配置

```yaml
management:
  health:
    enabled: true
    show-details: when-authorized
    db:
      enabled: true
    redis:
      enabled: true
```

### 3. 自定义健康指示器

```java
@Component
public class CustomHealthIndicator implements HealthIndicator {

    @Override
    public Health health() {
        // 自定义健康检查逻辑
        if (isHealthy()) {
            return Health.up()
                .withDetail("status", "正常")
                .build();
        }
        return Health.down()
            .withDetail("status", "异常")
            .build();
    }
}
```

### 4. 端点安全配置

```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,info
      base-path: /actuator
  endpoint:
    health:
      roles: ADMIN
```

### 5. 自定义端点

```java
@Component
@Endpoint(id = "custom")
public class CustomEndpoint {

    @ReadOperation
    public Map<String, Object> custom() {
        Map<String, Object> info = new HashMap<>();
        info.put("custom", "value");
        return info;
    }
}
```

### 6. 性能监控

```yaml
management:
  metrics:
    export:
      prometheus:
        enabled: true
  endpoint:
    metrics:
      enabled: true
```

## 相关链接

- [[cubo-starter/cubo-endpoint-spring-boot/index|端点管理]]

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-endpoint-spring-boot-sample](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-endpoint-spring-boot-sample)

<!-- 代码链接 -->
