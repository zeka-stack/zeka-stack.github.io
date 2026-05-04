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


# REST API Reactive 示例

基于 Spring WebFlux 的响应式 Web 应用示例，展示 `cubo-rest-spring-boot` 在非阻塞 IO 场景下的使用方式。

## 运行方式

```bash
mvn spring-boot:run
```

## 演示特性

| 特性 | 说明 |
|------|------|
| 响应式编程 | 使用 Mono 和 Flux 处理异步请求 |
| 统一响应封装 | 响应式环境下同样使用 `R.succeed()` / `R.failed()` |
| 非阻塞 IO | 高并发场景下的性能优势 |

## 最小示例

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

- [[cubo-starter/cubo-rest-spring-boot/index|REST API 组件]]


---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-rest-spring-boot-sample/cubo-rest-spring-boot-sample-reactive](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-rest-spring-boot-sample/cubo-rest-spring-boot-sample-reactive)

<!-- 代码链接 -->
