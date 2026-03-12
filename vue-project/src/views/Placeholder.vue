<template>
  <div class="placeholder-page">
    <div class="container">
      <h1 class="page-title">{{ title }}</h1>
      <div class="content">
        <p>该功能正在开发中，敬请期待！</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Placeholder',
  props: {
    title: {
      type: String,
      default: '页面开发中'
    }
  }
}
</script>

<style scoped>
.placeholder-page {
  padding: 60px 0;
  min-height: calc(100vh - 240px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.page-title {
  font-size: 2.5rem;
  font-weight: bold;
  color: var(--primary-color);
  margin-bottom: 2rem;
  text-align: center;
}

.content {
  text-align: center;
  font-size: 1.25rem;
  color: var(--text-secondary);
}
</style>