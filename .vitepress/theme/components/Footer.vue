<template>
  <footer class="busuanzi-footer">
    <div class="busuanzi">
      <span class="busuanzi-item">
        <span class="busuanzi-emoji">👥</span>
        <span class="busuanzi-label">本站访客数</span>
        <span class="busuanzi-value" id="busuanzi_site_uv">--</span>
        <span class="busuanzi-unit">人次</span>
      </span>
      <span class="busuanzi-separator">·</span>
      <span class="busuanzi-item">
        <span class="busuanzi-emoji">👀</span>
        <span class="busuanzi-label">本站总访问量</span>
        <span class="busuanzi-value" id="busuanzi_site_pv">--</span>
        <span class="busuanzi-unit">次</span>
      </span>
      <span class="busuanzi-separator" v-if="onlineCount > 0">·</span>
      <span class="busuanzi-item" v-if="onlineCount > 0">
        <span class="busuanzi-emoji">🙉</span>
        <span class="busuanzi-label">在线人数</span>
        <span class="online-dot"></span>
        <span class="busuanzi-value online-count">{{ onlineCount }}</span>
        <span class="busuanzi-unit">人</span>
      </span>
    </div>
    <div class="footer-content">
      <span class="footer-copyright">
        Copyright ©2025 Zeka Stack. Created By 
        <a href="https://github.com/dong4j" target="_blank" rel="noopener noreferrer" class="footer-link">dong4j</a>
      </span>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { useOnlineCounter } from '../composables/useOnlineCounter'

const { onlineCount } = useOnlineCounter()
</script>

<style scoped>
.busuanzi-footer {
  border-top: 1px solid var(--vp-c-divider);
  background-color: var(--vp-c-bg);
  padding: 0;
  margin: 0;
  max-width: 1440px;
  margin-left: auto;
  margin-right: auto;
  padding-left: 64px;
  padding-right: 64px;
}

@media (max-width: 768px) {
  .busuanzi-footer {
    padding-left: 24px;
    padding-right: 24px;
  }
}

.busuanzi {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
  padding: 6px 0 2px 0;
  margin: 0;
  font-size: 14px;
  color: var(--vp-c-text-2);
  line-height: 1.4;
}

.footer-content {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
  padding: 4px 0 8px 0;
  margin: 0;
  font-size: 14px;
  color: var(--vp-c-text-2);
  line-height: 1.5;
}

.footer-copyright {
  color: var(--vp-c-text-2);
}

.footer-link {
  color: var(--vp-c-brand);
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-link:hover {
  color: var(--vp-c-brand-light);
  text-decoration: underline;
}

.busuanzi-item {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.busuanzi-emoji {
  font-size: 16px;
  line-height: 1;
  flex-shrink: 0;
}

.busuanzi-label {
  color: var(--vp-c-text-2);
}

.busuanzi-value {
  color: var(--vp-c-brand);
  font-weight: 600;
  min-width: 2ch;
  text-align: center;
  margin-left: 4px;
}

.busuanzi-unit {
  color: var(--vp-c-text-3);
  font-size: 13px;
}

.busuanzi-separator {
  color: var(--vp-c-divider);
  margin: 0 4px;
  user-select: none;
}

.online-dot {
  width: 8px;
  height: 8px;
  background: #4caf50;
  border-radius: 50%;
  animation: breathe 2s ease-in-out infinite;
  flex-shrink: 0;
  display: inline-block;
  margin-left: 4px;
}

.online-count {
  color: var(--vp-c-brand);
  font-weight: 600;
}

@keyframes breathe {
  0%, 100% {
    opacity: 1;
    transform: scale(1);
    box-shadow: 0 0 0 0 rgba(76, 175, 80, 0.7);
  }
  50% {
    opacity: 0.6;
    transform: scale(1.2);
    box-shadow: 0 0 8px 4px rgba(76, 175, 80, 0.4);
  }
}

@media (max-width: 640px) {
  .busuanzi {
    font-size: 13px;
    padding: 4px 0 2px 0;
    margin: 0;
    gap: 6px;
  }

  .busuanzi-item {
    gap: 3px;
  }

  .busuanzi-unit {
    font-size: 12px;
  }

  .busuanzi-separator {
    margin: 0 2px;
  }

  .footer-content {
    font-size: 13px;
    padding: 3px 0 6px 0;
    margin: 0;
    gap: 6px;
  }
}
</style>

