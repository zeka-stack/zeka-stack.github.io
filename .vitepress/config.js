import { defineConfig } from 'vitepress'
import fs from 'fs'
import path from 'path'
import { fileURLToPath } from 'url'
import dayjs from 'dayjs'
import { InlineLinkPreviewElementTransform } from '@nolebase/vitepress-plugin-inline-link-preview/markdown-it'
import { GitChangelog, GitChangelogMarkdownSection, } from '@nolebase/vitepress-plugin-git-changelog/vite'
import { BiDirectionalLinks } from '@nolebase/markdown-it-bi-directional-links'
import timeline from "vitepress-markdown-timeline";
import { groupIconMdPlugin, groupIconVitePlugin } from 'vitepress-plugin-group-icons'
import { vitepressPluginLegend } from 'vitepress-plugin-legend'
import llmstxt from 'vitepress-plugin-llms'
import { copyOrDownloadAsMarkdownButtons } from 'vitepress-plugin-llms'
import { EXTERNAL_SERVICES, GITHUB_CONFIG } from './theme/config/constants.ts'
import difyPlugin from 'vitepress-plugin-dify';

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const docsDir = path.resolve(__dirname, '..')

/**
 * 获取模块的显示名称
 */
function getModuleDisplayName(modulePath) {
    const indexPath = path.join(modulePath, 'index.md')
    if (fs.existsSync(indexPath)) {
        const content = fs.readFileSync(indexPath, 'utf-8')
        const match = content.match(/^#\s+(.+)$/m)
        if (match) {
            return match[1].trim()
        }
    }
    return path.basename(modulePath)
}

/**
 * 获取模块 docs 目录下的额外文档
 * @param {string} modulePath - docs 目录中的模块路径
 * @param {string} relativePath - 相对 docs 的路径（用于生成链接）
 */
function getModuleDocItems(modulePath, relativePath) {
    const items = []

    if (!fs.existsSync(modulePath)) {
        return items
    }

    const files = fs.readdirSync(modulePath, { withFileTypes: true })
    for (const file of files) {
        if (!file.isFile() || !file.name.endsWith('.md') || file.name === 'index.md') {
            continue
        }

        const docPath = path.join(modulePath, file.name)
        const title = getDocumentTitle(docPath)
        if (!title) {
            continue
        }

        const link = `/${relativePath}/${file.name.replace(/\.md$/, '')}`

        // 解析文件名前缀用于排序，如 1.introduction.md -> sortKey: 1
        const match = file.name.match(/^(\d+)\.(.+)\.md$/)
        let sortKey = 9999 // 默认无编号文件排到最后
        if (match) {
            sortKey = parseInt(match[1])
        }

        items.push({
            text: title,
            link: link,
            sortKey: sortKey
        })
    }

    // 按 sortKey 排序，如果相同则按文件名排序
    items.sort((a, b) => {
        if (a.sortKey !== b.sortKey) {
            return a.sortKey - b.sortKey
        }
        return a.text.localeCompare(b.text, 'zh-CN')
    })

    return items.map(item => (
        {
            text: item.text,
            link: item.link
        }))
}

/**
 * 递归查找所有模块（从 docs 目录）
 * @param {string} dir - 要搜索的目录
 * @param {string} basePath - 基础路径（用于生成链接）
 * @param {string[]} skipDirs - 要跳过的目录名列表
 */
function findModules(dir, basePath = '', skipDirs = []) {
    const modules = []

    if (!fs.existsSync(dir)) {
        return modules
    }

    const items = fs.readdirSync(dir, { withFileTypes: true })

    for (const item of items) {
        // 跳过隐藏文件和特殊目录
        if (item.name.startsWith('.') ||
            item.name === 'node_modules' ||
            item.name === '.vitepress' ||
            item.name === 'guide' ||
            item.name === 'about' ||
            item.name === 'action' ||
            skipDirs.includes(item.name)) {
            continue
        }

        if (item.isDirectory()) {
            // 跳过特殊目录
            if (['src', 'target', 'docs', 'imgs', 'templates'].includes(item.name)) {
                continue
            }

            const modulePath = path.join(dir, item.name)
            const relativePath = basePath ? `${basePath}/${item.name}` : item.name
            const indexPath = path.join(modulePath, 'index.md')

            if (fs.existsSync(indexPath)) {
                const displayName = getModuleDisplayName(modulePath)
                const link = `/${relativePath}/`

                const moduleInfo = {
                    text: displayName,
                    link: link
                }

                // 递归查找子模块（传递 skipDirs 以跳过特殊目录）
                const subModules = findModules(modulePath, relativePath, skipDirs)
                const docItems = getModuleDocItems(modulePath, relativePath)

                if (subModules.length > 0 || docItems.length > 0) {
                    moduleInfo.items = []
                    if (subModules.length > 0) {
                        moduleInfo.items.push(...subModules)
                    }
                    if (docItems.length > 0) {
                        moduleInfo.items.push(...docItems)
                    }
                    // 如果有子项，添加折叠功能
                    moduleInfo.collapsed = true
                }

                modules.push(moduleInfo)
            } else {
                // 即使没有 index.md，也继续查找子模块
                const subModules = findModules(modulePath, relativePath, skipDirs)
                modules.push(...subModules)
            }
        }
    }

    // 按模块名称排序（中文排序）
    return modules.sort((a, b) => {
        return a.text.localeCompare(b.text, 'zh-CN')
    })
}

/**
 * 目标目录配置
 * key: 分类显示名称
 * value: 目录名称（docs 目录下的目录名）
 */
const TARGET_DIRS = {
    'Arco Meta': 'arco-meta',
    'Blen Kernel': 'blen-kernel',
    'Cubo Starter': 'cubo-starter',
    'Cubo Examples': 'cubo-starter-examples'
}

/**
 * 获取分类顺序数组（用于菜单显示顺序）
 * @returns {Array<string>} 分类名称数组
 */
function getCategoryOrder() {
    return Object.keys(TARGET_DIRS)
}

/**
 * 根据模块路径获取分类名称
 * @param {string} link - 模块链接路径
 * @returns {string|null} 分类名称，如果不匹配则返回 null
 */
function getCategoryByModulePath(link) {
    for (const [categoryName, dirName] of Object.entries(TARGET_DIRS)) {
        if (link.startsWith(`/${dirName}/`) || link === `/${dirName}/`) {
            return categoryName
        }
    }
    return null
}

/**
 * 基于目录路径进行分类, 用于自动生成菜单
 */
function categorizeModules(modules) {
    const categorized = {}

    for (const module of modules) {
        const category = getCategoryByModulePath(module.link)
        if (!category) {
            continue
        }

        if (!categorized[category]) {
            categorized[category] = []
        }
        categorized[category].push(module)
    }

    return categorized
}

/**
 * 获取文档的一级标题
 */
function getDocumentTitle(filePath) {
    if (!fs.existsSync(filePath)) {
        return null
    }
    const content = fs.readFileSync(filePath, 'utf-8')
    const match = content.match(/^#\s+(.+)$/m)
    if (match) {
        return match[1].trim()
    }
    return path.basename(filePath, path.extname(filePath))
}

/**
 * 获取指定目录下的所有文档，用于生成菜单项
 * @param {string} dirName - 目录名称（如 'guide', 'about', 'action'）
 * @returns {Array} 菜单项数组
 */
function getDirectoryItems(dirName) {
    const dirPath = path.join(docsDir, dirName)
    const items = []

    if (!fs.existsSync(dirPath)) {
        return items
    }

    // 读取目录下的所有文件
    const files = fs.readdirSync(dirPath, { withFileTypes: true })

    for (const file of files) {
        // 只处理 .md 文件
        if (!file.isFile() || !file.name.endsWith('.md')) {
            continue
        }

        const filePath = path.join(dirPath, file.name)
        let link = ''
        let sortKey = 0

        if (file.name === 'index.md') {
            // index.md 作为特殊处理，链接为 /目录名/，排序为 0
            link = `/${dirName}/`
            sortKey = 0
        } else {
            // 其他文件按编号排序，如 1.introduction.md -> /目录名/1.introduction
            const match = file.name.match(/^(\d+)\.(.+)\.md$/)
            if (match) {
                const num = parseInt(match[1])
                link = `/${dirName}/${file.name.replace(/\.md$/, '')}`
                sortKey = num
            } else {
                // 如果没有编号前缀，使用文件名（去掉 .md）作为链接，排序到最后
                const baseName = file.name.replace(/\.md$/, '')
                link = `/${dirName}/${baseName}`
                sortKey = 9999 // 无编号的文件排到最后
            }
        }

        const title = getDocumentTitle(filePath)
        if (title) {
            items.push({
                text: title,
                link: link,
                sortKey: sortKey
            })
        }
    }

    // 按 sortKey 排序
    items.sort((a, b) => a.sortKey - b.sortKey)

    return items.map(item => (
        {
            text: item.text,
            link: item.link
        }))
}

/**
 * 添加目录菜单到侧边栏（辅助函数）
 * @param {Object} sidebar - 侧边栏配置对象
 * @param {string} menuText - 菜单标题（如 '简介', '关于', '实战'）
 * @param {string} dirName - 目录名称（如 'guide', 'about', 'action'）
 */
function addDirectoryMenu(sidebar, menuText, dirName) {
    const items = getDirectoryItems(dirName)
    if (items.length > 0) {
        sidebar['/'].push({
            text: menuText,
            items: items,
            collapsed: true
        })
    }
}

/**
 * 生成侧边栏配置
 * 1. 首先添加 guide 目录菜单
 * 2. 然后按分类添加各个目标目录下的模块菜单
 * 3. 最后添加"关于"和"实战"菜单
 * 后续可以参考 about 目录添加其他目录菜单, 菜单的顺序就是 addDirectoryMenu 执行的顺序,
 */
function generateSidebar() {
    const sidebar = {
        '/': []
    }

    // 单独处理 "简介" 分类
    addDirectoryMenu(sidebar, '简介', 'guide')

    // 处理目标目录，按配置的顺序生成菜单
    const categoryOrder = getCategoryOrder()

    for (const categoryName of categoryOrder) {
        const dirName = TARGET_DIRS[categoryName]
        const targetDir = path.join(docsDir, dirName)

        if (!fs.existsSync(targetDir)) {
            continue
        }

        // 查找该目录下的所有子模块
        const modules = findModules(targetDir, dirName, [])

        // 检查顶级目录本身是否有 index.md
        const topLevelIndexPath = path.join(targetDir, 'index.md')
        const items = []

        if (fs.existsSync(topLevelIndexPath)) {
            const displayName = getModuleDisplayName(targetDir)
            items.push({
                text: displayName,
                link: `/${dirName}/`
            })
        }

        // 添加子模块
        if (modules.length > 0) {
            items.push(...modules)
        }

        // 如果有内容（顶级 index.md 或子模块），则添加到侧边栏
        if (items.length > 0) {
            sidebar['/'].push({
                text: categoryName,
                items: items,
                collapsed: true
            })
        }
    }

    // 添加 "关于" 菜单
    addDirectoryMenu(sidebar, '关于', 'about')
    // 添加 "实战" 菜单
    addDirectoryMenu(sidebar, '实战', 'action')

    return sidebar
}

export default defineConfig(
    {

        vite: {
            publicDir: path.resolve(__dirname, '../public'),
            plugins: [
                groupIconVitePlugin(
                    {
                        // 自定义图标: https://github.com/vscode-icons/vscode-icons/wiki/ListOfFiles
                        customIcon: {
                            'java': 'vscode-icons:file-type-java',
                            'bash': 'vscode-icons:file-type-shell',
                            'shell': 'vscode-icons:file-type-shell',
                            'sh': 'vscode-icons:file-type-shell',
                            'xml': 'vscode-icons:file-type-xml',
                            'maven': 'vscode-icons:file-type-maven',
                            'unplugin': 'https://unplugin.unjs.io/logo_light.svg',
                        },
                    }),
                GitChangelog(
                    {
                        // Fill in your repository URL here
                        repoURL: () => GITHUB_CONFIG.url,
                    }),
                GitChangelogMarkdownSection(),
                // 生成 LLM 友好的文档
                llmstxt({
                    title: 'Zeka Stack',
                    ignoreFiles: [
                        'node_modules/**',
                        '.vitepress/**',
                        'public/**',
                        'templates/**',
                        '.git/**'
                    ]
                }),
                difyPlugin({
                    enable: true,                    // 是否启用插件
                    token: 'PKh5RI7fbi9DhXOt',        // Dify 应用令牌（必需）
                    mode: 'bubble',                 // 嵌入模式：'bubble' 或 'iframe'
                    baseUrl: 'https://dify.dong4j.site',   // Dify 服务地址（可选，默认 https://udify.app）
                    isDev: false,                     // 是否为开发环境（可选）
                    bubble: {
                        draggable: true,
                        dragAxis: 'both',
                        containerProps: {
                          style: {
                            right: '30px',
                            bottom: '30px',
                            backgroundColor: '#3e86f6',
                            width: '60px',
                            height: '60px',
                            borderRadius: '30px',
                            boxShadow: '0 4px 12px rgba(0, 0, 0, 0.15)'
                          }
                        }
                    }
                }),
            ],
            optimizeDeps: {
                exclude: [
                    '@nolebase/vitepress-plugin-enhanced-readabilities/client',
                    'vitepress',
                    '@nolebase/ui',
                ],
            },
            ssr: {
                noExternal: [
                    // If there are other packages that need to be processed by Vite, you can add them here.
                    '@nolebase/vitepress-plugin-enhanced-readabilities',
                    '@nolebase/ui',
                    '@nolebase/vitepress-plugin-highlight-targeted-heading',
                    '@nolebase/vitepress-plugin-inline-link-preview',
                    '@nolebase/vitepress-plugin-git-changelog',
                ],
            },
        },

        title: 'Zeka Stack',
        description: 'Zeka Stack - 一个现代化的 Java 微服务工程体系',
        base: '/docs/',
        lang: 'zh-CN',

        // 域名配置
        // 当前配置部署在 /docs/ 子路径

        // 忽略死链接检查（用于开发环境的 localhost 链接等）
        ignoreDeadLinks: [
            /^http:\/\/localhost/,
            /^https:\/\/localhost/
        ],

        head: [
            ['link', { rel: 'icon', href: '/favicon.ico' }],
            ['script', {
                src: EXTERNAL_SERVICES.busuanzi.scriptUrl,
                async: true,
                'data-api': EXTERNAL_SERVICES.busuanzi.apiUrl,
                'data-prefix': EXTERNAL_SERVICES.busuanzi.prefix,
                'data-style': EXTERNAL_SERVICES.busuanzi.style,
                'data-pjax': 'true'
            }],
            ['script', {
                src: EXTERNAL_SERVICES.umami.scriptUrl,
                defer: true,
                'data-host-url': EXTERNAL_SERVICES.umami.hostUrl,
                'data-website-id': EXTERNAL_SERVICES.umami.websiteId
            }]
        ],

        // markdown配置
        markdown: {
            // 开启代码行号显示
            lineNumbers: true,
            image: {
                // 开启图片懒加载
                lazyLoading: true
            },
            config(md) {
                // other markdown-it configurations...
                md.use(InlineLinkPreviewElementTransform)
                md.use(BiDirectionalLinks())
                md.use(timeline)
                md.use(copyOrDownloadAsMarkdownButtons)
                md.use(groupIconMdPlugin, {
                    titleBar: { includeSnippet: true },
                })
                vitepressPluginLegend(md, {
                    markmap: { showToolbar: true }, // 显示脑图工具栏
                    mermaid: true // 启用 Mermaid
                })
                md.renderer.rules.heading_close = (tokens, idx, options, env, slf) => {
                    let htmlResult = slf.renderToken(tokens, idx, options);
                    if (tokens[idx].tag === 'h1') {
                        htmlResult += `<ArticleMetadata />`;
                    }
                    return htmlResult;
                }
            }
        },

        themeConfig: {
            siteTitle: 'Zeka Stack',
            logo: '/logo.png',

            nav: [
                { text: '🏠 首页', link: '/' },
                { text: '🚀 开始', link: '/guide/' },
                { text: '📝 更新日志', link: '/changelog' },
                { text: '📊 统计', link: 'https://umami.dong4j.site/share/o0wIhLdP1EwFcdCt/zeka-stack.dong4j.site', target: '_blank' }
            ],

            sidebar: generateSidebar(),

            socialLinks: [
                { icon: 'github', link: GITHUB_CONFIG.url }
            ],

            footer: {
                message: '基于 VitePress 构建',
                copyright: 'Copyright © 2025 Zeka.Stack'
            },

            search: {
                provider: 'local'
            },

            editLink: {
                pattern: GITHUB_CONFIG.editUrl,
                text: '在 GitHub 上编辑此页'
            },

            lastUpdated: {
                text: '最后更新于',
                formatOptions: {
                    forceLocale: true, // 保持默认 locale 处理（可选）
                    dateStyle: 'full',
                    timeStyle: 'medium'
                },
                transform: (timestamp) => {
                    // timestamp: number | undefined
                    return dayjs(timestamp).format('YYYY-MM-DD HH:mm:ss')
                }
            },

            outline: {
                level: [2, 4],
                label: '页面大纲'
            }
        }
    })
