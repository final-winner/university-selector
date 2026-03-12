<template>
  <div class="recommend">
    <div class="container">
      <h1 class="page-title">智能推荐</h1>
      <div class="recommend-section">
        <div class="recommend-form">
          <h2>填写您的信息</h2>
          <div class="form-row">
            <div class="form-group">
              <label>预估总分 <span class="required">*</span></label>
              <input
                type="number"
                v-model="formData.score"
                placeholder="请输入预估考研分数（0-500）"
                min="0"
                max="500"
                required
                style="width: 100%; padding: 14px 18px; border: 2px solid #e6f0ff; border-radius: 12px; font-size: 1rem; transition: all 0.3s ease; background: white; color: #1a365d; outline: none;"
                onfocus="this.style.borderColor = 'var(--primary-color)'; this.style.boxShadow = '0 0 0 3px rgba(30, 58, 138, 0.1)';"
                onblur="this.style.borderColor = '#e6f0ff'; this.style.boxShadow = 'none';"
              />
            </div>
            <div class="form-group">
              <label>意向专业<span class="required">*</span></label>
              <select v-model="formData.subjectCategory" required style="width: 100%; padding: 14px 18px; border: 2px solid #e6f0ff; border-radius: 12px; font-size: 1rem; transition: all 0.3s ease; background: white; color: #1a365d; outline: none;" onfocus="this.style.borderColor = 'var(--primary-color)'; this.style.boxShadow = '0 0 0 3px rgba(30, 58, 138, 0.1)';" onblur="this.style.borderColor = '#e6f0ff'; this.style.boxShadow = 'none';">
                <option value="">请选择</option>
                <option value="0812">计算机科学与技术</option>
                <option value="0835">软件工程</option>
                <option value="0839">网络空间安全</option>
                <option value="0854">电子信息</option>
              </select>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label>学硕/专硕 <span class="required">*</span></label>
              <select v-model="formData.degreeType" required style="width: 100%; padding: 14px 18px; border: 2px solid #e6f0ff; border-radius: 12px; font-size: 1rem; transition: all 0.3s ease; background: white; color: #1a365d; outline: none;" onfocus="this.style.borderColor = 'var(--primary-color)'; this.style.boxShadow = '0 0 0 3px rgba(30, 58, 138, 0.1)';" onblur="this.style.borderColor = '#e6f0ff'; this.style.boxShadow = 'none';">
                <option value="">请选择</option>
                <option value="academic">学硕</option>
                <option value="professional">专硕</option>
              </select>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label>意向地区</label>
              <select v-model="formData.targetRegion" style="width: 100%; padding: 14px 18px; border: 2px solid #e6f0ff; border-radius: 12px; font-size: 1rem; transition: all 0.3s ease; background: white; color: #1a365d; outline: none;" onfocus="this.style.borderColor = 'var(--primary-color)'; this.style.boxShadow = '0 0 0 3px rgba(30, 58, 138, 0.1)';" onblur="this.style.borderColor = '#e6f0ff'; this.style.boxShadow = 'none';">
                <option value="">请选择</option>
                <option value="华北">华北</option>
                <option value="华东">华东</option>
                <option value="华南">华南</option>
                <option value="华中">华中</option>
                <option value="西北">西北</option>
                <option value="西南">西南</option>
                <option value="东北">东北</option>
                <option value="custom">自定义省份</option>
              </select>
            </div>
            <div class="form-group" v-if="formData.targetRegion === 'custom'">
              <label>自定义省份</label>
              <input
                type="text"
                v-model="formData.customRegion"
                placeholder="请输入省份名称"
                style="width: 100%; padding: 14px 18px; border: 2px solid #e6f0ff; border-radius: 12px; font-size: 1rem; transition: all 0.3s ease; background: white; color: #1a365d; outline: none;"
                onfocus="this.style.borderColor = 'var(--primary-color)'; this.style.boxShadow = '0 0 0 3px rgba(30, 58, 138, 0.1)';"
                onblur="this.style.borderColor = '#e6f0ff'; this.style.boxShadow = 'none';"
              />
            </div>
          </div>
          <div class="form-group">
            <label>偏好筛选</label>
            <div class="filter-group">
              <div class="filter-item">
                <input type="checkbox" id="985" value="985" v-model="formData.universityLevel">
                <label for="985">985</label>
              </div>
              <div class="filter-item">
                <input type="checkbox" id="211" value="211" v-model="formData.universityLevel">
                <label for="211">211</label>
              </div>
              <div class="filter-item">
                <input type="checkbox" id="doubleTop" value="双一流" v-model="formData.universityLevel">
                <label for="doubleTop">双一流</label>
              </div>
              <div class="filter-item">
                <input type="checkbox" id="doubleNon" value="双非" v-model="formData.universityLevel">
                <label for="doubleNon">双非</label>
              </div>
            </div>
          </div>
          <button class="btn btn-primary recommend-btn" @click="getRecommendations">获取推荐</button>
        </div>

        <div class="recommend-result" v-if="showResult">
          <h2>推荐院校</h2>
          
          <!-- 冲 - 冲刺院校 -->
          <div class="recommend-category">
            <h3 class="category-title-sprint">冲刺院校</h3>
            <div class="schools-grid">
              <div v-for="uni in sprintSchools" :key="uni.id" class="university-card sprint-card">
                <div class="card-header">
                  <h4 class="school-name">{{ uni.name }}</h4>
                  <span class="school-tag sprint-tag">冲</span>
                </div>
                <div class="card-body">
                  <div class="school-info">
                    <p><strong>地区：</strong>{{ uni.location }}</p>
                    <p><strong>类型：</strong>{{ uni.type }}</p>
                    <p><strong>学科评估：</strong>{{ uni.level }}</p>
                    <p><strong>匹配度：</strong><span class="match-rate">{{ uni.matchRate }}%</span></p>
                  </div>
                  <p class="school-reason">{{ uni.reason }}</p>
                </div>
                <div class="card-footer">
                  <router-link :to="`/university-detail/${uni.id}`" class="btn btn-primary">查看详情</router-link>
                  <button class="btn btn-favorite" @click="toggleFavorite(uni.id)" :class="isFavorite(uni.id) ? 'active' : ''">
                    <span :class="isFavorite(uni.id) ? 'text-red-500' : 'text-gray-300'" style="font-size: 16px;">
                      {{ isFavorite(uni.id) ? '❤' : '♡' }}
                    </span>
                  </button>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 稳 - 稳妥院校 -->
          <div class="recommend-category">
            <h3 class="category-title-safe">稳妥院校</h3>
            <div class="schools-grid">
              <div v-for="uni in safeSchools" :key="uni.id" class="university-card safe-card">
                <div class="card-header">
                  <h4 class="school-name">{{ uni.name }}</h4>
                  <span class="school-tag safe-tag">稳</span>
                </div>
                <div class="card-body">
                  <div class="school-info">
                    <p><strong>地区：</strong>{{ uni.location }}</p>
                    <p><strong>类型：</strong>{{ uni.type }}</p>
                    <p><strong>学科评估：</strong>{{ uni.level }}</p>
                    <p><strong>匹配度：</strong><span class="match-rate">{{ uni.matchRate }}%</span></p>
                  </div>
                  <p class="school-reason">{{ uni.reason }}</p>
                </div>
                <div class="card-footer">
                  <router-link :to="`/university-detail/${uni.id}`" class="btn btn-primary">查看详情</router-link>
                  <button class="btn btn-favorite" @click="toggleFavorite(uni.id)" :class="isFavorite(uni.id) ? 'active' : ''">
                    <span :class="isFavorite(uni.id) ? 'text-red-500' : 'text-gray-300'" style="font-size: 16px;">
                      {{ isFavorite(uni.id) ? '❤' : '♡' }}
                    </span>
                  </button>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 保 - 保底院校 -->
          <div class="recommend-category">
            <h3 class="category-title-backup">保底院校</h3>
            <div class="schools-grid">
              <div v-for="uni in backupSchools" :key="uni.id" class="university-card backup-card">
                <div class="card-header">
                  <h4 class="school-name">{{ uni.name }}</h4>
                  <span class="school-tag backup-tag">保</span>
                </div>
                <div class="card-body">
                  <div class="school-info">
                    <p><strong>地区：</strong>{{ uni.location }}</p>
                    <p><strong>类型：</strong>{{ uni.type }}</p>
                    <p><strong>学科评估：</strong>{{ uni.level }}</p>
                    <p><strong>匹配度：</strong><span class="match-rate">{{ uni.matchRate }}%</span></p>
                  </div>
                  <p class="school-reason">{{ uni.reason }}</p>
                </div>
                <div class="card-footer">
                  <router-link :to="`/university-detail/${uni.id}`" class="btn btn-primary">查看详情</router-link>
                  <button class="btn btn-favorite" @click="toggleFavorite(uni.id)" :class="isFavorite(uni.id) ? 'active' : ''">
                    <span :class="isFavorite(uni.id) ? 'text-red-500' : 'text-gray-300'" style="font-size: 16px;">
                      {{ isFavorite(uni.id) ? '❤' : '♡' }}
                    </span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { useAuth } from '@/composables/useAuth'

const API_BASE_URL = 'http://localhost:8080'

export default {
  name: 'Recommend',
  components: {
  },
  setup() {
    const { checkLogin, user, checkLoginStatus } = useAuth()
    checkLoginStatus()
    const formData = ref({
      score: '',
      subjectCategory: '',
      degreeType: '',
      targetRegion: '',
      customRegion: '',
      universityLevel: []
    })
    const showResult = ref(false)
    const sprintSchools = ref([])
    const safeSchools = ref([])
    const backupSchools = ref([])
    const favorites = ref([])

    const getRecommendations = () => {
      // 验证必填项
      if (!formData.value.score || !formData.value.subjectCategory || !formData.value.degreeType) {
        window.$showToast({
          title: '提示',
          message: '请填写所有必填项！',
          type: 'warning'
        });
        return;
      }
      
      showResult.value = true
      const score = parseInt(formData.value.score) || 0
      
      // 模拟院校数据
      const allSchools = [
        // 冲刺院校（高分）
        { id: 1, name: '北京大学', location: '北京', type: '985', level: 'A+', requiredScore: 400, reason: '国内顶尖名校，计算机专业实力最强' },
        { id: 2, name: '清华大学', location: '北京', type: '985', level: 'A+', requiredScore: 395, reason: '计算机专业排名第一，就业前景极佳' },
        { id: 3, name: '浙江大学', location: '浙江', type: '985', level: 'A+', requiredScore: 390, reason: '综合实力强，计算机专业全国前三' },
        
        // 稳妥院校（中等分数）
        { id: 4, name: '上海交通大学', location: '上海', type: '985', level: 'A', requiredScore: 375, reason: '地理位置优越，计算机专业实力强' },
        { id: 5, name: '中国科学技术大学', location: '安徽', type: '985', level: 'A', requiredScore: 370, reason: '科研实力强，计算机专业性价比高' },
        { id: 6, name: '哈尔滨工业大学', location: '黑龙江', type: '985', level: 'A', requiredScore: 365, reason: '计算机专业传统强校，实力稳定' },
        { id: 10, name: '复旦大学', location: '上海', type: '985', level: 'A', requiredScore: 372, reason: '综合性大学，计算机专业发展迅速' },
        { id: 11, name: '南京大学', location: '江苏', type: '985', level: 'A', requiredScore: 368, reason: '计算机专业历史悠久，实力雄厚' },
        
        // 保底院校（较低分数）
        { id: 7, name: '北京邮电大学', location: '北京', type: '211', level: 'A-', requiredScore: 350, reason: '信息类专业强校，就业前景好' },
        { id: 8, name: '西安电子科技大学', location: '陕西', type: '211', level: 'A-', requiredScore: 345, reason: '电子信息领域强校，计算机专业实力不错' },
        { id: 9, name: '南京航空航天大学', location: '江苏', type: '211', level: 'B+', requiredScore: 340, reason: '综合实力强，计算机专业发展迅速' }
      ]
      
      // 地区映射
      const regionMap = {
        '华北': ['北京', '天津', '河北', '山西', '内蒙古'],
        '华东': ['上海', '江苏', '浙江', '安徽', '福建', '江西', '山东'],
        '华南': ['广东', '广西', '海南'],
        '华中': ['河南', '湖北', '湖南'],
        '西北': ['陕西', '甘肃', '青海', '宁夏', '新疆'],
        '西南': ['重庆', '四川', '贵州', '云南', '西藏'],
        '东北': ['辽宁', '吉林', '黑龙江']
      }
      
      // 根据筛选条件过滤院校
      let filteredSchools = [...allSchools]
      
      // 意向地区筛选
      if (formData.value.targetRegion) {
        if (formData.value.targetRegion === 'custom' && formData.value.customRegion) {
          // 自定义省份筛选
          const customRegion = formData.value.customRegion
          filteredSchools = filteredSchools.filter(school => 
            school.location.includes(customRegion)
          )
        } else if (formData.value.targetRegion !== 'custom') {
          // 地区筛选
          const regions = regionMap[formData.value.targetRegion] || []
          filteredSchools = filteredSchools.filter(school => 
            regions.includes(school.location)
          )
        }
      }
      
      // 院校层次筛选
      if (formData.value.universityLevel && formData.value.universityLevel.length > 0) {
        filteredSchools = filteredSchools.filter(school => 
          formData.value.universityLevel.includes(school.type)
        )
      }
      
      // 分类院校
      sprintSchools.value = filteredSchools.filter(school => school.requiredScore > score + 10).slice(0, 3)
      safeSchools.value = filteredSchools.filter(school => school.requiredScore >= score - 10 && school.requiredScore <= score + 10).slice(0, 5)
      backupSchools.value = filteredSchools.filter(school => school.requiredScore < score - 10).slice(0, 3)
      
      // 计算匹配度
      sprintSchools.value.forEach(school => {
        school.matchRate = Math.max(60, 100 - (school.requiredScore - score) * 2)
      })
      
      safeSchools.value.forEach(school => {
        school.matchRate = Math.max(70, 85 - Math.abs(school.requiredScore - score))
      })
      
      backupSchools.value.forEach(school => {
        school.matchRate = Math.max(80, 95 - (score - school.requiredScore))
      })
    }

    const isFavorite = (id) => {
      return favorites.value.includes(id)
    }

    const toggleFavorite = async (id) => {
      if (!checkLogin()) {
        return
      }
      const isFav = favorites.value.includes(id)
      const url = isFav 
        ? `${API_BASE_URL}/user/favorite/remove`
        : `${API_BASE_URL}/user/favorite/add`
      
      try {
        const response = await fetch(url, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            userId: user.value.id,
            universityId: id
          })
        })
        const data = await response.json()
        if (data.success) {
          const index = favorites.value.indexOf(id)
          if (index > -1) {
            // 使用新数组确保响应式更新
            favorites.value = favorites.value.filter(item => item !== id)
          } else {
            // 使用新数组确保响应式更新
            favorites.value = [...favorites.value, id]
          }
        } else {
          // 修复：当后端返回"已收藏"时，自动添加到收藏列表
          if (data.message.includes('已收藏') && !isFav) {
            if (!favorites.value.includes(id)) {
              // 使用新数组确保响应式更新
              favorites.value = [...favorites.value, id]
            }
          }
        }
      } catch (error) {
        console.error('操作失败:', error)
      }
    }

    return {
      formData,
      showResult,
      sprintSchools,
      safeSchools,
      backupSchools,
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

.recommend-category {
  margin-bottom: 40px;
}

.category-title-sprint {
  font-size: 1.25rem;
  font-weight: 600;
  color: #ef4444;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #ef4444;
}

.category-title-safe {
  font-size: 1.25rem;
  font-weight: 600;
  color: #3b82f6;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #3b82f6;
}

.category-title-backup {
  font-size: 1.25rem;
  font-weight: 600;
  color: #10b981;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #10b981;
}

.schools-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.school-tag {
  position: absolute;
  top: 20px;
  right: 20px;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 600;
  color: white;
}

.sprint-tag {
  background-color: #ef4444;
}

.safe-tag {
  background-color: #3b82f6;
}

.backup-tag {
  background-color: #10b981;
}

.school-info {
  margin-bottom: 16px;
}

.match-rate {
  font-weight: 600;
  color: var(--primary-color);
}

.school-reason {
  font-size: 0.9rem;
  color: #6b7280;
  line-height: 1.5;
  margin: 0;
  margin-top: 12px;
}

/* 冲稳保卡片样式 */
.university-card.sprint-card::before {
  background-color: #ef4444;
}

.university-card.safe-card::before {
  background-color: #3b82f6;
}

.university-card.backup-card::before {
  background-color: #10b981;
}

.university-card .school-name {
  margin: 0;
  font-size: 1.2rem;
  font-weight: 700;
  font-family: 'Microsoft YaHei', 'PingFang SC', sans-serif;
  padding-left: 12px;
  color: var(--primary-color);
}

.university-card .card-header {
  background-color: white;
  color: var(--text-primary);
  font-weight: bold;
  padding: 20px 24px;
  position: relative;
  border-bottom: none;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.university-card .card-body {
  padding: 20px 24px;
  background-color: white;
}

.university-card .card-body p {
  margin-bottom: 8px;
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.5;
  display: flex;
  align-items: center;
}

.university-card .card-footer {
  background-color: white;
  padding: 16px 24px;
  border-top: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 0 0 12px 12px;
}

.university-card .card-footer .btn {
  border-radius: 6px;
  padding: 8px 16px;
  font-size: 0.85rem;
  font-weight: 500;
  transition: all 0.3s ease;
}

.university-card .card-footer .btn-primary {
  background-color: var(--primary-color);
  border: none;
  box-shadow: 0 2px 8px rgba(59, 130, 246, 0.2);
  color: white;
}

.recommend-btn {
  border-radius: 8px;
  padding: 12px 32px;
  font-weight: 600;
  transition: all 0.3s ease;
  width: 100%;
}

.required {
  color: #ef4444;
  font-weight: bold;
  margin-left: 4px;
}

.filter-group {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  margin-top: 10px;
}

.filter-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 1rem;
  color: var(--text-primary);
}

.filter-item input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: var(--primary-color);
  cursor: pointer;
}

.filter-item label {
  margin: 0;
  cursor: pointer;
  font-weight: 400;
  transition: color 0.2s ease;
}

.filter-item label:hover {
  color: var(--primary-color);
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

  .schools-grid {
    grid-template-columns: 1fr;
  }

  .school-card {
    margin-bottom: 20px;
  }

  .btn {
    padding: 10px 24px;
  }

  .school-footer {
    flex-direction: column;
    align-items: stretch;
  }

  .school-footer .btn {
    margin-right: 0;
    margin-bottom: 10px;
  }

  .school-footer .btn:last-child {
    margin-bottom: 0;
  }
}
</style>