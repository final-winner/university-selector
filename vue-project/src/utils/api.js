// API基础配置
export const API_BASE_URL = 'http://localhost:8080';

/**
 * 通用API请求函数
 * @param {string} url - 请求地址
 * @param {object} options - 请求选项
 * @returns {Promise} - 返回Promise对象
 */
export async function apiRequest(url, options = {}) {
  try {
    const response = await fetch(`${API_BASE_URL}${url}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...options.headers
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error('API request failed:', error);
    throw error;
  }
}

/**
 * 院校相关API
 */
export const universityApi = {
  /**
   * 获取所有院校列表
   * @returns {Promise} - 院校列表
   */
  getAllUniversities: () => apiRequest('/university/list'),

  /**
   * 获取院校详情
   * @param {number} id - 院校ID
   * @returns {Promise} - 院校详情
   */
  getUniversityById: (id) => apiRequest(`/university/detail/${id}`),

  /**
   * 获取院校学院列表
   * @param {number} id - 院校ID
   * @returns {Promise} - 学院列表
   */
  getCollegesByUniversityId: (id) => apiRequest(`/university/colleges/${id}`)
};

/**
 * 用户相关API
 */
export const userApi = {
  /**
   * 登录
   * @param {object} credentials - 登录凭证
   * @returns {Promise} - 登录结果
   */
  login: (credentials) => apiRequest('/user/login', {
    method: 'POST',
    body: JSON.stringify(credentials)
  }),

  /**
   * 注册
   * @param {object} userData - 用户数据
   * @returns {Promise} - 注册结果
   */
  register: (userData) => apiRequest('/user/register', {
    method: 'POST',
    body: JSON.stringify(userData)
  }),

  /**
   * 找回密码
   * @param {object} data - 找回密码数据
   * @returns {Promise} - 找回密码结果
   */
  forgotPassword: (data) => apiRequest('/user/forgot-password', {
    method: 'POST',
    body: JSON.stringify(data)
  }),

  /**
   * 获取用户收藏列表
   * @param {number} userId - 用户ID
   * @returns {Promise} - 收藏列表
   */
  getFavorites: (userId) => apiRequest(`/user/favorite/${userId}`),

  /**
   * 添加收藏
   * @param {object} data - 收藏数据
   * @returns {Promise} - 添加结果
   */
  addFavorite: (data) => apiRequest('/user/favorite/add', {
    method: 'POST',
    body: JSON.stringify(data)
  }),

  /**
   * 移除收藏
   * @param {object} data - 收藏数据
   * @returns {Promise} - 移除结果
   */
  removeFavorite: (data) => apiRequest('/user/favorite/remove', {
    method: 'POST',
    body: JSON.stringify(data)
  })
};
