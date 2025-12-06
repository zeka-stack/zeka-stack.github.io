/**
 * 外部服务配置
 */
export const EXTERNAL_SERVICES = {
    // 不蒜子统计服务
    busuanzi: {
        scriptUrl: 'https://cdn.dong4j.site/source/static/busuanzi.self.js',
        apiUrl: 'https://api.dong4j.site/busuanzi/api',
        prefix: 'busuanzi',
        style: 'default',
    },

    // Umami 分析服务
    umami: {
        scriptUrl: 'https://cdn.dong4j.site/source/static/umami.self.js',
        hostUrl: 'https://umami.dong4j.site',
        websiteId: '1e2e22cc-637c-49e6-aeaf-c2bd0b47f92b',
    },

    // 在线计数服务
    onlineCounter: {
        apiUrl: 'https://umami.dong4j.site/counter',
        room: 'zeka-stack',
        updateInterval: 15000,
    }
} as const

/**
 * GitHub 仓库配置
 */
export const GITHUB_CONFIG = {
    owner: 'zeka-stack',
    repo: 'zeka-stack.github.io',
    branch: 'main',
    url: 'https://github.com/zeka-stack/zeka-stack.github.io',
    get editUrl() {
        return `${this.url}/edit/${this.branch}/:path`
    },
} as const

/**
 * 统计配置
 */
export const ANALYTICS_CONFIG = {
    enableBusuanzi: true,
    enableUmami: true,
    enableOnlineCounter: true,
} as const
