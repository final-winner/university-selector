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

 Date: 12/03/2026 20:22:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for correction
-- ----------------------------
DROP TABLE IF EXISTS `correction`;
CREATE TABLE `correction`  (
                               `id` int NOT NULL AUTO_INCREMENT COMMENT '纠错信息唯一标识',
                               `user_id` int NOT NULL COMMENT '用户id',
                               `university_id` int NOT NULL COMMENT '院校id',
                               `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '纠错类型（university/department/major/score）',
                               `field` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '纠错字段',
                               `current_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '当前值',
                               `suggested_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '建议值',
                               `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注说明',
                               `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '状态（待审核/已通过/已拒绝）',
                               `submit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
                               `process_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
                               INDEX `idx_university_id`(`university_id` ASC) USING BTREE,
                               INDEX `idx_status`(`status` ASC) USING BTREE,
                               CONSTRAINT `fk_correction_university` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `fk_correction_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '数据纠错表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of correction
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校院系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, 39, 250, '机械与电子工程学院', '机电学院', NULL, NULL, '西北农林科技大学机械与电子工程学院始建于1960年，是学校工科优势学院之一。学院以农业工程为特色，聚焦智能装备、农业机械化、电子信息等领域，拥有农业工程一级学科博士点，农业机械化工程为陕西省重点学科。学院注重产学研结合，与国内农机龙头企业建立长期合作，培养的毕业生在农业装备研发、智能制造等领域具有较强竞争力。', '2026-03-12 18:26:01');
INSERT INTO `department` VALUES (2, 39, 250, '信息工程学院', '信息学院', NULL, NULL, '西北农林科技大学信息工程学院成立于2000年，是学校信息化建设和人才培养的核心单位。学院设有计算机科学与技术、电子信息工程、软件工程等本科专业，拥有计算机应用技术、农业信息化技术等硕士点。学院重点发展农业大数据、智能感知、网络安全等方向，依托学校农业特色，在智慧农业、农业物联网等领域形成鲜明研究特色。', '2026-03-12 18:26:01');
INSERT INTO `department` VALUES (3, 6, 234, '信息与电气工程学院', '信电学院', NULL, NULL, '中国农业大学信息与电气工程学院源于1958年成立的农业电气化系，是我国农业信息化领域的先行者。学院涵盖计算机科学与技术、电气工程、自动化、电子信息等学科，拥有农业工程一级学科博士点，农业电气化与自动化为国家重点学科。学院聚焦智慧农业、农业机器人、智能检测与控制等方向，科研成果广泛应用于农业生产智能化改造。', '2026-03-12 18:26:01');
INSERT INTO `department` VALUES (4, 13, 238, '软件学院', '软件学院', NULL, NULL, '南京大学软件学院成立于2002年，是国家示范性软件学院之一。学院以培养高层次软件工程人才为目标，设有软件工程、人工智能、网络空间安全等专业方向，拥有软件工程一级学科博士点。学院注重工程实践能力培养，与华为、腾讯、阿里等企业建立联合实验室，毕业生在软件研发、互联网技术等领域就业率和薪资水平位居全国前列。', '2026-03-12 18:26:01');
INSERT INTO `department` VALUES (5, 28, 241, '计算机学院（软件学院、智能科学与技术学院）', '计算机学院', NULL, NULL, '四川大学计算机学院始建于1981年，2019年整合软件学院、智能科学与技术学院组建新学院，是西南地区计算机领域的领军院系。学院拥有计算机科学与技术一级学科博士点（全国A类学科），设有人工智能、大数据、网络安全、软件工程等方向，拥有视觉合成图形图像技术国家级重点实验室、国家示范性软件学院等平台，在模式识别、机器学习、数字媒体等领域研究成果显著。', '2026-03-12 18:26:01');
INSERT INTO `department` VALUES (6, 28, 241, '视觉合成图形图像技术国家级重点实验室', '图形图像实验室', NULL, NULL, '视觉合成图形图像技术国家级重点实验室依托四川大学建设，是我国西部唯一的图形图像领域国家级重点实验室。实验室聚焦计算机视觉、图形学、数字媒体、虚拟现实等方向，承担国家863计划、自然科学基金重点项目等国家级课题，在人脸识别、三维重建、数字文创等领域取得多项标志性成果，为我国图形图像产业发展提供核心技术支撑。', '2026-03-12 18:26:01');
INSERT INTO `department` VALUES (7, 10, 236, '工程类专业学院研究生教育管理中心', '工程研管中心', NULL, NULL, '同济大学工程类专业学院研究生教育管理中心统筹全校工科类研究生培养工作，涵盖土木工程、机械工程、电子与信息工程、计算机科学与技术等12个工科院系。中心负责研究生招生、培养方案制定、学位授予等管理工作，依托同济大学工科优势（土木工程全国第一、机械工程A类），构建了“理论+实践+创新”的研究生培养体系，与德国、瑞士等国高校建立联合培养机制。', '2026-03-12 18:26:01');
INSERT INTO `department` VALUES (8, 31, 247, '计算机学院', '计算机学院', NULL, NULL, '西北工业大学计算机学院始建于1958年，是我国最早设立计算机专业的院系之一。学院拥有计算机科学与技术一级学科博士点（ESI全球前1%），聚焦人工智能、网络安全、嵌入式系统、航空航天智能计算等方向，承担载人航天、探月工程、大飞机等国家重大工程的计算技术研发任务，在空天信息处理、无人系统智能控制等领域具有独特优势。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (9, 31, 247, '无人系统技术研究院', '无人系统研究院', NULL, NULL, '西北工业大学无人系统技术研究院是学校聚焦“三航”特色的新型科研教学机构，整合了计算机、航空、航天、航海等多学科资源。研究院重点开展无人机、无人船、无人潜航器等智能无人系统的研发与人才培养，拥有无人系统技术国家级实验教学示范中心，承担国防科技重大专项，是我国无人系统领域核心研发基地之一。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (10, 31, 247, '光电与智能研究院', '光电智能研究院', NULL, NULL, '西北工业大学光电与智能研究院成立于2018年，是学校“新工科”建设核心平台。研究院融合光学工程、计算机科学与技术、人工智能等学科，聚焦光电探测、智能感知、机器视觉、量子信息等方向，拥有光电信息技术与仪器教育部重点实验室，在航空航天光电导航、智能成像检测等领域取得多项关键技术突破。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (11, 30, 244, '电子与信息学部', '电子信息学部', NULL, NULL, '西安交通大学电子与信息学部是我国电子信息领域的顶尖院系之一，由原电信学院、计算机学院、人工智能学院等整合组建。学部拥有电子科学与技术、信息与通信工程、计算机科学与技术3个一级学科博士点（均为A类学科），涵盖通信工程、计算机、人工智能、微电子等专业，在智能信息处理、集成电路、物联网等领域研究水平居全国前列，拥有电子物理与器件教育部重点实验室。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (12, 30, 244, '计算机科学与技术学院', '计算机学院', NULL, NULL, '西安交通大学计算机科学与技术学院始建于1958年，是我国最早开展计算机教学与研究的院系之一。学院拥有计算机科学与技术一级学科博士点（ESI全球前1‰），重点研究人工智能、大数据分析与处理、网络安全、并行计算等方向，承担国家新一代人工智能重大项目，在医疗大数据、智能制造等领域应用成果显著。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (13, 30, 244, '网络空间安全学院', '网安学院', NULL, NULL, '西安交通大学网络空间安全学院成立于2018年，是国家首批网络空间安全一级学科博士点授权单位。学院聚焦网络安全、数据安全、工业控制安全等方向，拥有网络空间安全国家级实验教学示范中心，与国家网信办、陕西省公安厅建立战略合作，为国家培养高层次网络安全人才，在工业互联网安全、密码学等领域研究成果突出。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (14, 30, 244, '软件学院', '软件学院', NULL, NULL, '西安交通大学软件学院是国家示范性软件学院，成立于2001年。学院以软件工程、大数据工程、嵌入式软件为核心方向，注重工程实践和校企合作，与微软、IBM、华为等企业共建实习基地，培养的软件人才兼具技术研发和工程管理能力，毕业生在金融科技、智能制造软件等领域就业优势明显。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (15, 2, 232, '计算机学院', '计算机学院', NULL, NULL, '北京大学计算机学院成立于1978年，前身为数学力学系计算数学专业，是我国计算机科学领域的顶尖院系。学院拥有计算机科学与技术一级学科博士点（A+学科），涵盖人工智能、机器学习、网络与信息安全、数据库等方向，拥有视觉信息处理与机器智能教育部重点实验室，在自然语言处理、大数据分析、量子计算等领域研究水平国际领先。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (16, 2, 232, '智能学院', '智能学院', NULL, NULL, '北京大学智能学院成立于2021年，是学校布局人工智能领域的核心院系，整合了计算机、自动化、数学等多学科资源。学院聚焦通用人工智能、智能机器人、脑科学与类脑智能等方向，拥有国家新一代人工智能开放创新平台，与百度、字节跳动等企业共建联合实验室，致力于培养人工智能领域的领军人才。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (17, 2, 232, '软件与微电子学院', '软微学院', NULL, NULL, '北京大学软件与微电子学院成立于2002年，是国家示范性软件学院和微电子示范学院。学院设有软件工程、集成电路设计、金融科技等专业方向，采用“产学研用”一体化培养模式，注重实践能力和职业素养培养，毕业生在金融、互联网、集成电路等行业就业率高，是北京大学应用型高端人才培养的重要基地。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (18, 2, 233, '深圳研究生院', '深研院', NULL, NULL, '北京大学深圳研究生院成立于2001年，是北京大学在华南地区的重要办学基地。研究生院设有人工智能与数字经济实验室、计算机应用技术研究所等机构，依托深圳区位优势，聚焦人工智能、大数据、网络安全等方向，与腾讯、华为等企业开展深度合作，培养的研究生兼具北大的学术底蕴和深圳的创新精神。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (21, 13, 238, '计算机学院', '计算机学院', NULL, NULL, '南京大学计算机科学与技术系始建于1958年，2009年升格为计算机学院，是国内计算机领域的老牌强院。学院拥有计算机科学与技术一级学科博士点（A类学科），重点研究人工智能、机器学习、数据挖掘、分布式系统等方向，拥有计算机软件新技术国家重点实验室（全国计算机领域首个国家重点实验室），在软件自动化、自然语言处理等领域研究成果国际知名。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (23, 13, 238, '人工智能学院', '人工智能学院', NULL, NULL, '南京大学人工智能学院成立于2018年，是国内首批人工智能学院之一。学院依托南京大学计算机、数学、自动化等学科优势，聚焦机器学习、计算机视觉、智能机器人、认知智能等方向，拥有人工智能省级重点实验室，与旷视科技、科大讯飞等企业共建研发中心，培养的人工智能人才兼具理论基础和工程实践能力。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (24, 13, 240, '智能科学与技术学院（苏州校区）', '苏州智能学院', NULL, NULL, '南京大学苏州校区智能科学与技术学院成立于2021年，是学校布局长三角的重要人工智能人才培养基地。学院聚焦智能感知、人机交互、智能系统等方向，采用“书院制”培养模式，与苏州本地高新企业合作建立实习基地，毕业生主要服务于长三角地区人工智能产业发展。', '2026-03-12 18:26:02');
INSERT INTO `department` VALUES (25, 13, 240, '智能软件与工程学院（苏州校区）', '苏州软工学院', NULL, NULL, '南京大学苏州校区智能软件与工程学院依托南京大学软件学院的学科优势，聚焦智能软件、软件工程、云计算等方向，面向长三角数字经济发展需求，培养高层次软件人才。学院采用“双导师制”（校内导师+企业导师），与苏州工业园区企业共建联合培养基地，毕业生在软件研发、云计算运维等领域就业竞争力强。', '2026-03-12 18:26:02');

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
) ENGINE = InnoDB AUTO_INCREMENT = 137 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户收藏表（支持收藏专业/院校）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of favorite
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 245 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '专业表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (1, 39, '控制工程', '085406', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 1);
INSERT INTO `major` VALUES (2, 39, '计算机技术', '085404', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 2);
INSERT INTO `major` VALUES (3, 39, '人工智能', '085410', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 2);
INSERT INTO `major` VALUES (4, 6, '计算机技术', '085404', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 3);
INSERT INTO `major` VALUES (5, 28, '电子信息', '085400', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 5);
INSERT INTO `major` VALUES (6, 28, '电子信息', '085400', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 6);
INSERT INTO `major` VALUES (7, 31, '集成电路工程', '085403', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 8);
INSERT INTO `major` VALUES (8, 31, '计算机技术', '085404', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 8);
INSERT INTO `major` VALUES (9, 31, '人工智能', '085410', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 9);
INSERT INTO `major` VALUES (10, 31, '人工智能', '085410', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 10);
INSERT INTO `major` VALUES (11, 30, '计算机技术', '085404', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 12);
INSERT INTO `major` VALUES (12, 30, '网络与信息安全', '085412', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 13);
INSERT INTO `major` VALUES (13, 30, '软件工程', '085405', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:28:55', '22408', 14);
INSERT INTO `major` VALUES (14, 2, '计算机科学与技术', '081200', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 15);
INSERT INTO `major` VALUES (15, 2, '智能科学与技术', '140500', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 16);
INSERT INTO `major` VALUES (16, 2, '电子信息（01软件工程）', '085400', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 17);
INSERT INTO `major` VALUES (17, 2, '电子信息（02人工智能）', '085401', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 17);
INSERT INTO `major` VALUES (18, 2, '电子信息（03网络与信息安全）', '085402', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 17);
INSERT INTO `major` VALUES (19, 2, '电子信息（04新兴交叉学科）', '085403', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 17);
INSERT INTO `major` VALUES (20, 2, '计算机科学与技术', '081200', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 18);
INSERT INTO `major` VALUES (21, 2, '科学智能（计算机科学与技术）', '0812J6', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 18);
INSERT INTO `major` VALUES (22, 39, '计算机科学与技术', '081200', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 2);
INSERT INTO `major` VALUES (23, 6, '计算机科学与技术', '081200', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 3);
INSERT INTO `major` VALUES (24, 6, '智能科学与技术', '140500', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 3);
INSERT INTO `major` VALUES (25, 13, '计算机科学与技术', '081200', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 21);
INSERT INTO `major` VALUES (26, 13, '软件工程', '083500', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 21);
INSERT INTO `major` VALUES (27, 13, '计算机技术', '085404', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 21);
INSERT INTO `major` VALUES (28, 13, '软件工程', '085405', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 21);
INSERT INTO `major` VALUES (29, 13, '网络与信息安全', '085412', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 21);
INSERT INTO `major` VALUES (30, 13, '软件工程', '083500', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 4);
INSERT INTO `major` VALUES (31, 13, '软件工程', '085405', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 4);
INSERT INTO `major` VALUES (32, 13, '计算机科学与技术', '081200', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 23);
INSERT INTO `major` VALUES (33, 13, '人工智能', '085410', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 23);
INSERT INTO `major` VALUES (34, 13, '计算机科学与技术', '081200', NULL, NULL, NULL, NULL, NULL, NULL, '学硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 24);
INSERT INTO `major` VALUES (35, 13, '人工智能', '085410', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 24);
INSERT INTO `major` VALUES (36, 13, '软件工程', '085405', NULL, NULL, NULL, NULL, NULL, NULL, '专硕', NULL, NULL, '2026-03-12 17:38:42', '11408', 25);

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
) ENGINE = InnoDB AUTO_INCREMENT = 276 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考研核心数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of postgraduate_data
-- ----------------------------
INSERT INTO `postgraduate_data` VALUES (171, 14, NULL, 2024, 380, '北大计算机学院2024复试公示', NULL, 26, 17, 428, 382, 394.4, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (172, 15, NULL, 2024, 374, '北大智能学院2024复试公示', NULL, 13, 7, 412, 374, 388.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (173, 16, NULL, 2024, 345, '北大软微学院2024录取名单', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (174, 17, NULL, 2024, 345, '北大软微学院2024录取名单', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (175, 18, NULL, 2024, 345, '北大软微学院2024录取名单', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (176, 19, NULL, 2024, 345, '北大软微学院2024录取名单', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (177, 20, NULL, 2024, 370, '北大深圳研究生院2024拟录取', NULL, 28, 16, 420, 370, 390.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (178, 4, NULL, 2024, 320, '中国农大信息院2024复试线', NULL, 95, 94, 420, 320, 350.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (179, 23, NULL, 2024, 340, '中国农大计算机学硕2024录取', NULL, 47, 37, 390, 340, 355.4, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (180, 24, NULL, 2024, 300, '中国农大智能科学2024拟录取', NULL, 2, 2, 350, 300, 330.0, '2026-03-12 18:12:23');
INSERT INTO `postgraduate_data` VALUES (181, 25, NULL, 2024, 369, '南大计算机学院2024复试线', NULL, 16, 13, 401, 369, 380.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (182, 26, NULL, 2024, 372, '南大计算机学院2024复试线', NULL, 18, 15, 410, 372, 385.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (183, 27, NULL, 2024, 353, '南大计算机专硕2024拟录取', NULL, 106, 87, 400, 353, 370.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (184, 28, NULL, 2024, 372, '南大软件学院2024录取名单', NULL, 132, 109, 430, 372, 390.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (185, 29, NULL, 2024, 336, '南大网安专硕2024复试', NULL, 11, 9, 380, 336, 355.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (186, 30, NULL, 2024, 372, '南大软件学院2024复试线', NULL, 18, 15, 410, 372, 385.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (187, 31, NULL, 2024, 372, '南大软件学院2024录取名单', NULL, 132, 109, 430, 372, 390.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (188, 32, NULL, 2024, 369, '南大人工智能学院2024复试', NULL, 16, 13, 401, 369, 380.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (189, 33, NULL, 2024, 372, '南大人工智能专硕2024拟录取', NULL, 46, 37, 415, 372, 390.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (190, 34, NULL, 2024, 369, '南大苏州校区2024复试', NULL, 16, 13, 401, 369, 380.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (191, 35, NULL, 2024, 372, '南大苏州校区2024拟录取', NULL, 46, 37, 415, 372, 390.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (192, 36, NULL, 2024, 372, '南大苏州软工2024录取名单', NULL, 132, 109, 430, 372, 390.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (193, 5, NULL, 2024, 345, '川大计算机学院2024复试线', NULL, 124, 87, 422, 345, 350.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (194, 6, NULL, 2024, 340, '川大图形图像实验室2024录取', NULL, 90, 60, 418, 340, 345.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (195, 7, NULL, 2024, 320, '西工大计算机学院2024复试', NULL, 45, 35, 395, 320, 350.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (196, 8, NULL, 2024, 350, '西工大计算机专硕2024拟录取', NULL, 97, 76, 428, 350, 375.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (197, 9, NULL, 2024, 345, '西工大无人院2024复试线', NULL, 32, 25, 408, 345, 370.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (198, 10, NULL, 2024, 345, '西工大光电院2024复试线', NULL, 32, 25, 408, 345, 370.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (199, 1, NULL, 2024, 290, '西农机械学院2024复试', NULL, 25, 18, 375, 290, 320.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (200, 2, NULL, 2024, 300, '西农信息院2024复试线', NULL, 35, 25, 388, 300, 335.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (201, 3, NULL, 2024, 300, '西农人工智能2024拟录取', NULL, 15, 12, 380, 300, 330.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (202, 22, NULL, 2024, 273, '西农计算机学硕2024一志愿+调剂', NULL, 11, 1, 285, 285, 285.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (203, 11, NULL, 2024, 370, '西交计算机学院2024复试', NULL, 107, 65, 418, 370, 385.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (204, 12, NULL, 2024, 340, '西交网安学院2024复试线', NULL, 35, 28, 405, 340, 365.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (205, 13, NULL, 2024, 345, '西交软件学院2024拟录取', NULL, 55, 42, 410, 345, 370.0, '2026-03-12 18:12:24');
INSERT INTO `postgraduate_data` VALUES (206, 14, NULL, 2023, 348, '北大计算机学院2023复试公示', NULL, 16, 8, 427, 348, 378.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (207, 15, NULL, 2023, 360, '北大智能学院2023复试公示', NULL, 13, 7, 408, 360, 379.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (208, 16, NULL, 2023, 340, '北大软微学院2023录取名单', NULL, 50, 35, 421, 340, 365.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (209, 17, NULL, 2023, 340, '北大软微学院2023录取名单', NULL, 50, 35, 421, 340, 365.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (210, 18, NULL, 2023, 340, '北大软微学院2023录取名单', NULL, 50, 35, 421, 340, 365.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (211, 19, NULL, 2023, 340, '北大软微学院2023录取名单', NULL, 50, 35, 421, 340, 365.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (212, 20, NULL, 2023, 345, '北大深圳研究生院2023拟录取', NULL, 22, 12, 410, 345, 368.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (213, 4, NULL, 2023, 310, '中国农大信息院2023复试线', NULL, 80, 72, 405, 310, 342.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (214, 23, NULL, 2023, 300, '中国农大计算机学硕2023录取', NULL, 41, 35, 385, 300, 335.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (215, 24, NULL, 2023, 290, '中国农大智能科学2023拟录取', NULL, 3, 2, 340, 290, 320.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (216, 25, NULL, 2023, 350, '南大计算机学院2023复试线', NULL, 20, 15, 398, 350, 365.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (217, 26, NULL, 2023, 358, '南大计算机学院2023复试线', NULL, 22, 18, 405, 358, 372.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (218, 27, NULL, 2023, 351, '南大计算机专硕2023拟录取', NULL, 95, 75, 412, 351, 368.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (219, 28, NULL, 2023, 358, '南大软件学院2023录取名单', NULL, 118, 95, 425, 358, 375.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (220, 29, NULL, 2023, 325, '南大网安专硕2023复试', NULL, 14, 11, 375, 325, 340.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (221, 30, NULL, 2023, 358, '南大软件学院2023复试线', NULL, 22, 18, 405, 358, 372.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (222, 31, NULL, 2023, 358, '南大软件学院2023录取名单', NULL, 118, 95, 425, 358, 375.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (223, 32, NULL, 2023, 350, '南大人工智能学院2023复试', NULL, 20, 15, 398, 350, 365.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (224, 33, NULL, 2023, 358, '南大人工智能专硕2023拟录取', NULL, 40, 32, 410, 358, 375.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (225, 34, NULL, 2023, 350, '南大苏州校区2023复试', NULL, 20, 15, 398, 350, 365.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (226, 35, NULL, 2023, 358, '南大苏州校区2023拟录取', NULL, 40, 32, 410, 358, 375.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (227, 36, NULL, 2023, 358, '南大苏州软工2023录取名单', NULL, 118, 95, 425, 358, 375.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (228, 5, NULL, 2023, 345, '川大计算机学院2023复试线', NULL, 138, 92, 419, 345, 362.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (229, 6, NULL, 2023, 340, '川大图形图像实验室2023录取', NULL, 78, 52, 415, 340, 358.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (230, 7, NULL, 2023, 310, '西工大计算机学院2023复试', NULL, 40, 31, 390, 310, 345.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (231, 8, NULL, 2023, 365, '西工大计算机专硕2023拟录取', NULL, 85, 68, 425, 365, 380.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (232, 9, NULL, 2023, 310, '西工大无人院2023复试线', NULL, 28, 22, 395, 310, 348.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (233, 10, NULL, 2023, 310, '西工大光电院2023复试线', NULL, 28, 22, 395, 310, 348.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (234, 1, NULL, 2023, 280, '西农机械学院2023复试', NULL, 22, 16, 368, 280, 315.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (235, 2, NULL, 2023, 290, '西农信息院2023复试线', NULL, 30, 22, 382, 290, 328.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (236, 3, NULL, 2023, 290, '西农人工智能2023拟录取', NULL, 12, 10, 375, 290, 325.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (237, 22, NULL, 2023, 273, '西农计算机学硕2023一志愿+调剂', NULL, 10, 2, 330, 285, 307.5, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (238, 11, NULL, 2023, 365, '西交计算机学院2023复试', NULL, 92, 58, 415, 365, 380.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (239, 12, NULL, 2023, 330, '西交网安学院2023复试线', NULL, 32, 25, 400, 330, 355.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (240, 13, NULL, 2023, 340, '西交软件学院2023拟录取', NULL, 48, 38, 408, 340, 362.0, '2026-03-12 18:12:33');
INSERT INTO `postgraduate_data` VALUES (241, 14, NULL, 2025, 370, '北京大学计算机学院2025年复试分数线公示', NULL, 28, 16, 420, 370, 390.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (242, 15, NULL, 2025, 344, '北京大学智能学院2025年硕士复试线', NULL, 15, 10, 410, 344, 375.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (243, 16, NULL, 2025, 345, '北京大学软件与微电子学院2025复试通知', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (244, 17, NULL, 2025, 345, '北京大学软件与微电子学院2025复试通知', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (245, 18, NULL, 2025, 345, '北京大学软件与微电子学院2025复试通知', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (246, 19, NULL, 2025, 345, '北京大学软件与微电子学院2025复试通知', NULL, 60, 40, 420, 345, 375.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (247, 20, NULL, 2025, 370, '北京大学深圳研究生院2025拟录取公示', NULL, 28, 16, 420, 370, 390.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (248, 4, NULL, 2025, 320, '中国农业大学信息与电气工程学院2025复试线', NULL, 95, 94, 400, 320, 350.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (249, 23, NULL, 2025, 330, '中国农业大学计算机学硕2025拟录取名单', NULL, 22, 15, 395, 330, 355.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (250, 24, NULL, 2025, 300, '中国农业大学智能科学与技术2025复试公示', NULL, 2, 2, 350, 300, 330.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (251, 25, NULL, 2025, 369, '南京大学计算机学院2025复试基本线', NULL, 16, 13, 401, 369, 380.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (252, 26, NULL, 2025, 372, '南京大学计算机学院2025复试线', NULL, 18, 15, 410, 372, 385.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (253, 27, NULL, 2025, 353, '南京大学计算机专硕2025拟录取名单', NULL, 106, 87, 400, 353, 370.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (254, 28, NULL, 2025, 372, '南京大学软件学院2025录取公示', NULL, 132, 109, 430, 372, 390.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (255, 29, NULL, 2025, 336, '南京大学网络空间安全学院2025复试线', NULL, 11, 9, 380, 336, 355.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (256, 30, NULL, 2025, 372, '南京大学软件学院2025复试线', NULL, 18, 15, 410, 372, 385.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (257, 31, NULL, 2025, 372, '南京大学软件学院2025录取名单', NULL, 132, 109, 430, 372, 390.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (258, 32, NULL, 2025, 369, '南京大学人工智能学院2025复试线', NULL, 16, 13, 401, 369, 380.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (259, 33, NULL, 2025, 372, '南京大学人工智能专硕2025拟录取', NULL, 46, 37, 415, 372, 390.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (260, 34, NULL, 2025, 369, '南京大学苏州校区2025复试公示', NULL, 16, 13, 401, 369, 380.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (261, 35, NULL, 2025, 372, '南京大学苏州校区2025拟录取名单', NULL, 46, 37, 415, 372, 390.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (262, 36, NULL, 2025, 372, '南京大学苏州软工2025录取公示', NULL, 132, 109, 430, 372, 390.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (263, 5, NULL, 2025, 345, '四川大学计算机学院2025复试分数线', NULL, 124, 87, 422, 345, 350.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (264, 6, NULL, 2025, 340, '四川大学视觉合成实验室2025拟录取', NULL, 90, 60, 418, 340, 345.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (265, 7, NULL, 2025, 320, '西北工业大学计算机学院2025复试线', NULL, 45, 35, 395, 320, 350.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (266, 8, NULL, 2025, 340, '西北工业大学计算机专硕2025拟录取', NULL, 75, 58, 412, 340, 365.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (267, 9, NULL, 2025, 345, '西北工业大学无人系统研究院2025复试线', NULL, 32, 25, 408, 345, 370.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (268, 10, NULL, 2025, 345, '西北工业大学光电与智能研究院2025复试线', NULL, 32, 25, 408, 345, 370.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (269, 1, NULL, 2025, 290, '西北农林科技大学机械学院2025复试线', NULL, 25, 18, 375, 290, 320.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (270, 2, NULL, 2025, 300, '西北农林科技大学信息工程学院2025复试线', NULL, 35, 25, 388, 300, 335.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (271, 3, NULL, 2025, 300, '西北农林科技大学人工智能2025拟录取', NULL, 15, 12, 380, 300, 330.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (272, 22, NULL, 2025, 290, '西北农林科技大学计算机学硕2025复试公示', NULL, 10, 8, 370, 290, 325.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (273, 11, NULL, 2025, 350, '西安交通大学计算机学院2025复试线', NULL, 85, 65, 418, 350, 375.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (274, 12, NULL, 2025, 340, '西安交通大学网络空间安全学院2025复试线', NULL, 35, 28, 405, 340, 365.0, '2026-03-12 18:14:12');
INSERT INTO `postgraduate_data` VALUES (275, 13, NULL, 2025, 345, '西安交通大学软件学院2025拟录取名单', NULL, 55, 42, 410, 345, 370.0, '2026-03-12 18:14:12');

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
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of university
-- ----------------------------
INSERT INTO `university` VALUES (1, '清华大学', 3, '北京市海淀区清华园1号', '北京', '10003', 'C9', 'https://www.tsinghua.edu.cn/', '清华大学研究生院', 'https://yz.tsinghua.edu.cn/', 'A区', '北京', '清华大学始建于1911年，是中国著名高等学府，坐落于北京清华园。作为顶尖研究型大学，拥有12个学科门类，在工程技术、计算机科学、经济管理等领域享誉世界。', '综合类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (2, '北京大学', 2, '北京市海淀区颐和园路5号', '北京', '10001', 'C9', 'https://www.pku.edu.cn/', '北京大学研究生院', 'https://grs.pku.edu.cn/', 'A区', '北京', '北京大学创办于1898年，初名京师大学堂，是中国第一所国立综合性大学。拥有强大的文理医工学科群，人文社科和自然科学均处于国内领先地位。', '综合类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (3, '中国人民大学', 0, '北京市海淀区中关村大街59号', '北京', '10002', '985', 'https://www.ruc.edu.cn/', '中国人民大学研究生院', 'https://grs.ruc.edu.cn/', 'A区', '北京', '中国人民大学是中国共产党创办的第一所新型正规大学，以人文社会科学著称，被誉为\"中国人文社会科学的一面旗帜\"。', '综合类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (4, '北京航空航天大学', 0, '北京市海淀区学院路37号', '北京', '10006', '985', 'https://www.buaa.edu.cn/', '北京航空航天大学研究生院', 'https://graduate.buaa.edu.cn/', 'A区', '北京', '北京航空航天大学成立于1952年，是新中国的第一所航空航天高等学府，以航空航天、信息技术为特色，工科优势突出。', '理工类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (5, '北京理工大学', 0, '北京市海淀区中关村南大街5号', '北京', '10007', '985', 'https://www.bit.edu.cn/', '北京理工大学研究生院', 'https://grd.bit.edu.cn/', 'A区', '北京', '北京理工大学是中国共产党创办的第一所理工科大学，以国防科技为特色，在兵器科学与技术、车辆工程等领域具有显著优势。', '理工类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (6, '中国农业大学', 1, '北京市海淀区清华东路17号', '北京', '10019', '985', 'https://www.cau.edu.cn/', '中国农业大学研究生院', 'https://grad.cau.edu.cn/', 'A区', '北京', '中国农业大学是我国现代农业高等教育的起源地，以农业生命科学、农业工程为特色，农业科学领域位居全国首位。', '农林类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (7, '北京师范大学', 0, '北京市海淀区新街口外大街19号', '北京', '10027', '985', 'https://www.bnu.edu.cn/', '北京师范大学研究生院', 'https://graduate.bnu.edu.cn/', 'A区', '北京', '北京师范大学是教育部直属重点大学，以教师教育、教育科学和文理基础学科为主要特色，是中国师范教育的排头兵。', '师范类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (8, '中央民族大学', 0, '北京市海淀区中关村南大街27号', '北京', '10052', '985', 'https://www.muc.edu.cn/', '中央民族大学研究生院', 'https://grs.muc.edu.cn/', 'A区', '北京', '中央民族大学是中国少数民族教育的最高学府，拥有民族学、社会学等特色学科，为少数民族和民族地区培养人才。', '民族类', NULL, '华北', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (9, '复旦大学', 0, '上海市杨浦区邯郸路220号', '上海', '10246', 'C9', 'https://www.fudan.edu.cn/', '复旦大学研究生院', 'https://gs.fudan.edu.cn/', 'A区', '上海', '复旦大学创建于1905年，原名复旦公学，是中国人自主创办的第一所高等院校。文理医工均衡发展，新闻、经济、医学等学科享誉海内外。', '综合类', NULL, '华东', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (10, '同济大学', 0, '上海市杨浦区四平路1239号', '上海', '10247', '985', 'https://www.tongji.edu.cn/', '同济大学研究生院', 'https://yz.tongji.edu.cn/', 'A区', '上海', '同济大学始建于1907年，是中国最早的国立大学之一。以土木建筑、城市规划、交通运输等学科著称，对德交流合作特色鲜明。', '理工类', NULL, '华东', '2026-03-12 16:34:51');
INSERT INTO `university` VALUES (11, '上海交通大学', 0, '上海市闵行区东川路800号', '上海', '10248', 'C9', 'https://www.sjtu.edu.cn/', '上海交通大学研究生院', 'https://www.gs.sjtu.edu.cn/', 'A区', '上海', '上海交通大学创建于1896年，是我国历史最悠久的高等学府之一。在船舶海洋工程、机械工程、电子信息等领域具有强大实力。', '综合类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (12, '华东师范大学', 0, '上海市普陀区中山北路3663号', '上海', '10269', '985', 'https://www.ecnu.edu.cn/', '华东师范大学研究生院', 'https://yz.ecnu.edu.cn/', 'A区', '上海', '华东师范大学成立于1951年，是教育部直属的全国重点师范大学。教育学、地理学、心理学等学科处于国内领先水平。', '师范类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (13, '南京大学', 0, '江苏省南京市鼓楼区汉口路22号', '南京', '10284', 'C9', 'https://www.nju.edu.cn/', '南京大学研究生院', 'https://grawww.nju.edu.cn/', 'A区', '江苏', '南京大学前身是创建于1902年的三江师范学堂，是一所历史悠久、声誉卓著的高等学府。天文、地质、中文、历史等学科特色鲜明。', '综合类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (14, '东南大学', 0, '江苏省南京市玄武区四牌楼2号', '南京', '10286', '985', 'https://www.seu.edu.cn/', '东南大学研究生院', 'https://yzb.seu.edu.cn/', 'A区', '江苏', '东南大学创建于1902年，是中国最早建立的高等学府之一。以建筑、土木、电子、交通等工科见长，建筑学享有\"建筑老八校\"美誉。', '理工类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (15, '浙江大学', 0, '浙江省杭州市西湖区余杭塘路866号', '杭州', '10335', 'C9', 'https://www.zju.edu.cn/', '浙江大学研究生院', 'https://grs.zju.edu.cn/', 'A区', '浙江', '浙江大学的前身是求是书院，创建于1897年。学科门类齐全，工科、农学、医学、管理学等实力雄厚，被誉为\"东方剑桥\"。', '综合类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (16, '中国科学技术大学', 0, '安徽省合肥市包河区金寨路96号', '合肥', '10358', 'C9', 'https://www.ustc.edu.cn/', '中国科学技术大学研究生院', 'https://gradschool.ustc.edu.cn/', 'A区', '安徽', '中国科学技术大学成立于1958年，由中国科学院创办。以理工科见长，物理、化学、地球物理等基础科学研究水平国际领先。', '理工类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (17, '厦门大学', 0, '福建省厦门市思明区思明南路422号', '厦门', '10384', '985', 'https://www.xmu.edu.cn/', '厦门大学研究生院', 'https://gs.xmu.edu.cn/', 'A区', '福建', '厦门大学由著名爱国华侨领袖陈嘉庚先生于1921年创办，是中国近代教育史上第一所华侨创办的大学。经济管理、化学、海洋科学等学科优势明显。', '综合类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (18, '山东大学', 0, '山东省济南市历城区山大南路27号', '济南', '10422', '985', 'https://www.sdu.edu.cn/', '山东大学研究生院', 'https://www.grad.sdu.edu.cn/', 'A区', '山东', '山东大学创建于1901年，是中国近代高等教育的起源性大学。数学、中国语言文学、临床医学等学科具有传统优势。', '综合类', NULL, '华东', '2026-03-12 16:34:59');
INSERT INTO `university` VALUES (19, '中国海洋大学', 0, '山东省青岛市崂山区松岭路238号', '青岛', '10423', '985', 'https://www.ouc.edu.cn/', '中国海洋大学研究生院', 'https://grad.ouc.edu.cn/', 'A区', '山东', '中国海洋大学创建于1924年，是以海洋和水产学科为特色的教育部直属重点大学。海洋科学、水产学位居全国首位。', '理工类', NULL, '华东', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (20, '武汉大学', 0, '湖北省武汉市武昌区八一路299号', '武汉', '10486', '985', 'https://www.whu.edu.cn/', '武汉大学研究生院', 'https://gs.whu.edu.cn/', 'A区', '湖北', '武汉大学溯源于1893年自强学堂，是一所风景如画、人文荟萃的百年名校。测绘、法学、马克思主义理论等学科国内领先。', '综合类', NULL, '华中', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (21, '华中科技大学', 0, '湖北省武汉市洪山区珞喻路1037号', '武汉', '10487', '985', 'https://www.hust.edu.cn/', '华中科技大学研究生院', 'https://gs.hust.edu.cn/', 'A区', '湖北', '华中科技大学由原华中理工大学等合并组建，机械、光电、医学等学科实力雄厚，被誉为\"新中国高等教育发展的缩影\"。', '综合类', NULL, '华中', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (22, '湖南大学', 0, '湖南省长沙市岳麓区麓山南路2号', '长沙', '10532', '985', 'https://www.hnu.edu.cn/', '湖南大学研究生院', 'https://gra.hnu.edu.cn/', 'A区', '湖南', '湖南大学办学起源于公元976年创建的岳麓书院，是中国最古老的高等学府。土木工程、机械工程、化学等学科实力突出。', '综合类', NULL, '华中', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (23, '中南大学', 0, '湖南省长沙市岳麓区麓山南路932号', '长沙', '10533', '985', 'https://www.csu.edu.cn/', '中南大学研究生院', 'https://gra.csu.edu.cn/', 'A区', '湖南', '中南大学由原中南工业大学等合并组建，冶金工程、矿业工程、材料科学等学科享誉中外，湘雅医学院驰名海内。', '综合类', NULL, '华中', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (24, '国防科技大学', 0, '湖南省长沙市开福区德雅路109号', '长沙', '91002', '985', 'https://www.nudt.edu.cn/', '国防科技大学研究生院', 'https://www.nudt.edu.cn/yjsy/', 'A区', '湖南', '国防科技大学是直属中央军委领导的军队高等学府，计算机科学、航空航天、信息通信等领域处于国内顶尖水平。', '军事类', NULL, '华中', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (25, '中山大学', 0, '广东省广州市海珠区新港西路135号', '广州', '10558', '985', 'https://www.sysu.edu.cn/', '中山大学研究生院', 'https://graduate.sysu.edu.cn/', 'A区', '广东', '中山大学由孙中山先生于1924年创办，是一所文理医工全面发展的综合性大学。医学、管理学、哲学等学科优势明显。', '综合类', NULL, '华南', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (26, '华南理工大学', 0, '广东省广州市天河区五山路381号', '广州', '10561', '985', 'https://www.scut.edu.cn/', '华南理工大学研究生院', 'https://www2.scut.edu.cn/graduate/', 'A区', '广东', '华南理工大学创建于1952年，以工科见长，轻工技术与工程、建筑学、食品科学等学科位居全国前列，被誉为\"工程师的摇篮\"。', '理工类', NULL, '华南', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (27, '重庆大学', 0, '重庆市沙坪坝区沙正街174号', '重庆', '10611', '985', 'https://www.cqu.edu.cn/', '重庆大学研究生院', 'https://graduate.cqu.edu.cn/', 'A区', '重庆', '重庆大学创办于1929年，是西南地区最早的国立大学。土木工程、电气工程、机械工程等工科优势明显，建筑学特色突出。', '综合类', NULL, '西南', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (28, '四川大学', 0, '四川省成都市武侯区一环路南一段24号', '成都', '10610', '985', 'https://www.scu.edu.cn/', '四川大学研究生院', 'https://gs.scu.edu.cn/', 'A区', '四川', '四川大学由原四川大学等合并组建，华西医学中心享誉全国。口腔医学、生物医学、材料科学等学科处于国内领先水平。', '综合类', NULL, '西南', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (29, '电子科技大学', 0, '四川省成都市高新区（西区）西源大道2006号', '成都', '10614', '985', 'https://www.uestc.edu.cn/', '电子科技大学研究生院', 'https://yz.uestc.edu.cn/', 'A区', '四川', '电子科技大学成立于1956年，是我国电子信息领域的顶尖学府。电子科学与技术、信息与通信工程等学科位居全国前列。', '理工类', NULL, '西南', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (30, '西安交通大学', 0, '陕西省西安市碑林区咸宁西路28号', '西安', '10698', 'C9', 'https://www.xjtu.edu.cn/', '西安交通大学研究生院', 'https://gs.xjtu.edu.cn/', 'A区', '陕西', '西安交通大学的前身是1896年创办的南洋公学，是我国最早兴办的高等学府之一。电气工程、动力工程、机械工程等工科实力雄厚。', '综合类', NULL, '西北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (31, '西北工业大学', 0, '陕西省西安市碑林区友谊西路127号', '西安', '10699', '985', 'https://www.nwpu.edu.cn/', '西北工业大学研究生院', 'https://gs.nwpu.edu.cn/', 'A区', '陕西', '西北工业大学以发展航空、航天、航海工程教育和科学研究为特色，是我国\"三航\"领域的重要人才培养和科学研究基地。', '理工类', NULL, '西北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (32, '天津大学', 0, '天津市南开区卫津路92号', '天津', '10056', '985', 'https://www.tju.edu.cn/', '天津大学研究生院', 'https://yzb.tju.edu.cn/', 'A区', '天津', '天津大学始建于1895年，前身为北洋大学，是中国第一所现代大学。以工科见长，建筑、水利、化工、机械等学科位居全国前列，是“建筑老八校”之一，被誉为“中国近代工程教育的摇篮”。', '理工类', NULL, '华北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (33, '兰州大学', 0, '甘肃省兰州市城关区天水南路222号', '兰州', '10730', '985', 'https://www.lzu.edu.cn/', '兰州大学研究生院', 'https://yjsy.lzu.edu.cn/', 'B区', '甘肃', '兰州大学创建于1909年，是我国西北地区最早的现代高等学府。草学、生态学、地理学等学科优势突出，素有\"西北名校\"之称。', '综合类', NULL, '西北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (34, '东北大学', 0, '辽宁省沈阳市和平区文化路三巷11号', '沈阳', '10145', '985', 'https://www.neu.edu.cn/', '东北大学研究生院', 'https://www.graduate.neu.edu.cn/', 'A区', '辽宁', '东北大学始建于1923年，是我国著名的工科大学。冶金工程、材料科学、控制科学与工程等学科实力雄厚，自动化领域特色突出。', '理工类', NULL, '东北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (35, '大连理工大学', 0, '辽宁省大连市甘井子区凌工路2号', '大连', '10141', '985', 'https://www.dlut.edu.cn/', '大连理工大学研究生院', 'https://gs.dlut.edu.cn/', 'A区', '辽宁', '大连理工大学创建于1949年，是我国著名的\"四大工学院\"之一。化学工程、力学、土木工程等学科处于国内领先地位。', '理工类', NULL, '东北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (36, '吉林大学', 0, '吉林省长春市朝阳区前进大街2699号', '长春', '10183', '985', 'https://www.jlu.edu.cn/', '吉林大学研究生院', 'https://yjsy.jlu.edu.cn/', 'A区', '吉林', '吉林大学由多所高校合并组建，学科门类齐全，规模宏大。化学、法学、考古学、车辆工程等学科享有盛誉。', '综合类', NULL, '东北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (37, '哈尔滨工业大学', 0, '黑龙江省哈尔滨市南岗区西大直街92号', '哈尔滨', '10213', 'C9', 'https://www.hit.edu.cn/', '哈尔滨工业大学研究生院', 'https://yzb.hit.edu.cn/', 'A区', '黑龙江', '哈尔滨工业大学始建于1920年，被誉为\"工程师的摇篮\"。航天、焊接、机器人等领域处于国内领先地位，为我国航天事业培养了大量人才。', '理工类', NULL, '东北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (38, '南开大学', 0, '天津市南开区卫津路94号', '天津', '10055', '985', 'https://www.nankai.edu.cn/', '南开大学研究生院', 'https://graduate.nankai.edu.cn/', 'A区', '天津', '南开大学成立于1919年，由著名教育家严修、张伯苓创办。经济学、历史学、化学、数学等基础学科实力雄厚。', '综合类', NULL, '华北', '2026-03-12 16:35:00');
INSERT INTO `university` VALUES (39, '西北农林科技大学', 0, '陕西省咸阳市杨陵区邰城路3号', '咸阳', '10712', '985', 'https://www.nwsuaf.edu.cn/', '西北农林科技大学研究生院', 'https://yjshy.nwsuaf.edu.cn/', 'A区', '陕西', '西北农林科技大学是教育部直属的农林类重点大学，是我国干旱半干旱地区农业技术研究的重要基地，农林学科特色鲜明。', '农林类', NULL, '西北', '2026-03-12 16:35:00');
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
INSERT INTO `university` VALUES (61, '南京邮电大学', 0, '江苏省南京市栖霞区文苑路9号', '南京', '10293', '双一流', 'https://www.njupt.edu.cn/', '南京邮电大学研究生院', 'https://yzb.njupt.edu.cn/', 'A区', '江苏', '南京邮电大学是江苏省属重点大学，信息与通信工程、电子科学与技术等学科优势明显，被誉为\"华夏IT英才的摇篮\"。', '理工类', NULL, '华东', '2026-03-12 16:04:00');
INSERT INTO `university` VALUES (62, '西安邮电大学', 0, '陕西省西安市长安区西长安街563号', '西安', '11664', '双非', 'https://www.xupt.edu.cn/', '西安邮电大学研究生院', 'https://yz.xupt.edu.cn/', 'A区', '陕西', '西安邮电大学是陕西省属重点大学，通信工程、计算机科学与技术等学科特色鲜明，扎根西部信息产业。', '理工类', NULL, '西北', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (63, '广东工业大学', 0, '广东省广州市天河区迎龙路161号', '广州', '11845', '双非', 'https://www.gdut.edu.cn/', '广东工业大学研究生院', 'https://yzb.gdut.edu.cn/', 'A区', '广东', '广东工业大学是广东省属重点大学，机械工程、自动化等工科专业实力雄厚，产学研结合紧密。', '理工类', NULL, '华南', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (64, '深圳大学', 0, '广东省深圳市南山区南海大道3688号', '深圳', '10590', '双非', 'https://www.szu.edu.cn/', '深圳大学研究生院', 'https://yz.szu.edu.cn/', 'A区', '广东', '深圳大学是深圳市属重点大学，学科发展迅速，计算机、电子信息等专业依托地域优势，就业前景广阔。', '综合类', NULL, '华南', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (65, '浙江工业大学', 0, '浙江省杭州市西湖区留和路288号', '杭州', '10337', '双非', 'https://www.zjut.edu.cn/', '浙江工业大学研究生院', 'https://yz.zjut.edu.cn/', 'A区', '浙江', '浙江工业大学是浙江省属重点大学，化学工程与技术、机械工程等学科实力突出，工科特色鲜明。', '理工类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (66, '江苏大学', 0, '江苏省镇江市京口区学府路301号', '镇江', '10299', '双非', 'https://www.ujs.edu.cn/', '江苏大学研究生院', 'https://yz.ujs.edu.cn/', 'A区', '江苏', '江苏大学是江苏省属重点大学，农业工程、机械工程等学科优势明显，综合性较强。', '综合类', NULL, '华东', '2026-03-02 22:28:03');
INSERT INTO `university` VALUES (67, '新疆大学', 0, '新疆乌鲁木齐市天山区胜利路666号', '乌鲁木齐', '10755', '211', 'https://www.xju.edu.cn/', '新疆大学研究生院', 'https://yz.xju.edu.cn/', 'B区', '新疆', '新疆大学是国家“211工程”重点建设高校，新疆维吾尔自治区与教育部共建的综合性大学，扎根西北，服务边疆。', '综合类', NULL, '西北', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (68, '西藏大学', 0, '西藏拉萨市城关区藏大东路10号', '拉萨', '10694', '211', 'https://www.utibet.edu.cn/', '西藏大学研究生院', 'https://yz.utibet.edu.cn/', 'B区', '西藏', '西藏大学是西藏自治区所属综合性大学，国家“211工程”重点建设高校，立足西藏，特色鲜明。', '综合类', NULL, '西南', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (69, '内蒙古大学', 0, '内蒙古呼和浩特市赛罕区大学西街235号', '呼和浩特', '10126', '211', 'https://www.imu.edu.cn/', '内蒙古大学研究生院', 'https://gs.imu.edu.cn/', 'B区', '内蒙古', '内蒙古大学是国家“211工程”重点建设高校，以蒙古学、生命科学为特色，综合实力位居内蒙古高校首位。', '综合类', NULL, '华北', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (70, '宁夏大学', 0, '宁夏银川市西夏区贺兰山西路489号', '银川', '10749', '211', 'https://www.nxu.edu.cn/', '宁夏大学研究生院', 'https://gs.nxu.edu.cn/', 'B区', '宁夏', '宁夏大学是宁夏回族自治区与教育部合建高校，国家“211工程”重点建设高校，服务宁夏地方发展。', '综合类', NULL, '西北', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (71, '青海大学', 0, '青海省西宁市城北区宁大路251号', '西宁', '10743', '211', 'https://www.qhu.edu.cn/', '青海大学研究生院', 'https://gs.qhu.edu.cn/', 'B区', '青海', '青海大学是青海省与教育部共建高校，国家“211工程”重点建设高校，以高原医学、生态环境为特色。', '综合类', NULL, '西北', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (72, '石河子大学', 0, '新疆石河子市石河子大学北四路221号', '石河子', '10759', '211', 'https://www.shzu.edu.cn/', '石河子大学研究生院', 'https://yz.shzu.edu.cn/', 'B区', '新疆', '石河子大学是国家“211工程”重点建设高校，由教育部和新疆生产建设兵团共建，扎根兵团，服务边疆。', '综合类', NULL, '西北', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (73, '西南财经大学', 0, '四川省成都市温江区柳台大道555号', '成都', '10651', '211', 'https://www.swufe.edu.cn/', '西南财经大学研究生院', 'https://yz.swufe.edu.cn/', 'A区', '四川', '西南财经大学是教育部直属全国重点大学，国家“211工程”建设高校，以经济学、管理学为主体，金融特色鲜明。', '财经类', NULL, '西南', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (74, '中南财经政法大学', 0, '湖北省武汉市洪山区南湖大道182号', '武汉', '10520', '211', 'https://www.znufe.edu.cn/', '中南财经政法大学研究生院', 'https://gs.znufe.edu.cn/', 'A区', '湖北', '中南财经政法大学是教育部直属全国重点大学，国家“211工程”建设高校，财经、政法学科优势突出。', '财经类', NULL, '华中', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (75, '南京航空航天大学', 0, '江苏省南京市江宁区将军大道29号', '南京', '10287', '211', 'https://www.nuaa.edu.cn/', '南京航空航天大学研究生院', 'https://yzb.nuaa.edu.cn/', 'A区', '江苏', '南京航空航天大学是工业和信息化部直属高校，国家“211工程”建设高校，航空航天特色鲜明。', '理工类', NULL, '华东', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (76, '南京理工大学', 0, '江苏省南京市玄武区孝陵卫街200号', '南京', '10288', '211', 'https://www.njust.edu.cn/', '南京理工大学研究生院', 'https://gs.njust.edu.cn/', 'A区', '江苏', '南京理工大学是工业和信息化部直属高校，国家“211工程”建设高校，兵器科学与技术学科全国领先。', '理工类', NULL, '华东', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (77, '华南农业大学', 0, '广东省广州市天河区五山路483号', '广州', '10564', '双一流', 'https://www.scau.edu.cn/', '华南农业大学研究生院', 'https://yzb.scau.edu.cn/', 'A区', '广东', '华南农业大学是广东省与农业农村部共建高校，国家“双一流”建设高校，农业科学、兽医学优势突出。', '农林类', NULL, '华南', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (78, '南京林业大学', 0, '江苏省南京市玄武区龙蟠路159号', '南京', '10298', '双一流', 'https://www.njfu.edu.cn/', '南京林业大学研究生院', 'https://gs.njfu.edu.cn/', 'A区', '江苏', '南京林业大学是江苏省与国家林业和草原局共建高校，国家“双一流”建设高校，林业工程学科全国领先。', '农林类', NULL, '华东', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (79, '湘潭大学', 0, '湖南省湘潭市雨湖区羊牯塘街道', '湘潭', '10530', '双一流', 'https://www.xtu.edu.cn/', '湘潭大学研究生院', 'https://gs.xtu.edu.cn/', 'A区', '湖南', '湘潭大学是湖南省与教育部共建高校，国家“双一流”建设高校，数学、法学学科特色鲜明。', '综合类', NULL, '华中', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (80, '山西大学', 0, '山西省太原市小店区坞城路92号', '太原', '10108', '双一流', 'https://www.sxu.edu.cn/', '山西大学研究生院', 'https://yz.sxu.edu.cn/', 'A区', '山西', '山西大学是山西省与教育部共建高校，国家“双一流”建设高校，物理学、哲学学科优势明显。', '综合类', NULL, '华北', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (81, '杭州师范大学', 0, '浙江省杭州市余杭区仓前街道海曙路58号', '杭州', '10346', '双非', 'https://www.hznu.edu.cn/', '杭州师范大学研究生院', 'https://yz.hznu.edu.cn/', 'A区', '浙江', '杭州师范大学是浙江省重点建设高校，以教师教育为特色，阿里巴巴商学院产学研融合优势突出。', '师范类', NULL, '华东', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (82, '江苏师范大学', 0, '江苏省徐州市铜山区上海路101号', '徐州', '10320', '双非', 'https://www.jsnu.edu.cn/', '江苏师范大学研究生院', 'https://yz.jsnu.edu.cn/', 'A区', '江苏', '江苏师范大学是江苏省属重点师范大学，语言文字学、教育学学科实力雄厚。', '师范类', NULL, '华东', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (83, '桂林电子科技大学', 0, '广西桂林市七星区金鸡路1号', '桂林', '10595', '双非', 'https://www.guet.edu.cn/', '桂林电子科技大学研究生院', 'https://yzb.guet.edu.cn/', 'B区', '广西', '桂林电子科技大学是工业和信息化部与广西共建高校，电子信息、通信工程特色鲜明，军工背景深厚。', '理工类', NULL, '华南', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (84, '昆明理工大学', 0, '云南省昆明市呈贡区景明南路727号', '昆明', '10674', '双非', 'https://www.kmust.edu.cn/', '昆明理工大学研究生院', 'https://yz.kmust.edu.cn/', 'B区', '云南', '昆明理工大学是云南省属重点大学，冶金工程、环境科学与工程学科优势突出，综合实力居云南高校前列。', '理工类', NULL, '西南', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (85, '扬州大学', 0, '江苏省扬州市邗江区大学南路88号', '扬州', '11117', '双非', 'https://www.yzu.edu.cn/', '扬州大学研究生院', 'https://yz.yzu.edu.cn/', 'A区', '江苏', '扬州大学是江苏省属重点综合性大学，畜牧学、作物学学科实力雄厚，学科门类齐全。', '综合类', NULL, '华东', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (86, '浙江工商大学', 0, '浙江省杭州市钱塘区学正街18号', '杭州', '10353', '双非', 'https://www.zjgsu.edu.cn/', '浙江工商大学研究生院', 'https://yz.zjgsu.edu.cn/', 'A区', '浙江', '浙江工商大学是浙江省属重点大学，应用经济学、工商管理学科优势明显，财经特色突出。', '财经类', NULL, '华东', '2026-03-12 17:00:00');
INSERT INTO `university` VALUES (87, '云南大学', 0, '云南省昆明市五华区翠湖北路2号', '昆明', '10673', '211', 'https://www.ynu.edu.cn/', '云南大学研究生院', 'https://gs.ynu.edu.cn/', 'B区', '云南', '云南大学是云南省唯一的211工程、双一流建设高校，计算机学科在西南B区实力突出，软件工程方向依托西南区位优势，就业辐射云贵川地区。', '综合类', NULL, '西南', '2026-03-12 17:01:22');
INSERT INTO `university` VALUES (88, '广西大学', 0, '广西南宁市西乡塘区大学东路100号', '南宁', '10593', '211', 'https://www.gxu.edu.cn/', '广西大学研究生院', 'https://yjs.gxu.edu.cn/', 'B区', '广西', '广西大学是广西唯一的211工程高校，计算机与电子信息学院为学校王牌院系，专硕招生规模大，调剂竞争较激烈但一志愿保护政策友好。', '综合类', NULL, '华南', '2026-03-12 17:01:23');
INSERT INTO `university` VALUES (89, '贵州大学', 0, '贵州省贵阳市花溪区花溪大道南段2708号', '贵阳', '10657', '211', 'https://www.gzu.edu.cn/', '贵州大学研究生院', 'https://yzb.gzu.edu.cn/', 'B区', '贵州', '贵州大学计算机学科为省级重点学科，大数据方向是特色优势，依托贵州大数据产业，就业对口率高，B区考研性价比突出。', '综合类', NULL, '西南', '2026-03-12 17:01:25');

-- ----------------------------
-- Table structure for university_campus
-- ----------------------------
DROP TABLE IF EXISTS `university_campus`;
CREATE TABLE `university_campus`  (
                                      `id` int NOT NULL AUTO_INCREMENT COMMENT '校区ID',
                                      `university_id` int NOT NULL COMMENT '关联院校ID',
                                      `campus_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校区名称（如：海淀校区、沙河校区）',
                                      `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校区详细地址',
                                      `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校区所在城市',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `idx_university_id`(`university_id` ASC) USING BTREE,
                                      CONSTRAINT `fk_campus_university` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 252 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校校区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of university_campus
-- ----------------------------
INSERT INTO `university_campus` VALUES (230, 1, '海淀校区', '北京市海淀区清华园1号', '北京', '2026-03-12 17:52:41', '北京');
INSERT INTO `university_campus` VALUES (231, 1, '深圳国际研究生院', '广东省深圳市南山区西丽大学城清华园区', '深圳', '2026-03-12 17:52:41', '广东');
INSERT INTO `university_campus` VALUES (232, 2, '海淀校区', '北京市海淀区颐和园路5号', '北京', '2026-03-12 17:52:41', '北京');
INSERT INTO `university_campus` VALUES (233, 2, '深圳研究生院', '广东省深圳市南山区西丽镇丽水路2199号', '深圳', '2026-03-12 17:52:41', '广东');
INSERT INTO `university_campus` VALUES (234, 6, '东校区', '北京市海淀区清华东路17号', '北京', '2026-03-12 17:52:41', '北京');
INSERT INTO `university_campus` VALUES (235, 6, '西校区', '北京市海淀区圆明园西路2号', '北京', '2026-03-12 17:52:41', '北京');
INSERT INTO `university_campus` VALUES (236, 10, '四平路校区', '上海市杨浦区四平路1239号', '上海', '2026-03-12 17:52:41', '上海');
INSERT INTO `university_campus` VALUES (237, 10, '嘉定校区', '上海市嘉定区曹安公路4800号', '上海', '2026-03-12 17:52:41', '上海');
INSERT INTO `university_campus` VALUES (238, 13, '鼓楼校区', '江苏省南京市鼓楼区汉口路22号', '南京', '2026-03-12 17:52:41', '江苏');
INSERT INTO `university_campus` VALUES (239, 13, '仙林校区', '江苏省南京市栖霞区仙林大道163号', '南京', '2026-03-12 17:52:41', '江苏');
INSERT INTO `university_campus` VALUES (240, 13, '苏州校区', '江苏省苏州市相城区济学路8号', '苏州', '2026-03-12 17:52:41', '江苏');
INSERT INTO `university_campus` VALUES (241, 28, '望江校区', '四川省成都市武侯区一环路南一段24号', '成都', '2026-03-12 17:52:41', '四川');
INSERT INTO `university_campus` VALUES (242, 28, '华西校区', '四川省成都市武侯区人民南路三段17号', '成都', '2026-03-12 17:52:41', '四川');
INSERT INTO `university_campus` VALUES (243, 28, '江安校区', '四川省成都市双流区川大路二段', '成都', '2026-03-12 17:52:41', '四川');
INSERT INTO `university_campus` VALUES (244, 30, '兴庆校区', '陕西省西安市碑林区咸宁西路28号', '西安', '2026-03-12 17:52:41', '陕西');
INSERT INTO `university_campus` VALUES (245, 30, '雁塔校区', '陕西省西安市雁塔区雁塔西路76号', '西安', '2026-03-12 17:52:41', '陕西');
INSERT INTO `university_campus` VALUES (246, 30, '创新港校区', '陕西省西安市西咸新区沣西新城中国西部科技创新港', '西安', '2026-03-12 17:52:41', '陕西');
INSERT INTO `university_campus` VALUES (247, 31, '友谊西路校区', '陕西省西安市碑林区友谊西路127号', '西安', '2026-03-12 17:52:41', '陕西');
INSERT INTO `university_campus` VALUES (248, 31, '长安校区', '陕西省西安市长安区东祥路1号', '西安', '2026-03-12 17:52:41', '陕西');
INSERT INTO `university_campus` VALUES (249, 31, '太仓校区', '江苏省苏州市太仓市太仓港经济技术开发区江南路1号', '太仓', '2026-03-12 17:52:41', '江苏');
INSERT INTO `university_campus` VALUES (250, 39, '北校区', '陕西省咸阳市杨陵区邰城路3号', '咸阳', '2026-03-12 17:52:41', '陕西');
INSERT INTO `university_campus` VALUES (251, 39, '南校区', '陕西省咸阳市杨陵区西农路22号', '咸阳', '2026-03-12 17:52:41', '陕西');

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
                         `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
                         `role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '管理员/用户',
                         PRIMARY KEY (`id`) USING BTREE,
                         UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
                         UNIQUE INDEX `email`(`email` ASC) USING BTREE,
                         INDEX `target_university_id`(`target_university_id` ASC) USING BTREE,
                         INDEX `undergraduate_university_id`(`undergraduate_university_id` ASC) USING BTREE,
                         CONSTRAINT `user_ibfk_1` FOREIGN KEY (`target_university_id`) REFERENCES `university` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                         CONSTRAINT `user_ibfk_2` FOREIGN KEY (`undergraduate_university_id`) REFERENCES `university` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                         CONSTRAINT `ck_user_postgraduate_year` CHECK ((`postgraduate_year` >= 2020) and (`postgraduate_year` <= 2100)),
                         CONSTRAINT `ck_user_target_score` CHECK ((`target_score` >= 0) and (`target_score` <= 500))
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '17797656709', '124r12124@qq.com', 350, '', 19, '2026-03-12 10:29:55', '不上岸不改名', 'a2139365', NULL, 2027, '2026-02-20 15:25:25', 'user');
INSERT INTO `user` VALUES (2, '15131324567', '11408@qq.com', 404, NULL, NULL, '2026-03-12 10:04:52', '408', '111111', NULL, 2028, '2026-02-20 23:35:58', 'user');
INSERT INTO `user` VALUES (3, '16432343373', '8888@qq.com', 365, NULL, NULL, '2026-03-12 10:04:54', '！！！', '1234', NULL, 2027, '2026-02-20 23:39:20', 'user');
INSERT INTO `user` VALUES (4, '17638151819', '431149990@qq.com', NULL, NULL, NULL, '2026-03-12 10:14:06', 'admin', 'admin', NULL, NULL, '2026-03-12 10:12:55', 'admin');

SET FOREIGN_KEY_CHECKS = 1;
