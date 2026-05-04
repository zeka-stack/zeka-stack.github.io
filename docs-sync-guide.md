# 文档组织说明

本文档说明 `zeka-stack.github.io` 文档站点应该如何组织内容，尤其是 `sync-docs.sh` 的同步机制、目录约定、菜单生成方式和常见注意事项。

## 1. 两类文档

站点里的文档，可以分为两类：

### 1.1 自动同步文档
- 来源于各源码模块中的 `README.md` 和 `docs/` 目录
- 通过 `sync-docs.sh` 同步到文档站点
- 通常不应该在站点仓库中手动修改这些同步产物

### 1.2 手动维护文档
- 直接放在文档站点仓库本体中
- 典型目录包括 `guide/`、`about/`、`action/`
- 这些内容不会被源码同步覆盖，可以直接维护

> 简单原则：**模块文档看源码仓，站点独有文档看站点仓。**

## 2. 当前同步范围

当前脚本默认只处理 4 个顶级目录：

- `arco-meta/`
- `blen-kernel/`
- `cubo-starter/`
- `cubo-starter-examples/`

其他目录不在自动同步范围内，需要在站点仓库中手动维护。

## 3. 模块识别规则

脚本主要通过以下条件判断一个目录是否应该被同步：

1. 是否在上述目标目录下
2. 是否存在 `pom.xml`
3. 是否存在 `README.md`
4. 是否存在子模块目录或 `docs/` 目录

因此，一个源码目录要成为站点模块页，通常至少需要：

- `pom.xml`
- `README.md`

## 4. 同步后的几种结果

根据目录结构不同，同步结果也会不同：

### 4.1 有目录结构的情况
例如：

```text
cubo-starter/cubo-logsystem-spring-boot/
├── README.md
└── docs/
    ├── 1.xxx.md
    └── 2.xxx.md
```

同步后通常会生成：

- `cubo-starter/cubo-logsystem-spring-boot/index.md`
- `cubo-starter/cubo-logsystem-spring-boot/1.xxx.md`
- `cubo-starter/cubo-logsystem-spring-boot/2.xxx.md`

### 4.2 没有子文档的情况
如果某模块只有 `README.md`，没有 `docs/`，同步后通常只会生成：

- `index.md`

### 4.3 图片资源
如果源码目录中有 `imgs/`，同步脚本也会一并处理。

## 5. 推荐的源码文档结构

如果要新增模块文档，推荐保持以下结构：

```text
模块目录/
├── README.md
├── imgs/
│   └── xxx.webp
└── docs/
    ├── 1.xxx.md
    └── 2.xxx.md
```

这样同步后既能生成主页面，也能自然形成子文档菜单。

## 6. 推荐的站点独有文档结构

站点独有内容建议统一放在站点仓库本体中，例如：

```text
zeka-stack.github.io/
├── guide/
│   ├── index.md
│   ├── 1.introduction.md
│   ├── 2.quick-start.md
│   ├── 3.resources.md
│   └── 4.docs-organization.md
├── about/
│   └── index.md
└── action/
    └── index.md
```

## 7. 文件命名建议

### 7.1 补充文档推荐使用编号前缀

例如：

- `1.introduction.md`
- `2.quick-start.md`
- `3.resources.md`

编号主要用于控制菜单顺序。

### 7.2 文件名避免特殊字符

推荐使用：

- 英文小写
- 中划线 `-` 分隔
- 结构清晰、简短明确

不推荐使用：

- 空格
- 反斜杠
- 引号
- 过长或过复杂的命名

## 8. 双向链接该怎么写

站点使用了 `@nolebase/markdown-it-bi-directional-links`，因此双向链接路径必须对应站点最终文件结构。

### 8.1 优先写站点真实结构

例如最终文件路径是：

```text
zeka-stack.github.io/arco-meta/arco-builder/index.md
```

链接就应该写：

```text
[[arco-meta/arco-builder/index|构建框架总览]]
```

### 8.2 目录型页面要加 `/index`

如果目标页面是某个目录下的 `index.md`，不要写成目录名本身，而应该写完整路径，例如：

```text
[[cubo-starter/cubo-logsystem-spring-boot/index|日志系统]]
```

### 8.3 补充文档按真实文件名写

如果目标是模块下某个补充文档，例如：

```text
[[arco-meta/arco-maven-plugin/arco-container-maven-plugin/detail-docker-build-guide|Docker 构建指南]]
```

不要使用旧别名或自己猜测的文件名。

## 9. 同步脚本会自动处理的内容

`sync-docs.sh` 除了搬文件，还会自动做以下事情：

- 为缺少 frontmatter 的文件补充 `published` 日期
- 为缺少徽标的文档补充项目徽标
- 为 README 同步后的页面补充 GitHub 代码示例链接

因此，源码 README 里不需要重复手写这些公共装饰内容。

## 10. 新增文档的推荐流程

### 10.1 新增模块文档
1. 在源码模块下补充 `README.md` 或 `docs/*.md`
2. 确保目录结构清晰
3. 执行 `npm run sync`
4. 在本地运行 `pnpm run dev`
5. 检查菜单和链接是否正确

### 10.2 新增站点独有文档
1. 在站点仓库本体目录下新增 `.md` 文件
2. 使用编号前缀控制顺序
3. 确认该目录已经在配置中进入侧边栏
4. 在本地运行 `pnpm run dev`
5. 检查菜单和链接

## 11. 常见易错点

### 11.1 源码路径不等于站点路径
源码中的相对路径，不一定就是站点最终路径。同步后很多模块页面会变成 `index.md`，层级也会发生调整。

### 11.2 目录页忘记 `/index`
当目标是一个目录的主页时，必须写成 `/index`，否则可能匹配不到真实文件。

### 11.3 用了旧文件名或旧别名
如果文件已经被重命名，链接也必须同步更新，不能继续沿用历史名称。

### 11.4 只在 GitHub 上验证
双向链接是否正常，不能只看 GitHub 仓库，还要以 `pnpm run dev` 实际结果为准。

## 12. 最终建议

- 模块文档从源码仓维护
- 补充文档优先放在模块的 `docs/` 目录下
- 双向链接始终写同步后的真实站点路径
- 新增或调整链接后，至少跑一次 `pnpm run dev` 验证
