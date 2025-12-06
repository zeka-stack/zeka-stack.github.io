---
layout: home

hero:
    name: Zeka Stack
    text:
    tagline: 一个现代化的 Java 微服务工程体系
    image:
        src: /logo.png
        alt: Zeka Stack
    actions:
        -   theme: brand
            text: 🚀 快速开始
            link: /guide/
        -   theme: alt
            text: 🔥 关于
            link: /about/
        -   theme: alt
            text: ⭐ GitHub
            link: https://github.com/zeka-stack

features:
    -   icon: 🚀
        title: 快速入门
        details: 开箱即用的微服务脚手架，快速搭建企业级应用
    -   icon: 💡
        title: 模块化设计
        details: 高度解耦的模块化架构，按需引入，灵活组合
    -   icon: 🎯
        title: 最佳实践
        details: 融合业界最佳实践，提供规范化的开发指南
    -   icon: 🔧
        title: 丰富组件
        details: 内置丰富的基础组件，涵盖日志、认证、缓存等常用功能
    -   icon: 🐳
        title: 云原生支持
        details: 支持容器化部署，无缝对接 Kubernetes 生态
    -   icon: 📚
        title: 完整文档
        details: 每个模块都包含完整的文档和示例代码

---

<div class="home-content">

## 🎯 项目概览

Zeka Stack 是一个现代化的 Java 微服务工程体系，提供开箱即用的企业级开发框架，帮助开发者快速构建高质量的微服务应用。

<div class="stats-grid">
  <div class="stat-card">
    <div class="stat-number">20+</div>
    <div class="stat-label">核心模块</div>
  </div>
  <div class="stat-card">
    <div class="stat-number">100+</div>
    <div class="stat-label">代码示例</div>
  </div>
  <div class="stat-card">
    <div class="stat-number">∞</div>
    <div class="stat-label">无限可能</div>
  </div>
</div>

## 📚 模块体系

### 🟢 Arco Meta

- **元数据管理** - 提供统一的元数据定义和管理能力

### 🔵 Blen Kernel

- **内核组件** - 核心基础组件，包含认证、授权等通用能力

### 🟡 Cubo Starter

- **快速启动器** - 开箱即用的 Spring Boot Starter 集合

### 🟣 Cubo Examples

- **示例工程** - 完整的使用示例和最佳实践

## 🛠️ 技术栈

<div class="tech-stack">
  <div class="tech-item">
    <strong>Spring Boot</strong>
    <span>3.x</span>
  </div>
  <div class="tech-item">
    <strong>Spring Cloud</strong>
    <span>2023.x</span>
  </div>
  <div class="tech-item">
    <strong>Java</strong>
    <span>17+</span>
  </div>
</div>

## 🚀 快速开始

```bash [bash]
# 1. 克隆项目
git clone https://github.com/zeka-stack/zeka-stack.git

# 2. 进入项目目录
cd zeka-stack

# 3. 构建项目
mvn clean install
```

## 📖 参考资源

<div class="resources-grid">
  <a href="https://github.com/zeka-stack" class="resource-card" target="_blank">
    <div class="resource-icon">⭐</div>
    <div class="resource-title">Zeka Stack GitHub</div>
    <div class="resource-desc">项目源代码和 Issues</div>
  </a>
  <a href="https://spring.io/projects/spring-boot" class="resource-card" target="_blank">
    <div class="resource-icon">📚</div>
    <div class="resource-title">Spring Boot</div>
    <div class="resource-desc">Spring Boot 官方文档</div>
  </a>
  <a href="https://spring.io/projects/spring-cloud" class="resource-card" target="_blank">
    <div class="resource-icon">💡</div>
    <div class="resource-title">Spring Cloud</div>
    <div class="resource-desc">Spring Cloud 官方文档</div>
  </a>
  <a href="https://docs.spring.io/spring-ai/reference/" class="resource-card" target="_blank">
    <div class="resource-icon">🤖</div>
    <div class="resource-title">Spring AI</div>
    <div class="resource-desc">Spring AI 官方文档</div>
  </a>
</div>

---

## 👤 关于作者

<div class="author-links">
  <div class="author-section">
    <h3>个人站点</h3>
    <ul>
      <li><a href="https://blog.dong4j.site" target="_blank">📝 博客</a></li>
      <li><a href="https://home.dong4j.site" target="_blank">🏠 主页</a></li>
    </ul>
  </div>

  <div class="author-section">
    <h3>个人项目</h3>
    <ul>
      <li><a href="https://plugins.jetbrains.com/plugin/12192-markdown-image-kit" target="_blank">🖼️ MIK 插件</a> - Markdown Image Kit</li>
      <li><a href="https://plugins.jetbrains.com/plugin/28835-ai-javadoc" target="_blank">🤖 AI Javadoc 插件</a> - AI Javadoc Generator</li>
    </ul>
  </div>
</div>

</div>

<style>
.home-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem 1rem;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 1.5rem;
  margin: 2rem 0;
}

.stat-card {
  background: linear-gradient(135deg, var(--vp-c-bg-soft) 0%, var(--vp-c-bg) 100%);
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  padding: 2rem 1.5rem;
  text-align: center;
  transition: all 0.3s ease;
  overflow: visible;
  min-height: 160px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.stat-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  border-color: var(--vp-c-brand);
}

.stat-number {
  font-size: 3rem;
  font-weight: 700;
  line-height: 1.3;
  background: linear-gradient(135deg, var(--vp-c-brand) 0%, var(--vp-c-brand-light) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 0.5rem;
  display: block;
  overflow: visible;
  white-space: nowrap;
  word-break: keep-all;
}

.stat-label {
  color: var(--vp-c-text-2);
  font-size: 0.9rem;
  line-height: 1.5;
  margin-top: 0.5rem;
}

.tech-stack {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  margin: 1.5rem 0;
}

.tech-item {
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
  padding: 1rem 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
  transition: all 0.3s ease;
}

.tech-item:hover {
  border-color: var(--vp-c-brand);
  transform: translateY(-2px);
}

.tech-item strong {
  color: var(--vp-c-text-1);
  font-size: 1rem;
}

.tech-item span {
  color: var(--vp-c-text-2);
  font-size: 0.85rem;
}

.resources-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin: 2rem 0;
}

.resource-card {
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  padding: 1.5rem;
  text-decoration: none;
  color: inherit;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.resource-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  border-color: var(--vp-c-brand);
  text-decoration: none;
}

.resource-icon {
  font-size: 2.5rem;
  line-height: 1;
}

.resource-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--vp-c-text-1);
}

.resource-desc {
  font-size: 0.9rem;
  color: var(--vp-c-text-2);
  line-height: 1.5;
}

.author-links {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
}

.author-section {
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  padding: 1.5rem;
}

.author-section h3 {
  margin: 0 0 1rem 0;
  font-size: 1.2rem;
  color: var(--vp-c-text-1);
  font-weight: 600;
}

.author-section ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.author-section li {
  margin: 0.75rem 0;
}

.author-section a {
  color: var(--vp-c-brand);
  text-decoration: none;
  transition: color 0.2s ease;
  display: inline-block;
}

.author-section a:hover {
  color: var(--vp-c-brand-light);
  text-decoration: underline;
}

@media (max-width: 768px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }

  .resources-grid {
    grid-template-columns: 1fr;
  }

  .author-links {
    grid-template-columns: 1fr;
  }
}
</style>
