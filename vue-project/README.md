# 408考研择校辅助系统 - Vue前端项目

## 项目简介

这是一个基于Vue 3 + Vite的现代化前端项目，为408考研择校辅助系统提供用户界面。项目采用前后端分离架构，前端独立部署，通过RESTful API与Spring Boot后端通信。

## 技术栈

- **前端框架**: Vue 3 (Composition API)
- **构建工具**: Vite
- **路由管理**: Vue Router 4
- **UI框架**: Bootstrap 5
- **图标库**: Bootstrap Icons
- **图表库**: ECharts

## 项目结构

```
vue-project/
├── public/                 # 静态资源
│   └── image/             # 图片资源
├── src/
│   ├── assets/            # 资源文件
│   │   └── css/           # 全局样式
│   ├── components/        # Vue组件
│   │   ├── NavBar.vue     # 导航栏组件
│   │   └── Footer.vue     # 页脚组件
│   ├── router/            # 路由配置
│   │   └── index.js       # 路由定义
│   ├── views/             # 页面组件
│   │   ├── Home.vue              # 首页
│   │   ├── UniversityList.vue    # 院校列表页
│   │   ├── UniversityDetail.vue  # 院校详情页
│   │   ├── Recommend.vue         # 智能推荐页
│   │   ├── Compare.vue           # 数据对比页
│   │   ├── Login.vue             # 登录页
│   │   └── Register.vue          # 注册页
│   ├── App.vue            # 根组件
│   └── main.js            # 入口文件
├── index.html             # HTML模板
├── package.json           # 项目依赖
└── vite.config.js         # Vite配置
```

## 快速开始

### 1. 安装依赖

```bash
cd vue-project
npm install
```

### 2. 启动开发服务器

```bash
npm run dev
```

项目将在 `http://localhost:3000` 启动，并自动打开浏览器。

### 3. 构建生产版本

```bash
npm run build
```

构建后的文件将输出到 `dist` 目录。

### 4. 预览生产版本

```bash
npm run preview
```

## 功能特性

### 已实现功能

1. **首页**
   - 院校展示
   - 功能特点介绍
   - 热门院校推荐

2. **院校列表**
   - 院校卡片展示
   - 收藏功能
   - 筛选功能

3. **院校详情**
   - 院校基本信息
   - 院校排名
   - 专业设置
   - 招生信息
   - 数据可视化（ECharts图表）

4. **智能推荐**
   - 表单填写
   - 智能推荐算法
   - 推荐结果展示

5. **数据对比**
   - 多院校对比
   - 对比结果展示

6. **用户系统**
   - 用户登录
   - 用户注册

### 技术特性

1. **组件化开发**
   - 导航栏和页脚组件化
   - 页面组件化
   - 代码复用性高

2. **响应式设计**
   - 支持移动端和桌面端
   - Bootstrap 5响应式布局

3. **路由管理**
   - Vue Router 4
   - 页面切换流畅

4. **状态管理**
   - Vue 3 Composition API
   - 响应式数据

5. **跨域处理**
   - Vite代理配置
   - 开发环境无缝对接后端

## 配置说明

### Vite代理配置

在 `vite.config.js` 中配置了API代理：

```javascript
server: {
  port: 3000,
  open: true,
  proxy: {
    '/api': {
      target: 'http://localhost:8080',
      changeOrigin: true
    }
  }
}
```

这样前端请求 `/api/*` 的接口会自动转发到 `http://localhost:8080/api/*`，解决跨域问题。

### 路由配置

路由配置在 `src/router/index.js` 中：

```javascript
const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/university-list', name: 'UniversityList', component: UniversityList },
  { path: '/university-detail/:id', name: 'UniversityDetail', component: UniversityDetail },
  { path: '/recommend', name: 'Recommend', component: Recommend },
  { path: '/compare', name: 'Compare', component: Compare },
  { path: '/login', name: 'Login', component: Login },
  { path: '/register', name: 'Register', component: Register }
]
```

## 部署说明

### 开发环境部署

1. 启动Spring Boot后端（端口8080）
2. 启动Vue前端（端口3000）
3. 通过 `npm run dev` 启动开发服务器

### 生产环境部署

#### 方式1：前后端分离部署

1. **前端部署**
   ```bash
   npm run build
   ```
   将 `dist` 目录部署到Nginx或其他Web服务器

2. **后端部署**
   部署Spring Boot应用到服务器

3. **Nginx配置**
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;

       location / {
           root /path/to/dist;
           try_files $uri $uri/ /index.html;
       }

       location /api {
           proxy_pass http://localhost:8080;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
       }
   }
   ```

#### 方式2：集成部署（推荐）

1. **构建前端**
   ```bash
   npm run build
   ```

2. **复制到Spring Boot**
   将 `dist` 目录下的所有文件复制到Spring Boot项目的 `src/main/resources/static` 目录

3. **打包Spring Boot**
   ```bash
   mvn clean package
   ```

4. **运行**
   ```bash
   java -jar your-app.jar
   ```

这种方式部署后，前后端统一由Spring Boot提供服务，无需处理跨域问题。

## 开发注意事项

1. **API调用**
   - 所有API请求都应使用 `/api` 前缀
   - 示例：`fetch('/api/universities')`

2. **样式开发**
   - 全局样式放在 `src/assets/css/global.css`
   - 组件样式使用 `<style scoped>`

3. **组件开发**
   - 使用Vue 3 Composition API
   - 组件命名使用PascalCase
   - 文件名与组件名保持一致

4. **路由跳转**
   - 使用 `<router-link>` 进行页面跳转
   - 使用 `useRouter()` 进行编程式导航

## 常见问题

### 1. npm install 失败

**解决方案**：
- 检查网络连接
- 使用国内镜像：`npm config set registry https://registry.npmmirror.com`
- 删除 `node_modules` 和 `package-lock.json`，重新安装

### 2. 端口被占用

**解决方案**：
- 修改 `vite.config.js` 中的端口号
- 或者关闭占用3000端口的程序

### 3. 跨域问题

**解决方案**：
- 确保Vite代理配置正确
- 检查后端是否正常运行
- 确认API请求路径以 `/api` 开头

### 4. 页面刷新404

**解决方案**：
- 开发环境：Vite会自动处理
- 生产环境：Nginx配置 `try_files $uri $uri/ /index.html;`

## 后续优化建议

1. **性能优化**
   - 路由懒加载
   - 组件按需加载
   - 图片懒加载

2. **用户体验**
   - 添加加载动画
   - 优化错误提示
   - 添加骨架屏

3. **功能扩展**
   - 用户权限管理
   - 数据持久化
   - 搜索功能优化

4. **代码质量**
   - 添加ESLint
   - 添加Prettier
   - 添加单元测试

## 联系方式

- 客服热线：18888888888
- 客服邮箱：431149990@qq.com
- 服务时间：周一至周日 9:00-22:00

## 版权信息

© 2026 408考研择校辅助工具 版权所有