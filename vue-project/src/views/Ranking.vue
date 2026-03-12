<template>
  <div class="ranking-container">
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-3xl font-bold mb-6 text-center text-primary">热门院校</h1>
      
      <div class="ranking-list">
        <div 
          v-for="(university, index) in universities" 
          :key="university.id" 
          class="ranking-item"
        >
          <div class="rank-number" :class="getRankClass(index)">
            {{ index + 1 }}
          </div>
          <div class="university-info">
            <h3 class="university-name">{{ university.name }}</h3>
            <div class="university-details">
              <span class="collection-num">收藏量: {{ university.collectionNum }}</span>
              <span :style="getBadgeStyle(university.level)">{{ university.level }}</span>
              <span :style="getSchoolTypeStyle(university.type)">{{ university.type }}</span>
              <span class="university-province">{{ university.province }}</span>
            </div>
          </div>
          <router-link :to="`/university-detail/${university.id}`" class="view-detail">
            查看详情
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { getHotUniversities } from '@/utils/api'

export default {
  name: 'Ranking',
  setup() {
    const universities = ref([])
    const loading = ref(true)

    const fetchHotUniversities = async () => {
      try {
        loading.value = true
        const response = await getHotUniversities()
        universities.value = response
      } catch (error) {
        console.error('Failed to fetch hot universities:', error)
      } finally {
        loading.value = false
      }
    }

    const getRankClass = (index) => {
      if (index === 0) return 'rank-1'
      if (index === 1) return 'rank-2'
      if (index === 2) return 'rank-3'
      return ''
    }

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

    onMounted(() => {
      fetchHotUniversities()
    })

    return {
      universities,
      loading,
      getRankClass,
      getBadgeStyle,
      getSchoolTypeStyle
    }
  }
}
</script>

<style scoped>
.ranking-container {
  min-height: 80vh;
  background-color: var(--bg-color);
  padding-top: 2rem;
}

.ranking-list {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.ranking-item {
  display: flex;
  align-items: center;
  padding: 1.5rem;
  border-bottom: 1px solid var(--border-color);
  transition: background-color 0.2s;
}

.ranking-item:hover {
  background-color: #f9fafb;
}

.rank-number {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
  font-weight: bold;
  margin-right: 1.5rem;
  background-color: var(--border-color);
  color: var(--text-secondary);
}

.rank-1 {
  background-color: #FFD700;
  color: #333;
  font-weight: bold;
}

.rank-2 {
  background-color: #C0C0C0;
  color: #333;
  font-weight: bold;
}

.rank-3 {
  background-color: #CD7F32;
  color: white;
  font-weight: bold;
}

.university-info {
  flex: 1;
}

.university-name {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: var(--text-primary);
}

.university-details {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.view-detail {
  padding: 0.5rem 1rem;
  background-color: var(--primary-color);
  color: white;
  border-radius: 6px;
  text-decoration: none;
  transition: all 0.3s ease;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(59, 130, 246, 0.2);
  min-width: 100px;
  text-align: center;
}

.view-detail:hover {
  background-color: var(--primary-dark);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(59, 130, 246, 0.3);
}

@media (max-width: 768px) {
  .ranking-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .rank-number {
    margin-right: 0;
  }

  .university-details {
    flex-direction: column;
    gap: 0.5rem;
  }

  .view-detail {
    align-self: flex-start;
  }
}
</style>