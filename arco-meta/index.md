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


# Arco Meta

## 简介

Arco Meta 是 Zeka Stack 的构建基础层集合，提供统一的父 POM、依赖管理、构建插件体系与编译期增强能力。该目录聚合了整个生态的“构建规范与自动化能力”，其他模块通常通过继承父
POM 或引入插件来复用这些能力。

## 模块组成

- `arco-supreme/`：全局基础父项目，统一依赖版本与插件版本的顶层基座。
- `arco-builder/`：构建框架总控，提供多层 parent 设计（业务型/组件型父 POM）。
- `arco-maven-plugin/`：Maven 插件体系（构建自动化、质量检查、部署、脚本与容器化）。
- `arco-processor/`：编译期注解处理器，自动生成 Spring Boot 配置与 SPI 文件。

## 继承关系概览

推荐的父 POM 继承关系如下（详见各子模块 README）：

```
arco-supreme
└── arco-builder
    └── arco-dependencies-parent
        └── arco-project-dependencies
            └── arco-project-builder
                ├── arco-business-parent
                └── arco-component-parent
```

选择建议：

- 业务型项目：使用 `arco-business-parent`
- 组件/SDK：使用 `arco-component-parent`

## 常见用法

在业务项目的 `pom.xml` 中继承父 POM：

```xml
<parent>
    <groupId>dev.dong4j</groupId>
    <artifactId>arco-business-parent</artifactId>
    <version>${arco.version}</version>
</parent>
```

如需编译期自动配置生成，确保在 `annotationProcessorPaths` 中包含 `arco-processor-core`。

## 构建与调试

在本目录构建全部模块：

```bash
./mvnw clean install
```

单独构建某个模块示例：

```bash
./mvnw -pl arco-maven-plugin -am clean install
```

## 参考文档

- `arco-supreme/README.md`：全局父项目说明
- `arco-builder/README.md`：构建框架总览与父 POM 选择
- `arco-maven-plugin/README.md`：插件体系与用法
- `arco-processor/README.md`：注解处理器说明与示例

---

## 📦 代码示例

查看完整代码示例：

[arco-meta](https://github.com/dong4j/zeka.stack/tree/main/arco-meta)

<!-- 代码链接 -->
