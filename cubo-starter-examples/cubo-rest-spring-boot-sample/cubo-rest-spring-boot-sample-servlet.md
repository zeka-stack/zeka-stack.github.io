---
published: 2026.05.04
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


# REST API Servlet 示例

基于 Spring MVC 的传统 Servlet Web 应用示例，展示 `cubo-rest-spring-boot` 的核心能力。

## 运行方式

```bash
mvn spring-boot:run
```

启动后访问 API 文档：http://localhost:8080/doc.html

## 演示特性

| 特性 | 演示类 | 说明 |
|------|--------|------|
| 统一异常处理 | `UserController` | 各种异常场景的自动捕获和格式化响应 |
| 参数验证 | `ResponseWrapperController` | Bean Validation 自动校验请求参数 |
| 配置热更新 | `HotReloadController` | 非 Spring Cloud 环境下的配置动态刷新 |
| 字符串自动 Trim | `SpringTrimController` | 请求参数自动去除首尾空格 |
| 统一响应封装 | 全局生效 | `R.succeed()` / `R.failed()` 统一响应格式 |
| Knife4j 文档 | 自动集成 | 无需额外配置即生成 API 文档 |

## 最小示例

```java
@RestController
public class UserController {

    @GetMapping("/user/{id}")
    public Result<User> getUser(@PathVariable Long id) {
        return R.succeed(userService.getById(id));
    }

    @PostMapping("/user")
    public Result<User> createUser(@Valid @RequestBody UserCreateRequest request) {
        return R.succeed(userService.create(request));
    }
}
```

## 相关链接

- [[cubo-starter/cubo-rest-spring-boot/index|REST API 组件]]

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-rest-spring-boot-sample/cubo-rest-spring-boot-sample-servlet](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-rest-spring-boot-sample/cubo-rest-spring-boot-sample-servlet)

<!-- 代码链接 -->
