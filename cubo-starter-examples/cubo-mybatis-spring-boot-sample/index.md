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


# 数据访问示例

## 概述

本示例项目展示了如何使用 `cubo-mybatis-spring-boot` 组件进行数据库操作，包含单数据源、多数据源、Active Record、多租户等多种使用场景。

## 子模块说明

### 1. cubo-mybatis-spring-boot-sample-single

**单数据源示例**，展示了：

- 基础的 MyBatis Plus CRUD 操作
- 实体类映射和查询
- 条件构造器的使用

### 2. cubo-mybatis-spring-boot-sample-multiple

**多数据源示例**，展示了：

- 配置多个数据源
- 动态数据源切换
- 不同数据源的独立操作

### 3. cubo-mybatis-spring-boot-sample-active-record

**Active Record 模式示例**，展示了：

- 实体类直接操作数据库
- 无需 Mapper 接口的简化操作

### 4. cubo-mybatis-spring-boot-sample-integration

**集成示例**，展示了：

- 完整的业务场景集成
- 复杂查询和事务处理
- 多表关联操作

### 5. cubo-mybatis-spring-boot-sample-tenant

**多租户示例**，包含三个子示例：

- **tenant-field**：字段级多租户隔离
- **tenant-table**：表级多租户隔离
- **tenant-table-by-sharding**：基于分表的租户隔离

## 快速开始

### 运行单数据源示例

```bash
cd cubo-mybatis-spring-boot-sample-single
mvn spring-boot:run
```

### 运行多租户示例

```bash
cd cubo-mybatis-spring-boot-sample-tenant/cubo-mybatis-spring-boot-sample-tenant-field
mvn spring-boot:run
```

## 高阶用法

### 1. 基础 CRUD 操作

```java
@SpringBootApplication
public class SampleApplication extends ZekaStarter {
    
    @Override
    public void run(String... args) {
        UserDao userMapper = SpringContext.getInstance(UserDao.class);
        
        // 查询
        User user = userMapper.selectById(1);
        
        // 插入
        User newUser = new User();
        newUser.setName("test");
        userMapper.insert(newUser);
        
        // 更新
        user.setName("updated");
        userMapper.updateById(user);
        
        // 删除
        userMapper.deleteById(1);
    }
}
```

### 2. 条件查询

```java
QueryWrapper<User> wrapper = new QueryWrapper<>();
wrapper.eq("name", "test")
       .ge("age", 18)
       .orderByDesc("create_time");

List<User> users = userMapper.selectList(wrapper);
```

### 3. 多数据源配置

```yaml
spring:
  datasource:
    master:
      url: jdbc:mysql://localhost:3306/master
      username: root
      password: password
    slave:
      url: jdbc:mysql://localhost:3306/slave
      username: root
      password: password
```

### 4. 多租户配置

```yaml
mybatis-plus:
  tenant:
    enabled: true
    field: tenant_id  # 字段级租户隔离
    # 或
    table: true  # 表级租户隔离
```

### 5. 元数据自动填充

```java
@Entity
public class User {
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}
```

### 6. 敏感字段加解密

```java
@Entity
public class User {
    @Encrypt  // 自动加密存储，解密查询
    private String phone;
    
    @Encrypt
    private String email;
}
```

### 7. SQL 拦截器

```java
@Component
public class CustomSqlInterceptor implements Interceptor {
    
    @Override
    public Object intercept(Invocation invocation) {
        // 自定义 SQL 拦截逻辑
        return invocation.proceed();
    }
}
```

## 相关链接

- [[cubo-starter/cubo-mybatis-spring-boot/index|数据访问]]

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter-examples/cubo-mybatis-spring-boot-sample](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter-examples/cubo-mybatis-spring-boot-sample)

<!-- 代码链接 -->
