<template>
  <Teleport to="body">
    <Transition name="toast">
      <div v-if="show" class="toast-overlay" @click="close">
        <div class="toast-container" @click.stop>
          <div class="toast-icon" :class="type">
            <CheckCircle v-if="type === 'success'" class="toast-icon-svg" />
            <AlertCircle v-else-if="type === 'error'" class="toast-icon-svg" />
            <Info v-else class="toast-icon-svg" />
          </div>
          <div class="toast-content">
            <div class="toast-title">{{ title }}</div>
            <div class="toast-message">{{ message }}</div>
          </div>
          <button class="toast-close" @click="close">
            <X class="toast-close-svg" />
          </button>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script>
import { ref, watch } from 'vue'
import { CheckCircle, AlertCircle, Info, X } from 'lucide-vue-next'

export default {
  name: 'Toast',
  components: {
    CheckCircle,
    AlertCircle,
    Info,
    X
  },
  setup() {
    const show = ref(false)
    const title = ref('')
    const message = ref('')
    const type = ref('info')
    const duration = ref(1500)
    let timer = null

    const close = () => {
      show.value = false
      if (timer) {
        clearTimeout(timer)
        timer = null
      }
    }

    const showToast = (options) => {
      if (timer) {
        clearTimeout(timer)
      }
      
      title.value = options.title || '提示'
      message.value = options.message || ''
      type.value = options.type || 'info'
      duration.value = options.duration || 1500
      
      show.value = true
      
      if (duration.value > 0) {
        timer = setTimeout(() => {
          close()
        }, duration.value)
      }
    }

    return {
      show,
      title,
      message,
      type,
      close,
      showToast
    }
  }
}
</script>

<style scoped>
.toast-overlay {
  position: fixed;
  top: 20px;
  left: 0;
  right: 0;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  z-index: 9999;
  padding: 20px;
  pointer-events: none;
}

.toast-container {
  background: white;
  border-radius: 16px;
  padding: 20px 24px;
  display: flex;
  align-items: flex-start;
  gap: 16px;
  max-width: 400px;
  width: 100%;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
  position: relative;
}

.toast-icon {
  flex-shrink: 0;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.toast-icon.info {
  background: rgba(30, 58, 138, 0.1);
}

.toast-icon.success {
  background: rgba(22, 163, 74, 0.1);
}

.toast-icon.error {
  background: rgba(220, 38, 38, 0.1);
}

.toast-icon-svg {
  width: 24px;
  height: 24px;
}

.toast-icon.info .toast-icon-svg {
  color: #1E3A8A;
}

.toast-icon.success .toast-icon-svg {
  color: #16a34a;
}

.toast-icon.error .toast-icon-svg {
  color: #dc2626;
}

.toast-content {
  flex: 1;
  min-width: 0;
}

.toast-title {
  font-size: 16px;
  font-weight: 600;
  color: #1a365d;
  margin-bottom: 4px;
}

.toast-message {
  font-size: 14px;
  color: #64748b;
  line-height: 1.5;
}

.toast-close {
  position: absolute;
  top: 12px;
  right: 12px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s;
}

.toast-close:hover {
  background: rgba(0, 0, 0, 0.05);
}

.toast-close-svg {
  width: 18px;
  height: 18px;
  color: #94a3b8;
}

.toast-enter-active,
.toast-leave-active {
  transition: all 0.3s ease;
}

.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: scale(0.9);
}
</style>
