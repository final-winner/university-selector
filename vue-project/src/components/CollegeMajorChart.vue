<template>
  <div class="college-major-chart max-w-7xl mx-auto px-4 py-8">
    <!-- 标题区域优化：增加间距+视觉层次 -->
    <div class="mb-8">
      <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">学院专业数据</h2>
      <div class="text-sm text-text-light flex flex-col items-start">
        <div v-if="colleges && colleges.length > 0">
          <span>信息来源：</span>
          <span v-if="collegeWebsite" class="text-primary ml-1">{{ collegeWebsite }}</span>
          <span v-else>院校官网</span>
        </div>
        <div v-else>信息来源：院校官网</div>
        <div class="mt-1">更新时间：{{ latestUpdateTime }}</div>
      </div>
    </div>
    
    <!-- 学院卡片网格：优化间距+响应式 -->
    <div class="colleges-grid grid grid-cols-1 lg:grid-cols-2 gap-8">
      <!-- 学院卡片：增加质感+阴影+圆角 -->
      <div 
        v-for="college in colleges" 
        :key="college.collegeId" 
        class="college-card p-6 bg-white rounded-xl shadow-md hover:shadow-lg transition-shadow border border-gray-100"
      >
        <!-- 学院头部：优化排版 -->
        <div class="college-header mb-6">
          <h3 class="text-xl font-bold text-primary mb-4">{{ college.collegeName }}</h3>
          <div class="flex items-start">
              <h4 class="text-sm font-medium text-primary mr-2 whitespace-nowrap">院系简介：</h4>
              <p class="text-text-light text-sm text-gray-600">{{ college.introduction || '暂无简介' }}</p>
            </div>
        </div>
        
        <!-- 专业选择器：优化布局+样式 -->
        <div class="major-selector mb-6 flex items-center justify-between bg-gray-50 p-3 rounded-lg">
          <span class="text-sm font-medium text-text-primary">选择专业</span>
          <select 
            v-model="selectedMajors[college.collegeId]"
            @change="handleMajorChange(college.collegeId)"
            class="w-2/3 p-2 border border-gray-200 rounded-md focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary/30 transition-all"
          >
            <option value="">请选择专业</option>
            <option 
              v-for="major in college.majorList" 
              :key="major.majorId" 
              :value="major.majorId"
            >
              {{ major.majorName }}
            </option>
          </select>
        </div>
        
        <!-- 分数数据区域：优化空状态+表格样式 -->
        <div v-if="selectedMajors[college.collegeId]" class="score-data mb-6">
          <h4 class="text-sm font-medium text-primary mb-3 flex items-center">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
            </svg>
            2023-2025年考研数据
          </h4>
          <div v-if="scoreData[college.collegeId] && scoreData[college.collegeId].length > 0" class="data-table">
            <table class="w-full text-sm rounded-lg overflow-hidden shadow-sm">
              <thead>
                <tr class="bg-primary text-white">
                  <th class="text-center py-3 px-3">年份</th>
                  <th class="text-center py-3 px-3">复试分数线</th>
                  <th class="text-center py-3 px-3">信息来源</th>
                </tr>
              </thead>
              <tbody>
                <tr 
                  v-for="(item, index) in scoreData[college.collegeId]" 
                  :key="item.year" 
                  :class="[
                    'text-center transition-colors',
                    index % 2 === 0 ? 'bg-white' : 'bg-gray-50',
                    'hover:bg-primary/5'
                  ]"
                >
                  <td class="py-3 px-3 font-medium">{{ item.year }}</td>
                  <td class="py-3 px-3 text-primary font-medium">{{ item.retestScore }}</td>
                  <td class="py-3 px-3">
                    <span v-if="item.dataSource" class="text-primary">{{ item.dataSource }}</span>
                    <span v-else class="text-text-light text-gray-400">院校官网</span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div v-else class="text-text-secondary text-sm py-8 text-center bg-gray-50 rounded-lg border border-gray-100">
            <svg class="w-8 h-8 mx-auto mb-2 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            暂无该专业数据
          </div>
        </div>
      
        <!-- 图表区域 -->
        <div v-if="selectedMajors[college.collegeId]" class="chart-section">
          <!-- 复试分数线图表 -->
          <h4 class="text-sm font-medium text-primary mb-4 flex items-center">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
            </svg>
            复试分数线趋势图
          </h4>
          
          <div v-if="scoreData[college.collegeId] && scoreData[college.collegeId].length > 0" class="chart-container mb-8">
            <div :ref="el => chartRefs[`${college.collegeId}-reexam`] = el" style="width: 100%; height: 300px;"></div>
          </div>
          <div v-else class="text-text-secondary text-sm py-8 text-center bg-gray-50 rounded-lg border border-gray-100 mb-8">
            <svg class="w-8 h-8 mx-auto mb-2 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
            </svg>
            暂无该专业复试分数线数据
          </div>


        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, watch, nextTick } from 'vue'
import * as echarts from 'echarts'

const props = defineProps({
  colleges: {
    type: Array,
    default: () => []
  },
  universityWebsite: {
    type: String,
    default: ''
  }
})

// 计算属性：如果有大学官网就使用，否则使用研究生院官网（如果有的话）
const collegeWebsite = computed(() => {
  return props.universityWebsite || ''
})

// 计算属性：获取最新的更新时间
const latestUpdateTime = computed(() => {
  let latestTime = null
  
  // 遍历所有学院和专业，找到最新的更新时间
  props.colleges.forEach(college => {
    college.majorList.forEach(major => {
      major.scoreData.forEach(data => {
        if (data.updateTime) {
          const updateTime = new Date(data.updateTime)
          if (!latestTime || updateTime > latestTime) {
            latestTime = updateTime
          }
        }
      })
    })
  })
  
  // 格式化时间为YYYY-MM-DD格式
  if (latestTime) {
    const year = latestTime.getFullYear()
    const month = String(latestTime.getMonth() + 1).padStart(2, '0')
    const day = String(latestTime.getDate()).padStart(2, '0')
    return `${year}-${month}-${day}`
  }
  
  // 如果没有找到更新时间，返回默认值
  return '2026-03-12'
})

const selectedMajors = ref({})
const scoreData = ref({})
const chartRefs = ref({})
const charts = ref({})
// 定义resizeHandler变量（修复未定义问题）
let resizeHandler = null

// 初始化默认选中的专业
const initDefaultMajors = () => {
  props.colleges.forEach(college => {
    selectedMajors.value[college.collegeId] = ''
  })
}

// 更新分数数据
const updateScoreData = (collegeId, majorId) => {
  const college = props.colleges.find(c => c.collegeId === collegeId)
  if (college) {
    const major = college.majorList.find(m => m.majorId === majorId)
    if (major) {
      // 使用Vue的响应式更新方式
      scoreData.value = {
        ...scoreData.value,
        [collegeId]: major.scoreData
      }
      // 使用 nextTick 确保图表容器已经渲染
      nextTick(() => {
        updateChart(collegeId, major.scoreData)
      })
    }
  }
}

// 处理专业选择变化
const handleMajorChange = (collegeId) => {
  const majorId = selectedMajors.value[collegeId]
  if (majorId) {
    updateScoreData(collegeId, majorId)
  } else {
    scoreData.value[collegeId] = []
    // 销毁复试分数线图表
    const reexamChartKey = `${collegeId}-reexam`
    
    if (charts.value[reexamChartKey]) {
      charts.value[reexamChartKey].dispose()
      charts.value[reexamChartKey] = null
    }
  }
}

// 更新复试分数线图表
const updateReexamChart = (collegeId, data) => {
  const chartKey = `${collegeId}-reexam`
  if (!chartRefs.value[chartKey]) return
  
  // 销毁旧图表
  if (charts.value[chartKey]) {
    charts.value[chartKey].dispose()
  }
  
  // 创建新图表
  const chart = echarts.init(chartRefs.value[chartKey])
  charts.value[chartKey] = chart
  
  if (!data || data.length === 0) {
    chart.setOption({
      title: {
        text: '暂无数据',
        left: 'center',
        top: 'center',
        textStyle: { color: '#9ca3af', fontSize: 14 }
      }
    })
    return
  }
  
  const years = data.map(item => item.year)
  const retestScores = data.map(item => item.retestScore)
  
  // 计算Y轴自适应范围
  const allScores = retestScores.filter(Boolean)
  const minScore = Math.min(...allScores)
  const maxScore = Math.max(...allScores)
  const yMin = Math.floor((minScore - 5) / 10) * 10
  const yMax = Math.ceil((maxScore + 5) / 10) * 10
  
  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        label: {
          backgroundColor: '#6a7985',
          borderRadius: 4,
          padding: [4, 8]
        }
      },
      backgroundColor: 'rgba(255,255,255,0.9)',
      borderColor: '#e5e7eb',
      borderWidth: 1,
      padding: 12,
      textStyle: { color: '#374151' }
    },
    legend: {
      data: ['复试分数线'],
      top: 0,
      textStyle: { fontSize: 12, color: '#4b5563' }
    },
    grid: {
      left: '2%',
      right: '2%',
      bottom: '8%',
      top: '10%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: true,
      data: years,
      axisLine: { lineStyle: { color: '#e5e7eb' } },
      axisLabel: { color: '#374151', fontSize: 12, interval: 0, margin: 10 },
      axisTick: { show: false }
    },
    yAxis: {
      type: 'value',
      name: '分数',
      nameTextStyle: { color: '#6b7280', fontSize: 12 },
      min: yMin,
      max: yMax,
      interval: 10,
      axisLine: { show: false },
      axisLabel: { color: '#6b7280', fontSize: 12 },
      splitLine: { lineStyle: { color: '#f3f4f6' } }
    },
    series: [
      {
        name: '复试分数线',
        type: 'line',
        emphasis: { focus: 'series' },
        lineStyle: { 
          width: 4,
          type: 'solid'
        },
        data: retestScores,
        itemStyle: { color: '#1E40AF' },
        symbol: 'circle',
        symbolSize: 10
      }
    ]
  }
  
  chart.setOption(option)
  
  // 响应式调整
  const resizeHandler = () => {
    clearTimeout(window.resizeTimer)
    window.resizeTimer = setTimeout(() => {
      chart.resize()
    }, 100)
  }
  window.addEventListener('resize', resizeHandler)
}

// 更新录取分数图表
const updateAdmissionChart = (collegeId, data) => {
  const chartKey = `${collegeId}-admission`
  if (!chartRefs.value[chartKey]) return
  
  // 销毁旧图表
  if (charts.value[chartKey]) {
    charts.value[chartKey].dispose()
  }
  
  // 创建新图表
  const chart = echarts.init(chartRefs.value[chartKey])
  charts.value[chartKey] = chart
  
  if (!data || data.length === 0) {
    chart.setOption({
      title: {
        text: '暂无数据',
        left: 'center',
        top: 'center',
        textStyle: { color: '#9ca3af', fontSize: 14 }
      }
    })
    return
  }
  
  const years = data.map(item => item.year)
  const avgScores = data.map(item => item.avgScore)
  const minScores = data.map(item => item.minScore)
  const maxScores = data.map(item => item.maxScore)
  
  // 计算Y轴自适应范围
  const allScores = [...avgScores, ...minScores, ...maxScores].filter(Boolean)
  const minScore = Math.min(...allScores)
  const maxScore = Math.max(...allScores)
  const yMin = Math.floor((minScore - 2) / 10) * 10
  const yMax = Math.ceil((maxScore + 2) / 10) * 10
  
  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        label: {
          backgroundColor: '#6a7985',
          borderRadius: 4,
          padding: [4, 8]
        }
      },
      backgroundColor: 'rgba(255,255,255,0.9)',
      borderColor: '#e5e7eb',
      borderWidth: 1,
      padding: 12,
      textStyle: { color: '#374151' }
    },
    legend: {
      data: ['录取平均分', '录取最低分', '录取最高分'],
      top: 0,
      textStyle: { fontSize: 12, color: '#4b5563' }
    },
    grid: {
      left: '2%',
      right: '2%',
      bottom: '8%',
      top: '10%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: true,
      data: years,
      axisLine: { lineStyle: { color: '#e5e7eb' } },
      axisLabel: { color: '#374151', fontSize: 12, interval: 0, margin: 10 },
      axisTick: { show: false }
    },
    yAxis: {
      type: 'value',
      name: '分数',
      nameTextStyle: { color: '#6b7280', fontSize: 12 },
      min: yMin,
      max: yMax,
      interval: 10,
      axisLine: { show: false },
      axisLabel: { color: '#6b7280', fontSize: 12 },
      splitLine: { lineStyle: { color: '#f3f4f6' } }
    },
    series: [
      {
        name: '录取平均分',
        type: 'line',
        emphasis: { focus: 'series' },
        lineStyle: { 
          width: 4,
          type: 'solid'
        },
        data: avgScores,
        itemStyle: { color: '#059669' },
        symbol: 'diamond',
        symbolSize: 8
      },
      {
        name: '录取最低分',
        type: 'line',
        emphasis: { focus: 'series' },
        lineStyle: { 
          width: 4,
          type: 'solid'
        },
        data: minScores,
        itemStyle: { color: '#10B981' },
        symbol: 'triangle',
        symbolSize: 8
      },
      {
        name: '录取最高分',
        type: 'line',
        emphasis: { focus: 'series' },
        lineStyle: { 
          width: 4,
          type: 'solid'
        },
        data: maxScores,
        itemStyle: { color: '#EF4444' },
        symbol: 'square',
        symbolSize: 8
      }
    ]
  }
  
  chart.setOption(option)
  
  // 响应式调整
  const resizeHandler = () => {
    clearTimeout(window.resizeTimer)
    window.resizeTimer = setTimeout(() => {
      chart.resize()
    }, 100)
  }
  window.addEventListener('resize', resizeHandler)
}

// 更新图表
const updateChart = (collegeId, data) => {
  updateReexamChart(collegeId, data)
}

// 监听 colleges 变化
watch(() => props.colleges, (newColleges) => {
  initDefaultMajors()
  // 自动选择第一个学院的第一个专业
  if (newColleges && newColleges.length > 0) {
    const firstCollege = newColleges[0]
    if (firstCollege.majorList && firstCollege.majorList.length > 0) {
      selectedMajors.value[firstCollege.collegeId] = firstCollege.majorList[0].majorId
      updateScoreData(firstCollege.collegeId, firstCollege.majorList[0].majorId)
    }
  }
}, { deep: true, immediate: true })

onMounted(() => {
  initDefaultMajors()
  // 自动选择第一个学院的第一个专业
  if (props.colleges && props.colleges.length > 0) {
    const firstCollege = props.colleges[0]
    if (firstCollege.majorList && firstCollege.majorList.length > 0) {
      selectedMajors.value[firstCollege.collegeId] = firstCollege.majorList[0].majorId
      updateScoreData(firstCollege.collegeId, firstCollege.majorList[0].majorId)
    }
  }
})

onUnmounted(() => {
  // 销毁所有图表实例
  Object.values(charts.value).forEach(chart => {
    if (chart) {
      chart.dispose()
    }
  })
  // 移除resize监听
  window.removeEventListener('resize', resizeHandler)
})
</script>

<style scoped>
/* 定义全局变量（如果项目中已有可忽略） */
:root {
  --primary-color: #1E40AF; /* 主色：深蓝色更专业 */
  --text-primary: #111827;
  --text-secondary: #4b5563;
  --text-light: #9ca3af;
  --border-color: #e5e7eb;
}

/* 基础样式重置 */
.college-major-chart {
  background-color: #f9fafb;
  min-height: 100vh;
}

/* 卡片样式优化 */
.college-card {
  transition: all 0.3s ease;
  border-radius: 8px;
  background-color: #f9fafb;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  border: 1px solid #e5e7eb;
  padding: 20px;
}

/* 学院头部样式 */
.college-header {
  margin-bottom: 20px;
}

/* 专业选择器样式 */
.major-selector {
  margin-bottom: 20px;
  background-color: #ffffff;
  padding: 16px;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* 选择专业标签样式 */
.major-selector span {
  font-size: 14px;
  font-weight: 600;
  color: var(--primary-color);
  margin-right: 12px;
  white-space: nowrap;
  transition: all 0.2s ease;
}

/* SVG图标样式 */
.college-card .score-data h4 svg,
.college-card .chart-section h4 svg {
  width: 20px;
  height: 20px;
  margin-right: 8px;
}

/* 选择器样式优化 */
.major-selector select {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  font-size: 14px;
  color: #374151;
  background-color: #f9fafb;
  transition: all 0.2s ease;
}

.major-selector select:hover {
  border-color: #93c5fd;
  background-color: #ffffff;
}

.major-selector select:focus {
  outline: none;
  border-color: #1E40AF;
  box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
  background-color: #ffffff;
}

/* 分数数据区域样式 */
.score-data {
  margin-bottom: 20px;
}

/* 图表区域样式 */
.chart-section {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #e5e7eb;
}

/* 表格样式优化 */
.data-table table {
  border-collapse: collapse;
  width: 100%;
  background-color: #ffffff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.data-table th {
  font-weight: 600;
  text-align: center;
  background-color: var(--primary-color);
  color: white;
  padding: 12px;
  border-bottom: none;
}

.data-table td {
  padding: 12px;
  text-align: center;
  border-bottom: 1px solid #f3f4f6;
}

.data-table tr:last-child td {
  border-bottom: none;
}

/* 图表容器样式 */
.chart-container {
  background-color: #ffffff;
  border-radius: 8px;
  padding: 16px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  border: 1px solid #e5e7eb;
}

/* 响应式优化（修复核心语法错误） */
@media (max-width: 1024px) {
  .colleges-grid {
    grid-template-columns: repeat(1, minmax(0, 1fr)) !important;
  }
  .chart-container {
    height: 300px !important;
  }
}

@media (max-width: 640px) {
  .major-selector {
    flex-direction: column;
    align-items: flex-start !important;
    gap: 8px;
  }
  .major-selector select {
    width: 100% !important;
  }
}
</style>