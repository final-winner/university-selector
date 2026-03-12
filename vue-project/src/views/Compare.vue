<template>
  <div class="compare">
    <div class="container">
      <h1 class="page-title">院校对比</h1>
      
      <!-- 选择对比院校表单 -->
      <div class="compare-form">
        <h2>选择对比院校</h2>
        <div class="form-row">
          <div class="form-group">
            <label>院校1</label>
            <div class="autocomplete-wrapper">
              <input 
                v-model="compareData.university1" 
                type="text" 
                placeholder="输入院校名称（如：北京大学）"
                class="form-input"
                @input="handleInput('university1', $event)"
                @blur="hideDropdown('university1')"
                @focus="showDropdown('university1')"
              />
              <div v-if="showDropdowns.university1 && filteredUniversities.university1.length > 0" class="autocomplete-dropdown">
                <div 
                  v-for="uni in filteredUniversities.university1.slice(0, 5)" 
                  :key="uni.id"
                  class="dropdown-item"
                  @mousedown="selectUniversity('university1', uni.name)"
                >
                  {{ uni.name }}
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label>院校2</label>
            <div class="autocomplete-wrapper">
              <input 
                v-model="compareData.university2" 
                type="text" 
                placeholder="输入院校名称（如：清华大学）"
                class="form-input"
                @input="handleInput('university2', $event)"
                @blur="hideDropdown('university2')"
                @focus="showDropdown('university2')"
              />
              <div v-if="showDropdowns.university2 && filteredUniversities.university2.length > 0" class="autocomplete-dropdown">
                <div 
                  v-for="uni in filteredUniversities.university2.slice(0, 5)" 
                  :key="uni.id"
                  class="dropdown-item"
                  @mousedown="selectUniversity('university2', uni.name)"
                >
                  {{ uni.name }}
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label>专业</label>
            <select v-model="compareData.majorId" class="form-input">
              <option value="">请选择专业</option>
              <option v-for="major in availableMajors" :key="major.id" :value="major.id">
                {{ major.name }} ({{ major.code }})
              </option>
            </select>
          </div>
        </div>
        
        <!-- 热门院校快速选择 -->
        <div class="hot-universities">
          <h3>热门院校</h3>
          <div class="hot-university-tags">
            <span 
              v-for="uni in hotUniversities.slice(0, 10)" 
              :key="uni.id"
              class="hot-university-tag"
              @click="selectHotUniversity(uni.name)"
            >
              {{ uni.name }}
            </span>
          </div>
        </div>
        
        <button class="btn btn-primary" @click="compare">开始对比</button>
      </div>

      <!-- 对比结果 -->
      <div class="compare-result" v-if="showResult && uni1 && uni2">
        <!-- 顶部横向对比卡片栏 -->
        <div class="compare-cards">
          <!-- 院校1卡片 -->
          <div class="compare-card">
            <div class="card-header">
              <h3 class="university-name">{{ uni1.name }}</h3>
              <div class="level-tags">
                <span v-if="uni1.level && uni1.level.includes('985')" class="level-tag tag-985">985</span>
                <span v-if="uni1.level && uni1.level.includes('211')" class="level-tag tag-211">211</span>
                <span v-if="uni1.level && uni1.level.includes('C9')" class="level-tag tag-c9">C9</span>
              </div>
            </div>
            <div class="card-body">
              <div class="score-info">
                <span class="score-label">最新复试线</span>
                <span class="score-value">{{ uni1.latestRetestScore || '暂无数据' }}</span>
              </div>

              <div class="difficulty-info">
                <span class="difficulty-label">难度评分</span>
                <div class="difficulty-score">
                  <span class="score-number">{{ uni1.difficultyScore || '5.0' }}</span>
                  <div class="stars">
                    <span v-for="i in 10" :key="i" :class="['star', { 'filled': i <= (uni1.difficultyScore || 5) }]">
                      ★
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 院校2卡片 -->
          <div class="compare-card">
            <div class="card-header">
              <h3 class="university-name">{{ uni2.name }}</h3>
              <div class="level-tags">
                <span v-if="uni2.level && uni2.level.includes('985')" class="level-tag tag-985">985</span>
                <span v-if="uni2.level && uni2.level.includes('211')" class="level-tag tag-211">211</span>
                <span v-if="uni2.level && uni2.level.includes('C9')" class="level-tag tag-c9">C9</span>
              </div>
            </div>
            <div class="card-body">
              <div class="score-info">
                <span class="score-label">最新复试线</span>
                <span class="score-value">{{ uni2.latestRetestScore || '暂无数据' }}</span>
              </div>

              <div class="difficulty-info">
                <span class="difficulty-label">难度评分</span>
                <div class="difficulty-score">
                  <span class="score-number">{{ uni2.difficultyScore || '5.0' }}</span>
                  <div class="stars">
                    <span v-for="i in 10" :key="i" :class="['star', { 'filled': i <= (uni2.difficultyScore || 5) }]">
                      ★
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <!-- 合并后的大对比表格 -->
        <div class="comparison-module">
          <h3 class="module-title">院校对比详情</h3>
          <div class="module-table">
            <table class="table">
              <thead>
                <tr class="bg-primary text-white">
                  <th class="compare-item">对比项</th>
                  <th class="compare-value">{{ uni1.name }}</th>
                  <th class="compare-value">{{ uni2.name }}</th>
                </tr>
              </thead>
              <tbody>
                <!-- 基础信息分组 -->
                <tr class="group-header">
                  <td colspan="3">基础信息</td>
                </tr>
                <tr>
                  <td class="compare-item">院校类型</td>
                  <td class="compare-value">{{ uni1.type || '无数据' }}</td>
                  <td class="compare-value">{{ uni2.type || '无数据' }}</td>
                </tr>
                <tr>
                  <td class="compare-item">省份</td>
                  <td class="compare-value">{{ uni1.province || '无数据' }}</td>
                  <td class="compare-value">{{ uni2.province || '无数据' }}</td>
                </tr>
                <tr>
                  <td class="compare-item">城市</td>
                  <td class="compare-value">{{ uni1.city || '无数据' }}</td>
                  <td class="compare-value">{{ uni2.city || '无数据' }}</td>
                </tr>
                <tr>
                  <td class="compare-item">A/B区</td>
                  <td class="compare-value">{{ uni1.AB || '无数据' }}</td>
                  <td class="compare-value">{{ uni2.AB || '无数据' }}</td>
                </tr>
                <tr>
                  <td class="compare-item">院校层次</td>
                  <td class="compare-value">{{ uni1.level || '无数据' }}</td>
                  <td class="compare-value">{{ uni2.level || '无数据' }}</td>
                </tr>
                
                <!-- 考研核心数据分组 -->
                <tr class="group-header">
                  <td colspan="3">考研核心数据</td>
                </tr>
                <tr>
                  <td class="compare-item">最新复试线</td>
                  <td class="compare-value score">{{ uni1.latestRetestScore || '暂无数据' }}</td>
                  <td class="compare-value score">{{ uni2.latestRetestScore || '暂无数据' }}</td>
                </tr>
                <tr>
                  <td class="compare-item">近3年复试线涨幅</td>
                  <td class="compare-value trend">{{ uni1.retestScoreTrendDescription || '暂无数据' }}</td>
                  <td class="compare-value trend">{{ uni2.retestScoreTrendDescription || '暂无数据' }}</td>
                </tr>
                <tr>
                  <td class="compare-item">招生人数（统考）</td>
                  <td class="compare-value">{{ uni1.enrollmentNum || '暂无数据' }}</td>
                  <td class="compare-value">{{ uni2.enrollmentNum || '暂无数据' }}</td>
                </tr>
                
                <!-- 学科资源分组 -->
                <tr class="group-header">
                  <td colspan="3">学科资源</td>
                </tr>
                <tr>
                  <td class="compare-item">学科评估等级</td>
                  <td class="compare-value">{{ uni1.subjectRating || '暂无公开数据' }}</td>
                  <td class="compare-value">{{ uni2.subjectRating || '暂无公开数据' }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        
        <!-- 底部智能结论区 -->
        <div class="intelligent-conclusion">
          <h3 class="conclusion-title">智能对比结论</h3>
          <div class="conclusion-content">
            <p>{{ intelligentConclusion }}</p>
          </div>
          <div class="action-buttons">
            <button class="btn btn-primary" @click="exportPDF">导出PDF对比报告</button>
            <button class="btn btn-outline" @click="resetComparison">重新对比</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue'

export default {
  name: 'Compare',
  setup() {
    const compareData = ref({
      university1: '',
      university2: '',
      majorId: ''
    })
    
    // 自动完成功能相关数据
    const allUniversities = ref([]) // 存储所有院校数据
    const filteredUniversities = ref({
      university1: [],
      university2: []
    }) // 存储过滤后的院校列表
    const showDropdowns = ref({
      university1: false,
      university2: false
    }) // 控制下拉列表显示状态
    
    const availableMajors = ref([])
    const showResult = ref(false)
    const uni1 = ref({
      latestRetestScore: 380,
      retestScoreTrend: '+5%',
      enrollmentNum: 150,
      difficultyScore: 8.5,
      subjectRating: 'A+'
    })
    const uni2 = ref({
      latestRetestScore: 365,
      retestScoreTrend: '-2%',
      enrollmentNum: 120,
      difficultyScore: 7.8,
      subjectRating: 'A'
    })
    const hotUniversities = ref([])
    const isLoading = ref(false)
    const API_BASE_URL = 'http://localhost:8080'

    // 智能结论计算属性
    const intelligentConclusion = computed(() => {
      if (!uni1.value || !uni2.value) return ''
      
      // 提取关键数据（带默认值）
      const aScore = uni1.value.latestRetestScore || 0
      const bScore = uni2.value.latestRetestScore || 0
      const aTrend = uni1.value.retestScoreTrendDescription || ''
      const bTrend = uni2.value.retestScoreTrendDescription || ''
      const aLevel = uni1.value.level || ''
      const bLevel = uni2.value.level || ''
      const aProvince = uni1.value.province || ''
      const bProvince = uni2.value.province || ''
      const aRating = uni1.value.subjectRating || ''
      const bRating = uni2.value.subjectRating || ''
      
      // 比较逻辑（确保所有引用的属性都存在）
      try {
        if (aScore > bScore + 20 && aTrend && aTrend.includes('+')) {
          return `${uni1.value.name}复试线更高且呈上升趋势，竞争更激烈；${uni2.value.name}难度相对适中，可优先考虑。`
        } else if (aLevel && bLevel && aLevel === bLevel && aProvince && bProvince && aProvince === bProvince) {
          return `${uni1.value.name}和${uni2.value.name}同属${aLevel}院校且位于同一省份，可结合学科评估等级和个人偏好选择。`
        } else if (aRating && bRating && aRating > bRating) {
          return `${uni1.value.name}学科评估等级${aRating}高于${uni2.value.name}的${bRating}，学术实力更强，建议优先选择。`
        } else {
          return `${uni1.value.name}和${uni2.value.name}各有优势，建议结合复试线、招生人数和个人学科兴趣综合判断。`
        }
      } catch (error) {
        // 如果出现任何错误，返回一个通用结论
        return `${uni1.value.name}和${uni2.value.name}各有特点，建议结合自身情况进行选择。`
      }
    })

    const fetchUniversities = async () => {
      try {
        isLoading.value = true
        const response = await fetch(`${API_BASE_URL}/university/list`)
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        const data = await response.json()
        universities.value = data
      } catch (err) {
        console.error('获取院校数据失败:', err)
        window.$showToast({
          title: '错误',
          message: '获取院校数据失败，请稍后重试',
          type: 'error'
        })
      } finally {
        isLoading.value = false
      }
    }

    const fetchHotUniversities = async () => {
      try {
        const response = await fetch(`${API_BASE_URL}/university/hot`)
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        const data = await response.json()
        hotUniversities.value = data
      } catch (err) {
        console.error('获取热门院校数据失败:', err)
      }
    }
    
    // 获取所有院校数据（用于自动完成）
    const fetchAllUniversities = async () => {
      try {
        const response = await fetch(`${API_BASE_URL}/university/list`)
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        const data = await response.json()
        allUniversities.value = data
      } catch (err) {
        console.error('获取所有院校失败:', err)
      }
    }

    const fetchAvailableMajors = async () => {
      try {
        // 从后端获取真实专业数据
        const response = await fetch(`${API_BASE_URL}/university/majors`)
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        const data = await response.json()
        availableMajors.value = data
      } catch (err) {
        console.error('获取专业列表失败:', err)
        // 错误时使用默认专业列表
        availableMajors.value = [
          { id: 14, name: '计算机科学与技术', code: '081200' },
          { id: 2, name: '计算机技术', code: '085404' },
          { id: 3, name: '人工智能', code: '085410' }
        ]
      }
    }

    const selectHotUniversity = (universityName) => {
      if (!compareData.value.university1) {
        compareData.value.university1 = universityName
      } else if (!compareData.value.university2) {
        compareData.value.university2 = universityName
      } else {
        // 如果两个输入框都有值，替换第一个
        compareData.value.university1 = compareData.value.university2
        compareData.value.university2 = universityName
      }
    }

    const searchUniversity = async (name) => {
      try {
        const response = await fetch(`${API_BASE_URL}/university/search?name=${encodeURIComponent(name)}`)
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        return await response.json()
      } catch (err) {
        console.error('搜索院校失败:', err)
        return []
      }
    }
    
    // 处理输入事件，过滤院校列表
    const handleInput = (field, event) => {
      const inputValue = event.target.value.toLowerCase().trim()
      if (inputValue.length === 0) {
        filteredUniversities.value[field] = []
        showDropdowns.value[field] = true
        return
      }
      
      // 在所有院校中过滤匹配的结果
      filteredUniversities.value[field] = allUniversities.value.filter(uni => 
        uni.name.toLowerCase().includes(inputValue)
      )
      
      showDropdowns.value[field] = true
    }
    
    // 显示下拉列表
    const showDropdown = (field) => {
      const inputValue = compareData.value[field].toLowerCase().trim()
      if (inputValue.length > 0) {
        filteredUniversities.value[field] = allUniversities.value.filter(uni => 
          uni.name.toLowerCase().includes(inputValue)
        )
      }
      showDropdowns.value[field] = true
    }
    
    // 隐藏下拉列表
    const hideDropdown = (field) => {
      // 添加延迟，以便点击下拉项时能先触发mousedown事件
      setTimeout(() => {
        showDropdowns.value[field] = false
      }, 200)
    }
    
    // 选择院校
    const selectUniversity = (field, universityName) => {
      compareData.value[field] = universityName
      showDropdowns.value[field] = false
    }
    
    // 检查院校是否开设了指定专业
    const checkUniversityMajorExists = async (universityId, majorName, majorCode) => {
      try {
        const response = await fetch(`${API_BASE_URL}/university/check-major?universityId=${universityId}&majorName=${encodeURIComponent(majorName)}&majorCode=${encodeURIComponent(majorCode)}`)
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        return await response.json()
      } catch (err) {
        console.error('检查专业是否存在失败:', err)
        return false
      }
    }

    // 生成模拟的复试线趋势数据
    const generateMockTrendData = () => {
      const baseScore = Math.floor(Math.random() * 50) + 320
      return [
        { year: '2023', score: baseScore + Math.floor(Math.random() * 10) },
        { year: '2024', score: baseScore + Math.floor(Math.random() * 15) },
        { year: '2025', score: baseScore + Math.floor(Math.random() * 20) }
      ]
    }



    const compare = async () => {
      if (compareData.value.university1 && compareData.value.university2 && compareData.value.majorId) {
        isLoading.value = true
        try {
          const [results1, results2] = await Promise.all([
            searchUniversity(compareData.value.university1),
            searchUniversity(compareData.value.university2)
          ])
          
          if (results1.length > 0 && results2.length > 0) {
            // 检查两所学校是否相同
            if (results1[0].id === results2[0].id) {
              window.$showToast({
                title: '提示',
                message: '两所学校不能相同，请选择不同的学校进行对比！',
                type: 'warning'
              })
            } else {
              // 检查所选专业在两所院校中是否都存在
              const universityId1 = results1[0].id
              const universityId2 = results2[0].id
              const majorId = compareData.value.majorId
              
              // 获取当前选择的专业对象，提取名称和代码
              const selectedMajor = availableMajors.value.find(m => m.id == majorId)
              if (!selectedMajor) {
                window.$showToast({
                  title: '提示',
                  message: '请选择有效的专业！',
                  type: 'warning'
                })
                return
              }
              
              const majorName = selectedMajor.name
              const majorCode = selectedMajor.code
              
              // 并行检查两所院校的专业是否存在
              const [checkResult1, checkResult2] = await Promise.all([
                checkUniversityMajorExists(universityId1, majorName, majorCode),
                checkUniversityMajorExists(universityId2, majorName, majorCode)
              ])
              
              if (!checkResult1 && !checkResult2) {
                window.$showToast({
                  title: '提示',
                  message: `两所院校均未开设所选专业（${availableMajors.value.find(m => m.id == majorId)?.name || '未知专业'}），无法进行对比！`,
                  type: 'warning'
                })
                return
              } else if (!checkResult1) {
                window.$showToast({
                  title: '提示',
                  message: `${results1[0].name}未开设所选专业（${availableMajors.value.find(m => m.id == majorId)?.name || '未知专业'}），无法进行对比！`,
                  type: 'warning'
                })
                return
              } else if (!checkResult2) {
                window.$showToast({
                  title: '提示',
                  message: `${results2[0].name}未开设所选专业（${availableMajors.value.find(m => m.id == majorId)?.name || '未知专业'}），无法进行对比！`,
                  type: 'warning'
                })
                return
              }
              
              // 获取详细对比数据
              const universityIds = `${universityId1},${universityId2}`
              
              console.log('请求参数:', { universityIds, majorId })
              
              const response = await fetch(`${API_BASE_URL}/university/compare?universityIds=${universityIds}&majorId=${majorId}`)
              if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`)
              }
              
              const compareResults = await response.json()
              console.log('对比结果数据:', compareResults)
              
              // 合并数据
              uni1.value = { ...results1[0], ...compareResults[0] }
              uni2.value = { ...results2[0], ...compareResults[1] }
              
              console.log('合并后的数据:', { uni1: uni1.value, uni2: uni2.value })
              
              showResult.value = true
              console.log('显示结果:', showResult.value)
              
              
              window.$showToast({
                title: '对比成功',
                message: '已生成院校对比结果',
                type: 'success'
              })
            }
          } else {
            window.$showToast({
              title: '提示',
              message: '未找到匹配的院校，请检查输入！',
              type: 'warning'
            })
          }
        } catch (error) {
          console.error('对比失败:', error)
          window.$showToast({
            title: '错误',
            message: '对比失败，请稍后重试',
            type: 'error'
          })
        } finally {
          isLoading.value = false
        }
      } else {
        window.$showToast({
          title: '提示',
          message: '请输入两所院校并选择专业进行对比！',
          type: 'warning'
        })
      }
    }

    // 导出PDF对比报告
    const exportPDF = () => {
      window.$showToast({
        title: '提示',
        message: 'PDF导出功能正在开发中！',
        type: 'info'
      })
    }

    // 加入收藏
    const addToFavorites = () => {
      window.$showToast({
        title: '成功',
        message: '已将对比结果加入收藏！',
        type: 'success'
      })
    }

    // 重新对比
    const resetComparison = () => {
      showResult.value = false
      compareData.value.university1 = ''
      compareData.value.university2 = ''
    }

    onMounted(() => {
      fetchHotUniversities()
      fetchAvailableMajors()
      fetchAllUniversities()
    })

    return {
      compareData,
      showResult,
      uni1,
      uni2,
      hotUniversities,
      availableMajors,
      compare,
      selectHotUniversity,
      intelligentConclusion,
      exportPDF,
      addToFavorites,
      resetComparison,
      filteredUniversities,
      showDropdowns,
      handleInput,
      showDropdown,
      hideDropdown,
      selectUniversity
    }
  }
}
</script>

<style scoped>
/* 基础样式 */
.page-title {
  text-align: center;
  font-size: 2rem;
  font-weight: bold;
  color: var(--primary-color);
  margin-bottom: 40px;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

/* 表单样式 */
.compare-form {
  background-color: white;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  margin-bottom: 40px;
}

.compare-form h2 {
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

.autocomplete-wrapper {
  position: relative;
  width: 100%;
}

.autocomplete-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background-color: white;
  border: 1px solid var(--border-color);
  border-radius: 0 0 8px 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 10;
  max-height: 200px;
  overflow-y: auto;
  margin-top: -2px;
}

.dropdown-item {
  padding: 10px 16px;
  cursor: pointer;
  transition: background-color 0.2s ease;
  border-bottom: 1px solid #f0f0f0;
}

.dropdown-item:last-child {
  border-bottom: none;
}

.dropdown-item:hover {
  background-color: #f5f5f5;
}

.form-input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid var(--border-color);
  border-radius: 8px;
  font-size: 1rem;
  transition: all 0.3s ease;
  box-sizing: border-box;
}

.form-input:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.1);
}

/* 热门院校样式 */
.hot-universities {
  margin: 20px 0;
}

.hot-universities h3 {
  font-size: 1rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.hot-university-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.hot-university-tag {
  padding: 6px 12px;
  background-color: #f0f7ff;
  color: var(--primary-color);
  border-radius: 16px;
  font-size: 0.85rem;
  cursor: pointer;
  transition: all 0.3s ease;
  border: 1px solid var(--primary-color);
}

.hot-university-tag:hover {
  background-color: var(--primary-color);
  color: white;
  transform: translateY(-1px);
  box-shadow: 0 2px 8px rgba(30, 58, 138, 0.3);
}

/* 对比结果样式 */
.compare-result {
  margin-bottom: 40px;
}

/* 对比卡片样式 */
.compare-cards {
  display: flex;
  gap: 20px;
  margin-bottom: 40px;
  flex-wrap: wrap;
}

.compare-card {
  flex: 1;
  min-width: 300px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  padding: 24px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.compare-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.card-header {
  margin-bottom: 20px;
}

.university-name {
  font-size: 1.25rem;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.level-tags {
  display: flex;
  gap: 8px;
}

.level-tag {
  padding: 4px 12px;
  border-radius: 16px;
  font-size: 0.85rem;
  font-weight: 600;
  color: white;
}

.tag-985 {
  background-color: #f97316; /* 橙色 */
}

.tag-211 {
  background-color: #2563eb; /* 蓝色 */
}

.tag-c9 {
  background-color: #dc2626; /* 红色 */
}

.card-body {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.score-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background-color: #f7fafc;
  border-radius: 8px;
}

.score-label {
  font-size: 0.9rem;
  color: var(--text-secondary);
}

.score-value {
  font-size: 1.5rem;
  font-weight: bold;
  color: var(--primary-color);
}

.trend-chart {
  padding: 16px;
  background-color: #f7fafc;
  border-radius: 8px;
}

.trend-label {
  display: block;
  font-size: 0.9rem;
  color: var(--text-secondary);
  margin-bottom: 12px;
}

.mini-chart {
  height: 80px;
  width: 100%;
}

.difficulty-info {
  padding: 16px;
  background-color: #f7fafc;
  border-radius: 8px;
}

.difficulty-label {
  display: block;
  font-size: 0.9rem;
  color: var(--text-secondary);
  margin-bottom: 12px;
}

.difficulty-score {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.score-number {
  font-size: 1.5rem;
  font-weight: bold;
  color: #f59e0b;
}

.stars {
  display: flex;
  gap: 2px;
}

.star {
  color: #e5e7eb;
  font-size: 1rem;
}

.star.filled {
  color: #f59e0b;
}

/* 对比模块样式 */
.comparison-module {
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  padding: 24px;
  margin-bottom: 40px;
}

.module-title {
  font-size: 1.25rem;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: 20px;
  padding-bottom: 12px;
  border-bottom: 2px solid var(--border-color);
}

.module-table {
  overflow-x: auto;
}

.table {
  width: 100%;
  border-collapse: collapse;
  border-radius: 8px;
  overflow: hidden;
}

.table thead th {
  background-color: var(--primary-color);
  color: white;
  font-weight: 600;
  padding: 16px;
  text-align: left;
  border-bottom: 2px solid var(--primary-dark);
}

.table thead th.compare-value {
  text-align: center;
}

.table tbody tr {
  transition: background-color 0.3s ease;
  border-bottom: 1px solid var(--border-color);
}

.table tbody tr:last-child {
  border-bottom: none;
}

.table tbody tr:nth-child(even) {
  background-color: #f7fafc;
}

.table tbody tr:hover {
  background-color: #edf2f7;
}

.compare-item {
  padding: 16px;
  font-weight: 600;
  color: var(--text-primary);
  background-color: #f9fafb;
  width: 30%;
  text-align: left;
}

.compare-value {
  padding: 16px;
  color: var(--text-secondary);
  width: 35%;
  text-align: center;
}

/* 分组标题样式 */
.group-header {
  background-color: #edf2f7;
  border-top: 2px solid var(--border-color);
  border-bottom: 2px solid var(--border-color);
}

.group-header td {
  padding: 12px 16px;
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--primary-color);
  text-align: left;
}

/* 特殊数值样式 */
.compare-value.score {
  font-weight: bold;
  color: var(--primary-color);
}

.compare-value.trend {
  font-weight: bold;
}

.compare-value.trend[data-trend="up"] {
  color: var(--danger-color);
}

.compare-value.trend[data-trend="down"] {
  color: var(--success-color);
}

.compare-value.difficulty {
  font-weight: bold;
  color: #f59e0b;
}

/* 智能结论区样式 */
.intelligent-conclusion {
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  padding: 24px;
}

.conclusion-title {
  font-size: 1.25rem;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: 16px;
}

.conclusion-content {
  background-color: #f0f7ff;
  border-left: 4px solid var(--primary-color);
  padding: 16px;
  margin-bottom: 24px;
  border-radius: 4px;
}

.conclusion-content p {
  font-size: 1.1rem;
  line-height: 1.6;
  color: var(--text-primary);
  margin: 0;
}

.action-buttons {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

/* 按钮样式 */
.btn {
  border-radius: 8px;
  padding: 8px 20px;
  font-weight: 600;
  transition: all 0.3s ease;
  cursor: pointer;
  font-size: 0.9rem;
}

.btn-primary {
  background-color: var(--primary-color);
  border: none;
  color: white;
  width: 100%;
}

.btn-primary:hover {
  background-color: var(--primary-dark);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(30, 58, 138, 0.3);
}

.btn-secondary {
  background-color: var(--secondary-color);
  border: none;
  color: white;
}

.btn-secondary:hover {
  background-color: #e65a20;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(223, 107, 53, 0.3);
}

.btn-outline {
  background-color: white;
  border: 2px solid var(--border-color);
  color: var(--text-primary);
}

.btn-outline:hover {
  background-color: var(--bg-color);
  border-color: var(--primary-color);
  color: var(--primary-color);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .form-row {
    flex-direction: column;
  }

  .compare-form,
  .compare-card,
  .comparison-module,
  .intelligent-conclusion {
    padding: 20px;
  }

  .compare-cards {
    flex-direction: column;
  }

  .action-buttons {
    flex-direction: column;
  }

  .compare-item,
  .compare-value {
    width: 100%;
    text-align: left;
  }
}
</style>