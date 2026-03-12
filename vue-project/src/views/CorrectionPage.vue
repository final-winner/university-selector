<template>
  <div class="correction-page">
    <div class="container py-10">
      <div class="action-buttons flex gap-4 mb-8">
        <button type="button" class="btn btn-outline-secondary flex items-center gap-2" @click="goBack">
          <ArrowLeft class="h-4 w-4" /> 返回详情
        </button>
      </div>
      
      <div class="correction-card">
        <h1 class="page-title text-2xl font-bold text-primary mb-6">数据纠错</h1>
        
        <div class="mb-6">
          <h2 class="text-lg font-semibold mb-2">{{ universityName }}</h2>
        </div>
        
        <form @submit.prevent="submitCorrection">
          <div class="form-group mb-4">
            <label class="block text-text-primary mb-2">纠错类型</label>
            <select v-model="correction.type" class="w-full p-2 border border-border-color rounded-md transition-all focus:outline-none focus:border-primary">
              <option value="university">院校信息</option>
              <option value="department">院系信息</option>
              <option value="major">专业信息</option>
              <option value="score">分数信息</option>
            </select>
          </div>
          
          <div class="form-group mb-4">
            <label class="block text-text-primary mb-2">需要纠错的数据名称</label>
            <input v-model="correction.field" type="text" class="w-full p-2 border border-border-color rounded-md transition-all focus:outline-none focus:border-primary" placeholder="请输入需要纠错的字段名称" required>
          </div>
          
          <div class="form-group mb-4">
            <label class="block text-text-primary mb-2">当前值</label>
            <input v-model="correction.currentValue" type="text" class="w-full p-2 border border-border-color rounded-md transition-all focus:outline-none focus:border-primary" placeholder="请输入当前值">
          </div>
          
          <div class="form-group mb-4">
            <label class="block text-text-primary mb-2">建议值</label>
            <input v-model="correction.suggestedValue" type="text" class="w-full p-2 border border-border-color rounded-md transition-all focus:outline-none focus:border-primary" placeholder="请输入建议的正确值" required>
          </div>
          
          <div class="form-group mb-6">
            <label class="block text-text-primary mb-2">备注说明</label>
            <textarea v-model="correction.description" class="w-full p-2 border border-border-color rounded-md transition-all focus:outline-none focus:border-primary" rows="4" placeholder="请输入纠错原因或其他说明"></textarea>
          </div>
          
          <div class="flex justify-end" style="gap: 1rem;">
            <button type="button" class="btn btn-outline-secondary" @click="goBack">取消</button>
            <button type="submit" class="btn btn-primary text-center">提交纠错</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'
import { ArrowLeft } from 'lucide-vue-next'

const API_BASE_URL = 'http://localhost:8080'

const route = useRoute()
const router = useRouter()
const { checkLogin, user } = useAuth()

const universityId = ref(route.params.id)
const universityName = ref('')
const universityInfo = ref('')
const correction = ref({
  type: 'university',
  field: '',
  currentValue: '',
  suggestedValue: '',
  description: ''
})

const fetchUniversityInfo = async () => {
  try {
    const url = `${API_BASE_URL}/university/detail/${universityId.value}`
    const response = await fetch(url)
    const data = await response.json()
    universityName.value = data.name
    universityInfo.value = `${data.type} | ${data.level} | ${data.province} ${data.city}`
  } catch (error) {
    console.error('获取院校信息失败:', error)
  }
}

const submitCorrection = async () => {
  if (!checkLogin()) return
  
  try {
    const url = `${API_BASE_URL}/correction/submit`
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        userId: user.value.id,
        universityId: parseInt(universityId.value),
        type: correction.value.type,
        field: correction.value.field,
        currentValue: correction.value.currentValue,
        suggestedValue: correction.value.suggestedValue,
        description: correction.value.description
      })
    })
    const data = await response.json()
    if (data.success) {
      alert('纠错信息提交成功，等待管理员审核')
      goBack()
    } else {
      alert('提交失败：' + data.message)
    }
  } catch (error) {
    console.error('提交纠错失败:', error)
    alert('提交失败，请稍后重试')
  }
}

const goBack = () => {
  router.back()
}

onMounted(() => {
  fetchUniversityInfo()
})
</script>

<style scoped>
/* 页面标题 */
.page-title {
  color: var(--primary-color);
  font-weight: 700;
  letter-spacing: 1px;
}

/* 纠错卡片 */
.correction-card {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  padding: 1.25rem;
}

.correction-card:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}



/* 表单组 */
.form-group {
  margin-bottom: 1rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 500;
  color: var(--text-primary);
}

.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid var(--border-color);
  border-radius: 0.75rem;
  font-size: 1rem;
  transition: all 0.3s ease;
  box-sizing: border-box;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.1);
}



/* 响应式设计 */
@media (max-width: 768px) {
  .correction-card {
    padding: 1rem;
  }
  
  .form-group input,
  .form-group select,
  .form-group textarea {
    padding: 0.5rem;
  }
  
  .btn {
    padding: 0.5rem 1rem;
    font-size: 0.85rem;
  }
}
</style>