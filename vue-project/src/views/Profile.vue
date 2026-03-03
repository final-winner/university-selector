<template>
  <div class="profile">
    <div class="container py-10">
      <h1 class="page-title text-center text-3xl font-bold text-primary mb-16">个人中心</h1>
      
      <div class="profile-content">
        <!-- 用户信息卡片 -->
        <div class="profile-card">
          <div class="profile-header">
              <div class="profile-left">
                 <div class="avatar-container">
                   <div class="avatar">
                     <img v-if="user?.avatarUrl" :src="user.avatarUrl" alt="头像" class="avatar-img" />
                     <User v-else class="avatar-icon" />
                   </div>
                   <button class="btn-setting" @click="showSettingModal = true">
                     设置
                   </button>
                 </div>
                 <div class="profile-info">
                  <h2 class="username">{{ user?.username || '用户' }}</h2>
                  <p class="email">{{ user?.email || '' }}</p>
                  <p class="join-time">注册时间：{{ formatDate(user?.createTime) }}</p>
                </div>
              </div>
              <div class="profile-right">
                <div class="user-stats">
                  <div class="stat-item">
                    <span class="stat-label">目标分数</span>
                    <span class="stat-value">{{ user?.targetScore || '未设置' }}</span>
                  </div>
                  <div class="stat-item">
                    <span class="stat-label">考研年份</span>
                    <span class="stat-value">{{ user?.postgraduateYear || '未设置' }}</span>
                  </div>
                  <div class="stat-item countdown">
                    <span class="stat-label">考研倒计时</span>
                    <span class="stat-value">{{ countdownText }}</span>
                  </div>
                </div>
              </div>
            </div>
        </div>

        <!-- 功能菜单 -->
        <div class="menu-section">
          <h3 class="menu-title">我的功能</h3>
          <div class="menu-grid">
            <div class="menu-item" @click="handleNavigate('/university-list')">
              <div class="menu-icon">
                <List class="h-6 w-6" />
              </div>
              <span>浏览院校</span>
            </div>
            <div class="menu-item" @click="handleNavigate('/recommend')">
              <div class="menu-icon">
                <Lightbulb class="h-6 w-6" />
              </div>
              <span>智能推荐</span>
            </div>
            <div class="menu-item" @click="handleNavigate('/compare')">
              <div class="menu-icon">
                <BarChart class="h-6 w-6" />
              </div>
              <span>院校对比</span>
            </div>
            <div class="menu-item" @click="handleLogout">
              <div class="menu-icon logout">
                <LogOut class="h-6 w-6" />
              </div>
              <span>退出登录</span>
            </div>
          </div>
        </div>

        <!-- 收藏院校 -->
        <div class="favorites-section">
          <h3 class="section-title">我的收藏</h3>
          <div v-if="favorites.length > 0" class="favorites-grid">
            <div v-for="uni in favorites" :key="uni.id" class="favorite-card">
              <div class="favorite-header">
                <h4>{{ uni.name }}</h4>
                <button class="btn-remove" @click="removeFavorite(uni.id)">
                  <X class="h-4 w-4" />
                </button>
              </div>
              <div class="favorite-body">
                <p><span class="label">地区：</span>{{ uni.city }}</p>
                <p><span class="label">层次：</span>{{ uni.level }}</p>
                <p><span class="label">类型：</span>{{ uni.type }}</p>
              </div>
              <button class="btn-detail" @click="handleNavigate(`/university-detail/${uni.id}`)">
                查看详情
              </button>
            </div>
          </div>
          <div v-else class="empty-state">
            <Heart class="empty-icon" />
            <p>暂无收藏院校</p>
            <button class="btn btn-primary" @click="handleNavigate('/university-list')">
              去浏览院校
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- 设置模态框 -->
    <div v-if="showSettingModal" class="modal-overlay" @click="closeModal">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>设置目标信息</h3>
          <button class="modal-close" @click="closeModal">
            <X class="h-5 w-5" />
          </button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label>目标分数</label>
            <input
              type="number"
              v-model="settingForm.targetScore"
              placeholder="请输入目标分数"
              min="0"
              max="500"
            />
          </div>
          <div class="form-group">
            <label>考研年份</label>
            <input
              type="number"
              v-model="settingForm.postgraduateYear"
              placeholder="请输入考研年份"
              min="2024"
              max="2030"
            />
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="closeModal">取消</button>
          <button class="btn btn-primary" @click="saveSettings">保存</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'
import { User, List, Lightbulb, BarChart, LogOut, X, Heart } from 'lucide-vue-next'

export default {
  name: 'Profile',
  components: {
    User,
    List,
    Lightbulb,
    BarChart,
    LogOut,
    X,
    Heart
  },
  setup() {
    const router = useRouter()
    const {user, checkLoginStatus, logout, checkLogin} = useAuth()
    const API_BASE_URL = 'http://localhost:8080'
    const favorites = ref([])
    const countdownText = ref('未设置')
    const showSettingModal = ref(false)
    const settingForm = ref({
      targetScore: '',
      postgraduateYear: ''
    })

    const handleNavigate = (to) => {
      // 详情页面不需要登录检查
      if (!to.includes('/university-detail') && !checkLogin()) {
        return
      }
      router.push(to)
    }

    const handleLogout = () => {
      localStorage.removeItem('user')
      window.location.href = '/'
    }

    const formatDate = (dateStr) => {
      if (!dateStr) return '未知'
      const date = new Date(dateStr)
      return date.toLocaleDateString('zh-CN')
    }

    // 计算考研倒计时
    const calculateCountdown = () => {
      const postgraduateYear = user.value?.postgraduateYear
      if (!postgraduateYear) {
        countdownText.value = '未设置'
        return
      }

      // 考研通常在12月的最后一个周末
      // 注意：27考研是26年12月考
      const examYear = parseInt(postgraduateYear) - 1
      
      // 假设为12月25日
      const examDate = new Date(`${examYear}-12-20T00:00:00`)
      const now = new Date()
      const timeDiff = examDate - now

      if (timeDiff <= 0) {
        countdownText.value = '考试已结束'
        return
      }

      const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24))
      countdownText.value = `${days}天`
    }

    // 每分钟更新一次倒计时
    let countdownInterval = null

    const startCountdown = () => {
      calculateCountdown()
      if (countdownInterval) {
        clearInterval(countdownInterval)
      }
      countdownInterval = setInterval(calculateCountdown, 60000)
    }

    const stopCountdown = () => {
      if (countdownInterval) {
        clearInterval(countdownInterval)
        countdownInterval = null
      }
    }

    const fetchFavorites = async () => {
      const userId = user.value?.id
      if (!userId) return

      try {
        const res = await fetch(`${API_BASE_URL}/user/favorite/${userId}`)
        if (res.ok) {
          favorites.value = await res.json()
        }
      } catch (e) {
        console.error('获取收藏失败:', e)
      }
    }

    const removeFavorite = async (universityId) => {
      const userId = user.value?.id
      if (!userId) return

      try {
        const res = await fetch(`${API_BASE_URL}/user/favorite/remove`, {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({userId, universityId})
        })
        if (res.ok) {
          favorites.value = favorites.value.filter(f => f.id !== universityId)
          window.$showToast({title: '成功', message: '已取消收藏', type: 'success'})
        }
      } catch (e) {
        console.error('取消收藏失败:', e)
      }
    }

    onMounted(() => {
      checkLoginStatus()
      fetchFavorites()
      startCountdown()
    })

    const closeModal = () => {
      showSettingModal.value = false
      // 重置表单
      settingForm.value = {
        targetScore: '',
        postgraduateYear: ''
      }
    }

    const saveSettings = async () => {
      const userId = user.value?.id
      if (!userId) return

      try {
        const response = await fetch(`${API_BASE_URL}/user/update`, {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({
            userId,
            targetScore: settingForm.value.targetScore,
            postgraduateYear: settingForm.value.postgraduateYear
          })
        })
        
        if (response.ok) {
          // 更新本地用户信息（使用新对象确保响应式更新）
          user.value = {
            ...user.value,
            ...(settingForm.value.targetScore && { targetScore: settingForm.value.targetScore }),
            ...(settingForm.value.postgraduateYear && { postgraduateYear: settingForm.value.postgraduateYear })
          }
          // 更新localStorage
          localStorage.setItem('user', JSON.stringify(user.value))
          // 重新计算倒计时
          calculateCountdown()
          // 显示成功提示
          window.$showToast({title: '成功', message: '设置已保存', type: 'success'})
          // 关闭模态框
          closeModal()
        }
      } catch (error) {
        console.error('保存设置失败:', error)
        window.$showToast({title: '失败', message: '保存失败，请重试', type: 'error'})
      }
    }

    onUnmounted(() => {
      stopCountdown()
    })

    return {
      user,
      favorites,
      countdownText,
      showSettingModal,
      settingForm,
      handleNavigate,
      handleLogout,
      formatDate,
      removeFavorite,
      fetchFavorites,
      closeModal,
      saveSettings
    }
  }
}
</script>

<style scoped>
.profile {
  min-height: 80vh;
  padding-bottom: 40px;
}

.profile-content {
  max-width: 1000px;
  margin: 0 auto;
}

.profile-card {
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  padding: 30px;
  margin-bottom: 30px;
}

.profile-header {
  display: flex;
  align-items: center;
  gap: 24px;
}

.avatar-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  overflow: hidden;
}

.avatar-container .btn-setting {
  margin-top: 0;
  text-align: center;
}

.avatar-icon {
  width: 40px;
  height: 40px;
  color: white;
}

.avatar-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.profile-info .username {
  font-size: 1.5rem;
  font-weight: bold;
  color: var(--primary-color);
  margin-bottom: 4px;
}

.profile-info .email {
  color: var(--text-secondary);
  margin-bottom: 4px;
}

.profile-info .join-time {
  color: var(--text-light);
  font-size: 0.875rem;
  margin-bottom: 8px;
}

.profile-info .btn-setting {
  margin-top: 4px;
  display: inline-block;
}

.profile-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.profile-left {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.profile-right {
  display: flex;
  align-items: center;
  gap: 2rem;
}

.btn-setting {
  padding: 4px 8px;
  background: none;
  color: var(--text-secondary);
  border: none;
  border-radius: 0;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: underline;
}

.btn-setting:hover {
  color: var(--primary-color);
  text-decoration: underline;
  transform: none;
  box-shadow: none;
}

.user-stats {
  display: flex;
  gap: 2rem;
}

.stat-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-label {
  font-size: 0.875rem;
  color: var(--text-secondary);
  font-weight: 500;
}

.stat-value {
  font-size: 1.25rem;
  color: var(--secondary-color);
  font-weight: bold;
}

.stat-item.countdown .stat-value {
  color: #ef4444;
  font-size: 1.375rem;
  font-weight: 800;
}

.menu-section {
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  padding: 30px;
  margin-bottom: 30px;
}

.menu-title {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 20px;
}

.menu-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.menu-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 24px 16px;
  background: var(--bg-color);
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.menu-item:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.menu-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background: var(--primary-color);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  margin-bottom: 12px;
}

.menu-icon.logout {
  background: #f97316;
}

.menu-item span {
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.favorites-section {
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  padding: 30px;
}

.section-title {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 20px;
}

.favorites-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

.favorite-card {
  background: var(--bg-color);
  border-radius: 12px;
  padding: 16px;
}

.favorite-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.favorite-header h4 {
  font-size: 1rem;
  font-weight: 600;
  color: var(--primary-color);
}

.btn-remove {
  background: none;
  border: none;
  color: var(--text-light);
  cursor: pointer;
  padding: 4px;
}

.btn-remove:hover {
  color: #ef4444;
}

.favorite-body p {
  font-size: 0.875rem;
  color: var(--text-secondary);
  margin-bottom: 4px;
}

.favorite-body .label {
  color: var(--text-light);
}

.btn-detail {
  width: 90px;
  margin: 12px auto 0;
  padding: 8px;
  background: #f97316;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 0.875rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: block;
}

.btn-detail:hover {
  background: #ea580c;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(249, 115, 22, 0.2);
}

.empty-state {
  text-align: center;
  padding: 40px;
}

.empty-icon {
  width: 64px;
  height: 64px;
  color: var(--text-light);
  margin-bottom: 16px;
}

.empty-state p {
  color: var(--text-secondary);
  margin-bottom: 16px;
}

/* 模态框样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
  width: 100%;
  max-width: 400px;
  max-height: 80vh;
  overflow-y: auto;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  border-bottom: 1px solid #e6f0ff;
}

.modal-header h3 {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--text-primary);
  margin: 0;
}

.modal-close {
  background: none;
  border: none;
  color: var(--text-light);
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  transition: all 0.3s ease;
}

.modal-close:hover {
  background: #f3f4f6;
  color: var(--text-secondary);
}

.modal-body {
  padding: 24px;
}

.modal-body .form-group {
  margin-bottom: 20px;
}

.modal-body .form-group label {
  display: block;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 8px;
  font-size: 0.875rem;
}

.modal-body .form-group input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #e6f0ff;
  border-radius: 8px;
  font-size: 0.875rem;
  transition: all 0.3s ease;
  background: white;
  color: var(--text-primary);
}

.modal-body .form-group input:focus {
  outline: none;
  border-color: var(--secondary-color);
  box-shadow: 0 0 0 3px rgba(249, 115, 22, 0.1);
}

.modal-footer {
  display: flex;
  gap: 12px;
  padding: 20px 24px;
  border-top: 1px solid #e6f0ff;
  justify-content: flex-end;
}

.modal-footer .btn {
  padding: 10px 20px;
  border-radius: 6px;
  font-size: 0.875rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
}

.modal-footer .btn-secondary {
  background: #f3f4f6;
  color: var(--text-secondary);
}

.modal-footer .btn-secondary:hover {
  background: #e5e7eb;
}

.modal-footer .btn-primary {
  background: var(--primary-color);
  color: white;
}

.modal-footer .btn-primary:hover {
  background: var(--primary-dark);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(30, 58, 138, 0.3);
}

@media (max-width: 768px) {
  .menu-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .favorites-grid {
    grid-template-columns: 1fr;
  }
  
  .profile-header {
    flex-direction: column;
    text-align: center;
  }
  
  .profile-right {
    flex-direction: column;
    gap: 1rem;
    align-items: center;
  }
  
  .modal-content {
    margin: 20px;
  }
}
</style>
