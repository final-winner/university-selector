import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src')
    }
  },
  server: {
    port: 3000,          // 前端固定3000端口
    open: true,          // 启动后自动打开浏览器（重点！不用手动输网址）
    proxy: {
      '/api': {
        target: 'http://localhost:8080', // 代理到后端8080
        changeOrigin: true
      }
    }
  }
  // 删掉之前加的optimizeDeps配置，避免报错
})