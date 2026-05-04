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


# REST API 示例

## 概述

本示例项目展示了如何使用 `cubo-rest-spring-boot` 组件开发 RESTful API，包含 Servlet 和 Reactive 两种 Web 技术栈的完整示例。

## 子模块说明

### 1. cubo-rest-spring-boot-sample-servlet

基于 Spring MVC 的传统 Servlet Web 应用示例，展示了：

- **统一异常处理**：全局异常处理器自动捕获并格式化异常响应
- **参数验证**：基于 Bean Validation 的请求参数自动验证
- **响应封装**：统一的 API 响应格式，自动包装返回结果
- **配置热更新**：非 Spring Cloud 环境下的配置动态刷新
- **API 文档**：集成 Knife4j 自动生成和展示 API 文档
- **端点管理**：应用监控和管理端点

#### 核心特性演示

- 异常处理示例：`UserController` 展示了各种异常场景的处理
- 参数验证示例：`ResponseWrapperController` 展示了请求参数验证
- 配置热更新：`HotReloadController` 演示了配置动态刷新功能
- 字符串自动 Trim：`SpringTrimController` 展示了请求参数自动去除空格

### 2. cubo-rest-spring-boot-sample-reactive

基于 Spring WebFlux 的响应式 Web 应用示例，展示了：

- **响应式编程**：使用 Mono 和 Flux 处理异步请求
- **非阻塞 IO**：高并发场景下的性能优势
- **统一异常处理**：响应式环境下的异常处理机制

## 快速开始

### 运行 Servlet 示例

```bash
cd cubo-rest-spring-boot-sample-servlet
mvn spring-boot:run
```

访问 API 文档：http://localhost:8080/doc.html

### 运行 Reactive 示例

```bash
cd cubo-rest-spring-boot-sample-reactive
mvn spring-boot:run
```

## 高阶用法

### 1. 自定义异常处理

```java
@RestController
public class CustomController {
    
    @GetMapping("/test")
    public Result<String> test() {
        // 抛出业务异常，会被全局异常处理器自动捕获
        throw new BusinessException("业务异常");
    }
}
```

### 2. 参数验证

```java
@PostMapping("/user")
public Result<User> createUser(@Valid @RequestBody UserCreateRequest request) {
    // 参数会自动验证，验证失败会返回统一错误响应
    return R.succeed(userService.create(request));
}
```

### 3. 配置热更新

```java
@RestController
public class ConfigController {
    
    @Value("${app.name}")
    private String appName;
    
    @PostMapping("/reload")
    public Result<String> reloadConfig() {
        // 调用配置刷新接口后，@Value 注解的值会自动更新
        return R.succeed(appName);
    }
}
```

### 4. 响应式编程

```java
@RestController
public class ReactiveController {
    
    @GetMapping("/users")
    public Mono<Result<List<User>>> getUsers() {
        return userService.findAll()
            .map(R::succeed);
    }
}
```

## 相关链接

- [[cubo-starter/cubo-rest-spring-boot/index|REST API]]

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-rest-spring-boot-sample](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-rest-spring-boot-sample)

<!-- 代码链接 -->
