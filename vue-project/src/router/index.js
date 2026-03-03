import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/Home.vue')
  },
  {
    path: '/university-list',
    name: 'UniversityList',
    component: () => import('@/views/UniversityList.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/university-detail/:id',
    name: 'UniversityDetail',
    component: () => import('@/views/UniversityDetail.vue'),
    meta: { requiresAuth: false }
  },
  {
    path: '/recommend',
    name: 'Recommend',
    component: () => import('@/views/Recommend.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/compare',
    name: 'Compare',
    component: () => import('@/views/Compare.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/Register.vue')
  },
  {
    path: '/forgot-password',
    name: 'ForgotPassword',
    component: () => import('@/views/ForgotPassword.vue')
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('@/views/Profile.vue'),
    meta: { requiresAuth: true }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth) {
    const userData = localStorage.getItem('user')
    if (!userData) {
      if (window.$showToast) {
        window.$showToast({
          title: '提示',
          message: '请先登录',
          type: 'info',
          duration: 1500
        })
        setTimeout(() => {
          next('/login')
        }, 500)
      } else {
        alert('请先登录')
        next('/login')
      }
      return
    }
  }
  next()
})

export default router
