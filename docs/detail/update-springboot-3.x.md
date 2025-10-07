# 🎉 Spring Boot 3.5.4 升级

## 升级方案

### 1. 首先更新 `arco-supreme` 模块中的基础配置

在 [arco-supreme/pom.xml 中，需要更新 Java
版本和相关依赖：

```xml
<properties>
    <!-- 全局设置 jdk 版本 -->
    <java.version>17</java.version>
    <maven.compile.source>17</maven.compile.source>
    <maven.compile.target>17</maven.compile.target>
    
    <!-- 更新相关插件版本以支持 Java 17 -->
    <maven-compiler-plugin.version>3.11.0</maven-compiler-plugin.version>
    
    <!-- 更新依赖版本 -->
    <lombok.version>1.18.28</lombok.version>
    <junit.version>5.9.3</junit.version>
    <slf4j.version>2.0.7</slf4j.version>
    <log4j2.version>2.20.0</log4j2.version>
    <hutool.version>5.8.20</hutool.version>
</properties>
```

### 2. 更新 `arco-supreme/pom.xml` 中的 Spring 版本

```xml
<properties>
    <spring-framework.version>6.0.9</spring-framework.version>
    <spring-boot-dependencies.version>3.1.0</spring-boot-dependencies.version>
</properties>
```

### 3. 更新 `arco-builder/arco-project-dependencies/pom.xml` 中的依赖版本

```xml
<properties>
    <spring-cloud-dependencies.version>2022.0.3</spring-cloud-dependencies.version>
    <spring-cloud-alibaba-dependencies.version>2022.0.0.0-RC1</spring-cloud-alibaba-dependencies.version>
    <!-- 更新其他依赖版本 -->
    <dubbo.version>3.2.0</dubbo.version>
    <nacos.version>2.2.2</nacos.version>
    <fastjson.version>2.0.32</fastjson.version>
    <sentinel.version>1.8.6</sentinel.version>
    <nacos.client.version>2.2.2</nacos.client.version>
    <seata.version>1.6.1</seata.version>
</properties>
```

### 4. 更新 `arco-builder/arco-project-builder/pom.xml` 中的插件版本

```xml
<properties>
    <mapstruct.version>1.5.5.Final</mapstruct.version>
    <lombok-mapstruct-binding.version>0.2.0</lombok-mapstruct-binding.version>
    <p3c-pmd.version>2.1.1</p3c-pmd.version>
    
    <!-- 更新插件版本 -->
    <maven-checkstyle-plugin.version>3.3.1</maven-checkstyle-plugin.version>
    <maven-pmd-plugin.version>3.21.0</maven-pmd-plugin.version>
    <jacoco-maven-plugin.version>0.8.10</jacoco-maven-plugin.version>
    <maven-enforcer-plugin.version>3.3.0</maven-enforcer-plugin.version>
</properties>
```

### 5. 处理 Jakarta EE 迁移

在 `arco-builder/arco-project-dependencies/pom.xml` 中，需要更新与 Jakarta EE 相关的依赖：

```xml
<!-- 需要添加或更新 Jakarta EE 相关依赖 -->
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.0.0</version>
    <scope>provided</scope>
</dependency>
<dependency>
    <groupId>jakarta.persistence</groupId>
    <artifactId>jakarta.persistence-api</artifactId>
    <version>3.1.0</version>
    <scope>provided</scope>
</dependency>
<dependency>
    <groupId>jakarta.validation</groupId>
    <artifactId>jakarta.validation-api</artifactId>
    <version>3.0.2</version>
    <scope>provided</scope>
</dependency>
```

### 6. 更新 arco-builder/arco-business-parent/pom.xml 中的插件配置

检查并更新相关插件版本以确保与 Spring Boot 3 兼容：

```xml
<properties>
    <maven-dependency-plugin.version>3.5.0</maven-dependency-plugin.version>
    <maven-jar-plugin.version>3.3.0</maven-jar-plugin.version>
</properties>
```

### 7. 需要注意的兼容性问题

1. **Lombok 兼容性**：确保使用与 Spring Boot 3 兼容的 Lombok 版本
2. **MapStruct 兼配性**：需要使用 1.5.x 版本以支持 Jakarta EE
3. **Spring Cloud 版本**：需要使用与 Spring Boot 3.1 兼容的 2022.0.x 版本
4. **Spring Cloud Alibaba**：需要使用支持 Spring Boot 3 的版本

### 8. 代码层面的变更

在升级后，您还需要注意以下代码层面的变更：

1. 将所有 `javax.*` 包引用更新为 `jakarta.*`
2. 更新所有使用已废弃 API 的代码
3. 检查自定义配置类是否需要调整

### 9. 插件兼容性检查

您需要检查以下 Maven 插件是否与 Spring Boot 3 兼容：

1. `arco-assist-maven-plugin` - 可能需要更新以支持 Jakarta EE
2. `arco-boot-maven-plugin` - 可能需要调整以适应新的类加载机制
3. `arco-container-maven-plugin` - 可能需要更新 Dockerfile 模板
4. `arco-script-maven-plugin` - 可能需要调整启动脚本

## ✅ 升级完成的模块

已经成功完成了 **arco-meta** 框架从 Spring Boot 2.x 到 Spring Boot 3.5.4 的第一阶段升级工作：

### 1. **arco-supreme 模块（顶层管理模块）**

- ✅ **Spring Boot**: `2.x` → `3.5.4`
- ✅ **Spring Framework**: `5.x` → `6.2.9`
- ✅ **Maven 插件**: 全面升级到最新稳定版本
    - `maven-compiler-plugin`: `3.8.1` → `3.14.0`
    - `maven-assembly-plugin`: `3.3.0` → `3.7.1`
    - `maven-antrun-plugin`: `3.0.0` → `3.1.0`
    - `maven-javadoc-plugin`: `3.3.1` → `3.11.2`
    - `maven-source-plugin`: `3.2.1` → `3.3.1`
    - `maven-gpg-plugin`: `1.6` → `3.2.7`
    - `flatten-maven-plugin`: `1.2.4` → `1.6.0`
- ✅ **第三方依赖升级**:
    - `lombok`: `1.18.22` → `1.18.38`
    - `annotations`: `19.0.0` → `26.0.1`
    - `junit`: `5.6.2` → `5.13.4`
    - `slf4j`: `1.7.30` → `2.0.17`
    - `log4j2`: `2.17.0` → `2.24.3`
    - `hutool`: `5.7.16` → `5.8.36`

### 2. **arco-maven-plugin 模块（Maven 插件模块）**

- ✅ **核心 Maven 依赖**:
    - `maven.version`: `3.6.3` → `3.9.9`
    - `maven-plugin.version`: `3.6.0` → `3.15.1`
- ✅ **第三方库升级**:
    - `classgraph`: `4.8.54` → `4.8.179`
    - `javaparser`: `3.15.15` → `3.26.3`
    - `commons-compress`: `1.19` → `1.28.0`
    - `commons-io`: `2.7` → `2.18.0`
    - `commons-lang3`: `3.10` → `3.18.0`
    - `plexus-utils`: `3.2.1` → `4.0.2`
    - `plexus-component-annotations`: `2.1.0` → `2.2.0`

### 3. **arco-builder 模块（多层级管理模块）**

- ✅ **Spring Cloud 生态系统**:
    - `spring-cloud-dependencies`: `Hoxton.SR9` → `2025.0.0`
    - `spring-cloud-alibaba-dependencies`: `2.2.6.RELEASE` → `2023.0.3.3`
- ✅ **阿里巴巴中间件**:
    - `dubbo`: `2.7.8` → `3.3.6`
    - `nacos`: `2.0.3` → `2.4.6`
    - `sentinel`: `1.8.1` → `2.0.1`
    - `seata`: `1.3.0` → `2.3.3`
- ✅ **业务父级模块 Maven 插件**:
    - `maven-dependency-plugin`: `3.1.2` → `3.8.1`
    - `maven-jar-plugin`: `3.2.0` → `3.4.2`

### 4. **arco-processor 模块（注解处理器模块）**

- ✅ **注解处理器依赖**:
    - `auto-service`: `1.0-rc6` → `1.1.1`
