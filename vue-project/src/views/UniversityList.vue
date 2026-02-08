<template>
  <div class="university-list">
    <div class="container py-10">
      <h1 class="page-title text-center text-3xl font-bold text-primary mb-16">院校列表</h1>
      
      <!-- 搜索和筛选区域 -->
      <div class="search-filter-container mb-8 bg-white p-6 rounded-xl shadow-sm">
        <div class="flex flex-wrap gap-4 items-center justify-between">
          <div class="flex-1 min-w-[300px]">
            <input 
              v-model="searchQuery" 
              type="text" 
              placeholder="搜索院校名称..." 
              class="w-full px-4 py-3 rounded-lg border border-border-color focus:outline-none focus:ring-2 focus:ring-primary-light focus:border-transparent transition-all"
            />
          </div>
          <div class="flex gap-4">
            <select v-model="filterType" class="px-4 py-3 rounded-lg border border-border-color focus:outline-none focus:ring-2 focus:ring-primary-light focus:border-transparent transition-all">
              <option value="">所有类型</option>
              <option value="985">985</option>
              <option value="211">211</option>
              <option value="双一流">双一流</option>
              <option value="双非">双非</option>
            </select>
            <select v-model="sortBy" class="px-4 py-3 rounded-lg border border-border-color focus:outline-none focus:ring-2 focus:ring-primary-light focus:border-transparent transition-all">
              <option value="name">按名称排序</option>
              <option value="type">按类型排序</option>
              <option value="location">按地区排序</option>
            </select>
          </div>
        </div>
      </div>
      
      <!-- 表格区域 -->
      <div class="table-responsive">
        <table class="table table-hover w-full">
          <thead>
            <tr class="bg-primary text-white">
              <th class="px-6 py-4 font-bold text-lg text-center">院校名称</th>
              <th class="px-6 py-4 font-bold text-lg text-center">类型</th>
              <th class="px-6 py-4 font-bold text-lg text-center">地区</th>
              <th class="px-6 py-4 font-bold text-lg text-center">分区</th>
              <th class="px-6 py-4 font-bold text-lg text-center">学科评估</th>
              <th class="px-6 py-4 font-bold text-lg text-center">操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="university in displayedUniversities" :key="university.id" class="hover:bg-light transition-all duration-200">
              <td class="px-6 py-5 font-semibold text-lg text-primary text-center">{{ university.name }}</td>
              <td class="px-6 py-5 text-center"><span class="badge" :style="getUniversityTypeStyle(university.type)">{{ university.type }}</span></td>
              <td class="px-6 py-5 text-lg text-text-primary text-center">{{ university.location }}</td>
              <td class="px-6 py-5 text-lg text-text-primary text-center">{{ university.region }}</td>
              <td class="px-6 py-5 text-lg text-text-primary text-center">{{ university.level }}</td>
              <td class="px-6 py-5 text-center">
                <div class="flex justify-center items-center gap-3">
                  <router-link :to="`/university-detail/${university.id}`" class="btn btn-primary hover:shadow-lg transform hover:-translate-y-1 transition-all">查看详情</router-link>
                  <button class="btn btn-favorite hover:shadow-lg transform hover:-translate-y-1 transition-all" @click="toggleFavoriteStatus(university.id)">
                    <Heart :class="isFavoriteUniversity(university.id) ? 'fill-current text-red-500' : 'text-text-secondary'" class="h-4 w-4" />
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
      <div v-if="filteredUniversities.length > 0" class="pagination-container d-flex justify-content-between align-items-center mt-8 p-5 bg-white rounded-xl shadow-sm">
        <nav aria-label="Page navigation">
          <ul class="pagination">
            <li :class="{ 'disabled': currentPage === 1 }">
              <a href="#" @click.prevent="changeToPage(currentPage - 1)" class="page-link">
                <ChevronLeft class="h-4 w-4" />
              </a>
            </li>
            <li v-for="page in totalPages" :key="page" :class="{ 'active': page === currentPage }">
              <a href="#" @click.prevent="changeToPage(page)" class="page-link">{{ page }}</a>
            </li>
            <li :class="{ 'disabled': currentPage === totalPages }">
              <a href="#" @click.prevent="changeToPage(currentPage + 1)" class="page-link">
                <ChevronRight class="h-4 w-4" />
              </a>
            </li>
          </ul>
        </nav>
        <div class="pagination-info text-text-secondary text-sm">
          共 {{ filteredUniversities.length }} 条记录，每页显示 {{ pageSize }} 条
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { Heart, ChevronLeft, ChevronRight } from 'lucide-vue-next'

// 院校数据
const universities = ref([
  {
    id: 1,
    name: '北京大学',
    type: '985',
    location: '北京',
    region: 'A区',
    level: 'A+'
  },
  {
    id: 2,
    name: '清华大学',
    type: '985',
    location: '北京',
    region: 'A区',
    level: 'A+'
  },
  {
    id: 3,
    name: '浙江大学',
    type: '985',
    location: '浙江',
    region: 'A区',
    level: 'A+'
  },
  {
    id: 4,
    name: '复旦大学',
    type: '985',
    location: '上海',
    region: 'A区',
    level: 'A'
  },
  {
    id: 5,
    name: '上海交通大学',
    type: '985',
    location: '上海',
    region: 'A区',
    level: 'A'
  },
  {
    id: 6,
    name: '南京大学',
    type: '985',
    location: '江苏',
    region: 'A区',
    level: 'A'
  },
  {
    id: 7,
    name: '武汉大学',
    type: '985',
    location: '湖北',
    region: 'A区',
    level: 'A'
  },
  {
    id: 8,
    name: '华中科技大学',
    type: '985',
    location: '湖北',
    region: 'A区',
    level: 'A'
  },
  {
    id: 9,
    name: '中山大学',
    type: '985',
    location: '广东',
    region: 'A区',
    level: 'A'
  },
  {
    id: 10,
    name: '西安交通大学',
    type: '985',
    location: '陕西',
    region: 'A区',
    level: 'A'
  },
  {
    id: 11,
    name: '哈尔滨工业大学',
    type: '985',
    location: '黑龙江',
    region: 'A区',
    level: 'A'
  },
  {
    id: 12,
    name: '北京航空航天大学',
    type: '985',
    location: '北京',
    region: 'A区',
    level: 'A'
  }
])

// 响应式数据
const favoriteUniversities = ref([])
const currentPage = ref(1)
const pageSize = ref(10)
const searchQuery = ref('')
const filterType = ref('')
const sortBy = ref('name')
const isLoading = ref(false)

// 防抖定时器
let debounceTimer = null

// 监听搜索词变化，实现防抖
watch(searchQuery, (newQuery) => {
  clearTimeout(debounceTimer)
  debounceTimer = setTimeout(() => {
    currentPage.value = 1 // 搜索时重置到第一页
  }, 300)
})

// 监听筛选条件变化，重置页码
watch(filterType, () => {
  currentPage.value = 1
})

// 监听排序条件变化，重置页码
watch(sortBy, () => {
  currentPage.value = 1
})

// 院校类型排序权重
const UNIVERSITY_TYPE_ORDER = {
  '985': 1,
  '211': 2,
  '双一流': 3,
  '双非': 4
}

// 院校类型样式配置
const UNIVERSITY_TYPE_STYLES = {
  '985': 'background-color: #e53935; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
  '211': 'background-color: #1e88e5; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
  '双一流': 'background-color: #f57c00; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
  '双非': 'background-color: #43a047; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;'
}

// 筛选和排序后的院校列表
const filteredUniversities = computed(() => {
  let result = [...universities.value]
  
  // 搜索过滤
  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    result = result.filter(university => 
      university.name.toLowerCase().includes(query)
    )
  }
  
  // 类型过滤
  if (filterType.value) {
    result = result.filter(university => 
      university.type === filterType.value
    )
  }
  
  // 排序
  result.sort((a, b) => {
    if (sortBy.value === 'name') {
      return a.name.localeCompare(b.name, 'zh-CN')
    } else if (sortBy.value === 'type') {
      return UNIVERSITY_TYPE_ORDER[a.type] - UNIVERSITY_TYPE_ORDER[b.type]
    } else if (sortBy.value === 'location') {
      return a.location.localeCompare(b.location, 'zh-CN')
    }
    return 0
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

// 获取院校类型样式
const getUniversityTypeStyle = (type) => {
  return UNIVERSITY_TYPE_STYLES[type] || UNIVERSITY_TYPE_STYLES['双非']
}

// 检查院校是否为收藏
const isFavoriteUniversity = (id) => {
  return favoriteUniversities.value.includes(id)
}

// 切换院校收藏状态
const toggleFavoriteStatus = (id) => {
  const index = favoriteUniversities.value.indexOf(id)
  if (index > -1) {
    favoriteUniversities.value.splice(index, 1)
  } else {
    favoriteUniversities.value.push(id)
  }
}
</script>

<style scoped>
/* 主题颜色变量 */
:root {
  --primary-color: #1E3A8A;
  --primary-light: #3B82F6;
  --primary-dark: #1E3A8A;
  --secondary-color: #F97316;
  --text-primary: #1f2937;
  --text-secondary: #6b7280;
  --text-light: #9ca3af;
  --border-color: #e5e7eb;
  --bg-color: #f9fafb;
}

/* 文本样式 */
.text-primary {
  color: var(--primary-color);
}

.bg-primary {
  background-color: var(--primary-color);
}

.text-text-primary {
  color: var(--text-primary);
}

.text-text-secondary {
  color: var(--text-secondary);
}

.text-text-light {
  color: var(--text-light);
}

.border-border-color {
  border-color: var(--border-color);
}

.bg-light {
  background-color: rgba(30, 58, 138, 0.05);
}

/* 搜索和筛选容器 */
.search-filter-container {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.search-filter-container:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
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
.btn-primary {
  background: linear-gradient(135deg, var(--secondary-color), #e86208);
  color: white;
  border: none;
  border-radius: 6px;
  padding: 8px 16px;
  font-weight: 500;
  font-size: 0.75rem;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(249, 115, 22, 0.2);
}

.btn-primary:hover {
  background: linear-gradient(135deg, #ff8a3c, var(--secondary-color));
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(249, 115, 22, 0.3);
}

.btn-favorite {
  background-color: white;
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
  border-radius: 6px;
  padding: 8px;
  width: 32px;
  height: 32px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.btn-favorite:hover {
  background-color: var(--border-color);
  color: var(--text-primary);
  border-color: var(--primary-light);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(249, 115, 22, 0.2);
}

/* 分页样式 */
.pagination-container {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.pagination-container:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
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