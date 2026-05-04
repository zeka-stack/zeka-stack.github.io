<claude-mem-context>
# Memory Context

# [zeka-stack.github.io] recent context, 2026-05-04 8:03pm GMT+8

No previous sessions found.
</claude-mem-context>

# AGENTS.md

## 基本约定

- 始终使用中文回复。
- 本仓库是 Zeka Stack 的 VitePress 文档站点。
- 修改前先检查当前工作区状态，不要覆盖用户已有改动。
- 默认使用 ASCII 编辑文件；文档内容本身需要中文时可以使用中文。

## 常用命令

```bash
pnpm install
pnpm run dev
pnpm run build
pnpm run preview
pnpm run sync
```

`package.json` 同时提供了 npm 脚本；仓库中存在 `pnpm-lock.yaml` 和 `package-lock.json`，优先遵循用户当前使用的包管理器。未明确时，优先使用 `pnpm`。

## 项目结构

- `.vitepress/config.js`：VitePress 配置和侧边栏生成逻辑。
- `.vitepress/theme/`：自定义主题、样式和组件。
- `guide/`、`about/`、`action/`：站点独有文档，直接在本仓库维护。
- `sync-docs.sh`：从上级源码仓库同步模块文档。
- `docs-sync-guide.md`：文档同步和目录组织说明。
- `docs-authoring-best-practices.md`：文档写作规范。

## 文档维护规则

- 模块文档通常来源于源码模块的 `README.md` 和 `docs/` 目录，通过 `pnpm run sync` 同步到本站点。
- 站点独有文档直接维护本仓库中的 `guide/`、`about/`、`action/` 等目录。
- 不要手动修改同步产物，除非用户明确要求；优先修改源码文档后重新同步。
- 每个 Markdown 页面应有且仅有一个一级标题，一级标题会作为菜单文本。
- 编号文件名用于控制菜单顺序，例如 `1.introduction.md`、`2.quick-start.md`。
- 双向链接使用站点最终路径；目录主页要写到 `/index`，例如 `[[cubo-starter/example/index|示例]]`。
- 图片资源优先使用 WebP，放在对应目录的 `imgs/` 下。

## 验证建议

- 修改配置、主题或链接后，至少运行 `pnpm run build`。
- 新增或调整文档菜单、双向链接时，优先用 `pnpm run dev` 本地检查页面和控制台警告。
- 同步模块文档后，关注 `sync-docs.sh` 生成的 frontmatter、徽标和代码链接是否符合预期。
