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
        <button type="button" class="btn-outline-secondary flex items-center gap-2" @click="share">
          <Share2 class="h-4 w-4" /> 分享
        </button>
      </div>

      <div class="university-header mb-10">
        <div class="badges flex gap-3 flex-wrap mb-5">
          <span class="badge" style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8;">{{ university.type }}</span>
          <span class="badge" style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8;">{{ university.region }}</span>
          <span class="badge" style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8;">{{ university.location }}</span>
          <span class="badge" style="background-color: white; color: #94A3B8; border: 2px solid #94A3B8;">{{ university.level }}</span>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-5">{{ university.name }}</h1>
        <p class="text-lg text-text-secondary leading-relaxed">{{ university.description }}</p>
      </div>

      <div class="nav-tabs border-b-2 border-border-color mb-8">
        <div class="flex space-x-2">
          <button class="nav-link px-6 py-3 border-b-3 transition-all duration-300" :class="activeTab === 'basic-info' ? 'border-primary text-primary font-semibold' : 'border-transparent text-text-secondary hover:text-primary hover:border-primary'" @click="activeTab = 'basic-info'">
            基本信息
          </button>
          <button class="nav-link px-6 py-3 border-b-3 transition-all duration-300" :class="activeTab === 'majors' ? 'border-primary text-primary font-semibold' : 'border-transparent text-text-secondary hover:text-primary hover:border-primary'" @click="activeTab = 'majors'">
            专业设置
          </button>
          <button class="nav-link px-6 py-3 border-b-3 transition-all duration-300" :class="activeTab === 'admission' ? 'border-primary text-primary font-semibold' : 'border-transparent text-text-secondary hover:text-primary hover:border-primary'" @click="activeTab = 'admission'">
            招生信息
          </button>
          <button class="nav-link px-6 py-3 border-b-3 transition-all duration-300" :class="activeTab === 'data' ? 'border-primary text-primary font-semibold' : 'border-transparent text-text-secondary hover:text-primary hover:border-primary'" @click="activeTab = 'data'">
            数据可视化
          </button>
        </div>
      </div>

      <div class="tab-content">
        <div v-if="activeTab === 'basic-info'">
          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">院校基本信息</h2>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校代码：</span>
              <span class="text-text-secondary flex-1">{{ university.code }}</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校类型：</span>
              <span class="text-text-secondary flex-1">{{ university.category }}</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校性质：</span>
              <span class="text-text-secondary flex-1">{{ university.nature }}</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校地区：</span>
              <span class="text-text-secondary flex-1">{{ university.address }}</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校特色：</span>
              <span class="text-text-secondary flex-1">{{ university.features }}</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">院校简介：</span>
              <span class="text-text-secondary flex-1">{{ university.introduction }}</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">学校官网：</span>
              <a :href="university.website" target="_blank" class="text-primary hover:text-secondary hover:underline flex-1">{{ university.website }}</a>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">研究生院官网：</span>
              <a :href="university.gradSchoolWebsite" target="_blank" class="text-primary hover:text-secondary hover:underline flex-1">{{ university.gradSchoolWebsite }}</a>
            </div>
          </div>

          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">院校排名</h2>
            <div class="table-container overflow-x-auto">
              <table class="w-full">
                <thead>
                  <tr class="bg-bg-color">
                    <th class="px-4 py-3 font-semibold text-text-primary border-b-2 border-border-color">排名类型</th>
                    <th class="px-4 py-3 font-semibold text-text-primary border-b-2 border-border-color">排名</th>
                    <th class="px-4 py-3 font-semibold text-text-primary border-b-2 border-border-color">总分</th>
                    <th class="px-4 py-3 font-semibold text-text-primary border-b-2 border-border-color">参考来源</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="ranking in university.rankings" :key="ranking.type" class="hover:bg-bg-color transition-colors">
                    <td class="px-4 py-3 text-text-secondary border-b border-border-color">{{ ranking.type }}</td>
                    <td class="px-4 py-3 text-text-secondary border-b border-border-color">{{ ranking.rank }}</td>
                    <td class="px-4 py-3 text-text-secondary border-b border-border-color">{{ ranking.score }}</td>
                    <td class="px-4 py-3 text-text-secondary border-b border-border-color">{{ ranking.source }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div v-if="activeTab === 'majors'">
          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">专业设置</h2>
            <div class="text-center" v-if="!university.majors || university.majors.length === 0">
              <div class="text-gray-400 py-12">
                <Info class="h-12 w-12 text-gray-300 mx-auto mb-4" />
                暂无专业信息
              </div>
            </div>
            <div v-else>
              <div v-for="major in university.majors" :key="major.name" class="major-item p-5 border border-border-color rounded-lg mb-5 bg-bg-color">
                <h3 class="text-lg font-semibold text-primary mb-3">{{ major.name }}</h3>
                <p class="text-text-secondary leading-relaxed">{{ major.description }}</p>
              </div>
            </div>
          </div>
        </div>

        <div v-if="activeTab === 'admission'">
          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">招生信息</h2>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">招生简章：</span>
              <a :href="university.admission.brochure" target="_blank" class="text-primary hover:text-secondary hover:underline flex-1">{{ university.admission.brochureTitle }}</a>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">专业目录：</span>
              <a :href="university.admission.catalog" target="_blank" class="text-primary hover:text-secondary hover:underline flex-1">{{ university.admission.catalogTitle }}</a>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">推免信息：</span>
              <a :href="university.admission.recommendation" target="_blank" class="text-primary hover:text-secondary hover:underline flex-1">{{ university.admission.recommendationTitle }}</a>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">复试信息：</span>
              <a :href="university.admission.reexamination" target="_blank" class="text-primary hover:text-secondary hover:underline flex-1">{{ university.admission.reexaminationTitle }}</a>
            </div>
          </div>

          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">奖学金信息</h2>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">国家奖学金：</span>
              <span class="text-text-secondary flex-1">每年奖励特别优秀的学生，奖励标准为每生每年8000元</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">国家励志奖学金：</span>
              <span class="text-text-secondary flex-1">每年奖励资助品学兼优的家庭经济困难学生，奖励标准为每生每年5000元</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">国家助学金：</span>
              <span class="text-text-secondary flex-1">每年资助家庭经济困难学生，资助标准为每生每年3000元</span>
            </div>
            <div class="info-row flex mb-5 leading-relaxed">
              <span class="info-label font-semibold text-text-primary w-32 flex-shrink-0">学校奖学金：</span>
              <span class="text-text-secondary flex-1">学校设有多种奖学金，包括综合奖学金、单项奖学金等</span>
            </div>
          </div>
        </div>

        <div v-if="activeTab === 'data'">
          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">招生人数变化趋势</h2>
            <div id="admissionChart" class="chart-container w-full h-80 mt-5"></div>
          </div>

          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">分数线变化趋势</h2>
            <div id="scoreChart" class="chart-container w-full h-80 mt-5"></div>
          </div>

          <div class="info-section bg-white p-7 rounded-xl shadow-sm mb-8">
            <h2 class="text-2xl font-bold text-primary mb-6 pb-3 border-b-2 border-border-color">竞争态势分析</h2>
            <div id="competitionChart" class="chart-container w-full h-80 mt-5"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import * as echarts from 'echarts'
import { ArrowLeft, Star, Share2, Info } from 'lucide-vue-next'

export default {
  name: 'UniversityDetail',
  components: {
    ArrowLeft,
    Star,
    Share2,
    Info
  },
  setup() {
    const route = useRoute()
    const router = useRouter()
    const activeTab = ref('basic-info')
    const isFavorited = ref(false)

    const university = ref({
      id: 1,
      name: '清华大学',
      type: '985',
      location: '北京',
      region: 'A区',
      level: 'A+',
      code: '10003',
      category: '综合类',
      nature: '公办',
      address: '北京市海淀区',
      features: '985工程、211工程、双一流A类、强基计划、卓越工程师教育培养计划、卓越法律人才教育培养计划、卓越医生教育培养计划',
      description: '清华大学（Tsinghua University），简称"清华"，位于北京市海淀区，是中华人民共和国教育部直属的全国重点大学，位列国家"双一流"、"985工程"、"211工程"重点建设高校。',
      introduction: '清华大学的前身清华学堂始建于1911年，1912年更名为清华学校。1928年更名为国立清华大学。1937年抗日战争全面爆发后南迁长沙，与北京大学、南开大学组建国立长沙临时大学，1938年迁至昆明改名为国立西南联合大学。1946年迁回清华园。1949年中华人民共和国成立，清华大学进入新的发展阶段。1952年全国高等学校院系调整后成为多科性工业大学。1978年以来逐步恢复和发展为综合性的研究型大学。',
      website: 'https://www.tsinghua.edu.cn',
      gradSchoolWebsite: 'https://yz.tsinghua.edu.cn',
      rankings: [
        { type: '软科中国大学排名', rank: 1, score: 99.1, source: '软科' },
        { type: '武书连中国大学排名', rank: 1, score: 100.0, source: '武书连' },
        { type: '校友会中国大学排名', rank: 1, score: 99.52, source: '校友会' },
        { type: 'QS世界大学排名', rank: 14, score: '--', source: 'QS' },
        { type: '泰晤士高等教育世界大学排名', rank: 23, score: '--', source: '泰晤士' }
      ],
      majors: [],
      admission: {
        brochure: 'https://yz.tsinghua.edu.cn/info/1007/2811.htm',
        brochureTitle: '2024年硕士研究生招生简章',
        catalog: 'https://yz.tsinghua.edu.cn/info/1009/2812.htm',
        catalogTitle: '2024年硕士研究生招生专业目录',
        recommendation: 'https://yz.tsinghua.edu.cn/info/1012/2813.htm',
        recommendationTitle: '2024年推荐免试硕士研究生招生办法',
        reexamination: 'https://yz.tsinghua.edu.cn/info/1013/2814.htm',
        reexaminationTitle: '2024年硕士研究生复试录取办法'
      }
    })

    const goBack = () => {
      router.back()
    }

    const toggleFavorite = () => {
      isFavorited.value = !isFavorited.value
    }

    const share = () => {
      if (navigator.share) {
        navigator.share({
          title: university.value.name,
          text: university.value.description,
          url: window.location.href
        })
      } else {
        alert('分享功能暂不支持')
      }
    }

    const initCharts = () => {
      const admissionChart = echarts.init(document.getElementById('admissionChart'))
      admissionChart.setOption({
        title: { text: '招生人数变化趋势' },
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: ['2020', '2021', '2022', '2023', '2024'] },
        yAxis: { type: 'value' },
        series: [{ data: [1200, 1320, 1010, 1340, 900], type: 'line', smooth: true }]
      })

      const scoreChart = echarts.init(document.getElementById('scoreChart'))
      scoreChart.setOption({
        title: { text: '分数线变化趋势' },
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: ['2020', '2021', '2022', '2023', '2024'] },
        yAxis: { type: 'value' },
        series: [{ data: [330, 340, 335, 345, 340], type: 'line', smooth: true }]
      })

      const competitionChart = echarts.init(document.getElementById('competitionChart'))
      competitionChart.setOption({
        title: { text: '竞争态势分析' },
        tooltip: { trigger: 'item' },
        series: [{
          type: 'pie',
          radius: '50%',
          data: [
            { value: 1048, name: '报考人数' },
            { value: 735, name: '录取人数' },
            { value: 580, name: '推免人数' }
          ]
        }]
      })

      window.addEventListener('resize', () => {
        admissionChart.resize()
        scoreChart.resize()
        competitionChart.resize()
      })
    }

    watch(activeTab, (newTab) => {
      if (newTab === 'data') {
        setTimeout(initCharts, 100)
      }
    })

    onMounted(() => {
      if (activeTab.value === 'data') {
        setTimeout(initCharts, 100)
      }
    })

    return {
      university,
      activeTab,
      isFavorited,
      goBack,
      toggleFavorite,
      share
    }
  }
}
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

.text-secondary {
  color: var(--secondary-color);
}

.text-text-primary {
  color: var(--text-primary);
}

.text-text-secondary {
  color: var(--text-secondary);
}

.border-border-color {
  border-color: var(--border-color);
}

.bg-bg-color {
  background-color: var(--bg-color);
}

@media (max-width: 768px) {
  .action-buttons {
    flex-direction: column;
  }

  .university-header h1 {
    font-size: 1.8rem;
  }

  .info-row {
    flex-direction: column;
    gap: 2px;
  }

  .info-label {
    width: auto !important;
  }

  .chart-container {
    height: 240px !important;
  }
}
</style>