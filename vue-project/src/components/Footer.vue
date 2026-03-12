<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-top">
        <div class="row">
          <div class="col-md-6">
            <div class="footer-nav">
              <!-- 普通用户导航 -->
              <template v-if="!isAdmin">
                <router-link to="/" class="nav-link">首页</router-link>
                <router-link to="/university-list" class="nav-link">院校库</router-link>
                <router-link to="/recommend" class="nav-link">我的择校方案</router-link>
                <router-link to="/compare" class="nav-link">院校对比</router-link>
                <router-link to="/login" class="nav-link">登录/注册</router-link>
                <router-link to="/about" class="nav-link">关于我们</router-link>
                <router-link to="/help" class="nav-link">帮助中心</router-link>
                <router-link to="/sitemap" class="nav-link">网站地图</router-link>
              </template>
              
              <!-- 管理员导航 -->
              <template v-else>
                <router-link to="/admin/correction" class="nav-link">管理后台</router-link>
              </template>
            </div>
          </div>
          <div class="col-md-6">
            <div class="footer-contact text-right">
              <p class="contact-item"><Phone class="contact-icon" /> 客服热线：18888888888</p>
              <p class="contact-item"><Mail class="contact-icon" /> 客服邮箱：431149990@qq.com</p>
              <p class="contact-item"><Clock class="contact-icon" /> 服务时间：周一至周日 9:00-22:00</p>
            </div>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <div class="footer-copyright">
          <p class="copyright-text">© 2026 408考研择校辅助工具 版权所有</p>
        </div>
        <div class="footer-social">
          <a href="#" title="官方微信"><MessageSquare class="h-5 w-5" /></a>
          <a href="#" title="官方微博"><Twitter class="h-5 w-5" /></a>
          <a href="#" title="官方QQ"><MessageCircle class="h-5 w-5" /></a>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
import { computed } from 'vue'
import { Phone, Mail, Clock, MessageSquare, Twitter, MessageCircle } from 'lucide-vue-next'
import { useAuth } from '@/composables/useAuth'

export default {
  name: 'Footer',
  components: {
    Phone,
    Mail,
    Clock,
    MessageSquare,
    Twitter,
    MessageCircle
  },
  setup() {
    const { user } = useAuth()
    
    // 检查是否为管理员
    const isAdmin = computed(() => {
      return user.value && user.value.role === 'admin'
    })
    
    return {
      isAdmin
    }
  }
}
</script>

<style scoped>
.nav-link {
  color: var(--secondary-color);
  text-decoration: none;
  transition: all 0.3s ease;
  font-weight: 500;
  white-space: nowrap;
  margin: 0 10px;
  display: inline-block;
  margin-bottom: 5px;
}

.nav-link:hover {
  color: var(--secondary-color);
  transform: translateY(-2px);
}

.contact-item {
  margin-bottom: 0.75rem;
  display: flex;
  align-items: center;
}

.contact-icon {
  color: var(--secondary-color);
  width: 16px;
  height: 16px;
  margin-right: 8px;
}

.copyright-text {
  text-align: center;
}

.row {
  display: flex;
  flex-wrap: wrap;
  margin-right: -15px;
  margin-left: -15px;
}

.col-md-6 {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}

@media (min-width: 768px) {
  .col-md-6 {
    flex: 0 0 50%;
    max-width: 50%;
  }
  
  .footer-contact {
    text-align: right;
  }
  
  .contact-item {
    justify-content: flex-end;
  }
}

@media (max-width: 768px) {
  .footer-nav {
    text-align: center;
    margin-bottom: 15px;
  }
  
  .footer-contact {
    text-align: center;
  }
  
  .contact-item {
    justify-content: center;
  }
  
  .footer-bottom {
    flex-direction: column;
    align-items: center;
  }
  
  .footer-copyright {
    text-align: center;
    margin-bottom: 15px;
  }
  
  .footer-social {
    text-align: center;
  }
  
  .footer-social a {
    margin: 0 10px;
  }
}
</style>