<template>
  <div class="recommend">
    <div class="container">
      <h1 class="page-title">智能推荐</h1>
      <div class="recommend-section">
        <div class="recommend-form">
          <h2>填写您的信息</h2>
          <div class="form-row">
            <div class="form-group">
              <label>本科院校类型</label>
              <select v-model="formData.undergraduateType" class="w-full p-4 border-2 border-border-color rounded-lg focus:outline-none focus:border-primary transition-colors">
                <option value="">请选择</option>
                <option value="985">985院校</option>
                <option value="211">211院校</option>
                <option value="double-first-class">双一流院校</option>
                <option value="ordinary">双非院校</option>
              </select>
            </div>
            <div class="form-group">
              <label>目标地区</label>
              <select v-model="formData.targetRegion" class="w-full p-4 border-2 border-border-color rounded-lg focus:outline-none focus:border-primary transition-colors">
                <option value="">请选择</option>
                <option value="A区">A区</option>
                <option value="B区">B区</option>
              </select>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label>目标院校类型</label>
              <select v-model="formData.targetType" class="w-full p-4 border-2 border-border-color rounded-lg focus:outline-none focus:border-primary transition-colors">
                <option value="">请选择</option>
                <option value="985">985院校</option>
                <option value="211">211院校</option>
                <option value="double-first-class">双一流院校</option>
                <option value="ordinary">双非院校</option>
              </select>
            </div>
            <div class="form-group">
              <label>专业方向</label>
              <select v-model="formData.major" class="w-full p-4 border-2 border-border-color rounded-lg focus:outline-none focus:border-primary transition-colors">
                <option value="">请选择</option>
                <option value="cs">计算机科学与技术</option>
                <option value="se">软件工程</option>
                <option value="ai">人工智能</option>
                <option value="bigdata">大数据</option>
              </select>
            </div>
          </div>
          <button class="btn btn-primary recommend-btn" @click="getRecommendations">获取推荐</button>
        </div>

        <div class="recommend-result" v-if="showResult">
          <h2>推荐院校</h2>
          <div class="recommend-table">
            <table class="table">
              <thead>
                <tr>
                  <th>院校名称</th>
                  <th>地区</th>
                  <th>类型</th>
                  <th>学科评估</th>
                  <th>匹配度</th>
                  <th>推荐理由</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="uni in recommendations" :key="uni.id">
                  <td class="font-semibold text-primary">{{ uni.name }}</td>
                  <td>{{ uni.location }}</td>
                  <td>{{ uni.type }}</td>
                  <td>{{ uni.level }}</td>
                  <td>{{ uni.matchRate }}%</td>
                  <td>{{ uni.reason }}</td>
                  <td>
                    <router-link :to="`/university-detail/${uni.id}`" class="btn btn-primary btn-sm mr-2">查看详情</router-link>
                    <button class="btn btn-outline-secondary btn-sm" @click="toggleFavorite(uni.id)">
                      <Heart :class="isFavorite(uni.id) ? 'fill-current text-red-500' : 'text-text-secondary'" class="h-4 w-4" />
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { Heart } from 'lucide-vue-next'

export default {
  name: 'Recommend',
  components: {
    Heart
  },
  setup() {
    const formData = ref({
      undergraduateType: '',
      targetRegion: '',
      targetType: '',
      major: ''
    })
    const showResult = ref(false)
    const recommendations = ref([])
    const favorites = ref([])

    const getRecommendations = () => {
      showResult.value = true
      recommendations.value = [
        {
          id: 1,
          name: '北京大学',
          location: '北京',
          type: '985',
          level: 'A+',
          matchRate: 95,
          reason: '根据您的条件，该校在专业实力和地理位置上都非常匹配'
        },
        {
          id: 2,
          name: '清华大学',
          location: '北京',
          type: '985',
          level: 'A+',
          matchRate: 92,
          reason: '该校计算机专业实力强劲，符合您的专业方向'
        },
        {
          id: 3,
          name: '浙江大学',
          location: '浙江',
          type: '985',
          level: 'A+',
          matchRate: 88,
          reason: '该校综合实力强，计算机专业排名靠前'
        }
      ]
    }

    const isFavorite = (id) => {
      return favorites.value.includes(id)
    }

    const toggleFavorite = (id) => {
      const index = favorites.value.indexOf(id)
      if (index > -1) {
        favorites.value.splice(index, 1)
      } else {
        favorites.value.push(id)
      }
    }

    return {
      formData,
      showResult,
      recommendations,
      favorites,
      getRecommendations,
      isFavorite,
      toggleFavorite
    }
  }
}
</script>

<style scoped>
.page-title {
  text-align: center;
  font-size: 2rem;
  font-weight: bold;
  color: var(--primary-color);
  margin-bottom: 40px;
}

.recommend-section {
  max-width: 1200px;
  margin: 0 auto;
}

.recommend-form {
  background-color: white;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  margin-bottom: 40px;
}

.recommend-form h2 {
  font-size: 1.5rem;
  font-weight: bold;
  color: var(--primary-color);
  margin-bottom: 30px;
  text-align: center;
}

.form-row {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

.form-group {
  flex: 1;
}

.form-group label {
  display: block;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 10px;
}

.form-group select {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid var(--border-color);
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-group select:focus {
  outline: none;
  border-color: var(--primary-color);
}

.recommend-result {
  background-color: white;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.recommend-result h2 {
  font-size: 1.5rem;
  font-weight: bold;
  color: var(--primary-color);
  margin-bottom: 30px;
  text-align: center;
}

.recommend-table {
  overflow-x: auto;
}

.table {
  margin-bottom: 0;
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
}

.table thead th {
  background-color: var(--primary-color);
  color: white;
  font-weight: 600;
  border: none;
  padding: 16px;
  text-align: left;
}

.table tbody td {
  padding: 16px;
  color: var(--text-secondary);
  vertical-align: middle;
  border-bottom: 1px solid var(--border-color);
}

.table tbody tr:hover {
  background-color: var(--bg-color);
}

.recommend-btn {
  border-radius: 8px;
  padding: 12px 32px;
  font-weight: 600;
  transition: all 0.3s ease;
  width: 100%;
}

.btn-outline-secondary {
  background-color: transparent;
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
  border-radius: 8px;
  padding: 8px 12px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.btn-outline-secondary:hover {
  background-color: var(--border-color);
  color: var(--text-primary);
  border-color: var(--primary-light);
  transform: translateY(-1px);
}

.btn-sm {
  font-size: 0.75rem;
  padding: 6px 12px;
}

.mr-2 {
  margin-right: 8px;
}

.text-primary {
  color: var(--primary-color);
}

@media (max-width: 768px) {
  .form-row {
    flex-direction: column;
  }

  .recommend-form,
  .recommend-result {
    padding: 20px;
  }

  .table thead th,
  .table tbody td {
    padding: 12px;
  }

  .btn {
    padding: 10px 24px;
  }
}
</style>