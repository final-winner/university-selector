/*
 Navicat Premium Dump SQL

 Source Server         : gechang
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : localhost:3306
 Source Schema         : university_selector

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

 Date: 03/03/2026 19:56:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
                               `id` int NOT NULL AUTO_INCREMENT COMMENT '院系唯一主键',
                               `university_id` int NOT NULL COMMENT '关联院校表的ID',
                               `campus_id` int NULL DEFAULT NULL COMMENT '关联校区表的ID',
                               `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '院系全称（如：计算机科学与技术系）',
                               `short_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院系简称（如：计科院）',
                               `website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院系官网地址',
                               `contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院系联系电话/邮箱',
                               `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '院系简介',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `uk_university_department`(`university_id` ASC, `name` ASC) USING BTREE,
                               INDEX `idx_university_id`(`university_id` ASC) USING BTREE,
                               INDEX `fk_department_campus`(`campus_id` ASC) USING BTREE,
                               CONSTRAINT `fk_department_campus` FOREIGN KEY (`campus_id`) REFERENCES `university_campus` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
                               CONSTRAINT `fk_department_university` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1049 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校院系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1001, 1, 1, '计算机科学与技术系', '计科系', 'https://www.cs.tsinghua.edu.cn/', '010-62782190', '清华大学计算机科学与技术系是国内顶尖计算机院系，学硕考11408，专硕考22408，学科实力全国第一', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1002, 2, 5, '信息科学技术学院', '信息学院', 'https://eecs.pku.edu.cn/', '010-62751824', '北京大学信息科学技术学院计算机专业统考408，学硕11408/专硕22408，科研资源雄厚', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1003, 9, 21, '计算机学院', '计科院', 'https://cs.fudan.edu.cn/', '021-65642363', '复旦大学计算机学院学硕考11408，专硕改考22408，复试线稳定在370+', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1004, 11, 28, '电子信息与电气工程学院', '电院', 'https://ee.sjtu.edu.cn/', '021-34204830', '上海交通大学电院计算机专硕考22408，学硕考11408，工科实力顶尖', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1005, 15, 40, '计算机科学与技术学院', '计科院', 'https://cs.zju.edu.cn/', '0571-87951300', '浙江大学计算机学院学硕11408/专硕22408，计算机学科评估A+', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1006, 13, 34, '计算机科学与技术系', '计科系', 'https://cs.nju.edu.cn/', '025-83593635', '南京大学计算机系统考408，学硕11408/专硕22408，基础学科底蕴深厚', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1007, 16, 45, '计算机科学与技术学院', '计科院', 'https://cs.ustc.edu.cn/', '0551-63601683', '中国科大大计院学硕11408/专硕22408，人工智能方向特色鲜明', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1008, 37, 112, '计算机科学与技术学院', '计科院', 'https://cs.hit.edu.cn/', '0451-86413431', '哈工大计算机学院学硕11408/专硕22408，深圳校区复试线355+', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1009, 30, 90, '计算机科学与技术学院', '计科院', 'https://cs.xjtu.edu.cn/', '029-82668173', '西安交大计算机学院学硕11408/专硕22408，工科传统强院', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1010, 4, 11, '计算机学院', '计科院', 'https://cs.buaa.edu.cn/', '010-82317114', '北航计算机学院学硕11408/专硕22408，航空航天领域计算机应用优势突出', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1011, 20, 59, '计算机学院', '计科院', 'https://cs.whu.edu.cn/', '027-68752843', '武汉大学计算机学院学硕11408/专硕22408，复试线360+', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1012, 21, 63, '计算机科学与技术学院', '计科院', 'https://cs.hust.edu.cn/', '027-87543041', '华中科大计算机学院学硕11408/专硕22408，计算机学科评估A', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1013, 25, 73, '计算机学院', '计科院', 'https://cs.sysu.edu.cn/', '020-84113260', '中山大学计算机学院学硕11408/专硕22408，华南地区计算机强院', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1014, 26, 78, '计算机科学与工程学院', '计工院', 'https://cs.scut.edu.cn/', '020-87110737', '华南理工计算机学院学硕11408/专硕22408，工科应用特色鲜明', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1015, 28, 84, '计算机学院', '计科院', 'https://cs.scu.edu.cn/', '028-85460739', '四川大学计算机学院学硕11408/专硕22408，西南地区认可度高', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1016, 29, 87, '计算机科学与工程学院', '计工院', 'https://cs.uestc.edu.cn/', '028-61831136', '电子科技大学计工院学硕11408/专硕22408，电子信息领域顶尖', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1017, 18, 51, '计算机科学与技术学院', '计科院', 'https://cs.sdu.edu.cn/', '0531-88364231', '山东大学计算机学院学硕11408/专硕22408，青岛校区有专项招生', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1018, 36, 107, '计算机科学与技术学院', '计科院', 'https://cs.jlu.edu.cn/', '0431-85168400', '吉林大学计算机学院2025改考408，学硕11408/专硕22408', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1019, 32, 119, '计算机科学与技术学院', '计科院', 'https://cs.tju.edu.cn/', '022-27406032', '天津大学计算机学院学硕11408/专硕22408，工科底蕴深厚', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1020, 38, 116, '计算机与控制工程学院', '计控院', 'https://cse.nankai.edu.cn/', '022-23508227', '南开大学计控院学硕11408/专硕22408，文理交叉特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1021, 17, 48, '计算机科学与技术学院', '计科院', 'https://cs.xmu.edu.cn/', '0592-2186385', '厦门大学计算机学院学硕11408/专硕22408，复试线335+', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1022, 22, 66, '信息科学与工程学院', '信息院', 'https://csee.hnu.edu.cn/', '0731-88822829', '湖南大学信息院学硕11408/专硕22408，计算机学科评估B+', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1023, 23, 68, '计算机学院', '计科院', 'https://cs.csu.edu.cn/', '0731-88879612', '中南大学计算机学院学硕11408/专硕22408，工科实力强劲', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1024, 27, 81, '计算机学院', '计科院', 'https://cs.cqu.edu.cn/', '023-65102385', '重庆大学计算机学院学硕11408/专硕22408，西南地区工科强院', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1025, 31, 94, '计算机学院', '计科院', 'https://cs.nwpu.edu.cn/', '029-88491843', '西北工大计算机学院学硕11408/专硕22408，三航领域特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1026, 10, 25, '计算机科学与技术学院', '计科院', 'https://cs.tongji.edu.cn/', '021-65982201', '同济大学计算机学院学硕11408/专硕22408，建筑信息化特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1027, 5, 12, '计算机学院', '计科院', 'https://cs.bit.edu.cn/', '010-68913854', '北京理工计算机学院学硕11408/专硕22408，国防科技特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1028, 12, 32, '计算机科学与技术学院', '计科院', 'https://cs.ecnu.edu.cn/', '021-62233448', '华东师大计算机学院学硕11408/专硕22408，教育信息化特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1029, 40, 122, '计算机学院', '计科院', 'https://cs.ccnu.edu.cn/', '027-67867788', '华中师大计算机学院学硕11408/专硕22408，教育AI方向突出', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1030, 47, 140, '计算机与信息工程学院', '计信院', 'https://computer.henu.edu.cn/', '0371-22868899', '河南大学计信院专硕考22408，学硕考11408，双一流学科支撑', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1031, 49, 147, '计算机学院', '计科院', 'https://cs.cug.edu.cn/', '027-67885085', '中国地质大学（武汉）计算机学院学硕11408/专硕22408，地理信息AI特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1032, 50, 148, '计算机科学与技术学院', '计科院', 'https://cs.cumt.edu.cn/', '0516-83590123', '中国矿业大学（徐州）计科院学硕11408/专硕22408，矿业智能化特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1033, 51, 150, '计算机与人工智能学院', '计智院', 'https://cs.whut.edu.cn/', '027-87858989', '武汉理工计智院学硕11408/专硕22408，智能交通特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1034, 52, 153, '信息学院', '信息院', 'https://info.hzau.edu.cn/', '027-87282008', '华中农大信息学院学硕11408/专硕22408，智慧农业特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1035, 53, 155, '信息科学技术学院', '信息学院', 'https://ist.jnu.edu.cn/', '020-85220066', '暨南大学信息学院学硕11408/专硕22408，侨校国际化特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1036, 54, 160, '计算机学院', '计科院', 'https://cs.scnu.edu.cn/', '020-85211098', '华南师大计算机学院学硕11408/专硕22408，教育AI特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1037, 55, 163, '信息学院', '信息院', 'https://info.lnu.edu.cn/', '024-62202345', '辽宁大学信息学院学硕11408/专硕22408，大数据特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1038, 56, 165, '计算机与电子信息学院', '计电院', 'https://ceit.nnu.edu.cn/', '025-85891888', '南京师大计电院学硕11408/专硕22408，智能教育特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1039, 57, 168, '计算机与通信工程学院', '计通院', 'https://cce.ustb.edu.cn/', '010-62332266', '北京科大计通院学硕11408/专硕22408，工业智能特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1040, 58, 170, '信息科学与工程学院', '信息学院', 'https://info.nbu.edu.cn/', '0574-87609123', '宁波大学信息学院学硕11408/专硕22408，海洋大数据特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1041, 59, 173, '计算机学院', '计科院', 'https://cs.hdu.edu.cn/', '0571-86919000', '杭州电子科技大学计科院学硕11408/专硕22408，电子信息特色鲜明', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1042, 60, 178, '计算机科学与技术学院', '计科院', 'https://cs.cqupt.edu.cn/', '023-62461688', '重庆邮电计科院学硕11408/专硕22408，通信与计算机融合特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1043, 61, 181, '计算机学院', '计科院', 'https://cs.njupt.edu.cn/', '025-85866666', '南京邮电计科院学硕11408/专硕22408，通信大数据特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1044, 62, 184, '计算机学院', '计科院', 'https://cs.xupt.edu.cn/', '029-88166688', '西安邮电计科院学硕11408/专硕22408，西部信息安全特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1045, 63, 186, '计算机学院', '计科院', 'https://cs.gdut.edu.cn/', '020-39322288', '广东工业计科院学硕11408/专硕22408，工业智能特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1046, 64, 191, '计算机与软件学院', '计软院', 'https://cs.szu.edu.cn/', '0755-26536114', '深圳大学计软院学硕11408/专硕22408，人工智能与云计算特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1047, 65, 195, '计算机学院', '计科院', 'https://cs.zjut.edu.cn/', '0571-88320123', '浙江工业计科院学硕11408/专硕22408，工业算法特色', '2026-03-02 22:53:43');
INSERT INTO `department` VALUES (1048, 66, 198, '计算机科学与通信工程学院', '计通院', 'https://ccce.ujs.edu.cn/', '0511-88791234', '江苏大学计通院学硕11408/专硕22408，智能装备特色', '2026-03-02 22:53:43');

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
                             `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏记录唯一标识',
                             `user_id` int NOT NULL COMMENT '用户id',
                             `major_id` int NULL DEFAULT NULL COMMENT '专业id（收藏专业时填写）',
                             `collect_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
                             `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                             `university_id` int NULL DEFAULT NULL COMMENT '院校id（收藏院校时填写）',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `uk_favorite_user_uni_major`(`user_id` ASC, `university_id` ASC, `major_id` ASC) USING BTREE COMMENT '用户+院校+专业组合唯一，防止重复收藏',
                             INDEX `major_id`(`major_id` ASC) USING BTREE,
                             INDEX `university_id`(`university_id` ASC) USING BTREE,
                             INDEX `idx_user_collect_time`(`user_id` ASC, `collect_time` DESC) USING BTREE,
                             CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                             CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`major_id`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                             CONSTRAINT `favorite_ibfk_3` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户收藏表（支持收藏专业/院校）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES (86, 3, NULL, '2026-02-20 23:39:44', NULL, 5);

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
                          `id` int NOT NULL AUTO_INCREMENT COMMENT '专业唯一主键\r\n\r\n',
                          `university_id` int NOT NULL COMMENT '关联院校表ID\r\n',
                          `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专业名称',
                          `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业代码',
                          `rating` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业评级（A+/A/B+等）',
                          `tuition` int NULL DEFAULT NULL COMMENT '学费',
                          `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '专业简介',
                          `retest_subjects` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '复试科目',
                          `schooling_length` tinyint NULL DEFAULT NULL COMMENT '学制',
                          `accept_transfer` enum('是','否') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受调剂（是/否）',
                          `master_type` enum('学硕','专硕') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '硕士类型（学硕/专硕）',
                          `dormitory` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宿舍情况',
                          `employment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '就业去向',
                          `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                          `exam_subjects` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '初试科目',
                          `department_id` int NOT NULL,
                          PRIMARY KEY (`id`) USING BTREE,
                          INDEX `university_id`(`university_id` ASC) USING BTREE,
                          INDEX `idx_department_id`(`department_id` ASC) USING BTREE,
                          CONSTRAINT `major_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                          CONSTRAINT `major_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 227 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '专业表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (217, 1, '计算机科学与技术', '081200', 'A+', 8000, '清华大学计算机学硕，统考11408，学科评估A+', '计算机系统结构、人工智能', 3, '否', '学硕', '四人间，独立卫浴', '互联网大厂、科研院所', '2026-03-02 23:03:02', '11408', 1001);
INSERT INTO `major` VALUES (218, 1, '计算机技术', '085404', 'A+', 10000, '清华大学计算机专硕，统考22408，深圳校区扩招', '软件工程、网络安全', 3, '否', '专硕', '四人间，独立卫浴', '互联网大厂、国企', '2026-03-02 23:03:02', '22408', 1001);
INSERT INTO `major` VALUES (219, 2, '计算机科学与技术', '081200', 'A', 8000, '北京大学计算机学硕，统考11408，复录比1.53', '高级操作系统、计算机网络', 3, '否', '学硕', '四人间，集中供暖', '互联网、金融科技', '2026-03-02 23:03:02', '11408', 1002);
INSERT INTO `major` VALUES (220, 2, '电子信息（计算机方向）', '085404', 'A', 10000, '北京大学计算机专硕，统考22408，复试线380+', '软件工程、数据库', 3, '否', '专硕', '四人间，集中供暖', '互联网、金融科技', '2026-03-02 23:03:02', '22408', 1002);
INSERT INTO `major` VALUES (221, 15, '计算机科学与技术', '081200', 'A+', 8000, '浙江大学计算机学硕，统考11408，报录比31.2:1', '计算机组成原理、算法设计', 3, '否', '学硕', '四人间，空调独卫', '阿里、腾讯、字节跳动', '2026-03-02 23:03:02', '11408', 1005);
INSERT INTO `major` VALUES (222, 15, '电子信息（计算机）', '085400', 'A+', 10000, '浙江大学计算机专硕，统考22408，平均分375.7', '软件工程、网络安全', 3, '否', '专硕', '四人间，空调独卫', '阿里、腾讯、字节跳动', '2026-03-02 23:03:02', '22408', 1005);
INSERT INTO `major` VALUES (223, 58, '计算机科学与技术', '081200', 'B', 8000, '宁波大学计算机学硕，统考11408，报录比9.6:1', '数据结构、操作系统', 3, '否', '学硕', '四人间，空调', '区域互联网企业、科研院所', '2026-03-02 23:03:02', '11408', 1040);
INSERT INTO `major` VALUES (224, 58, '计算机技术', '085404', 'B', 10000, '宁波大学计算机专硕，统考22408，不接受调剂', '计算机网络、软件工程', 3, '否', '专硕', '四人间，空调', '区域互联网企业、国企', '2026-03-02 23:03:02', '22408', 1040);
INSERT INTO `major` VALUES (225, 13, '计算机科学与技术', '081200', 'A', 8000, '南京大学计算机学硕，统考11408，复试线369', '算法设计、计算机系统', 3, '否', '学硕', '四人间，独立卫浴', '互联网、科研院所', '2026-03-02 23:03:02', '11408', 1006);
INSERT INTO `major` VALUES (226, 13, '软件工程（专硕）', '085405', 'A', 10000, '南京大学软件工程专硕，统考22408，复试线372', '软件工程、数据库', 3, '否', '专硕', '四人间，独立卫浴', '互联网、国企', '2026-03-02 23:03:02', '22408', 1006);

-- ----------------------------
-- Table structure for postgraduate_data
-- ----------------------------
DROP TABLE IF EXISTS `postgraduate_data`;
CREATE TABLE `postgraduate_data`  (
                                      `id` int NOT NULL AUTO_INCREMENT COMMENT '数据唯一标识',
                                      `major_id` int NOT NULL COMMENT '关联专业表ID\r\n',
                                      `enrollment_plan` int NULL DEFAULT NULL COMMENT '拟招生人数(约等于录取人数)',
                                      `year` int NOT NULL COMMENT '年份',
                                      `retest_score` int NULL DEFAULT NULL COMMENT '复试线',
                                      `data_source` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据来源',
                                      `apply_num` int NULL DEFAULT NULL COMMENT '报考人数',
                                      `retest_num` int NULL DEFAULT NULL COMMENT '复试人数',
                                      `admission_num` int NULL DEFAULT NULL COMMENT '录取人数',
                                      `highest_score` int NULL DEFAULT NULL COMMENT '最高分（拟录取分数）',
                                      `lowest_score` int NULL DEFAULT NULL COMMENT '最低分（拟录取分数）',
                                      `average_score` decimal(4, 1) NULL DEFAULT NULL COMMENT '平均分',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      UNIQUE INDEX `uk_major_year`(`major_id` ASC, `year` ASC) USING BTREE,
                                      INDEX `major_id`(`major_id` ASC) USING BTREE,
                                      CONSTRAINT `postgraduate_data_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `ck_postgraduate_average_score` CHECK ((`average_score` >= 0) and (`average_score` <= 500)),
                                      CONSTRAINT `ck_postgraduate_highest_score` CHECK ((`highest_score` >= 0) and (`highest_score` <= 500)),
                                      CONSTRAINT `ck_postgraduate_lowest_score` CHECK ((`lowest_score` >= 0) and (`lowest_score` <= 500)),
                                      CONSTRAINT `ck_postgraduate_retest_score` CHECK ((`retest_score` >= 0) and (`retest_score` <= 500))
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考研核心数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of postgraduate_data
-- ----------------------------
INSERT INTO `postgraduate_data` VALUES (1, 217, 45, 2023, 325, '清华大学深研院2025年录取公示', 1200, 55, 40, 428, 325, 375.2, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (2, 217, 42, 2024, 340, '清华大学深研院2025年录取公示', 1300, 53, 38, 435, 340, 382.5, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (3, 217, 40, 2025, 325, '清华大学深研院2025年录取公示', 1350, 50, 36, 440, 325, 378.8, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (4, 218, 80, 2023, 325, '清华大学深研院2025年录取公示', 1800, 96, 72, 430, 325, 365.5, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (5, 218, 78, 2024, 335, '清华大学深研院2025年录取公示', 1900, 94, 70, 432, 335, 370.2, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (6, 218, 46, 2025, 325, '清华大学深研院2025年录取公示', 2000, 55, 46, 425, 325, 368.7, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (7, 219, 17, 2023, 348, '北京大学研招网2024年录取公示', 260, 24, 8, 415, 348, 375.3, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (8, 219, 17, 2024, 380, '北京大学研招网2025年录取公示', 400, 26, 17, 430, 380, 402.1, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (9, 219, 15, 2025, 385, '北京大学研招网2025年录取公示', 420, 23, 15, 435, 385, 408.5, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (10, 220, 35, 2023, 365, '北京大学研招网2024年录取公示', 520, 44, 35, 420, 365, 388.7, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (11, 220, 38, 2024, 380, '北京大学研招网2025年录取公示', 580, 48, 38, 425, 380, 401.2, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (12, 220, 40, 2025, 382, '北京大学研招网2025年录取公示', 620, 50, 40, 430, 382, 405.6, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (13, 221, 48, 2023, 360, '浙江大学研究生院2024年报录比公示', 950, 60, 40, 428, 360, 385.4, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (14, 221, 45, 2024, 365, '浙江大学研究生院2025年报录比公示', 980, 56, 38, 432, 365, 390.7, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (15, 221, 42, 2025, 370, '浙江大学研究生院2025年报录比公示', 1000, 53, 35, 435, 370, 392.7, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (16, 222, 95, 2023, 350, '浙江大学研究生院2024年报录比公示', 1450, 114, 85, 420, 350, 372.3, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (17, 222, 92, 2024, 355, '浙江大学研究生院2025年报录比公示', 1520, 110, 82, 425, 355, 375.4, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (18, 222, 80, 2025, 360, '浙江大学研究生院2025年报录比公示', 1600, 96, 80, 430, 360, 375.7, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (19, 223, 20, 2023, 340, '宁波大学新东方在线2025报考指南', 120, 25, 16, 415, 340, 372.5, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (20, 223, 18, 2024, 350, '宁波大学新东方在线2025报考指南', 150, 23, 14, 420, 350, 378.3, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (21, 223, 20, 2025, 365, '宁波大学新东方在线2025报考指南', 192, 25, 8, 425, 365, 388.6, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (22, 224, 70, 2023, 330, '宁波大学新东方在线2025报考指南', 650, 84, 60, 410, 330, 365.2, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (23, 224, 68, 2024, 335, '宁波大学新东方在线2025报考指南', 680, 82, 58, 415, 335, 368.7, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (24, 224, 65, 2025, 340, '宁波大学新东方在线2025报考指南', 720, 78, 65, 420, 340, 372.4, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (25, 225, 13, 2023, 355, 'N诺考研2025年南京大学录取分析', 320, 16, 10, 410, 355, 378.6, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (26, 225, 12, 2024, 362, 'N诺考研2025年南京大学录取分析', 350, 15, 10, 415, 362, 384.3, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (27, 225, 10, 2025, 369, 'N诺考研2025年南京大学录取分析', 380, 13, 8, 420, 369, 384.0, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (28, 226, 109, 2023, 360, 'N诺考研2025年南京大学录取分析', 1320, 132, 100, 425, 360, 382.3, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (29, 226, 105, 2024, 368, 'N诺考研2025年南京大学录取分析', 1450, 138, 105, 430, 368, 387.5, '2026-03-02 23:03:02');
INSERT INTO `postgraduate_data` VALUES (30, 226, 100, 2025, 372, 'N诺考研2025年南京大学录取分析', 1580, 132, 100, 430, 372, 389.0, '2026-03-02 23:03:02');

-- ----------------------------
-- Table structure for university
-- ----------------------------
DROP TABLE IF EXISTS `university`;
CREATE TABLE `university`  (
                               `id` int NOT NULL AUTO_INCREMENT COMMENT '院校唯一标识',
                               `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '院校名称',
                               `collection_num` int NOT NULL DEFAULT 0 COMMENT '收藏量，反映学校热门程度',
                               `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校地址',
                               `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '城市',
                               `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校代码',
                               `level` enum('C9','985','211','双一流','双非') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校层次',
                               `official_website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校官网',
                               `graduate_school_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校研究生院名称',
                               `graduate_school_website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校研究生院官网',
                               `A_B` enum('A区','B区') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '考研A/B区（A区/B区）',
                               `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份',
                               `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '院校简介',
                               `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校类型（综合类/理工类/师范类）',
                               `logo_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院校logo',
                               `region` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地区',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `uk_university_name`(`name` ASC) USING BTREE,
                               INDEX `idx_university_level`(`level` ASC) USING BTREE,
                               INDEX `idx_university_type`(`type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of university
-- ----------------------------
INSERT INTO `university` VALUES (1, '清华大学', 0, '北京市海淀区清华园1号', '北京', '10003', 'C9', 'https://www.tsinghua.edu.cn/', '清华大学研究生院', 'https://yz.tsinghua.edu.cn/', 'A区', '北京', '清华大学始建于1911年，是中国著名高等学府，坐落于北京清华园。作为顶尖研究型大学，拥有12个学科门类，在工程技术、计算机科学、经济管理等领域享誉世界。', '综合类', 'https://www.tsinghua.edu.cn/images/logo.png', '华北', '2026-02-20 12:09:34');
INSERT INTO `university` VALUES (2, '北京大学', 0, '北京市海淀区颐和园路5号', '北京', '10001', 'C9', 'https://www.pku.edu.cn/', '北京大学研究生院', 'https://grs.pku.edu.cn/', 'A区', '北京', '北京大学创办于1898年，初名京师大学堂，是中国第一所国立综合性大学。拥有强大的文理医工学科群，人文社科和自然科学均处于国内领先地位。', '综合类', 'https://www.pku.edu.cn/img/logo.png', '华北', '2026-02-20 12:09:34');
INSERT INTO `university` VALUES (3, '中国人民大学', 0, '北京市海淀区中关村大街59号', '北京', '10002', '985', 'https://www.ruc.edu.cn/', '中国人民大学研究生院', 'https://grs.ruc.edu.cn/', 'A区', '北京', '中国人民大学是中国共产党创办的第一所新型正规大学，以人文社会科学著称，被誉为\"中国人文社会科学的一面旗帜\"。', '综合类', 'https://www.ruc.edu.cn/logo.png', '华北', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (4, '北京航空航天大学', 0, '北京市海淀区学院路37号', '北京', '10006', '985', 'https://www.buaa.edu.cn/', '北京航空航天大学研究生院', 'https://graduate.buaa.edu.cn/', 'A区', '北京', '北京航空航天大学成立于1952年，是新中国的第一所航空航天高等学府，以航空航天、信息技术为特色，工科优势突出。', '理工类', 'https://www.buaa.edu.cn/logo.png', '华北', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (5, '北京理工大学', 0, '北京市海淀区中关村南大街5号', '北京', '10007', '985', 'https://www.bit.edu.cn/', '北京理工大学研究生院', 'https://grd.bit.edu.cn/', 'A区', '北京', '北京理工大学是中国共产党创办的第一所理工科大学，以国防科技为特色，在兵器科学与技术、车辆工程等领域具有显著优势。', '理工类', 'https://www.bit.edu.cn/logo.png', '华北', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (6, '中国农业大学', 0, '北京市海淀区清华东路17号', '北京', '10019', '985', 'https://www.cau.edu.cn/', '中国农业大学研究生院', 'https://grad.cau.edu.cn/', 'A区', '北京', '中国农业大学是我国现代农业高等教育的起源地，以农业生命科学、农业工程为特色，农业科学领域位居全国首位。', '农林类', 'https://www.cau.edu.cn/logo.png', '华北', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (7, '北京师范大学', 0, '北京市海淀区新街口外大街19号', '北京', '10027', '985', 'https://www.bnu.edu.cn/', '北京师范大学研究生院', 'https://graduate.bnu.edu.cn/', 'A区', '北京', '北京师范大学是教育部直属重点大学，以教师教育、教育科学和文理基础学科为主要特色，是中国师范教育的排头兵。', '师范类', 'https://www.bnu.edu.cn/logo.png', '华北', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (8, '中央民族大学', 0, '北京市海淀区中关村南大街27号', '北京', '10052', '985', 'https://www.muc.edu.cn/', '中央民族大学研究生院', 'https://grs.muc.edu.cn/', 'A区', '北京', '中央民族大学是中国少数民族教育的最高学府，拥有民族学、社会学等特色学科，为少数民族和民族地区培养人才。', '民族类', 'https://www.muc.edu.cn/logo.png', '华北', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (9, '复旦大学', 0, '上海市杨浦区邯郸路220号', '上海', '10246', 'C9', 'https://www.fudan.edu.cn/', '复旦大学研究生院', 'https://gs.fudan.edu.cn/', 'A区', '上海', '复旦大学创建于1905年，原名复旦公学，是中国人自主创办的第一所高等院校。文理医工均衡发展，新闻、经济、医学等学科享誉海内外。', '综合类', 'https://www.fudan.edu.cn/logo.png', '华东', '2026-02-20 12:09:34');
INSERT INTO `university` VALUES (10, '同济大学', 0, '上海市杨浦区四平路1239号', '上海', '10247', '985', 'https://www.tongji.edu.cn/', '同济大学研究生院', 'https://yz.tongji.edu.cn/', 'A区', '上海', '同济大学始建于1907年，是中国最早的国立大学之一。以土木建筑、城市规划、交通运输等学科著称，对德交流合作特色鲜明。', '理工类', 'https://www.tongji.edu.cn/logo.png', '华东', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (11, '上海交通大学', 0, '上海市闵行区东川路800号', '上海', '10248', 'C9', 'https://www.sjtu.edu.cn/', '上海交通大学研究生院', 'https://www.gs.sjtu.edu.cn/', 'A区', '上海', '上海交通大学创建于1896年，是我国历史最悠久的高等学府之一。在船舶海洋工程、机械工程、电子信息等领域具有强大实力。', '综合类', 'https://www.sjtu.edu.cn/logo.png', '华东', '2026-02-20 12:09:34');
INSERT INTO `university` VALUES (12, '华东师范大学', 0, '上海市普陀区中山北路3663号', '上海', '10269', '985', 'https://www.ecnu.edu.cn/', '华东师范大学研究生院', 'https://yz.ecnu.edu.cn/', 'A区', '上海', '华东师范大学成立于1951年，是教育部直属的全国重点师范大学。教育学、地理学、心理学等学科处于国内领先水平。', '师范类', 'https://www.ecnu.edu.cn/logo.png', '华东', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (13, '南京大学', 0, '江苏省南京市鼓楼区汉口路22号', '南京', '10284', 'C9', 'https://www.nju.edu.cn/', '南京大学研究生院', 'https://grawww.nju.edu.cn/', 'A区', '江苏', '南京大学前身是创建于1902年的三江师范学堂，是一所历史悠久、声誉卓著的高等学府。天文、地质、中文、历史等学科特色鲜明。', '综合类', 'https://www.nju.edu.cn/logo.png', '华东', '2026-02-20 12:09:34');
INSERT INTO `university` VALUES (14, '东南大学', 0, '江苏省南京市玄武区四牌楼2号', '南京', '10286', '985', 'https://www.seu.edu.cn/', '东南大学研究生院', 'https://yzb.seu.edu.cn/', 'A区', '江苏', '东南大学创建于1902年，是中国最早建立的高等学府之一。以建筑、土木、电子、交通等工科见长，建筑学享有\"建筑老八校\"美誉。', '理工类', 'https://www.seu.edu.cn/logo.png', '华东', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (15, '浙江大学', 0, '浙江省杭州市西湖区余杭塘路866号', '杭州', '10335', 'C9', 'https://www.zju.edu.cn/', '浙江大学研究生院', 'https://grs.zju.edu.cn/', 'A区', '浙江', '浙江大学的前身是求是书院，创建于1897年。学科门类齐全，工科、农学、医学、管理学等实力雄厚，被誉为\"东方剑桥\"。', '综合类', 'https://www.zju.edu.cn/logo.png', '华东', '2026-02-20 12:09:34');
INSERT INTO `university` VALUES (16, '中国科学技术大学', 0, '安徽省合肥市包河区金寨路96号', '合肥', '10358', 'C9', 'https://www.ustc.edu.cn/', '中国科学技术大学研究生院', 'https://gradschool.ustc.edu.cn/', 'A区', '安徽', '中国科学技术大学成立于1958年，由中国科学院创办。以理工科见长，物理、化学、地球物理等基础科学研究水平国际领先。', '理工类', 'https://www.ustc.edu.cn/logo.png', '华东', '2026-02-20 12:09:34');
INSERT INTO `university` VALUES (17, '厦门大学', 0, '福建省厦门市思明区思明南路422号', '厦门', '10384', '985', 'https://www.xmu.edu.cn/', '厦门大学研究生院', 'https://gs.xmu.edu.cn/', 'A区', '福建', '厦门大学由著名爱国华侨领袖陈嘉庚先生于1921年创办，是中国近代教育史上第一所华侨创办的大学。经济管理、化学、海洋科学等学科优势明显。', '综合类', 'https://www.xmu.edu.cn/logo.png', '华东', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (18, '山东大学', 0, '山东省济南市历城区山大南路27号', '济南', '10422', '985', 'https://www.sdu.edu.cn/', '山东大学研究生院', 'https://www.grad.sdu.edu.cn/', 'A区', '山东', '山东大学创建于1901年，是中国近代高等教育的起源性大学。数学、中国语言文学、临床医学等学科具有传统优势。', '综合类', 'https://www.sdu.edu.cn/logo.png', '华东', '2026-02-20 00:38:37');
INSERT INTO `university` VALUES (19, '中国海洋大学', 0, '山东省青岛市崂山区松岭路238号', '青岛', '10423', '985', 'https://www.ouc.edu.cn/', '中国海洋大学研究生院', 'https://grad.ouc.edu.cn/', 'A区', '山东', '中国海洋大学创建于1924年，是以海洋和水产学科为特色的教育部直属重点大学。海洋科学、水产学位居全国首位。', '理工类', '', '华东', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (20, '武汉大学', 0, '湖北省武汉市武昌区八一路299号', '武汉', '10486', '985', 'https://www.whu.edu.cn/', '武汉大学研究生院', 'https://gs.whu.edu.cn/', 'A区', '湖北', '武汉大学溯源于1893年自强学堂，是一所风景如画、人文荟萃的百年名校。测绘、法学、马克思主义理论等学科国内领先。', '综合类', '', '华中', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (21, '华中科技大学', 0, '湖北省武汉市洪山区珞喻路1037号', '武汉', '10487', '985', 'https://www.hust.edu.cn/', '华中科技大学研究生院', 'https://gs.hust.edu.cn/', 'A区', '湖北', '华中科技大学由原华中理工大学等合并组建，机械、光电、医学等学科实力雄厚，被誉为\"新中国高等教育发展的缩影\"。', '综合类', '', '华中', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (22, '湖南大学', 0, '湖南省长沙市岳麓区麓山南路2号', '长沙', '10532', '985', 'https://www.hnu.edu.cn/', '湖南大学研究生院', 'https://gra.hnu.edu.cn/', 'A区', '湖南', '湖南大学办学起源于公元976年创建的岳麓书院，是中国最古老的高等学府。土木工程、机械工程、化学等学科实力突出。', '综合类', '', '华中', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (23, '中南大学', 0, '湖南省长沙市岳麓区麓山南路932号', '长沙', '10533', '985', 'https://www.csu.edu.cn/', '中南大学研究生院', 'https://gra.csu.edu.cn/', 'A区', '湖南', '中南大学由原中南工业大学等合并组建，冶金工程、矿业工程、材料科学等学科享誉中外，湘雅医学院驰名海内。', '综合类', '', '华中', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (24, '国防科技大学', 0, '湖南省长沙市开福区德雅路109号', '长沙', '91002', '985', 'https://www.nudt.edu.cn/', '国防科技大学研究生院', 'https://www.nudt.edu.cn/yjsy/', 'A区', '湖南', '国防科技大学是直属中央军委领导的军队高等学府，计算机科学、航空航天、信息通信等领域处于国内顶尖水平。', '军事类', '', '华中', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (25, '中山大学', 0, '广东省广州市海珠区新港西路135号', '广州', '10558', '985', 'https://www.sysu.edu.cn/', '中山大学研究生院', 'https://graduate.sysu.edu.cn/', 'A区', '广东', '中山大学由孙中山先生于1924年创办，是一所文理医工全面发展的综合性大学。医学、管理学、哲学等学科优势明显。', '综合类', '', '华南', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (26, '华南理工大学', 0, '广东省广州市天河区五山路381号', '广州', '10561', '985', 'https://www.scut.edu.cn/', '华南理工大学研究生院', 'https://www2.scut.edu.cn/graduate/', 'A区', '广东', '华南理工大学创建于1952年，以工科见长，轻工技术与工程、建筑学、食品科学等学科位居全国前列，被誉为\"工程师的摇篮\"。', '理工类', '', '华南', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (27, '重庆大学', 0, '重庆市沙坪坝区沙正街174号', '重庆', '10611', '985', 'https://www.cqu.edu.cn/', '重庆大学研究生院', 'https://graduate.cqu.edu.cn/', 'A区', '重庆', '重庆大学创办于1929年，是西南地区最早的国立大学。土木工程、电气工程、机械工程等工科优势明显，建筑学特色突出。', '综合类', '', '西南', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (28, '四川大学', 0, '四川省成都市武侯区一环路南一段24号', '成都', '10610', '985', 'https://www.scu.edu.cn/', '四川大学研究生院', 'https://gs.scu.edu.cn/', 'A区', '四川', '四川大学由原四川大学等合并组建，华西医学中心享誉全国。口腔医学、生物医学、材料科学等学科处于国内领先水平。', '综合类', '', '西南', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (29, '电子科技大学', 0, '四川省成都市高新西区西源大道2006号', '成都', '10614', '985', 'https://www.uestc.edu.cn/', '电子科技大学研究生院', 'https://yz.uestc.edu.cn/', 'A区', '四川', '电子科技大学成立于1956年，是我国电子信息领域的顶尖学府。电子科学与技术、信息与通信工程等学科位居全国前列。', '理工类', '', '西南', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (30, '西安交通大学', 0, '陕西省西安市碑林区咸宁西路28号', '西安', '10698', 'C9', 'https://www.xjtu.edu.cn/', '西安交通大学研究生院', 'https://gs.xjtu.edu.cn/', 'A区', '陕西', '西安交通大学的前身是1896年创办的南洋公学，是我国最早兴办的高等学府之一。电气工程、动力工程、机械工程等工科实力雄厚。', '综合类', '', '西北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (31, '西北工业大学', 0, '陕西省西安市碑林区友谊西路127号', '西安', '10699', '985', 'https://www.nwpu.edu.cn/', '西北工业大学研究生院', 'https://gs.nwpu.edu.cn/', 'A区', '陕西', '西北工业大学以发展航空、航天、航海工程教育和科学研究为特色，是我国\"三航\"领域的重要人才培养和科学研究基地。', '理工类', '', '西北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (32, '天津大学', 0, '天津市南开区卫津路92号', '天津', '10056', '985', 'https://www.tju.edu.cn/', '天津大学研究生院', 'https://yzb.tju.edu.cn/', 'A区', '天津', '天津大学始建于1895年，前身为北洋大学，是中国第一所现代大学。以工科见长，建筑、水利、化工、机械等学科位居全国前列，是“建筑老八校”之一，被誉为“中国近代工程教育的摇篮”。', '理工类', '', '华北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (33, '兰州大学', 0, '甘肃省兰州市城关区天水南路222号', '兰州', '10730', '985', 'https://www.lzu.edu.cn/', '兰州大学研究生院', 'https://yjsy.lzu.edu.cn/', 'B区', '甘肃', '兰州大学创建于1909年，是我国西北地区最早的现代高等学府。草学、生态学、地理学等学科优势突出，素有\"西北名校\"之称。', '综合类', '', '西北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (34, '东北大学', 0, '辽宁省沈阳市和平区文化路三巷11号', '沈阳', '10145', '985', 'https://www.neu.edu.cn/', '东北大学研究生院', 'https://www.graduate.neu.edu.cn/', 'A区', '辽宁', '东北大学始建于1923年，是我国著名的工科大学。冶金工程、材料科学、控制科学与工程等学科实力雄厚，自动化领域特色突出。', '理工类', '', '东北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (35, '大连理工大学', 0, '辽宁省大连市甘井子区凌工路2号', '大连', '10141', '985', 'https://www.dlut.edu.cn/', '大连理工大学研究生院', 'https://gs.dlut.edu.cn/', 'A区', '辽宁', '大连理工大学创建于1949年，是我国著名的\"四大工学院\"之一。化学工程、力学、土木工程等学科处于国内领先地位。', '理工类', '', '东北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (36, '吉林大学', 0, '吉林省长春市朝阳区前进大街2699号', '长春', '10183', '985', 'https://www.jlu.edu.cn/', '吉林大学研究生院', 'https://yjsy.jlu.edu.cn/', 'A区', '吉林', '吉林大学由多所高校合并组建，学科门类齐全，规模宏大。化学、法学、考古学、车辆工程等学科享有盛誉。', '综合类', '', '东北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (37, '哈尔滨工业大学', 0, '黑龙江省哈尔滨市南岗区西大直街92号', '哈尔滨', '10213', 'C9', 'https://www.hit.edu.cn/', '哈尔滨工业大学研究生院', 'https://yzb.hit.edu.cn/', 'A区', '黑龙江', '哈尔滨工业大学始建于1920年，被誉为\"工程师的摇篮\"。航天、焊接、机器人等领域处于国内领先地位，为我国航天事业培养了大量人才。', '理工类', '', '东北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (38, '南开大学', 0, '天津市南开区卫津路94号', '天津', '10055', '985', 'https://www.nankai.edu.cn/', '南开大学研究生院', 'https://graduate.nankai.edu.cn/', 'A区', '天津', '南开大学成立于1919年，由著名教育家严修、张伯苓创办。经济学、历史学、化学、数学等基础学科实力雄厚。', '综合类', '', '华北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (39, '西北农林科技大学', 0, '陕西省咸阳市杨陵区邰城路3号', '咸阳', '10712', '985', 'https://www.nwsuaf.edu.cn/', '西北农林科技大学研究生院', 'https://yjshy.nwsuaf.edu.cn/', 'A区', '陕西', '西北农林科技大学是教育部直属的农林类重点大学，是我国干旱半干旱地区农业技术研究的重要基地，农林学科特色鲜明。', '农林类', '', '西北', '2026-03-02 22:18:17');
INSERT INTO `university` VALUES (40, '华中师范大学', 0, '湖北省武汉市洪山区珞喻路152号', '武汉', '10511', '211', 'https://www.ccnu.edu.cn/', '华中师范大学研究生院', 'https://gs.ccnu.edu.cn/', 'A区', '湖北', '华中师范大学是教育部直属重点综合性师范大学，国家 “211 工程” 重点建设高校，国家 “双一流” 建设高校。学校位于湖北省武汉市，学科门类齐全，在教育学、心理学、中国语言文学、历史学等人文社科领域实力雄厚，同时在计算机科学与技术、人工智能等工科方向也形成了鲜明的研究特色，是我国重要的师范教育与科研创新基地。', '师范类', NULL, '华中', '2026-02-21 00:43:22');
INSERT INTO `university` VALUES (41, '长安大学', 0, '陕西省西安市雁塔区南二环路中段', '西安', '10710', '211', 'https://www.chd.edu.cn/', '长安大学研究生院', 'https://yzb.chd.edu.cn/', 'A区', '陕西', '直属教育部，工科优势突出的211高校', '理工类', NULL, '西北', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (42, '江南大学', 0, '江苏省无锡市蠡湖大道1800号', '无锡', '10295', '211', 'https://www.jiangnan.edu.cn/', '江南大学研究生院', 'https://yz.jiangnan.edu.cn/', 'A区', '江苏', '轻工领域特色鲜明的211高校', '理工类', NULL, '华东', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (43, '苏州大学', 0, '江苏省苏州市姑苏区十梓街1号', '苏州', '10285', '211', 'https://www.suda.edu.cn/', '苏州大学研究生院', 'https://yjs.suda.edu.cn/', 'A区', '江苏', '江苏省属综合性211高校', '综合类', NULL, '华东', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (44, '河南工业大学', 0, '河南省郑州市高新技术产业开发区莲花街100号', '郑州', '10463', '双非', 'https://www.haut.edu.cn/', '河南工业大学研究生院', 'https://yjs.haut.edu.cn/', 'A区', '河南', '以粮食科学与工程为特色的双非高校', '理工类', NULL, '华中', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (45, '河南科技大学', 0, '河南省洛阳市洛龙区开元大道263号', '洛阳', '10464', '双非', 'https://www.haust.edu.cn/', '河南科技大学研究生院', 'https://yjsc.haust.edu.cn/', 'A区', '河南', '综合性省属双非高校', '综合类', NULL, '华中', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (46, '河南理工大学', 0, '河南省焦作市山阳区世纪路2001号', '焦作', '10460', '双非', 'https://www.hpu.edu.cn/', '河南理工大学研究生院', 'https://yjs.hpu.edu.cn/', 'A区', '河南', '矿业工程特色鲜明的双非高校', '理工类', NULL, '华中', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (47, '河南大学', 0, '河南省开封市顺河回族区明伦街85号', '开封', '10475', '双一流', 'https://www.henu.edu.cn/', '河南大学研究生院', 'https://grs.henu.edu.cn/', 'A区', '河南', '文理学科底蕴深厚的双一流高校', '综合类', NULL, '华中', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (48, '南昌大学', 0, '江西省南昌市红谷滩区学府大道999号', '南昌', '10403', '211', 'https://www.ncu.edu.cn/', '南昌大学研究生院', 'https://yjsy.ncu.edu.cn/', 'A区', '江西', '江西省属唯一211高校', '综合类', NULL, '华东', '2026-02-21 01:03:00');
INSERT INTO `university` VALUES (49, '中国地质大学（武汉）', 0, '湖北省武汉市洪山区鲁磨路388号', '武汉', '10491', '211', 'https://www.cug.edu.cn/', '中国地质大学（武汉）研究生院', 'https://yjsy.cug.edu.cn/', 'A区', '湖北', '中国地质大学（武汉）是教育部直属全国重点大学，以地质、资源、环境、工程技术为特色，地质资源与地质工程学科全国领先。', '理工类', NULL, '华中', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (50, '中国矿业大学（徐州）', 0, '江苏省徐州市泉山区大学路1号', '徐州', '10290', '211', 'https://www.cumt.edu.cn/', '中国矿业大学研究生院', 'https://yjsb.cumt.edu.cn/', 'A区', '江苏', '中国矿业大学（徐州）是教育部直属全国重点大学，以矿业工程、安全科学与工程为特色，相关学科位居世界前列。', '理工类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (51, '武汉理工大学', 0, '湖北省武汉市洪山区珞狮路122号', '武汉', '10497', '211', 'https://www.whut.edu.cn/', '武汉理工大学研究生院', 'https://yjsy.whut.edu.cn/', 'A区', '湖北', '武汉理工大学是教育部直属全国重点大学，材料科学与工程、交通运输工程等学科实力雄厚，工科特色鲜明。', '理工类', NULL, '华中', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (52, '华中农业大学', 0, '湖北省武汉市洪山区狮子山街1号', '武汉', '10504', '211', 'https://www.hzau.edu.cn/', '华中农业大学研究生院', 'https://yjsy.hzau.edu.cn/', 'A区', '湖北', '华中农业大学是教育部直属全国重点大学，以农业科学为特色，作物学、园艺学、畜牧学等学科位居全国前列。', '农林类', NULL, '华中', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (53, '暨南大学', 0, '广东省广州市天河区黄埔大道西601号', '广州', '10559', '211', 'https://www.jnu.edu.cn/', '暨南大学研究生院', 'https://yz.jnu.edu.cn/', 'A区', '广东', '暨南大学是教育部直属全国重点大学，是中国第一所由国家创办的华侨高等学府，新闻传播学、金融学等学科优势明显。', '综合类', NULL, '华南', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (54, '华南师范大学', 0, '广东省广州市天河区中山大道西55号', '广州', '10574', '211', 'https://www.scnu.edu.cn/', '华南师范大学研究生院', 'https://yz.scnu.edu.cn/', 'A区', '广东', '华南师范大学是教育部直属全国重点大学，心理学、教育学等学科实力雄厚，是华南地区重要的师范院校。', '师范类', NULL, '华南', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (55, '辽宁大学', 0, '辽宁省沈阳市皇姑区崇山中路66号', '沈阳', '10140', '211', 'https://www.lnu.edu.cn/', '辽宁大学研究生院', 'https://gs.lnu.edu.cn/', 'A区', '辽宁', '辽宁大学是辽宁省属综合性211高校，应用经济学、法学等学科特色鲜明，人文社科优势突出。', '综合类', NULL, '东北', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (56, '南京师范大学', 0, '江苏省南京市栖霞区文苑路1号', '南京', '10319', '211', 'https://www.nnu.edu.cn/', '南京师范大学研究生院', 'https://yzb.nnu.edu.cn/', 'A区', '江苏', '南京师范大学是江苏省属重点211高校，教育学、地理学等学科实力雄厚，师范特色鲜明。', '师范类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (57, '北京科技大学', 0, '北京市海淀区学院路30号', '北京', '10008', '211', 'https://www.ustb.edu.cn/', '北京科技大学研究生院', 'https://yz.ustb.edu.cn/', 'A区', '北京', '北京科技大学是教育部直属全国重点大学，冶金工程、材料科学与工程等学科位居全国前列，工科特色显著。', '理工类', NULL, '华北', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (58, '宁波大学', 0, '浙江省宁波市江北区风华路818号', '宁波', '11646', '双一流', 'https://www.nbu.edu.cn/', '宁波大学研究生院', 'https://graduate.nbu.edu.cn/', 'A区', '浙江', '宁波大学是省部共建双一流高校，水产、信息与通信工程等学科特色鲜明，海洋学科发展迅速。', '综合类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (59, '杭州电子科技大学', 0, '浙江省杭州市钱塘区白杨街道2号大街1158号', '杭州', '10336', '双非', 'https://www.hdu.edu.cn/', '杭州电子科技大学研究生院', 'https://yz.hdu.edu.cn/', 'A区', '浙江', '杭州电子科技大学是浙江省属重点大学，电子信息、计算机等工科专业特色鲜明，就业竞争力强。', '理工类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (60, '重庆邮电大学', 0, '重庆市南岸区崇文路2号', '重庆', '10617', '双非', 'https://www.cqupt.edu.cn/', '重庆邮电大学研究生院', 'https://yz.cqupt.edu.cn/', 'A区', '重庆', '重庆邮电大学是重庆市属重点大学，通信工程、计算机科学与技术等学科实力突出，信息领域特色显著。', '理工类', NULL, '西南', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (61, '南京邮电大学', 0, '江苏省南京市栖霞区文苑路9号', '南京', '10293', '双非', 'https://www.njupt.edu.cn/', '南京邮电大学研究生院', 'https://yzb.njupt.edu.cn/', 'A区', '江苏', '南京邮电大学是江苏省属重点大学，信息与通信工程、电子科学与技术等学科优势明显，被誉为\"华夏IT英才的摇篮\"。', '理工类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (62, '西安邮电大学', 0, '陕西省西安市长安区西长安街563号', '西安', '11664', '双非', 'https://www.xupt.edu.cn/', '西安邮电大学研究生院', 'https://yz.xupt.edu.cn/', 'A区', '陕西', '西安邮电大学是陕西省属重点大学，通信工程、计算机科学与技术等学科特色鲜明，扎根西部信息产业。', '理工类', NULL, '西北', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (63, '广东工业大学', 0, '广东省广州市天河区迎龙路161号', '广州', '11845', '双非', 'https://www.gdut.edu.cn/', '广东工业大学研究生院', 'https://yzb.gdut.edu.cn/', 'A区', '广东', '广东工业大学是广东省属重点大学，机械工程、自动化等工科专业实力雄厚，产学研结合紧密。', '理工类', NULL, '华南', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (64, '深圳大学', 0, '广东省深圳市南山区南海大道3688号', '深圳', '10590', '双非', 'https://www.szu.edu.cn/', '深圳大学研究生院', 'https://yz.szu.edu.cn/', 'A区', '广东', '深圳大学是深圳市属重点大学，学科发展迅速，计算机、电子信息等专业依托地域优势，就业前景广阔。', '综合类', NULL, '华南', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (65, '浙江工业大学', 0, '浙江省杭州市西湖区留和路288号', '杭州', '10337', '双非', 'https://www.zjut.edu.cn/', '浙江工业大学研究生院', 'https://yz.zjut.edu.cn/', 'A区', '浙江', '浙江工业大学是浙江省属重点大学，化学工程与技术、机械工程等学科实力突出，工科特色鲜明。', '理工类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (66, '江苏大学', 0, '江苏省镇江市京口区学府路301号', '镇江', '10299', '双非', 'https://www.ujs.edu.cn/', '江苏大学研究生院', 'https://yz.ujs.edu.cn/', 'A区', '江苏', '江苏大学是江苏省属重点大学，农业工程、机械工程等学科优势明显，综合性较强。', '综合类', NULL, '华东', '2026-03-02 22:28:03');

-- ----------------------------
-- Table structure for university_campus
-- ----------------------------
DROP TABLE IF EXISTS `university_campus`;
CREATE TABLE `university_campus`  (
                                      `id` int NOT NULL AUTO_INCREMENT COMMENT '校区ID',
                                      `university_id` int NOT NULL COMMENT '关联院校ID',
                                      `campus_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校区名称（如：海淀校区、沙河校区）',
                                      `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校区详细地址',
                                      `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校区所在城市',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `idx_university_id`(`university_id` ASC) USING BTREE,
                                      CONSTRAINT `fk_campus_university` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 230 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校校区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of university_campus
-- ----------------------------
INSERT INTO `university_campus` VALUES (1, 1, '主校区（海淀园）', '北京市海淀区清华园1号', '北京', '2026-02-21 01:16:06');
INSERT INTO `university_campus` VALUES (2, 1, '深圳国际研究生院', '广东省深圳市南山区西丽大学城清华园区', '深圳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (3, 1, '昌平校区', '北京市昌平区马池口镇昌流路738号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (5, 2, '主校区（燕园）', '北京市海淀区颐和园路5号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (6, 2, '昌平新校区', '北京市昌平区沙河高教园北三街10号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (7, 2, '深圳研究生院', '广东省深圳市南山区西丽镇丽水路2199号', '深圳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (8, 2, '医学部校区', '北京市海淀区学院路38号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (9, 3, '主校区（海淀校区）', '北京市海淀区中关村大街59号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (10, 3, '苏州校区', '江苏省苏州市吴中区仁爱路188号', '苏州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (11, 4, '主校区（学院路校区）', '北京市海淀区学院路37号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (12, 4, '沙河校区', '北京市昌平区沙河高教园南三街9号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (13, 5, '主校区（中关村校区）', '北京市海淀区中关村南大街5号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (14, 5, '良乡校区', '北京市房山区良乡高教园南大街1号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (15, 6, '主校区（东校区）', '北京市海淀区清华东路17号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (16, 6, '西校区', '北京市海淀区圆明园西路2号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (17, 7, '主校区（海淀校区）', '北京市海淀区新街口外大街19号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (18, 7, '珠海校区', '广东省珠海市香洲区唐家湾镇金凤路18号', '珠海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (19, 8, '主校区（海淀校区）', '北京市海淀区中关村南大街27号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (20, 8, '丰台校区', '北京市丰台区王佐镇青龙湖路11号', '北京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (21, 9, '主校区（邯郸校区）', '上海市杨浦区邯郸路220号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (22, 9, '枫林校区', '上海市徐汇区医学院路138号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (23, 9, '张江校区', '上海市浦东新区张衡路825号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (24, 9, '江湾校区', '上海市杨浦区淞沪路2005号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (25, 10, '主校区（四平路校区）', '上海市杨浦区四平路1239号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (26, 10, '嘉定校区', '上海市嘉定区曹安公路4800号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (27, 10, '沪西校区', '上海市普陀区真南路500号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (28, 11, '主校区（闵行校区）', '上海市闵行区东川路800号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (29, 11, '徐汇校区', '上海市徐汇区华山路1954号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (30, 11, '七宝校区', '上海市闵行区七莘路2678号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (31, 11, '黄浦校区', '上海市黄浦区重庆南路227号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (32, 12, '主校区（中山北路校区）', '上海市普陀区中山北路3663号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (33, 12, '闵行校区', '上海市闵行区东川路500号', '上海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (34, 13, '主校区（鼓楼校区）', '江苏省南京市鼓楼区汉口路22号', '南京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (35, 13, '仙林校区', '江苏省南京市栖霞区仙林大道163号', '南京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (36, 13, '浦口校区', '江苏省南京市浦口区学府路8号', '南京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (37, 14, '主校区（四牌楼校区）', '江苏省南京市玄武区四牌楼2号', '南京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (38, 14, '九龙湖校区', '江苏省南京市江宁区吉印大道2009号', '南京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (39, 14, '丁家桥校区', '江苏省南京市鼓楼区丁家桥87号', '南京', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (40, 15, '主校区（紫金港校区）', '浙江省杭州市西湖区余杭塘路866号', '杭州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (41, 15, '玉泉校区', '浙江省杭州市西湖区浙大路38号', '杭州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (42, 15, '西溪校区', '浙江省杭州市西湖区天目山路148号', '杭州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (43, 15, '华家池校区', '浙江省杭州市上城区凯旋路268号', '杭州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (44, 15, '之江校区', '浙江省杭州市西湖区之江路51号', '杭州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (45, 16, '主校区（金寨路校区）', '安徽省合肥市包河区金寨路96号', '合肥', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (46, 16, '西区校区', '安徽省合肥市蜀山区黄山路443号', '合肥', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (47, 16, '先进技术研究院校区', '安徽省合肥市蜀山区望江西路5089号', '合肥', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (48, 17, '主校区（思明校区）', '福建省厦门市思明区思明南路422号', '厦门', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (49, 17, '翔安校区', '福建省厦门市翔安区翔安南路4221号', '厦门', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (50, 17, '漳州校区', '福建省漳州市龙海区招商局漳州开发区南滨大道300号', '漳州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (51, 18, '主校区（中心校区）', '山东省济南市历城区山大南路27号', '济南', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (52, 18, '洪家楼校区', '山东省济南市历城区洪家楼5号', '济南', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (53, 18, '趵突泉校区', '山东省济南市历下区文化西路44号', '济南', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (54, 18, '威海校区', '山东省威海市环翠区文化西路180号', '威海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (55, 18, '青岛校区', '山东省青岛市即墨区滨海路72号', '青岛', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (56, 19, '主校区（崂山校区）', '山东省青岛市崂山区松岭路238号', '青岛', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (57, 19, '鱼山校区', '山东省青岛市市南区鱼山路5号', '青岛', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (58, 19, '浮山校区', '山东省青岛市市南区香港东路23号', '青岛', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (59, 20, '主校区（珞珈山校区）', '湖北省武汉市武昌区八一路299号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (60, 20, '医学部校区', '湖北省武汉市武昌区东湖路115号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (61, 20, '信息学部校区', '湖北省武汉市洪山区珞喻路129号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (62, 20, '工学部校区', '湖北省武汉市武昌区东湖南路8号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (63, 21, '主校区（主校区）', '湖北省武汉市洪山区珞喻路1037号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (64, 21, '同济医学院校区', '湖北省武汉市硚口区航空路13号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (65, 21, '光谷校区', '湖北省武汉市洪山区高新大道999号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (66, 22, '主校区（南校区）', '湖南省长沙市岳麓区麓山南路2号', '长沙', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (67, 22, '北校区', '湖南省长沙市岳麓区石佳冲路109号', '长沙', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (68, 23, '主校区（校本部）', '湖南省长沙市岳麓区麓山南路932号', '长沙', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (69, 23, '湘雅医学院校区', '湖南省长沙市开福区湘雅路88号', '长沙', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (70, 23, '新校区', '湖南省长沙市岳麓区潇湘中路328号', '长沙', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (71, 24, '主校区（长沙校区）', '湖南省长沙市开福区德雅路109号', '长沙', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (72, 24, '合肥校区', '安徽省合肥市蜀山区黄山路460号', '合肥', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (73, 25, '主校区（南校区）', '广东省广州市海珠区新港西路135号', '广州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (74, 25, '北校区', '广东省广州市越秀区中山二路74号', '广州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (75, 25, '东校区', '广东省广州市番禺区外环东路132号', '广州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (76, 25, '珠海校区', '广东省珠海市香洲区唐家湾镇中山大学珠海校区', '珠海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (77, 25, '深圳校区', '广东省深圳市光明区新湖街道公常路66号', '深圳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (78, 26, '主校区（五山校区）', '广东省广州市天河区五山路381号', '广州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (79, 26, '大学城校区', '广东省广州市番禺区广州大学城外环东路382号', '广州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (80, 26, '广州国际校区', '广东省广州市番禺区兴业大道东777号', '广州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (81, 27, '主校区（A区）', '重庆市沙坪坝区沙正街174号', '重庆', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (82, 27, 'B区', '重庆市沙坪坝区沙中路83号', '重庆', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (83, 27, '虎溪校区', '重庆市沙坪坝区大学城南路55号', '重庆', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (84, 28, '主校区（望江校区）', '四川省成都市武侯区一环路南一段24号', '成都', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (85, 28, '华西校区', '四川省成都市武侯区人民南路三段17号', '成都', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (86, 28, '江安校区', '四川省成都市双流区川大路二段2号', '成都', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (87, 29, '主校区（清水河校区）', '四川省成都市高新西区西源大道2006号', '成都', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (88, 29, '沙河校区', '四川省成都市成华区建设北路二段4号', '成都', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (89, 29, '九里堤校区', '四川省成都市金牛区九里堤西路8号', '成都', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (90, 30, '主校区（兴庆校区）', '陕西省西安市碑林区咸宁西路28号', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (91, 30, '雁塔校区', '陕西省西安市雁塔区雁塔西路76号', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (92, 30, '曲江校区', '陕西省西安市雁塔区雁翔路99号', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (93, 30, '中国西部科技创新港', '陕西省咸阳市秦都区钓台街道统一西路', '咸阳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (94, 31, '主校区（友谊西路校区）', '陕西省西安市碑林区友谊西路127号', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (95, 31, '长安校区', '陕西省西安市长安区东祥路1号', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (96, 31, '太仓校区', '江苏省苏州市太仓市宁波路9号', '太仓', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (97, 39, '主校区（北校区）', '陕西省咸阳市杨陵区邰城路3号', '咸阳', '2026-02-21 01:42:30');
INSERT INTO `university_campus` VALUES (98, 39, '南校区', '陕西省咸阳市杨陵区西农路22号', '咸阳', '2026-02-21 01:42:30');
INSERT INTO `university_campus` VALUES (99, 33, '主校区（城关校区）', '甘肃省兰州市城关区天水南路222号', '兰州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (100, 33, '榆中校区', '甘肃省兰州市榆中县夏官营镇吴谢营村', '兰州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (101, 34, '主校区（南湖校区）', '辽宁省沈阳市和平区文化路三巷11号', '沈阳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (102, 34, '浑南校区', '辽宁省沈阳市浑南区创新路195号', '沈阳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (103, 34, '秦皇岛分校', '河北省秦皇岛市海港区泰山路143号', '秦皇岛', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (104, 35, '主校区（凌水校区）', '辽宁省大连市甘井子区凌工路2号', '大连', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (105, 35, '开发区校区', '辽宁省大连市金普新区图强街321号', '大连', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (106, 35, '盘锦校区', '辽宁省盘锦市大洼区大工路2号', '盘锦', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (107, 36, '主校区（前卫南区）', '吉林省长春市朝阳区前进大街2699号', '长春', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (108, 36, '前卫北区', '吉林省长春市朝阳区解放大路2519号', '长春', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (109, 36, '南岭校区', '吉林省长春市南关区人民大街5988号', '长春', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (110, 36, '新民校区', '吉林省长春市朝阳区新民大街828号', '长春', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (111, 36, '朝阳校区', '吉林省长春市朝阳区西民主大街6号', '长春', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (112, 37, '主校区（一校区）', '黑龙江省哈尔滨市南岗区西大直街92号', '哈尔滨', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (113, 37, '二校区', '黑龙江省哈尔滨市南岗区黄河路73号', '哈尔滨', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (114, 37, '威海校区', '山东省威海市环翠区文化西路2号', '威海', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (115, 37, '深圳校区', '广东省深圳市南山区桃源街道深圳大学城哈工大校区', '深圳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (116, 38, '主校区（八里台校区）', '天津市南开区卫津路94号', '天津', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (117, 38, '津南校区', '天津市津南区同砚路38号', '天津', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (118, 38, '泰达校区', '天津市滨海新区宏达街23号', '天津', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (119, 32, '主校区（卫津路校区）', '天津市南开区卫津路92号', '天津', '2026-02-21 01:42:30');
INSERT INTO `university_campus` VALUES (120, 32, '北洋园校区', '天津市津南区雅观路135号', '天津', '2026-02-21 01:42:30');
INSERT INTO `university_campus` VALUES (121, 32, '滨海工业研究院校区', '天津市滨海新区临港经济区嘉陵江道48号', '天津', '2026-02-21 01:42:30');
INSERT INTO `university_campus` VALUES (122, 40, '主校区（桂子山校区）', '湖北省武汉市洪山区珞喻路152号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (123, 40, '南湖校区', '湖北省武汉市洪山区雄楚大道382号', '武汉', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (124, 41, '主校区（南校区）', '陕西省西安市雁塔区南二环路中段', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (125, 41, '北校区', '陕西省西安市未央区未央路126号', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (126, 41, '渭水校区', '陕西省西安市未央区尚苑路北侧', '西安', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (127, 42, '主校区（蠡湖校区）', '江苏省无锡市蠡湖大道1800号', '无锡', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (128, 42, '青山湾校区', '江苏省无锡市惠山区惠河路170号', '无锡', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (129, 43, '主校区（天赐庄校区）', '江苏省苏州市姑苏区十梓街1号', '苏州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (130, 43, '独墅湖校区', '江苏省苏州市吴中区仁爱路199号', '苏州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (131, 43, '阳澄湖校区', '江苏省苏州市相城区济学路8号', '苏州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (132, 44, '主校区（莲花街校区）', '河南省郑州市高新技术产业开发区莲花街100号', '郑州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (133, 44, '嵩山路校区', '河南省郑州市二七区嵩山南路140号', '郑州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (134, 44, '中原路校区', '河南省郑州市中原区中原西路195号', '郑州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (135, 45, '主校区（开元校区）', '河南省洛阳市洛龙区开元大道263号', '洛阳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (136, 45, '西苑校区', '河南省洛阳市涧西区西苑路48号', '洛阳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (137, 45, '景华校区', '河南省洛阳市涧西区景华路东段', '洛阳', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (138, 46, '主校区（南校区）', '河南省焦作市山阳区世纪路2001号', '焦作', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (139, 46, '北校区', '河南省焦作市解放区建设西路55号', '焦作', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (140, 47, '主校区（明伦校区）', '河南省开封市顺河回族区明伦街85号', '开封', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (141, 47, '金明校区', '河南省开封市龙亭区金明大道北段', '开封', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (142, 47, '郑州校区', '河南省郑州市金水区明理路379号', '郑州', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (143, 48, '主校区（前湖校区）', '江西省南昌市红谷滩区学府大道999号', '南昌', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (144, 48, '青山湖校区', '江西省南昌市东湖区南京东路235号', '南昌', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (145, 48, '东湖校区', '江西省南昌市东湖区八一大道461号', '南昌', '2026-02-21 01:15:51');
INSERT INTO `university_campus` VALUES (146, 49, '南望山校区（主校区）', '湖北省武汉市洪山区鲁磨路388号', '武汉', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (147, 49, '未来城校区', '湖北省武汉市东湖新技术开发区未来三路', '武汉', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (148, 50, '南湖校区（主校区）', '江苏省徐州市泉山区大学路1号', '徐州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (149, 50, '文昌校区', '江苏省徐州市泉山区金山东路1号', '徐州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (150, 51, '南湖校区（主校区）', '湖北省武汉市洪山区岭南路', '武汉', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (151, 51, '马房山校区', '湖北省武汉市洪山区珞狮路122号', '武汉', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (152, 51, '余家头校区', '湖北省武汉市武昌区和平大道1178号', '武汉', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (153, 52, '狮子山校区（主校区）', '湖北省武汉市洪山区狮子山街1号', '武汉', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (154, 52, '襄阳校区', '湖北省襄阳市东津新区楚山路', '襄阳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (155, 53, '石牌校区（主校区）', '广东省广州市天河区黄埔大道西601号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (156, 53, '番禺校区', '广东省广州市番禺区兴业大道东855号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (157, 53, '广园东校区', '广东省广州市天河区瘦狗岭路377号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (158, 53, '深圳校区', '广东省深圳市南山区学苑大道1001号', '深圳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (159, 53, '珠海校区', '广东省珠海市香洲区前山路206号', '珠海', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (160, 54, '石牌校区（主校区）', '广东省广州市天河区中山大道西55号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (161, 54, '大学城校区', '广东省广州市番禺区广州大学城外环西路378号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (162, 54, '南海校区', '广东省佛山市南海区狮山镇南海软件科技园', '佛山', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (163, 55, '崇山校区（主校区）', '辽宁省沈阳市皇姑区崇山中路66号', '沈阳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (164, 55, '蒲河校区', '辽宁省沈阳市沈北新区道义南大街58号', '沈阳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (165, 56, '仙林校区（主校区）', '江苏省南京市栖霞区文苑路1号', '南京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (166, 56, '随园校区', '江苏省南京市鼓楼区宁海路122号', '南京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (167, 56, '紫金校区', '江苏省南京市玄武区板仓街78号', '南京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (168, 57, '学院路校区（主校区）', '北京市海淀区学院路30号', '北京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (169, 57, '管庄校区', '北京市朝阳区管庄北一里', '北京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (170, 58, '风华路校区（主校区）', '浙江省宁波市江北区风华路818号', '宁波', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (171, 58, '梅山校区', '浙江省宁波市北仑区梅山街道七星南路169号', '宁波', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (172, 58, '植物园校区', '浙江省宁波市鄞州区东海大道', '宁波', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (173, 59, '下沙校区（主校区）', '浙江省杭州市钱塘区白杨街道2号大街1158号', '杭州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (174, 59, '文一校区', '浙江省杭州市西湖区文一路115号', '杭州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (175, 59, '东岳校区', '浙江省杭州市西湖区大龙驹坞70号', '杭州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (176, 59, '下沙东校区', '浙江省杭州市钱塘区白杨街道6号大街215号', '杭州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (177, 59, '青山湖校区', '浙江省杭州市临安区青山湖科技城', '杭州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (178, 60, '崇文路校区（主校区）', '重庆市南岸区崇文路2号', '重庆', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (179, 60, '花溪校区', '重庆市巴南区红光大道69号', '重庆', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (180, 60, '仙桃数据谷校区', '重庆市渝北区仙桃街道数据谷东路', '重庆', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (181, 61, '仙林校区（主校区）', '江苏省南京市栖霞区文苑路9号', '南京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (182, 61, '三牌楼校区', '江苏省南京市鼓楼区新模范马路66号', '南京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (183, 61, '锁金村校区', '江苏省南京市玄武区龙蟠路177号', '南京', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (184, 62, '长安校区（主校区）', '陕西省西安市长安区西长安街618号', '西安', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (185, 62, '雁塔校区', '陕西省西安市雁塔区长安南路563号', '西安', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (186, 63, '大学城校区（主校区）', '广东省广州市番禺区广州大学城外环西路100号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (187, 63, '东风路校区', '广东省广州市越秀区东风东路729号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (188, 63, '龙洞校区', '广东省广州市天河区龙洞街迎龙路161号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (189, 63, '番禺校区', '广东省广州市番禺区钟村街市广路钟三路段11号', '广州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (190, 63, '揭阳校区', '广东省揭阳市惠来县粤东新城大学路1号', '揭阳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (191, 64, '粤海校区（主校区）', '广东省深圳市南山区南海大道3688号', '深圳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (192, 64, '丽湖校区', '广东省深圳市南山区学苑大道1088号', '深圳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (193, 64, '罗湖校区', '广东省深圳市罗湖区解放路4008号', '深圳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (194, 64, '宝安校区', '广东省深圳市宝安区新安街道兴东社区67区留仙二路139号', '深圳', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (195, 65, '屏峰校区（主校区）', '浙江省杭州市西湖区留和路288号', '杭州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (196, 65, '朝晖校区', '浙江省杭州市拱墅区潮王路18号', '杭州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (197, 65, '莫干山校区', '浙江省湖州市德清县舞阳街道游子街1号', '湖州', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (198, 66, '校本部（主校区）', '江苏省镇江市京口区学府路301号', '镇江', '2026-03-02 22:49:06');
INSERT INTO `university_campus` VALUES (199, 66, '北固校区', '江苏省镇江市京口区东吴路108号', '镇江', '2026-03-02 22:49:06');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` int NOT NULL AUTO_INCREMENT COMMENT '用户唯一标识',
                         `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
                         `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
                         `target_score` int NULL DEFAULT NULL COMMENT '目标分数',
                         `avatar_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像链接',
                         `target_university_id` int NULL DEFAULT NULL COMMENT '目标院校id',
                         `info_update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '信息更新时间',
                         `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
                         `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码（加密存储）',
                         `undergraduate_university_id` int NULL DEFAULT NULL COMMENT '本科学校id',
                         `postgraduate_year` int NULL DEFAULT NULL COMMENT '考研年份',
                         `create_time` datetime NOT NULL,
                         PRIMARY KEY (`id`) USING BTREE,
                         UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
                         UNIQUE INDEX `email`(`email` ASC) USING BTREE,
                         INDEX `target_university_id`(`target_university_id` ASC) USING BTREE,
                         INDEX `undergraduate_university_id`(`undergraduate_university_id` ASC) USING BTREE,
                         CONSTRAINT `user_ibfk_1` FOREIGN KEY (`target_university_id`) REFERENCES `university` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                         CONSTRAINT `user_ibfk_2` FOREIGN KEY (`undergraduate_university_id`) REFERENCES `university` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                         CONSTRAINT `ck_user_postgraduate_year` CHECK ((`postgraduate_year` >= 2020) and (`postgraduate_year` <= 2100)),
                         CONSTRAINT `ck_user_target_score` CHECK ((`target_score` >= 0) and (`target_score` <= 500))
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '17638151819', '431149990@qq.com', 350, 'https://cn.bing.com/images/search?q=%e7%8b%97%e5%9b%be%e7%89%87&id=2EB876D55A15C750EEB49CBE06B0292190407486&FORM=IQFRBA', 19, '2026-02-20 21:16:57', '不上岸不改名', 'a2139365', NULL, 2027, '2026-02-20 15:25:25');
INSERT INTO `user` VALUES (2, '15131324567', '11408@qq.com', 404, NULL, NULL, '2026-02-21 22:41:02', '408', '111111', NULL, 2028, '2026-02-20 23:35:58');
INSERT INTO `user` VALUES (3, '16432343373', '8888@qq.com', 365, NULL, NULL, '2026-02-21 00:04:29', '！！！', '1234', NULL, 2027, '2026-02-20 23:39:20');

SET FOREIGN_KEY_CHECKS = 1;
