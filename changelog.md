# 更新日志

本页面记录 Zeka Stack 项目的重要更新和变更。

---

### 2026-05-04

#### 🐛 Bug 修复

- 修复所有双向链接警告：`arco-builder`、`arco-processor`、`arco-maven-plugin`、`arco-supreme`、`cubo-starter-examples` 中的 `README.md` 链接路径缺失 `arco-meta/` 前缀或缺少 `/index` 后缀
- 修复 `assembly.outputTimestamp` 和 `docker_build_guide` 旧文件名引用，更新为实际文件名

#### ⭐ 新功能

- 新增开发者文档 `docs-sync-guide.md`：文档组织说明，帮助开发者理解 `sync-docs.sh` 的同步机制和目录约定
- 新增开发者文档 `docs-authoring-best-practices.md`：文档编写最佳实践，覆盖标题规范、内容结构、写作风格、双向链接规范和 AI 友好文档建议
- 更新 `README.md`，新增"文档开发规范"章节引导开发者阅读上述两份文档

#### 📓 文档更新

- 重写 `guide/index.md`：面向使用者的引导首页，包含项目定位、适用场景和仓库结构概览
- 重写 `guide/1.introduction.md`：完整的项目介绍，涵盖分层设计、各层核心模块、使用路径和与普通脚手架的对比
- 重写 `guide/2.quick-start.md`：完整的快速开始手册，包含前置要求、获取代码、构建、运行示例、典型项目结构、IDE 配置和常见问题
- 重写 `guide/3.resources.md`：资源汇总和学习路径，包含模块文档入口、按任务找资料索引和三种推荐学习路径

---

### 2025-12-06

#### ⭐ 新功能

- 初始化 Zeka Stack 文档站点
- 从 Spring AI Cookbook 模板迁移并适配
- 配置 Arco Meta、Blen Kernel、Cubo Starter 模块结构

#### 📓 文档更新

- 更新首页内容，适配 Zeka Stack 框架
- 更新关于页面，描述项目背景和目标
- 更新 README 文档结构说明

---

> 更多历史更新记录请查看 [GitHub 提交历史](https://github.com/zeka-stack/zeka-stack.github.io/commits/main)
