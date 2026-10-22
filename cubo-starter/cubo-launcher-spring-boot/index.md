---
published: 2022.03.21
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


# 应用启动器

当前内容对照 3.0.0-SNAPSHOT 源码维护。业务优先采用框架的基类与组件，不复制基础设施实现。

## 组件定位

ZekaStack 应用需要统一启动、运行类型识别及生命周期扩展。

当前入口 `cubo-launcher-spring-boot-starter` 直接依赖：`cubo-launcher-spring-boot-autoconfigure`, `cubo-launcher-spring-boot-core`。底层实现通过 starter 传递引入，不重复手动拼装。


## Starter 选型

- [cubo-launcher-spring-boot-starter](https://zekastack.dong4j.site/docs/skills/cubo-launcher-spring-boot-starter/SKILL.md)：独立的依赖、选型和编码约定。

## 推荐业务写法

依赖启动核心与自动配置；启动类继承 `dev.dong4j.zeka.starter.launcher.ZekaStarter`，加 `@SpringBootApplication`，默认不另写 main。可重写 `before()` / `run(String... args)` / `after()`，非 Web 用 `@RunningType(ApplicationType.SERVICE)`。

```java
package dev.dong4j.zeka.demo;
import dev.dong4j.zeka.starter.launcher.ZekaStarter;
import org.springframework.boot.autoconfigure.SpringBootApplication;
/** 进入框架统一生命周期。 */
@SpringBootApplication
public class DemoApplication extends ZekaStarter { }
```

扫描根包默认 `dev.dong4j.zeka`，自定义包须在启动 JVM 前设 `-DPARENT_PACKAGE_NAME=com.example`。显式 API 可用 `ZekaStarter.run(DemoApplication.class, args)`；不要臆造 ZekaApplication 的重载。

启动类入口与构建生成的 start.class 一起验证。


## 配置与真实默认值

`zeka-stack.app.enable-banner` 默认 false；`app.group/config-group/discovery-group/custom` 在 `zeka-stack` 下。`zeka-stack.extend.enable-autowired-is-null` / `enable-resource-is-null` 默认 false，不以允许缺失注入替代正确依赖。

配置热更新受 RefreshScope 相关类路径和自动配置条件控制；当前条件使用 `LauncherProperties.PREFIX + "refresh"`（没有分隔点），不可声称配置 `zeka-stack.app.refresh` 一定生效，需在所用版本验证。


## 自动配置与扩展

LauncherAutoConfiguration 负责绑定启动属性。RefreshScopeRegistry、DynamicConfigLoader、RefreshScopeRefresher、ConfigFileWatcherRunner 在 RefreshScope 条件满足且缺少对应 Bean 时装配。配置监听器不是跨进程配置中心，不把本地文件变更视为分布式一致性。


## 验证要求

变更后验证实际应用上下文、接口与依赖版本。文档中的示例不是完整业务授权或运行可靠性保证；配置存在不代表所有环境均装配相同能力。框架工程规范维护在根目录 arch.md，可通过 zeka arch / zeka demo 离线查询。

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter/cubo-launcher-spring-boot](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter/cubo-launcher-spring-boot)

<!-- 代码链接 -->
