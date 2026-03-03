<template>
  <div id="app">
    <Header />
    <main class="main-content">
      <router-view />
    </main>
    <Footer />
    <Toast />
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
import Footer from '@/components/Footer.vue'
import Toast from '@/components/Toast.vue'

export default {
  name: 'App',
  components: {
    Header,
    Footer,
    Toast
  }
}
</script>

<style>
:root {
  --primary-color: #1E3A8A;
  --secondary-color: #3B82F6;
  --text-primary: #1f2937;
  --text-secondary: #6b7280;
  --bg-color: #f9fafb;
  --border-color: #e5e7eb;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Hiragino Sans GB',
    'Microsoft YaHei', 'Helvetica Neue', Helvetica, Arial, sans-serif;
  background-color: var(--bg-color);
  color: var(--text-primary);
  line-height: 1.6;
}

#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1;
  padding-top: 20px;
}

a {
  text-decoration: none;
  color: inherit;
}

a:hover {
  text-decoration: none;
}

button {
  cursor: pointer;
  border: none;
  outline: none;
  font-family: inherit;
}

input,
select,
textarea {
  font-family: inherit;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 15px;
}
</style>
