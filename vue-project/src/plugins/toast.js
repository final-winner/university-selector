import { createApp } from 'vue'
import Toast from '../components/Toast.vue'

const ToastConstructor = {
  install(Vue) {
    let toastInstance = null
    let container = null

    const showToastMethod = (options) => {
      if (!toastInstance) {
        container = document.createElement('div')
        document.body.appendChild(container)
        const app = createApp(Toast)
        toastInstance = app.mount(container)
      }

      toastInstance.showToast({
        title: options.title || '提示',
        message: options.message || '',
        type: options.type || 'info',
        duration: options.duration !== undefined ? options.duration : 3000
      })
    }

    Vue.config.globalProperties.$showToast = showToastMethod
    window.$showToast = showToastMethod
  }
}

export default ToastConstructor
