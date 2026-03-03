<template>
  <header class="navbar">
    <div class="w-100 px-4">
      <div class="d-flex justify-content-between align-items-center w-100">
        <div class="d-flex items-center">
          <div class="navbar-brand" style="margin-left: 0;">
            <img src="/image/408.png" alt="408教父" class="img-fluid" style="height: 56px;">
          </div>
          
          <ul class="d-none d-md-flex ml-8 list-none">
            <li class="list-item">
              <router-link class="nav-link" to="/" @click="closeNavbar">
                <Home class="h-3 w-3 mr-2" />
                首页
              </router-link>
            </li>
            <li class="list-item">
              <router-link class="nav-link" to="/university-list" @click="closeNavbar">
                <List class="h-3 w-3 mr-2" />
                院校列表
              </router-link>
            </li>
            <li class="list-item">
              <router-link class="nav-link" to="/ranking" @click="closeNavbar">
                <Award class="h-3 w-3 mr-2" />
                排行榜
              </router-link>
            </li>
            <li class="list-item">
              <a class="nav-link" href="javascript:void(0)" @click="handleAuthNavigate('/recommend', true)">
                <Lightbulb class="h-3 w-3 mr-2" />
                智能推荐
              </a>
            </li>
            <li class="list-item">
              <a class="nav-link" href="javascript:void(0)" @click="handleAuthNavigate('/compare', true)">
                <BarChart class="h-3 w-3 mr-2" />
                数据对比
              </a>
            </li>
          </ul>
        </div>
        
        <div class="d-flex items-center">
          <div class="d-none d-md-flex align-items-center">
            <template v-if="isLoggedIn">
              <router-link to="/profile" class="d-flex align-items-center mr-4 user-info">
                <User class="h-3 w-3 mr-2" />
                {{ user?.username }}
              </router-link>
              <button class="btn btn-logout btn-lg" @click="handleLogout">退出</button>
            </template>
            <template v-else>
              <router-link to="/login" class="btn btn-lg mr-4" @click="closeNavbar">登录</router-link>
              <router-link to="/register" class="btn btn-primary btn-lg" @click="closeNavbar">注册</router-link>
            </template>
          </div>
          
          <div class="d-md-none flex items-center">
            <button @click="toggleNavbar" class="p-2 rounded-md text-gray-600">
              <Menu class="h-6 w-6" />
            </button>
          </div>
        </div>
      </div>
      
      <div v-if="isNavbarOpen" class="d-md-none py-4 space-y-3">
        <ul class="space-y-3">
          <li>
            <router-link class="nav-link" to="/" @click="closeNavbar">
              <Home class="h-3 w-3 mr-2" />
              首页
            </router-link>
          </li>
          <li>
            <router-link class="nav-link" to="/university-list" @click="closeNavbar">
              <List class="h-3 w-3 mr-2" />
              院校列表
            </router-link>
          </li>
          <li>
            <router-link class="nav-link" to="/ranking" @click="closeNavbar">
              <Award class="h-3 w-3 mr-2" />
              排行榜
            </router-link>
          </li>
          <li>
            <a class="nav-link" href="javascript:void(0)" @click="handleAuthNavigate('/recommend', true)">
              <Lightbulb class="h-3 w-3 mr-2" />
              智能推荐
            </a>
          </li>
          <li>
            <a class="nav-link" href="javascript:void(0)" @click="handleAuthNavigate('/compare', true)">
              <BarChart class="h-3 w-3 mr-2" />
              数据对比
            </a>
          </li>
        </ul>
        <div class="d-flex flex-column gap-3 mt-4">
          <template v-if="isLoggedIn">
            <router-link to="/profile" class="d-flex align-items-center justify-content-center user-info">
              <User class="h-3 w-3 mr-2" />
              {{ user?.username }}
            </router-link>
            <button class="btn btn-logout text-center" @click="handleLogout">退出</button>
          </template>
          <template v-else>
            <router-link to="/login" class="btn text-center" @click="closeNavbar">登录</router-link>
            <router-link to="/register" class="btn btn-primary text-center" @click="closeNavbar">注册</router-link>
          </template>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { ref, onMounted } from 'vue'
import { Home, List, Award, Lightbulb, BarChart, Menu, User } from 'lucide-vue-next'
import { useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'

export default {
  name: 'Header',
  components: {
    Home,
    List,
    Award,
    Lightbulb,
    BarChart,
    Menu,
    User
  },
  setup() {
    const router = useRouter()
    const { isLoggedIn, user, checkLoginStatus, logout, handleNavigate } = useAuth()
    const isNavbarOpen = ref(false)

    /**
     * 处理需要认证的导航
     * @param {string} to - 目标路由
     * @param {boolean} requireAuth - 是否需要登录
     */
    const handleAuthNavigate = (to, requireAuth) => {
      if (requireAuth) {
        handleNavigate(to, true)
      } else {
        closeNavbar()
        router.push(to)
      }
    }

    /**
     * 处理退出登录
     */
    const handleLogout = () => {
      logout()
      window.location.reload()
    }

    /**
     * 切换导航栏状态
     */
    const toggleNavbar = () => {
      isNavbarOpen.value = !isNavbarOpen.value
    }

    /**
     * 关闭导航栏
     */
    const closeNavbar = () => {
      isNavbarOpen.value = false
    }

    onMounted(() => {
      checkLoginStatus()
    })

    return {
      isNavbarOpen,
      isLoggedIn,
      user,
      toggleNavbar,
      closeNavbar,
      handleLogout,
      handleAuthNavigate,
      checkLoginStatus
    }
  }
}
</script>

<style scoped>
.user-info {
  color: #1a365d;
  font-weight: 600;
}

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
