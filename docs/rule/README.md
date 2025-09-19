---
title: Zeka Stack 项目开发规范
author: dong4j
tags:
- standard
- zeka-stack
- development
---

::: tip
Zeka Stack 项目开发规范, 此文档会引用之前写的一些内容, 如果与旧文档描述/规范/使用方式等存在冲突, **一切以此文档为准**!

[TOC]

<!-- more -->

## 文档导航

本文档包含以下主要章节：

- **[概述](#概述)** - 规范的目的和基本原则
- **[准备工作](#准备工作)** - 开发环境配置和工具推荐
- **[开发规范](#1-开发规范)** - 项目结构、命名规范、代码规范
- **[常用工具类](#2-常用工具类)** - 框架提供的工具类使用指南
- **[细节补充](#3-细节补充)** - 开发过程中的注意事项
- **[服务器规范](#4-服务器规范)** - 部署环境配置规范
- **[数据库规范](#5-数据库规范)** - 数据库设计和操作规范
- **[组件使用规范](#6-组件使用规范)** - 配置管理和组件使用
- **[Nacos](#7-nacos)** - 配置中心使用规范
- **[Maven](#8-maven)** - 依赖管理和构建规范
- **[日志规范](#9-日志规范)** - 日志记录和输出规范
- **[Git 分支规范](#10-git-分支规范)** - 版本控制和分支管理
- **[测试](#11-测试)** - 测试计划和测试规范
- **[代码审查规范](#12-代码审查规范)** - 代码审查流程和标准
- **[性能规范](#13-性能规范)** - 性能优化和监控规范
- **[安全规范](#14-安全规范)** - 安全开发和安全防护
- **[文档规范](#15-文档规范)** - 技术文档编写规范

## 概述

我们以 [阿里巴巴开发手册](https://github.com/alibaba/p3c/) 为基础, 结合自己工作经验, 作为所有 Zeka Stack 项目的开发规范, 以此为约束, 希望构建一个个 `稳定`, `易于维护`, `可扩展` 的系统.

一个项目最怕多种编码风格, 实体名一会 entity, 一会 model, 让维护的人身心疲惫, 因此在一个项目中保持唯一一种编码习惯, 有利于代码维护与快速理解, 比如通过命名, 就知道其大概的作用以及所在的包名.

**见名知意, 此乃命名的最高境界(体会一下 `取名一小时, 编码一分钟` 的境界 😂).**

> 代码规范看起来比较枯燥, 看完一遍可能只有一点点印象, 因此希望大家多看几遍.
> 代码规范比较偏向个人主义, 每个人的编码习惯都不一样, 所以希望多提出自己的建议, 一起改进(没有最好的规范, 只有最合适的. 🙃)

## Let's go

### 开篇

江湖四分五裂, 一人一江湖...

但我们是一个团队，为了便于管理和维护，急需一份代码规范, 来约束我们的编码规则和习惯, 就像修炼一门武林绝学, 需要秘籍的指引(葵花宝典?)。

请各位英雄好汉仔细阅读并严格遵守.
如有不足之处 希望提出意见, 共商武林统一霸业.

从 1000 个哈姆雷特转变为同一个 **林志玲**, 代码风格保持统一有利于**提高工作效率**, 便于管理.

比如:

1. 一看到以 Agent结尾的类, 就应该知道这个是接口, 用于**参数验证**, **业务逻辑转发**, **组装结果**, 返回规范的数据结构或跳转页面;
2. 一看到以 Controller 结尾的类, 就应该知道这个是接口, 用于**参数验证**, **业务逻辑转发**, **组装结果**, 返回规范的数据结构或跳转页面;
3. 一看到以 Service 结尾的类, 就知道这个是业务接口类, 用于定义业务接口;
4. 一看到以 Impl 结尾的类, 就应该知道这个是业务实现类, 组合不同的 Dao, 实现业务逻辑;
5. 一看到以 Manager 结尾的类, 就应该知道这个是对第三方 rest 接口, dubbo, webservice, socket, feign 等调用的封装, 可以对参数进行转换或者异常转换等操作;
6. 一看到以 Dao 结尾的类, 就应该知道这个是 DB 操作类, 对数据进行 CRUD 操作;
7. 一看到以 DTO 结尾的类, 就应该知道这个是数据传输对象, 用于展示层和服务层之间的数据传输;
8. ....

## 约定

为了避免歧义, 文档大量使用以下词汇, 解释如下:

1. **必须** (must): 绝对，严格遵循，请照做，无条件遵守；
2. **一定不可** (must not): 禁令，严令禁止；
3. **应该** (should): 强烈建议这样做，但是不强求；
4. **不该** (should not): 强烈不建议这样做，但是不强求；
5. **可以** (may) 和 可选 (optional): 选择性高一点，在这个文档内，此词语使用较少；
6. **推荐** (recommend): 个人推荐的做法, 不强求;

## 准备工作

> 行走江湖, 没有一件趁手的兵器怎么能在江湖中立足, 还在用 `eclipse` 的少侠们, 希望弃暗投明, 拥抱 Intellij IDEA, 你会发现编码效率提升不是**点巴点儿**, 而是**蹭蹭蹭**的往上涨 😁.

**我不是富二代, 我没有赢在人生的起跑线上, 但是我用 Intellij IDEA, 我赢在了工作的起跑线上!**

推荐一个比较全面的 [Intellij IDEA 教程](https://github.com/judasn/IntelliJ-IDEA-Tutorial), 请大家一定要花点时间熟悉或配置一下自己的 IDEA.

目前 JetBrains 家的所有产品全线支持中文, 只需要下载官方中文语言包即可, 个人推荐使用中文包 (会有种发现新大陆的感觉).

这里值得吐槽一下, 官方没出中文汉化包之前到处找第三方汉化包, 出了官方汉化包后又觉得用汉化版 low, IDE 用英文版才显得高大上 😢.

我们是工作, 应该使用各种工具提高自己的开发效率, 官方都贴心的为我们提供了母语支持, 我们反而不用了, 有点对不起使用这么多年 ~~~盗版~~~的 IDEA 呀.

以上是个人意见, 大家随意选择, 如果以后需要我帮你在本地处理 IDEA 的问题, 请先安装汉化包.

**工欲善其事, 必先利其器. 一件趁手的兵器带你迎娶白富美, 走上人生巅峰, 统一江湖, 指日可待**

![image-20210726210606915](https://cdn.dong4j.site/source/image/image-20210726210606915.png)

为了简化手动操作和提高编码效率, 我们要求 **必须** 安装几个必要的插件, 以及对 IDEA 进行必要的优化配置.

在阅读下面的内容之前, 请先看看 [这个](../plugin/README.md), 其中的 **todo 标识** , **fixme 标识**  和 **类注释** 可以不用配置, **FKH.Kit.Format** 已经帮你完成了, 你只需要按照要求安装我们提供的几个插件即可, 未来我们还会开发 **FKH.Kit.Agent** 来简化 agent service 接口查询与测试, 类似于 **RestfulToolkit**.

::: tip

下面对 [这篇文档](../plugin/README.md) 进行了补充, 并推荐几个个人经常使用到的插件, 或者你们也有趁手的插件都可以分享出来.

:::

### Intellij IDEA 插件

#### Alibaba Java Coding Guidelines

> `可以` 安装

**作用: 代码规则检查**

此插件是 阿里巴巴根据 [阿里巴巴开发手册](https://github.com/alibaba/p3c/) 开发的一个静态代码规范检查插件, 每个警告都提供了一个 demo,

![20210726212301](https://cdn.dong4j.site/source/image/20210726212301.png)

此篇以 [阿里巴巴开发手册](https://github.com/alibaba/p3c/) 为基础, 但是并不会一一罗列每条规范, 因为此插件已经能很好的检查了.

非强制安装的原因是我们自己有 **fkh-checkstyle-plugin-rule** 这个 maven plugin, 在 **阿里巴巴规范** 的基础上了做了修改以符合当前代码开发规范, 并更加可控.

::: tip

此插件已集成到 V5 框架中, 不需要手动集成.

:::

**此篇重点在于这个插件不能检查的规范.**

#### Lombok

> **必须** 安装, 不然代码跑不起来就尴尬了

**作用: 化繁为简. [官网]([http://projectlombok.org/](http://projectlombok.org/))**

使用 `@Data` 代替烦人的 get/set 方法

![20210726211833](https://cdn.dong4j.site/source/image/20210726211833.png)

使用 `@Slf4j` 代替获取 log 实例的代码

```java
private static final Logger log = LoggerFactory.getLogger(ApplicationTest.class);
```

![20210726212620](https://cdn.dong4j.site/source/image/20210726212620.png)

V5 框架已集成了 `lombok` 的 maven 依赖, 从 **IDEA 2020.3** 开始 lombok 作为 IDEA 内置插件, 因为 lombok 跟 IDEA 版本存在兼容性问题, 请一定要使用内置版本, 如果 IDEA 在 2020.3 以下, 请尽快升级到 **最新版**, 注册码问题请自行解决, 推荐使用 [这个插件](https://gitee.com/pengzhile/ide-eval-resetter), 如果不知道怎么使用, 我们提供手把手帮助.

如果因为 lombok 导致编译失败, 请开启 **注解处理器** 配置, 如果还是不行, 请删除 **.idea** 和 **.iml** 并重新导入, 这样基本上能解决 IDEA 大多数编译问题.

#### Maven Helper

> **必须的必须** 安装, 如果发现没有安装的, 罚写 1000 遍 Maven Helper (不准用 for 和 while)

**作用: 检查依赖冲突**, **项目依赖分析** , **简化 Maven 命令**

新加入一个 jar 包, 谁添加谁负责, 使用此插件检查是否有依赖冲突.

依赖冲突可能会导致:

1. java.lang.ClassNotFoundException
2. java.lang.NoSuchMethodError
3. java.lang.NoClassDefFoundError
4. 开发环境正常, 线上环境不正常....

![20210726214900](https://cdn.dong4j.site/source/image/20210726214900.png)

很遗憾不能展示依赖冲突的样子, 因为 V5 的依赖管理不允许出现这种情况 😏

**固化 Maven 命令**

![20210726215116](https://cdn.dong4j.site/source/image/20210726215116.png)

这里面的 **-Dcheckstyle.skip** 和 **-Dpmd.skip** 请大家不要随意使用, 要是发现提交的代码编译不通过请大家喝奶茶就行.

#### JRebel

> **推荐** 安装, 提高工作效率的插件.

**作用: 代码热部署插件, 改了代码后, 重新编译, 不用重启应用就可查看效果.**

热部署插件, 谁用谁知道;

[科学使用方法](http://blog.lanyus.com/search/JRebel/) (低调点)

[这里](../plugin/official/jrebel.md) 有一篇详细的使用说明文档.

#### GenerateSerialVersionUID

> **推荐** 安装

**作用: 为实现了 Serializable 接口的实体快速添加 serialVersionUID, 提高效率**

实体了 `Serializable` 接口的实体, `必须` 添加 `serialVersionUID` 字段.

#### GenerateAllSetter

> **推荐** 安装

**作用: 快速生成 set 方法**


#### RestfulToolkit

> **推荐** 安装

**作用: 快速定位接口, Rest 请求模拟**

#### Archive Browser

> **推荐** 安装

**作用: 在 IDEA 中直接查看压缩包类的文件, 不需要解压**

![20210807155008](https://cdn.dong4j.site/source/image/20210807155008.png)

#### arthas idea

> **推荐** 安装

**作用: 如果你玩儿 [arthas](https://arthas.aliyun.com/doc/arthas-tutorials.html?language=cn), 推荐安装此插件**

#### CodeGlance2

> **推荐** 安装

**作用: 在 IDEA 编辑框右边生成一个 mini map, 用于快速导航.**

#### Codota

> **推荐** 安装

**作用: 基于 AI 的代码自动补全与搜索代码示例插件**

![20210802164516](https://cdn.dong4j.site/source/image/20210802164516.png)

#### Conventional Commit

> **推荐** 安装

**作用: 自动补全 git commit 前缀, 配合 FKH.Kit.Commit 使用提升体验**

#### CSDN tools

> **推荐** 安装

**作用: 免费的开发者工具, Json 格式化, 时间转换**

![20210802165647](https://cdn.dong4j.site/source/image/20210802165647.png)

#### Diagrams.net Integration

> **推荐** 安装  (基础架构与数据部 **必须** 安装)

**作用: IDEA 插件版的 draw.io, 可直接编辑 svg 文件**

**推荐使用此插件代替桌面版的 draw, 不要再发截图了, 以后可直接编辑原文件 **

![20210726222734](https://cdn.dong4j.site/source/image/20210726222734.png)

#### GitToolBox

> **必须** 安装

**作用: 直观的看到每一行的提交记录, 自动提示有远端代码提交, 它不香吗?**

![20210726223220](https://cdn.dong4j.site/source/image/20210726223220.png)

#### JProfiler/VisualVM Launcher/VisualGC/YourKit

> **推荐** 安装 JProfiler (基础架构与数据部 **必须** 安装), YourKit 不好弄, 还没找到共享版.

**作用: 启动为什么慢如蜗牛? deadlock 发生在哪里? JVM 为何频频 OOM? 是道德的沦丧还是人性的扭曲? 用用 JProfiler 就知道了.**

**JProfiler **

![20210726231502](https://cdn.dong4j.site/source/image/20210726231502.png)

**VisualGC **

![20210726231346](https://cdn.dong4j.site/source/image/20210726231346.png)

#### RemoteTail

> **推荐** 安装, 后期我们会开发一套日志系统, 用于解决日志查看困难问题. 目前可暂时使用这个插件, 并为大家提供所有服务的日志对应关系与日志查看账号.

**作用: IDEA 直接查看服务器日志, 自己动手丰衣足食.**

![20210726225254](https://cdn.dong4j.site/source/image/20210726225254.png)

#### JWT

> **必须** 安装

**作用: 直接解析 token 内的数据**

![20210726225736](https://cdn.dong4j.site/source/image/20210726225736.png)

#### MybatisCodeHelperPro

> **推荐的推荐** 安装

**作用: [自己去看看](https://gejun123456.github.io/MyBatisCodeHelper-Pro/#/) 提供多少功能, 能给我们提高多少开发效率, 一年 60 块 2 个激活码, 反正我是买了, 支持一下国内开发者吧**, 哪天你开发了一个我也买.

也可以支持一下 [我的开源插件](https://github.com/dong4j/markdown-image-kit)

**这里也可以投票让公司出钱买**, 这个对于我们后端开发来说是一个开发利器.

![20210726230440](https://cdn.dong4j.site/source/image/20210726230440.png)

#### Save Actions

> **推荐的推荐** 安装

**作用: 手动保存文件之前执行一些自定义操作, 比如添加 this, 格式化代码, 删除无用 import 等**.

#### Spot Profiler for Java and Kotlin

> **推荐** 安装

**作用: 想知道某段代码执行的时间? 使用 Stopwatch 输出后上线时搞忘了删除? 用这个吧.**

![20210802170443](https://cdn.dong4j.site/source/image/20210802170443.png)

#### SequenceDiagram

> **推荐** 安装

**作用: 根据代码调用逻辑自动生成时序图, 快速梳理代码逻辑的利器**

![20210802171529](https://cdn.dong4j.site/source/image/20210802171529.png)

### Intellij IDEA 设置

 [这篇文档](../plugin/README.md) 对 IDEA 部分配置做了说明, 还是推荐大家先看看 [Intellij IDEA 教程](https://github.com/judasn/IntelliJ-IDEA-Tutorial), 对 IDEA 的配置有一个整体的了解, 接下来将介绍一下个人觉得有用但是大家一直没有去很好的设置的地方.

#### 启动时重新打开项目

经常看到启动 IDEA 时自动打开了最后关闭的项目, 为什么不在启动的时候自己选择呢? 难道最后一个关闭的项目就一定是我们想打开的嘛?

取消 **启动时重新打开项目** 选项

![](https://cdn.dong4j.site/source/image/20210726232910.png)

启动时你就能看到这个页面, 这里再选择它不香吗?

![20210726232650](https://cdn.dong4j.site/source/image/20210726232650.png)

#### Maven 环境配置

经常看到第一次打开新项目的时候还要手动去修改 Maven 的环境配置, 了解一下 **项目级配置**:

![20210726233606](https://cdn.dong4j.site/source/image/20210726233606.png)



这里面的配置将会作为所有 **新项目** 的默认配置, 不用每次都去修改了, 多节约点时间回家撸猫不好吗?

记得再看看 **为新项目运行配置模板** 和 **新项目的结构** 这些配置, 多看看总是有好处的.

#### Git 操作

**请注意**, 在不是非常熟悉 git 命令的情况下, 不要在公司使用 git 命令行操作代码, 可以回家自己玩儿, 辛苦一天写的代码丢了就不好玩儿了 (如果无所谓我怀疑你在摸鱼).

[这里](http://192.168.2.15/fkh-docs/views/tool/2017/030314.html) 有讲到怎么使用 IDEA 的图形化界面去操作 Git 的. [这里](./project-gitlab.md) 有讲到怎么在多个项目中使用 Git 的.

我推荐大家使用图形化界面的方式去操作 Git, 我们不会觉得这样不高级, 面试的时候也没人会问你 Git 拉取分支的命令是什么 (要是真有人问, 你就反问 Git 的实现原理是什么? 指针与引用的区别又是什么? 然后带上微笑默默地走出办公室, 深藏功与名 😎).

#### Git Patch/Cherry-Pick

想从某个分支合并某一条或几条 commit? 用用 **Cherry-Pick** 吧. 在家修改了代码不能提交到公司仓库? 用用 **Patch** 吧.

**Cherry-Pick**

![20210727001733](https://cdn.dong4j.site/source/image/20210727001733.png)

**Patch**

![20210727001753](https://cdn.dong4j.site/source/image/20210727001753.png)



#### 配置备份

如果不想重复配置, 如果想让公司的配置和家里的配置保持同步, 试试这个吧, 推荐使用 Gitee 同步配置, 不过一定要记得 **设置为私有项目**.

![20210727000858](https://cdn.dong4j.site/source/image/20210727000858.png)



#### 代码快速执行

如果想临时快速的验证某一段代码, 直接用 JShell(JDK11+) 或 Groovy 吧, 不用再写单元测试了.

![20210727001121](https://cdn.dong4j.site/source/image/20210727001121.png)

#### 快捷键配置

请大家为 **FKH.Kit.JavaDoc** 添加一下快捷键吧, 不要在用鼠标点点点了, 多用快捷键呀, **这样显得高大上**.

![20210727002344](https://cdn.dong4j.site/source/image/20210727002344.png)

其他的快捷键根据习惯自己设置吧.

**多用快捷键**

**多用快捷键**

**多用快捷键**

代码规范我们前面介绍了会使用 Maven 插件检查, 请一定不要手动添加 **-Dcheckstyle.skip=true** 和 **-Dpmd.skip=true** 去忽略代码检查(不要逼我修改这 2 个参数),

并且必须在提交代码前保证能通过编译(**能运行不代表代码检查通过**), 可以手动执行 `mvn clean validate`.

个人认为代码规范是在 **编码过程中去下意识遵守的** , 而不是因为项目工期紧就去忽略这一项工作, 后期再花几天时间去改代码格式, 请一定要记住这个逻辑.

其实这就是一个编码习惯的问题, 前期可能不习惯经常忘记, 后面就好了, 不过一定要下意识的按照代码规范写代码, 只有这样才能养成习惯.

还有:

**不要拷贝 V4 的代码**

**不要拷贝 V4 的代码**

**不要拷贝 V4 的代码**

## 1. 开发规范

目前我们正在开发 **zeka-iot** , 这个项目目前涉及到的模块比较全面, 且比较简单, 因此我们就以 **zeka-iot** 作为示例, 讲讲使用 Zeka Stack 框架开发的项目需要遵守的规范与约定.

### 1.1 项目结构规范

可以先从 [如何组织本地代码](./project-gitlab.md) 开始, 了解一下 Zeka Stack 项目通常包含哪些子项目, 以及为什么要这么去组织代码.

由于现在是以一个 Gitlab Group 作为一个业务项目, 意思是一个业务项目会包含多个 Git 项目, 目的是将各个子项目分开进行权限管理, 但也带来如下问题:

1. 多个 git 项目不好管理分支;
2. 多个 maven 子项目没有一个父 pom, 因此无法全局操作所有子模块;

以上 2 个问题解决办法在  [如何组织本地代码](./project-gitlab.md) 文档中已作出说明, 需要 **特别强调** 的是:

**必须保证每个 Git 都存在相同的分支, 且切换分支时需要全部项目一起切换!**

#### 1.1.1 项目文件

我们规定只要是一个单独的 Git 项目且是通过 Maven 管理时, **必须** 包含以下几个文件:

1. **.gitignore**: git 项目忽略文件;
2. **.editorconfig**: IDE 全局配置文件;
3. **mvnw.cmd**: maven wrapper windows 脚本;
4. **mvnw**: maven wrapper linux 脚本;
5. **.mvn 目录**: maven wrapper;

::: tip
Maven Wrapper 的作用与使用方式请自行搜索
:::

这些文件 **必须** 从  [fkh-framework-guide](http://192.168.2.18/share/fkh-framework-guide/tree/master/files) 项目直接复制 (master 分支), **请不要从以前的老项目拷贝**.

目录结构:

```
.
├── zeka-doc-xxx
│   ├── db									  # sql 目录 (必须)
│   │   ├── 20210812
│   │   └── init.sql
│   ├── drawio								  # drawio 目录 (必须)
│   │   ├── message-count-design.drawio.svg
│   │   └── server-relationship.drawio.svg
│   ├── imgs								  # image 目录 (必须)
│   ├── .editorconfig						  # IDEA 全局配置文件 (必须)
│   ├── .gitignore							  # git 忽略文件 (必须)
│   ├── README.md							  # 项目说明 (必须)
│   ├── branch.md							  # 分支说明 (必须)
│   ├── pom.xml								  # 知识库部署配置 (必须)
│   ├── publish.sh							  # 一键部署脚本 (必须)
│   ├── deploy.md							  # 项目部署说明 (必须)
│   └── product 							  # 产品相关文档 (必须)
├── frontend								  # 前端项目相关文件
│   ├── .editorconfig
│   ├── .gitignore
│   ├── pom.xml								  # 前端项目配置 (必须)
│   └── publish.sh							  # 一键部署脚本 (必须)
├── service									  # 后端服务相关文件
│   ├── .editorconfig
│   ├── .gitignore
│   ├── .mvn								  # maven wrapper (必须)
│   ├── mvnw
│   └── mvnw.cmd
├── pom.xml									  # 本地管理多个 git 项目的 pom 配置, 需要自行添加
└── settings.xml							  # 公司 maven 私服配置

```

我们会定期维护上述文件, 可能会修改部分配置, 但会保证 master 分支配置的正确性与实时性.

在创建新项目时, 请明确以下几点:

1. 如果是一个独立的 Maven 项目且非多模块, 上述文件与 pom.xml 文件同级;
2. 如果是多模块的 Maven 项目, 上述文件与主 pom.xml 同级;
3. 前面 2 条成立的条件是 pom.xml 文件应该在项目主目录, 非 v4 的项目结构(pom.xml 在单独的 parent 项目中);

#### 1.1.2 业务中台项目

一个完整的业务中台项目, 至少应该包含下面五个子项目:

1. **zeka-doc-xxx**: 项目文档, **文档跟着项目走, 跟着分支走**;
2. **zeka-distribution-xxx**: 一键部署;
3. **zeka-center-xxx**: 业务中台服务;
4. **zeka-sdk-xxx**: 给应用层使用的 SDK;
5. **zeka-element-xxx**: sdk, mservice(如果存在) 与 center 项目公共的代码;

各模块之间的依赖关系如下:

![](https://cdn.dong4j.site/source/image/project-relationship-1.drawio.svg)

::: tip

项目名我们按照 **范围从大到小** 的顺序命名.

:::

**zeka-doc-xxx**

我们希望将项目文档归集到一处集中管理, **文档跟着项目的迭代而迭代**. doc 项目 **必须** 包含以下几个文件:

1. **README.md**: 项目说明, 必须说明各个子项目, 模块的作用, 项目需求说明, 项目需求迭代记录以及 todo list;
2. **branch.md**: 用于记录各个分支的作用以及操作时间和操作人, 分支的当前状态 (开发中, 已上线), 基于哪个分支等信息;
3. **information.md**: 用于记录项目的各种信息，包括但不限于：swagger，API， 中间件地址等；
4. **db 目录**: 包括 init.sql, 并使用 **yyyyMMdd** 命名子目录，目录只能包含 SQL 文件，使用方式可以写在部署文档中或者添加注释，项目一旦上线，除非新增的表，其他表结构修改全部使用增量 DDL；
5. **deploy 目录**： **yyyyMMdd** 命名子目录，写明每次上线部署步骤；子目录下包含 `drawio` 和 `imgs` 目录，用于添加 drawio 文件和图片；
6. **design 目录**：使用 `v版本号` 的命名方式，由 **开发人员** 维护，目录下包含 `drawio` 和 `imgs` 目录，用于添加 drawio 文件和图片；
7. **product 目录**： 使用 `v版本号` 的命名方式，由 **产品经理** 维护，目录下包含 `drawio` 和 `imgs` 目录，用于添加 drawio 文件和图片；
8. **other 目录**：其他项目文档，比如第三方接口文档，学习总结文档等；

**注意：**

1. 请加 drawio ，imgs 与 MD 文档通过目录划分，不要直接将 drawio 或图片放到 MD 同级目录；
2. 目录名如果使用英文， 请使用 **小写** （除非需要大写的专有名词）；
3. 如果使用中文文件名, 请使用英文的 **-** 替换空格；
4. 每个目录都应该包含 `drawio` 和 `imgs` 目录，请将 MD 引用的文件放到同级的  `drawio` 或 `imgs` , 子目录中同理；

::: tip

从 v1.9.0 开始, 项目文档也可通过插件直接部署到服务器, 供所有人查看与学习, 我们把这个称为 **项目知识库**, 可通过访问 [http://192.168.2.15:9527](http://192.168.2.15:9527) 查看;

项目知识库部署配置可参考 [知识库一键部署说明](http://192.168.2.18/share/fkh-framework-guide/blob/master/fkh-plugin-sample/fkh-publish-maven-plugin-sample/docs/1.9.0/README.md).

:::

**项目权限**

doc 项目的权限除了项目组的开发成员, 还应该添加项目组内的 **测试**, **产品** 等同事, 共同维护 doc 内所有文档.

**规范**

1. 模块命名规则 **必须** 为:  `zeka-doc-项目名`;
2. **必须:** 附件必须是原文件,比如 md 中使用的 draw.io 画的图, 不允许使用截图, 必须上传 draw.io 原文件, md 文件不允许转换成 word 或 pdf 再上传;
3. **必须:**  md 中的附件链接必须是相对路径且必须使用 Linux 路径格式, , 否则在其他同事更新后可能就无法跳转或显示;
4. **必须:** 图片全部上传到 **imgs** 目录, draw.io 文件上传到 **drawio** 目录;
5. **推荐**: 如果配图使用 drawio, 推荐使用 IDEA 插件 **Diagrams.net Integration**, 每个配图一个 svg 文件, 可直接在 IDEA 绘制配图并显示;

**zeka-distribution-xxx**

此项目用于简化服务部署, 提升工作效率, 可根据配置快速部署服务.

此模块需要配合 **package-all.xml** 文件使用, 具体的使用方式请参考 [zeka-framework-guide](http://192.168.2.18/share/zeka-framework-guide/blob/feature/1.8.0/zeka-plugin-sample/zeka-publish-maven-plugin-sample/batch/sample-distribution/package-all.xml).

如果需要单独部署某一个模块, 只需要在 **pom.xml** 中为部署模块添加一键部署配置:

```xml
<properties>
  <package.name>zeka-center-iot</package.name>

  <!--region 部署配置 -->
  <publish.enable>true</publish.enable>
  <!-- 最终的部署路径: /opt/apps/${env}/iot -->
  <publish.group.id>iot</publish.group.id>
  <!-- 只部署 test 环境, 需要添加参数: -Dpublish.env=test -->
  <publish.hosts.test>192.168.2.72</publish.hosts.test>
  <!-- 只部署 prev 环境, 需要添加参数: -Dpublish.env=prev, 如果不添加任何参数, 将部署到 dev, test, prev 3 个环境 (未配置某个环境将忽略部署)-->
  <publish.hosts.prev>192.168.2.73</publish.hosts.prev>
  <!--endregion-->
  <jvm.options>-Xms256M -Xmx256M</jvm.options>
  <!-- -Dpackage.env.prod=true 将使用此配置代替 jvm.options -->
  <prod.jvm.options>-Xms512M -Xmx512M</prod.jvm.options>
</properties>
```

**项目权限**

项目后端开发小组.

**规范**

1. 模块命名规则 **必须** 为: `zeka-distribution-项目名`;
2. **请在编译通过的前提下再部署**.

**zeka-center-xxx**

此项目是业务中台的项目结构, 应用层项目结构后面会讲到.

业务中台服务为应用层提供业务能力, 为提高应用层与业务中台层的兼容性, 减少对应用层的侵入, 通讯协议选择使用 HTTP.

最开始我们提供了 `AgentTemplate` 接口让应用层直接使用, 后面由于使用方式的问题我们又基于 `AgentTemplate` 封装了 SDK 模块, 用于简化应用层调用逻辑;

而为了提高业务中台层之间的调用效率我们选择使用 RPC 协议通讯, 因此业务中台层需要提供一个 Dubbo API 模块给其他业务中台服务依赖.

按照这样的思路, 业务中台项目的模块分层结构如下:

1. **zeka-center-xxx-common**: center 各个模块共用的工具类, 枚举类, 常量, 异常, 实体等, 顶层包名为 `com.zeka.center.项目名.common`;
2. **zeka-center-xxx-client-dubbo**: dubbo api, 依赖 zeka-center-xxx-common, 顶层包名为 `com.zeka.center.项目名.client.dubbo`;
3. **zeka-center-xxx-storage**: db 层, 包含一层独立的 service 接口和 dao 接口, 数据库实体 **必须** 在这一层, 依赖 zeka-center-xxx-common, 顶层包名为 `com.zeka.center.项目名.storage`;
4. **zeka-center-xxx-agent**: 业务中台逻辑处理模块, agent service 接收 HTTP 请求, dubbo provider 接收 RPC 请求, 依赖 zeka-center-xxx-storage, 顶层包名为 `com.zeka.center.项目名`;
5. **zeka-center-xxx-schedule** (非必须): 定时任务执行器, 根据项目需求选择添加, 依赖 zeka-center-xxx-client-dubbo, 顶层包名为 `com.zeka.center.项目名.schedule`;

以 center 为例, 判断 package 是否应该分模块的原则是: **是否需要被其他模块引用**.

按照这个原则我们将原来的 **service** 和 **manager** 模块以 package 的形式合并到了 agent 模块中.

但是 storage 比较特殊, 从 v4 开始我们一直将 db 层单独作为一个模块,  原因是多个 mservice 可能都会依赖 storage 层访问 db, 另一种考虑是可能存在某种聚合型项目, 用于访问多个数据库进行 **非常规性操作**, 比如 **跨库数据迁移**.

**fkh-center-xxx-client-dubbo**

需要特别注意的是, 如果项目存在 mservice 模块, **必须** 将 mservice 层使用到的异常类放入到 dubbo 模块中, 否则 dubbo 消费者无法正确解析异常信息.

**fkh-center-xxx-agent**

从 1.9.0 开始, 我们开始按照领域模型进行 package 分层, 比如 `zeka-center-iot-agent` 的 package:

<br/>
<details><summary><B><I style="cursor:pointer; color: #0e5870">🎉 zeka-center-iot-agent</I></B></summary>

```
.
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── zeka
    │   │           └── center
    │   │               └── iot
    │   │                   ├── config
    │   │                   ├── module
    │   │                   │   ├── datareporting
    │   │                   │   │   ├── agent
    │   │                   │   │   ├── manager
    │   │                   │   │   └── service
    │   │                   │   │       └── impl
    │   │                   │   ├── device
    │   │                   │   │   ├── agent
    │   │                   │   │   └── service
    │   │                   │   │       └── impl
    │   │                   │   ├── gps
    │   │                   │   │   ├── agent
    │   │                   │   │   ├── provider
    │   │                   │   │   └── service
    │   │                   │   │       └── impl
    │   │                   │   ├── metas
    │   │                   │   │   ├── agent
    │   │                   │   │   └── service
    │   │                   │   │       └── impl
    │   │                   │   ├── product
    │   │                   │   │   ├── agent
    │   │                   │   │   └── service
    │   │                   │   │       └── impl
    │   │                   │   ├── statistics
    │   │                   │   │   ├── agent
    │   │                   │   │   ├── cache
    │   │                   │   │   │   └── impl
    │   │                   │   │   ├── events
    │   │                   │   │   ├── handler
    │   │                   │   │   ├── launcher
    │   │                   │   │   ├── payload
    │   │                   │   │   └── service
    │   │                   │   │       └── impl
    │   │                   │   └── system
    │   │                   │       ├── agent
    │   │                   │       └── service
    │   │                   │           └── impl
    │   │                   └── utils
    └── test
```
</details>




**以后不管是 center 还是 rest 层, 都要求按照领域模型进行分包**, 这样能够让代码结构更加合理, 从原来分散到各个 pakcage 聚焦到一个 module 下, 对排查问题提供了便利.

为了解决微服务错综复杂的调用关系, 我们 **规定** 了中台服务之间以及下层的服务调用规则, 即:

1. **应用层服务只能通过 HTTP 协议调用 Center 服务**;
2. **Center 层之间只能通过 RPC 服务调用**;
3. **Center 层用于聚合 mservice 层的 RPC 服务(如果存在多个 mserivce 服务的情况下);**

调用关系如下图:

![](https://cdn.dong4j.site/source/image/center-interaction.drawio.svg)

Center 层使用 HTTP 通信协议主要是考虑到接口的兼容性, 使用 JSON 数据的请求/响应模型能够兼容大多数语言, 但是 HTTP 通讯协议工作在 OSI 的第七层, 效率比不上 TCP, 因此 Center 层之间与 Center 层与下层的 mservice 之间都采用 RPC.

为了能够内聚业务中台的基础能力, 我们规定不同的 Center 下的 mservice 不能相互调用, **只能** 通过 center 交互. 按照这种规定,  Center 层 **不能** 存在其他 Center 层下的 mservice 依赖.

**项目权限**

项目后端开发人员.

**全局规范**

1. 模块命名规则 **必须** 为: `zeka-center-项目名`;
2. 顶级包名命名规则: `com.zeka.center.项目名`;
3. **必须** 存在 `com.zeka.center.项目名.config` package, 且 **必须** 包含 `ApplicationConfiguration.java` 和 `ApplicationProperties.java` 2 个类;
4. **必须** 在 `ApplicationProperties.java` 中定义 **应用配置前缀名**, 命名规则为: **zeka.项目名.配置分组名**, 应用配置类写法如下:

   ```java
   @Slf4j
   @Configuration
   @EnableConfigurationProperties(ApplicationProperties.class)
   public class ApplicationConfiguration {

   }

   @Data
   @ConfigurationProperties(prefix = ApplicationProperties.PREFIX)
   public class ApplicationProperties {
       /** Prefix */
       static final String PREFIX = "zeka.项目名";

       /** 其他应用配置 */
       private OtherProperties other = new OtherProperties();

       @Data
       public static class OtherProperties {
               // 配置字段
       }
   }

   ```

5. **不允许** 在 `RepositoryService` 上层直接使用 Mybatis Plus 的 wrapper 操作 db, **必须** 全部封装到 `RepositoryService` 层;
6. **必须** 定义接口错误枚举类和项目级异常, 且错误信息 **必须** 写入到国际化错误信息文件中, 即必须存在如下类文件 (写法可参考 guide 项目):

   1. XxxCenterExceptionAssert: 实现 ResultCode, IAssert 2 个接口, 用于简化异常抛出的写法;
   2. XxxCenterBundle: 将错误消息配置文件绑定到异常枚举上;
   3. XxxCenterErrorCodes: 异常枚举定义;
   4. XxxCenterException: 项目级异常, 必须继承 `BaseException`;
7. 国际化错误信息 key **必须** 使用项目名前缀, 比如 `iot.xx.yy=错误消息`;
8. DTO 和 PO 的之间的转换 **必须** 使用 `ServiceConverter` 的子接口;
9. 所有的 Bean 注入 **必须** 使用构造注入(请直接使用 `@AllArgsConstructor`), 且注入的字段必须使用 `final` 修饰;

**Agent 接口规范**

1. Agent 接口名 **必须** 以 `Agent` 结尾;
2. Agent 接口的入参 **只能** 是 Void, 基础类型, Query 或 DTO, 出参 **只能** 是 void , 基础类型, DTO, 集合,
3. 提前定义 Agent service apiName, 从 1.8.0 开始优先使用 **code**, 一旦定义后 **不可修改**;
4. ApiService.code 使用 **大写英文字母**, **一位到两位**;
5. ApiServiceMethod.code 使用 **数字类型的字符串**, **四位数**且从 **1000** 开始 (0000~0999 由框架使用, 提供扩展接口);
6. Agent 接口 **必须** 添加 Swagger 响应的注解, 且 **必须** 保证接口描述的正确性, 完整性与实时性 (更多规范请查看 **Swagger 规范**);
7. Agent 接口类的方法命名规则应该尽量简单, 通常包含如下方法名:

   1. page: 获取分页数据
   2. list: 获取 list
   3. get: 根据 id 获取单条数据
   4. saveOrUpdate: 新增或更新
   5. remove: 删除指定数据

   对于 page 和 list 接口, 我们可以根据实际情况, 简化为调用一个 page 的 sql:

   ```java
   @ApiServiceMethod(code = Names.Common.PAGE)
   public IPage<DeviceDetailDTO> page(DeviceQuery deviceQuery) {
     return this.deviceService.page(deviceQuery);
   }
   
   @ApiServiceMethod(code = Names.Common.LIST)
   public List<DeviceDetailDTO> list(DeviceQuery deviceQuery) {
     return this.deviceService.list(deviceQuery);
   }
   
   @ApiServiceMethod(code = Names.Common.GET)
   public DeviceDetailDTO get(Long id) {
     List<DeviceDetailDTO> records = this.deviceService.list(DeviceQuery.builder().id(id).limit(1).build()).getRecords();
     return CollectionUtils.isNotEmpty(records) ? records.get(0) : null;
   }
   ```

   对于 Center 层的接口, 我们应该遵守 **通用性原则**.

   比如查询接口, 我们应该在交付接口前考虑到用户可能会通过 id, name, keyword 等条件查询分页, list 或单条数据, 而不是只提供一个根据 `getById` 的接口, 这样当用户需要根据 name 获取单条数据时, 我们不得不新增接口并部署.

   根据上面的描述, 以查询业务为例, 我们可以抽象出以下 3 个接口:

   ```java
   IPage<DeviceDetailDTO> findPage(DeviceQuery query);
   List<DeviceDetailDTO> findList(DeviceQuery query);
   DeviceDetailDTO findOne(DeviceQuery query);
   ```

**zeka-sdk-xxx**

**项目权限**

项目后端开发人员.

**规范**

1. 模块命名规则 **必须** 为: `zeka-sdk-项目名` ;
2. 顶级包名命名规则 **必须** 为: `com.zeka.sdk.项目名`;
3. sdk client **必须** 放在 `com.zeka.sdk.项目名` 包下, 与 SpringBoot 的启动主类所在包路径规则一致;
4. sdk client 定义如下 (以 iot center 为例):

   ```java
   @SuppressWarnings("java:S1214")
   @ServiceName(CenterIotSdkClient.SERVICE_NAME)
   public interface CenterIotSdkClient extends AgentClient {
       /** 必须使用 项目名-center 命名 */
       String SERVICE_NAME = "iot-center";
   }
   ```

5. 应用层使用时 **推荐** 自定义 client, 必须实现 sdk 包提供的接口, 且只能使用 **@Client** (应用层可使用 Client.endpoint 等属性):

   ```java
   @Client
   public interface SubIotSdkClient extends CenterIotSdkClient {
   }
   ```

6. 如果需要给 V4 使用, 必须包含 **zeka-sdk-项目名.xml** 文件由 V4 引入, 具体内容如下:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:context="http://www.springframework.org/schema/context"
          xmlns="http://www.springframework.org/schema/beans"
          xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context.xsd">

       <!-- 注入 client 相关的 bean, 必须精确到项目名, 不允许直接写 com.zeka.sdk -->
       <context:component-scan base-package="com.zeka.sdk.项目名"/>
   </beans>
   ```

7. 开发 SDK 模块时, 最高依赖只能使用  **zeka-element-basic** 依赖, **不允许** 使用 **zeka-element-core** 及以上依赖 (避免向 v4 传递过多依赖, 减少兼容性问题);
8. 此模块的 Spring 依赖 **必须** 使用  `<scope>provided</scope>`, 其他依赖请 **尽量** 使用 `<scope>provided</scope>`, 由应用层来确定依赖版本以避免版本冲突;
9. SDK 接口 **不允许** 使用 get, post 等接口, 请使用最新的 **api** 接口代替;

   ```java
   public void updateDeviceStatus(DeviceEditDTO dto) {
        // 使用 api 代替原来的 get post 等接口
        this.client.api(this.function(Names.Device.STATUS))
            .params(dto)
            .perform()
            .failException(IotClientException.class)
            .andReturn()
            .expect(Void.class);
   }
   ```

10. 此模块修改后 **必须** `deploy` 到公司远程仓库;
11. serviceName 命名 **必须** 为 `xxx-center`;

**zeka-element-xxx**

比如 `zeka-third` 和 `zeka-payment` 这类需要在 mservice 和 center 共用的代码需要抽离到 `zeka-element-xxx` 项目, 且此模块会被 `zeka-sdk-xxx` 和 `zeka-center-xxx-common` 共同依赖, 为 2 个项目提供公共类. 由于 SDK 会被 v4 项目依赖, 为了减少过多的 Zeka Stack 依赖传递到 v4 , 我们将限制此模块的依赖层级关系与添加依赖的方式.

>  **zeka-element** 项目是 Zeka Stack 框架的基础库, 最开始是没有 **zeka-element-basic** 这个模块的, 后来为了兼容 v4 框架, 将部分基础代码下沉到现在的 **zeka-element-basic** 模块中, 整个项目的模块依赖关系如下:

>  ![](https://cdn.dong4j.site/source/image/element-relationship.drawio.svg)

**项目权限**

项目后端开发人员.

**规范**

1. 模块命名规则 **必须** 为: `zeka-element-项目名` ;
2. 顶级包名命名规则 **必须** 为: `com.zeka.element.模块名.项目名`;
3. 此模块最高 **只能** 依赖 **zeka-element-basic**, 且不能添加 Zeka Stack 的 starter 组件;
4. 如果添加了 spring 相关依赖, scope **必须** 为 **provided**;

对于第 4 点规范要求, 主要是防止版本冲突的问题出现.

作为 SDK 的开发者, 一定要考虑依赖传递对使用端的影响, **请合理使用 maven 的 scop 标签**.

#### 1.1.3 前台项目

我们将 Gateway 上层的应用统称为 **前台项目**, 比如现在的 TCS, BMS 等项目, 他们是一个自成体系的应用层项目, 包含前端代码和后端 API.

前台项目可以是一个单体的 SSM 应用, 也可以是由多个 mservice 组成的大型分布式项目.

业务中台是现有业务的通用逻辑抽象和基础功能服务, 比如 **运单中心**, 只会管理运单的生命周期, 运单数据可以从现有的 **车货匹配** 和 **网络货运** 业务中来.

业务中台注定是 **底层通用逻辑**, 因此 **绝对不能** 调用应用层服务.

##### 1.1.3.1 前端项目

@陈宗飞

**项目权限**

项目前端开发人员.

**规范**

1. 如果是客户使用的应用, **推荐** 使用 **portal**, 比如 **zeka-portal-xxx-ui**;
2. 如果是管理端类型(后端项目, 比如 BMS, 租户管理等项目)的应用, **推荐** 使用 **dashboard**, 比如 **zeka-dashboard-xxx-ui**;
3. **必须** 使用对应的 后端项目名 + "-ui" 命名, 比如 `zeka-dashboard-iot` 对应的前端项目名为 `zeka-dashboard-iot-ui`;
4. build 后的目录名 **必须** 与前端项目名相同;
5. app.config.js 中的 `proApiAgency` **必须** 使用对应的 `/${后端项目名}-api`
6. pom.xml 中的 `dist.path` 标签 **必须** 与 build 后的目录名一致;
7. pom.xml 中的 `publish.group.id` 标签 **必须** 与前端项目名一致;
8. 分支名 **必须** 与对应的后端分支名保持一致, 且需求开发前需要与后端沟通是否需要使用新的分支;

##### 1.1.3.2 后端项目

**项目权限**

项目后端开发人员.

**规范**

1. 接口 **必须** 使用 [RESTful](https://www.ruanyifeng.com/blog/2011/09/restful.html) 风格(从 2.0.0 开始实现了 API 多版本号功能, 我们从接口的易用性与接口文档的可读性上考虑违背了 **RESTful** 对于 **version** 的架构思想. 既然作为一个 **架构风格**, 我们可以有自己的实现方式);
2. **必须** 存在 `com.zeka.应用类型名(portal/dashboard).项目名.config` package, 且 **必须** 包含 `ApplicationConfiguration.java` 和 `ApplicationProperties.java` 2 个类;
3. **必须** 在 `ApplicationProperties.java` 中定义 **应用配置前缀名**, 命名规则为: **zeka.项目名.配置分组名**;
4. 异常类等规范参考 Center 层写法;
5. **必须** 按照领域模型进行 package 分层:

  <br/>
  <details><summary><B><I style="cursor:pointer; color: #0e5870">🎉 module</I></B></summary>

   ```
   .
   ├── main
   │   ├── java
   │   │   └── com
   │   │       └── zeka
   │   │           └── dashboard
   │   │               └── iot
   │   │                   ├── clients
   │   │                   ├── config
   │   │                   ├── consts
   │   │                   ├── module
   │   │                   │   ├── device
   │   │                   │   │   ├── controller
   │   │                   │   │   ├── converter
   │   │                   │   │   └── entity
   │   │                   │   │       ├── form
   │   │                   │   │       └── vo
   │   │                   │   ├── metas
   │   │                   │   │   ├── controller
   │   │                   │   │   ├── converter
   │   │                   │   │   └── entity
   │   │                   │   │       ├── form
   │   │                   │   │       └── vo
   │   │                   │   ├── product
   │   │                   │   │   ├── controller
   │   │                   │   │   ├── converter
   │   │                   │   │   ├── entity
   │   │                   │   │   │   ├── form
   │   │                   │   │   │   └── vo
   │   │                   │   │   └── service
   │   │                   │   │       └── impl
   │   │                   │   ├── statistics
   │   │                   │   │   ├── controller
   │   │                   │   │   ├── service
   │   │                   │   │   │   └── impl
   │   │                   │   │   └── wrapper
   │   │                   │   ├── system
   │   │                   │   │   ├── controller
   │   │                   │   │   ├── converter
   │   │                   │   │   └── entity
   │   │                   │   │       ├── form
   │   │                   │   │       └── vo
   │   │                   │   └── user
   │   │                   │       ├── controller
   │   │                   │       ├── entity
   │   │                   │       │   ├── dto
   │   │                   │       │   └── form
   │   │                   │       └── service
   │   │                   │           └── impl
   │   │                   ├── utils
   │   │                   └── websocket
   │   │                       └── vo
   │   └── resources
   └── test
   ```
  </details>

#### 1.1.4 数据流

![](https://cdn.dong4j.site/source/image/data-stream.drawio.svg)



1. 前台项目请使用 **ServiceConverter** 和 **ViewConverter** 进行实体转换, **不允许** 使用 BeatUtils 进行实体互转;
2. API 层 **只允许** 做参数校验, 调用业务服务, 数据组装和结果转换操作, **不允许** 调用 DAO 接口;
3. manager 层用于调用非本应用服务, 需要在此层处理好异常和结果转换;
4. 应用层 **尽量使用** SDK 调用业务中台服务;
5. Agent Service 出参只能是 DTO 或基础类型; **不允许** 使用 Map 或 JsonObject, 入参同样不允许使用 Map 或 JsonObject;

### 1.2 其他命名规范

#### 1.2.1 网关

应用的路由配置模板如下:

```json
{
  "filters": [
    {
      "args": {
        "parts": "1"
      },
      "name": "StripPrefix"
    }
  ],
  "id": "${应用名}",
  "order": 2,
  "predicates": [
    {
      "args": {
        "pattern": "/${path}/**"
      },
      "name": "Path"
    }
  ],
  "uri": "lb://${应用名}"
}
```

1. 应用名 **必须** 与 **package.name** 一致, 如果未配置则与 **artifactId** 一致;
2. path **必须** 使用 **xxx-center** 的方式命名, 比如: `user-center`, `iot-center` ;

#### 1.2.2 中间件

为了避免多个中间件实例加大运维复杂度, 我们使用 docker 部署了所有的中间件, 并通过后缀去区分不同的环境, 如果不能使用后缀区分才会使用 docker 部署多个实例.

现对部分中间件的使用作出规范.

##### 1.2.2.1 MySQL

1. 如果是本公司产品使用的数据库, **必须** 使用 `zeka_` 作为数据库前缀;
2. 数据库 **必须** 使用 `_${env}` 作为后缀, 以区分不同环境, 生产环境不需要添加后缀;
3. 项目中 **必须** 使用如下链接格式:

   ```
   jdbc:mysql://mysql.server:3306/zeka_xxx_${spring.profiles.active}?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=Asia/Shanghai&useAffectedRows=true
   ```

   其中 `xxx` 需要替换, `${spring.profiles.active}` 保持原样.

##### 1.2.2.2 Mongo

1. 如果是本公司产品使用的数据库, **必须** 使用 `zeka_` 作为数据库前缀;
2. 数据库 **必须** 使用 `_${env}` 作为后缀, 以区分不同环境, 生产环境不需要添加后缀;

##### 1.2.2.3 Redis

1. key 的命名规则: **group 缩写** + **:** + **项目名** + **:** + **业务含义** 例如: p:iot:device:{deviceId}, 其中  group 缩写同 **Naocs 的 Group 规则类似 **, **iot** 是项目名, 其他是业务含义. 这样做能有效避免 key 冲突;
2. 英文字符的 **:** 作为 key 的分隔符,方便客户端工具作为目录分级;
3. key 的维护应该由 **写入方** 负责, 即写入方应该对 key 的生命周期进行管理. 如果在同一个项目, 最好封装一层业务逻辑对 key 进行管理, 其他开发者只需要调用业务接口即可, 不需要关心具体操作的 key; 如果是跨应用使用 key , 最好的做法是将 cache 层的操作抽离成一个 jar, 其他项目进行依赖. 这样能够有效减小维护成本；

##### 1.2.2.4 定时任务执行器

1. 执行器的命名规则: `${package.name}-${spring.profiles.active}`, 生产环境需要删除 `-${spring.profiles.active}`;
2. 请尽量完善 `@Job` 注解中的几个字段, 从 `v2.0.0` 开始将直接读取这几个属性, 可简化创建任务的步骤;

#### 1.2.3 版本号

##### 1.2.3.1 项目版本号

我们要求同一个 group 下的 git 项目在同一个分支的项目版本号 **必须** 一致, 因此在创建了一个新的 feature 分支时, 需要全局修改所有 pom.xml 中的 version.

**全局规范**

1. **必须** 使用 x.x.x 的方式命名，且 x 必须为数字 (开发初期需要添加后缀: `**-SNAPSHOT**`)；
2. 起始版本 **必须** 从 **1.0.0-SNAPSHOT** 开始;
3. 同一个 group 内的所有项目在同一个分支时版本号 **必须** 保持一致;
4. 如果是 **feature/x.x.x** 分支时, 项目版本号 **必须** 和 **x.x.x-{后缀}** 一致;
5. 第三方版本号 **必须** 定义到 **pom.properties** 标签中, 不能直接写到依赖中;
6. 第三方版本号标签使用 **artifactId.version** 定义, 比如 **<fkh-iot-sdk.version>1.1.1-SNAPSHOT</fkh-iot-sdk.version>**

**版本号修改规范**

1. 修改内部逻辑, bug 等, 只修改最后一位版本号: `1.0.0 -> 1.0.1`;
2. 改动 API, 新增功能, 与旧版本有明显兼容问题, 修改中间版本号: `1.0.0 -> 1.1.0`;
3. 重大调整入整体架构调整, 业务重构, 修改首位版本号: `1.0.0 -> 2.0.0`;

为了减少重复修改 version, 我们可以使用 **revision** 定义当前项目的全局版本号, 子模块使用 **${revision}** 即可.

::: tip

使用 revision 存在以下几点规范:

1. revision 必须定义在一个 Git 项目的 maven 父 pom 中;
2. **不允许** 使用 revision 代替 project.version, 意思是 revision **只能** 用来定义当前模块版本号, 而不是用于依赖的版本号定义;

:::

##### 1.2.3.2 代码版本号

Java Doc 中 **必须** 包含 **@version**, 且使用 x.x.x 结构, 初始化版本为 1.0.0,  版本号修改规范同 **项目版本号-版本号修改规范**;

##### 1.2.3.3 since 版本号

类注释和方法注释 **必须** 添加 **@since**, 表示此类/方法 从哪个分支开始添加, 此版本号初始化为 x.x.x/y.y.y, 提交代码时 **必须** 全局修改为当前所在分支的版本号(不包含 `feature/` 前缀).

**FKH Idea Commit** 插件会将 **@version x.x.x**, **@since x.x.x** 和 **@since y.y.y** 定义为 todo 类型的标签, 因此在提交代码之前请查看 todo list, 且确保 x.x.x 和 y.y.y 已替换.

#### 1.2.4 Swagger 规范

1. 同一类接口 **必须** 使用 **Api.tags** 分组, 比如 IoT Hub 的元数据管理接口, 分为 **设备元数据管理接口** 和 **产品元数据管理接口**, 同属于 **元数据管理** 分组下 (不要把所有接口都平铺展示出来, 这样不方便查找接口);  一般我们按照 **modules** 进行分组:
2. **ApiOperation.value** 最多 **14** 个字符, 其他详细信息写入到 **ApiOperation.notes** 中.

#### 1.2.5 包名

包名 **必须** 使用 **单数** 命名, 比如工具包应该命名为 **util** 而不是 **utils**;

`推荐` 几个常用的包名:

- `config` 用来放配置类, 每个应用都应该存在;
- `util` 工具类包
- `enums` 枚举类包
- `constant` 常量类包 (`推荐` 将常量按类别定义在不同的常量类中且常量类不要使用 interface, 而是 public final 修饰的 class)
- `exception` 异常相关的包, 包括错误代码枚举, 项目异常类, Bundle 类 和 ExceptionAssert;
- `module` 领域模型包, 包含当前领域下相关类, 比如 controller, service, manager, entity 等;
- `service` service 接口包
- `service.impl` service 接口实现类包
- `manager` 第三方
- `dao` dao 接口包
- `provider` 特指 provider 提供的接口类

#### 1.2.6 类名

类名 `必须` 使用 UpperCamelCase 风格(首字母都大写)，必须遵从驼峰形式. 例如: StringUtils

> 抽象类命名 `必须` 使用 Abstract 或 Base 开头;
> 异常类命名 `必须` 使用 Exception 结尾;
> 测试类命名 `必须` 以它要测试的类的名称开始，以 Test 结尾;
> 接口实现类 `必须` 以 Impl 结尾;
> API 接口类必须以 `Controller` 结尾;
> ORM 接口必须以 `Dao` 结尾;
>
> Agent 接口 **必须** 以 `Agent` 结尾;

#### 1.2.7 属性名

这个没什么好说的, 按照 Java 推荐命名方式即可.

> 常量命名 `必须` 全部大写, 单词间用下划线分隔;

## 2. 常用工具类

常用工具类主要集中在 `zeka-element-basic` 和  `zeka-element-core` 模块中, 工具包 package 为 `com.zeka.starter.basic.util` 和 `com.zeka.starter.core.util`.

### 2.1 使用原则

最开始只用 core 工具包, 但是为了给 v4 项目使用, 我们将部分工具类拆分到了 basic 工具包中, 这样能够减少 SDK 引入过多的第三方工具类.

如果存在相同的工具类, **优先使用** 框架已提供的, 如果框架工具类中不存在需要的功能, 再考虑自行在项目中添加对应的工具类或加入第三方工具类(如果只是个别方法, 建议直接拷贝, 而不是添加整个工具包);

### 2.2 basic 工具包

#### 2.2.1 JsonUtils

基于 Jackson 封装的 json 操作工具类, 除了为框架提供了 Rest 层和 Agent 层的参数序列化与反序列化, 还在大量地方使用.

项目中涉及到的 Json 操作, 推荐使用此工具类, **请不要使用 FastJson** .

::: tip

JsonUtils 有一定的初始化配置, 如果我们的初始化 JsonUtils 无法满足业务需求, 可自行获取 ObjectMapper 后配置:

```java
ObjectMapper getCopyMapper();
```

请不要使用 `ObjectMapper getInstance()`, 此接口返回的 `ObjectMapper ` 是整个框架使用的实例, 请在明确影响面的情况下修改.

:::

#### 2.2.2 StringPool

包含常用的符号, 同类还有 **CharPool**;

#### 2.2.3 StringUtils

大量的字符串操作接口, 尽量使用此接口代替其他第三方工具类;

#### 2.2.4 DataTypeUtils

数据类型转换

#### 2.2.5 EnumUtils

枚举操作, 提供通过多种方式获取枚举类, 并提供动态创建枚举的功能;

#### 2.2.6 WebUtils

用于处理HTTP请求的工具类, 包含 url, body 参数解析与转换, 各种参数处理等;

#### 2.2.7 其他

更多的工具类请自行查看

### 2.3. core 工具包

应该能从工具类名了解大致的功能, 请优先使用 `Tools`

```
AesUtils
AntPathFilter
Base64Utils
BeanUtils
ClassUtils
CollectionUtils
ConvertUtils
DateTimeUtils
DateUtils
DigestUtils
FileUtils
Holder
HttpClientUtils
ImageUtils
JvmRandom
Lazy
ObjectUtils
PathUtils
RandomUtils
ReflectionUtils
ResourceUtils
ResultCodeUtils
RuntimeUtils
SnowflakeBuilder
StringUtils
SuffixFileFilter
SystemUtils
ThreadUtils
Tools
Unchecked
XmlUtil
```

#### 2.3.1 其他

- **com.zeka.starter.common.util.ConfigKit**: 配置操作工具
- **com.zeka.starter.basic.constant.ConfigKey**: 大量的配置名常量
- **com.zeka.starter.basic.constant.ConfigDefaultValue**: 配置默认值常量
- **com.zeka.starter.basic.constant.BasicConstant**: 基础常量
- **com.zeka.starter.common.context.SpringContext**: 在任何地方获取 bean

## 3.  细节补充

更多的细节请看 [版本更新说明](../log/README.md)

- 检查 todo 是否完成, 删除已完成的 todo;
- 删除未使用的代码和删除未使用的 bean;
- agent service 层返回的实体使用 DTO，分页查询 IPage;
- agent service 如果实现了 ApiServiceDefinition 接口, 返回结果可使用  `this.ok()` 代替 `R.succeed()`;
- agent 接口没有业务入参时，请使用 Void 占位;
- 请检查 agent service 注入语句, 如果使用了 `@AllArgsConstructor` 就不要再使用 `@Resource`, 且字段使用 final 修饰;
- 统一使用 **@Resource** 代替 **@Autowired**;
- 使用 **构造注入** 代替 **set 注入**;
- 请检查 idea 警告, 使用推荐的写法替换代码;
- agent service 接口请直接使用驼峰命名法, 不再使用中横线, 修改后还需要修改 SDK;
- 这种代码请直接 return:

   ```java
   Map<String, String> retMap = parseContent(reqInfo);
   return retMap;

   修改为:
   return parseContent(reqInfo);
   ```

- 请使用 `WebMvcConfigurer` 代替 `WebMvcConfigurerAdapter`;
- REST 接口必须写 swagger 注解, 且说明必须准确;
- REST 接口层 **不允许** 使用 `@SneakyThrows`;
- 请使用 `PostMapping`, `GetMapping`, `PutMapping` 等代替 `RequestMapper`;
- 请使用 `@SuppressWarnings("unchecked")` 抑制已明确不会出错的类型转换异常;
- 合理修改日志等级; 不要直接输出一句日志, 把上下文一起打印出来;
- 重构 SDK 接口, 参考 `com.fkhwl.payment.client.TenantAgentClient`;
- 将 `fkh-center-payment-callback` 和 `fkh-center-payment-schedule` 拆分为单独的 git 项目;
- 只要是 SDK 依赖的模块, 都不能加 fkh-element-basic 以上的依赖, Spring 的依赖请使用  `<scope>provided</scope>`
- REST 接口请使用 **RESTful 风格的接口名** , 不要用动词, 用请求方式区分操作.
- `fkh-element-devtools` 和 `fkh-element-test` 不需要在加 `<scope>test</scope>`, 框架已经全局加过了.
- 如果想在非 bean 的实例中获取 bean, 请使用 `com.fkhwl.starter.common.context.SpringContext`;
- 用了 ConfigurationProperties 就不需要 Component;
- 流/资源等实现了 `Closeable` 接口在关闭时请使用 `try-with-resource` 语法;
- 不要使用 printStackTrace(), 请用 log.error 代替;
- dao 操作时, createTime 和 updateTime 不需要手动设值;
- 增删改操作不需要返回 boolean, 操作成功返回 void, 操作失败直接抛出异常, 让业务端自己捕获异常处理后面的业务;
- 请定义配置类, **不允许** 使用用 @Value;
- 将使用 `JSONObject`  的代码使用 JsonUtils 替换, **不允许** 使用 FastJson;
- 删除未使用的代码和删除未使用的 bean;
- 请使用 `WebMvcConfigurer` 代替 `WebMvcConfigurerAdapter`;
- REST 接口必须写 swagger 注解, 且说明必须准确;
- REST 接口层不要使用 `@SneakyThrows`;
- 请使用 `PostMapping`, `GetMapping`, `PutMapping` 等代替 `RequestMapper`;
- 请使用 `@SuppressWarnings("unchecked")` 抑制已明确不会出错的类型转换异常;
- 合理修改日志等级; 不要直接输出一句日志, 把上下文一起打印出来;
- Query 不再使用, 请使用 BaseQuery 代替;
- 枚举类需要 `implements SerializeEnum<XXX>`;
- 代码提交前尽量触发一下maven validate,保证编译通过;
- 代码中的 @version 1.0.0 ， @since 1.0.0 ，@since 1.0.0 需要更新为当前具体的版本号;
- 关键流程需要有单元测试代码
- 请修复 maven 编译警告, 包括 依赖冲突, serialVersionUID 未定义, javadoc 警告等;
- 必须使用枚举定义 API 接口错误, 并将错误信息写入到国际化配置文件中;
- 不推荐 `BeanUtils` 进行大量频繁的属性拷贝, 而应该使用 MapStruct;
- 修改代码后, 应该检查对应的 javadoc 是否需要修改;
- 较长的 stream 逻辑应该写清楚作用;

## 4. 服务器规范

1. 后端服务部署目录: `/opt/apps/${env}`, env 包括 dev, test, prev. 如果使用一键部署则会自动创建.
2. 前端 UI 部署目录: `/opt/frontend/${env}`,  env 包括 dev, test, prev. 如果使用一键部署则会自动创建.
3. 日志目录: `/mnt/syslogs/v5/${env}`, env 包括 dev, test, prev. 如果使用一键部署则会自动创建.
4. docker 文件目录: `/mnt/docker`
5. 临时文件目录: `/mnt/tmp`
6. 文件上传目录(不使用分布式文件系统时): `/mnt/data/upload/${env}`, env 包括 dev, test, prev.
7. nginx 目录: `/usr/local/nginx`, 且所有站点配置需要放到 `/usr/local/nginx/conf/conf.d` 目录下, 配置文件名 **使用前端项目名** 命名
8. 其他软件安装目录: `/opt`
9. 所有服务 **必须** 全部使用 **fkhservice** 用户运行;

## 5. 数据库规范

推荐 3 篇文章:

1. [赶集 mysql 军规](https://mp.weixin.qq.com/s?__biz=MjM5ODYxMDA5OQ==&mid=2651960775&idx=1&sn=1a9c9f4b94dfe71ad2528fb2c84f5ec7&chksm=bd2d001b8a5a890d302d139ea42e9ffde44407738a618865934e40b8e35486b13cafca2933f6&mpshare=1&scene=1&srcid=1228MzgFw9KLVzaHtjHvpb2p%23rd)
2. [58到家数据库30条军规解读](https://mp.weixin.qq.com/s?__biz=MjM5ODYxMDA5OQ==&mid=2651959906&idx=1&sn=2cbdc66cfb5b53cf4327a1e0d18d9b4a&chksm=bd2d07be8a5a8ea86dc3c04eced3f411ee5ec207f73d317245e1fefea1628feb037ad71531bc&scene=21#wechat_redirect)
3. [再议数据库军规](https://mp.weixin.qq.com/s?__biz=MjM5ODYxMDA5OQ==&mid=2651959910&idx=1&sn=6b6853b70dbbe6d689a12a4a60b84d8b&chksm=bd2d07ba8a5a8eac6783bac951dba345d865d875538755fe665a5daaf142efe670e2c02b7c71&scene=21#wechat_redirect)

### 5.1 其他规范

1. 数据表 character **必须** 使用 **utf8mb4**, 且 collate 使用 **utf8mb4_general_ci**;
2. 每张表 **必须** 定义 **id** 字段:

   ```sql
   id bigint(20) unsigned not null auto_increment comment '主键Id',
   ```

3. 记录创建时间和更新时间 **必须** 使用 **create_time** 和 **update_time**, 且使用如下 DDL:

   ```sql
   `create_time`  datetime  not null default current_timestamp comment '创建时间',
   `update_time`  datetime  not null default current_timestamp on update current_timestamp comment '更新时间',
   ```

4. 如果需要使用逻辑删除, 则需要添加如下字段:

   ```sql
   `deleted` bit(1) not null default b'0' comment '是否已删除：0=否，1=是',
   ```

5. 使用 **tinyint(2)** 定义大于 2 个类型的枚举;

   ```sql
   `status` tinyint(2) not null default '0' comment '设备状态：0 未激活, 1 未启用, 2 启用, 3 禁用',
   ```

6. 如果字段只存在 true/false, **必须** 使用 **bit(1)** 定义:

   ```sql
   `online` bit(1) not null default b'0' comment '设备在线状态: 0 不在线, 1在线',
   ```

7. 分布式 id 字段 **必须** 定义为 varchar, 避免前端 js 精度丢失;
8. 所有字段 **应该** 指定默认值, **不允许** 全部使用 **default null**; 
9. 所有字段 **必须** 添加注释; 
10. 使用 SQL 脚本插入数据时, **必须** 合并为一条 SQL, **不允许** 使用多条 **insert into** 语句; 
11. 表之间 **不允许** 建立外键关联, 请使用代码保证数据正确性; 
12. 表字段 **必须** 使用 **下划线** 分隔单词;

### 5.2 SQL Template

```sql
create table if not exists base_template (
    `id`          bigint(20) unsigned not null auto_increment primary key comment '主键 Id',
    `status`      tinyint(2)          not null default 0 comment 'xxx 状态: 0=aaa; 1=bbb; 2=ccc; 3=ddd',
    `create_time` datetime            not null default current_timestamp comment '创建时间',
    `update_time` datetime            not null default current_timestamp on update current_timestamp comment '更新时间',
    `deleted`     bit(1)              not null default b'0' comment '是否已删除：0=否，1=是'
) engine = InnoDB
    auto_increment = 1
    character set = utf8mb4
    collate = utf8mb4_general_ci
    row_format = dynamic comment ='表名';
```

## 6. 组件使用规范

本地开发时, 默认使用 **配置文件**, 避免频繁打开 Nacos 修改配置, 但是这种方式无法实现配置动态刷新的功能, 非本地开发时默认走 **配置中心**, 部署包中的配置文件会被忽略, 避免直接在服务器上修改配置文件, 且能够实现配置动态刷新的功能.

如果需要在本地开发时从配置中心读取配置, 可在 `bootstrap.yml` 显式配置 `fkh.nacos.enable-nacos-config=true` 实现.

配置文件我们分为 **主配置** 和 **环境配置**, 打包时会包含所有配置文件, 这样可以实现在任何环境部署而不需要重新打包.

### 6.1 配置类

1. 每个可部署的应用 **必须** 包含 **ApplicationConfiguration.java** 和 **ApplicationProperties.java** 类, 固定写法如下:

   ```java
   @Configuration
   @EnableConfigurationProperties(ApplicationProperties.class)
   public class ApplicationConfiguration {
   }

   @Data
   @ConfigurationProperties(prefix = ApplicationProperties.PREFIX)
   public class ApplicationProperties {
       static final String PREFIX = "zeka.{项目名}";
   }
   ```

   **ApplicationConfiguration.java** 用于实现应用级的自动装配, **ApplicationProperties.java** 则是应用的配置类, 每个应用都应该有一个 **唯一** 的配置前缀, 所有应用配置都应该在此分类下, [了解 ConfigurationProperties](../config/README.md)

2. 配置类中的配置字段 **必须** 将作用, 注意事项写清楚, 方便在写配置时进行提示;
3. **不允许** 直接使用 **@Value** 注解读取配置, **必须** 使用配置类获取配置;
4. Spring Cloud 应用必须有 **bootstrap.yml** 配置;
5. Spring Boot 应用必须有 **application.yml** 配置;
6. **新增/修改/删除 配置, 请同步更新环境配置文件和 Nacos 上的配置**, 线上更新部署时的部署文档需要给出 **配置更新说明**;

### 6.2 application.yml

application.yml 配置文件可以理解为 **配置模板**, 其他环境的配置只是为了在特定的环境下覆盖 **配置模板** 中的配置, 这样可以减少大量的重复配置.比如 IoT center 项目的配置如下:

<br/>
<details><summary><B><I style="cursor:pointer; color: #0e5870">🎉 application.yml</I></B></summary>

```yaml
server:
  port: 18104
dubbo:
  protocol:
    port: 28033
  cloud:
    subscribed-services: zeka-center-third

jetcache:
  hidePackages: com.zeka.center.iot
  remote:
    default:
      type: redis.lettuce
      uri: redis://zeka140620@redis.server:6379
zeka:
  iot:
    mqtt:
      host: tcp://mqtt.server:1883
      clientId: zeka_iot_collector_${random.int}
      username: admin
      password: public
  agent:
    endpoint:
      enable-fail-fast: true
      enable-sign-check: false
    enable-container-log: true
  mongo:
    enable-auto-create-index: true
    enable-save-class-name: true
    datasource:
      default: mongodb://zeka:zeka140620@mongo.server:27017/iot_${spring.profiles.active}
      gps: mongodb://obd:zeka%40zol4@192.168.2.57:12131,192.168.2.57:12132,192.168.2.57:12133/test_obd_new
  logging:
    level:
      project: debug
      root: info
  mybatis:
    enable-log: true

mybatis-plus:
  mapper-locations: classpath*:/mapper/mysql/*.xml

spring:
  datasource:
    url: jdbc:mysql://mysql.server:3306/zeka_iot_${spring.profiles.active}?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=Asia/Shanghai&useAffectedRows=true
    username: zeka
    password: zeka140620
```
</details>

<br/>
<details><summary><B><I style="cursor:pointer; color: #0e5870">🎉 application-local.yml</I></B></summary>

```yaml
zeka:
  mongo:
    datasource:
      default: mongodb://zeka:zeka140620@mongo.server:27017/iot_dev
  agent:
    endpoint:
      enable-expand-ids-check: off

# 本地开发时, mysql 使用 dev 库
spring:
  datasource:
    url: jdbc:mysql://mysql.server:3306/zeka_iot_dev?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=Asia/Shanghai&useAffectedRows=true
```
</details>

<br/>
<details><summary><B><I style="cursor:pointer; color: #0e5870">🎉 application-dev.yml</I></B></summary>

```yaml
# 不需要任何配置, 因为主配置中已全部配置
```
</details>

<br/>
<details><summary><B><I style="cursor:pointer; color: #0e5870">🎉 application-test.yml</I></B></summary>

```yaml
jetcache:
  remote:
    default:
      uri: redis://zeka140620@redis.server:6380
```
</details>

<br/>
<details><summary><B><I style="cursor:pointer; color: #0e5870">🎉 application-prev.yml</I></B></summary>

```yaml
jetcache:
  remote:
    default:
      uri: redis://zeka140620@redis.server:6381
```
</details>

1. 配置文件 **必须** 全部使用 **yml** 格式;
2. 所有配置 **必须** 全部写在主配置文件中, 其中环境参数需要使用 `${spring.profiles.active}`;
3. 当前应用级配置 **必须** 在 **zeka.{项目名}** 分组下;
4. 配置的 key **必须** 使用 **中横线** 分隔单词, **不允许** 驼峰或其他命名方式;
5. 配置文件中的每个 key 都应该可以点击条状到特定的配置类(可能需要先编译项目), 否则请删除并写入到配置类中;

### 6.3 bootstrap.yml

1. 什么使用应该配置 spring.application.name: 比如 `zeka-center-iot-agent` 是模块名, 为了简便我们可以修改部署包名为: `zeka-center-iot`, 此时需要在 pom.xml 中配置 `<package`.name>` 标签, 这种情况下需要显式的在主配置中配置 `spring.application.name`:

   ```yaml
   spring:
     application:
     	# 可以使用占位符, maven 编译后会使用 pom 的属性自动替换
       name: ${package.name}
   zeka:
     app:
       config-group: C_IOT
   ```

2. `未显式设置 application name 或者未正确解析 ${package.name} (可能需要重新编译项目), 读取当前模块名作为应用名: [`zeka-center-iot-agent]`

## 7. Nacos

1. dataId **必须** 使用 yml 后缀;
2. 一个应用必须添加 **主配置** 和 **环境配置**;
3. Group 规则:
   1. Center 层项目使用 **C_{项目名}**  方式命名;
   2. Mservice 层项目使用 **M_{项目名}** 方式命名;
   3. 应用层项目使用 **P_{项目名}** 方式命名;

## 8. Maven

### 8.1 依赖管理

1. 业务系统父 pom **必须** 继承于 `zeka-company-parent`;
2. 业务系统不能在 pom 中定义框架组件依赖版本，所有组件版本由框架控制;
3. 如果是多模块项目, 业务系统所使用的依赖版本 **必须** 全部定义在父 pom 的 properties 节点中;
4. 如果是多模块项目, 所有的第三方依赖 **必须** 全部定义到 父 pom 的 dependencyManagement 节点中, 即子模块中的依赖 **不允许** 出现 **version** ;
5. 如果是多模块项目, 父 pom 统一使用 **revision** 定义项目版本号, 子模块 **必须** 在 **parent** 节点中使用 `<version>${revision}</version>`;
6. 公司级项目 **禁止** 在任何 pom 中重新定义 **groupId**, **禁止** 在子模块中定义 **version**;
7. **禁止** 非部署模块定义 **package.name**;
8. 依赖根据最小使用原则, 在哪层使用就添加到哪层, **禁止** 全部添加到最底层的模块, 比如 common;
9. 请合理使用 **scope** 控制依赖传递;
10. **禁止** 随意添加第三方依赖, 第三方依赖应该由项目经理负责添加, 在无法确认的情况下请联系 **基础架构与数据部** 参与添加;
11. **禁止** 使用 `<scope>system</scope>`, 第三方依赖如果没有 maven 地址, 需要上传到公司私服;
12. **一般** 不需要在 pom 中添加任何 maven plugin, 如果存在特殊需求, 请联系 **基础架构与数据部** 参与添加;

### 8.1 相关命令

```
mvn clean package -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true
mvn clean deploy -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true
mvn clean install -Djar.repackage.skip=false -Dmakeself.skip=false
mvn clean compile -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=tru
mvn clean install -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true
mvn clean package -U -Dpackage.env.prod=true -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true
mvn clean package -U -Dpackage.env.prod=true -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dmakeself.skip=false
mvn clean package -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpublish.switch=true
mvn clean package -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpublish.switch=true -Dapm.enable=true
mvn clean deploy -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpublish.switch=true
mvn clean deploy -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpublish.switch=true -Dapm.enable=true
mvn clean deploy -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpublish.switch=true -Dapm.enable=true -Dpublish.env=prev
mvn clean deploy -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpublish.switch=true -Dapm.enable=true -Dpublish.env=test
mvn clean package -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpackage.env.prod=true
mvn clean package -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dapm.enable=true -Dpublish.switch=true
mvn clean deploy -DskipTests -Dcheckstyle.skip=true -Dpmd.skip=true -Dpublish.switch=true -Dapm.enable=true -Dpublish.env=dev
```

::: tip

以上命令中的 -DskipTests -Dcheckstyle.skip=true **只能** 在特殊情况下使用, **禁止** 在开发中使用, 请在每次提交之前编译代码, 看是否能通过代码检查. **项目经理** 因应该在部署时严格检查代码是否全部通过检查, 遇到紧急上线等特殊情况, 才可考虑忽略代码检查.

:::

## 9. 日志规范

1. 修改（包括新增）操作 **必须** 打印日志;
2. 条件分支 **必须** 打印条件值, 重要参数必须打印;
3. 数据量大的时候需要打印数据量;
4. **不允许** 使用 System print(包括 System.out.println 和 System.error.println) 记录日志;
5. **不允许** 使用 `printStackTrace()`;
6. 统一使用 **@Slf4j** 获取 log, 日志对象名统一使用 **log**;
7. **不允许**记录日志后又抛出异常;
8. **不在循环中打印日志**;
9. **绝对不允许** 业务日志全部使用 **log.error** 输出日志;
10. 请合理使用 **log.debug** 和 **log.info**, 不要全部使用 info, 也不要全部使用 debug;

## 10. Git 分支规范

我们推荐使用 **Git Flow** 来管理分支，可以先看看 [Git Flow 的正确使用姿势](https://www.jianshu.com/p/41910dc6ef29) 了解一下什么是 GitFlow，IDEA 也可使用 **GitFlowPlus** 插件来简化操作。

1. 必须存在 master 分支, 且作为受保护的分支，不能直接提交代码, 只能使用 merge 的方式合并其他分支代码;
2. 必须存在 develop 分支, 不能直接将代码提交到此分支, 只能使用 merge 的方式合并其他分支代码, 所有新功能基于此分支拉取;
3. 所有新功能分支 **必须** 使用 `feature/x.x.x` 命名, 此分支功能开发完成或上线后, 负责人需要合并到 develop 和 master 分支, 分支上线后不能再对此分支做任何修改, 如果需要修改 bug
4. 新功能起始版本 **必须** 从 1.0.0 开始;

## 11. 测试

### 11. 1测试计划

通常测试计划的范围包括以下几点：

1. 描述测试的各个阶段（例如，单元测试、集成测试或系统测试），并说明本计划所针对的测试类型（如功能测试或性能测试）。
2. 简要地列出测试对象中将接受测试或将不接受测试的那些性能和功能。
3. 如果在编写此文档的过程中做出的某些假设可能会影响测试设计、开发或实施，则列出所有这些假设。
4. 列出可能会影响测试设计、开发或实施的所有风险或意外事件。
5. 列出可能会影响测试设计、开发或实施的所有约束。
6. 规划测试进度，分配测试任务至个人

### 11.2 测试设计

测试计划制定完成后，即开始进行测试设计，内容包括：

1. 测试场景设计，针对不同的模块、不同功能、各业务流程和逻辑分支，分别进行测试场景设计。相同的功能在不同的模块，可以参考已有的测试场景进行设计
2. 测试用例设计，新模块测试用例按照测试用例模板进行编写；已有模块更新或优化需要更新原有case
3. 用例评审

完在测试用例设计之后为了保证测试用例的覆盖率，需要对测试用例进行评审，评审可以是交叉review或开会讨论的形式，主要从以下几方面进行评审

1. 测试用例是否覆盖了所有需求
2. 测试用例内容是否正确，是否与需求目标一致
3. 测试用例内容是否完整，是否清楚包含输入和预期输出结果
4. 测试用例是否具有指导性，是否能灵活指导测试人员通过用例发现更多缺陷,而不是限制他们的思维
5. 找出哪些需求不可测：无法准备环境、可测试性达不到等等原因
6. 对具体需求的实现结果的确认（设计人员、开发人员、测试人员的认识是否一致，如果不一致，谁说了算）
7. 测试用例本身的描述是否清晰，是否存在二义性
8. 是否考虑到测试用例的执行效率。往往测试用例中步骤不断重复执行，验证点却不同，而且测试设计的冗余性，都造成了效率的低下

### 11.3 Bug 提交和缺陷跟踪

1. 确认该bug是否复现以及复现的步骤
2. Bug库中是否已存在同一问题描述的bug
3. 确认该问题是否为真正的bug，比如不满足产品需求、影响产品使用等等
4. 思考该问题是否还在其他场景下复现

提交bug时，各个参数根据bug规范进行填写，概要要简单明了，复现步骤要清晰直接，另外，必要时提供相关测试数据和文字说明，上传图片或附件，以便更加直观的说明问题。发现产品缺陷时，测试人员要对软件缺陷进行分类，以简明扼要的方式指出其影响，以及修改的优先次序~

### 11.4 回归测试的测试范围

回归测试是指修改了旧代码后，重新进行测试以确认修改没有引入新的错误或导致其他代码产生错误。通常有下列几种方法来确定回归测试范围：

1. 测试全部用例。这种方法比较安全，但往往带来很大的工作量。
2. 基于风险选择测试，先运行最重要的、关键的和可疑的测试，而跳过那些非关键的、优先级别低的或者高稳定的测试，测试过程从主要特征到次要特征。
3. 基于操作剖面选择测试，可以优先选择那些针对最重要或最频繁使用功能的测试用例，释放和缓解最高级别的风险，有助于尽早发现那些对可靠性有最大影响的故障。

再测试修改的部分。测试者可以通过相依性分析识别软件的修改情况并分析修改的影响，将回归测试局限于被改变的模块和它的接口上，使回归测试尽可能覆盖受到影响的部分。

### 11.5 内部沟通

测试人员除了需要注重与产品人员和开发直接的沟通，团队各成员之间沟通也应高效及时，避免测试人员之间测试结果互相影响、重复测试、重复与开发沟通确认浪费开发时间等，从而提高测试工作的效率。因此，要求测试人员做到以下几点：

1. 测试前期，沟通结果实时共享
2. 测试过程中，以更高的实时性进行沟通，特别是和产品和开发沟通结果会对其他测试人员工作产生影响的情况，有助于团队其他人员的工作，提高团队协作能力，和产品和开发沟通的结果，及时以文档形式记录下来并进行内部沟通。

## 12. 代码审查规范

代码审查是保证代码质量的重要环节，通过同行评审可以发现潜在问题，提高代码可维护性和团队协作效率。

### 12.1 审查原则

1. **必须** 对所有代码变更进行审查，包括功能代码、测试代码、配置文件等
2. **必须** 至少有一名经验丰富的开发者参与审查
3. **必须** 在合并到主分支前完成审查
4. **推荐** 使用 Pull Request 或 Merge Request 进行代码审查

### 12.2 审查内容

#### 12.2.1 功能正确性
- 代码是否实现了预期功能
- 边界条件处理是否完善
- 异常情况处理是否合理
- 业务逻辑是否正确

#### 12.2.2 代码质量
- 代码是否符合项目编码规范
- 变量和方法命名是否清晰
- 代码结构是否合理
- 是否有重复代码
- 注释是否充分且准确

#### 12.2.3 性能考虑
- 是否存在性能瓶颈
- 数据库查询是否优化
- 缓存使用是否合理
- 内存使用是否高效

#### 12.2.4 安全性
- 是否存在安全漏洞
- 输入验证是否充分
- 权限控制是否正确
- 敏感信息是否泄露

### 12.3 审查流程

1. **提交前自检**: 开发者提交代码前必须进行自检
2. **创建审查请求**: 通过 Git 平台创建 Pull Request
3. **分配审查者**: 指定合适的审查者
4. **审查反馈**: 审查者提出修改建议
5. **修改完善**: 开发者根据反馈修改代码
6. **再次审查**: 修改后的代码需要再次审查
7. **合并代码**: 审查通过后合并到目标分支

### 12.4 审查标准

#### 12.4.1 必须修改的问题
- 功能错误或逻辑错误
- 安全漏洞
- 性能问题
- 代码规范严重违反

#### 12.4.2 建议修改的问题
- 代码可读性改进
- 代码结构优化
- 注释完善
- 命名优化

#### 12.4.3 审查通过标准
- 所有必须修改的问题已解决
- 至少一名审查者同意
- 代码编译通过
- 测试用例通过

## 13. 性能规范

### 13.1 性能目标

1. **响应时间**: API 接口响应时间应控制在 200ms 以内
2. **吞吐量**: 系统应能支持预期的并发用户数
3. **资源使用**: CPU 使用率不超过 70%，内存使用率不超过 80%
4. **数据库**: 单次查询时间不超过 100ms

### 13.2 性能优化原则

#### 13.2.1 数据库优化
- **必须** 为经常查询的字段添加索引
- **必须** 避免 N+1 查询问题
- **推荐** 使用分页查询避免大量数据加载
- **推荐** 合理使用缓存减少数据库访问

#### 13.2.2 代码优化
- **必须** 避免在循环中进行数据库操作
- **必须** 合理使用缓存机制
- **推荐** 使用异步处理耗时操作
- **推荐** 优化算法复杂度

#### 13.2.3 资源管理
- **必须** 及时释放资源（连接、文件等）
- **必须** 避免内存泄漏
- **推荐** 使用连接池管理数据库连接
- **推荐** 合理设置 JVM 参数

### 13.3 性能监控

1. **必须** 添加关键业务指标监控
2. **必须** 监控系统资源使用情况
3. **推荐** 使用 APM 工具进行性能分析
4. **推荐** 设置性能告警机制

## 14. 安全规范

### 14.1 数据安全

#### 14.1.1 敏感数据处理
- **必须** 对敏感数据进行加密存储
- **必须** 使用 HTTPS 传输敏感数据
- **必须** 不在日志中输出敏感信息
- **推荐** 使用环境变量管理敏感配置

#### 14.1.2 输入验证
- **必须** 对所有用户输入进行验证
- **必须** 防止 SQL 注入攻击
- **必须** 防止 XSS 攻击
- **推荐** 使用参数化查询

### 14.2 访问控制

#### 14.2.1 身份认证
- **必须** 实现用户身份认证
- **必须** 使用安全的密码策略
- **推荐** 支持多因素认证
- **推荐** 实现单点登录

#### 14.2.2 权限控制
- **必须** 实现基于角色的访问控制
- **必须** 验证用户操作权限
- **推荐** 实现细粒度权限控制
- **推荐** 记录用户操作日志

### 14.3 系统安全

#### 14.3.1 网络安全
- **必须** 使用防火墙保护系统
- **必须** 定期更新系统补丁
- **推荐** 使用 VPN 访问内网资源
- **推荐** 实现网络隔离

#### 14.3.2 应用安全
- **必须** 定期进行安全扫描
- **必须** 使用安全的第三方库
- **推荐** 实现安全审计功能
- **推荐** 建立安全事件响应机制

## 15. 文档规范

### 15.1 代码文档

#### 15.1.1 类注释
- **必须** 为所有公共类添加类注释
- **必须** 包含类的作用、作者、创建时间等信息
- **推荐** 包含使用示例
- **推荐** 包含注意事项

#### 15.1.2 方法注释
- **必须** 为所有公共方法添加方法注释
- **必须** 包含参数说明、返回值说明
- **推荐** 包含异常说明
- **推荐** 包含使用示例

### 15.2 项目文档

#### 15.2.1 README 文档
- **必须** 包含项目简介
- **必须** 包含安装和运行说明
- **必须** 包含配置说明
- **推荐** 包含常见问题解答

#### 15.2.2 API 文档
- **必须** 使用 Swagger 生成 API 文档
- **必须** 包含接口描述、参数说明、响应示例
- **推荐** 包含错误码说明
- **推荐** 包含接口变更历史

### 15.3 技术文档

#### 15.3.1 设计文档
- **必须** 包含系统架构设计
- **必须** 包含数据库设计
- **推荐** 包含接口设计
- **推荐** 包含部署架构

#### 15.3.2 运维文档
- **必须** 包含部署说明
- **必须** 包含监控配置
- **推荐** 包含故障排查指南
- **推荐** 包含性能调优指南

## 16. 总结

### 16.1 规范的重要性

遵循统一的开发规范对于团队协作和项目维护具有重要意义：

1. **提高代码质量**: 统一的编码风格和规范有助于减少 bug，提高代码可读性
2. **提升开发效率**: 规范化的开发流程和工具使用能够显著提高开发效率
3. **降低维护成本**: 清晰的代码结构和完善的文档能够降低后期维护成本
4. **促进团队协作**: 统一的规范有助于团队成员之间的协作和知识传递

### 16.2 规范执行

#### 16.2.1 执行原则
- **强制执行**: 所有规范中的"必须"条款必须严格执行
- **持续改进**: 规范应该根据项目发展和团队反馈持续改进
- **工具支持**: 尽可能使用工具自动化检查规范执行情况
- **培训教育**: 定期组织规范培训和经验分享

#### 16.2.2 检查机制
- **代码审查**: 通过代码审查确保规范执行
- **自动化检查**: 使用 Maven 插件和 IDE 插件自动检查
- **定期审计**: 定期进行代码质量审计
- **持续监控**: 通过监控工具持续监控系统质量

### 16.3 规范更新

本文档会根据以下情况进行更新：

1. **技术发展**: 随着技术栈的更新和升级
2. **项目需求**: 根据具体项目的特殊需求
3. **团队反馈**: 根据团队使用过程中的反馈和建议
4. **最佳实践**: 根据行业最佳实践的发展

### 16.4 联系方式

如有任何问题或建议，请联系：

- **项目维护者**: dong4j
- **文档版本**: v2.0.0
- **最后更新**: 2024年12月
- **更新频率**: 根据项目需要不定期更新

---

**注意**: 本文档是 Zeka Stack 项目的核心开发规范，所有团队成员都应该仔细阅读并严格遵守。规范的执行情况将作为代码审查和项目评估的重要依据。
