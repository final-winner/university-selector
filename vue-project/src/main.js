import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import toast from './plugins/toast'
import './assets/css/global.css'

const app = createApp(App)
app.use(router)
app.use(toast)
app.mount('#app')
