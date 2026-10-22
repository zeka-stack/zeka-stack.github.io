---
published: 2022.05.09
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


# 字典组件

基于 MyBatis 与 Servlet 提供字典持久化、选项查询和缓存管理。业务直接注入自动配置的 DictionaryService，不复制 DictionaryServiceImpl，也不另造相同 Controller。

## 依赖和数据库

```xml
<dependency>
    <groupId>dev.dong4j</groupId>
    <artifactId>cubo-dict-spring-boot-starter</artifactId>
</dependency>
```

确认项目包含 Servlet 与数据库环境，使用组件 cubo-dict-spring-boot-core/db/init.sql 核对并通过项目数据库迁移流程准备 sys_dict_type / sys_dict_value。不要在启动时未经确认修改生产数据库。

## 配置

```yaml
zeka-stack:
  dict:
    enabled: true
    cache-type: memory
    preload-cache: true
    cache-expire-time: 3600
    cache-refresh-delay: 100
```

DictProperties 中 enable-cache / preload-cache 默认为 true，cache-type 默认 MEMORY，cache-expire-time 为 3600 秒，cache-refresh-delay 为 100ms。当前自动配置的缓存和预热条件没有 matchIfMissing，因此要显式配置 cache-type 和 preload-cache。enable-cache 字段本身不负责选择缓存 Bean；禁用缓存选 cache-type: none。没有 table-prefix 或一致性检查间隔配置。

## 在业务中复用

```java
import dev.dong4j.zeka.starter.dict.entity.dto.DictionaryOption;
import dev.dong4j.zeka.starter.dict.service.DictionaryService;
import java.util.List;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/** 复用组件服务，避免重复实现缓存和查询。 */
@Service
@AllArgsConstructor
public class BusinessDictionaryQuery {
    private final DictionaryService dictionaryService;

    /** 返回指定类型的已定义选项。 */
    public List<DictionaryOption> options(String typeCode) {
        return this.dictionaryService.getDictionaryOptions(typeCode);
    }
}
```

其他真实方法：getAllDictionaryOptions、getDictionaryType、listDictionaryTypes、saveDictionaryType、updateDictionaryType、deleteDictionaryType、saveDictionaryValue、updateDictionaryValue、deleteDictionaryValue、getDictionaryValue、refreshCache、refreshAllCache、clearCache、clearAllCache。不调用不存在的 getDictionaryValues。

## HTTP 端点

| 方法 | 路径 | 行为 |
| --- | --- | --- |
| GET | /dicts/options/{typeCode} | 单类选项 |
| GET | /dicts/options | 全部选项 |
| POST | /dicts/refresh/{typeCode} | 刷新单类缓存 |
| POST | /dicts/refresh | 刷新全部缓存 |
| POST | /dicts/clear/{typeCode} | 清空单类缓存 |
| POST | /dicts/clear | 清空全部缓存 |

返回框架 Result，成功 code 为 2000；空值字段是否输出受项目 JSON 配置影响。刷新和清空端点需要项目的访问控制，不因使用框架注解就自动获得完整授权。

## 扩展与限制

DictAutoConfiguration 在缺少对应 Bean 时提供 DictionaryService、DictionaryCache、DictionaryEventListener 和（条件启用时）DictionaryCachePreloader；需要自定义时实现相应接口，按具体条件覆盖。MemoryDictionaryCache / NoOpDictionaryCache 由显式 cache-type 选择。

不要将 tenantId / clientId 字段存在当成自动租户隔离保证；按实际查询和安全上下文验证。不假定内存缓存自动跨节点一致，跨节点刷新需要独立方案。

---

## 📦 代码示例

查看完整代码示例：

[cubo-starter/cubo-dict-spring-boot](https://github.com/dong4j/zeka.stack/tree/main/cubo-starter/cubo-dict-spring-boot)

<!-- 代码链接 -->
