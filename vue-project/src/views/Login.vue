<template>
  <div class="login">
    <div class="login-bg-orb"></div>
    <div class="login-bg-orb"></div>
    <div class="login-bg-orb"></div>
    <div class="login-bg-orb"></div>
    <div class="login-bg-orb"></div>
    <div class="login-container">
      <div class="login-card">
        <div class="login-header">
          <h1>用户登录</h1>
          <p>欢迎回到408考研择校辅助系统</p>
        </div>
        <form @submit.prevent="handleLogin">
          <div class="form-group">
            <label>用户名</label>
            <input
              type="text"
              v-model="loginForm.username"
              placeholder="请输入用户名"
              required
            />
          </div>
          <div class="form-group">
            <label>密码</label>
            <input
              type="password"
              v-model="loginForm.password"
              placeholder="请输入密码"
              required
            />
          </div>
          <div class="form-options">
            <label class="checkbox-label">
              <input type="checkbox" v-model="loginForm.remember" />
              <span>记住我</span>
            </label>
            <a href="#" class="forgot-password">忘记密码？</a>
          </div>
          <button type="submit" class="btn btn-primary">登录</button>
        </form>
        <div class="login-footer">
          <p>还没有账号？<router-link to="/register">立即注册</router-link></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

export default {
  name: 'Login',
  setup() {
    const router = useRouter()
    const loginForm = ref({
      username: '',
      password: '',
      remember: false
    })

    const handleLogin = () => {
      console.log('登录信息:', loginForm.value)
      alert('登录成功！')
      router.push('/')
    }

    return {
      loginForm,
      handleLogin
    }
  }
}
</script>

<style scoped>
.login {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: white;
  padding: 20px;
  position: relative;
  overflow: hidden;
}

.login::after {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle at center, rgba(30, 58, 138, 0.1) 0%, transparent 50%);
  animation: pulse 8s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 0.5;
    transform: scale(1);
  }
  50% {
    opacity: 1;
    transform: scale(1.1);
  }
}

.login-bg-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(40px);
  opacity: 0.8;
  animation: float 15s ease-in-out infinite;
}

.login-bg-orb:nth-child(1) {
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, rgba(255, 107, 53, 0.4) 0%, transparent 70%);
  top: -100px;
  left: -100px;
  animation-delay: 0s;
}

.login-bg-orb:nth-child(2) {
  width: 350px;
  height: 350px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.4) 0%, transparent 70%);
  bottom: -100px;
  right: -100px;
  animation-delay: -5s;
}

.login-bg-orb:nth-child(3) {
  width: 300px;
  height: 300px;
  background: radial-gradient(circle, rgba(123, 97, 255, 0.4) 0%, transparent 70%);
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  animation-delay: -10s;
}

.login-bg-orb:nth-child(4) {
  width: 250px;
  height: 250px;
  background: radial-gradient(circle, rgba(0, 196, 140, 0.3) 0%, transparent 70%);
  top: 20%;
  right: 10%;
  animation-delay: -3s;
}

.login-bg-orb:nth-child(5) {
  width: 280px;
  height: 280px;
  background: radial-gradient(circle, rgba(255, 177, 66, 0.3) 0%, transparent 70%);
  bottom: 20%;
  left: 10%;
  animation-delay: -7s;
}

@keyframes float {
  0%, 100% {
    transform: translate(0, 0) scale(1);
  }
  25% {
    transform: translate(30px, -30px) scale(1.1);
  }
  50% {
    transform: translate(-20px, 20px) scale(0.9);
  }
  75% {
    transform: translate(-30px, -20px) scale(1.05);
  }
}

.login-container {
  width: 100%;
  max-width: 420px;
  position: relative;
  z-index: 1;
}

.login-card {
  background: white;
  border-radius: 20px;
  padding: 45px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 2px solid #e6f0ff;
  position: relative;
  overflow: hidden;
}

.login-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, transparent, #ff7d00, transparent);
  animation: shimmer 3s linear infinite;
}

.login-card::after {
  content: '';
  position: absolute;
  top: -50%;
  right: -50%;
  width: 100%;
  height: 100%;
  background: radial-gradient(circle, rgba(255, 125, 0, 0.08) 0%, transparent 70%);
  pointer-events: none;
}

@keyframes shimmer {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(100%);
  }
}

.login-header {
  text-align: center;
  margin-bottom: 35px;
}

.login-header h1 {
  font-size: 2.2rem;
  font-weight: 700;
  color: #1a365d;
  margin-bottom: 12px;
  letter-spacing: 2px;
}

.login-header p {
  color: #889099;
  font-size: 0.95rem;
  letter-spacing: 1px;
}

.form-group {
  margin-bottom: 24px;
}

.form-group label {
  display: block;
  font-weight: 600;
  color: #1a365d;
  margin-bottom: 10px;
  font-size: 0.9rem;
  letter-spacing: 0.5px;
}

.form-group input {
  width: 100%;
  padding: 14px 18px;
  border: 2px solid #e6f0ff;
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: white;
  color: #1a365d;
}

.form-group input::placeholder {
  color: #889099;
}

.form-group input:focus {
  outline: none;
  border-color: #ff7d00;
  box-shadow: 0 0 0 3px rgba(255, 125, 0, 0.1);
  background: white;
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 28px;
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  font-size: 0.9rem;
  color: #889099;
}

.checkbox-label input {
  width: 18px;
  height: 18px;
  cursor: pointer;
  accent-color: #ff7d00;
}

.forgot-password {
  color: #ff7d00;
  text-decoration: none;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.forgot-password:hover {
  color: #e67300;
  text-decoration: none;
  transform: translateY(-2px);
}

.btn {
  width: 100%;
  padding: 16px;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  transition: all 0.3s ease;
  border: none;
  cursor: pointer;
  letter-spacing: 1px;
  position: relative;
  overflow: hidden;
}

.btn-primary {
  background: #1E3A8A;
  color: white;
  box-shadow: 0 4px 15px rgba(30, 58, 138, 0.3);
}

.btn-primary::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transition: left 0.5s ease;
}

.btn-primary:hover::before {
  left: 100%;
}

.btn-primary:hover {
  background: #1E40AF;
  transform: translateY(-3px);
  box-shadow: 0 6px 20px rgba(30, 58, 138, 0.4);
}

.login-footer {
  text-align: center;
  margin-top: 28px;
  padding-top: 24px;
  border-top: 1px solid #e6f0ff;
}

.login-footer p {
  color: #889099;
  font-size: 0.9rem;
  margin: 0;
}

.login-footer a {
  color: #ff7d00;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
}

.login-footer a:hover {
  color: #e67300;
  text-decoration: none;
}

@media (max-width: 480px) {
  .login-card {
    padding: 35px 25px;
  }

  .login-header h1 {
    font-size: 1.8rem;
  }
}
</style>