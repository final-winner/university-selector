<template>
  <div class="university-detail">
    <div class="container max-w-6xl mx-auto px-4 py-4">
      <div class="action-buttons flex gap-4 mb-8">
        <button type="button" class="btn-outline-secondary flex items-center gap-2" @click="goBack">
          <ArrowLeft class="h-4 w-4" /> 返回列表
        </button>
        <button type="button" class="btn-outline-secondary flex items-center gap-2" @click="toggleFavorite">
          <Star :class="isFavorited ? 'fill-current text-yellow-500' : 'text-text-secondary'" class="h-4 w-4" /> {{ isFavorited ? '已收藏' : '收藏' }}
        </button>
        <button type="button" class="btn-outline-secondary flex items-center gap-2" @click="goToCorrectionPage">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
          </svg> 数据纠错
        </button>
      </div>



      <div v-if="isLoading" class="text-center py-20">
        <div class="text-gray-400">加载中...</div>
      </div>

      <div v-else-if="university.name">
        <div class="university-header mb-16 text-center">
          <h1 class="text-4xl font-bold text-primary" style="margin-bottom: 10px;">{{ university.name }}</h1>
          <div class="badges flex flex-wrap justify-center" style="margin-bottom: 10px; gap: 10px;">
            <span style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 12px; min-width: 60px; display: inline-block;">{{ university.level }}</span>
            <span style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 12px; min-width: 60px; display: inline-block;">{{ university.AB }}</span>
            <span style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 12px; min-width: 60px; display: inline-block;">{{ university.type }}</span>
            <span style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 12px; min-width: 60px; display: inline-block;">{{ university.region }}</span>
          </div>
          <h3 class="text-xl font-bold text-primary mb-2">院校简介</h3>
          <p class="text-lg text-text-secondary leading-relaxed">{{ university.introduction || '暂无简介' }}</p>
        </div>

        <div class="info-section bg-white p-7 rounded-xl shadow-sm" style="margin-top: 60px;">
          <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">院校基本信息</h2>
          <div class="info-row flex mb-5 leading-relaxed">
            <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校代码：</span>
            <span class="text-text-secondary flex-1">{{ university.code }}</span>
          </div>
          <div class="info-row flex mb-5 leading-relaxed">
            <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校类型：</span>
            <span class="text-text-secondary flex-1">{{ university.type }}</span>
          </div>
          <div class="info-row flex mb-5 leading-relaxed">
            <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校层次：</span>
            <span class="text-text-secondary flex-1">{{ university.level }}</span>
          </div>
          <div class="info-row flex mb-5 leading-relaxed">
            <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">所在省份：</span>
            <span class="text-text-secondary flex-1">{{ university.province }}</span>
          </div>
          <div class="info-row flex mb-5 leading-relaxed">
            <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">所在城市：</span>
            <span class="text-text-secondary flex-1">{{ university.city }}</span>
          </div>
          <div class="info-row flex mb-5 leading-relaxed">
            <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">A/B区：</span>
            <span class="text-text-secondary flex-1">{{ university.AB }}</span>
          </div>
          <div class="info-row flex mb-5 leading-relaxed">
            <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校地区：</span>
            <span class="text-text-secondary flex-1">{{ university.region }}</span>
          </div>
        </div>
        
        <!-- 学院专业数据模块 -->
        <div class="info-section bg-white p-7 rounded-xl shadow-sm" style="margin-top: 60px;">
          <CollegeMajorChart :colleges="colleges" :university-website="university.official_website" />
        </div>
      </div>

      <div v-else class="text-center py-20">
        <div class="text-gray-400">未找到院校信息</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'
import { ArrowLeft, Star } from 'lucide-vue-next'
import CollegeMajorChart from '@/components/CollegeMajorChart.vue'

const API_BASE_URL = 'http://localhost:8080'

const route = useRoute()
const router = useRouter()
const { checkLogin, user, checkLoginStatus } = useAuth()
const isFavorited = ref(false)
const isLoading = ref(false)

const university = ref({
  id: null,
  name: '',
  type: '',
  city: '',
  region: '',
  AB: '',
  level: '',
  code: '',
  province: '',
  introduction: '',
  official_website: '',
  graduate_school_website: ''
})

// 学院专业数据
const colleges = ref([])



// 从后端API获取学院专业数据
const fetchCollegeData = async () => {
  const universityId = route.params.id
  if (!universityId) return
  
  try {
    isLoading.value = true
    const url = `${API_BASE_URL}/university/colleges/${universityId}`
    const response = await fetch(url)
    if (response.ok) {
      const data = await response.json()
      colleges.value = data
    } else {
      console.error('获取学院数据失败:', response.statusText)
      // 保留模拟数据作为 fallback
      colleges.value = [
        {
          collegeId: "001",
          collegeName: "计算机学院",
          introduction: "计算机学院是学校重点建设的学院之一，拥有强大的师资力量和完善的教学设施。",
          majorList: [
            {
              majorId: "00101",
              majorName: "计算机科学与技术",
              scoreData: [
                {"year": 2023, "reexamScore": 365, "avgScore": 378},
                {"year": 2024, "reexamScore": 372, "avgScore": 385},
                {"year": 2025, "reexamScore": 378, "avgScore": 390}
              ]
            },
            {
              majorId: "00102",
              majorName: "软件工程",
              scoreData: [
                {"year": 2023, "reexamScore": 358, "avgScore": 370},
                {"year": 2024, "reexamScore": 365, "avgScore": 375},
                {"year": 2025, "reexamScore": 370, "avgScore": 380}
              ]
            }
          ]
        },
        {
          collegeId: "002",
          collegeName: "电子信息学院",
          introduction: "电子信息学院致力于培养电子信息领域的高素质专业人才。",
          majorList: [
            {
              majorId: "00201",
              majorName: "电子信息工程",
              scoreData: [
                {"year": 2023, "reexamScore": 350, "avgScore": 362},
                {"year": 2024, "reexamScore": 355, "avgScore": 368},
                {"year": 2025, "reexamScore": 360, "avgScore": 372}
              ]
            },
            {
              majorId: "00202",
              majorName: "通信工程",
              scoreData: [
                {"year": 2023, "reexamScore": 345, "avgScore": 358},
                {"year": 2024, "reexamScore": 350, "avgScore": 362},
                {"year": 2025, "reexamScore": 355, "avgScore": 365}
              ]
            }
          ]
        }
      ]
    }
  } catch (error) {
    console.error('获取学院数据失败:', error)
    // 保留模拟数据作为 fallback
    colleges.value = [
      {
        collegeId: "001",
        collegeName: "计算机学院",
        introduction: "计算机学院是学校重点建设的学院之一，拥有强大的师资力量和完善的教学设施。",
        majorList: [
          {
            majorId: "00101",
            majorName: "计算机科学与技术",
            scoreData: [
              {"year": 2023, "reexamScore": 365, "avgScore": 378},
              {"year": 2024, "reexamScore": 372, "avgScore": 385},
              {"year": 2025, "reexamScore": 378, "avgScore": 390}
            ]
          },
          {
            majorId: "00102",
            majorName: "软件工程",
            scoreData: [
              {"year": 2023, "reexamScore": 358, "avgScore": 370},
              {"year": 2024, "reexamScore": 365, "avgScore": 375},
              {"year": 2025, "reexamScore": 370, "avgScore": 380}
            ]
          }
        ]
      },
      {
        collegeId: "002",
        collegeName: "电子信息学院",
        introduction: "电子信息学院致力于培养电子信息领域的高素质专业人才。",
        majorList: [
          {
            majorId: "00201",
            majorName: "电子信息工程",
            scoreData: [
              {"year": 2023, "reexamScore": 350, "avgScore": 362},
              {"year": 2024, "reexamScore": 355, "avgScore": 368},
              {"year": 2025, "reexamScore": 360, "avgScore": 372}
            ]
          },
          {
            majorId: "00202",
            majorName: "通信工程",
            scoreData: [
              {"year": 2023, "reexamScore": 345, "avgScore": 358},
              {"year": 2024, "reexamScore": 350, "avgScore": 362},
              {"year": 2025, "reexamScore": 355, "avgScore": 365}
            ]
          }
        ]
      }
    ]
  } finally {
    isLoading.value = false
  }
}

const fetchUniversityById = async () => {
  const id = route.params.id
  if (!id) return
  
  try {
    isLoading.value = true
    const url = `${API_BASE_URL}/university/detail/${id}`
    const response = await fetch(url)
    const data = await response.json()
    university.value = data
  } catch (error) {
    console.error('获取院校详情失败:', error)
  } finally {
    isLoading.value = false
  }
}

const checkFavoriteStatus = async () => {
  const userId = user.value?.id
  const universityId = route.params.id
  if (!userId || !universityId) return
  
  try {
    const res = await fetch(`${API_BASE_URL}/user/favorite/check?userId=${userId}&universityId=${universityId}`)
    const data = await res.json()
    isFavorited.value = data.isFavorite || false
  } catch (e) {
    console.error('获取收藏状态失败:', e)
  }
}

const getUniversityTypeStyle = (level) => {
  const styles = {
    '985': 'background-color:#dc2626;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    '211': 'background-color:#2563eb;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    '双一流': 'background-color:#facc15;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    '双非': 'background-color:#16a34a;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px'
  }
  return styles[level] || styles['双非']
}

const getABStyle = (ab) => {
  const styles = {
    'A区': 'background-color:#3b82f6;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px',
    'B区': 'background-color:#22c55e;color:#fff;padding:2px 8px;border-radius:12px;font-weight:600;font-size:12px'
  }
  return styles[ab] || ''
}

const getSchoolTypeStyle = (type) => {
  const styles = {
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
  return styles[type] || styles['其他']
}

const goBack = () => {
  router.back()
}

// 跳转到数据纠错页面
const goToCorrectionPage = () => {
  if (!checkLogin()) return
  router.push(`/correction/${route.params.id}`)
}

const toggleFavorite = async () => {
  if (!checkLogin()) return
  
  const universityId = route.params.id
  const url = isFavorited.value 
    ? `${API_BASE_URL}/user/favorite/remove`
    : `${API_BASE_URL}/user/favorite/add`
  
  try {
    const res = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ userId: user.value.id, universityId: +universityId })
    })
    const data = await res.json()
    if (data.success) {
      // 直接更新响应式数据
      isFavorited.value = !isFavorited.value
      
      // 实时更新收藏量
      if (university.value && university.value.collectionNum !== undefined) {
        university.value = {
          ...university.value,
          collectionNum: isFavorited.value 
            ? university.value.collectionNum + 1 
            : Math.max(0, university.value.collectionNum - 1)
        }
      }
    } else {
      // 修复：当后端返回"已收藏"时，自动设置为已收藏状态
      if (data.message.includes('已收藏') && !isFavorited.value) {
        isFavorited.value = true
      }
    }
  } catch (e) {
    console.error('操作失败:', e)
  }
}

// 获取用户收藏列表
const fetchFavorites = async () => {
  const userId = user.value?.id
  if (!userId) return
  
  try {
    const res = await fetch(`${API_BASE_URL}/user/favorites/${userId}`)
    if (res.ok) {
      const data = await res.json()
      // 检查当前院校是否在收藏列表中
      const currentUniversityId = parseInt(route.params.id)
      const isFavorite = data.some(uni => uni.id === currentUniversityId)
      // 直接更新响应式数据
      isFavorited.value = isFavorite
    }
  } catch (e) {
    console.error('获取收藏列表失败:', e)
  }
}

onMounted(() => {
  checkLoginStatus()
  fetchUniversityById()
  fetchCollegeData()
  if (user.value?.id) {
    checkFavoriteStatus()
  }
})

// 监听用户登录状态变化
watch(() => user.value?.id, (newUserId) => {
  if (newUserId) {
    checkFavoriteStatus()
  } else {
    isFavorited.value = false
  }
})
</script>

<style scoped>
.btn-outline-secondary {
  background-color: transparent;
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
  border-radius: 6px;
  padding: 8px 16px;
  font-size: 0.85rem;
  font-weight: 500;
  transition: all 0.3s ease;
}

.btn-outline-secondary:hover {
  background-color: var(--border-color);
  color: var(--text-primary);
  border-color: var(--primary-light);
  transform: translateY(-1px);
}

.text-primary {
  color: var(--primary-color);
}

.bg-white {
  background-color: white;
}
</style>
