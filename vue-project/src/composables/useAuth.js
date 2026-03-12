import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { userApi } from '@/utils/api'

export function useAuth() {
  const router = useRouter()
  const isLoggedIn = ref(false)
  const user = ref(null)
  const isLoading = ref(false)

  /**
   * 检查用户是否登录
   * @returns {boolean} - 是否已登录
   */
  const checkLogin = () => {
    const userData = localStorage.getItem('user')
    if (!userData) {
      showLoginPrompt()
      return false
    }
    return true
  }

  /**
   * 显示登录提示
   */
  const showLoginPrompt = () => {
    if (window.$showToast) {
      window.$showToast({
        title: '提示',
        message: '请先登录',
        type: 'info',
        duration: 1500
      })
      setTimeout(() => {
        router.push('/login')
      }, 500)
    } else {
      alert('请先登录')
      router.push('/login')
    }
  }

  /**
   * 检查登录状态
   * @returns {boolean} - 登录状态
   */
  const checkLoginStatus = () => {
    const userData = localStorage.getItem('user')
    if (userData) {
      isLoggedIn.value = true
      user.value = JSON.parse(userData)
    } else {
      isLoggedIn.value = false
      user.value = null
    }
    return isLoggedIn.value
  }

  /**
   * 登录
   * @param {object} credentials - 登录凭证
   * @returns {Promise} - 登录结果
   */
  const login = async (credentials) => {
    try {
      isLoading.value = true
      const response = await userApi.login(credentials)
      if (response.success) {
        console.log('Login response user:', response.user)
        localStorage.setItem('user', JSON.stringify(response.user))
        checkLoginStatus()
      }
      return response
    } catch (error) {
      console.error('Login failed:', error)
      throw error
    } finally {
      isLoading.value = false
    }
  }

  /**
   * 注册
   * @param {object} userData - 用户数据
   * @returns {Promise} - 注册结果
   */
  const register = async (userData) => {
    try {
      isLoading.value = true
      const response = await userApi.register(userData)
      return response
    } catch (error) {
      console.error('Register failed:', error)
      throw error
    } finally {
      isLoading.value = false
    }
  }

  /**
   * 退出登录
   */
  const logout = () => {
    localStorage.removeItem('user')
    isLoggedIn.value = false
    user.value = null
    router.push('/')
  }

  /**
   * 处理导航
   * @param {string} to - 目标路由
   * @param {boolean} requireAuth - 是否需要登录
   */
  const handleNavigate = (to, requireAuth = false) => {
    if (requireAuth && !checkLogin()) {
      return
    }
    router.push(to)
  }

  return {
    isLoggedIn,
    user,
    isLoading,
    checkLogin,
    checkLoginStatus,
    login,
    register,
    logout,
    handleNavigate
  }
}
