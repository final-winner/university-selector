<template>
  <div class="compare">
    <div class="container">
      <h1 class="page-title">数据对比</h1>
      <div class="compare-section">
        <div class="compare-form">
          <h2>选择对比院校</h2>
          <div class="form-row">
            <div class="form-group">
              <label>院校1</label>
              <select v-model="compareData.university1">
                <option value="">请选择</option>
                <option v-for="uni in universities" :key="uni.id" :value="uni.id">{{ uni.name }}</option>
              </select>
            </div>
            <div class="form-group">
              <label>院校2</label>
              <select v-model="compareData.university2">
                <option value="">请选择</option>
                <option v-for="uni in universities" :key="uni.id" :value="uni.id">{{ uni.name }}</option>
              </select>
            </div>
          </div>
          <button class="btn btn-primary" @click="compare">开始对比</button>
        </div>

        <div class="compare-result" v-if="showResult">
          <h2>对比结果</h2>
          <div class="compare-table">
            <table class="table">
              <thead>
                <tr>
                  <th>对比项</th>
                  <th>{{ uni1.name }}</th>
                  <th>{{ uni2.name }}</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>院校类型</td>
                  <td>{{ uni1.type }}</td>
                  <td>{{ uni2.type }}</td>
                </tr>
                <tr>
                  <td>地区</td>
                  <td>{{ uni1.location }}</td>
                  <td>{{ uni2.location }}</td>
                </tr>
                <tr>
                  <td>分区</td>
                  <td>{{ uni1.region }}</td>
                  <td>{{ uni2.region }}</td>
                </tr>
                <tr>
                  <td>学科评估</td>
                  <td>{{ uni1.level }}</td>
                  <td>{{ uni2.level }}</td>
                </tr>
                <tr>
                  <td>软科排名</td>
                  <td>{{ uni1.rankings[0].rank }}</td>
                  <td>{{ uni2.rankings[0].rank }}</td>
                </tr>
                <tr>
                  <td>QS排名</td>
                  <td>{{ uni1.rankings[3].rank }}</td>
                  <td>{{ uni2.rankings[3].rank }}</td>
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

export default {
  name: 'Compare',
  setup() {
    const compareData = ref({
      university1: '',
      university2: ''
    })
    const showResult = ref(false)
    const uni1 = ref({})
    const uni2 = ref({})

    const universities = ref([
      {
        id: 1,
        name: '北京大学',
        type: '985',
        location: '北京',
        region: 'A区',
        level: 'A+',
        rankings: [
          { type: '软科中国大学排名', rank: 2, score: 98.5, source: '软科' },
          { type: 'QS世界大学排名', rank: 17, score: '--', source: 'QS' }
        ]
      },
      {
        id: 2,
        name: '清华大学',
        type: '985',
        location: '北京',
        region: 'A区',
        level: 'A+',
        rankings: [
          { type: '软科中国大学排名', rank: 1, score: 99.1, source: '软科' },
          { type: 'QS世界大学排名', rank: 14, score: '--', source: 'QS' }
        ]
      },
      {
        id: 3,
        name: '浙江大学',
        type: '985',
        location: '浙江',
        region: 'A区',
        level: 'A+',
        rankings: [
          { type: '软科中国大学排名', rank: 3, score: 97.8, source: '软科' },
          { type: 'QS世界大学排名', rank: 45, score: '--', source: 'QS' }
        ]
      }
    ])

    const compare = () => {
      if (compareData.value.university1 && compareData.value.university2) {
        uni1.value = universities.value.find(u => u.id === compareData.value.university1)
        uni2.value = universities.value.find(u => u.id === compareData.value.university2)
        showResult.value = true
      }
    }

    return {
      compareData,
      showResult,
      uni1,
      uni2,
      universities,
      compare
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

.compare-section {
  max-width: 1000px;
  margin: 0 auto;
}

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

.compare-result {
  background-color: white;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.compare-result h2 {
  font-size: 1.5rem;
  font-weight: bold;
  color: var(--primary-color);
  margin-bottom: 30px;
  text-align: center;
}

.compare-table {
  overflow-x: auto;
}

.table {
  margin-bottom: 0;
}

.table thead th {
  background-color: var(--primary-color);
  color: white;
  font-weight: 600;
  border: none;
  padding: 16px;
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

.btn {
  border-radius: 8px;
  padding: 12px 32px;
  font-weight: 600;
  transition: all 0.3s ease;
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
}

@media (max-width: 768px) {
  .form-row {
    flex-direction: column;
  }

  .compare-form,
  .compare-result {
    padding: 20px;
  }
}
</style>