import {onBeforeUnmount, onMounted, ref} from 'vue'
import {inBrowser} from 'vitepress'
import {EXTERNAL_SERVICES} from '../config/constants'

/**
 * 在线人数状态(单例)
 */
const onlineCount = ref(0)
let intervalId: number | null = null
let instanceCount = 0

/**
 * 获取在线人数
 */
const fetchOnlineCount = async () => {
    if (!inBrowser) return

    try {
        const {apiUrl, room} = EXTERNAL_SERVICES.onlineCounter
        const response = await fetch(`${apiUrl}?room=${room}`, {
            method: 'GET',
        })

        if (response.ok) {
            const data = await response.json()
            if (data.success && data.data && data.data.online_user !== undefined) {
                onlineCount.value = data.data.online_user
            }
        }
    } catch (error) {
        console.warn('Error fetching online count:', error)
    }
}

/**
 * 启动定时器
 */
const startPolling = () => {
    if (intervalId !== null) return // 已经在运行

    // 初始获取
    fetchOnlineCount()

    // 定时更新
    intervalId = window.setInterval(() => {
        fetchOnlineCount()
    }, EXTERNAL_SERVICES.onlineCounter.updateInterval)
}

/**
 * 停止定时器
 */
const stopPolling = () => {
    if (intervalId !== null) {
        clearInterval(intervalId)
        intervalId = null
    }
}

/**
 * 在线计数器 Composable
 * 使用单例模式,确保只有一个定时器在运行
 */
export function useOnlineCounter() {
    onMounted(() => {
        if (!inBrowser) return

        instanceCount++

        // 第一个实例启动定时器
        if (instanceCount === 1) {
            startPolling()
        }
    })

    onBeforeUnmount(() => {
        if (!inBrowser) return

        instanceCount--

        // 最后一个实例卸载时停止定时器
        if (instanceCount === 0) {
            stopPolling()
        }
    })

    return {
        onlineCount,
        refresh: fetchOnlineCount
    }
}
