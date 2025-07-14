## 🧑‍💻 简介

作为一个 Java 后端工程师，我相信你一定遇到过下面这些问题：

1. 使用 IDEA 启动一个 Spring Boot 项目，第一行就出现红色告警：发现多个 slf4j 实现类，提示你要排除一个；
2. 本地开发一切正常，一部署到测试环境却报错：找不到某个 class；
3. 项目中的 pom.xml 有上百个依赖，不知道哪个服务哪个功能，谁也不敢轻易动；
4. 多模块之间彼此依赖，模块 A 引用模块 B，模块 B 又反过来依赖模块 A，形成“依赖闭环”；
5. ……

经历过大大小小的 Spring Boot 项目后我发现，不论是大厂还是小团队，很多项目对 Maven 的依赖管理都**重视不足**。

重复引入、版本冲突、依赖混乱、模块耦合这些问题，几乎是通病。

好一点的团队会搭建一个公司级的 parent 项目来统一依赖版本；大多数直接沿用 spring-boot-starter-parent；更差的，哪缺啥引啥，能跑就行，构建配置几乎没人管。

---

**为什么要重新思考 Maven 项目的组织结构?**

因为当项目开始变大：  
%% %%

- 依赖管理就成了地雷阵，一改就炸；
- 多人协作时，版本不一致、依赖冲突的问题频繁出现；

这时候，我们就需要一种更体系化、更可维护的方式来组织我们的 Maven 项目。

这也是我设计 **Zeka.Stack** Maven 分层结构的初衷。

---

## 🏗️ 为什么需要分层管理 Maven 模块

Maven 的父子项目机制为我们提供了强大的依赖管理和插件统一配置能力。通过多层继承结构，我们可以：

### 📏 统一规范

- 所有子项目共享一套标准化的构建配置（如编译器版本、编码格式、测试策略等）。
- 避免重复定义，提高可维护性。

### 🎨 差异化配置

- 不同类型的项目（业务服务、框架组件、文档工具等）可以拥有各自定制化的依赖和插件配置。
- 同时保留共用部分的统一配置，避免冗余。

### 🧬 灵活扩展

- 新增或修改配置时，只需在对应层级进行操作，不影响其他层级。
- 支持未来新增更多类型的项目模板。

---

## 🧱 我的 Maven 分层结构设计

以下是 Zeka.Stack 的 Maven 项目结构：

```
dev.dong4j:arco-supreme (外部依赖)
└── dev.dong4j:arco-builder
    ├── arco-dependencies-parent
    │   └── arco-project-dependencies
    │       └── arco-project-builder
    │           ├── arco-business-parent
    │           └── arco-component-parent
    └── arco-distribution-parent
        ├── arco-business-distribution
        └── arco-doc-distribution
```

### 🏛️ `arco-supreme` - 全局基础父项目

这是整个框架的最顶层父项目，用于：

- 定义全局通用的 Maven 插件（如 `maven-compiler-plugin`, `flatten-maven-plugin`）。
- 统一管理第三方依赖版本（如 Lombok、JUnit、Log4j2、Hutool 等）。
- 设置编码、JDK 版本、构建行为等全局属性。
- 提供部署到公共仓库（如 Sonatype Central）和私有仓库（如 Nexus）的配置。
- 定义构建流程控制规则（如跳过测试、生成源码包等）。

```xml
<!-- 示例：dependencyManagement -->
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>org.junit</groupId>
      <artifactId>junit-bom</artifactId>
      <version>${junit.version}</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
    <!-- 其他核心依赖 -->
  </dependencies>
</dependencyManagement>
```

---

#### ❓ 为什么单独定义 arco-supreme 顶层父项目？

很多人会疑惑，为什么不直接使用某个功能性 parent（比如 arco-project-parent）作为整个项目体系的最顶层，而要专门独立出一个 arco-supreme 模块？

实际上，这样做有以下三个非常明确的动因：

##### ☕ 统一定义 JDK 版本，强制所有项目使用一致的编译环境

构建体系最基础的一点是 JDK 版本一致性，一旦不同模块使用了不同版本，可能导致编译失败、兼容性问题，甚至运行时崩溃。因此：

- arco-supreme 明确指定 JDK 版本；
- 所有子项目通过继承该顶层 parent，自动继承 JDK 版本，无需重复声明；
- 若团队将来升级 JDK，只需在 arco-supreme 统一调整，具备 **版本切换的集中控制能力**。

##### 📦 定义 Maven 仓库策略，统一依赖下载与上传路径

在多环境（内网仓库 / 私服 / 公网）共存的场景下，Maven 仓库配置尤为重要：

- arco-supreme 统一定义所有仓库地址，确保依赖从**正确的来源拉取**，避免出现“某个模块拉不到依赖”的问题；
- 同时配置部署策略（如发布到公司 Nexus 私服），让发布流程统一、规范；
- 子模块无需重复配置 repositories 与 distributionManagement，更清爽。

##### 🧼 该模块中不定义实际依赖，仅维护通用依赖声明

不同类型模块（如业务服务、构建插件、注解处理器）对依赖版本的诉求完全不同：

- arco-mavn-plugin 是 Zeka.Stack 生态中的 maven-plugin 项目, 此项目的绝大部分依赖无法被业务型/组件型模块使用, 所以 maven-plugin 项目可以直接使用
  `arco-supreme` 作为父模块, 保持统一的 JDK 版本和 Maven 仓库配置, 而依赖则自成体系, 互不影响;
- 而比如 `log4j`, `junit`, `lombok` 等依赖也会在 maven-plugin 项目中使用, 所以将这些会被共用的依赖抽离到 `arco-supreme` 模块中, 避免重复定义;
- 往后如果出现类似 maven-plugin 类似的场景, 依然可以使用 `arco-supreme` 模块作为父依赖, 继承 JDK 版本和 Maven 仓库配置;

通过这种方式，arco-supreme 成为了整个 Zeka.Stack 构建体系的 **“统一基础设施层”**：

- 它不直接参与构建逻辑，也不干预业务结构；
- 但它定义了所有模块运行在什么样的 JDK 环境、用什么样的仓库拉包；
- 更像是一个“**构建生态规则的制定者**”，而不是“构建逻辑的执行者”。

---

### 🎛️ `arco-builder` - 项目构建总控层

作为 `arco-supreme` 的直接子项目，它负责：

- 引入 `arco-supreme` 中定义的全局规范。
- 定义两个主要子模块：
    - `arco-dependencies-parent`: 负责管理依赖。
    - `arco-distribution-parent`: 负责一键部署功能。

```xml
<modules>
  <module>arco-dependencies-parent</module>
  <module>arco-distribution-parent</module>
</modules>
```

---

### 🧠 `arco-dependencies-parent` - 依赖管理中枢

该模块专注于统一管理所有项目的基础依赖版本，例如：

- Spring Boot 及其生态（Spring Cloud, Spring Cloud Alibaba）
- 日志框架（Log4j2）
- 工具类库（Hutool）

```xml
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-dependencies</artifactId>
      <version>${spring-boot-dependencies.version}</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
    <!-- 其他依赖 -->
  </dependencies>
</dependencyManagement>
```

---

### 🧵 `arco-project-dependencies` - 插件与构建配置聚合

这个模块引入了多个构建插件并统一配置，包括：

- `git-commit-id-plugin`：记录 Git 提交信息。
- `maven-checkstyle-plugin` / `maven-pmd-plugin`：代码质量检查。
- `jacoco-maven-plugin`：代码覆盖率分析。
- `maven-compiler-plugin`：自定义注解处理器路径。

```xml
<pluginManagement>
  <plugins>
    <plugin>
      <artifactId>maven-compiler-plugin</artifactId>
      <configuration>
        <annotationProcessorPaths>
          <path>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
          </path>
          <path>
            <groupId>org.mapstruct</groupId>
            <artifactId>mapstruct-processor</artifactId>
          </path>
        </annotationProcessorPaths>
      </configuration>
    </plugin>
  </plugins>
</pluginManagement>
```

---

### 🧱 `arco-project-builder` - 构建逻辑抽象层

该模块进一步细分为两类父级模板：

#### 🧳 业务型父级 `arco-business-parent`

- 更加注重打包方式（如资源过滤、依赖分离）。
- 使用 `maven-jar-plugin` 和 `maven-assembly-plugin` 来支持复杂的部署需求。

```xml
<build>
  <resources>
    <resource>
      <filtering>true</filtering>
      <directory>src/main/resources</directory>
      <includes>
        <include>**/*.properties</include>
        <include>**/*.yml</include>
      </includes>
    </resource>
  </resources>
</build>
```

#### 🧰 组件型父级 `arco-component-parent`

- 更倾向于轻量级，适合用于构建 SDK 或框架组件。
- 默认不打包源码，可通过 `-P source` 参数启用。

```xml
<profiles>
  <profile>
    <id>source</id>
    <build>
      <plugins>
        <plugin>
          <artifactId>maven-source-plugin</artifactId>
        </plugin>
      </plugins>
    </build>
  </profile>
</profiles>
```

---

### 🚀 `arco-distribution-parent` - 一键部署层

提供两个子模块：

- `arco-business-distribution`: 用于打包多个业务项目的部署包。
- `arco-doc-distribution`: 用于打包知识库文档。

它们通常包含一些通用的打包脚本和部署插件配置。

---

## 💡 分层架构的优势

| 层级                          | 职责             | 优点         |
|-----------------------------|----------------|------------|
| `arco-supreme`              | 全局配置、插件版本、仓库地址 | 统一规范，提升一致性 |
| `arco-builder`              | 项目类型划分         | 解耦不同类型项目配置 |
| `arco-dependencies-parent`  | 依赖版本管理         | 集中式版本控制    |
| `arco-project-dependencies` | 插件配置聚合         | 提高构建复用性    |
| `arco-project-builder`      | 构建细节抽象         | 支持不同项目类型   |
| `arco-distribution-parent`  | 发布/部署管理        | 一键部署、自动化   |

---

## 🔍 对比 Spring Boot Parent 的设计思路

Spring Boot 提供了一个简洁的 `spring-boot-starter-parent`，用于快速搭建标准 Spring Boot 应用。而我们在其基础上做了更深入的抽象：

| Spring Boot 原始做法 | 我们的改进             |
|------------------|-------------------|
| 单一层级 parent      | 多层级 parent，便于职责划分 |
| 统一的插件配置          | 根据项目类型差异定制插件      |
| 统一的依赖管理          | 细粒度依赖版本控制，便于升级    |
| 不区分项目类型          | 明确区分类别，增强灵活性      |

---

## 🤔 思考

我们在实践中发现，**不同类型的项目需要不同的构建策略**，而依赖管理只是构建体系的一部分。

因此在设计 Zeka.Stack 体系时，采用了以下三个关键构建原则，既保证了**统一性**，又具备**高度灵活的扩展性**：

### 📤 共用配置统一上提，集中维护不重复

> “相同的抽取上层，不同的保留在本地。”

将所有子模块都可能使用的共性内容统一提取至顶层模块：

- 使所有子项目都可复用而无需重复声明；
- 后期调整只需在顶层一处修改即可，具备集中式变更能力；
- 保持整个体系 **一致性、高可控、低维护成本**。

### 📤 共用配置统一上提，集中维护不重复

> “插件是插件，业务是业务，工具是工具。”

构建体系并不只包含业务模块，还包括工具类模块、编译插件、注解处理器等，它们的依赖差异巨大：

- arco-maven-plugin（构建插件）不应引入 mybatis、mapstruct 等业务相关依赖；
- arco-processor（注解处理器）更应保持纯净、避免引入 runtime 依赖；
- 比如二开过的开源项目, 比如 xxj-job, jetcache 等, 他们的依赖不应该影响 Zeka.Stack 生态, 但又需要部署到公司私服;
- 业务型模块需要定义大量常见的依赖以及特定处理的 xxx-mavn-plugin 配置;
- 组件型模块可能部分 xxx-maven-plugin 和业务型模块的 maven 配置不一样;

因此我们将这些模块拆分继承不同的 parent，形成“分而治之”的结构，避免了依赖交叉污染，保持模块边界清晰。

### 🔧 插件、工具类模块独立 parent 管理，构建逻辑灵活可插拔

> “构建体系的可维护性来自于边界清晰的插件结构。”

插件类模块（如自研的 Maven Plugin、编译处理器等）在整个体系中扮演“构建增强器”的角色，不应被业务项目的配置干扰：

- 这类模块往往需要特殊的 plugin 配置、maven lifecycle 调整等；
- 也可能运行在构建时 classpath 中，而非 runtime；
- 可以更方便地做插拔与升级，**实现构建体系的“即插即用”能力**。

这种架构虽然初期需要一定学习成本，但在中大型项目中，能够有效降低后期维护和协作成本，提升团队工程效率。

---

Zeka.Stack 的目标不是快速搭项目，而是提供一套 **可维护、可扩展、可持续演进的构建体系**。这需要从构建逻辑、依赖控制、项目结构、部署运维多个维度考虑，而不仅是简单封装依赖版本。

> Zeka.Stack 是忠实的设计模式实践者, 不仅仅体现在代码层面, 而是贯穿在整个 Stack 体系中,

---

如需查看完整结构，请参考 [arco-supreme](https://github.com/zeka-stack/arco-supreme)
和 [arco-builder](https://github.com/zeka-stack/arco-builder)。
