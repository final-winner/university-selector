<template>
  <div class="home min-h-screen">
    <section class="hero">
      <div class="container">
        <div class="hero-content text-center">
          <h1 class="text-3xl md:text-4xl font-bold mb-5">智能择校，精准定位</h1>
          <p class="text-lg md:text-xl mb-8">专业、智能、便捷的408统考院校选择工具，助您找到最适合的考研目标院校</p>
          <div class="d-flex flex-row justify-center gap-4">
            <router-link to="/recommend" class="btn-light">开始智能推荐</router-link>
            <router-link to="/university-list" class="btn-outline-light">浏览院校列表</router-link>
          </div>
        </div>
      </div>
    </section>

    <section class="container py-20">
      <div class="text-center mb-16">
        <h2 class="worthy-text text-3xl font-bold text-primary">值得拥有</h2>
      </div>
      <div class="row">
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-secondary">
              <Search class="h-20 w-20" />
            </div>
            <h3 class="text-secondary">智能推荐</h3>
            <p>根据您的成绩、专业偏好、地区选择等因素，智能推荐最适合的院校</p>
          </div>
        </div>
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-success">
              <BarChart class="h-20 w-20" />
            </div>
            <h3 class="text-success">数据对比</h3>
            <p>多维度对比院校信息，包括分数线、招生人数、竞争态势等</p>
          </div>
        </div>
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-tertiary">
              <Heart class="h-20 w-20" />
            </div>
            <h3 class="text-tertiary">收藏管理</h3>
            <p>收藏感兴趣的院校，方便随时查看和对比</p>
          </div>
        </div>
        <div class="col-md-3 mb-6">
          <div class="feature-card">
            <div class="feature-icon text-accent">
              <Lightbulb class="h-20 w-20" />
            </div>
            <h3 class="text-accent">备考指导</h3>
            <p>提供专业的备考建议和学习资源，助力您的考研复习计划</p>
          </div>
        </div>
      </div>
    </section>

    <section class="container py-20">
      <div class="text-center mb-16">
        <h2 class="section-title text-3xl font-bold text-primary">热门院校</h2>
      </div>
      <div class="row">
        <div v-for="university in universities" :key="university.id" class="col-md-4 mb-6">
          <div class="university-card">
            <div class="card-header">
              <h5>{{ university.name }}</h5>
              <span class="badge" :style="getBadgeStyle(university.type)">{{ university.type }}</span>
            </div>
            <div class="card-body">
              <p><strong>地区：</strong>{{ university.location }}</p>
              <p><strong>分区：</strong>{{ university.region }}</p>
              <p><strong>学科评估：</strong>{{ university.level }}</p>
            </div>
            <div class="card-footer">
              <router-link :to="`/university-detail/${university.id}`" class="btn btn-primary btn-lg">查看详情</router-link>
              <button class="btn-favorite btn-favorite-lg" @click="toggleFavorite(university.id)">
                <Heart :class="isFavorite(university.id) ? 'fill-current text-red-500' : 'text-text-secondary'" class="h-4 w-4" />
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="text-center mt-10">
        <router-link to="/university-list" class="btn-light">查看全部院校</router-link>
      </div>
    </section>
  </div>
</template>

<script>
import { ref } from 'vue'
import { Search, BarChart, Heart, Lightbulb } from 'lucide-vue-next'

export default {
  name: 'Home',
  components: {
    Search,
    BarChart,
    Heart,
    Lightbulb
  },
  setup() {
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
      }
    ])

    const getBadgeStyle = (type) => {
      const styles = {
        '985': 'background-color: #e53935; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
        '211': 'background-color: #1e88e5; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
        '双一流': 'background-color: #f57c00; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
        '双非': 'background-color: #43a047; color: white; padding: 4px 12px; border-radius: 16px; font-size: 0.75rem; font-weight: 600;',
      }
      return styles[type] || styles['双非']
    }

    const favorites = ref(new Set())

    const toggleFavorite = (id) => {
      if (favorites.value.has(id)) {
        favorites.value.delete(id)
      } else {
        favorites.value.add(id)
      }
    }

    const isFavorite = (id) => {
      return favorites.value.has(id)
    }

    return {
      universities,
      getBadgeStyle,
      toggleFavorite,
      isFavorite
    }
  }
}
</script>

<style scoped>
.hero-content {
  max-width: 800px;
  margin: 0 auto;
}

.row {
  display: flex;
  flex-wrap: wrap;
  margin-right: -15px;
  margin-left: -15px;
}

.col-md-3,
.col-md-4 {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}

.col-md-3 {
  flex: 0 0 25%;
  max-width: 25%;
}

.col-md-4 {
  flex: 0 0 33.333333%;
  max-width: 33.333333%;
}

.mb-6 {
  margin-bottom: 1.5rem;
}

.mt-10 {
  margin-top: 2.5rem;
}

.d-flex {
  display: flex;
}

.flex-row {
  flex-direction: row;
}

.justify-center {
  justify-content: center;
}

.gap-4 {
  gap: 1rem;
}

.text-center {
  text-align: center;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.btn-favorite {
  background-color: white;
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
  border-radius: 6px;
  padding: 6px;
  width: 32px;
  height: 32px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.btn-favorite:hover {
  background-color: var(--border-color);
  color: var(--text-primary);
  border-color: var(--primary-light);
  transform: translateY(-1px);
}

@media (max-width: 768px) {
  .col-md-3,
  .col-md-4 {
    flex: 0 0 100%;
    max-width: 100%;
  }
}
</style>