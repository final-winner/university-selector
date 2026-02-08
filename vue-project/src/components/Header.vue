<template>
  <header class="navbar">
    <div class="w-100 px-4">
      <div class="d-flex justify-content-between align-items-center w-100">
        <!-- 左侧：Logo 和导航链接 -->
        <div class="d-flex items-center">
          <!-- Logo -->
          <div class="navbar-brand" style="margin-left: 0;">
            <img src="/image/408.png" alt="408教父" class="img-fluid" style="height: 56px;">
          </div>
          
          <!-- 桌面端导航链接 -->
          <ul class="d-none d-md-flex ml-8 list-none">
            <li class="list-item">
              <router-link class="nav-link" to="/" @click="closeNavbar">
                <Home class="h-4 w-4 mr-2" />
                首页
              </router-link>
            </li>
            <li class="list-item">
              <router-link class="nav-link" to="/university-list" @click="closeNavbar">
                <List class="h-4 w-4 mr-2" />
                院校列表
              </router-link>
            </li>
            <li class="list-item">
              <router-link class="nav-link" to="/recommend" @click="closeNavbar">
                <Lightbulb class="h-4 w-4 mr-2" />
                智能推荐
              </router-link>
            </li>
            <li class="list-item">
              <router-link class="nav-link" to="/compare" @click="closeNavbar">
                <BarChart class="h-4 w-4 mr-2" />
                数据对比
              </router-link>
            </li>
          </ul>
        </div>
        
        <!-- 右侧：登录注册按钮和移动端菜单 -->
        <div class="d-flex items-center">
          <!-- 桌面端登录注册按钮 -->
          <div class="d-none d-md-flex">
            <router-link to="/login" class="btn btn-outline-secondary btn-lg mr-4" @click="closeNavbar">登录</router-link>
            <router-link to="/register" class="btn btn-primary btn-lg" @click="closeNavbar">注册</router-link>
          </div>
          
          <!-- 移动端菜单按钮 -->
          <div class="d-md-none flex items-center">
            <button @click="toggleNavbar" class="p-2 rounded-md text-gray-600">
              <Menu class="h-6 w-6" />
            </button>
          </div>
        </div>
      </div>
      
      <!-- 移动端菜单 -->
      <div v-if="isNavbarOpen" class="d-md-none py-4 space-y-3">
        <ul class="space-y-3">
          <li>
            <router-link class="nav-link" to="/" @click="closeNavbar">
              <Home class="h-4 w-4 mr-2" />
              首页
            </router-link>
          </li>
          <li>
            <router-link class="nav-link" to="/university-list" @click="closeNavbar">
              <List class="h-4 w-4 mr-2" />
              院校列表
            </router-link>
          </li>
          <li>
            <router-link class="nav-link" to="/recommend" @click="closeNavbar">
              <Lightbulb class="h-4 w-4 mr-2" />
              智能推荐
            </router-link>
          </li>
          <li>
            <router-link class="nav-link" to="/compare" @click="closeNavbar">
              <BarChart class="h-4 w-4 mr-2" />
              数据对比
            </router-link>
          </li>
        </ul>
        <div class="d-flex flex-column gap-3 mt-4">
          <router-link to="/login" class="btn text-center" @click="closeNavbar">登录</router-link>
          <router-link to="/register" class="btn btn-primary text-center" @click="closeNavbar">注册</router-link>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { ref } from 'vue'
import { Home, List, Lightbulb, BarChart, Menu } from 'lucide-vue-next'

export default {
  name: 'Header',
  components: {
    Home,
    List,
    Lightbulb,
    BarChart,
    Menu
  },
  setup() {
    const isNavbarOpen = ref(false)

    const toggleNavbar = () => {
      isNavbarOpen.value = !isNavbarOpen.value
    }

    const closeNavbar = () => {
      isNavbarOpen.value = false
    }

    return {
      isNavbarOpen,
      toggleNavbar,
      closeNavbar
    }
  }
}
</script>

<style scoped>
.text-gray-600 {
  color: var(--text-secondary);
}

.mr-2 {
  margin-right: 0.5rem;
}

.mr-4 {
  margin-right: 1rem;
}

.ml-8 {
  margin-left: 2rem;
}

.d-flex {
  display: flex;
}

.justify-content-between {
  justify-content: space-between;
}

.align-items-center {
  align-items: center;
}

.d-none {
  display: none;
}

.d-md-flex {
  display: flex;
}

.d-md-none {
  display: none;
}

.flex-column {
  flex-direction: column;
}

.space-y-3 {
  gap: 0.75rem;
}

.gap-4 {
  gap: 1rem;
}

.py-4 {
  padding-top: 1rem;
  padding-bottom: 1rem;
}

.mt-4 {
  margin-top: 1rem;
}

.text-center {
  text-align: center;
}

.flex-grow {
  flex-grow: 1;
}

.list-none {
  list-style: none;
  padding: 0;
  margin: 0;
}

.list-item {
  list-style-type: none;
}

@media (max-width: 768px) {
  .d-md-none {
    display: block;
  }
  
  .d-md-flex {
    display: none;
  }
}
</style>