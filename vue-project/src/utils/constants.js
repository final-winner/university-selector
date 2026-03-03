/**
 * 常量定义
 */

// 院校层次
export const UNIVERSITY_LEVELS = {
  C9: 'C9',
  '985': '985',
  '211': '211',
  DOUBLE_FIRST_CLASS: '双一流',
  DOUBLE_NON: '双非'
};

// 院校类型
export const UNIVERSITY_TYPES = {
  COMPREHENSIVE: '综合类',
  SCIENCE: '理工类',
  NORMAL: '师范类',
  AGRICULTURAL: '农林类',
  MEDICAL: '医药类',
  FINANCIAL: '财经类',
  POLITICAL: '政法类',
  LANGUAGE: '语言类',
  NATIONAL: '民族类',
  ART: '艺术类',
  SPORTS: '体育类',
  OTHER: '其他'
};

// 考研分区
export const EXAM_REGIONS = {
  REGION_A: 'A区',
  REGION_B: 'B区'
};

// 硕士类型
export const MASTER_TYPES = {
  ACADEMIC: '学硕',
  PROFESSIONAL: '专硕'
};

// 路由名称
export const ROUTES = {
  HOME: '/',
  UNIVERSITY_LIST: '/university-list',
  UNIVERSITY_DETAIL: '/university-detail',
  RECOMMEND: '/recommend',
  COMPARE: '/compare',
  LOGIN: '/login',
  REGISTER: '/register',
  FORGOT_PASSWORD: '/forgot-password',
  PROFILE: '/profile'
};

// 需要认证的路由
export const AUTH_ROUTES = [
  ROUTES.UNIVERSITY_LIST,
  ROUTES.RECOMMEND,
  ROUTES.COMPARE,
  ROUTES.PROFILE
];

// 消息提示类型
export const TOAST_TYPES = {
  SUCCESS: 'success',
  ERROR: 'error',
  INFO: 'info',
  WARNING: 'warning'
};
