<template>
  <div class="register">
    <div class="register-bg-orb"></div>
    <div class="register-bg-orb"></div>
    <div class="register-bg-orb"></div>
    <div class="register-bg-orb"></div>
    <div class="register-bg-orb"></div>
    <div class="register-container">
      <div class="register-card">
        <div class="register-header">
          <h1>用户注册</h1>
          <p>加入408考研择校辅助系统</p>
        </div>
        <form @submit.prevent="handleRegister">
          <div class="form-group">
            <label>用户名</label>
            <input
              type="text"
              v-model="registerForm.username"
              placeholder="请输入用户名"
              required
            />
          </div>
          <div class="form-group">
            <label>邮箱</label>
            <input
              type="email"
              v-model="registerForm.email"
              placeholder="请输入邮箱"
              required
            />
          </div>
          <div class="form-group">
            <label>密码</label>
            <input
              type="password"
              v-model="registerForm.password"
              placeholder="请输入密码"
              required
            />
          </div>
          <div class="form-group">
            <label>确认密码</label>
            <input
              type="password"
              v-model="registerForm.confirmPassword"
              placeholder="请再次输入密码"
              required
            />
          </div>
          <div class="form-group">
            <label class="checkbox-label">
              <input type="checkbox" v-model="registerForm.agree" required />
              <span>我已阅读并同意<a href="#" class="terms-link">用户协议</a>和<a href="#" class="terms-link">隐私政策</a></span>
            </label>
          </div>
          <button type="submit" class="btn btn-primary">注册</button>
        </form>
        <div class="register-footer">
          <p>已有账号？<router-link to="/login">立即登录</router-link></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

export default {
  name: 'Register',
  setup() {
    const router = useRouter()
    const registerForm = ref({
      username: '',
      email: '',
      password: '',
      confirmPassword: '',
      agree: false
    })

    const handleRegister = () => {
      if (registerForm.value.password !== registerForm.value.confirmPassword) {
        alert('两次输入的密码不一致')
        return
      }
      console.log('注册信息:', registerForm.value)
      alert('注册成功！')
      router.push('/login')
    }

    return {
      registerForm,
      handleRegister
    }
  }
}
</script>

<style scoped>
.register {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: white;
  padding: 20px;
  position: relative;
  overflow: hidden;
}

.register::after {
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

.register-bg-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(40px);
  opacity: 0.8;
  animation: float 15s ease-in-out infinite;
}

.register-bg-orb:nth-child(1) {
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, rgba(255, 107, 53, 0.4) 0%, transparent 70%);
  top: -100px;
  left: -100px;
  animation-delay: 0s;
}

.register-bg-orb:nth-child(2) {
  width: 350px;
  height: 350px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.4) 0%, transparent 70%);
  bottom: -100px;
  right: -100px;
  animation-delay: -5s;
}

.register-bg-orb:nth-child(3) {
  width: 300px;
  height: 300px;
  background: radial-gradient(circle, rgba(123, 97, 255, 0.4) 0%, transparent 70%);
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  animation-delay: -10s;
}

.register-bg-orb:nth-child(4) {
  width: 250px;
  height: 250px;
  background: radial-gradient(circle, rgba(0, 196, 140, 0.3) 0%, transparent 70%);
  top: 20%;
  right: 10%;
  animation-delay: -3s;
}

.register-bg-orb:nth-child(5) {
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

.register-container {
  width: 100%;
  max-width: 420px;
  position: relative;
  z-index: 1;
}

.register-card {
  background: white;
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 2px solid #e6f0ff;
  position: relative;
  overflow: hidden;
}

.register-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, transparent, #ff7d00, transparent);
  animation: shimmer 3s linear infinite;
}

@keyframes shimmer {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(100%);
  }
}

.register-card::after {
  content: '';
  position: absolute;
  top: -50%;
  right: -50%;
  width: 100%;
  height: 100%;
  background: radial-gradient(circle, rgba(255, 125, 0, 0.08) 0%, transparent 70%);
  pointer-events: none;
}

.register-header {
  text-align: center;
  margin-bottom: 35px;
}

.register-header h1 {
  font-size: 2.2rem;
  font-weight: 700;
  color: #1a365d;
  margin-bottom: 12px;
  letter-spacing: 2px;
}

.register-header p {
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

.form-group input[type="text"],
.form-group input[type="email"],
.form-group input[type="password"] {
  width: 100%;
  padding: 14px 18px;
  border: 2px solid #e6f0ff;
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: white;
  color: #1a365d;
}

.form-group input[type="text"]::placeholder,
.form-group input[type="email"]::placeholder,
.form-group input[type="password"]::placeholder {
  color: #889099;
}

.form-group input[type="text"]:focus,
.form-group input[type="email"]:focus,
.form-group input[type="password"]:focus {
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
  gap: 12px;
  cursor: pointer;
  font-size: 0.9rem;
  color: #889099;
}

.checkbox-label input {
  width: 18px;
  height: 18px;
  cursor: pointer;
  accent-color: #ff7d00;
  margin-right: 12px;
}

.terms-link {
  color: #ff7d00;
  text-decoration: none;
  transition: all 0.3s ease;
}

.terms-link:hover {
  color: #e67300;
  text-decoration: none;
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

.register-footer {
  text-align: center;
  margin-top: 28px;
  padding-top: 24px;
  border-top: 1px solid #e6f0ff;
}

.register-footer p {
  color: #889099;
  font-size: 0.9rem;
  margin: 0;
}

.register-footer a {
  color: #ff7d00;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
}

.register-footer a:hover {
  color: #e67300;
  text-decoration: none;
}

@media (max-width: 480px) {
  .register-card {
    padding: 35px 25px;
  }

  .register-header h1 {
    font-size: 1.8rem;
  }
}
</style>