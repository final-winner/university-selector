<template>
  <div class="university-list">
    <div class="container py-10">
      <h1 class="page-title text-center text-3xl font-bold text-primary mb-16">院校列表</h1>
      
      <!-- 搜索和筛选区域 -->
      <div class="search-filter-container">
        <div class="search-row">
          <input 
            v-model="searchQuery" 
            type="text" 
            placeholder="搜索院校名称..."
            @keyup.enter="handleSearch"
          />
          <button @click="handleSearch" class="btn btn-primary">确定</button>
        </div>
        
        <!-- 院校层次 -->
        <div class="filter-group">
          <span class="filter-label">院校层次：</span>
          <span 
            v-for="type in filterTypes" 
            :key="type"
            class="filter-tag"
            :class="{ active: filterType === type }"
            @click="filterType = type"
          >
            {{ type === '' ? '全部' : type }}
          </span>
        </div>
        
        <!-- 院校所在地 -->
        <div class="filter-group">
          <span class="filter-label">院校所在地：</span>
          <span 
            v-for="province in provinces" 
            :key="province"
            class="filter-tag"
            :class="{ active: filterProvince === province }"
            @click="filterProvince = province"
          >
            {{ province === '' ? '全部' : province }}
          </span>
        </div>
        
        <!-- 地区 -->
        <div class="filter-group">
          <span class="filter-label">地区：</span>
          <span 
            v-for="region in regions" 
            :key="region"
            class="filter-tag"
            :class="{ active: filterRegion === region }"
            @click="filterRegion = region"
          >
            {{ region === '' ? '全部' : region }}
          </span>
        </div>
        
        <!-- A/B区 -->
        <div class="filter-group">
          <span class="filter-label">分区：</span>
          <span 
            v-for="ab in ['', 'A区', 'B区']" 
            :key="ab"
            class="filter-tag"
            :class="{ active: filterAB === ab }"
            @click="filterAB = ab"
          >
            {{ ab === '' ? '全部' : ab }}
          </span>
        </div>
        
        <!-- 院校类型 -->
        <div class="filter-group">
          <span class="filter-label">院校类型：</span>
          <span 
            v-for="type in schoolTypes" 
            :key="type"
            class="filter-tag"
            :class="{ active: filterSchoolType === type }"
            @click="filterSchoolType = type"
          >
            {{ type === '' ? '全部' : type }}
          </span>
        </div>
        

      </div>
      
      <!-- 表格区域 -->
      <div class="table-responsive">
        <table class="table table-hover w-full">
          <thead>
            <tr class="bg-primary text-white">
              <th class="px-4 py-3 font-bold text-sm text-center">院校名称</th>
              <th class="px-4 py-3 font-bold text-sm text-center">院校代码</th>
              <th class="px-4 py-3 font-bold text-sm text-center">省份</th>
              <th class="px-4 py-3 font-bold text-sm text-center">城市</th>
              <th class="px-4 py-3 font-bold text-sm text-center">地区</th>
              <th class="px-4 py-3 font-bold text-sm text-center">院校层次</th>
              <th class="px-4 py-3 font-bold text-sm text-center">A/B区</th>
              <th class="px-4 py-3 font-bold text-sm text-center">院校类型</th>
              <th class="px-4 py-3 font-bold text-sm text-center">操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="university in displayedUniversities" :key="university.id" class="hover:bg-light transition-all duration-200">
              <td class="px-4 py-3 font-semibold text-sm text-primary text-center">{{ university.name }}</td>
              <td class="px-4 py-3 text-sm text-text-primary text-center">{{ university.code }}</td>
              <td class="px-4 py-3 text-sm text-text-primary text-center">{{ university.province }}</td>
              <td class="px-4 py-3 text-sm text-text-primary text-center">{{ university.city }}</td>
              <td class="px-4 py-3 text-sm text-text-primary text-center">{{ university.region }}</td>
              <td class="px-4 py-3 text-center"><span :style="getUniversityTypeStyle(university.level)">{{ university.level }}</span></td>
              <td class="px-4 py-3 text-center"><span :style="getABStyle(university.AB)">{{ university.AB }}</span></td>
              <td class="px-4 py-3 text-center"><span :style="getSchoolTypeStyle(university.type)">{{ university.type }}</span></td>
              <td class="px-4 py-3 text-center">
                <div class="flex justify-center items-center gap-2">
                  <a href="javascript:void(0)" @click="handleNavigate(`/university-detail/${university.id}`)" class="btn btn-primary text-xs px-2 py-1 hover:shadow-lg transform hover:-translate-y-1 transition-all">查看详情</a>
                  <button class="btn btn-favorite hover:shadow-lg transform hover:-translate-y-1 transition-all" @click="toggleFavoriteStatus(university.id)" :class="isFavoriteUniversity(university.id) ? 'active' : ''">
                    <span :class="isFavoriteUniversity(university.id) ? 'text-red-500' : 'text-gray-300'" style="font-size: 14px;">
                      {{ isFavoriteUniversity(university.id) ? '❤' : '♡' }}
                    </span>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      
      <!-- 空状态 -->
      <div v-if="filteredUniversities.length === 0" class="empty-state text-center py-16 bg-white rounded-xl shadow-sm mt-8">
        <div class="text-text-secondary text-2xl font-semibold">暂无院校数据</div>
        <p class="text-text-light mt-2">请尝试调整搜索条件或筛选选项</p>
      </div>
      
      <!-- 分页区域 -->
      <div v-if="filteredUniversities.length > 0" class="pagination-container">
        <nav aria-label="Page navigation">
          <ul class="pagination">
            <li :class="{ 'disabled': currentPage === 1 }">
              <a href="#" @click.prevent="changeToPage(currentPage - 1)" class="page-link">
                <ChevronLeft class="h-5 w-5" />
              </a>
            </li>
            <li v-for="page in totalPages" :key="page" :class="{ 'active': page === currentPage }">
              <a href="#" @click.prevent="changeToPage(page)" class="page-link">{{ page }}</a>
            </li>
            <li :class="{ 'disabled': currentPage === totalPages }">
              <a href="#" @click.prevent="changeToPage(currentPage + 1)" class="page-link">
                <ChevronRight class="h-5 w-5" />
              </a>
            </li>
          </ul>
        </nav>
        <div class="pagination-info">
          共 {{ filteredUniversities.length }} 条记录，每页显示 {{ pageSize }} 条
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import { ChevronLeft, ChevronRight } from 'lucide-vue-next'
import { useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'

const router = useRouter()
const { checkLogin, user, checkLoginStatus } = useAuth()
const API_BASE_URL = 'http://localhost:8080'

const universities = ref([])
const favoriteUniversities = ref([])

const handleNavigate = (to) => {
  if (!checkLogin()) {
    return
  }
  router.push(to)
}

const currentPage = ref(1)
const pageSize = ref(10)
const searchQuery = ref('')
const filterType = ref('')
const filterProvince = ref('')
const filterRegion = ref('')
const filterAB = ref('')
const filterSchoolType = ref('')


const filterTypes = ['', 'C9', '985', '211', '双一流', '双非']
const provinces = ['', '北京', '天津', '河北', '山西', '内蒙古', '辽宁', '吉林', '黑龙江', '上海', '江苏', '浙江', '安徽', '福建', '江西', '山东', '河南', '湖北', '湖南', '广东', '广西', '海南', '重庆', '四川', '贵州', '云南', '西藏', '陕西', '甘肃', '青海', '宁夏', '新疆']
const regions = ['', '华北', '华东', '华中', '华南', '西南', '西北', '东北']
const schoolTypes = ['', '综合类', '理工类', '师范类', '农林类', '医药类', '财经类', '政法类', '语言类', '民族类', '艺术类', '体育类', '其他']

const isLoading = ref(false)
const error = ref(null)

// 搜索查询（延迟搜索）
const searchQueryDebounced = ref('')

// 处理搜索
const handleSearch = () => {
  searchQueryDebounced.value = searchQuery.value
  currentPage.value = 1
}

const fetchUniversities = async () => {
  try {
    isLoading.value = true
    error.value = null
    const response = await fetch(`${API_BASE_URL}/university/list`)
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    const data = await response.json()
    universities.value = data
  } catch (err) {
    console.error('获取院校数据失败:', err)
    error.value = '加载院校数据失败，请稍后重试'
  } finally {
    isLoading.value = false
  }
}

// 获取用户收藏列表
const fetchFavorites = async () => {
  const userId = user.value?.id
  if (!userId) return
  
  try {
    const res = await fetch(`${API_BASE_URL}/user/favorite/${userId}`)
    if (res.ok) {
      const data = await res.json()
      // 清空现有列表
      favoriteUniversities.value = []
      // 添加收藏的院校ID
      data.forEach(uni => favoriteUniversities.value.push(uni.id))
    }
  } catch (e) {
    console.error('获取收藏列表失败:', e)
  }
}

onMounted(() => {
  checkLoginStatus()
  fetchUniversities()
  // 登录后获取收藏列表
  if (user.value?.id) {
    fetchFavorites()
  }
})

// 监听用户登录状态变化
watch(() => user.value?.id, (newUserId) => {
  if (newUserId) {
    fetchFavorites()
  } else {
    favoriteUniversities.value = []
  }
})

// watch(searchQuery, () => {
//   currentPage.value = 1
// })

watch(filterType, () => {
  currentPage.value = 1
})

watch(filterProvince, () => {
  currentPage.value = 1
})

watch(filterRegion, () => {
  currentPage.value = 1
})

watch(filterAB, () => {
  currentPage.value = 1
})

watch(filterSchoolType, () => {
  currentPage.value = 1
})



const UNIVERSITY_TYPE_ORDER = {
  'C9': 0,
  '985': 1,
  '211': 2,
  '双一流': 3,
  '双非': 4
}

// 院校类型样式配置
const UNIVERSITY_TYPE_STYLES = {
  '985': 'background-color: #e53935; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
  '211': 'background-color: #1e88e5; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
  '双一流': 'background-color: #facc15; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
  '双非': 'background-color: #43a047; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;'
}

// 筛选和排序后的院校列表
const filteredUniversities = computed(() => {
  let result = [...universities.value]
  
  // 搜索过滤
  if (searchQueryDebounced.value) {
    const query = searchQueryDebounced.value.toLowerCase()
    result = result.filter(university => 
      university.name.toLowerCase().includes(query)
    )
  }
  
  // 层次过滤
  if (filterType.value) {
    result = result.filter(university => 
      university.level === filterType.value
    )
  }
  
  // 省份过滤
  if (filterProvince.value) {
    result = result.filter(university => 
      university.province === filterProvince.value
    )
  }
  
  // 地区过滤
  if (filterRegion.value) {
    result = result.filter(university => 
      university.region === filterRegion.value
    )
  }
  
  // A/B区过滤
  if (filterAB.value) {
    result = result.filter(university => 
      university.AB === filterAB.value
    )
  }
  
  // 院校类型过滤
  if (filterSchoolType.value) {
    result = result.filter(university => 
      university.type === filterSchoolType.value
    )
  }
  
  // 默认按名称排序
  result.sort((a, b) => {
    return a.name.localeCompare(b.name, 'zh-CN')
  })
  
  return result
})

// 总页数
const totalPages = computed(() => {
  return Math.ceil(filteredUniversities.value.length / pageSize.value)
})

// 当前页显示的院校列表
const displayedUniversities = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filteredUniversities.value.slice(start, end)
})

// 切换页码
const changeToPage = (page) => {
  if (page >= 1 && page <= totalPages.value) {
    isLoading.value = true
    // 模拟加载延迟，提升用户体验
    setTimeout(() => {
      currentPage.value = page
      window.scrollTo({ top: 0, behavior: 'smooth' })
      isLoading.value = false
    }, 200)
  }
}

// 获取院校层次样式（985/211/双一流/双非）
const getUniversityTypeStyle = (type) => {
  const typeStyles = {
    'C9': 'background-color:#dc2626;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    '985': 'background-color:#f97316;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    '211': 'background-color:#2563eb;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    '双一流': 'background-color:#facc15;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    '双非': 'background-color:#16a34a;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px'
  }
  return typeStyles[type] || typeStyles['双非']
}

// 获取院校类型样式（综合类/理工类/师范类等）
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

// 获取A/B区样式
const getABStyle = (ab) => {
  const abStyles = {
    'A区': 'background-color:#3b82f6;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    'B区': 'background-color:#22c55e;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px'
  }
  return abStyles[ab] || ''
}

// 检查院校是否为收藏
const isFavoriteUniversity = (id) => {
  return favoriteUniversities.value.includes(id)
}

// 切换院校收藏状态
const toggleFavoriteStatus = async (id) => {
  console.log('点击收藏按钮，院校ID:', id)
  console.log('用户状态:', user.value)
  
  if (!checkLogin()) {
    console.log('未登录，跳转到登录页面')
    return
  }
  
  const isFav = favoriteUniversities.value.includes(id)
  const url = isFav 
    ? `${API_BASE_URL}/user/favorite/remove`
    : `${API_BASE_URL}/user/favorite/add`
  
  console.log('操作类型:', isFav ? '取消收藏' : '添加收藏')
  console.log('请求URL:', url)
  
  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        userId: user.value.id,
        universityId: id
      })
    })
    
    console.log('响应状态:', response.status)
    const data = await response.json()
    console.log('响应数据:', data)
    
    if (data.success) {
      console.log('操作成功，更新收藏列表')
      const index = favoriteUniversities.value.indexOf(id)
      if (index > -1) {
        // 使用新数组确保响应式更新
        favoriteUniversities.value = favoriteUniversities.value.filter(item => item !== id)
      } else {
        // 使用新数组确保响应式更新
        favoriteUniversities.value = [...favoriteUniversities.value, id]
      }
      console.log('更新后的收藏列表:', favoriteUniversities.value)
    } else {
      console.log('操作失败:', data.message)
      // 修复：当后端返回"已收藏"时，自动添加到收藏列表
      if (data.message.includes('已收藏') && !isFav) {
        console.log('后端提示已收藏，自动添加到前端收藏列表')
        if (!favoriteUniversities.value.includes(id)) {
          // 使用新数组确保响应式更新
          favoriteUniversities.value = [...favoriteUniversities.value, id]
          console.log('更新后的收藏列表:', favoriteUniversities.value)
        }
      }
    }
  } catch (error) {
    console.error('网络请求失败:', error)
  }
}
</script>

<style scoped>
/* 搜索和筛选容器 */
.search-filter-container {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  margin-bottom: 1rem;
  padding: 1.25rem;
}

.search-filter-container:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

/* 搜索行 */
.search-row {
  margin-bottom: 1.5rem;
}

.search-row {
  display: flex;
  gap: 0.75rem;
  align-items: center;
}

.search-row input {
  flex: 1;
  max-width: 400px;
  padding: 0.65rem 1rem;
  border-radius: 0.75rem;
  border: 2px solid var(--border-color);
  font-size: 1rem;
  transition: all 0.3s ease;
  height: 36px;
  box-sizing: border-box;
}

.search-row input:focus {
  outline: none;
  border-color: var(--primary-color);
}

/* 筛选组 */
.filter-group {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  padding-bottom: 0.75rem;
  border-bottom: 1px solid #e5e7eb;
}

.filter-group:last-child {
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

.filter-label {
  font-weight: 500;
  color: var(--text-primary);
  min-width: 80px;
  font-size: 0.9rem;
}

.filter-tag {
  padding: 0.25rem 0.75rem;
  border-radius: 4px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: all 0.2s ease;
  color: #606266;
  border: 1px solid transparent;
}

.filter-tag:hover {
  color: var(--primary-color);
  background-color: #f0f7ff;
}

.filter-tag.active {
  color: white;
  background-color: var(--primary-color);
  border-color: var(--primary-color);
}



/* 表格容器 */
.table-responsive {
  overflow-x: auto;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  background-color: white;
  margin-bottom: 2rem;
}

.table {
  width: 100%;
  background-color: white;
  border-radius: 16px;
  overflow: hidden;
  border-collapse: separate;
  border-spacing: 0;
}

.table thead th {
  background-color: var(--primary-color);
  color: white;
  font-weight: 600;
  text-align: center;
  padding: 1rem;
  border-bottom: 2px solid var(--primary-dark);
  position: sticky;
  top: 0;
  z-index: 10;
}

.table tbody tr {
  border-bottom: 1px solid var(--border-color);
  transition: all 0.3s ease;
}

.table tbody tr:last-child {
  border-bottom: none;
}

.table tbody tr:hover {
  background-color: rgba(30, 58, 138, 0.05);
  transform: translateX(4px);
}

.table tbody td {
  padding: 1rem;
  text-align: center;
  vertical-align: middle;
}

/* 按钮样式 */




/* 按钮容器样式 */
.table tbody td > div {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}

/* 分页样式 */
.pagination-container {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  margin-top: 2.5rem;
  padding: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.pagination-container:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

/* 分页信息 */
.pagination-info {
  font-size: 1rem;
  color: var(--text-secondary);
}

.pagination {
  display: flex;
  list-style: none;
  padding: 0;
  margin: 0;
  gap: 8px;
}

.page-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border: 1px solid var(--border-color);
  border-radius: 8px;
  color: var(--text-primary);
  text-decoration: none;
  transition: all 0.3s ease;
  font-size: 0.875rem;
  font-weight: 500;
}

.page-link:hover {
  background-color: var(--primary-color);
  color: white;
  border-color: var(--primary-color);
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(30, 58, 138, 0.3);
}

.pagination .active .page-link {
  background-color: var(--primary-color);
  color: white;
  border-color: var(--primary-color);
  box-shadow: 0 4px 12px rgba(30, 58, 138, 0.3);
}

.pagination .disabled .page-link {
  background-color: #f8f9fa;
  color: #6c757d;
  border-color: #dee2e6;
  pointer-events: none;
}

/* 空状态 */
.empty-state {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.empty-state:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .table {
    font-size: 0.875rem;
  }
  
  .table thead th {
    padding: 0.75rem;
  }
  
  .table tbody td {
    padding: 0.75rem;
  }
}

@media (max-width: 768px) {
  .search-filter-container {
    padding: 1rem;
  }
  
  .search-filter-container .flex {
    flex-direction: column;
    align-items: stretch;
  }
  
  .search-filter-container .flex-1 {
    width: 100%;
  }
  
  .search-filter-container select {
    width: 100%;
  }
  
  .table {
    font-size: 0.75rem;
  }
  
  .table thead th {
    padding: 0.5rem;
  }
  
  .table tbody td {
    padding: 0.5rem;
  }
  
  .btn-primary {
    font-size: 0.75rem;
    padding: 6px 12px;
  }
  
  .pagination-container {
    flex-direction: column;
    gap: 16px;
    align-items: center;
  }
  
  .pagination {
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .pagination-info {
    text-align: center;
  }
  
  .page-link {
    width: 36px;
    height: 36px;
    font-size: 0.75rem;
  }
}

@media (max-width: 480px) {
  .table thead {
    font-size: 0.625rem;
  }
  
  .table tbody {
    font-size: 0.625rem;
  }
  
  .btn-primary {
    font-size: 0.625rem;
    padding: 4px 8px;
  }
  
  .btn-favorite {
    width: 28px;
    height: 28px;
    padding: 6px;
  }
  
  .Heart {
    width: 14px;
    height: 14px;
  }
}
</style>