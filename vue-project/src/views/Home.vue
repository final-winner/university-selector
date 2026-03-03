<template>
  <div class="home min-h-screen">
    <section class="hero">
      <div class="container">
        <div class="hero-content text-center">
          <h1 class="text-3xl md:text-4xl font-bold mb-5">智能择校，精准定位</h1>
          <p class="text-lg md:text-xl mb-8">专业、智能、便捷的408统考院校选择工具，助您找到最适合的考研目标院校</p>
          <div class="d-flex flex-row justify-center gap-4">
            <a href="javascript:void(0)" @click="handleNavigate('/recommend')" class="btn-light">开始智能推荐</a>
            <router-link to="/university-list" class="btn-outline-light">浏览院校列表</router-link>
          </div>
        </div>
      </div>
    </section>

    <section class="container py-20">
      <div class="text-center mb-16">
        <h2 class="worthy-text section-title text-primary font-bold" style="font-size: 2rem;">值得拥有</h2>
      </div>
      <div class="row">
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-secondary">
              <Search class="h-20 w-20" />
            </div>
            <h3 class="text-secondary">智能推荐</h3>
            <p>根据您的成绩、专业偏好、地区选择等因素，智能推荐最适合的院校</p>
          </div>
        </div>
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-success">
              <BarChart class="h-20 w-20" />
            </div>
            <h3 class="text-success">数据对比</h3>
            <p>多维度对比院校信息，包括分数线、招生人数、竞争态势等</p>
          </div>
        </div>
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-tertiary">
              <Heart class="h-20 w-20" />
            </div>
            <h3 class="text-tertiary">收藏管理</h3>
            <p>收藏感兴趣的院校，方便随时查看和对比</p>
          </div>
        </div>
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-accent">
              <Lightbulb class="h-20 w-20" />
            </div>
            <h3 class="text-accent">备考指导</h3>
            <p>提供专业的备考建议和学习资源，助力您的考研复习计划</p>
          </div>
        </div>
      </div>
    </section>

    <section class="container py-20">
      <div class="text-center mb-16">
        <h2 class="worthy-text section-title text-primary font-bold" style="font-size: 2rem;">热门院校</h2>
      </div>
      <div class="row">
        <div v-for="university in universities" :key="university.id" class="col-md-4 mb-6">
          <div class="university-card">
            <div class="card-header">
              <h5>{{ university.name }}</h5>
              <span :style="getSchoolTypeStyle(university.type)">{{ university.type }}</span>
            </div>
            <div class="card-body">
              <p><strong>地区：</strong>{{ university.city }}</p>
              <p><strong>分区：</strong>{{ university.AB }}</p>
              <p><strong>层次：</strong>{{ university.level }}</p>
            </div>
            <div class="card-footer">
              <a href="javascript:void(0)" @click="handleNavigate(`/university-detail/${university.id}`)" class="btn btn-primary text-xs font-bold px-2 py-1 hover:shadow-lg transform hover:-translate-y-1 transition-all">查看详情</a>
              <div class="flex items-center gap-4">
                <span class="collection-count text-sm text-text-secondary">收藏: {{ university.collectionNum }}</span>
                <button class="btn btn-favorite hover:shadow-lg transform hover:-translate-y-1 transition-all" @click="toggleFavorite(university.id)" :class="isFavorite(university.id) ? 'active' : ''">
                  <span :class="isFavorite(university.id) ? 'text-red-500' : 'text-gray-300'" style="font-size: 16px;">
                    {{ isFavorite(university.id) ? '❤' : '♡' }}
                  </span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="text-center mt-10">
        <a href="javascript:void(0)" @click="handleNavigate('/university-list')" class="btn-light">查看全部院校</a>
      </div>
    </section>
  </div>
</template>

<script>
import { ref, onMounted, watch } from 'vue'
import { Search, BarChart, Lightbulb, Heart } from 'lucide-vue-next'
import { useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'
import { universityApi, userApi } from '@/utils/api'
import { AUTH_ROUTES, ROUTES } from '@/utils/constants'

export default {
  name: 'Home',
  components: {
    Search,
    BarChart,
    Lightbulb,
    Heart
  },
  setup() {
    const router = useRouter()
    const { checkLogin, user, checkLoginStatus } = useAuth()
    const universities = ref([])
    const isLoading = ref(false)
    const favorites = ref(new Set())

    /**
     * 处理导航
     * @param {string} to - 目标路由
     */
    const handleNavigate = (to) => {
      // 详情页面不需要登录
      const requiresAuth = AUTH_ROUTES.includes(to) && !to.startsWith(ROUTES.UNIVERSITY_DETAIL)
      
      if (requiresAuth && !checkLogin()) {
        return
      }
      router.push(to)
    }

    /**
     * 切换收藏状态
     * @param {number} id - 院校ID
     */
    const toggleFavorite = async (id) => {
      if (!checkLogin()) return
      
      const isFav = favorites.value.has(id)
      
      try {
        const response = isFav 
          ? await userApi.removeFavorite({ userId: user.value.id, universityId: id })
          : await userApi.addFavorite({ userId: user.value.id, universityId: id })
        
        if (response.success) {
          // 使用新的Set对象来触发响应式更新
          const newFavorites = new Set(favorites.value)
          isFav ? newFavorites.delete(id) : newFavorites.add(id)
          favorites.value = newFavorites
          
          // 实时更新收藏量
          const universityIndex = universities.value.findIndex(uni => uni.id === id)
          if (universityIndex !== -1) {
            // 创建新的数组来触发响应式更新
            const updatedUniversities = [...universities.value]
            // 更新收藏量
            updatedUniversities[universityIndex] = {
              ...updatedUniversities[universityIndex],
              collectionNum: isFav 
                ? Math.max(0, updatedUniversities[universityIndex].collectionNum - 1) 
                : updatedUniversities[universityIndex].collectionNum + 1
            }
            universities.value = updatedUniversities
          }
        } else {
          // 修复：当后端返回"已收藏"时，自动添加到收藏列表
          if (response.message.includes('已收藏') && !isFav) {
            const newFavorites = new Set(favorites.value)
            newFavorites.add(id)
            favorites.value = newFavorites
          }
        }
      } catch (error) {
        console.error('操作失败:', error)
      }
    }

    /**
     * 获取热门院校
     */
    const fetchHotUniversities = async () => {
      try {
        isLoading.value = true
        const data = await universityApi.getHotUniversities()
        universities.value = data.slice(0, 6)
      } catch (error) {
        console.error('获取热门院校失败:', error)
      } finally {
        isLoading.value = false
      }
    }

    /**
     * 获取收藏列表
     */
    const fetchFavorites = async () => {
      const userId = user.value?.id
      if (!userId) return
      try {
        const data = await userApi.getFavorites(userId)
        // 创建新的Set对象来触发响应式更新
        const newFavorites = new Set()
        data.forEach(uni => newFavorites.add(uni.id))
        favorites.value = newFavorites
      } catch (error) {
        console.error('获取收藏列表失败:', error)
      }
    }

    /**
     * 获取院校层次样式
     * @param {string} type - 院校层次
     * @returns {string} - 样式字符串
     */
    const getBadgeStyle = (type) => {
      const styles = {
        'C9': 'background-color: #dc2626 !important; color: white !important; padding: 2px 8px; border-radius: 12px; font-weight: 600; font-size: 12px;',
        '985': 'background-color: #f97316 !important; color: white !important; padding: 2px 8px; border-radius: 12px; font-weight: 600; font-size: 12px;',
        '211': 'background-color: #2563eb !important; color: white !important; padding: 2px 8px; border-radius: 12px; font-weight: 600; font-size: 12px;',
        '双一流': 'background-color: #facc15 !important; color: white !important; padding: 2px 8px; border-radius: 12px; font-weight: 600; font-size: 12px;',
        '双非': 'background-color: #16a34a !important; color: white !important; padding: 2px 8px; border-radius: 12px; font-weight: 600; font-size: 12px;',
      }
      return styles[type] || styles['双非']
    }

    /**
     * 获取院校类型样式
     * @param {string} type - 院校类型
     * @returns {string} - 样式字符串
     */
    const getSchoolTypeStyle = (type) => {
      const typeStyles = {
        '综合类': 'background-color:#8b5cf6;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '理工类': 'background-color:#06b6d4;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '师范类': 'background-color:#f97316;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '农林类': 'background-color:#22c55e;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '医药类': 'background-color:#ef4444;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '财经类': 'background-color:#eab308;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '政法类': 'background-color:#64748b;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '语言类': 'background-color:#ec4899;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '民族类': 'background-color:#a855f7;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '艺术类': 'background-color:#f43f5e;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '体育类': 'background-color:#14b8a6;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
        '其他': 'background-color:#6b7280;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px'
      }
      return typeStyles[type] || typeStyles['其他']
    }

    /**
     * 检查是否已收藏
     * @param {number} id - 院校ID
     * @returns {boolean} - 是否已收藏
     */
    const isFavorite = (id) => {
      return favorites.value.has(id)
    }

    // 监听用户登录状态变化
    watch(() => user.value?.id, (newUserId) => {
      if (newUserId) {
        fetchFavorites()
      } else {
        favorites.value.clear()
      }
    })

    onMounted(() => {
      checkLoginStatus()
      fetchHotUniversities()
      if (user.value?.id) fetchFavorites()
    })

    return {
      universities,
      getBadgeStyle,
      getSchoolTypeStyle,
      toggleFavorite,
      isFavorite,
      handleNavigate
    }
  }
}
</script>

<style scoped>
.hero-content {
  max-width: 800px;
  margin: 0 auto;
}

.row {
  display: flex;
  flex-wrap: wrap;
  margin-right: -15px;
  margin-left: -15px;
}

.col-md-3,
.col-md-4 {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}

.col-md-3 {
  flex: 0 0 25%;
  max-width: 25%;
}

.col-md-4 {
  flex: 0 0 33.333333%;
  max-width: 33.333333%;
}

.mb-6 {
  margin-bottom: 1.5rem;
}

.mt-10 {
  margin-top: 2.5rem;
}

.d-flex {
  display: flex;
}

.flex-row {
  flex-direction: row;
}

.justify-center {
  justify-content: center;
}

.gap-4 {
  gap: 1rem;
}

.text-center {
  text-align: center;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.collection-count {
  font-size: 0.875rem;
  color: var(--text-secondary);
}

@media (max-width: 768px) {
  .col-md-3,
  .col-md-4 {
    flex: 0 0 100%;
    max-width: 100%;
  }
}
</style>