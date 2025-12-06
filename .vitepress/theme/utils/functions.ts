import {EXTERNAL_SERVICES} from '../config/constants'

const pattern
    = /[a-zA-Z0-9_\u0392-\u03C9\u00C0-\u00FF\u0600-\u06FF\u0400-\u04FF]+|[\u4E00-\u9FFF\u3400-\u4DBF\uF900-\uFAFF\u3040-\u309F\uAC00-\uD7AF]+/g

export function countWord(data: string) {
    const m = data.match(pattern)
    let count = 0
    if (!m) {
        return 0
    }
    for (let i = 0; i < m.length; i += 1) {
        if (m[i].charCodeAt(0) >= 0x4E00) {
            count += m[i].length
        } else {
            count += 1
        }
    }
    return count
}

/**
 * Busuanzi 统计数据接口
 */
export interface BusuanziData {
    page_pv?: number
    site_uv?: number
    site_pv?: number
}

/**
 * 获取 Busuanzi 统计数据
 * @param options 配置选项
 * @param options.updatePagePv 是否更新页面浏览量
 * @param options.updateSiteStats 是否更新站点统计（UV 和 PV）
 * @returns Promise<BusuanziData | null>
 */
export function fetchBusuanzi(options: {
    updatePagePv?: boolean
    updateSiteStats?: boolean
} = {}): Promise<BusuanziData | null> {
    const {updatePagePv = true, updateSiteStats = false} = options

    return new Promise((resolve) => {
        if (typeof window === 'undefined') {
            resolve(null)
            return
        }

        try {
            const api = EXTERNAL_SERVICES.busuanzi.apiUrl
            const xhr = new XMLHttpRequest()
            xhr.open('POST', api, true)

            // 获取存储的 identity
            const identity = localStorage.getItem('bsz-id')
            if (identity) {
                xhr.setRequestHeader('Authorization', 'Bearer ' + identity)
            }

            xhr.setRequestHeader('x-bsz-referer', window.location.href)
            xhr.setRequestHeader('Content-Type', 'application/json')

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    try {
                        const data = JSON.parse(xhr.responseText)
                        if (data.success && data.data) {
                            const result: BusuanziData = {}

                            // 更新页面浏览量
                            if (updatePagePv) {
                                const pagePv = data.data.page_pv
                                if (pagePv !== undefined) {
                                    result.page_pv = pagePv
                                    const pvElement = document.getElementById('busuanzi_page_pv')
                                    if (pvElement) {
                                        pvElement.textContent = pagePv.toString()
                                    }
                                }
                            }

                            // 更新站点统计
                            if (updateSiteStats) {
                                const siteUv = data.data.site_uv
                                const sitePv = data.data.site_pv
                                if (siteUv !== undefined) {
                                    result.site_uv = siteUv
                                    const uvElement = document.getElementById('busuanzi_site_uv')
                                    if (uvElement) {
                                        uvElement.textContent = siteUv.toString()
                                    }
                                }
                                if (sitePv !== undefined) {
                                    result.site_pv = sitePv
                                    const sitePvElement = document.getElementById('busuanzi_site_pv')
                                    if (sitePvElement) {
                                        sitePvElement.textContent = sitePv.toString()
                                    }
                                }
                            }

                            // 保存 identity
                            const newIdentity = xhr.getResponseHeader('Set-Bsz-Identity')
                            if (newIdentity && newIdentity !== '') {
                                localStorage.setItem('bsz-id', newIdentity)
                            }

                            resolve(result)
                        } else {
                            resolve(null)
                        }
                    } catch (error) {
                        console.warn('Error parsing busuanzi response:', error)
                        resolve(null)
                    }
                } else if (xhr.readyState === 4) {
                    // 请求失败
                    resolve(null)
                }
            }

            xhr.onerror = () => {
                console.warn('Error fetching busuanzi:', xhr.statusText)
                resolve(null)
            }

            xhr.send()
        } catch (error) {
            console.warn('Error fetching busuanzi:', error)
            resolve(null)
        }
    })
}
