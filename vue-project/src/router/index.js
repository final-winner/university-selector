import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import UniversityList from '@/views/UniversityList.vue'
import UniversityDetail from '@/views/UniversityDetail.vue'
import Recommend from '@/views/Recommend.vue'
import Compare from '@/views/Compare.vue'
import Login from '@/views/Login.vue'
import Register from '@/views/Register.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/university-list',
    name: 'UniversityList',
    component: UniversityList
  },
  {
    path: '/university-detail/:id',
    name: 'UniversityDetail',
    component: UniversityDetail
  },
  {
    path: '/recommend',
    name: 'Recommend',
    component: Recommend
  },
  {
    path: '/compare',
    name: 'Compare',
    component: Compare
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router