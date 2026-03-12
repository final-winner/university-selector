<template>
  <div class="admin-correction">
    <div class="container py-10">
      <h1 class="page-title text-center text-3xl font-bold text-primary mb-16">数据纠错管理</h1>
      
      <div class="admin-card">
        <div class="card-header flex justify-between items-center mb-6">
          <h2 class="text-xl font-semibold">待审核纠错信息</h2>
          <div class="flex gap-3">
            <select v-model="filterStatus" class="p-2 border border-border-color rounded-md transition-all focus:outline-none focus:border-primary">
              <option value="pending">待审核</option>
              <option value="approved">已通过</option>
              <option value="rejected">已拒绝</option>
              <option value="all">全部</option>
            </select>
          </div>
        </div>
        
        <div v-if="isLoading" class="text-center py-10">
          <div class="text-gray-400">加载中...</div>
        </div>
        
        <div v-else-if="corrections.length === 0" class="text-center py-10">
          <div class="text-gray-400">暂无纠错信息</div>
        </div>
        
        <div v-else class="overflow-x-auto">
          <table class="w-full border-collapse">
            <thead>
              <tr class="bg-gray-50 border-b">
                <th class="px-4 py-3 text-left text-text-primary font-semibold">ID</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">用户</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">院校</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">纠错类型</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">纠错字段</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">当前值</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">建议值</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">状态</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">提交时间</th>
                <th class="px-4 py-3 text-left text-text-primary font-semibold">操作</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in filteredCorrections" :key="item.id" class="border-b hover:bg-gray-50 transition-colors">
                <td class="px-4 py-3">{{ item.id }}</td>
                <td class="px-4 py-3">{{ item.userName }}</td>
                <td class="px-4 py-3">{{ item.universityName }}</td>
                <td class="px-4 py-3">{{ getTypeLabel(item.type) }}</td>
                <td class="px-4 py-3">{{ item.field }}</td>
                <td class="px-4 py-3">{{ item.currentValue || '-' }}</td>
                <td class="px-4 py-3">{{ item.suggestedValue }}</td>
                <td class="px-4 py-3">
                  <span :class="getStatusClass(item.status)">
                    {{ getStatusLabel(item.status) }}
                  </span>
                </td>
                <td class="px-4 py-3">{{ formatDate(item.submitTime) }}</td>
                <td class="px-4 py-3">
                  <div v-if="item.status === 'pending'" class="flex gap-2">
                    <button type="button" class="btn btn-success text-sm" @click="approveCorrection(item.id)">通过</button>
                    <button type="button" class="btn btn-danger text-sm" @click="rejectCorrection(item.id)">拒绝</button>
                  </div>
                  <div v-else class="text-gray-400">已处理</div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'

const API_BASE_URL = 'http://localhost:8080'

const router = useRouter()
const { checkLogin, user, checkLoginStatus } = useAuth()
const isLoading = ref(false)
const corrections = ref([])
const filterStatus = ref('pending')

// 检查是否为管理员
const isAdmin = computed(() => {
  return user.value && user.value.role === 'admin'
})

// 检查管理员权限
const checkAdminPermission = () => {
  if (!checkLogin()) return false
  console.log('User info:', user.value)
  console.log('Is admin:', isAdmin.value)
  if (!isAdmin.value) {
    alert('您没有管理员权限')
    router.push('/')
    return false
  }
  return true
}

const filteredCorrections = computed(() => {
  if (filterStatus.value === 'all') {
    return corrections.value
  }
  return corrections.value.filter(item => item.status === filterStatus.value)
})

const getTypeLabel = (type) => {
  const labels = {
    'university': '院校信息',
    'department': '院系信息',
    'major': '专业信息',
    'score': '分数信息'
  }
  return labels[type] || type
}

const getStatusLabel = (status) => {
  const labels = {
    'pending': '待审核',
    'approved': '已通过',
    'rejected': '已拒绝'
  }
  return labels[status] || status
}

const getStatusClass = (status) => {
  const classes = {
    'pending': 'status-pending',
    'approved': 'status-approved',
    'rejected': 'status-rejected'
  }
  return classes[status] || ''
}

const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN')
}

const fetchCorrections = async () => {
  if (!checkLogin()) return
  
  try {
    isLoading.value = true
    const url = `${API_BASE_URL}/correction/list`
    const response = await fetch(url)
    const data = await response.json()
    corrections.value = data
  } catch (error) {
    console.error('获取纠错信息失败:', error)
  } finally {
    isLoading.value = false
  }
}

const approveCorrection = async (id) => {
  try {
    const url = `${API_BASE_URL}/correction/approve/${id}`
    const response = await fetch(url, {
      method: 'POST'
    })
    const data = await response.json()
    if (data.success) {
      // 更新本地数据
      const index = corrections.value.findIndex(item => item.id === id)
      if (index !== -1) {
        corrections.value[index].status = 'approved'
      }
    } else {
      alert('操作失败：' + data.message)
    }
  } catch (error) {
    console.error('通过纠错失败:', error)
    alert('操作失败，请稍后重试')
  }
}

const rejectCorrection = async (id) => {
  try {
    const url = `${API_BASE_URL}/correction/reject/${id}`
    const response = await fetch(url, {
      method: 'POST'
    })
    const data = await response.json()
    if (data.success) {
      // 更新本地数据
      const index = corrections.value.findIndex(item => item.id === id)
      if (index !== -1) {
        corrections.value[index].status = 'rejected'
      }
    } else {
      alert('操作失败：' + data.message)
    }
  } catch (error) {
    console.error('拒绝纠错失败:', error)
    alert('操作失败，请稍后重试')
  }
}

onMounted(() => {
  checkLoginStatus()
  // 延迟一下，确保用户信息已加载
  setTimeout(() => {
    if (checkAdminPermission()) {
      fetchCorrections()
    }
  }, 100)
})
</script>

<style scoped>
/* 页面标题 */
.page-title {
  color: var(--primary-color);
  font-weight: 700;
  letter-spacing: 2px;
}

/* 管理卡片 */
.admin-card {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  padding: 1.25rem;
}

.admin-card:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

/* 卡片头部 */
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

/* 按钮样式 */
.btn {
  padding: 0.5rem 1rem;
  border-radius: 0.75rem;
  font-weight: 600;
  transition: all 0.3s ease;
  border: none;
  cursor: pointer;
}

.btn-success {
  background-color: #22c55e;
  color: white;
  box-shadow: 0 2px 8px rgba(34, 197, 94, 0.3);
}

.btn-success:hover {
  background-color: #16a34a;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(34, 197, 94, 0.4);
}

.btn-danger {
  background-color: #ef4444;
  color: white;
  box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
}

.btn-danger:hover {
  background-color: #dc2626;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
}

/* 表格样式 */
table {
  width: 100%;
  border-collapse: collapse;
}

th {
  padding: 0.75rem 1rem;
  text-align: left;
  font-weight: 600;
  color: var(--text-primary);
  background-color: #f9fafb;
  border-bottom: 1px solid #e5e7eb;
}

td {
  padding: 0.75rem 1rem;
  border-bottom: 1px solid #e5e7eb;
  transition: background-color 0.2s ease;
}

tr:hover td {
  background-color: #f9fafb;
}

/* 状态标签 */
.status-pending {
  padding: 0.25rem 0.75rem;
  background-color: #fef3c7;
  color: #92400e;
  border-radius: 0.5rem;
  font-size: 0.875rem;
  font-weight: 600;
}

.status-approved {
  padding: 0.25rem 0.75rem;
  background-color: #d1fae5;
  color: #065f46;
  border-radius: 0.5rem;
  font-size: 0.875rem;
  font-weight: 600;
}

.status-rejected {
  padding: 0.25rem 0.75rem;
  background-color: #fee2e2;
  color: #b91c1c;
  border-radius: 0.5rem;
  font-size: 0.875rem;
  font-weight: 600;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .admin-card {
    padding: 1rem;
  }
  
  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }
  
  table {
    font-size: 0.875rem;
  }
  
  th, td {
    padding: 0.5rem 0.75rem;
  }
}
</style>