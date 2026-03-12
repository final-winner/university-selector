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
    path: '/about',
    name: 'About',
    component: () => import('@/views/Placeholder.vue'),
    props: { title: '关于我们' }
  },
  {
    path: '/help',
    name: 'Help',
    component: () => import('@/views/Placeholder.vue'),
    props: { title: '帮助中心' }
  },
  {
    path: '/sitemap',
    name: 'Sitemap',
    component: () => import('@/views/Placeholder.vue'),
    props: { title: '网站地图' }
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('@/views/Profile.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/ranking',
    name: 'Ranking',
    component: () => import('@/views/Ranking.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/admin/correction',
    name: 'AdminCorrection',
    component: () => import('@/views/AdminCorrection.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/correction/:id',
    name: 'CorrectionPage',
    component: () => import('@/views/CorrectionPage.vue'),
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
    
    const user = JSON.parse(userData)
    
    if (to.meta.requiresAdmin) {
      if (user.role !== 'admin') {
        if (window.$showToast) {
          window.$showToast({
            title: '提示',
            message: '您没有权限访问该页面',
            type: 'warning',
            duration: 1500
          })
        } else {
          alert('您没有权限访问该页面')
        }
        next('/')
        return
      }
    }
    
    if (user.role === 'admin' && !to.meta.requiresAdmin) {
      if (window.$showToast) {
        window.$showToast({
          title: '提示',
          message: '管理员请访问管理后台',
          type: 'info',
          duration: 1500
        })
      } else {
        alert('管理员请访问管理后台')
      }
      next('/admin/correction')
      return
    }
  }
  next()
})

export default router
