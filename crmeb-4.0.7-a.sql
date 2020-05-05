/*
 Navicat Premium Data Transfer

 Source Server         : crmeb
 Source Server Type    : MySQL
 Source Server Version : 50616
 Source Host           : rdsagent.foodtrust.cn:1401
 Source Schema         : crmeb

 Target Server Type    : MySQL
 Target Server Version : 50616
 File Encoding         : 65001

 Date: 04/05/2020 23:28:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for eb_article
-- ----------------------------
DROP TABLE IF EXISTS `eb_article`;
CREATE TABLE `eb_article`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章管理ID',
  `cid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '分类id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章标题',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章作者',
  `image_input` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章图片',
  `synopsis` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章简介',
  `share_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章分享标题',
  `share_synopsis` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章分享简介',
  `visit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览次数',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原文链接',
  `status` tinyint(1) UNSIGNED NOT NULL COMMENT '状态',
  `add_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '添加时间',
  `hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员id',
  `mer_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '商户id',
  `product_id` int(10) NOT NULL DEFAULT 0 COMMENT '商品关联id',
  `is_hot` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否热门(小程序)',
  `is_banner` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否轮播图(小程序)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章管理表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_article
-- ----------------------------
INSERT INTO `eb_article` VALUES (1, '1', '同生共好，自由生长：丰巢4.0内测中', '董学锋', 'https://oss.foodtrust.cn//372ad202004251014538878.jpg', '我们许下的愿，在每一行代码里算数！', '同生共好，自由生长：丰巢4.0内测中', '我们许下的愿，在每一行代码里算数！', '37', 0, 'https://blog.foodtrust.cn/', 1, '1588200018', 0, 1, 0, 1792, 1, 1);

-- ----------------------------
-- Table structure for eb_article_category
-- ----------------------------
DROP TABLE IF EXISTS `eb_article_category`;
CREATE TABLE `eb_article_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章分类id',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父级ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章分类标题',
  `intr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章分类简介',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章分类图片',
  `status` tinyint(1) UNSIGNED NOT NULL COMMENT '状态',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1删除0未删除',
  `add_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '添加时间',
  `hidden` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_article_category
-- ----------------------------
INSERT INTO `eb_article_category` VALUES (1, 0, '系统消息', '系统动态及公告', 'https://oss.foodtrust.cn//4f2ae202004251037016803.png', 0, 0, 0, '1588200018', 0);

-- ----------------------------
-- Table structure for eb_article_content
-- ----------------------------
DROP TABLE IF EXISTS `eb_article_content`;
CREATE TABLE `eb_article_content`  (
  `nid` int(10) UNSIGNED NOT NULL COMMENT '文章id',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章内容',
  UNIQUE INDEX `nid`(`nid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章内容表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_article_content
-- ----------------------------
INSERT INTO `eb_article_content` VALUES (1, '<p>\n    <span style=\"white-space: nowrap;\"><strong>让健康和友善触手可及！</strong></span>\n</p>\n<p>\n    <br/>\n</p>\n<p>\n    <span style=\"white-space\">丰巢4.0是在丰巢过去五年所有努力的当然延伸，它以丰巢原生团队及共好伙伴作为早期重要的参与及发起者，构建一个开放的、让追求健康和友善的生产者服务者和消费者，可以同生共好、自由生长的生态系统。</span>\n</p>\n<p>\n    <br/>\n</p>\n<p>\n    <span style=\"white-space\">✓ &nbsp;商城常规功能：H5小程序及直播共用</span>\n</p>\n<p>\n    <span style=\"white-space:\">✓ &nbsp;与社区博客及独立微信公众帐号打通</span>\n</p>\n<p>\n    <span style=\"white-space\">✓&nbsp; 共用商城入口可共享客源及推广成果</span>\n</p>\n<p>\n    <span style=\"white-space\">✓ &nbsp;消费者可开启代言推广二级分销模式</span>\n</p>\n<p>\n    <span style=\"white-space\">☐ 同一法人或自然人可同时当多个角色</span><br/>\n</p>\n<p>\n    <span style=\"white-space\">☐ 生产者服务者可选商城统一仓配服务</span>\n</p>\n<p>\n    <span style=\"white-space\">☐ 每个服务商可以在产品库中一键上架</span>\n</p>\n<p>\n    <span style=\"white-space\">☐ 服务商可独立上架可一键代发及分销</span>\n</p>\n<p>\n    <span style=\"white-space\">☐ 支持服务商生产者启用独立入口推广</span>\n</p>\n<p>\n    <span style=\"white-space\">☐ 非共享仓储及配送产品每日实时清算</span>\n</p>\n<p>\n    <br/>\n</p>\n<p>\n    <span style=\"white-space\"><strong>我们许过的愿，在每一行代码里算数！</strong></span>\n</p>\n<p>\n    <br/>\n</p>\n<p>\n    <span style=\"white-space\">丰巢4.0线上商城及社区系统全部开源</span><br/>\n</p>\n<p>\n    <span style=\"white-space\"><a href=\"https://gitee.com/foodtrust/fc4.git\" target=\"_self\">https://gitee.com/foodtrust/fc4.git</a></span>\n</p>\n<p>\n    <span style=\"white-space\">保持透明是获得信任的基础，欢迎Ruby（后端数据处理）、TP6（管理后台）及VUE（前端H5及小程序）老鸟参加志愿开发，开发者可获得系统积分奖励！</span>\n</p>\n<p>\n    <br/>\n</p>\n<p>\n    <span style=\"white-space\"><strong>点击下方产品可前往体验FC4.0前端界面</strong></span>\n</p>\n<p>\n    <span style=\"white-space\">注意<span style=\"color:#ff0000\">测试版不实际发货</span>所有支付将原路退款</span>\n</p>');

-- ----------------------------
-- Table structure for eb_cache
-- ----------------------------
DROP TABLE IF EXISTS `eb_cache`;
CREATE TABLE `eb_cache`  (
  `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '缓存数据',
  `expire_time` int(11) NOT NULL DEFAULT 0 COMMENT '失效时间0=永久',
  `add_time` int(10) NULL DEFAULT NULL COMMENT '缓存时间',
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `key`(`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信缓存表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_express
-- ----------------------------
DROP TABLE IF EXISTS `eb_express`;
CREATE TABLE `eb_express`  (
  `id` mediumint(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '快递公司id',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '快递公司简称',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '快递公司全称',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `is_show` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否显示',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE,
  INDEX `is_show`(`is_show`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 426 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '快递公司表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_express
-- ----------------------------
INSERT INTO `eb_express` VALUES (1, 'LIMINWL', '利民物流', 1, 0);
INSERT INTO `eb_express` VALUES (2, 'XINTIAN', '鑫天顺物流', 1, 0);
INSERT INTO `eb_express` VALUES (3, 'henglu', '恒路物流', 1, 0);
INSERT INTO `eb_express` VALUES (4, 'klwl', '康力物流', 1, 0);
INSERT INTO `eb_express` VALUES (5, 'meiguo', '美国快递', 1, 0);
INSERT INTO `eb_express` VALUES (6, 'a2u', 'A2U速递', 1, 0);
INSERT INTO `eb_express` VALUES (7, 'benteng', '奔腾物流', 1, 0);
INSERT INTO `eb_express` VALUES (8, 'ahdf', '德方物流', 1, 0);
INSERT INTO `eb_express` VALUES (9, 'timedg', '万家通', 1, 0);
INSERT INTO `eb_express` VALUES (10, 'ztong', '智通物流', 1, 0);
INSERT INTO `eb_express` VALUES (11, 'xindan', '新蛋物流', 1, 0);
INSERT INTO `eb_express` VALUES (12, 'bgpyghx', '挂号信', 1, 0);
INSERT INTO `eb_express` VALUES (13, 'XFHONG', '鑫飞鸿物流快递', 1, 0);
INSERT INTO `eb_express` VALUES (14, 'ALP', '阿里物流', 1, 0);
INSERT INTO `eb_express` VALUES (15, 'BFWL', '滨发物流', 1, 0);
INSERT INTO `eb_express` VALUES (16, 'SJWL', '宋军物流', 1, 0);
INSERT INTO `eb_express` VALUES (17, 'SHUNFAWL', '顺发物流', 1, 0);
INSERT INTO `eb_express` VALUES (18, 'TIANHEWL', '天河物流', 1, 0);
INSERT INTO `eb_express` VALUES (19, 'YBWL', '邮联物流', 1, 0);
INSERT INTO `eb_express` VALUES (20, 'SWHY', '盛旺货运', 1, 0);
INSERT INTO `eb_express` VALUES (21, 'TSWL', '汤氏物流', 1, 0);
INSERT INTO `eb_express` VALUES (22, 'YUANYUANWL', '圆圆物流', 1, 0);
INSERT INTO `eb_express` VALUES (23, 'BALIANGWL', '八梁物流', 1, 0);
INSERT INTO `eb_express` VALUES (24, 'ZGWL', '振刚物流', 1, 0);
INSERT INTO `eb_express` VALUES (25, 'JIAYU', '佳宇物流', 1, 0);
INSERT INTO `eb_express` VALUES (26, 'SHHX', '昊昕物流', 1, 0);
INSERT INTO `eb_express` VALUES (27, 'ande', '安得物流', 1, 0);
INSERT INTO `eb_express` VALUES (28, 'ppbyb', '贝邮宝', 1, 0);
INSERT INTO `eb_express` VALUES (29, 'dida', '递达快递', 1, 0);
INSERT INTO `eb_express` VALUES (30, 'jppost', '日本邮政', 1, 0);
INSERT INTO `eb_express` VALUES (31, 'intmail', '中国邮政', 96, 0);
INSERT INTO `eb_express` VALUES (32, 'HENGCHENGWL', '恒诚物流', 1, 0);
INSERT INTO `eb_express` VALUES (33, 'HENGFENGWL', '恒丰物流', 1, 0);
INSERT INTO `eb_express` VALUES (34, 'gdems', '广东ems快递', 1, 0);
INSERT INTO `eb_express` VALUES (35, 'xlyt', '祥龙运通', 1, 0);
INSERT INTO `eb_express` VALUES (36, 'gjbg', '国际包裹', 1, 0);
INSERT INTO `eb_express` VALUES (37, 'uex', 'UEX', 1, 0);
INSERT INTO `eb_express` VALUES (38, 'singpost', '新加坡邮政', 1, 0);
INSERT INTO `eb_express` VALUES (39, 'guangdongyouzhengwuliu', '广东邮政', 1, 0);
INSERT INTO `eb_express` VALUES (40, 'bht', 'BHT', 1, 0);
INSERT INTO `eb_express` VALUES (41, 'cces', 'CCES快递', 1, 0);
INSERT INTO `eb_express` VALUES (42, 'cloudexpress', 'CE易欧通国际速递', 1, 0);
INSERT INTO `eb_express` VALUES (43, 'dasu', '达速物流', 1, 0);
INSERT INTO `eb_express` VALUES (44, 'pfcexpress', '皇家物流', 1, 0);
INSERT INTO `eb_express` VALUES (45, 'hjs', '猴急送', 1, 0);
INSERT INTO `eb_express` VALUES (46, 'huilian', '辉联物流', 1, 0);
INSERT INTO `eb_express` VALUES (47, 'huanqiu', '环球速运', 1, 0);
INSERT INTO `eb_express` VALUES (48, 'huada', '华达快运', 1, 0);
INSERT INTO `eb_express` VALUES (49, 'htwd', '华通务达物流', 1, 0);
INSERT INTO `eb_express` VALUES (50, 'hipito', '海派通', 1, 0);
INSERT INTO `eb_express` VALUES (51, 'hqtd', '环球通达', 1, 0);
INSERT INTO `eb_express` VALUES (52, 'airgtc', '航空快递', 1, 0);
INSERT INTO `eb_express` VALUES (53, 'haoyoukuai', '好又快物流', 1, 0);
INSERT INTO `eb_express` VALUES (54, 'hanrun', '韩润物流', 1, 0);
INSERT INTO `eb_express` VALUES (55, 'ccd', '河南次晨达', 1, 0);
INSERT INTO `eb_express` VALUES (56, 'hfwuxi', '和丰同城', 1, 0);
INSERT INTO `eb_express` VALUES (57, 'Sky', '荷兰', 1, 0);
INSERT INTO `eb_express` VALUES (58, 'hongxun', '鸿讯物流', 1, 0);
INSERT INTO `eb_express` VALUES (59, 'hongjie', '宏捷国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (60, 'httx56', '汇通天下物流', 1, 0);
INSERT INTO `eb_express` VALUES (61, 'lqht', '恒通快递', 1, 0);
INSERT INTO `eb_express` VALUES (62, 'jinguangsudikuaijian', '京广速递快件', 1, 0);
INSERT INTO `eb_express` VALUES (63, 'junfengguoji', '骏丰国际速递', 1, 0);
INSERT INTO `eb_express` VALUES (64, 'jiajiatong56', '佳家通', 1, 0);
INSERT INTO `eb_express` VALUES (65, 'jrypex', '吉日优派', 1, 0);
INSERT INTO `eb_express` VALUES (66, 'jinchengwuliu', '锦程国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (67, 'jgwl', '景光物流', 1, 0);
INSERT INTO `eb_express` VALUES (68, 'pzhjst', '急顺通', 1, 0);
INSERT INTO `eb_express` VALUES (69, 'ruexp', '捷网俄全通', 1, 0);
INSERT INTO `eb_express` VALUES (70, 'jmjss', '金马甲', 1, 0);
INSERT INTO `eb_express` VALUES (71, 'lanhu', '蓝弧快递', 1, 0);
INSERT INTO `eb_express` VALUES (72, 'ltexp', '乐天速递', 1, 0);
INSERT INTO `eb_express` VALUES (73, 'lutong', '鲁通快运', 1, 0);
INSERT INTO `eb_express` VALUES (74, 'ledii', '乐递供应链', 1, 0);
INSERT INTO `eb_express` VALUES (75, 'lundao', '论道国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (76, 'mailikuaidi', '麦力快递', 1, 0);
INSERT INTO `eb_express` VALUES (77, 'mchy', '木春货运', 1, 0);
INSERT INTO `eb_express` VALUES (78, 'meiquick', '美快国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (79, 'valueway', '美通快递', 1, 0);
INSERT INTO `eb_express` VALUES (80, 'nuoyaao', '偌亚奥国际', 1, 0);
INSERT INTO `eb_express` VALUES (81, 'euasia', '欧亚专线', 1, 0);
INSERT INTO `eb_express` VALUES (82, 'pca', '澳大利亚PCA快递', 1, 0);
INSERT INTO `eb_express` VALUES (83, 'pingandatengfei', '平安达腾飞', 1, 0);
INSERT INTO `eb_express` VALUES (84, 'pjbest', '品骏快递', 1, 0);
INSERT INTO `eb_express` VALUES (85, 'qbexpress', '秦邦快运', 1, 0);
INSERT INTO `eb_express` VALUES (86, 'quanxintong', '全信通快递', 1, 0);
INSERT INTO `eb_express` VALUES (87, 'quansutong', '全速通国际快递', 1, 0);
INSERT INTO `eb_express` VALUES (88, 'qinyuan', '秦远物流', 1, 0);
INSERT INTO `eb_express` VALUES (89, 'qichen', '启辰国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (90, 'quansu', '全速快运', 1, 0);
INSERT INTO `eb_express` VALUES (91, 'qzx56', '全之鑫物流', 1, 0);
INSERT INTO `eb_express` VALUES (92, 'qskdyxgs', '千顺快递', 1, 0);
INSERT INTO `eb_express` VALUES (93, 'runhengfeng', '全时速运', 1, 0);
INSERT INTO `eb_express` VALUES (94, 'rytsd', '日益通速递', 1, 0);
INSERT INTO `eb_express` VALUES (95, 'ruidaex', '瑞达国际速递', 1, 0);
INSERT INTO `eb_express` VALUES (96, 'shiyun', '世运快递', 1, 0);
INSERT INTO `eb_express` VALUES (97, 'sfift', '十方通物流', 1, 0);
INSERT INTO `eb_express` VALUES (98, 'stkd', '顺通快递', 1, 0);
INSERT INTO `eb_express` VALUES (99, 'bgn', '布谷鸟快递', 1, 0);
INSERT INTO `eb_express` VALUES (100, 'jiahuier', '佳惠尔快递', 1, 0);
INSERT INTO `eb_express` VALUES (101, 'pingyou', '小包', 1, 0);
INSERT INTO `eb_express` VALUES (102, 'yumeijie', '誉美捷快递', 1, 0);
INSERT INTO `eb_express` VALUES (103, 'meilong', '美龙快递', 1, 0);
INSERT INTO `eb_express` VALUES (104, 'guangtong', '广通速递', 1, 0);
INSERT INTO `eb_express` VALUES (105, 'STARS', '星晨急便', 1, 0);
INSERT INTO `eb_express` VALUES (106, 'NANHANG', '中国南方航空股份有限公司', 1, 0);
INSERT INTO `eb_express` VALUES (107, 'lanbiao', '蓝镖快递', 1, 0);
INSERT INTO `eb_express` VALUES (109, 'baotongda', '宝通达物流', 1, 0);
INSERT INTO `eb_express` VALUES (110, 'dashun', '大顺物流', 1, 0);
INSERT INTO `eb_express` VALUES (111, 'dada', '大达物流', 1, 0);
INSERT INTO `eb_express` VALUES (112, 'fangfangda', '方方达物流', 1, 0);
INSERT INTO `eb_express` VALUES (113, 'hebeijianhua', '河北建华物流', 1, 0);
INSERT INTO `eb_express` VALUES (114, 'haolaiyun', '好来运快递', 1, 0);
INSERT INTO `eb_express` VALUES (115, 'jinyue', '晋越快递', 1, 0);
INSERT INTO `eb_express` VALUES (116, 'kuaitao', '快淘快递', 1, 0);
INSERT INTO `eb_express` VALUES (117, 'peixing', '陪行物流', 1, 0);
INSERT INTO `eb_express` VALUES (118, 'hkpost', '香港邮政', 1, 0);
INSERT INTO `eb_express` VALUES (119, 'ytfh', '一统飞鸿快递', 1, 0);
INSERT INTO `eb_express` VALUES (120, 'zhongxinda', '中信达快递', 1, 0);
INSERT INTO `eb_express` VALUES (121, 'zhongtian', '中天快运', 1, 0);
INSERT INTO `eb_express` VALUES (122, 'zuochuan', '佐川急便', 1, 0);
INSERT INTO `eb_express` VALUES (123, 'chengguang', '程光快递', 1, 0);
INSERT INTO `eb_express` VALUES (124, 'cszx', '城市之星', 1, 0);
INSERT INTO `eb_express` VALUES (125, 'chuanzhi', '传志快递', 1, 0);
INSERT INTO `eb_express` VALUES (126, 'feibao', '飞豹快递', 1, 0);
INSERT INTO `eb_express` VALUES (127, 'huiqiang', '汇强快递', 1, 0);
INSERT INTO `eb_express` VALUES (128, 'lejiedi', '乐捷递', 1, 0);
INSERT INTO `eb_express` VALUES (129, 'lijisong', '成都立即送快递', 1, 0);
INSERT INTO `eb_express` VALUES (130, 'minbang', '民邦速递', 1, 0);
INSERT INTO `eb_express` VALUES (131, 'ocs', 'OCS国际快递', 1, 0);
INSERT INTO `eb_express` VALUES (132, 'santai', '三态速递', 1, 0);
INSERT INTO `eb_express` VALUES (133, 'saiaodi', '赛澳递', 1, 0);
INSERT INTO `eb_express` VALUES (134, 'jd', '京东快递', 1, 0);
INSERT INTO `eb_express` VALUES (135, 'zengyi', '增益快递', 1, 0);
INSERT INTO `eb_express` VALUES (136, 'fanyu', '凡宇速递', 1, 0);
INSERT INTO `eb_express` VALUES (137, 'fengda', '丰达快递', 1, 0);
INSERT INTO `eb_express` VALUES (138, 'coe', '东方快递', 1, 0);
INSERT INTO `eb_express` VALUES (139, 'ees', '百福东方快递', 1, 0);
INSERT INTO `eb_express` VALUES (140, 'disifang', '递四方速递', 1, 0);
INSERT INTO `eb_express` VALUES (141, 'rufeng', '如风达快递', 1, 0);
INSERT INTO `eb_express` VALUES (142, 'changtong', '长通物流', 1, 0);
INSERT INTO `eb_express` VALUES (143, 'chengshi100', '城市100快递', 1, 0);
INSERT INTO `eb_express` VALUES (144, 'feibang', '飞邦物流', 1, 0);
INSERT INTO `eb_express` VALUES (145, 'haosheng', '昊盛物流', 1, 0);
INSERT INTO `eb_express` VALUES (146, 'yinsu', '音速速运', 1, 0);
INSERT INTO `eb_express` VALUES (147, 'kuanrong', '宽容物流', 1, 0);
INSERT INTO `eb_express` VALUES (148, 'tongcheng', '通成物流', 1, 0);
INSERT INTO `eb_express` VALUES (149, 'tonghe', '通和天下物流', 1, 0);
INSERT INTO `eb_express` VALUES (150, 'zhima', '芝麻开门', 1, 0);
INSERT INTO `eb_express` VALUES (151, 'ririshun', '日日顺物流', 1, 0);
INSERT INTO `eb_express` VALUES (152, 'anxun', '安迅物流', 1, 0);
INSERT INTO `eb_express` VALUES (153, 'baiqian', '百千诚国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (154, 'chukouyi', '出口易', 1, 0);
INSERT INTO `eb_express` VALUES (155, 'diantong', '店通快递', 1, 0);
INSERT INTO `eb_express` VALUES (156, 'dajin', '大金物流', 1, 0);
INSERT INTO `eb_express` VALUES (157, 'feite', '飞特物流', 1, 0);
INSERT INTO `eb_express` VALUES (159, 'gnxb', '国内小包', 1, 0);
INSERT INTO `eb_express` VALUES (160, 'huacheng', '华诚物流', 1, 0);
INSERT INTO `eb_express` VALUES (161, 'huahan', '华翰物流', 1, 0);
INSERT INTO `eb_express` VALUES (162, 'hengyu', '恒宇运通', 1, 0);
INSERT INTO `eb_express` VALUES (163, 'huahang', '华航快递', 1, 0);
INSERT INTO `eb_express` VALUES (164, 'jiuyi', '久易快递', 1, 0);
INSERT INTO `eb_express` VALUES (165, 'jiete', '捷特快递', 1, 0);
INSERT INTO `eb_express` VALUES (166, 'jingshi', '京世物流', 1, 0);
INSERT INTO `eb_express` VALUES (167, 'kuayue', '跨越快递', 1, 0);
INSERT INTO `eb_express` VALUES (168, 'mengsu', '蒙速快递', 1, 0);
INSERT INTO `eb_express` VALUES (169, 'nanbei', '南北快递', 1, 0);
INSERT INTO `eb_express` VALUES (171, 'pinganda', '平安达快递', 1, 0);
INSERT INTO `eb_express` VALUES (172, 'ruifeng', '瑞丰速递', 1, 0);
INSERT INTO `eb_express` VALUES (173, 'rongqing', '荣庆物流', 1, 0);
INSERT INTO `eb_express` VALUES (174, 'suijia', '穗佳物流', 1, 0);
INSERT INTO `eb_express` VALUES (175, 'simai', '思迈快递', 1, 0);
INSERT INTO `eb_express` VALUES (176, 'suteng', '速腾快递', 1, 0);
INSERT INTO `eb_express` VALUES (177, 'shengbang', '晟邦物流', 1, 0);
INSERT INTO `eb_express` VALUES (178, 'suchengzhaipei', '速呈宅配', 1, 0);
INSERT INTO `eb_express` VALUES (179, 'wuhuan', '五环速递', 1, 0);
INSERT INTO `eb_express` VALUES (180, 'xingchengzhaipei', '星程宅配', 1, 0);
INSERT INTO `eb_express` VALUES (181, 'yinjie', '顺捷丰达', 1, 0);
INSERT INTO `eb_express` VALUES (183, 'yanwen', '燕文物流', 1, 0);
INSERT INTO `eb_express` VALUES (184, 'zongxing', '纵行物流', 1, 0);
INSERT INTO `eb_express` VALUES (185, 'aae', 'AAE快递', 1, 0);
INSERT INTO `eb_express` VALUES (186, 'dhl', 'DHL快递', 1, 0);
INSERT INTO `eb_express` VALUES (187, 'feihu', '飞狐快递', 1, 0);
INSERT INTO `eb_express` VALUES (188, 'shunfeng', '顺丰速运', 92, 1);
INSERT INTO `eb_express` VALUES (189, 'spring', '春风物流', 1, 0);
INSERT INTO `eb_express` VALUES (190, 'yidatong', '易达通快递', 1, 0);
INSERT INTO `eb_express` VALUES (191, 'PEWKEE', '彪记快递', 1, 0);
INSERT INTO `eb_express` VALUES (192, 'PHOENIXEXP', '凤凰快递', 1, 0);
INSERT INTO `eb_express` VALUES (193, 'CNGLS', 'GLS快递', 1, 0);
INSERT INTO `eb_express` VALUES (194, 'BHTEXP', '华慧快递', 1, 0);
INSERT INTO `eb_express` VALUES (195, 'B2B', '卡行天下', 1, 0);
INSERT INTO `eb_express` VALUES (196, 'PEISI', '配思货运', 1, 0);
INSERT INTO `eb_express` VALUES (197, 'SUNDAPOST', '上大物流', 1, 0);
INSERT INTO `eb_express` VALUES (198, 'SUYUE', '苏粤货运', 1, 0);
INSERT INTO `eb_express` VALUES (199, 'F5XM', '伍圆速递', 1, 0);
INSERT INTO `eb_express` VALUES (200, 'GZWENJIE', '文捷航空速递', 1, 0);
INSERT INTO `eb_express` VALUES (201, 'yuancheng', '远成物流', 1, 0);
INSERT INTO `eb_express` VALUES (202, 'dpex', 'DPEX快递', 1, 0);
INSERT INTO `eb_express` VALUES (203, 'anjie', '安捷快递', 1, 0);
INSERT INTO `eb_express` VALUES (204, 'jldt', '嘉里大通', 1, 0);
INSERT INTO `eb_express` VALUES (205, 'yousu', '优速快递', 1, 0);
INSERT INTO `eb_express` VALUES (206, 'wanbo', '万博快递', 1, 0);
INSERT INTO `eb_express` VALUES (207, 'sure', '速尔物流', 1, 0);
INSERT INTO `eb_express` VALUES (208, 'sutong', '速通物流', 1, 0);
INSERT INTO `eb_express` VALUES (209, 'JUNCHUANWL', '骏川物流', 1, 0);
INSERT INTO `eb_express` VALUES (210, 'guada', '冠达快递', 1, 0);
INSERT INTO `eb_express` VALUES (211, 'dsu', 'D速快递', 1, 0);
INSERT INTO `eb_express` VALUES (212, 'LONGSHENWL', '龙胜物流', 1, 0);
INSERT INTO `eb_express` VALUES (213, 'abc', '爱彼西快递', 1, 0);
INSERT INTO `eb_express` VALUES (214, 'eyoubao', 'E邮宝', 1, 0);
INSERT INTO `eb_express` VALUES (215, 'aol', 'AOL快递', 1, 0);
INSERT INTO `eb_express` VALUES (216, 'jixianda', '急先达物流', 1, 0);
INSERT INTO `eb_express` VALUES (217, 'haihong', '山东海红快递', 1, 0);
INSERT INTO `eb_express` VALUES (218, 'feiyang', '飞洋快递', 1, 0);
INSERT INTO `eb_express` VALUES (219, 'rpx', 'RPX保时达', 1, 0);
INSERT INTO `eb_express` VALUES (220, 'zhaijisong', '宅急送', 1, 0);
INSERT INTO `eb_express` VALUES (221, 'tiantian', '天天快递', 99, 0);
INSERT INTO `eb_express` VALUES (222, 'yunwuliu', '云物流', 1, 0);
INSERT INTO `eb_express` VALUES (223, 'jiuye', '九曳供应链', 1, 0);
INSERT INTO `eb_express` VALUES (224, 'bsky', '百世快运', 1, 0);
INSERT INTO `eb_express` VALUES (225, 'higo', '黑狗物流', 1, 0);
INSERT INTO `eb_express` VALUES (226, 'arke', '方舟速递', 1, 0);
INSERT INTO `eb_express` VALUES (227, 'zwsy', '中外速运', 1, 0);
INSERT INTO `eb_express` VALUES (228, 'jxy', '吉祥邮', 1, 0);
INSERT INTO `eb_express` VALUES (229, 'aramex', 'Aramex', 1, 0);
INSERT INTO `eb_express` VALUES (230, 'guotong', '国通快递', 1, 0);
INSERT INTO `eb_express` VALUES (231, 'jiayi', '佳怡物流', 1, 0);
INSERT INTO `eb_express` VALUES (232, 'longbang', '龙邦快运', 1, 0);
INSERT INTO `eb_express` VALUES (233, 'minhang', '民航快递', 1, 0);
INSERT INTO `eb_express` VALUES (234, 'quanyi', '全一快递', 1, 0);
INSERT INTO `eb_express` VALUES (235, 'quanchen', '全晨快递', 1, 0);
INSERT INTO `eb_express` VALUES (236, 'usps', 'USPS快递', 1, 0);
INSERT INTO `eb_express` VALUES (237, 'xinbang', '新邦物流', 1, 0);
INSERT INTO `eb_express` VALUES (238, 'yuanzhi', '元智捷诚快递', 1, 0);
INSERT INTO `eb_express` VALUES (239, 'zhongyou', '中邮物流', 1, 0);
INSERT INTO `eb_express` VALUES (240, 'yuxin', '宇鑫物流', 1, 0);
INSERT INTO `eb_express` VALUES (241, 'cnpex', '中环快递', 1, 0);
INSERT INTO `eb_express` VALUES (242, 'shengfeng', '盛丰物流', 1, 0);
INSERT INTO `eb_express` VALUES (243, 'yuantong', '圆通速递', 97, 1);
INSERT INTO `eb_express` VALUES (244, 'jiayunmei', '加运美物流', 1, 0);
INSERT INTO `eb_express` VALUES (245, 'ywfex', '源伟丰快递', 1, 0);
INSERT INTO `eb_express` VALUES (246, 'xinfeng', '信丰物流', 1, 0);
INSERT INTO `eb_express` VALUES (247, 'wanxiang', '万象物流', 1, 0);
INSERT INTO `eb_express` VALUES (248, 'menduimen', '门对门', 1, 0);
INSERT INTO `eb_express` VALUES (249, 'mingliang', '明亮物流', 1, 0);
INSERT INTO `eb_express` VALUES (250, 'fengxingtianxia', '风行天下', 1, 0);
INSERT INTO `eb_express` VALUES (251, 'gongsuda', '共速达物流', 1, 0);
INSERT INTO `eb_express` VALUES (252, 'zhongtong', '中通快递', 100, 1);
INSERT INTO `eb_express` VALUES (253, 'quanritong', '全日通快递', 1, 0);
INSERT INTO `eb_express` VALUES (254, 'ems', 'EMS', 1, 1);
INSERT INTO `eb_express` VALUES (255, 'wanjia', '万家物流', 1, 0);
INSERT INTO `eb_express` VALUES (256, 'yuntong', '运通快递', 1, 0);
INSERT INTO `eb_express` VALUES (257, 'feikuaida', '飞快达物流', 1, 0);
INSERT INTO `eb_express` VALUES (258, 'haimeng', '海盟速递', 1, 0);
INSERT INTO `eb_express` VALUES (259, 'zhongsukuaidi', '中速快件', 1, 0);
INSERT INTO `eb_express` VALUES (260, 'yuefeng', '越丰快递', 1, 0);
INSERT INTO `eb_express` VALUES (261, 'shenghui', '盛辉物流', 1, 0);
INSERT INTO `eb_express` VALUES (262, 'datian', '大田物流', 1, 0);
INSERT INTO `eb_express` VALUES (263, 'quanjitong', '全际通快递', 1, 0);
INSERT INTO `eb_express` VALUES (264, 'longlangkuaidi', '隆浪快递', 1, 0);
INSERT INTO `eb_express` VALUES (265, 'neweggozzo', '新蛋奥硕物流', 1, 0);
INSERT INTO `eb_express` VALUES (266, 'shentong', '申通快递', 95, 1);
INSERT INTO `eb_express` VALUES (267, 'haiwaihuanqiu', '海外环球', 1, 0);
INSERT INTO `eb_express` VALUES (268, 'yad', '源安达快递', 1, 0);
INSERT INTO `eb_express` VALUES (269, 'jindawuliu', '金大物流', 1, 0);
INSERT INTO `eb_express` VALUES (270, 'sevendays', '七天连锁', 1, 0);
INSERT INTO `eb_express` VALUES (271, 'tnt', 'TNT快递', 1, 0);
INSERT INTO `eb_express` VALUES (272, 'huayu', '天地华宇物流', 1, 0);
INSERT INTO `eb_express` VALUES (273, 'lianhaotong', '联昊通快递', 1, 0);
INSERT INTO `eb_express` VALUES (274, 'nengda', '港中能达快递', 1, 0);
INSERT INTO `eb_express` VALUES (275, 'LBWL', '联邦物流', 1, 0);
INSERT INTO `eb_express` VALUES (276, 'ontrac', 'onTrac', 1, 0);
INSERT INTO `eb_express` VALUES (277, 'feihang', '原飞航快递', 1, 0);
INSERT INTO `eb_express` VALUES (278, 'bangsongwuliu', '邦送物流', 1, 0);
INSERT INTO `eb_express` VALUES (279, 'huaxialong', '华夏龙物流', 1, 0);
INSERT INTO `eb_express` VALUES (280, 'ztwy', '中天万运快递', 1, 0);
INSERT INTO `eb_express` VALUES (281, 'fkd', '飞康达物流', 1, 0);
INSERT INTO `eb_express` VALUES (282, 'anxinda', '安信达快递', 1, 0);
INSERT INTO `eb_express` VALUES (283, 'quanfeng', '全峰快递', 1, 0);
INSERT INTO `eb_express` VALUES (284, 'shengan', '圣安物流', 1, 0);
INSERT INTO `eb_express` VALUES (285, 'jiaji', '佳吉物流', 1, 0);
INSERT INTO `eb_express` VALUES (286, 'yunda', '韵达快运', 94, 0);
INSERT INTO `eb_express` VALUES (287, 'ups', 'UPS快递', 1, 0);
INSERT INTO `eb_express` VALUES (288, 'debang', '德邦物流', 1, 0);
INSERT INTO `eb_express` VALUES (289, 'yafeng', '亚风速递', 1, 0);
INSERT INTO `eb_express` VALUES (290, 'kuaijie', '快捷速递', 98, 0);
INSERT INTO `eb_express` VALUES (291, 'huitong', '百世快递', 93, 0);
INSERT INTO `eb_express` VALUES (293, 'aolau', 'AOL澳通速递', 1, 0);
INSERT INTO `eb_express` VALUES (294, 'anneng', '安能物流', 1, 0);
INSERT INTO `eb_express` VALUES (295, 'auexpress', '澳邮中国快运', 1, 0);
INSERT INTO `eb_express` VALUES (296, 'exfresh', '安鲜达', 1, 0);
INSERT INTO `eb_express` VALUES (297, 'bcwelt', 'BCWELT', 1, 0);
INSERT INTO `eb_express` VALUES (298, 'youzhengguonei', '挂号信', 1, 0);
INSERT INTO `eb_express` VALUES (299, 'xiaohongmao', '北青小红帽', 1, 0);
INSERT INTO `eb_express` VALUES (300, 'lbbk', '宝凯物流', 1, 0);
INSERT INTO `eb_express` VALUES (301, 'byht', '博源恒通', 1, 0);
INSERT INTO `eb_express` VALUES (302, 'idada', '百成大达物流', 1, 0);
INSERT INTO `eb_express` VALUES (303, 'baitengwuliu', '百腾物流', 1, 0);
INSERT INTO `eb_express` VALUES (304, 'birdex', '笨鸟海淘', 1, 0);
INSERT INTO `eb_express` VALUES (305, 'bsht', '百事亨通', 1, 0);
INSERT INTO `eb_express` VALUES (306, 'dayang', '大洋物流快递', 1, 0);
INSERT INTO `eb_express` VALUES (307, 'dechuangwuliu', '德创物流', 1, 0);
INSERT INTO `eb_express` VALUES (308, 'donghanwl', '东瀚物流', 1, 0);
INSERT INTO `eb_express` VALUES (309, 'dfpost', '达方物流', 1, 0);
INSERT INTO `eb_express` VALUES (310, 'dongjun', '东骏快捷物流', 1, 0);
INSERT INTO `eb_express` VALUES (311, 'dindon', '叮咚澳洲转运', 1, 0);
INSERT INTO `eb_express` VALUES (312, 'dazhong', '大众佐川急便', 1, 0);
INSERT INTO `eb_express` VALUES (313, 'decnlh', '德中快递', 1, 0);
INSERT INTO `eb_express` VALUES (314, 'dekuncn', '德坤供应链', 1, 0);
INSERT INTO `eb_express` VALUES (315, 'eshunda', '俄顺达', 1, 0);
INSERT INTO `eb_express` VALUES (316, 'ewe', 'EWE全球快递', 1, 0);
INSERT INTO `eb_express` VALUES (317, 'fedexuk', 'FedEx英国', 1, 0);
INSERT INTO `eb_express` VALUES (318, 'fox', 'FOX国际速递', 1, 0);
INSERT INTO `eb_express` VALUES (319, 'rufengda', '凡客如风达', 1, 0);
INSERT INTO `eb_express` VALUES (320, 'fandaguoji', '颿达国际快递', 1, 0);
INSERT INTO `eb_express` VALUES (321, 'hnfy', '飞鹰物流', 1, 0);
INSERT INTO `eb_express` VALUES (322, 'flysman', '飞力士物流', 1, 0);
INSERT INTO `eb_express` VALUES (323, 'sccod', '丰程物流', 1, 0);
INSERT INTO `eb_express` VALUES (324, 'farlogistis', '泛远国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (325, 'gsm', 'GSM', 1, 0);
INSERT INTO `eb_express` VALUES (326, 'gaticn', 'GATI快递', 1, 0);
INSERT INTO `eb_express` VALUES (327, 'gts', 'GTS快递', 1, 0);
INSERT INTO `eb_express` VALUES (328, 'gangkuai', '港快速递', 1, 0);
INSERT INTO `eb_express` VALUES (329, 'gtsd', '高铁速递', 1, 0);
INSERT INTO `eb_express` VALUES (330, 'tiandihuayu', '华宇物流', 1, 0);
INSERT INTO `eb_express` VALUES (331, 'huangmajia', '黄马甲快递', 1, 0);
INSERT INTO `eb_express` VALUES (332, 'ucs', '合众速递', 1, 0);
INSERT INTO `eb_express` VALUES (333, 'huoban', '伙伴物流', 1, 0);
INSERT INTO `eb_express` VALUES (334, 'nedahm', '红马速递', 1, 0);
INSERT INTO `eb_express` VALUES (335, 'huiwen', '汇文配送', 1, 0);
INSERT INTO `eb_express` VALUES (336, 'nmhuahe', '华赫物流', 1, 0);
INSERT INTO `eb_express` VALUES (337, 'hangyu', '航宇快递', 1, 0);
INSERT INTO `eb_express` VALUES (338, 'minsheng', '闽盛物流', 1, 0);
INSERT INTO `eb_express` VALUES (339, 'riyu', '日昱物流', 1, 0);
INSERT INTO `eb_express` VALUES (340, 'sxhongmajia', '山西红马甲', 1, 0);
INSERT INTO `eb_express` VALUES (341, 'syjiahuier', '沈阳佳惠尔', 1, 0);
INSERT INTO `eb_express` VALUES (342, 'shlindao', '上海林道货运', 1, 0);
INSERT INTO `eb_express` VALUES (343, 'shunjiefengda', '顺捷丰达', 1, 0);
INSERT INTO `eb_express` VALUES (344, 'subida', '速必达物流', 1, 0);
INSERT INTO `eb_express` VALUES (345, 'bphchina', '速方国际物流', 1, 0);
INSERT INTO `eb_express` VALUES (346, 'sendtochina', '速递中国', 1, 0);
INSERT INTO `eb_express` VALUES (347, 'suning', '苏宁快递', 1, 0);
INSERT INTO `eb_express` VALUES (348, 'sihaiet', '四海快递', 1, 0);
INSERT INTO `eb_express` VALUES (349, 'tianzong', '天纵物流', 1, 0);
INSERT INTO `eb_express` VALUES (350, 'chinatzx', '同舟行物流', 1, 0);
INSERT INTO `eb_express` VALUES (351, 'nntengda', '腾达速递', 1, 0);
INSERT INTO `eb_express` VALUES (352, 'sd138', '泰国138', 1, 0);
INSERT INTO `eb_express` VALUES (353, 'tongdaxing', '通达兴物流', 1, 0);
INSERT INTO `eb_express` VALUES (354, 'tlky', '天联快运', 1, 0);
INSERT INTO `eb_express` VALUES (355, 'youshuwuliu', 'UC优速快递', 1, 0);
INSERT INTO `eb_express` VALUES (356, 'ueq', 'UEQ快递', 1, 0);
INSERT INTO `eb_express` VALUES (357, 'weitepai', '微特派快递', 1, 0);
INSERT INTO `eb_express` VALUES (358, 'wtdchina', '威时沛运', 1, 0);
INSERT INTO `eb_express` VALUES (359, 'wzhaunyun', '微转运', 1, 0);
INSERT INTO `eb_express` VALUES (360, 'gswtkd', '万通快递', 1, 0);
INSERT INTO `eb_express` VALUES (361, 'wotu', '渥途国际速运', 1, 0);
INSERT INTO `eb_express` VALUES (362, 'xiyoute', '希优特快递', 1, 0);
INSERT INTO `eb_express` VALUES (363, 'xilaikd', '喜来快递', 1, 0);
INSERT INTO `eb_express` VALUES (364, 'xsrd', '鑫世锐达', 1, 0);
INSERT INTO `eb_express` VALUES (365, 'xtb', '鑫通宝物流', 1, 0);
INSERT INTO `eb_express` VALUES (366, 'xintianjie', '信天捷快递', 1, 0);
INSERT INTO `eb_express` VALUES (367, 'xaetc', '西安胜峰', 1, 0);
INSERT INTO `eb_express` VALUES (368, 'xianfeng', '先锋快递', 1, 0);
INSERT INTO `eb_express` VALUES (369, 'sunspeedy', '新速航', 1, 0);
INSERT INTO `eb_express` VALUES (370, 'xipost', '西邮寄', 1, 0);
INSERT INTO `eb_express` VALUES (371, 'sinatone', '信联通', 1, 0);
INSERT INTO `eb_express` VALUES (372, 'sunjex', '新杰物流', 1, 0);
INSERT INTO `eb_express` VALUES (373, 'yundaexus', '韵达美国件', 1, 0);
INSERT INTO `eb_express` VALUES (374, 'yxwl', '宇鑫物流', 1, 0);
INSERT INTO `eb_express` VALUES (375, 'yitongda', '易通达', 1, 0);
INSERT INTO `eb_express` VALUES (376, 'yiqiguojiwuliu', '一柒物流', 1, 0);
INSERT INTO `eb_express` VALUES (377, 'yilingsuyun', '亿领速运', 1, 0);
INSERT INTO `eb_express` VALUES (378, 'yujiawuliu', '煜嘉物流', 1, 0);
INSERT INTO `eb_express` VALUES (379, 'gml', '英脉物流', 1, 0);
INSERT INTO `eb_express` VALUES (380, 'leopard', '云豹国际货运', 1, 0);
INSERT INTO `eb_express` VALUES (381, 'czwlyn', '云南中诚', 1, 0);
INSERT INTO `eb_express` VALUES (382, 'sdyoupei', '优配速运', 1, 0);
INSERT INTO `eb_express` VALUES (383, 'yongchang', '永昌物流', 1, 0);
INSERT INTO `eb_express` VALUES (384, 'yufeng', '御风速运', 1, 0);
INSERT INTO `eb_express` VALUES (385, 'yamaxunwuliu', '亚马逊物流', 1, 0);
INSERT INTO `eb_express` VALUES (386, 'yousutongda', '优速通达', 1, 0);
INSERT INTO `eb_express` VALUES (387, 'yishunhang', '亿顺航', 1, 0);
INSERT INTO `eb_express` VALUES (388, 'yongwangda', '永旺达快递', 1, 0);
INSERT INTO `eb_express` VALUES (389, 'ecmscn', '易满客', 1, 0);
INSERT INTO `eb_express` VALUES (390, 'yingchao', '英超物流', 1, 0);
INSERT INTO `eb_express` VALUES (391, 'edlogistics', '益递物流', 1, 0);
INSERT INTO `eb_express` VALUES (392, 'yyexpress', '远洋国际', 1, 0);
INSERT INTO `eb_express` VALUES (393, 'onehcang', '一号仓', 1, 0);
INSERT INTO `eb_express` VALUES (394, 'ycgky', '远成快运', 1, 0);
INSERT INTO `eb_express` VALUES (395, 'lineone', '一号线', 1, 0);
INSERT INTO `eb_express` VALUES (396, 'ypsd', '壹品速递', 1, 0);
INSERT INTO `eb_express` VALUES (397, 'vipexpress', '鹰运国际速递', 1, 0);
INSERT INTO `eb_express` VALUES (398, 'el56', '易联通达物流', 1, 0);
INSERT INTO `eb_express` VALUES (399, 'yyqc56', '一运全成物流', 1, 0);
INSERT INTO `eb_express` VALUES (400, 'zhongtie', '中铁快运', 1, 0);
INSERT INTO `eb_express` VALUES (401, 'ZTKY', '中铁物流', 1, 0);
INSERT INTO `eb_express` VALUES (402, 'zzjh', '郑州建华快递', 1, 0);
INSERT INTO `eb_express` VALUES (403, 'zhongruisudi', '中睿速递', 1, 0);
INSERT INTO `eb_express` VALUES (404, 'zhongwaiyun', '中外运速递', 1, 0);
INSERT INTO `eb_express` VALUES (405, 'zengyisudi', '增益速递', 1, 0);
INSERT INTO `eb_express` VALUES (406, 'sujievip', '郑州速捷', 1, 0);
INSERT INTO `eb_express` VALUES (407, 'zhichengtongda', '至诚通达快递', 1, 0);
INSERT INTO `eb_express` VALUES (408, 'zhdwl', '众辉达物流', 1, 0);
INSERT INTO `eb_express` VALUES (409, 'kuachangwuliu', '直邮易', 1, 0);
INSERT INTO `eb_express` VALUES (410, 'topspeedex', '中运全速', 1, 0);
INSERT INTO `eb_express` VALUES (411, 'otobv', '中欧快运', 1, 0);
INSERT INTO `eb_express` VALUES (412, 'zsky123', '准实快运', 1, 0);
INSERT INTO `eb_express` VALUES (413, 'donghong', '东红物流', 1, 0);
INSERT INTO `eb_express` VALUES (414, 'kuaiyouda', '快优达速递', 1, 0);
INSERT INTO `eb_express` VALUES (415, 'balunzhi', '巴伦支快递', 1, 0);
INSERT INTO `eb_express` VALUES (416, 'hutongwuliu', '户通物流', 1, 0);
INSERT INTO `eb_express` VALUES (417, 'xianchenglian', '西安城联速递', 1, 0);
INSERT INTO `eb_express` VALUES (418, 'youbijia', '邮必佳', 1, 0);
INSERT INTO `eb_express` VALUES (419, 'feiyuan', '飞远物流', 1, 0);
INSERT INTO `eb_express` VALUES (420, 'chengji', '城际速递', 1, 0);
INSERT INTO `eb_express` VALUES (421, 'huaqi', '华企快运', 1, 0);
INSERT INTO `eb_express` VALUES (422, 'yibang', '一邦快递', 1, 0);
INSERT INTO `eb_express` VALUES (423, 'citylink', 'CityLink快递', 1, 0);
INSERT INTO `eb_express` VALUES (424, 'meixi', '美西快递', 1, 0);
INSERT INTO `eb_express` VALUES (425, 'acs', 'ACS', 1, 0);

-- ----------------------------
-- Table structure for eb_routine_access_token
-- ----------------------------
DROP TABLE IF EXISTS `eb_routine_access_token`;
CREATE TABLE `eb_routine_access_token`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '小程序access_token表ID',
  `access_token` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'openid',
  `stop_time` int(11) UNSIGNED NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '小程序access_token表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_routine_form_id
-- ----------------------------
DROP TABLE IF EXISTS `eb_routine_form_id`;
CREATE TABLE `eb_routine_form_id`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '表单ID表ID',
  `uid` int(11) NULL DEFAULT 0 COMMENT '用户uid',
  `form_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单ID',
  `stop_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '表单ID失效时间',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '状态1 未使用 2不能使用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '表单id表记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_routine_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `eb_routine_qrcode`;
CREATE TABLE `eb_routine_qrcode`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '微信二维码ID',
  `third_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '二维码类型 spread(用户推广) product_spread(商品推广)',
  `third_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态 0不可用 1可用',
  `add_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加时间',
  `page` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小程序页面路径带参数',
  `qrcode_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小程序二维码路径',
  `url_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '二维码添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '小程序二维码管理表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_shipping_templates
-- ----------------------------
DROP TABLE IF EXISTS `eb_shipping_templates`;
CREATE TABLE `eb_shipping_templates`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板名称',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '计费方式',
  `appoint` tinyint(1) NOT NULL DEFAULT 0 COMMENT '指定包邮',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_shipping_templates
-- ----------------------------
INSERT INTO `eb_shipping_templates` VALUES (1, '通用模板-广东198包邮', 2, 1, 99, 1588322063);
INSERT INTO `eb_shipping_templates` VALUES (2, '包邮商品-偏远地区除外', 2, 1, 98, 1588322206);
INSERT INTO `eb_shipping_templates` VALUES (3, '独立包邮一组：非偏远区域满99包邮', 2, 1, 97, 1588322359);

-- ----------------------------
-- Table structure for eb_shipping_templates_free
-- ----------------------------
DROP TABLE IF EXISTS `eb_shipping_templates_free`;
CREATE TABLE `eb_shipping_templates_free`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `province_id` int(11) NOT NULL DEFAULT 0 COMMENT '省ID',
  `temp_id` int(11) NOT NULL DEFAULT 0 COMMENT '模板ID',
  `city_id` int(11) NOT NULL DEFAULT 0 COMMENT '城市ID',
  `number` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '包邮件数',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '包邮金额',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '计费方式',
  `uniqid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组唯一值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1308 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_shipping_templates_free
-- ----------------------------
INSERT INTO `eb_shipping_templates_free` VALUES (1257, 483250, 1, 483251, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1258, 483250, 1, 486129, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1259, 483250, 1, 487721, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1260, 483250, 1, 488589, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1261, 483250, 1, 488954, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1262, 483250, 1, 490106, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1263, 483250, 1, 490919, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1264, 483250, 1, 492341, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1265, 483250, 1, 494394, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1266, 483250, 1, 496438, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1267, 483250, 1, 498104, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1268, 483250, 1, 499489, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1269, 483250, 1, 501867, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1270, 483250, 1, 502828, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1271, 483250, 1, 504366, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1272, 483250, 1, 505298, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1273, 483250, 1, 506616, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1274, 483250, 1, 507255, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1275, 483250, 1, 507557, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1276, 483250, 1, 508648, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1277, 483250, 1, 510408, 5.00, 198.00, 2, '15eabdf0f9ca42');
INSERT INTO `eb_shipping_templates_free` VALUES (1278, 1, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1279, 7362, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1280, 13267, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1281, 67747, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1282, 99537, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1283, 115224, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1284, 133208, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1285, 145665, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1286, 161792, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1287, 167904, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1288, 191019, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1289, 224649, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1290, 244377, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1291, 262698, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1292, 285860, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1293, 367395, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1294, 420824, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1295, 452123, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1296, 483250, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1297, 511462, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1298, 529344, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1299, 533328, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1300, 545532, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1301, 604131, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1302, 624372, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1303, 646578, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1304, 671119, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1305, 690094, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1306, 695259, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');
INSERT INTO `eb_shipping_templates_free` VALUES (1307, 714390, 3, 2, 5.00, 99.00, 2, '15eabe037b3201');

-- ----------------------------
-- Table structure for eb_shipping_templates_region
-- ----------------------------
DROP TABLE IF EXISTS `eb_shipping_templates_region`;
CREATE TABLE `eb_shipping_templates_region`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `province_id` int(11) NOT NULL DEFAULT 0 COMMENT '省ID',
  `temp_id` int(11) NOT NULL DEFAULT 0 COMMENT '模板ID',
  `city_id` int(11) NOT NULL DEFAULT 0 COMMENT '城市ID',
  `first` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '首件',
  `first_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '首件运费',
  `continue` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '续件',
  `continue_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '续件运费',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '计费方式',
  `uniqid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组唯一值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 710 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_shipping_templates_region
-- ----------------------------
INSERT INTO `eb_shipping_templates_region` VALUES (619, 0, 1, 0, 1.00, 22.00, 1.00, 8.00, 2, '15eabdf0f8fdd5');
INSERT INTO `eb_shipping_templates_region` VALUES (620, 0, 1, 0, 1.00, 22.00, 1.00, 8.00, 2, '15eabdf0f8fdd5');
INSERT INTO `eb_shipping_templates_region` VALUES (621, 483250, 1, 483251, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (622, 483250, 1, 486129, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (623, 483250, 1, 487721, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (624, 483250, 1, 488589, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (625, 483250, 1, 488954, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (626, 483250, 1, 490106, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (627, 483250, 1, 490919, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (628, 483250, 1, 492341, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (629, 483250, 1, 494394, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (630, 483250, 1, 496438, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (631, 483250, 1, 498104, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (632, 483250, 1, 499489, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (633, 483250, 1, 501867, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (634, 483250, 1, 502828, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (635, 483250, 1, 504366, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (636, 483250, 1, 505298, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (637, 483250, 1, 506616, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (638, 483250, 1, 507255, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (639, 483250, 1, 507557, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (640, 483250, 1, 508648, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (641, 483250, 1, 510408, 2.00, 12.00, 1.00, 2.00, 2, '15eabdf0f8fddd');
INSERT INTO `eb_shipping_templates_region` VALUES (642, 640332, 1, 640333, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (643, 640332, 1, 640675, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (644, 640332, 1, 642571, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (645, 640332, 1, 643863, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (646, 640332, 1, 644423, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (647, 640332, 1, 645076, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (648, 640332, 1, 646392, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (649, 698440, 1, 640333, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (650, 698440, 1, 640675, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (651, 698440, 1, 642571, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (652, 698440, 1, 643863, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (653, 698440, 1, 644423, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (654, 698440, 1, 645076, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (655, 698440, 1, 646392, 1.00, 32.00, 1.00, 16.00, 2, '15eabdf0f8fdf9');
INSERT INTO `eb_shipping_templates_region` VALUES (656, 714368, 1, 752150, 1.00, 42.00, 1.00, 32.00, 2, '15eabdf0f8fe08');
INSERT INTO `eb_shipping_templates_region` VALUES (657, 714390, 1, 752150, 1.00, 42.00, 1.00, 32.00, 2, '15eabdf0f8fe08');
INSERT INTO `eb_shipping_templates_region` VALUES (658, 714401, 1, 752150, 1.00, 42.00, 1.00, 32.00, 2, '15eabdf0f8fe08');
INSERT INTO `eb_shipping_templates_region` VALUES (659, 0, 2, 0, 0.00, 0.00, 1.00, 0.00, 2, '15eabdf9e41d3f');
INSERT INTO `eb_shipping_templates_region` VALUES (660, 0, 2, 0, 0.00, 0.00, 1.00, 0.00, 2, '15eabdf9e41d3f');
INSERT INTO `eb_shipping_templates_region` VALUES (661, 640332, 2, 646392, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (662, 640332, 2, 645076, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (663, 640332, 2, 644423, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (664, 640332, 2, 643863, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (665, 640332, 2, 642571, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (666, 640332, 2, 640675, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (667, 640332, 2, 640333, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (668, 698440, 2, 713697, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (669, 698440, 2, 712893, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (670, 698440, 2, 711218, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (671, 698440, 2, 709792, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (672, 698440, 2, 708117, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (673, 698440, 2, 705145, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (674, 698440, 2, 704779, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (675, 698440, 2, 703119, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (676, 698440, 2, 702104, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (677, 698440, 2, 701559, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (678, 698440, 2, 700489, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (679, 698440, 2, 700070, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (680, 698440, 2, 699773, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (681, 698440, 2, 699583, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (682, 698440, 2, 698441, 1.00, 12.00, 1.00, 8.00, 2, '15eabdf9e41d46');
INSERT INTO `eb_shipping_templates_region` VALUES (683, 714368, 2, 752150, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (684, 714390, 2, 752169, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (685, 714401, 2, 749957, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (686, 714401, 2, 749930, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (687, 714401, 2, 749571, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (688, 714401, 2, 748553, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (689, 714401, 2, 745674, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (690, 714401, 2, 743938, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (691, 714401, 2, 742636, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (692, 714401, 2, 742126, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (693, 714401, 2, 740510, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (694, 714401, 2, 739957, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (695, 714401, 2, 737861, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (696, 714401, 2, 737856, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (697, 714401, 2, 736051, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (698, 714401, 2, 734179, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (699, 714401, 2, 730843, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (700, 714401, 2, 729928, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (701, 714401, 2, 727730, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (702, 714401, 2, 725488, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (703, 714401, 2, 722024, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (704, 714401, 2, 720118, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (705, 714401, 2, 719868, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (706, 714401, 2, 717531, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (707, 714401, 2, 714402, 1.00, 18.00, 1.00, 16.00, 2, '15eabdf9e41d5b');
INSERT INTO `eb_shipping_templates_region` VALUES (708, 0, 3, 0, 2.00, 22.00, 1.00, 8.00, 2, '15eabe037a9142');
INSERT INTO `eb_shipping_templates_region` VALUES (709, 0, 3, 0, 2.00, 22.00, 1.00, 8.00, 2, '15eabe037a9142');

-- ----------------------------
-- Table structure for eb_sms_record
-- ----------------------------
DROP TABLE IF EXISTS `eb_sms_record`;
CREATE TABLE `eb_sms_record`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '短信发送记录编号',
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '短信平台账号',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接受短信的手机号',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '短信内容',
  `add_time` int(11) UNSIGNED NOT NULL COMMENT '发送短信时间',
  `add_ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '添加记录ip',
  `template` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '短信模板ID',
  `resultcode` int(6) UNSIGNED NULL DEFAULT NULL COMMENT '状态码 100=成功,130=失败,131=空号,132=停机,133=关机,134=无状态',
  `record_id` int(11) UNSIGNED NOT NULL COMMENT '发送记录id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短信发送记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_bargain
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_bargain`;
CREATE TABLE `eb_store_bargain`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '砍价商品ID',
  `product_id` int(11) UNSIGNED NOT NULL COMMENT '关联商品ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '砍价活动名称',
  `image` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '砍价活动图片',
  `unit_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位名称',
  `stock` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '库存',
  `sales` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '销量',
  `images` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '砍价商品轮播图',
  `start_time` int(11) UNSIGNED NOT NULL COMMENT '砍价开启时间',
  `stop_time` int(11) UNSIGNED NOT NULL COMMENT '砍价结束时间',
  `store_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '砍价商品名称',
  `price` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '砍价金额',
  `min_price` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '砍价商品最低价',
  `num` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '每次购买的砍价商品数量',
  `bargain_max_price` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '用户每次砍价的最大金额',
  `bargain_min_price` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '用户每次砍价的最小金额',
  `bargain_num` int(11) UNSIGNED NOT NULL DEFAULT 1 COMMENT '用户每次砍价的次数',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '砍价状态 0(到砍价时间不自动开启)  1(到砍价时间自动开启时间)',
  `give_integral` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '反多少积分',
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '砍价活动简介',
  `cost` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '成本价',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `is_hot` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否推荐0不推荐1推荐',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除 0未删除 1删除',
  `add_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `is_postage` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否包邮 0不包邮 1包邮',
  `postage` decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '邮费',
  `rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '砍价规则',
  `look` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '砍价商品浏览量',
  `share` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '砍价商品分享量',
  `temp_id` int(11) NULL DEFAULT NULL COMMENT '运费模板ID',
  `weight` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '重量',
  `volume` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '体积',
  `quota` int(10) NOT NULL DEFAULT 0 COMMENT '限购总数',
  `quota_show` int(10) NOT NULL DEFAULT 0 COMMENT '限量总数显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '砍价表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_bargain_user
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_bargain_user`;
CREATE TABLE `eb_store_bargain_user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户参与砍价表ID',
  `uid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `bargain_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '砍价商品id',
  `bargain_price_min` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '砍价的最低价',
  `bargain_price` decimal(8, 2) NULL DEFAULT NULL COMMENT '砍价金额',
  `price` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '砍掉的价格',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态 1参与中 2 活动结束参与失败 3活动结束参与成功',
  `add_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '参与时间',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否取消',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户参与砍价表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_bargain_user_help
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_bargain_user_help`;
CREATE TABLE `eb_store_bargain_user_help`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '砍价用户帮助表ID',
  `uid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '帮助的用户id',
  `bargain_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '砍价商品ID',
  `bargain_user_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '用户参与砍价表id',
  `price` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '帮助砍价多少金额',
  `add_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '砍价用户帮助表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_cart
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_cart`;
CREATE TABLE `eb_store_cart`  (
  `id` bigint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车表ID',
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `product_attr_unique` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品属性',
  `cart_num` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品数量',
  `add_time` int(10) UNSIGNED NOT NULL COMMENT '添加时间',
  `is_pay` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = 未购买 1 = 已购买',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `is_new` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为立即购买',
  `combination_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '拼团id',
  `seckill_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '秒杀商品ID',
  `bargain_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '砍价id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`uid`) USING BTREE,
  INDEX `goods_id`(`product_id`) USING BTREE,
  INDEX `uid`(`uid`, `is_pay`) USING BTREE,
  INDEX `uid_2`(`uid`, `is_del`) USING BTREE,
  INDEX `uid_3`(`uid`, `is_new`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_category
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_category`;
CREATE TABLE `eb_store_category`  (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT COMMENT '商品分类表ID',
  `pid` mediumint(11) NOT NULL COMMENT '父id',
  `cate_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `sort` mediumint(11) NOT NULL COMMENT '排序',
  `pic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `is_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否推荐',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `is_base`(`is_show`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_store_category
-- ----------------------------
INSERT INTO `eb_store_category` VALUES (1, 0, '健康餐桌', 9, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (2, 1, '超值之选', 99, 'https://oss.foodtrust.cn//4f2ae202004251037016803.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (3, 1, '产地直发', 98, 'https://oss.foodtrust.cn//3237e202004251037002506.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (4, 1, '时令蔬菜', 97, 'https://oss.foodtrust.cn//a0ec4202004251037003274.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (5, 1, '当季水果', 96, 'https://oss.foodtrust.cn//11dff202004251037008622.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (6, 1, '禽蛋鱼肉', 95, 'https://oss.foodtrust.cn//860b7202004251037007355.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (7, 1, '安心料理', 94, 'https://oss.foodtrust.cn//398dd202004251037001150.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (8, 1, '面点乳品', 93, 'https://oss.foodtrust.cn//e15f0202004251037005731.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (9, 1, '粮油调料', 92, 'https://oss.foodtrust.cn//bc94a202004251037003016.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (10, 1, '南北特产', 91, 'https://oss.foodtrust.cn//bf573202004251037007349.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (11, 1, '干果零食', 90, 'https://oss.foodtrust.cn//bf573202004251037007349.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (12, 1, '茶饮冲调', 89, 'https://oss.foodtrust.cn//e15f0202004251037005731.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (13, 1, '更多好物', 88, 'https://oss.foodtrust.cn//4f2ae202004251037016803.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (20, 0, '环保日用', 8, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (21, 20, '环保用品', 99, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (22, 20, '个人护理', 98, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (23, 20, '居家日常', 97, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (30, 0, '母婴专区', 7, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (31, 30, '孕期首选', 99, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (32, 30, '襁褓之爱', 98, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (33, 30, '咿呀学语', 97, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (34, 30, '青梅竹马', 96, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (35, 30, '豆蔻年华', 95, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (40, 0, '会员专区', 6, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (41, 40, '专项服务', 99, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (42, 40, '肠道免疫', 98, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (43, 40, '舒眠护脊', 97, 'https://oss.foodtrust.cn//de625202004251154513069.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (44, 40, '环境安全', 96, 'https://oss.foodtrust.cn//4f2ae202004251037016803.png', 1, 1587782527);
INSERT INTO `eb_store_category` VALUES (45, 40, '系统保留', 95, 'https://oss.foodtrust.cn//4f2ae202004251037016803.png', 1, 1587782527);

-- ----------------------------
-- Table structure for eb_store_combination
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_combination`;
CREATE TABLE `eb_store_combination`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品id',
  `mer_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '商户id',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '推荐图',
  `images` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '轮播图',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动标题',
  `attr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动属性',
  `people` int(2) UNSIGNED NOT NULL COMMENT '参团人数',
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '简介',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '价格',
  `sort` int(10) UNSIGNED NOT NULL COMMENT '排序',
  `sales` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量',
  `stock` int(10) UNSIGNED NOT NULL COMMENT '库存',
  `add_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '添加时间',
  `is_host` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '推荐',
  `is_show` tinyint(1) UNSIGNED NOT NULL COMMENT '商品状态',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `combination` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `mer_use` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '商户是否可用1可用0不可用',
  `is_postage` tinyint(1) UNSIGNED NOT NULL COMMENT '是否包邮1是0否',
  `postage` decimal(10, 2) UNSIGNED NOT NULL COMMENT '邮费',
  `start_time` int(11) UNSIGNED NOT NULL COMMENT '拼团开始时间',
  `stop_time` int(11) UNSIGNED NOT NULL COMMENT '拼团结束时间',
  `effective_time` int(11) NOT NULL DEFAULT 0 COMMENT '拼团订单有效时间',
  `cost` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拼图商品成本',
  `browse` int(11) NULL DEFAULT 0 COMMENT '浏览量',
  `unit_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '单位名',
  `temp_id` int(11) NULL DEFAULT NULL COMMENT '运费模板ID',
  `weight` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '重量',
  `volume` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '体积',
  `num` int(11) NULL DEFAULT NULL COMMENT '单次购买数量',
  `quota` int(10) NOT NULL DEFAULT 0 COMMENT '限购总数',
  `quota_show` int(10) NOT NULL DEFAULT 0 COMMENT '限量总数显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '拼团商品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_coupon
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_coupon`;
CREATE TABLE `eb_store_coupon`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '优惠券表ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '优惠券名称',
  `integral` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '兑换消耗积分值',
  `coupon_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '兑换的优惠券面值',
  `use_min_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '最低消费多少金额可用优惠券',
  `coupon_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '优惠券有效期限（单位：天）',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT 1 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态（0：关闭，1：开启）',
  `add_time` int(11) UNSIGNED NOT NULL COMMENT '兑换项目添加时间',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除',
  `product_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属商品id',
  `category_id` int(11) NOT NULL DEFAULT 0 COMMENT '分类id',
  `type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '优惠券类型 0-通用 1-品类券 2-商品券',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `state`(`status`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `coupon_time`(`coupon_time`) USING BTREE,
  INDEX `is_del`(`is_del`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_coupon_issue
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_coupon_issue`;
CREATE TABLE `eb_store_coupon_issue`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` int(10) NULL DEFAULT NULL COMMENT '优惠券ID',
  `start_time` int(10) NULL DEFAULT NULL COMMENT '优惠券领取开启时间',
  `end_time` int(10) NULL DEFAULT NULL COMMENT '优惠券领取结束时间',
  `total_count` int(10) NULL DEFAULT NULL COMMENT '优惠券领取数量',
  `remain_count` int(10) NULL DEFAULT NULL COMMENT '优惠券剩余领取数量',
  `is_permanent` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否无限张数',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 正常 0 未开启 -1 已无效',
  `is_give_subscribe` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否首次关注赠送 0-否(默认) 1-是',
  `is_full_give` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否满赠0-否(默认) 1-是',
  `full_reduction` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '消费满多少赠送优惠券',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `add_time` int(10) NULL DEFAULT NULL COMMENT '优惠券添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `start_time`(`start_time`, `end_time`) USING BTREE,
  INDEX `remain_count`(`remain_count`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `is_del`(`is_del`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券前台领取表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_coupon_issue_user
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_coupon_issue_user`;
CREATE TABLE `eb_store_coupon_issue_user`  (
  `uid` int(10) NULL DEFAULT NULL COMMENT '领取优惠券用户ID',
  `issue_coupon_id` int(10) NULL DEFAULT NULL COMMENT '优惠券前台领取ID',
  `add_time` int(10) NULL DEFAULT NULL COMMENT '领取时间',
  UNIQUE INDEX `uid`(`uid`, `issue_coupon_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券前台用户领取记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_coupon_user`;
CREATE TABLE `eb_store_coupon_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '优惠券发放记录id',
  `cid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '兑换的项目id',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '优惠券所属用户',
  `coupon_title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '优惠券名称',
  `coupon_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '优惠券的面值',
  `use_min_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '最低消费多少金额可用优惠券',
  `add_time` int(11) UNSIGNED NOT NULL COMMENT '优惠券创建时间',
  `end_time` int(11) UNSIGNED NOT NULL COMMENT '优惠券结束时间',
  `use_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用时间',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'send' COMMENT '获取方式',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态（0：未使用，1：已使用, 2:已过期）',
  `is_fail` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否有效',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `end_time`(`end_time`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `is_fail`(`is_fail`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券发放记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_order
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_order`;
CREATE TABLE `eb_store_order`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单号',
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `real_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户姓名',
  `user_phone` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户电话',
  `user_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细地址',
  `cart_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[]' COMMENT '购物车id',
  `freight_price` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '运费金额',
  `total_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单商品总数',
  `total_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '订单总价',
  `total_postage` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '邮费',
  `pay_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '实际支付金额',
  `pay_postage` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '支付邮费',
  `deduction_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '抵扣金额',
  `coupon_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '优惠券id',
  `coupon_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '优惠券金额',
  `paid` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付状态',
  `pay_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '支付时间',
  `pay_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '支付方式',
  `add_time` int(11) UNSIGNED NOT NULL COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '订单状态（-1 : 申请退款 -2 : 退货成功 0：待发货；1：待收货；2：已收货；3：待评价；-1：已退款）',
  `refund_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 未退款 1 申请中 2 已退款',
  `refund_reason_wap_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退款图片',
  `refund_reason_wap_explain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退款用户说明',
  `refund_reason_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '退款时间',
  `refund_reason_wap` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前台退款原因',
  `refund_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '不退款的理由',
  `refund_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '退款金额',
  `delivery_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '快递名称/送货人姓名',
  `delivery_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发货类型',
  `delivery_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '快递单号/手机号',
  `gain_integral` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '消费赚取积分',
  `use_integral` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '使用积分',
  `back_integral` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '给用户退了多少积分',
  `mark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除',
  `unique` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一id(md5加密)类似id',
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员备注',
  `mer_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户ID',
  `is_mer_check` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `combination_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '拼团商品id0一般商品',
  `pink_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拼团id 0没有拼团',
  `cost` decimal(8, 2) UNSIGNED NOT NULL COMMENT '成本价',
  `seckill_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '秒杀商品ID',
  `bargain_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '砍价id',
  `verify_code` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '核销码',
  `store_id` int(11) NOT NULL DEFAULT 0 COMMENT '门店id',
  `shipping_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '配送方式 1=快递 ，2=门店自提',
  `clerk_id` int(11) NOT NULL DEFAULT 0 COMMENT '店员id',
  `is_channel` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '支付渠道(0微信公众号1微信小程序)',
  `is_remind` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '消息提醒',
  `is_system_del` tinyint(1) NULL DEFAULT 0 COMMENT '后台是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id_2`(`order_id`, `uid`) USING BTREE,
  UNIQUE INDEX `unique`(`unique`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `pay_price`(`pay_price`) USING BTREE,
  INDEX `paid`(`paid`) USING BTREE,
  INDEX `pay_time`(`pay_time`) USING BTREE,
  INDEX `pay_type`(`pay_type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `is_del`(`is_del`) USING BTREE,
  INDEX `coupon_id`(`coupon_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_order_cart_info
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_order_cart_info`;
CREATE TABLE `eb_store_order_cart_info`  (
  `oid` int(11) UNSIGNED NOT NULL COMMENT '订单id',
  `cart_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '购物车id',
  `product_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品ID',
  `cart_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购买东西的详细信息',
  `unique` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一id',
  UNIQUE INDEX `oid`(`oid`, `unique`) USING BTREE,
  INDEX `cart_id`(`cart_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单购物详情表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_order_status
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_order_status`;
CREATE TABLE `eb_store_order_status`  (
  `oid` int(10) UNSIGNED NOT NULL COMMENT '订单id',
  `change_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作类型',
  `change_message` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作备注',
  `change_time` int(10) UNSIGNED NOT NULL COMMENT '操作时间',
  INDEX `oid`(`oid`) USING BTREE,
  INDEX `change_type`(`change_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单操作记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_pink
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_pink`;
CREATE TABLE `eb_store_pink`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id 生成',
  `order_id_key` int(10) UNSIGNED NOT NULL COMMENT '订单id  数据库',
  `total_num` int(10) UNSIGNED NOT NULL COMMENT '购买商品个数',
  `total_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '购买总金额',
  `cid` int(10) UNSIGNED NOT NULL COMMENT '拼团商品id',
  `pid` int(10) UNSIGNED NOT NULL COMMENT '商品id',
  `people` int(10) UNSIGNED NOT NULL COMMENT '拼图总人数',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '拼团商品单价',
  `add_time` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '开始时间',
  `stop_time` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `k_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '团长id 0为团长',
  `is_tpl` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否发送模板消息0未发送1已发送',
  `is_refund` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否退款 0未退款 1已退款',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态1进行中2已完成3未完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '拼团表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product`;
CREATE TABLE `eb_store_product`  (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `mer_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户Id(0为总后台管理员创建,不为0的时候是商户后台创建)',
  `image` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品图片',
  `slider_image` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '轮播图',
  `store_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `store_info` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品简介',
  `keyword` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关键字',
  `bar_code` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品条码（一维码）',
  `cate_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类id',
  `price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '商品价格',
  `vip_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '会员价格',
  `ot_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '市场价',
  `postage` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '邮费',
  `unit_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单位名',
  `sort` smallint(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `sales` mediumint(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量',
  `stock` mediumint(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '库存',
  `is_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态（0：未上架，1：上架）',
  `is_hot` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否热卖',
  `is_benefit` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否优惠',
  `is_best` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否精品',
  `is_new` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否新品',
  `add_time` int(11) UNSIGNED NOT NULL COMMENT '添加时间',
  `is_postage` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否包邮',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除',
  `mer_use` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户是否代理 0不可代理1可代理',
  `give_integral` decimal(8, 2) UNSIGNED NOT NULL COMMENT '获得积分',
  `cost` decimal(8, 2) UNSIGNED NOT NULL COMMENT '成本价',
  `is_seckill` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '秒杀状态 0 未开启 1已开启',
  `is_bargain` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '砍价状态 0未开启 1开启',
  `is_good` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否优品推荐',
  `is_sub` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否单独分佣',
  `ficti` mediumint(11) NULL DEFAULT 100 COMMENT '虚拟销量',
  `browse` int(11) NULL DEFAULT 0 COMMENT '浏览量',
  `code_path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品二维码地址(用户小程序海报)',
  `soure_link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '淘宝京东1688类型',
  `video_link` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主图视频链接',
  `temp_id` int(11) NOT NULL DEFAULT 1 COMMENT '运费模板ID',
  `spec_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '规格 0单 1多',
  `activity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '活动显示排序1=秒杀，2=砍价，3=拼团',
  `pospal_code` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '银豹系统商品编码，只用于迁移数据',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cate_id`(`cate_id`) USING BTREE,
  INDEX `is_hot`(`is_hot`) USING BTREE,
  INDEX `is_benefit`(`is_benefit`) USING BTREE,
  INDEX `is_best`(`is_best`) USING BTREE,
  INDEX `is_new`(`is_new`) USING BTREE,
  INDEX `toggle_on_sale, is_del`(`is_del`) USING BTREE,
  INDEX `price`(`price`) USING BTREE,
  INDEX `is_show`(`is_show`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE,
  INDEX `sales`(`sales`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `is_postage`(`is_postage`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_attr
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_attr`;
CREATE TABLE `eb_store_product_attr`  (
  `product_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品ID',
  `attr_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '属性名',
  `attr_values` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '属性值',
  `type` tinyint(1) NULL DEFAULT 0 COMMENT '活动类型 0=商品，1=秒杀，2=砍价，3=拼团',
  INDEX `store_id`(`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品属性表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_attr_result
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_attr_result`;
CREATE TABLE `eb_store_product_attr_result`  (
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `result` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品属性参数',
  `change_time` int(10) UNSIGNED NOT NULL COMMENT '上次修改时间',
  `type` tinyint(1) NULL DEFAULT 0 COMMENT '活动类型 0=商品，1=秒杀，2=砍价，3=拼团',
  INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品属性详情表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_attr_value
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_attr_value`;
CREATE TABLE `eb_store_product_attr_value`  (
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `suk` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品属性索引值 (attr_value|attr_value[|....])',
  `stock` int(10) UNSIGNED NOT NULL COMMENT '属性对应的库存',
  `sales` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量',
  `price` decimal(8, 2) UNSIGNED NOT NULL COMMENT '属性金额',
  `image` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `unique` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '唯一值',
  `cost` decimal(8, 2) UNSIGNED NOT NULL COMMENT '成本价',
  `bar_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品条码',
  `ot_price` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '原价',
  `weight` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '重量',
  `volume` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '体积',
  `brokerage` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '一级返佣',
  `brokerage_two` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '二级返佣',
  `type` tinyint(1) NULL DEFAULT 0 COMMENT '活动类型 0=商品，1=秒杀，2=砍价，3=拼团',
  `quota` int(11) NULL DEFAULT NULL COMMENT '活动限购数量',
  `quota_show` int(11) NULL DEFAULT NULL COMMENT '活动限购数量显示',
  INDEX `unique`(`unique`, `suk`) USING BTREE,
  INDEX `store_id`(`product_id`, `suk`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品属性值表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_cate
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_cate`;
CREATE TABLE `eb_store_product_cate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT 0 COMMENT '商品id',
  `cate_id` int(11) NOT NULL DEFAULT 0 COMMENT '分类id',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类辅助表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_description
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_description`;
CREATE TABLE `eb_store_product_description`  (
  `product_id` int(11) NOT NULL DEFAULT 0 COMMENT '商品ID',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品详情',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '商品类型',
  INDEX `product_id`(`product_id`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_relation
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_relation`;
CREATE TABLE `eb_store_product_relation`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型(收藏(collect）、点赞(like))',
  `category` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '某种类型的商品(普通商品、秒杀商品)',
  `add_time` int(10) UNSIGNED NOT NULL COMMENT '添加时间',
  UNIQUE INDEX `uid`(`uid`, `product_id`, `type`, `category`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `category`(`category`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品点赞和收藏表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_reply
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_reply`;
CREATE TABLE `eb_store_product_reply`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `oid` int(11) NOT NULL COMMENT '订单ID',
  `unique` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一id',
  `product_id` int(11) NOT NULL COMMENT '商品id',
  `reply_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'product' COMMENT '某种商品类型(普通商品、秒杀商品）',
  `product_score` tinyint(1) NOT NULL COMMENT '商品分数',
  `service_score` tinyint(1) NOT NULL COMMENT '服务分数',
  `comment` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `pics` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论图片',
  `add_time` int(11) NOT NULL COMMENT '评论时间',
  `merchant_reply_content` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员回复内容',
  `merchant_reply_time` int(11) NULL DEFAULT NULL COMMENT '管理员回复时间',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0未删除1已删除',
  `is_reply` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未回复1已回复',
  `nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户头像',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id_2`(`oid`, `unique`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `parent_id`(`reply_type`) USING BTREE,
  INDEX `is_del`(`is_del`) USING BTREE,
  INDEX `product_score`(`product_score`) USING BTREE,
  INDEX `service_score`(`service_score`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_product_rule
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_product_rule`;
CREATE TABLE `eb_store_product_rule`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `rule_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规格名称',
  `rule_value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规格值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品规则值(规格)表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_seckill
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_seckill`;
CREATE TABLE `eb_store_seckill`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品秒杀商品表id',
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品id',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '推荐图',
  `images` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '轮播图',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动标题',
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '简介',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '价格',
  `cost` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '成本',
  `ot_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '原价',
  `give_integral` decimal(10, 2) UNSIGNED NOT NULL COMMENT '返多少积分',
  `sort` int(10) UNSIGNED NOT NULL COMMENT '排序',
  `stock` int(10) UNSIGNED NOT NULL COMMENT '库存',
  `sales` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量',
  `unit_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单位名',
  `postage` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '邮费',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `start_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '开始时间',
  `stop_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '结束时间',
  `add_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '添加时间',
  `status` tinyint(1) UNSIGNED NOT NULL COMMENT '商品状态',
  `is_postage` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否包邮',
  `is_hot` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '热门推荐',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除 0未删除1已删除',
  `num` int(11) UNSIGNED NOT NULL COMMENT '最多秒杀几个',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '显示',
  `time_id` int(11) NULL DEFAULT NULL COMMENT '时间段ID',
  `temp_id` int(11) NULL DEFAULT NULL COMMENT '运费模板ID',
  `weight` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '商品重量',
  `volume` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '商品体积',
  `quota` int(10) NOT NULL DEFAULT 0 COMMENT '限购总数',
  `quota_show` int(10) NOT NULL DEFAULT 0 COMMENT '限购总数显示',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `start_time`(`start_time`, `stop_time`) USING BTREE,
  INDEX `is_del`(`is_del`) USING BTREE,
  INDEX `is_hot`(`is_hot`) USING BTREE,
  INDEX `is_show`(`status`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE,
  INDEX `is_postage`(`is_postage`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品秒杀商品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_seckill_time
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_seckill_time`;
CREATE TABLE `eb_store_seckill_time`  (
  `seckill_id` int(10) NOT NULL DEFAULT 0 COMMENT '秒杀活动ID',
  `time_id` int(10) NOT NULL DEFAULT 0 COMMENT '秒杀时间段ID'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '秒杀时段表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_service
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_service`;
CREATE TABLE `eb_store_service`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客服id',
  `mer_id` int(11) NOT NULL DEFAULT 0 COMMENT '商户id',
  `uid` int(11) NOT NULL COMMENT '客服uid',
  `avatar` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客服头像',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '代理名称',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0隐藏1显示',
  `notify` int(2) NULL DEFAULT 0 COMMENT '订单通知1开启0关闭',
  `customer` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否展示统计管理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客服表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_service_log
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_service_log`;
CREATE TABLE `eb_store_service_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客服用户对话记录表ID',
  `mer_id` int(11) NOT NULL DEFAULT 0 COMMENT '商户id',
  `msn` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息内容',
  `uid` int(11) NOT NULL COMMENT '发送人uid',
  `to_uid` int(11) NOT NULL COMMENT '接收人uid',
  `add_time` int(11) NOT NULL COMMENT '发送时间',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已读（0：否；1：是；）',
  `remind` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否提醒过',
  `msn_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '消息类型 1=文字 2=表情 3=图片 4=语音',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客服用户对话记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_store_visit
-- ----------------------------
DROP TABLE IF EXISTS `eb_store_visit`;
CREATE TABLE `eb_store_visit`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `product_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品类型',
  `cate_id` int(11) NULL DEFAULT NULL COMMENT '商品分类ID',
  `type` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品类型',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `count` int(11) NULL DEFAULT NULL COMMENT '访问次数',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注描述',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品浏览分析表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_system_admin
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_admin`;
CREATE TABLE `eb_system_admin`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '后台管理员表ID',
  `account` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '后台管理员账号',
  `pwd` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '后台管理员密码',
  `real_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '后台管理员姓名',
  `roles` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '后台管理员权限(menus_id)',
  `last_ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '后台管理员最后一次登录ip',
  `last_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '后台管理员最后一次登录时间',
  `add_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '后台管理员添加时间',
  `login_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录次数',
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '后台管理员级别',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '后台管理员状态 1有效0无效',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account`(`account`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台管理员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_admin
-- ----------------------------
INSERT INTO `eb_system_admin` VALUES (1, 'crmeb', '16981f77ceafea1b594cb592f7327d53', 'admin', '1', '119.33.194.224', 1587939104, 1587733813, 0, 0, 1, 0);

-- ----------------------------
-- Table structure for eb_system_attachment
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_attachment`;
CREATE TABLE `eb_system_attachment`  (
  `att_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件名称',
  `att_dir` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件路径',
  `satt_dir` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '压缩图片路径',
  `att_size` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件大小',
  `att_type` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件类型',
  `pid` int(10) NOT NULL DEFAULT 0 COMMENT '分类ID0编辑器,1商品图片,2拼团图片,3砍价图片,4秒杀图片,5文章图片,6组合数据图',
  `time` int(11) NOT NULL DEFAULT 0 COMMENT '上传时间',
  `image_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '图片上传类型 1本地 2七牛云 3OSS 4COS ',
  `module_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '图片上传模块类型 1 后台上传 2 用户生成',
  PRIMARY KEY (`att_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件管理表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_attachment
-- ----------------------------
INSERT INTO `eb_system_attachment` VALUES (17, '21bed202004250044441257.png', 'https://oss.foodtrust.cn//21bed202004250044441257.png', 'https://oss.foodtrust.cn//21bed202004250044441257.png', '0', 'image/jpeg', 3, 1587746684, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (18, '5c6cf202004250051322208.png', 'https://oss.foodtrust.cn//5c6cf202004250051322208.png', 'https://oss.foodtrust.cn//5c6cf202004250051322208.png', '0', 'image/jpeg', 3, 1587747092, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (19, 'd7e2d202004250057222459.jpg', 'https://oss.foodtrust.cn//d7e2d202004250057222459.jpg', 'https://oss.foodtrust.cn//d7e2d202004250057222459.jpg', '0', 'image/jpeg', 5, 1587747442, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (20, '859a4202004250121543840.jpg', 'https://oss.foodtrust.cn//859a4202004250121543840.jpg', 'https://oss.foodtrust.cn//859a4202004250121543840.jpg', '0', 'image/jpeg', 6, 1587748914, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (22, '9c9c2202004250136523040.png', 'https://oss.foodtrust.cn//9c9c2202004250136523040.png', 'https://oss.foodtrust.cn//9c9c2202004250136523040.png', '0', 'image/jpeg', 8, 1587749812, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (23, 'bb182202004250209263716.jpg', 'https://oss.foodtrust.cn//bb182202004250209263716.jpg', 'https://oss.foodtrust.cn//bb182202004250209263716.jpg', '0', 'image/jpeg', 6, 1587751766, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (24, '7739c202004250337006643.jpg', 'https://oss.foodtrust.cn//7739c202004250337006643.jpg', 'https://oss.foodtrust.cn//7739c202004250337006643.jpg', '0', 'image/jpeg', 11, 1587757020, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (25, '8322720200425033706535.jpg', 'https://oss.foodtrust.cn//8322720200425033706535.jpg', 'https://oss.foodtrust.cn//8322720200425033706535.jpg', '0', 'image/jpeg', 11, 1587757026, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (35, '0c4ec202004250358016966.gif', 'https://oss.foodtrust.cn//0c4ec202004250358016966.gif', 'https://oss.foodtrust.cn//0c4ec202004250358016966.gif', '0', 'image/jpeg', 13, 1587758281, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (36, '14532202004250359139546.gif', 'https://oss.foodtrust.cn//14532202004250359139546.gif', 'https://oss.foodtrust.cn//14532202004250359139546.gif', '0', 'image/jpeg', 13, 1587758353, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (37, 'dddf6202004250401001173.png', 'https://oss.foodtrust.cn//dddf6202004250401001173.png', 'https://oss.foodtrust.cn//dddf6202004250401001173.png', '0', 'image/jpeg', 13, 1587758460, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (38, 'c45ac202004250404047597.gif', 'https://oss.foodtrust.cn//c45ac202004250404047597.gif', 'https://oss.foodtrust.cn//c45ac202004250404047597.gif', '0', 'image/jpeg', 13, 1587758644, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (39, '7ec90202004250404568624.gif', 'https://oss.foodtrust.cn//7ec90202004250404568624.gif', 'https://oss.foodtrust.cn//7ec90202004250404568624.gif', '0', 'image/jpeg', 13, 1587758696, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (40, '49597202004250405242603.gif', 'https://oss.foodtrust.cn//49597202004250405242603.gif', 'https://oss.foodtrust.cn//49597202004250405242603.gif', '0', 'image/jpeg', 13, 1587758725, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (41, '39b93202004250406089120.gif', 'https://oss.foodtrust.cn//39b93202004250406089120.gif', 'https://oss.foodtrust.cn//39b93202004250406089120.gif', '0', 'image/jpeg', 13, 1587758768, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (42, 'c6ffb202004250406587394.png', 'https://oss.foodtrust.cn//c6ffb202004250406587394.png', 'https://oss.foodtrust.cn//c6ffb202004250406587394.png', '0', 'image/jpeg', 13, 1587758818, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (43, '27e5f202004250415175691.gif', 'https://oss.foodtrust.cn//27e5f202004250415175691.gif', 'https://oss.foodtrust.cn//27e5f202004250415175691.gif', '0', 'image/jpeg', 13, 1587759317, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (44, '6f97f202004250415171693.gif', 'https://oss.foodtrust.cn//6f97f202004250415171693.gif', 'https://oss.foodtrust.cn//6f97f202004250415171693.gif', '0', 'image/jpeg', 13, 1587759317, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (45, '18665202004250415176069.gif', 'https://oss.foodtrust.cn//18665202004250415176069.gif', 'https://oss.foodtrust.cn//18665202004250415176069.gif', '0', 'image/jpeg', 13, 1587759317, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (46, 'c67b3202004250415173509.gif', 'https://oss.foodtrust.cn//c67b3202004250415173509.gif', 'https://oss.foodtrust.cn//c67b3202004250415173509.gif', '0', 'image/jpeg', 13, 1587759317, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (47, 'e1017202004250415175972.gif', 'https://oss.foodtrust.cn//e1017202004250415175972.gif', 'https://oss.foodtrust.cn//e1017202004250415175972.gif', '0', 'image/jpeg', 13, 1587759317, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (48, '6db83202004250915485157.jpg', 'https://oss.foodtrust.cn//6db83202004250915485157.jpg', 'https://oss.foodtrust.cn//6db83202004250915485157.jpg', '0', 'image/jpeg', 11, 1587777348, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (50, 'f656b202004250919289976.jpg', 'https://oss.foodtrust.cn//f656b202004250919289976.jpg', 'https://oss.foodtrust.cn//f656b202004250919289976.jpg', '0', 'image/jpeg', 11, 1587777568, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (52, '98517202004250933362595.jpg', 'https://oss.foodtrust.cn//98517202004250933362595.jpg', 'https://oss.foodtrust.cn//98517202004250933362595.jpg', '0', 'image/jpeg', 5, 1587778416, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (54, 'd13cb202004250935335429.jpg', 'https://oss.foodtrust.cn//d13cb202004250935335429.jpg', 'https://oss.foodtrust.cn//d13cb202004250935335429.jpg', '0', 'image/jpeg', 5, 1587778533, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (55, '8240d202004250940439202.jpg', 'https://oss.foodtrust.cn//8240d202004250940439202.jpg', 'https://oss.foodtrust.cn//8240d202004250940439202.jpg', '0', 'image/jpeg', 5, 1587778843, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (56, '7e77e202004250940496399.jpg', 'https://oss.foodtrust.cn//7e77e202004250940496399.jpg', 'https://oss.foodtrust.cn//7e77e202004250940496399.jpg', '0', 'image/jpeg', 5, 1587778849, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (57, '09ee3202004250940532165.jpg', 'https://oss.foodtrust.cn//09ee3202004250940532165.jpg', 'https://oss.foodtrust.cn//09ee3202004250940532165.jpg', '0', 'image/jpeg', 5, 1587778853, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (58, 'd484d202004250954246867.jpg', 'https://oss.foodtrust.cn//d484d202004250954246867.jpg', 'https://oss.foodtrust.cn//d484d202004250954246867.jpg', '0', 'image/jpeg', 5, 1587779664, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (59, '372ad202004251014538878.jpg', 'https://oss.foodtrust.cn//372ad202004251014538878.jpg', 'https://oss.foodtrust.cn//372ad202004251014538878.jpg', '0', 'image/jpeg', 5, 1587780893, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (60, '3237e202004251037002506.png', 'https://oss.foodtrust.cn//3237e202004251037002506.png', 'https://oss.foodtrust.cn//3237e202004251037002506.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (61, '860b7202004251037007355.png', 'https://oss.foodtrust.cn//860b7202004251037007355.png', 'https://oss.foodtrust.cn//860b7202004251037007355.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (62, 'e15f0202004251037005731.png', 'https://oss.foodtrust.cn//e15f0202004251037005731.png', 'https://oss.foodtrust.cn//e15f0202004251037005731.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (63, '11dff202004251037008622.png', 'https://oss.foodtrust.cn//11dff202004251037008622.png', 'https://oss.foodtrust.cn//11dff202004251037008622.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (64, 'a0ec4202004251037003274.png', 'https://oss.foodtrust.cn//a0ec4202004251037003274.png', 'https://oss.foodtrust.cn//a0ec4202004251037003274.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (65, 'bc94a202004251037003016.png', 'https://oss.foodtrust.cn//bc94a202004251037003016.png', 'https://oss.foodtrust.cn//bc94a202004251037003016.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (66, '4f2ae202004251037016803.png', 'https://oss.foodtrust.cn//4f2ae202004251037016803.png', 'https://oss.foodtrust.cn//4f2ae202004251037016803.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (67, 'bf573202004251037007349.png', 'https://oss.foodtrust.cn//bf573202004251037007349.png', 'https://oss.foodtrust.cn//bf573202004251037007349.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (68, '398dd202004251037001150.png', 'https://oss.foodtrust.cn//398dd202004251037001150.png', 'https://oss.foodtrust.cn//398dd202004251037001150.png', '0', 'image/jpeg', 16, 1587782221, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (70, 'de625202004251154513069.png', 'https://oss.foodtrust.cn//de625202004251154513069.png', 'https://oss.foodtrust.cn//de625202004251154513069.png', '0', 'image/jpeg', 16, 1587786891, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (71, '06322202004252022151781.png', 'https://oss.foodtrust.cn//06322202004252022151781.png', 'https://oss.foodtrust.cn//06322202004252022151781.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (72, '653ea202004252022154125.png', 'https://oss.foodtrust.cn//653ea202004252022154125.png', 'https://oss.foodtrust.cn//653ea202004252022154125.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (73, 'b1a09202004252022154002.png', 'https://oss.foodtrust.cn//b1a09202004252022154002.png', 'https://oss.foodtrust.cn//b1a09202004252022154002.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (74, 'dee6c202004252022156432.png', 'https://oss.foodtrust.cn//dee6c202004252022156432.png', 'https://oss.foodtrust.cn//dee6c202004252022156432.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (75, '03634202004252022151171.png', 'https://oss.foodtrust.cn//03634202004252022151171.png', 'https://oss.foodtrust.cn//03634202004252022151171.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (76, '89131202004252022154902.png', 'https://oss.foodtrust.cn//89131202004252022154902.png', 'https://oss.foodtrust.cn//89131202004252022154902.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (77, '24282202004252022154243.png', 'https://oss.foodtrust.cn//24282202004252022154243.png', 'https://oss.foodtrust.cn//24282202004252022154243.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (78, '668b4202004252022156019.png', 'https://oss.foodtrust.cn//668b4202004252022156019.png', 'https://oss.foodtrust.cn//668b4202004252022156019.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (79, 'e0792202004252022151244.png', 'https://oss.foodtrust.cn//e0792202004252022151244.png', 'https://oss.foodtrust.cn//e0792202004252022151244.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (80, 'd9975202004252022152724.png', 'https://oss.foodtrust.cn//d9975202004252022152724.png', 'https://oss.foodtrust.cn//d9975202004252022152724.png', '0', 'image/jpeg', 17, 1587817335, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (81, 'ff943202004260851033674.png', 'https://oss.foodtrust.cn//ff943202004260851033674.png', 'https://oss.foodtrust.cn//ff943202004260851033674.png', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (82, '6c351202004260851036868.png', 'https://oss.foodtrust.cn//6c351202004260851036868.png', 'https://oss.foodtrust.cn//6c351202004260851036868.png', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (83, '13487202004260851032870.png', 'https://oss.foodtrust.cn//13487202004260851032870.png', 'https://oss.foodtrust.cn//13487202004260851032870.png', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (84, '20e46202004260851037850.jpg', 'https://oss.foodtrust.cn//20e46202004260851037850.jpg', 'https://oss.foodtrust.cn//20e46202004260851037850.jpg', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (85, 'a25b4202004260851031057.jpg', 'https://oss.foodtrust.cn//a25b4202004260851031057.jpg', 'https://oss.foodtrust.cn//a25b4202004260851031057.jpg', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (86, '849ba202004260851036015.jpg', 'https://oss.foodtrust.cn//849ba202004260851036015.jpg', 'https://oss.foodtrust.cn//849ba202004260851036015.jpg', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (87, '01d2620200426085103895.png', 'https://oss.foodtrust.cn//01d2620200426085103895.png', 'https://oss.foodtrust.cn//01d2620200426085103895.png', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (88, 'd234e202004260851033806.jpg', 'https://oss.foodtrust.cn//d234e202004260851033806.jpg', 'https://oss.foodtrust.cn//d234e202004260851033806.jpg', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (89, '90a66202004260851036750.jpg', 'https://oss.foodtrust.cn//90a66202004260851036750.jpg', 'https://oss.foodtrust.cn//90a66202004260851036750.jpg', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (90, '2b9d7202004260851033406.png', 'https://oss.foodtrust.cn//2b9d7202004260851033406.png', 'https://oss.foodtrust.cn//2b9d7202004260851033406.png', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (91, '37646202004260851038520.jpg', 'https://oss.foodtrust.cn//37646202004260851038520.jpg', 'https://oss.foodtrust.cn//37646202004260851038520.jpg', '0', 'image/jpeg', 18, 1587862263, 3, 1);
INSERT INTO `eb_system_attachment` VALUES (92, '4f09a20200426085103126.png', 'https://oss.foodtrust.cn//4f09a20200426085103126.png', 'https://oss.foodtrust.cn//4f09a20200426085103126.png', '0', 'image/jpeg', 18, 1587862263, 3, 1);

-- ----------------------------
-- Table structure for eb_system_attachment_category
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_attachment_category`;
CREATE TABLE `eb_system_attachment_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT 0 COMMENT '父级ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `enname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类目录',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_attachment_category
-- ----------------------------
INSERT INTO `eb_system_attachment_category` VALUES (1, 0, '前端页面', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (2, 0, '后端页面', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (3, 0, '品牌标识', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (5, 1, '页面装饰', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (6, 0, '微信专用', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (8, 1, '人物形象', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (9, 0, '专题活动', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (10, 0, '商品专用', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (11, 1, '商店版头', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (13, 1, '生鲜模版', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (16, 1, '分类图标', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (17, 1, '个人中心', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (18, 1, '会员等级', NULL);
INSERT INTO `eb_system_attachment_category` VALUES (19, 0, '远程下载', '');

-- ----------------------------
-- Table structure for eb_system_city
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_city`;
CREATE TABLE `eb_system_city`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL DEFAULT 0 COMMENT '城市id',
  `level` int(11) NOT NULL DEFAULT 0 COMMENT '省市级别',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父级id',
  `area_code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '区号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `merger_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合并名称',
  `lng` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '经度',
  `lat` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '纬度',
  `is_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否展示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3971 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '城市表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_city
-- ----------------------------
INSERT INTO `eb_system_city` VALUES (1, 1, 0, 0, '110000000000', '北京市', '北京', '116.407526', '39.904030', 1);
INSERT INTO `eb_system_city` VALUES (2, 7362, 0, 0, '120000000000', '天津市', '天津', '117.200983', '39.084158', 1);
INSERT INTO `eb_system_city` VALUES (3, 13267, 0, 0, '130000000000', '河北省', '河北', '114.468664', '38.037057', 1);
INSERT INTO `eb_system_city` VALUES (4, 67747, 0, 0, '140000000000', '山西省', '山西', '112.562398', '37.873531', 1);
INSERT INTO `eb_system_city` VALUES (5, 99537, 0, 0, '150000000000', '内蒙古自治区', '内蒙古', '111.765617', '40.817498', 1);
INSERT INTO `eb_system_city` VALUES (6, 115224, 0, 0, '210000000000', '辽宁省', '辽宁', '123.429440', '41.835441', 1);
INSERT INTO `eb_system_city` VALUES (7, 133208, 0, 0, '220000000000', '吉林省', '吉林', '125.325990', '43.896536', 1);
INSERT INTO `eb_system_city` VALUES (8, 145665, 0, 0, '230000000000', '黑龙江省', '黑龙江', '126.661669', '45.742347', 1);
INSERT INTO `eb_system_city` VALUES (9, 161792, 0, 0, '310000000000', '上海市', '上海', '121.473701', '31.230416', 1);
INSERT INTO `eb_system_city` VALUES (10, 167904, 0, 0, '320000000000', '江苏省', '江苏', '118.763232', '32.061707', 1);
INSERT INTO `eb_system_city` VALUES (11, 191019, 0, 0, '330000000000', '浙江省', '浙江', '120.152791', '30.267446', 1);
INSERT INTO `eb_system_city` VALUES (12, 224649, 0, 0, '340000000000', '安徽省', '安徽', '117.284922', '31.861184', 1);
INSERT INTO `eb_system_city` VALUES (13, 244377, 0, 0, '350000000000', '福建省', '福建', '119.295144', '26.100779', 1);
INSERT INTO `eb_system_city` VALUES (14, 262698, 0, 0, '360000000000', '江西省', '江西', '115.909228', '28.675696', 1);
INSERT INTO `eb_system_city` VALUES (15, 285860, 0, 0, '370000000000', '山东省', '山东', '117.020359', '36.668530', 1);
INSERT INTO `eb_system_city` VALUES (16, 367395, 0, 0, '410000000000', '河南省', '河南', '113.753602', '34.765515', 1);
INSERT INTO `eb_system_city` VALUES (17, 420824, 0, 0, '420000000000', '湖北省', '湖北', '114.341861', '30.546498', 1);
INSERT INTO `eb_system_city` VALUES (18, 452123, 0, 0, '430000000000', '湖南省', '湖南', '112.983810', '28.112444', 1);
INSERT INTO `eb_system_city` VALUES (19, 483250, 0, 0, '440000000000', '广东省', '广东', '113.266530', '23.132191', 1);
INSERT INTO `eb_system_city` VALUES (20, 511462, 0, 0, '450000000000', '广西壮族自治区', '广西', '108.327546', '22.815478', 1);
INSERT INTO `eb_system_city` VALUES (21, 529344, 0, 0, '460000000000', '海南省', '海南', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (22, 533328, 0, 0, '500000000000', '重庆市', '重庆', '106.551556', '29.563009', 1);
INSERT INTO `eb_system_city` VALUES (23, 545532, 0, 0, '510000000000', '四川省', '四川', '104.075931', '30.651651', 1);
INSERT INTO `eb_system_city` VALUES (24, 604131, 0, 0, '520000000000', '贵州省', '贵州', '106.707410', '26.598194', 1);
INSERT INTO `eb_system_city` VALUES (25, 624372, 0, 0, '530000000000', '云南省', '云南', '102.710002', '25.045806', 1);
INSERT INTO `eb_system_city` VALUES (26, 640332, 0, 0, '540000000000', '西藏自治区', '西藏', '91.117212', '29.646922', 1);
INSERT INTO `eb_system_city` VALUES (27, 646578, 0, 0, '610000000000', '陕西省', '陕西', '108.954239', '34.265472', 1);
INSERT INTO `eb_system_city` VALUES (28, 671119, 0, 0, '620000000000', '甘肃省', '甘肃', '103.826308', '36.059421', 1);
INSERT INTO `eb_system_city` VALUES (29, 690094, 0, 0, '630000000000', '青海省', '青海', '101.780199', '36.620901', 1);
INSERT INTO `eb_system_city` VALUES (30, 695259, 0, 0, '640000000000', '宁夏回族自治区', '宁夏', '106.258754', '38.471317', 1);
INSERT INTO `eb_system_city` VALUES (31, 698440, 0, 0, '650000000000', '新疆维吾尔自治区', '新疆', '87.627704', '43.793026', 1);
INSERT INTO `eb_system_city` VALUES (32, 714368, 0, 0, '0', '香港特别行政区', '香港', '114.173355', '22.320048', 1);
INSERT INTO `eb_system_city` VALUES (33, 714390, 0, 0, '0', '澳门特别行政区', '澳门', '113.549090', '22.198951', 1);
INSERT INTO `eb_system_city` VALUES (34, 714401, 0, 0, '0', '台湾', '台湾', '121.509062', '25.044332', 1);
INSERT INTO `eb_system_city` VALUES (35, 2, 1, 1, '110100000000', '北京市', '北京', '116.407526', '39.904030', 1);
INSERT INTO `eb_system_city` VALUES (36, 7363, 1, 7362, '120100000000', '天津市', '天津', '117.200983', '39.084158', 1);
INSERT INTO `eb_system_city` VALUES (37, 13268, 1, 13267, '130100000000', '石家庄市', '河北,石家庄', '114.514859', '38.042306', 1);
INSERT INTO `eb_system_city` VALUES (38, 18128, 1, 13267, '130200000000', '唐山市', '河北,唐山', '118.180193', '39.630867', 1);
INSERT INTO `eb_system_city` VALUES (39, 24371, 1, 13267, '130300000000', '秦皇岛市', '河北,秦皇岛', '119.600492', '39.935385', 1);
INSERT INTO `eb_system_city` VALUES (40, 26779, 1, 13267, '130400000000', '邯郸市', '河北,邯郸', '114.538961', '36.625657', 1);
INSERT INTO `eb_system_city` VALUES (41, 32688, 1, 13267, '130500000000', '邢台市', '河北,邢台', '114.504844', '37.070589', 1);
INSERT INTO `eb_system_city` VALUES (42, 38160, 1, 13267, '130600000000', '保定市', '河北,保定', '115.464806', '38.873891', 1);
INSERT INTO `eb_system_city` VALUES (43, 44570, 1, 13267, '130700000000', '张家口市', '河北,张家口', '114.887543', '40.824418', 1);
INSERT INTO `eb_system_city` VALUES (44, 49190, 1, 13267, '130800000000', '承德市', '河北,承德', '117.962410', '40.954071', 1);
INSERT INTO `eb_system_city` VALUES (45, 52018, 1, 13267, '130900000000', '沧州市', '河北,沧州', '116.838834', '38.304477', 1);
INSERT INTO `eb_system_city` VALUES (46, 58247, 1, 13267, '131000000000', '廊坊市', '河北,廊坊', '116.683752', '39.538047', 1);
INSERT INTO `eb_system_city` VALUES (47, 61804, 1, 13267, '131100000000', '衡水市', '河北,衡水', '115.670177', '37.738920', 1);
INSERT INTO `eb_system_city` VALUES (48, 66813, 1, 13267, '139000000000', '直辖县', '河北', '114.468664', '38.037057', 1);
INSERT INTO `eb_system_city` VALUES (49, 67748, 1, 67747, '140100000000', '太原市', '山西,太原', '112.548879', '37.870590', 1);
INSERT INTO `eb_system_city` VALUES (50, 69390, 1, 67747, '140200000000', '大同市', '山西,大同', '113.612440', '40.040295', 1);
INSERT INTO `eb_system_city` VALUES (51, 71850, 1, 67747, '140300000000', '阳泉市', '山西,阳泉', '113.580519', '37.856971', 1);
INSERT INTO `eb_system_city` VALUES (52, 72975, 1, 67747, '140400000000', '长治市', '山西,长治', '113.116255', '36.195386', 1);
INSERT INTO `eb_system_city` VALUES (53, 76726, 1, 67747, '140500000000', '晋城市', '山西,晋城', '112.851831', '35.490701', 1);
INSERT INTO `eb_system_city` VALUES (54, 79163, 1, 67747, '140600000000', '朔州市', '山西,朔州', '112.432825', '39.331595', 1);
INSERT INTO `eb_system_city` VALUES (55, 81000, 1, 67747, '140700000000', '晋中市', '山西,晋中', '112.752694', '37.687024', 1);
INSERT INTO `eb_system_city` VALUES (56, 84092, 1, 67747, '140800000000', '运城市', '山西,运城', '111.007528', '35.026412', 1);
INSERT INTO `eb_system_city` VALUES (57, 87613, 1, 67747, '140900000000', '忻州市', '山西,忻州', '112.734174', '38.416663', 1);
INSERT INTO `eb_system_city` VALUES (58, 92738, 1, 67747, '141000000000', '临汾市', '山西,临汾', '111.518976', '36.088005', 1);
INSERT INTO `eb_system_city` VALUES (59, 96064, 1, 67747, '141100000000', '吕梁市', '山西,吕梁', '111.144319', '37.518314', 1);
INSERT INTO `eb_system_city` VALUES (60, 99538, 1, 99537, '150100000000', '呼和浩特市', '内蒙古,呼和浩特', '111.749180', '40.842585', 1);
INSERT INTO `eb_system_city` VALUES (61, 100904, 1, 99537, '150200000000', '包头市', '内蒙古,包头', '109.840347', '40.657449', 1);
INSERT INTO `eb_system_city` VALUES (62, 101772, 1, 99537, '150300000000', '乌海市', '内蒙古,乌海', '106.794249', '39.655388', 1);
INSERT INTO `eb_system_city` VALUES (63, 101884, 1, 99537, '150400000000', '赤峰市', '内蒙古,赤峰', '118.886856', '42.257817', 1);
INSERT INTO `eb_system_city` VALUES (64, 104457, 1, 99537, '150500000000', '通辽市', '内蒙古,通辽', '122.243444', '43.652890', 1);
INSERT INTO `eb_system_city` VALUES (65, 107065, 1, 99537, '150600000000', '鄂尔多斯市', '内蒙古,鄂尔多斯', '109.781327', '39.608266', 1);
INSERT INTO `eb_system_city` VALUES (66, 108166, 1, 99537, '150700000000', '呼伦贝尔市', '内蒙古,呼伦贝尔', '119.765744', '49.211574', 1);
INSERT INTO `eb_system_city` VALUES (67, 109847, 1, 99537, '150800000000', '巴彦淖尔市', '内蒙古,巴彦淖尔', '107.387657', '40.743213', 1);
INSERT INTO `eb_system_city` VALUES (68, 110889, 1, 99537, '150900000000', '乌兰察布市', '内蒙古,乌兰察布', '113.132585', '40.994785', 1);
INSERT INTO `eb_system_city` VALUES (69, 112552, 1, 99537, '152200000000', '兴安盟', '内蒙古,兴安', '122.067042', '46.077561', 1);
INSERT INTO `eb_system_city` VALUES (70, 113777, 1, 99537, '152500000000', '锡林郭勒盟', '内蒙古,锡林郭勒', '116.048222', '43.933454', 1);
INSERT INTO `eb_system_city` VALUES (71, 114940, 1, 99537, '152900000000', '阿拉善盟', '内蒙古,阿拉善', '105.728969', '38.851892', 1);
INSERT INTO `eb_system_city` VALUES (72, 115225, 1, 115224, '210100000000', '沈阳市', '辽宁,沈阳', '123.431474', '41.805698', 1);
INSERT INTO `eb_system_city` VALUES (73, 117932, 1, 115224, '210200000000', '大连市', '辽宁,大连', '121.614682', '38.914003', 1);
INSERT INTO `eb_system_city` VALUES (74, 119789, 1, 115224, '210300000000', '鞍山市', '辽宁,鞍山', '122.994329', '41.108647', 1);
INSERT INTO `eb_system_city` VALUES (75, 121081, 1, 115224, '210400000000', '抚顺市', '辽宁,抚顺', '123.957208', '41.880872', 1);
INSERT INTO `eb_system_city` VALUES (76, 122142, 1, 115224, '210500000000', '本溪市', '辽宁,本溪', '123.766485', '41.294175', 1);
INSERT INTO `eb_system_city` VALUES (77, 122730, 1, 115224, '210600000000', '丹东市', '辽宁,丹东', '124.354706', '40.000499', 1);
INSERT INTO `eb_system_city` VALUES (78, 123698, 1, 115224, '210700000000', '锦州市', '辽宁,锦州', '121.127003', '41.095119', 1);
INSERT INTO `eb_system_city` VALUES (79, 125249, 1, 115224, '210800000000', '营口市', '辽宁,营口', '122.235417', '40.667012', 1);
INSERT INTO `eb_system_city` VALUES (80, 126156, 1, 115224, '210900000000', '阜新市', '辽宁,阜新', '121.670323', '42.021619', 1);
INSERT INTO `eb_system_city` VALUES (81, 127070, 1, 115224, '211000000000', '辽阳市', '辽宁,辽阳', '123.236944', '41.267244', 1);
INSERT INTO `eb_system_city` VALUES (82, 127834, 1, 115224, '211100000000', '盘锦市', '辽宁,盘锦', '122.070714', '41.119997', 1);
INSERT INTO `eb_system_city` VALUES (83, 128421, 1, 115224, '211200000000', '铁岭市', '辽宁,铁岭', '123.726166', '42.223769', 1);
INSERT INTO `eb_system_city` VALUES (84, 129977, 1, 115224, '211300000000', '朝阳市', '辽宁,朝阳', '120.389862', '41.497767', 1);
INSERT INTO `eb_system_city` VALUES (85, 131738, 1, 115224, '211400000000', '葫芦岛市', '辽宁,葫芦岛', '120.836932', '40.711052', 1);
INSERT INTO `eb_system_city` VALUES (86, 133209, 1, 133208, '220100000000', '长春市', '吉林,长春', '125.323544', '43.817071', 1);
INSERT INTO `eb_system_city` VALUES (87, 135392, 1, 133208, '220200000000', '吉林市', '吉林,吉林', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (88, 137206, 1, 133208, '220300000000', '四平市', '吉林,四平', '124.350398', '43.166419', 1);
INSERT INTO `eb_system_city` VALUES (89, 138721, 1, 133208, '220400000000', '辽源市', '吉林,辽源', '125.143532', '42.887918', 1);
INSERT INTO `eb_system_city` VALUES (90, 139340, 1, 133208, '220500000000', '通化市', '吉林,通化', '125.939697', '41.728401', 1);
INSERT INTO `eb_system_city` VALUES (91, 140601, 1, 133208, '220600000000', '白山市', '吉林,白山', '126.423587', '41.939994', 1);
INSERT INTO `eb_system_city` VALUES (92, 141361, 1, 133208, '220700000000', '松原市', '吉林,松原', '124.825117', '45.141789', 1);
INSERT INTO `eb_system_city` VALUES (93, 142786, 1, 133208, '220800000000', '白城市', '吉林,白城', '122.839024', '45.619641', 1);
INSERT INTO `eb_system_city` VALUES (94, 143990, 1, 133208, '222400000000', '延边朝鲜族自治州', '吉林,延边', '129.508946', '42.891253', 1);
INSERT INTO `eb_system_city` VALUES (95, 145666, 1, 145665, '230100000000', '哈尔滨市', '黑龙江,哈尔滨', '126.534967', '45.803775', 1);
INSERT INTO `eb_system_city` VALUES (96, 149079, 1, 145665, '230200000000', '齐齐哈尔市', '黑龙江,齐齐哈尔', '123.918186', '47.354348', 1);
INSERT INTO `eb_system_city` VALUES (97, 150915, 1, 145665, '230300000000', '鸡西市', '黑龙江,鸡西', '130.969333', '45.295075', 1);
INSERT INTO `eb_system_city` VALUES (98, 151830, 1, 145665, '230400000000', '鹤岗市', '黑龙江,鹤岗', '130.297964', '47.349916', 1);
INSERT INTO `eb_system_city` VALUES (99, 152413, 1, 145665, '230500000000', '双鸭山市', '黑龙江,双鸭山', '131.159133', '46.646508', 1);
INSERT INTO `eb_system_city` VALUES (100, 153313, 1, 145665, '230600000000', '大庆市', '黑龙江,大庆', '125.103784', '46.589309', 1);
INSERT INTO `eb_system_city` VALUES (101, 154201, 1, 145665, '230700000000', '伊春市', '黑龙江,伊春', '128.841147', '47.727536', 1);
INSERT INTO `eb_system_city` VALUES (102, 155076, 1, 145665, '230800000000', '佳木斯市', '黑龙江,佳木斯', '130.318917', '46.799922', 1);
INSERT INTO `eb_system_city` VALUES (103, 156713, 1, 145665, '230900000000', '七台河市', '黑龙江,七台河', '131.003138', '45.771726', 1);
INSERT INTO `eb_system_city` VALUES (104, 157130, 1, 145665, '231000000000', '牡丹江市', '黑龙江,牡丹江', '129.633168', '44.551653', 1);
INSERT INTO `eb_system_city` VALUES (105, 158623, 1, 145665, '231100000000', '黑河市', '黑龙江,黑河', '127.528560', '50.245329', 1);
INSERT INTO `eb_system_city` VALUES (106, 159769, 1, 145665, '231200000000', '绥化市', '黑龙江,绥化', '126.968887', '46.653845', 1);
INSERT INTO `eb_system_city` VALUES (107, 161651, 1, 145665, '232700000000', '大兴安岭地区', '黑龙江,大兴安岭', '124.711080', '52.335206', 1);
INSERT INTO `eb_system_city` VALUES (108, 161793, 1, 161792, '310100000000', '上海市', '上海', '121.473701', '31.230416', 1);
INSERT INTO `eb_system_city` VALUES (109, 167905, 1, 167904, '320100000000', '南京市', '江苏,南京', '118.796877', '32.060255', 1);
INSERT INTO `eb_system_city` VALUES (110, 169375, 1, 167904, '320200000000', '无锡市', '江苏,无锡', '120.311910', '31.491169', 1);
INSERT INTO `eb_system_city` VALUES (111, 170724, 1, 167904, '320300000000', '徐州市', '江苏,徐州', '117.284124', '34.205768', 1);
INSERT INTO `eb_system_city` VALUES (112, 173635, 1, 167904, '320400000000', '常州市', '江苏,常州', '119.973987', '31.810689', 1);
INSERT INTO `eb_system_city` VALUES (113, 174764, 1, 167904, '320500000000', '苏州市', '江苏,苏州', '120.585315', '31.298886', 1);
INSERT INTO `eb_system_city` VALUES (114, 176920, 1, 167904, '320600000000', '南通市', '江苏,南通', '120.894291', '31.980171', 1);
INSERT INTO `eb_system_city` VALUES (115, 178999, 1, 167904, '320700000000', '连云港市', '江苏,连云港', '119.221611', '34.596653', 1);
INSERT INTO `eb_system_city` VALUES (116, 180743, 1, 167904, '320800000000', '淮安市', '江苏,淮安', '119.015285', '33.610353', 1);
INSERT INTO `eb_system_city` VALUES (117, 182538, 1, 167904, '320900000000', '盐城市', '江苏,盐城', '120.163561', '33.347382', 1);
INSERT INTO `eb_system_city` VALUES (118, 185201, 1, 167904, '321000000000', '扬州市', '江苏,扬州', '119.412966', '32.394210', 1);
INSERT INTO `eb_system_city` VALUES (119, 186657, 1, 167904, '321100000000', '镇江市', '江苏,镇江', '119.425836', '32.187849', 1);
INSERT INTO `eb_system_city` VALUES (120, 187441, 1, 167904, '321200000000', '泰州市', '江苏,泰州', '119.923116', '32.455778', 1);
INSERT INTO `eb_system_city` VALUES (121, 189402, 1, 167904, '321300000000', '宿迁市', '江苏,宿迁', '118.275198', '33.963232', 1);
INSERT INTO `eb_system_city` VALUES (122, 191020, 1, 191019, '330100000000', '杭州市', '浙江,杭州', '120.155070', '30.274084', 1);
INSERT INTO `eb_system_city` VALUES (123, 194395, 1, 191019, '330200000000', '宁波市', '浙江,宁波', '121.550357', '29.874556', 1);
INSERT INTO `eb_system_city` VALUES (124, 197850, 1, 191019, '330300000000', '温州市', '浙江,温州', '120.699366', '27.994267', 1);
INSERT INTO `eb_system_city` VALUES (125, 203852, 1, 191019, '330400000000', '嘉兴市', '浙江,嘉兴', '120.755486', '30.746129', 1);
INSERT INTO `eb_system_city` VALUES (126, 205101, 1, 191019, '330500000000', '湖州市', '浙江,湖州', '120.086823', '30.894348', 1);
INSERT INTO `eb_system_city` VALUES (127, 206438, 1, 191019, '330600000000', '绍兴市', '浙江,绍兴', '120.580232', '30.029752', 1);
INSERT INTO `eb_system_city` VALUES (128, 209250, 1, 191019, '330700000000', '金华市', '浙江,金华', '119.647444', '29.079059', 1);
INSERT INTO `eb_system_city` VALUES (129, 214260, 1, 191019, '330800000000', '衢州市', '浙江,衢州', '118.859457', '28.970079', 1);
INSERT INTO `eb_system_city` VALUES (130, 215955, 1, 191019, '330900000000', '舟山市', '浙江,舟山', '122.207215', '29.985295', 1);
INSERT INTO `eb_system_city` VALUES (131, 216449, 1, 191019, '331000000000', '台州市', '浙江,台州', '121.420757', '28.656386', 1);
INSERT INTO `eb_system_city` VALUES (132, 221610, 1, 191019, '331100000000', '丽水市', '浙江,丽水', '119.922796', '28.467630', 1);
INSERT INTO `eb_system_city` VALUES (133, 224650, 1, 224649, '340100000000', '合肥市', '安徽,合肥', '117.227239', '31.820586', 1);
INSERT INTO `eb_system_city` VALUES (134, 226469, 1, 224649, '340200000000', '芜湖市', '安徽,芜湖', '118.432941', '31.352859', 1);
INSERT INTO `eb_system_city` VALUES (135, 227482, 1, 224649, '340300000000', '蚌埠市', '安徽,蚌埠', '117.389719', '32.916287', 1);
INSERT INTO `eb_system_city` VALUES (136, 228630, 1, 224649, '340400000000', '淮南市', '安徽,淮南', '116.999932', '32.625478', 1);
INSERT INTO `eb_system_city` VALUES (137, 229844, 1, 224649, '340500000000', '马鞍山市', '安徽,马鞍山', '118.506759', '31.670452', 1);
INSERT INTO `eb_system_city` VALUES (138, 230476, 1, 224649, '340600000000', '淮北市', '安徽,淮北', '116.798265', '33.955844', 1);
INSERT INTO `eb_system_city` VALUES (139, 230981, 1, 224649, '340700000000', '铜陵市', '安徽,铜陵', '117.812079', '30.945429', 1);
INSERT INTO `eb_system_city` VALUES (140, 231499, 1, 224649, '340800000000', '安庆市', '安徽,安庆', '117.063754', '30.543494', 1);
INSERT INTO `eb_system_city` VALUES (141, 233236, 1, 224649, '341000000000', '黄山市', '安徽,黄山', '118.337481', '29.714655', 1);
INSERT INTO `eb_system_city` VALUES (142, 234109, 1, 224649, '341100000000', '滁州市', '安徽,滁州', '118.317106', '32.301556', 1);
INSERT INTO `eb_system_city` VALUES (143, 235483, 1, 224649, '341200000000', '阜阳市', '安徽,阜阳', '115.814204', '32.890124', 1);
INSERT INTO `eb_system_city` VALUES (144, 237607, 1, 224649, '341300000000', '宿州市', '安徽,宿州', '116.964356', '33.646373', 1);
INSERT INTO `eb_system_city` VALUES (145, 239084, 1, 224649, '341500000000', '六安市', '安徽,六安', '116.521854', '31.733699', 1);
INSERT INTO `eb_system_city` VALUES (146, 241180, 1, 224649, '341600000000', '亳州市', '安徽,亳州', '115.778676', '33.844582', 1);
INSERT INTO `eb_system_city` VALUES (147, 242634, 1, 224649, '341700000000', '池州市', '安徽,池州', '117.491568', '30.664800', 1);
INSERT INTO `eb_system_city` VALUES (148, 243399, 1, 224649, '341800000000', '宣城市', '安徽,宣城', '118.758816', '30.940718', 1);
INSERT INTO `eb_system_city` VALUES (149, 244378, 1, 244377, '350100000000', '福州市', '福建,福州', '119.296494', '26.074507', 1);
INSERT INTO `eb_system_city` VALUES (150, 247478, 1, 244377, '350200000000', '厦门市', '福建,厦门', '118.089425', '24.479833', 1);
INSERT INTO `eb_system_city` VALUES (151, 248059, 1, 244377, '350300000000', '莆田市', '福建,莆田', '119.007777', '25.454084', 1);
INSERT INTO `eb_system_city` VALUES (152, 249098, 1, 244377, '350400000000', '三明市', '福建,三明', '117.638678', '26.263406', 1);
INSERT INTO `eb_system_city` VALUES (153, 251197, 1, 244377, '350500000000', '泉州市', '福建,泉州', '118.675675', '24.874132', 1);
INSERT INTO `eb_system_city` VALUES (154, 253905, 1, 244377, '350600000000', '漳州市', '福建,漳州', '117.647481', '24.512948', 1);
INSERT INTO `eb_system_city` VALUES (155, 256112, 1, 244377, '350700000000', '南平市', '福建,南平', '118.177708', '26.641768', 1);
INSERT INTO `eb_system_city` VALUES (156, 258160, 1, 244377, '350800000000', '龙岩市', '福建,龙岩', '117.017536', '25.075123', 1);
INSERT INTO `eb_system_city` VALUES (157, 260230, 1, 244377, '350900000000', '宁德市', '福建,宁德', '119.547932', '26.665617', 1);
INSERT INTO `eb_system_city` VALUES (158, 262699, 1, 262698, '360100000000', '南昌市', '江西,南昌', '115.858197', '28.682892', 1);
INSERT INTO `eb_system_city` VALUES (159, 264862, 1, 262698, '360200000000', '景德镇市', '江西,景德镇', '117.178419', '29.268835', 1);
INSERT INTO `eb_system_city` VALUES (160, 265677, 1, 262698, '360300000000', '萍乡市', '江西,萍乡', '113.854556', '27.622768', 1);
INSERT INTO `eb_system_city` VALUES (161, 266521, 1, 262698, '360400000000', '九江市', '江西,九江', '116.001930', '29.705077', 1);
INSERT INTO `eb_system_city` VALUES (162, 269107, 1, 262698, '360500000000', '新余市', '江西,新余', '114.917346', '27.817808', 1);
INSERT INTO `eb_system_city` VALUES (163, 269654, 1, 262698, '360600000000', '鹰潭市', '江西,鹰潭', '117.069202', '28.260189', 1);
INSERT INTO `eb_system_city` VALUES (164, 270222, 1, 262698, '360700000000', '赣州市', '江西,赣州', '114.935029', '25.831829', 1);
INSERT INTO `eb_system_city` VALUES (165, 274444, 1, 262698, '360800000000', '吉安市', '江西,吉安', '114.992509', '27.113443', 1);
INSERT INTO `eb_system_city` VALUES (166, 277615, 1, 262698, '360900000000', '宜春市', '江西,宜春', '114.416778', '27.815619', 1);
INSERT INTO `eb_system_city` VALUES (167, 280562, 1, 262698, '361000000000', '抚州市', '江西,抚州', '116.358181', '27.949217', 1);
INSERT INTO `eb_system_city` VALUES (168, 282841, 1, 262698, '361100000000', '上饶市', '江西,上饶', '117.943433', '28.454862', 1);
INSERT INTO `eb_system_city` VALUES (169, 285861, 1, 285860, '370100000000', '济南市', '山东,济南', '117.119999', '36.651216', 1);
INSERT INTO `eb_system_city` VALUES (170, 291235, 1, 285860, '370200000000', '青岛市', '山东,青岛', '120.382639', '36.067082', 1);
INSERT INTO `eb_system_city` VALUES (171, 298025, 1, 285860, '370300000000', '淄博市', '山东,淄博', '118.054927', '36.813487', 1);
INSERT INTO `eb_system_city` VALUES (172, 301711, 1, 285860, '370400000000', '枣庄市', '山东,枣庄', '117.323725', '34.810487', 1);
INSERT INTO `eb_system_city` VALUES (173, 304309, 1, 285860, '370500000000', '东营市', '山东,东营', '118.674767', '37.434751', 1);
INSERT INTO `eb_system_city` VALUES (174, 306339, 1, 285860, '370600000000', '烟台市', '山东,烟台', '121.447935', '37.463822', 1);
INSERT INTO `eb_system_city` VALUES (175, 313063, 1, 285860, '370700000000', '潍坊市', '山东,潍坊', '119.161755', '36.706774', 1);
INSERT INTO `eb_system_city` VALUES (176, 320179, 1, 285860, '370800000000', '济宁市', '山东,济宁', '116.587098', '35.414921', 1);
INSERT INTO `eb_system_city` VALUES (177, 326706, 1, 285860, '370900000000', '泰安市', '山东,泰安', '117.087614', '36.200252', 1);
INSERT INTO `eb_system_city` VALUES (178, 330547, 1, 285860, '371000000000', '威海市', '山东,威海', '122.120419', '37.513068', 1);
INSERT INTO `eb_system_city` VALUES (179, 333140, 1, 285860, '371100000000', '日照市', '山东,日照', '119.526888', '35.416377', 1);
INSERT INTO `eb_system_city` VALUES (180, 336050, 1, 285860, '371200000000', '莱芜市', '山东,莱芜', '117.676723', '36.213813', 1);
INSERT INTO `eb_system_city` VALUES (181, 337144, 1, 285860, '371300000000', '临沂市', '山东,临沂', '118.356448', '35.104672', 1);
INSERT INTO `eb_system_city` VALUES (182, 344133, 1, 285860, '371400000000', '德州市', '山东,德州', '116.357464', '37.434092', 1);
INSERT INTO `eb_system_city` VALUES (183, 349382, 1, 285860, '371500000000', '聊城市', '山东,聊城', '115.985371', '36.456703', 1);
INSERT INTO `eb_system_city` VALUES (184, 355972, 1, 285860, '371600000000', '滨州市', '山东,滨州', '117.970703', '37.381990', 1);
INSERT INTO `eb_system_city` VALUES (185, 361375, 1, 285860, '371700000000', '菏泽市', '山东,菏泽', '115.480656', '35.233750', 1);
INSERT INTO `eb_system_city` VALUES (186, 367396, 1, 367395, '410100000000', '郑州市', '河南,郑州', '113.625368', '34.746599', 1);
INSERT INTO `eb_system_city` VALUES (187, 370304, 1, 367395, '410200000000', '开封市', '河南,开封', '114.307581', '34.797239', 1);
INSERT INTO `eb_system_city` VALUES (188, 372971, 1, 367395, '410300000000', '洛阳市', '河南,洛阳', '112.454040', '34.619682', 1);
INSERT INTO `eb_system_city` VALUES (189, 376365, 1, 367395, '410400000000', '平顶山市', '河南,平顶山', '113.192661', '33.766169', 1);
INSERT INTO `eb_system_city` VALUES (190, 379245, 1, 367395, '410500000000', '安阳市', '河南,安阳', '114.392392', '36.097577', 1);
INSERT INTO `eb_system_city` VALUES (191, 382878, 1, 367395, '410600000000', '鹤壁市', '河南,鹤壁', '114.297272', '35.747225', 1);
INSERT INTO `eb_system_city` VALUES (192, 383890, 1, 367395, '410700000000', '新乡市', '河南,新乡', '113.926800', '35.303004', 1);
INSERT INTO `eb_system_city` VALUES (193, 387707, 1, 367395, '410800000000', '焦作市', '河南,焦作', '113.241823', '35.215892', 1);
INSERT INTO `eb_system_city` VALUES (194, 389719, 1, 367395, '410900000000', '濮阳市', '河南,濮阳', '115.029215', '35.761829', 1);
INSERT INTO `eb_system_city` VALUES (195, 392737, 1, 367395, '411000000000', '许昌市', '河南,许昌', '113.852640', '34.035506', 1);
INSERT INTO `eb_system_city` VALUES (196, 395254, 1, 367395, '411100000000', '漯河市', '河南,漯河', '114.016539', '33.581412', 1);
INSERT INTO `eb_system_city` VALUES (197, 396611, 1, 367395, '411200000000', '三门峡市', '河南,三门峡', '111.200135', '34.772493', 1);
INSERT INTO `eb_system_city` VALUES (198, 398169, 1, 367395, '411300000000', '南阳市', '河南,南阳', '112.528321', '32.990833', 1);
INSERT INTO `eb_system_city` VALUES (199, 403311, 1, 367395, '411400000000', '商丘市', '河南,商丘', '115.656370', '34.414172', 1);
INSERT INTO `eb_system_city` VALUES (200, 408287, 1, 367395, '411500000000', '信阳市', '河南,信阳', '114.091023', '32.146983', 1);
INSERT INTO `eb_system_city` VALUES (201, 411925, 1, 367395, '411600000000', '周口市', '河南,周口', '114.696951', '33.626149', 1);
INSERT INTO `eb_system_city` VALUES (202, 417174, 1, 367395, '411700000000', '驻马店市', '河南,驻马店', '114.022298', '33.011529', 1);
INSERT INTO `eb_system_city` VALUES (203, 420258, 1, 367395, '419000000000', '直辖县', '河南', '113.753602', '34.765515', 1);
INSERT INTO `eb_system_city` VALUES (204, 420825, 1, 420824, '420100000000', '武汉市', '湖北,武汉', '114.305392', '30.593098', 1);
INSERT INTO `eb_system_city` VALUES (205, 424449, 1, 420824, '420200000000', '黄石市', '湖北,黄石', '115.038520', '30.199652', 1);
INSERT INTO `eb_system_city` VALUES (206, 425508, 1, 420824, '420300000000', '十堰市', '湖北,十堰', '110.797990', '32.629397', 1);
INSERT INTO `eb_system_city` VALUES (207, 427710, 1, 420824, '420500000000', '宜昌市', '湖北,宜昌', '111.286471', '30.691967', 1);
INSERT INTO `eb_system_city` VALUES (208, 429501, 1, 420824, '420600000000', '襄阳市', '湖北,襄阳', '112.122414', '32.008986', 1);
INSERT INTO `eb_system_city` VALUES (209, 432415, 1, 420824, '420700000000', '鄂州市', '湖北,鄂州', '114.894843', '30.391940', 1);
INSERT INTO `eb_system_city` VALUES (210, 432829, 1, 420824, '420800000000', '荆门市', '湖北,荆门', '112.199265', '31.035423', 1);
INSERT INTO `eb_system_city` VALUES (211, 434548, 1, 420824, '420900000000', '孝感市', '湖北,孝感', '113.916902', '30.924568', 1);
INSERT INTO `eb_system_city` VALUES (212, 437779, 1, 420824, '421000000000', '荆州市', '湖北,荆州', '112.239741', '30.335165', 1);
INSERT INTO `eb_system_city` VALUES (213, 440639, 1, 420824, '421100000000', '黄冈市', '湖北,黄冈', '114.872316', '30.453905', 1);
INSERT INTO `eb_system_city` VALUES (214, 445040, 1, 420824, '421200000000', '咸宁市', '湖北,咸宁', '114.322492', '29.841443', 1);
INSERT INTO `eb_system_city` VALUES (215, 446212, 1, 420824, '421300000000', '随州市', '湖北,随州', '113.382458', '31.690215', 1);
INSERT INTO `eb_system_city` VALUES (216, 447268, 1, 420824, '422800000000', '恩施土家族苗族自治州', '湖北,恩施', '109.488172', '30.272156', 1);
INSERT INTO `eb_system_city` VALUES (217, 449865, 1, 420824, '429000000000', '直辖县', '湖北', '114.341861', '30.546498', 1);
INSERT INTO `eb_system_city` VALUES (218, 452124, 1, 452123, '430100000000', '长沙市', '湖南,长沙', '112.938814', '28.228209', 1);
INSERT INTO `eb_system_city` VALUES (219, 453799, 1, 452123, '430200000000', '株洲市', '湖南,株洲', '113.134002', '27.827550', 1);
INSERT INTO `eb_system_city` VALUES (220, 455283, 1, 452123, '430300000000', '湘潭市', '湖南,湘潭', '112.944049', '27.829738', 1);
INSERT INTO `eb_system_city` VALUES (221, 456303, 1, 452123, '430400000000', '衡阳市', '湖南,衡阳', '112.571997', '26.893230', 1);
INSERT INTO `eb_system_city` VALUES (222, 459251, 1, 452123, '430500000000', '邵阳市', '湖南,邵阳', '111.467791', '27.238892', 1);
INSERT INTO `eb_system_city` VALUES (223, 463141, 1, 452123, '430600000000', '岳阳市', '湖南,岳阳', '113.128958', '29.357104', 1);
INSERT INTO `eb_system_city` VALUES (224, 465105, 1, 452123, '430700000000', '常德市', '湖南,常德', '111.698497', '29.031673', 1);
INSERT INTO `eb_system_city` VALUES (225, 467562, 1, 452123, '430800000000', '张家界市', '湖南,张家界', '110.479191', '29.117096', 1);
INSERT INTO `eb_system_city` VALUES (226, 468660, 1, 452123, '430900000000', '益阳市', '湖南,益阳', '112.355180', '28.553860', 1);
INSERT INTO `eb_system_city` VALUES (227, 470123, 1, 452123, '431000000000', '郴州市', '湖南,郴州', '113.014717', '25.770509', 1);
INSERT INTO `eb_system_city` VALUES (228, 472709, 1, 452123, '431100000000', '永州市', '湖南,永州', '111.613445', '26.420394', 1);
INSERT INTO `eb_system_city` VALUES (229, 476148, 1, 452123, '431200000000', '怀化市', '湖南,怀化', '109.998488', '27.554978', 1);
INSERT INTO `eb_system_city` VALUES (230, 479103, 1, 452123, '431300000000', '娄底市', '湖南,娄底', '111.993497', '27.700062', 1);
INSERT INTO `eb_system_city` VALUES (231, 481319, 1, 452123, '433100000000', '湘西土家族苗族自治州', '湖南,湘西', '109.739172', '28.311947', 1);
INSERT INTO `eb_system_city` VALUES (232, 483251, 1, 483250, '440100000000', '广州市', '广东,广州', '113.264434', '23.129162', 1);
INSERT INTO `eb_system_city` VALUES (233, 486129, 1, 483250, '440200000000', '韶关市', '广东,韶关', '113.597522', '24.810403', 1);
INSERT INTO `eb_system_city` VALUES (234, 487721, 1, 483250, '440300000000', '深圳市', '广东,深圳', '114.057868', '22.543099', 1);
INSERT INTO `eb_system_city` VALUES (235, 488589, 1, 483250, '440400000000', '珠海市', '广东,珠海', '113.576726', '22.270715', 1);
INSERT INTO `eb_system_city` VALUES (236, 488954, 1, 483250, '440500000000', '汕头市', '广东,汕头', '116.681972', '23.354091', 1);
INSERT INTO `eb_system_city` VALUES (237, 490106, 1, 483250, '440600000000', '佛山市', '广东,佛山', '113.121416', '23.021548', 1);
INSERT INTO `eb_system_city` VALUES (238, 490919, 1, 483250, '440700000000', '江门市', '广东,江门', '113.081901', '22.578738', 1);
INSERT INTO `eb_system_city` VALUES (239, 492341, 1, 483250, '440800000000', '湛江市', '广东,湛江', '110.359377', '21.270707', 1);
INSERT INTO `eb_system_city` VALUES (240, 494394, 1, 483250, '440900000000', '茂名市', '广东,茂名', '110.925456', '21.662999', 1);
INSERT INTO `eb_system_city` VALUES (241, 496438, 1, 483250, '441200000000', '肇庆市', '广东,肇庆', '112.465091', '23.047191', 1);
INSERT INTO `eb_system_city` VALUES (242, 498104, 1, 483250, '441300000000', '惠州市', '广东,惠州', '114.416196', '23.111847', 1);
INSERT INTO `eb_system_city` VALUES (243, 499489, 1, 483250, '441400000000', '梅州市', '广东,梅州', '116.122238', '24.288615', 1);
INSERT INTO `eb_system_city` VALUES (244, 501867, 1, 483250, '441500000000', '汕尾市', '广东,汕尾', '115.375278', '22.786211', 1);
INSERT INTO `eb_system_city` VALUES (245, 502828, 1, 483250, '441600000000', '河源市', '广东,河源', '114.700447', '23.743538', 1);
INSERT INTO `eb_system_city` VALUES (246, 504366, 1, 483250, '441700000000', '阳江市', '广东,阳江', '111.982232', '21.857958', 1);
INSERT INTO `eb_system_city` VALUES (247, 505298, 1, 483250, '441800000000', '清远市', '广东,清远', '113.056031', '23.681763', 1);
INSERT INTO `eb_system_city` VALUES (248, 506616, 1, 483250, '441900000000', '东莞市', '广东,东莞', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (249, 507255, 1, 483250, '442000000000', '中山市', '广东,中山', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (250, 507557, 1, 483250, '445100000000', '潮州市', '广东,潮州', '116.622603', '23.656950', 1);
INSERT INTO `eb_system_city` VALUES (251, 508648, 1, 483250, '445200000000', '揭阳市', '广东,揭阳', '116.372831', '23.549993', 1);
INSERT INTO `eb_system_city` VALUES (252, 510408, 1, 483250, '445300000000', '云浮市', '广东,云浮', '112.044491', '22.915094', 1);
INSERT INTO `eb_system_city` VALUES (253, 511463, 1, 511462, '450100000000', '南宁市', '广西,南宁', '108.366543', '22.817002', 1);
INSERT INTO `eb_system_city` VALUES (254, 513434, 1, 511462, '450200000000', '柳州市', '广西,柳州', '109.415953', '24.325502', 1);
INSERT INTO `eb_system_city` VALUES (255, 514790, 1, 511462, '450300000000', '桂林市', '广西,桂林', '110.290194', '25.273566', 1);
INSERT INTO `eb_system_city` VALUES (256, 516858, 1, 511462, '450400000000', '梧州市', '广西,梧州', '111.279115', '23.476962', 1);
INSERT INTO `eb_system_city` VALUES (257, 517933, 1, 511462, '450500000000', '北海市', '广西,北海', '109.119927', '21.481254', 1);
INSERT INTO `eb_system_city` VALUES (258, 518407, 1, 511462, '450600000000', '防城港市', '广西,防城港', '108.353846', '21.686860', 1);
INSERT INTO `eb_system_city` VALUES (259, 518808, 1, 511462, '450700000000', '钦州市', '广西,钦州', '108.654146', '21.979933', 1);
INSERT INTO `eb_system_city` VALUES (260, 519929, 1, 511462, '450800000000', '贵港市', '广西,贵港', '109.598926', '23.111530', 1);
INSERT INTO `eb_system_city` VALUES (261, 521166, 1, 511462, '450900000000', '玉林市', '广西,玉林', '110.164756', '22.636379', 1);
INSERT INTO `eb_system_city` VALUES (262, 522786, 1, 511462, '451000000000', '百色市', '广西,百色', '106.618201', '23.902333', 1);
INSERT INTO `eb_system_city` VALUES (263, 524814, 1, 511462, '451100000000', '贺州市', '广西,贺州', '111.566694', '24.403582', 1);
INSERT INTO `eb_system_city` VALUES (264, 525638, 1, 511462, '451200000000', '河池市', '广西,河池', '108.085261', '24.692931', 1);
INSERT INTO `eb_system_city` VALUES (265, 527443, 1, 511462, '451300000000', '来宾市', '广西,来宾', '109.221465', '23.750306', 1);
INSERT INTO `eb_system_city` VALUES (266, 528339, 1, 511462, '451400000000', '崇左市', '广西,崇左', '107.364711', '22.376532', 1);
INSERT INTO `eb_system_city` VALUES (267, 529345, 1, 529344, '460100000000', '海口市', '海南,海口', '110.198293', '20.044001', 1);
INSERT INTO `eb_system_city` VALUES (268, 529878, 1, 529344, '460200000000', '三亚市', '海南,三亚', '109.511909', '18.252847', 1);
INSERT INTO `eb_system_city` VALUES (269, 530060, 1, 529344, '460300000000', '三沙市', '海南,三沙', '112.338695', '16.831839', 1);
INSERT INTO `eb_system_city` VALUES (270, 530070, 1, 529344, '460400000000', '儋州市', '海南,儋州', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (271, 530468, 1, 529344, '469000000000', '省直辖县级行政区域', '海南', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (272, 533329, 1, 533328, '500100000000', '重庆市', '重庆', '106.551556', '29.563009', 1);
INSERT INTO `eb_system_city` VALUES (273, 540700, 1, 533328, '500200000000', '县', '重庆', '106.551556', '29.563009', 1);
INSERT INTO `eb_system_city` VALUES (274, 545533, 1, 545532, '510100000000', '成都市', '四川,成都', '104.066541', '30.572269', 1);
INSERT INTO `eb_system_city` VALUES (275, 550275, 1, 545532, '510300000000', '自贡市', '四川,自贡', '104.778442', '29.339030', 1);
INSERT INTO `eb_system_city` VALUES (276, 551809, 1, 545532, '510400000000', '攀枝花市', '四川,攀枝花', '101.718637', '26.582347', 1);
INSERT INTO `eb_system_city` VALUES (277, 552358, 1, 545532, '510500000000', '泸州市', '四川,泸州', '105.442258', '28.871810', 1);
INSERT INTO `eb_system_city` VALUES (278, 554142, 1, 545532, '510600000000', '德阳市', '四川,德阳', '104.397894', '31.126855', 1);
INSERT INTO `eb_system_city` VALUES (279, 556077, 1, 545532, '510700000000', '绵阳市', '四川,绵阳', '104.679114', '31.467450', 1);
INSERT INTO `eb_system_city` VALUES (280, 560191, 1, 545532, '510800000000', '广元市', '四川,广元', '105.843357', '32.435435', 1);
INSERT INTO `eb_system_city` VALUES (281, 563242, 1, 545532, '510900000000', '遂宁市', '四川,遂宁', '105.592898', '30.532847', 1);
INSERT INTO `eb_system_city` VALUES (282, 565735, 1, 545532, '511000000000', '内江市', '四川,内江', '105.058433', '29.580228', 1);
INSERT INTO `eb_system_city` VALUES (283, 568202, 1, 545532, '511100000000', '乐山市', '四川,乐山', '103.765568', '29.552106', 1);
INSERT INTO `eb_system_city` VALUES (284, 570733, 1, 545532, '511300000000', '南充市', '四川,南充', '106.110698', '30.837793', 1);
INSERT INTO `eb_system_city` VALUES (285, 576992, 1, 545532, '511400000000', '眉山市', '四川,眉山', '103.848538', '30.075439', 1);
INSERT INTO `eb_system_city` VALUES (286, 578485, 1, 545532, '511500000000', '宜宾市', '四川,宜宾', '104.643215', '28.751768', 1);
INSERT INTO `eb_system_city` VALUES (287, 581870, 1, 545532, '511600000000', '广安市', '四川,广安', '106.633212', '30.455961', 1);
INSERT INTO `eb_system_city` VALUES (288, 585049, 1, 545532, '511700000000', '达州市', '四川,达州', '107.468023', '31.209571', 1);
INSERT INTO `eb_system_city` VALUES (289, 588538, 1, 545532, '511800000000', '雅安市', '四川,雅安', '103.013261', '29.980537', 1);
INSERT INTO `eb_system_city` VALUES (290, 589779, 1, 545532, '511900000000', '巴中市', '四川,巴中', '106.747477', '31.867903', 1);
INSERT INTO `eb_system_city` VALUES (291, 592598, 1, 545532, '512000000000', '资阳市', '四川,资阳', '104.627636', '30.128901', 1);
INSERT INTO `eb_system_city` VALUES (292, 594864, 1, 545532, '513200000000', '阿坝藏族羌族自治州', '四川,阿坝', '102.224653', '31.899413', 1);
INSERT INTO `eb_system_city` VALUES (293, 596525, 1, 545532, '513300000000', '甘孜藏族自治州', '四川,甘孜', '101.962310', '30.049520', 1);
INSERT INTO `eb_system_city` VALUES (294, 599659, 1, 545532, '513400000000', '凉山彝族自治州', '四川,凉山', '102.267335', '27.881610', 1);
INSERT INTO `eb_system_city` VALUES (295, 604132, 1, 604131, '520100000000', '贵阳市', '贵州,贵阳', '106.630153', '26.647661', 1);
INSERT INTO `eb_system_city` VALUES (296, 605834, 1, 604131, '520200000000', '六盘水市', '贵州,六盘水', '104.830359', '26.592666', 1);
INSERT INTO `eb_system_city` VALUES (297, 607029, 1, 604131, '520300000000', '遵义市', '贵州,遵义', '106.927389', '27.725654', 1);
INSERT INTO `eb_system_city` VALUES (298, 609309, 1, 604131, '520400000000', '安顺市', '贵州,安顺', '105.947593', '26.253072', 1);
INSERT INTO `eb_system_city` VALUES (299, 610607, 1, 604131, '520500000000', '毕节市', '贵州,毕节', '105.283992', '27.302589', 1);
INSERT INTO `eb_system_city` VALUES (300, 614530, 1, 604131, '520600000000', '铜仁市', '贵州,铜仁', '109.189598', '27.731514', 1);
INSERT INTO `eb_system_city` VALUES (301, 617670, 1, 604131, '522300000000', '黔西南布依族苗族自治州', '贵州,黔西南', '104.906396', '25.087825', 1);
INSERT INTO `eb_system_city` VALUES (302, 619017, 1, 604131, '522600000000', '黔东南苗族侗族自治州', '贵州,黔东南', '107.982859', '26.583442', 1);
INSERT INTO `eb_system_city` VALUES (303, 622734, 1, 604131, '522700000000', '黔南布依族苗族自治州', '贵州,黔南', '107.522097', '26.254092', 1);
INSERT INTO `eb_system_city` VALUES (304, 624373, 1, 624372, '530100000000', '昆明市', '云南,昆明', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (305, 626181, 1, 624372, '530300000000', '曲靖市', '云南,曲靖', '103.796167', '25.489999', 1);
INSERT INTO `eb_system_city` VALUES (306, 627981, 1, 624372, '530400000000', '玉溪市', '云南,玉溪', '102.546543', '24.352036', 1);
INSERT INTO `eb_system_city` VALUES (307, 628776, 1, 624372, '530500000000', '保山市', '云南,保山', '99.161761', '25.112046', 1);
INSERT INTO `eb_system_city` VALUES (308, 629781, 1, 624372, '530600000000', '昭通市', '云南,昭通', '103.717465', '27.338257', 1);
INSERT INTO `eb_system_city` VALUES (309, 631276, 1, 624372, '530700000000', '丽江市', '云南,丽江', '100.227750', '26.855047', 1);
INSERT INTO `eb_system_city` VALUES (310, 631811, 1, 624372, '530800000000', '普洱市', '云南,普洱', '100.966512', '22.825065', 1);
INSERT INTO `eb_system_city` VALUES (311, 632971, 1, 624372, '530900000000', '临沧市', '云南,临沧', '100.079583', '23.877573', 1);
INSERT INTO `eb_system_city` VALUES (312, 634006, 1, 624372, '532300000000', '楚雄彝族自治州', '云南,楚雄', '101.528069', '25.045532', 1);
INSERT INTO `eb_system_city` VALUES (313, 635219, 1, 624372, '532500000000', '红河哈尼族彝族自治州', '云南,红河', '103.374799', '23.363130', 1);
INSERT INTO `eb_system_city` VALUES (314, 636688, 1, 624372, '532600000000', '文山壮族苗族自治州', '云南,文山', '104.216248', '23.400734', 1);
INSERT INTO `eb_system_city` VALUES (315, 637778, 1, 624372, '532800000000', '西双版纳傣族自治州', '云南,西双版纳', '100.797777', '22.007351', 1);
INSERT INTO `eb_system_city` VALUES (316, 638092, 1, 624372, '532900000000', '大理白族自治州', '云南,大理', '100.267639', '25.606485', 1);
INSERT INTO `eb_system_city` VALUES (317, 639368, 1, 624372, '533100000000', '德宏傣族景颇族自治州', '云南,德宏', '98.584895', '24.433353', 1);
INSERT INTO `eb_system_city` VALUES (318, 639802, 1, 624372, '533300000000', '怒江傈僳族自治州', '云南,怒江', '98.853097', '25.852547', 1);
INSERT INTO `eb_system_city` VALUES (319, 640107, 1, 624372, '533400000000', '迪庆藏族自治州', '云南,迪庆', '99.702234', '27.818882', 1);
INSERT INTO `eb_system_city` VALUES (320, 640333, 1, 640332, '540100000000', '拉萨市', '西藏,拉萨', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (321, 640675, 1, 640332, '540200000000', '日喀则市', '西藏,日喀则', '88.880583', '29.266869', 1);
INSERT INTO `eb_system_city` VALUES (322, 642571, 1, 640332, '540300000000', '昌都市', '西藏,昌都', '97.172020', '31.140969', 1);
INSERT INTO `eb_system_city` VALUES (323, 643863, 1, 640332, '540400000000', '林芝市', '西藏,林芝', '94.361490', '29.649128', 1);
INSERT INTO `eb_system_city` VALUES (324, 644423, 1, 640332, '540500000000', '山南市', '西藏,山南', '91.117212', '29.646922', 1);
INSERT INTO `eb_system_city` VALUES (325, 645076, 1, 640332, '542400000000', '那曲地区', '西藏,那曲', '92.051239', '31.476202', 1);
INSERT INTO `eb_system_city` VALUES (326, 646392, 1, 640332, '542500000000', '阿里地区', '西藏,阿里', '80.105804', '32.501111', 1);
INSERT INTO `eb_system_city` VALUES (327, 646579, 1, 646578, '610100000000', '西安市', '陕西,西安', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (328, 649979, 1, 646578, '610200000000', '铜川市', '陕西,铜川', '108.945233', '34.896756', 1);
INSERT INTO `eb_system_city` VALUES (329, 650575, 1, 646578, '610300000000', '宝鸡市', '陕西,宝鸡', '107.237974', '34.361979', 1);
INSERT INTO `eb_system_city` VALUES (330, 652581, 1, 646578, '610400000000', '咸阳市', '陕西,咸阳', '108.708991', '34.329605', 1);
INSERT INTO `eb_system_city` VALUES (331, 655295, 1, 646578, '610500000000', '渭南市', '陕西,渭南', '109.509786', '34.499995', 1);
INSERT INTO `eb_system_city` VALUES (332, 657848, 1, 646578, '610600000000', '延安市', '陕西,延安', '109.489727', '36.585455', 1);
INSERT INTO `eb_system_city` VALUES (333, 660643, 1, 646578, '610700000000', '汉中市', '陕西,汉中', '107.023323', '33.067480', 1);
INSERT INTO `eb_system_city` VALUES (334, 663046, 1, 646578, '610800000000', '榆林市', '陕西,榆林', '109.734589', '38.285390', 1);
INSERT INTO `eb_system_city` VALUES (335, 667681, 1, 646578, '610900000000', '安康市', '陕西,安康', '109.029022', '32.684714', 1);
INSERT INTO `eb_system_city` VALUES (336, 669707, 1, 646578, '611000000000', '商洛市', '陕西,商洛', '109.940477', '33.870422', 1);
INSERT INTO `eb_system_city` VALUES (337, 671120, 1, 671119, '620100000000', '兰州市', '甘肃,兰州', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (338, 672330, 1, 671119, '620200000000', '嘉峪关市', '甘肃,嘉峪关', '98.289152', '39.773130', 1);
INSERT INTO `eb_system_city` VALUES (339, 672385, 1, 671119, '620300000000', '金昌市', '甘肃,金昌', '102.188043', '38.520089', 1);
INSERT INTO `eb_system_city` VALUES (340, 672577, 1, 671119, '620400000000', '白银市', '甘肃,白银', '104.138559', '36.544756', 1);
INSERT INTO `eb_system_city` VALUES (341, 673463, 1, 671119, '620500000000', '天水市', '甘肃,天水', '105.724947', '34.580863', 1);
INSERT INTO `eb_system_city` VALUES (342, 676215, 1, 671119, '620600000000', '武威市', '甘肃,武威', '102.638011', '37.928264', 1);
INSERT INTO `eb_system_city` VALUES (343, 677568, 1, 671119, '620700000000', '张掖市', '甘肃,张掖', '100.449818', '38.925875', 1);
INSERT INTO `eb_system_city` VALUES (344, 678560, 1, 671119, '620800000000', '平凉市', '甘肃,平凉', '106.665240', '35.543051', 1);
INSERT INTO `eb_system_city` VALUES (345, 680191, 1, 671119, '620900000000', '酒泉市', '甘肃,酒泉', '98.494483', '39.732410', 1);
INSERT INTO `eb_system_city` VALUES (346, 680815, 1, 671119, '621000000000', '庆阳市', '甘肃,庆阳', '107.643631', '35.709077', 1);
INSERT INTO `eb_system_city` VALUES (347, 682322, 1, 671119, '621100000000', '定西市', '甘肃,定西', '104.626282', '35.580662', 1);
INSERT INTO `eb_system_city` VALUES (348, 684415, 1, 671119, '621200000000', '陇南市', '甘肃,陇南', '104.921841', '33.400684', 1);
INSERT INTO `eb_system_city` VALUES (349, 687916, 1, 671119, '622900000000', '临夏回族自治州', '甘肃,临夏', '103.210538', '35.601182', 1);
INSERT INTO `eb_system_city` VALUES (350, 689265, 1, 671119, '623000000000', '甘南藏族自治州', '甘肃,甘南', '102.911027', '34.983385', 1);
INSERT INTO `eb_system_city` VALUES (351, 690095, 1, 690094, '630100000000', '西宁市', '青海,西宁', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (352, 691278, 1, 690094, '630200000000', '海东市', '青海,海东', '102.104287', '36.502039', 1);
INSERT INTO `eb_system_city` VALUES (353, 693040, 1, 690094, '632200000000', '海北藏族自治州', '青海,海北', '100.900997', '36.954413', 1);
INSERT INTO `eb_system_city` VALUES (354, 693342, 1, 690094, '632300000000', '黄南藏族自治州', '青海,黄南', '102.015248', '35.519548', 1);
INSERT INTO `eb_system_city` VALUES (355, 693672, 1, 690094, '632500000000', '海南藏族自治州', '青海,海南', '101.780199', '36.620901', 1);
INSERT INTO `eb_system_city` VALUES (356, 694220, 1, 690094, '632600000000', '果洛藏族自治州', '青海,果洛', '100.244808', '34.471431', 1);
INSERT INTO `eb_system_city` VALUES (357, 694478, 1, 690094, '632700000000', '玉树藏族自治州', '青海,玉树', '97.091934', '33.011674', 1);
INSERT INTO `eb_system_city` VALUES (358, 694846, 1, 690094, '632800000000', '海西蒙古族藏族自治州', '青海,海西', '97.369751', '37.377139', 1);
INSERT INTO `eb_system_city` VALUES (359, 695260, 1, 695259, '640100000000', '银川市', '宁夏,银川', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (360, 695883, 1, 695259, '640200000000', '石嘴山市', '宁夏,石嘴山', '106.383303', '38.983236', 1);
INSERT INTO `eb_system_city` VALUES (361, 696252, 1, 695259, '640300000000', '吴忠市', '宁夏,吴忠', '106.198393', '37.997460', 1);
INSERT INTO `eb_system_city` VALUES (362, 696928, 1, 695259, '640400000000', '固原市', '宁夏,固原', '106.242610', '36.015855', 1);
INSERT INTO `eb_system_city` VALUES (363, 697887, 1, 695259, '640500000000', '中卫市', '宁夏,中卫', '105.196902', '37.499972', 1);
INSERT INTO `eb_system_city` VALUES (364, 698441, 1, 698440, '650100000000', '乌鲁木齐市', '新疆,乌鲁木齐', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (365, 699583, 1, 698440, '650200000000', '克拉玛依市', '新疆,克拉玛依', '84.889207', '45.579888', 1);
INSERT INTO `eb_system_city` VALUES (366, 699773, 1, 698440, '650400000000', '吐鲁番市', '新疆,吐鲁番', '89.189655', '42.951384', 1);
INSERT INTO `eb_system_city` VALUES (367, 700070, 1, 698440, '650500000000', '哈密市', '新疆,哈密', '93.514916', '42.818501', 1);
INSERT INTO `eb_system_city` VALUES (368, 700489, 1, 698440, '652300000000', '昌吉回族自治州', '新疆,昌吉', '87.308224', '44.011182', 1);
INSERT INTO `eb_system_city` VALUES (369, 701559, 1, 698440, '652700000000', '博尔塔拉蒙古自治州', '新疆,博尔塔拉', '82.066159', '44.905588', 1);
INSERT INTO `eb_system_city` VALUES (370, 702104, 1, 698440, '652800000000', '巴音郭楞蒙古自治州', '新疆,巴音郭楞', '86.145298', '41.764115', 1);
INSERT INTO `eb_system_city` VALUES (371, 703119, 1, 698440, '652900000000', '阿克苏地区', '新疆,阿克苏', '80.260605', '41.168779', 1);
INSERT INTO `eb_system_city` VALUES (372, 704779, 1, 698440, '653000000000', '克孜勒苏柯尔克孜自治州', '新疆,克孜勒苏', '76.167819', '39.714526', 1);
INSERT INTO `eb_system_city` VALUES (373, 705145, 1, 698440, '653100000000', '喀什地区', '新疆,喀什', '75.989755', '39.470400', 1);
INSERT INTO `eb_system_city` VALUES (374, 708117, 1, 698440, '653200000000', '和田地区', '新疆,和田', '79.922211', '37.114157', 1);
INSERT INTO `eb_system_city` VALUES (375, 709792, 1, 698440, '654000000000', '伊犁哈萨克自治州', '新疆,伊犁', '81.324136', '43.916823', 1);
INSERT INTO `eb_system_city` VALUES (376, 711218, 1, 698440, '654200000000', '塔城地区', '新疆,塔城', '82.980316', '46.745364', 1);
INSERT INTO `eb_system_city` VALUES (377, 712893, 1, 698440, '654300000000', '阿勒泰地区', '新疆,阿勒泰', '88.141253', '47.844924', 1);
INSERT INTO `eb_system_city` VALUES (378, 713697, 1, 698440, '659000000000', '直辖县', '新疆', '87.627704', '43.793026', 1);
INSERT INTO `eb_system_city` VALUES (385, 714402, 1, 714401, '0', '彰化县', '台湾,彰化', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (386, 717531, 1, 714401, '0', '新北市', '台湾,新北', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (387, 719868, 1, 714401, '0', '澎湖县', '台湾,澎湖', '119.566417', '23.569733', 1);
INSERT INTO `eb_system_city` VALUES (388, 720118, 1, 714401, '0', '屏东县', '台湾,屏东', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (389, 722024, 1, 714401, '0', '臺中市', '台湾,臺中', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (390, 725488, 1, 714401, '0', '臺南市', '台湾,臺南', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (391, 727730, 1, 714401, '0', '臺北市', '台湾,臺北', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (392, 729928, 1, 714401, '0', '臺东县', '台湾,臺东', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (393, 730843, 1, 714401, '0', '桃园市', '台湾,桃园', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (394, 734179, 1, 714401, '0', '宜兰县', '台湾,宜兰', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (395, 736051, 1, 714401, '0', '南投县', '台湾,南投', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (396, 737856, 1, 714401, '0', '南海岛', '台湾,南海岛', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (397, 737861, 1, 714401, '0', '苗栗县', '台湾,苗栗', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (398, 739957, 1, 714401, '0', '嘉义市', '台湾,嘉义', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (399, 740510, 1, 714401, '0', '嘉义县', '台湾,嘉义', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (400, 742126, 1, 714401, '0', '新竹市', '台湾,新竹', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (401, 742636, 1, 714401, '0', '新竹县', '台湾,新竹', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (402, 743938, 1, 714401, '0', '花莲县', '台湾,花莲', '121.300000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (403, 745674, 1, 714401, '0', '高雄市', '台湾,高雄', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (404, 748553, 1, 714401, '0', '基隆市', '台湾,基隆', '121.746248', '25.130741', 1);
INSERT INTO `eb_system_city` VALUES (405, 749571, 1, 714401, '0', '金门县', '台湾,金门', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (406, 749930, 1, 714401, '0', '连江县', '台湾,连江', '119.539704', '26.197364', 1);
INSERT INTO `eb_system_city` VALUES (407, 749957, 1, 714401, '0', '云林县', '台湾,云林', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (408, 3, 2, 2, '110101000000', '东城区', '北京,东城', '116.416357', '39.928353', 1);
INSERT INTO `eb_system_city` VALUES (409, 203, 2, 2, '110102000000', '西城区', '北京,西城', '116.365868', '39.912289', 1);
INSERT INTO `eb_system_city` VALUES (410, 480, 2, 2, '110105000000', '朝阳区', '北京,朝阳', '116.443108', '39.921470', 1);
INSERT INTO `eb_system_city` VALUES (411, 1122, 2, 2, '110106000000', '丰台区', '北京,丰台', '116.287149', '39.858427', 1);
INSERT INTO `eb_system_city` VALUES (412, 1533, 2, 2, '110107000000', '石景山区', '北京,石景山', '116.222982', '39.906611', 1);
INSERT INTO `eb_system_city` VALUES (413, 1692, 2, 2, '110108000000', '海淀区', '北京,海淀', '116.298056', '39.959912', 1);
INSERT INTO `eb_system_city` VALUES (414, 2376, 2, 2, '110109000000', '门头沟区', '北京,门头沟', '116.102009', '39.940646', 1);
INSERT INTO `eb_system_city` VALUES (415, 2689, 2, 2, '110111000000', '房山区', '北京,房山', '116.143267', '39.749144', 1);
INSERT INTO `eb_system_city` VALUES (416, 3324, 2, 2, '110112000000', '通州区', '北京,通州', '116.656435', '39.909946', 1);
INSERT INTO `eb_system_city` VALUES (417, 3927, 2, 2, '110113000000', '顺义区', '北京,顺义', '116.654651', '40.130347', 1);
INSERT INTO `eb_system_city` VALUES (418, 4498, 2, 2, '110114000000', '昌平区', '北京,昌平', '116.231204', '40.220660', 1);
INSERT INTO `eb_system_city` VALUES (419, 5042, 2, 2, '110115000000', '大兴区', '北京,大兴', '116.341395', '39.726929', 1);
INSERT INTO `eb_system_city` VALUES (420, 5800, 2, 2, '110116000000', '怀柔区', '北京,怀柔', '116.642349', '40.315704', 1);
INSERT INTO `eb_system_city` VALUES (421, 6138, 2, 2, '110117000000', '平谷区', '北京,平谷', '117.121383', '40.140701', 1);
INSERT INTO `eb_system_city` VALUES (422, 6466, 2, 2, '110118000000', '密云区', '北京,密云', '116.843177', '40.376834', 1);
INSERT INTO `eb_system_city` VALUES (423, 6921, 2, 2, '110119000000', '延庆区', '北京,延庆', '115.974848', '40.456951', 1);
INSERT INTO `eb_system_city` VALUES (424, 7364, 2, 7363, '120101000000', '和平区', '天津,和平', '117.214510', '39.116949', 1);
INSERT INTO `eb_system_city` VALUES (425, 7434, 2, 7363, '120102000000', '河东区', '天津,河东', '117.251587', '39.128291', 1);
INSERT INTO `eb_system_city` VALUES (426, 7607, 2, 7363, '120103000000', '河西区', '天津,河西', '117.223372', '39.109563', 1);
INSERT INTO `eb_system_city` VALUES (427, 7763, 2, 7363, '120104000000', '南开区', '天津,南开', '117.150738', '39.138203', 1);
INSERT INTO `eb_system_city` VALUES (428, 7954, 2, 7363, '120105000000', '河北区', '天津,河北', '117.200983', '39.084158', 1);
INSERT INTO `eb_system_city` VALUES (429, 8079, 2, 7363, '120106000000', '红桥区', '天津,红桥', '117.151533', '39.167345', 1);
INSERT INTO `eb_system_city` VALUES (430, 8298, 2, 7363, '120110000000', '东丽区', '天津,东丽', '117.314324', '39.086569', 1);
INSERT INTO `eb_system_city` VALUES (431, 8563, 2, 7363, '120111000000', '西青区', '天津,西青', '117.008827', '39.141152', 1);
INSERT INTO `eb_system_city` VALUES (432, 8835, 2, 7363, '120112000000', '津南区', '天津,津南', '117.357260', '38.937928', 1);
INSERT INTO `eb_system_city` VALUES (433, 9102, 2, 7363, '120113000000', '北辰区', '天津,北辰', '117.135488', '39.224792', 1);
INSERT INTO `eb_system_city` VALUES (434, 9378, 2, 7363, '120114000000', '武清区', '天津,武清', '117.044388', '39.384119', 1);
INSERT INTO `eb_system_city` VALUES (435, 10143, 2, 7363, '120115000000', '宝坻区', '天津,宝坻', '117.309863', '39.717379', 1);
INSERT INTO `eb_system_city` VALUES (436, 10983, 2, 7363, '120116000000', '滨海新区', '天津,滨海', '117.517969', '38.719936', 1);
INSERT INTO `eb_system_city` VALUES (437, 11454, 2, 7363, '120117000000', '宁河区', '天津,宁河', '117.826625', '39.329858', 1);
INSERT INTO `eb_system_city` VALUES (438, 11795, 2, 7363, '120118000000', '静海区', '天津,静海', '116.974130', '38.947512', 1);
INSERT INTO `eb_system_city` VALUES (439, 12251, 2, 7363, '120119000000', '蓟州区', '天津,蓟州', '117.200983', '39.084158', 1);
INSERT INTO `eb_system_city` VALUES (440, 13269, 2, 13268, '130101000000', '市辖区', '河北,石家庄', '114.514859', '38.042306', 1);
INSERT INTO `eb_system_city` VALUES (441, 13270, 2, 13268, '130102000000', '长安区', '河北,石家庄,长安', '114.539060', '38.036654', 1);
INSERT INTO `eb_system_city` VALUES (442, 13444, 2, 13268, '130104000000', '桥西区', '河北,石家庄,桥西', '114.461154', '38.004043', 1);
INSERT INTO `eb_system_city` VALUES (443, 13601, 2, 13268, '130105000000', '新华区', '河北,石家庄,新华', '114.463347', '38.051060', 1);
INSERT INTO `eb_system_city` VALUES (444, 13728, 2, 13268, '130107000000', '井陉矿区', '河北,石家庄,井陉', '114.145240', '38.032148', 1);
INSERT INTO `eb_system_city` VALUES (445, 13788, 2, 13268, '130108000000', '裕华区', '河北,石家庄,裕华', '114.531362', '38.006453', 1);
INSERT INTO `eb_system_city` VALUES (446, 13895, 2, 13268, '130109000000', '藁城区', '河北,石家庄,藁城', '114.847075', '38.021567', 1);
INSERT INTO `eb_system_city` VALUES (447, 14142, 2, 13268, '130110000000', '鹿泉区', '河北,石家庄,鹿泉', '114.313724', '38.085958', 1);
INSERT INTO `eb_system_city` VALUES (448, 14377, 2, 13268, '130111000000', '栾城区', '河北,石家庄,栾城', '114.648318', '37.900200', 1);
INSERT INTO `eb_system_city` VALUES (449, 14562, 2, 13268, '130121000000', '井陉县', '河北,石家庄,井陉', '114.145240', '38.032148', 1);
INSERT INTO `eb_system_city` VALUES (450, 14902, 2, 13268, '130123000000', '正定县', '河北,石家庄,正定', '114.570941', '38.146445', 1);
INSERT INTO `eb_system_city` VALUES (451, 15100, 2, 13268, '130125000000', '行唐县', '河北,石家庄,行唐', '114.552692', '38.438411', 1);
INSERT INTO `eb_system_city` VALUES (452, 15447, 2, 13268, '130126000000', '灵寿县', '河北,石家庄,灵寿', '114.382645', '38.308628', 1);
INSERT INTO `eb_system_city` VALUES (453, 15747, 2, 13268, '130127000000', '高邑县', '河北,石家庄,高邑', '114.611433', '37.615159', 1);
INSERT INTO `eb_system_city` VALUES (454, 15860, 2, 13268, '130128000000', '深泽县', '河北,石家庄,深泽', '115.200910', '38.184072', 1);
INSERT INTO `eb_system_city` VALUES (455, 15993, 2, 13268, '130129000000', '赞皇县', '河北,石家庄,赞皇', '114.386155', '37.665576', 1);
INSERT INTO `eb_system_city` VALUES (456, 16218, 2, 13268, '130130000000', '无极县', '河北,石家庄,无极', '114.976337', '38.179141', 1);
INSERT INTO `eb_system_city` VALUES (457, 16447, 2, 13268, '130131000000', '平山县', '河北,石家庄,平山', '114.199134', '38.247144', 1);
INSERT INTO `eb_system_city` VALUES (458, 17188, 2, 13268, '130132000000', '元氏县', '河北,石家庄,元氏', '114.525580', '37.766651', 1);
INSERT INTO `eb_system_city` VALUES (459, 17417, 2, 13268, '130133000000', '赵县', '河北,石家庄,赵县', '114.776187', '37.756498', 1);
INSERT INTO `eb_system_city` VALUES (460, 17710, 2, 13268, '130183000000', '晋州市', '河北,石家庄,晋州', '115.044185', '38.033629', 1);
INSERT INTO `eb_system_city` VALUES (461, 17945, 2, 13268, '130184000000', '新乐市', '河北,石家庄,新乐', '114.684014', '38.343296', 1);
INSERT INTO `eb_system_city` VALUES (462, 18129, 2, 18128, '130201000000', '市辖区', '河北,唐山', '118.180193', '39.630867', 1);
INSERT INTO `eb_system_city` VALUES (463, 18130, 2, 18128, '130202000000', '路南区', '河北,唐山,路南', '118.154354', '39.625059', 1);
INSERT INTO `eb_system_city` VALUES (464, 18297, 2, 18128, '130203000000', '路北区', '河北,唐山,路北', '118.200692', '39.624437', 1);
INSERT INTO `eb_system_city` VALUES (465, 18542, 2, 18128, '130204000000', '古冶区', '河北,唐山,古冶', '118.447635', '39.733578', 1);
INSERT INTO `eb_system_city` VALUES (466, 18754, 2, 18128, '130205000000', '开平区', '河北,唐山,开平', '118.261842', '39.671001', 1);
INSERT INTO `eb_system_city` VALUES (467, 18938, 2, 18128, '130207000000', '丰南区', '河北,唐山,丰南', '118.085169', '39.576031', 1);
INSERT INTO `eb_system_city` VALUES (468, 19436, 2, 18128, '130208000000', '丰润区', '河北,唐山,丰润', '118.162216', '39.832582', 1);
INSERT INTO `eb_system_city` VALUES (469, 19987, 2, 18128, '130209000000', '曹妃甸区', '河北,唐山,曹妃甸', '118.460379', '39.273070', 1);
INSERT INTO `eb_system_city` VALUES (470, 20152, 2, 18128, '130223000000', '滦县', '河北,唐山,滦县', '118.703598', '39.740593', 1);
INSERT INTO `eb_system_city` VALUES (471, 20696, 2, 18128, '130224000000', '滦南县', '河北,唐山,滦南', '118.682379', '39.518997', 1);
INSERT INTO `eb_system_city` VALUES (472, 21321, 2, 18128, '130225000000', '乐亭县', '河北,唐山,乐亭', '118.912571', '39.425608', 1);
INSERT INTO `eb_system_city` VALUES (473, 21825, 2, 18128, '130227000000', '迁西县', '河北,唐山,迁西', '118.314715', '40.141500', 1);
INSERT INTO `eb_system_city` VALUES (474, 22273, 2, 18128, '130229000000', '玉田县', '河北,唐山,玉田', '117.738658', '39.900401', 1);
INSERT INTO `eb_system_city` VALUES (475, 23067, 2, 18128, '130281000000', '遵化市', '河北,唐山,遵化', '117.965892', '40.189202', 1);
INSERT INTO `eb_system_city` VALUES (476, 23787, 2, 18128, '130283000000', '迁安市', '河北,唐山,迁安', '118.701144', '39.999175', 1);
INSERT INTO `eb_system_city` VALUES (477, 24372, 2, 24371, '130301000000', '市辖区', '河北,秦皇岛', '119.600492', '39.935385', 1);
INSERT INTO `eb_system_city` VALUES (478, 24373, 2, 24371, '130302000000', '海港区', '河北,秦皇岛,海港', '119.564962', '39.947560', 1);
INSERT INTO `eb_system_city` VALUES (479, 24760, 2, 24371, '130303000000', '山海关区', '河北,秦皇岛,山海关', '119.775799', '39.978849', 1);
INSERT INTO `eb_system_city` VALUES (480, 24891, 2, 24371, '130304000000', '北戴河区', '河北,秦皇岛,北戴河', '119.488914', '39.834751', 1);
INSERT INTO `eb_system_city` VALUES (481, 24951, 2, 24371, '130306000000', '抚宁区', '河北,秦皇岛,抚宁', '119.244848', '39.876254', 1);
INSERT INTO `eb_system_city` VALUES (482, 25332, 2, 24371, '130321000000', '青龙满族自治县', '河北,秦皇岛,青龙', '118.949684', '40.407578', 1);
INSERT INTO `eb_system_city` VALUES (483, 25758, 2, 24371, '130322000000', '昌黎县', '河北,秦皇岛,昌黎', '119.162694', '39.712813', 1);
INSERT INTO `eb_system_city` VALUES (484, 26216, 2, 24371, '130324000000', '卢龙县', '河北,秦皇岛,卢龙', '118.892986', '39.891947', 1);
INSERT INTO `eb_system_city` VALUES (485, 26780, 2, 26779, '130401000000', '市辖区', '河北,邯郸', '114.538961', '36.625657', 1);
INSERT INTO `eb_system_city` VALUES (486, 26781, 2, 26779, '130402000000', '邯山区', '河北,邯郸,邯山', '114.490431', '36.580358', 1);
INSERT INTO `eb_system_city` VALUES (487, 26877, 2, 26779, '130403000000', '丛台区', '河北,邯郸,丛台', '114.492897', '36.636410', 1);
INSERT INTO `eb_system_city` VALUES (488, 27018, 2, 26779, '130404000000', '复兴区', '河北,邯郸,复兴', '114.462058', '36.639022', 1);
INSERT INTO `eb_system_city` VALUES (489, 27135, 2, 26779, '130406000000', '峰峰矿区', '河北,邯郸,峰峰', '114.214634', '36.472281', 1);
INSERT INTO `eb_system_city` VALUES (490, 27372, 2, 26779, '130421000000', '邯郸县', '河北,邯郸,邯郸', '114.530925', '36.593881', 1);
INSERT INTO `eb_system_city` VALUES (491, 27538, 2, 26779, '130423000000', '临漳县', '河北,邯郸,临漳', '114.619544', '36.335300', 1);
INSERT INTO `eb_system_city` VALUES (492, 27978, 2, 26779, '130424000000', '成安县', '河北,邯郸,成安', '114.670032', '36.444317', 1);
INSERT INTO `eb_system_city` VALUES (493, 28222, 2, 26779, '130425000000', '大名县', '河北,邯郸,大名', '115.147814', '36.285616', 1);
INSERT INTO `eb_system_city` VALUES (494, 28894, 2, 26779, '130426000000', '涉县', '河北,邯郸,涉县', '113.691401', '36.584995', 1);
INSERT INTO `eb_system_city` VALUES (495, 29226, 2, 26779, '130427000000', '磁县', '河北,邯郸,磁县', '114.373947', '36.374012', 1);
INSERT INTO `eb_system_city` VALUES (496, 29613, 2, 26779, '130428000000', '肥乡县', '河北,邯郸,肥乡', '114.800166', '36.548132', 1);
INSERT INTO `eb_system_city` VALUES (497, 29888, 2, 26779, '130429000000', '永年县', '河北,邯郸,永年', '114.543804', '36.744120', 1);
INSERT INTO `eb_system_city` VALUES (498, 30335, 2, 26779, '130430000000', '邱县', '河北,邯郸,邱县', '115.186792', '36.811133', 1);
INSERT INTO `eb_system_city` VALUES (499, 30568, 2, 26779, '130431000000', '鸡泽县', '河北,邯郸,鸡泽', '114.878299', '36.920350', 1);
INSERT INTO `eb_system_city` VALUES (500, 30747, 2, 26779, '130432000000', '广平县', '河北,邯郸,广平', '114.948607', '36.483484', 1);
INSERT INTO `eb_system_city` VALUES (501, 30924, 2, 26779, '130433000000', '馆陶县', '河北,邯郸,馆陶', '115.282468', '36.547557', 1);
INSERT INTO `eb_system_city` VALUES (502, 31210, 2, 26779, '130434000000', '魏县', '河北,邯郸,魏县', '114.938921', '36.359869', 1);
INSERT INTO `eb_system_city` VALUES (503, 31793, 2, 26779, '130435000000', '曲周县', '河北,邯郸,曲周', '114.945113', '36.780175', 1);
INSERT INTO `eb_system_city` VALUES (504, 32146, 2, 26779, '130481000000', '武安市', '河北,邯郸,武安', '114.203697', '36.696506', 1);
INSERT INTO `eb_system_city` VALUES (505, 32689, 2, 32688, '130501000000', '市辖区', '河北,邢台', '114.504844', '37.070589', 1);
INSERT INTO `eb_system_city` VALUES (506, 32690, 2, 32688, '130502000000', '桥东区', '河北,邢台,桥东', '114.507254', '37.068017', 1);
INSERT INTO `eb_system_city` VALUES (507, 32795, 2, 32688, '130503000000', '桥西区', '河北,邢台,桥西', '114.468435', '37.059882', 1);
INSERT INTO `eb_system_city` VALUES (508, 32922, 2, 32688, '130521000000', '邢台县', '河北,邢台,邢台', '114.561132', '37.050730', 1);
INSERT INTO `eb_system_city` VALUES (509, 33459, 2, 32688, '130522000000', '临城县', '河北,邢台,临城', '114.498762', '37.444499', 1);
INSERT INTO `eb_system_city` VALUES (510, 33688, 2, 32688, '130523000000', '内丘县', '河北,邢台,内丘', '114.512128', '37.286669', 1);
INSERT INTO `eb_system_city` VALUES (511, 34011, 2, 32688, '130524000000', '柏乡县', '河北,邢台,柏乡', '114.693426', '37.482423', 1);
INSERT INTO `eb_system_city` VALUES (512, 34139, 2, 32688, '130525000000', '隆尧县', '河北,邢台,隆尧', '114.770419', '37.350173', 1);
INSERT INTO `eb_system_city` VALUES (513, 34431, 2, 32688, '130526000000', '任县', '河北,邢台,任县', '114.671936', '37.120983', 1);
INSERT INTO `eb_system_city` VALUES (514, 34635, 2, 32688, '130527000000', '南和县', '河北,邢台,南和', '114.683762', '37.005041', 1);
INSERT INTO `eb_system_city` VALUES (515, 34866, 2, 32688, '130528000000', '宁晋县', '河北,邢台,宁晋', '114.919301', '37.619886', 1);
INSERT INTO `eb_system_city` VALUES (516, 35240, 2, 32688, '130529000000', '巨鹿县', '河北,邢台,巨鹿', '115.037478', '37.221112', 1);
INSERT INTO `eb_system_city` VALUES (517, 35542, 2, 32688, '130530000000', '新河县', '河北,邢台,新河', '115.242070', '37.528719', 1);
INSERT INTO `eb_system_city` VALUES (518, 35718, 2, 32688, '130531000000', '广宗县', '河北,邢台,广宗', '115.142607', '37.074660', 1);
INSERT INTO `eb_system_city` VALUES (519, 35940, 2, 32688, '130532000000', '平乡县', '河北,邢台,平乡', '115.030076', '37.063148', 1);
INSERT INTO `eb_system_city` VALUES (520, 36202, 2, 32688, '130533000000', '威县', '河北,邢台,威县', '115.266780', '36.975377', 1);
INSERT INTO `eb_system_city` VALUES (521, 36748, 2, 32688, '130534000000', '清河县', '河北,邢台,清河', '115.667576', '37.040087', 1);
INSERT INTO `eb_system_city` VALUES (522, 37086, 2, 32688, '130535000000', '临西县', '河北,邢台,临西', '115.501048', '36.870813', 1);
INSERT INTO `eb_system_city` VALUES (523, 37403, 2, 32688, '130581000000', '南宫市', '河北,邢台,南宫', '115.408748', '37.359264', 1);
INSERT INTO `eb_system_city` VALUES (524, 37883, 2, 32688, '130582000000', '沙河市', '河北,邢台,沙河', '114.503335', '36.854922', 1);
INSERT INTO `eb_system_city` VALUES (525, 38161, 2, 38160, '130601000000', '市辖区', '河北,保定', '115.464806', '38.873891', 1);
INSERT INTO `eb_system_city` VALUES (526, 38162, 2, 38160, '130602000000', '竞秀区', '河北,保定,竞秀', '115.458669', '38.877561', 1);
INSERT INTO `eb_system_city` VALUES (527, 38327, 2, 38160, '130606000000', '莲池区', '河北,保定,莲池', '115.497342', '38.883209', 1);
INSERT INTO `eb_system_city` VALUES (528, 38578, 2, 38160, '130607000000', '满城区', '河北,保定,满城', '115.322351', '38.948955', 1);
INSERT INTO `eb_system_city` VALUES (529, 38786, 2, 38160, '130608000000', '清苑区', '河北,保定,清苑', '115.489968', '38.765041', 1);
INSERT INTO `eb_system_city` VALUES (530, 39082, 2, 38160, '130609000000', '徐水区', '河北,保定,徐水', '115.655778', '39.018737', 1);
INSERT INTO `eb_system_city` VALUES (531, 39426, 2, 38160, '130623000000', '涞水县', '河北,保定,涞水', '115.713905', '39.394317', 1);
INSERT INTO `eb_system_city` VALUES (532, 39736, 2, 38160, '130624000000', '阜平县', '河北,保定,阜平', '114.195104', '38.849152', 1);
INSERT INTO `eb_system_city` VALUES (533, 39960, 2, 38160, '130626000000', '定兴县', '河北,保定,定兴', '115.808175', '39.263018', 1);
INSERT INTO `eb_system_city` VALUES (534, 40258, 2, 38160, '130627000000', '唐县', '河北,保定,唐县', '114.982972', '38.748204', 1);
INSERT INTO `eb_system_city` VALUES (535, 40632, 2, 38160, '130628000000', '高阳县', '河北,保定,高阳', '115.778965', '38.700088', 1);
INSERT INTO `eb_system_city` VALUES (536, 40825, 2, 38160, '130629000000', '容城县', '河北,保定,容城', '115.861657', '39.042784', 1);
INSERT INTO `eb_system_city` VALUES (537, 40961, 2, 38160, '130630000000', '涞源县', '河北,保定,涞源', '114.694284', '39.360247', 1);
INSERT INTO `eb_system_city` VALUES (538, 41272, 2, 38160, '130631000000', '望都县', '河北,保定,望都', '115.154511', '38.695736', 1);
INSERT INTO `eb_system_city` VALUES (539, 41433, 2, 38160, '130632000000', '安新县', '河北,保定,安新', '115.935603', '38.935369', 1);
INSERT INTO `eb_system_city` VALUES (540, 41658, 2, 38160, '130633000000', '易县', '河北,保定,易县', '115.497457', '39.349393', 1);
INSERT INTO `eb_system_city` VALUES (541, 42155, 2, 38160, '130634000000', '曲阳县', '河北,保定,曲阳', '114.744926', '38.622244', 1);
INSERT INTO `eb_system_city` VALUES (542, 42550, 2, 38160, '130635000000', '蠡县', '河北,保定,蠡县', '115.583855', '38.488056', 1);
INSERT INTO `eb_system_city` VALUES (543, 42802, 2, 38160, '130636000000', '顺平县', '河北,保定,顺平', '115.135470', '38.837487', 1);
INSERT INTO `eb_system_city` VALUES (544, 43054, 2, 38160, '130637000000', '博野县', '河北,保定,博野', '115.464380', '38.457364', 1);
INSERT INTO `eb_system_city` VALUES (545, 43196, 2, 38160, '130638000000', '雄县', '河北,保定,雄县', '116.108650', '38.994550', 1);
INSERT INTO `eb_system_city` VALUES (546, 43441, 2, 38160, '130681000000', '涿州市', '河北,保定,涿州', '115.974422', '39.485283', 1);
INSERT INTO `eb_system_city` VALUES (547, 43905, 2, 38160, '130683000000', '安国市', '河北,保定,安国', '115.326647', '38.418440', 1);
INSERT INTO `eb_system_city` VALUES (548, 44124, 2, 38160, '130684000000', '高碑店市', '河北,保定,高碑店', '115.873758', '39.326521', 1);
INSERT INTO `eb_system_city` VALUES (549, 44571, 2, 44570, '130701000000', '市辖区', '河北,张家口', '114.887543', '40.824418', 1);
INSERT INTO `eb_system_city` VALUES (550, 44572, 2, 44570, '130702000000', '桥东区', '河北,张家口,桥东', '114.894341', '40.788457', 1);
INSERT INTO `eb_system_city` VALUES (551, 44634, 2, 44570, '130703000000', '桥西区', '河北,张家口,桥西', '114.869407', '40.819564', 1);
INSERT INTO `eb_system_city` VALUES (552, 44704, 2, 44570, '130705000000', '宣化区', '河北,张家口,宣化', '115.099510', '40.608726', 1);
INSERT INTO `eb_system_city` VALUES (553, 45133, 2, 44570, '130706000000', '下花园区', '河北,张家口,下花园', '115.287352', '40.502652', 1);
INSERT INTO `eb_system_city` VALUES (554, 45197, 2, 44570, '130708000000', '万全区', '河北,张家口,万全', '114.740560', '40.766898', 1);
INSERT INTO `eb_system_city` VALUES (555, 45395, 2, 44570, '130709000000', '崇礼区', '河北,张家口,崇礼', '115.282669', '40.974676', 1);
INSERT INTO `eb_system_city` VALUES (556, 45623, 2, 44570, '130722000000', '张北县', '河北,张家口,张北', '114.720086', '41.158557', 1);
INSERT INTO `eb_system_city` VALUES (557, 46018, 2, 44570, '130723000000', '康保县', '河北,张家口,康保', '114.600404', '41.852368', 1);
INSERT INTO `eb_system_city` VALUES (558, 46371, 2, 44570, '130724000000', '沽源县', '河北,张家口,沽源', '115.688692', '41.669668', 1);
INSERT INTO `eb_system_city` VALUES (559, 46619, 2, 44570, '130725000000', '尚义县', '河北,张家口,尚义', '113.969619', '41.076227', 1);
INSERT INTO `eb_system_city` VALUES (560, 46812, 2, 44570, '130726000000', '蔚县', '河北,张家口,蔚县', '114.588903', '39.840843', 1);
INSERT INTO `eb_system_city` VALUES (561, 47396, 2, 44570, '130727000000', '阳原县', '河北,张家口,阳原', '114.150388', '40.103742', 1);
INSERT INTO `eb_system_city` VALUES (562, 47718, 2, 44570, '130728000000', '怀安县', '河北,张家口,怀安', '114.385791', '40.674193', 1);
INSERT INTO `eb_system_city` VALUES (563, 48013, 2, 44570, '130730000000', '怀来县', '河北,张家口,怀来', '115.517862', '40.415343', 1);
INSERT INTO `eb_system_city` VALUES (564, 48331, 2, 44570, '130731000000', '涿鹿县', '河北,张家口,涿鹿', '115.205345', '40.379563', 1);
INSERT INTO `eb_system_city` VALUES (565, 48731, 2, 44570, '130732000000', '赤城县', '河北,张家口,赤城', '115.831499', '40.912921', 1);
INSERT INTO `eb_system_city` VALUES (566, 49191, 2, 49190, '130801000000', '市辖区', '河北,承德', '117.962410', '40.954071', 1);
INSERT INTO `eb_system_city` VALUES (567, 49192, 2, 49190, '130802000000', '双桥区', '河北,承德,双桥', '117.943348', '40.974650', 1);
INSERT INTO `eb_system_city` VALUES (568, 49328, 2, 49190, '130803000000', '双滦区', '河北,承德,双滦', '117.799912', '40.959196', 1);
INSERT INTO `eb_system_city` VALUES (569, 49425, 2, 49190, '130804000000', '鹰手营子矿区', '河北,承德,鹰手营子', '117.663471', '40.546436', 1);
INSERT INTO `eb_system_city` VALUES (570, 49456, 2, 49190, '130821000000', '承德县', '河北,承德,承德', '118.173825', '40.768238', 1);
INSERT INTO `eb_system_city` VALUES (571, 49866, 2, 49190, '130822000000', '兴隆县', '河北,承德,兴隆', '117.500558', '40.417358', 1);
INSERT INTO `eb_system_city` VALUES (572, 50185, 2, 49190, '130823000000', '平泉县', '河北,承德,平泉', '118.701951', '41.018405', 1);
INSERT INTO `eb_system_city` VALUES (573, 50455, 2, 49190, '130824000000', '滦平县', '河北,承德,滦平', '117.332801', '40.941482', 1);
INSERT INTO `eb_system_city` VALUES (574, 50690, 2, 49190, '130825000000', '隆化县', '河北,承德,隆化', '117.738938', '41.313791', 1);
INSERT INTO `eb_system_city` VALUES (575, 51081, 2, 49190, '130826000000', '丰宁满族自治县', '河北,承德,丰宁', '117.962410', '40.954071', 1);
INSERT INTO `eb_system_city` VALUES (576, 51428, 2, 49190, '130827000000', '宽城满族自治县', '河北,承德,宽城', '118.485313', '40.611391', 1);
INSERT INTO `eb_system_city` VALUES (577, 51657, 2, 49190, '130828000000', '围场满族蒙古族自治县', '河北,承德,围场', '117.760159', '41.938529', 1);
INSERT INTO `eb_system_city` VALUES (578, 52019, 2, 52018, '130901000000', '市辖区', '河北,沧州', '116.838834', '38.304477', 1);
INSERT INTO `eb_system_city` VALUES (579, 52020, 2, 52018, '130902000000', '新华区', '河北,沧州,新华', '116.866284', '38.314416', 1);
INSERT INTO `eb_system_city` VALUES (580, 52086, 2, 52018, '130903000000', '运河区', '河北,沧州,运河', '116.832276', '38.310143', 1);
INSERT INTO `eb_system_city` VALUES (581, 52214, 2, 52018, '130921000000', '沧县', '河北,沧州,沧县', '117.007478', '38.219856', 1);
INSERT INTO `eb_system_city` VALUES (582, 52753, 2, 52018, '130922000000', '青县', '河北,沧州,青县', '116.804306', '38.583021', 1);
INSERT INTO `eb_system_city` VALUES (583, 53128, 2, 52018, '130923000000', '东光县', '河北,沧州,东光', '116.537067', '37.888248', 1);
INSERT INTO `eb_system_city` VALUES (584, 53595, 2, 52018, '130924000000', '海兴县', '河北,沧州,海兴', '117.496606', '38.141582', 1);
INSERT INTO `eb_system_city` VALUES (585, 53810, 2, 52018, '130925000000', '盐山县', '河北,沧州,盐山', '117.230603', '38.058088', 1);
INSERT INTO `eb_system_city` VALUES (586, 54277, 2, 52018, '130926000000', '肃宁县', '河北,沧州,肃宁', '115.829758', '38.422802', 1);
INSERT INTO `eb_system_city` VALUES (587, 54547, 2, 52018, '130927000000', '南皮县', '河北,沧州,南皮', '116.708104', '38.038584', 1);
INSERT INTO `eb_system_city` VALUES (588, 54875, 2, 52018, '130928000000', '吴桥县', '河北,沧州,吴桥', '116.391508', '37.627661', 1);
INSERT INTO `eb_system_city` VALUES (589, 55369, 2, 52018, '130929000000', '献县', '河北,沧州,献县', '116.122802', '38.190144', 1);
INSERT INTO `eb_system_city` VALUES (590, 55902, 2, 52018, '130930000000', '孟村回族自治县', '河北,沧州,孟村', '117.104298', '38.053409', 1);
INSERT INTO `eb_system_city` VALUES (591, 56037, 2, 52018, '130981000000', '泊头市', '河北,沧州,泊头', '116.578368', '38.083437', 1);
INSERT INTO `eb_system_city` VALUES (592, 56764, 2, 52018, '130982000000', '任丘市', '河北,沧州,任丘', '116.082918', '38.683592', 1);
INSERT INTO `eb_system_city` VALUES (593, 57238, 2, 52018, '130983000000', '黄骅市', '河北,沧州,黄骅', '117.330048', '38.371383', 1);
INSERT INTO `eb_system_city` VALUES (594, 57596, 2, 52018, '130984000000', '河间市', '河北,沧州,河间', '116.099518', '38.446624', 1);
INSERT INTO `eb_system_city` VALUES (595, 58248, 2, 58247, '131001000000', '市辖区', '河北,廊坊', '116.683752', '39.538047', 1);
INSERT INTO `eb_system_city` VALUES (596, 58249, 2, 58247, '131002000000', '安次区', '河北,廊坊,安次', '116.694544', '39.502569', 1);
INSERT INTO `eb_system_city` VALUES (597, 58567, 2, 58247, '131003000000', '广阳区', '河北,廊坊,广阳', '116.710690', '39.522786', 1);
INSERT INTO `eb_system_city` VALUES (598, 58789, 2, 58247, '131022000000', '固安县', '河北,廊坊,固安', '116.298657', '39.438214', 1);
INSERT INTO `eb_system_city` VALUES (599, 59228, 2, 58247, '131023000000', '永清县', '河北,廊坊,永清', '116.499028', '39.321794', 1);
INSERT INTO `eb_system_city` VALUES (600, 59639, 2, 58247, '131024000000', '香河县', '河北,廊坊,香河', '117.006093', '39.761424', 1);
INSERT INTO `eb_system_city` VALUES (601, 59963, 2, 58247, '131025000000', '大城县', '河北,廊坊,大城', '116.653794', '38.705449', 1);
INSERT INTO `eb_system_city` VALUES (602, 60378, 2, 58247, '131026000000', '文安县', '河北,廊坊,文安', '116.457858', '38.873281', 1);
INSERT INTO `eb_system_city` VALUES (603, 60784, 2, 58247, '131028000000', '大厂回族自治县', '河北,廊坊,大厂', '116.970154', '39.897785', 1);
INSERT INTO `eb_system_city` VALUES (604, 60904, 2, 58247, '131081000000', '霸州市', '河北,廊坊,霸州', '116.391386', '39.125898', 1);
INSERT INTO `eb_system_city` VALUES (605, 61311, 2, 58247, '131082000000', '三河市', '河北,廊坊,三河', '117.078295', '39.982718', 1);
INSERT INTO `eb_system_city` VALUES (606, 61805, 2, 61804, '131101000000', '市辖区', '河北,衡水', '115.670177', '37.738920', 1);
INSERT INTO `eb_system_city` VALUES (607, 61806, 2, 61804, '131102000000', '桃城区', '河北,衡水,桃城', '115.675422', '37.735369', 1);
INSERT INTO `eb_system_city` VALUES (608, 62086, 2, 61804, '131103000000', '冀州区', '河北,衡水,冀州', '115.670177', '37.738920', 1);
INSERT INTO `eb_system_city` VALUES (609, 62479, 2, 61804, '131121000000', '枣强县', '河北,衡水,枣强', '115.724260', '37.513417', 1);
INSERT INTO `eb_system_city` VALUES (610, 63050, 2, 61804, '131122000000', '武邑县', '河北,衡水,武邑', '115.887655', '37.801658', 1);
INSERT INTO `eb_system_city` VALUES (611, 63584, 2, 61804, '131123000000', '武强县', '河北,衡水,武强', '115.982461', '38.041368', 1);
INSERT INTO `eb_system_city` VALUES (612, 63832, 2, 61804, '131124000000', '饶阳县', '河北,衡水,饶阳', '115.725833', '38.235892', 1);
INSERT INTO `eb_system_city` VALUES (613, 64040, 2, 61804, '131125000000', '安平县', '河北,衡水,安平', '115.519216', '38.234510', 1);
INSERT INTO `eb_system_city` VALUES (614, 64281, 2, 61804, '131126000000', '故城县', '河北,衡水,故城', '115.965874', '37.347410', 1);
INSERT INTO `eb_system_city` VALUES (615, 64833, 2, 61804, '131127000000', '景县', '河北,衡水,景县', '116.270648', '37.692290', 1);
INSERT INTO `eb_system_city` VALUES (616, 65702, 2, 61804, '131128000000', '阜城县', '河北,衡水,阜城', '116.144418', '37.868872', 1);
INSERT INTO `eb_system_city` VALUES (617, 66323, 2, 61804, '131182000000', '深州市', '河北,衡水,深州', '115.559574', '38.001536', 1);
INSERT INTO `eb_system_city` VALUES (618, 66814, 2, 66813, '139001000000', '定州市', '河北,定州', '114.990159', '38.516174', 1);
INSERT INTO `eb_system_city` VALUES (619, 67371, 2, 66813, '139002000000', '辛集市', '河北,辛集', '115.218057', '37.943315', 1);
INSERT INTO `eb_system_city` VALUES (620, 67749, 2, 67748, '140101000000', '市辖区', '山西,太原', '112.548879', '37.870590', 1);
INSERT INTO `eb_system_city` VALUES (621, 67750, 2, 67748, '140105000000', '小店区', '山西,太原,小店', '112.565659', '37.736526', 1);
INSERT INTO `eb_system_city` VALUES (622, 67921, 2, 67748, '140106000000', '迎泽区', '山西,太原,迎泽', '112.563400', '37.863451', 1);
INSERT INTO `eb_system_city` VALUES (623, 68043, 2, 67748, '140107000000', '杏花岭区', '山西,太原,杏花岭', '112.570605', '37.893955', 1);
INSERT INTO `eb_system_city` VALUES (624, 68203, 2, 67748, '140108000000', '尖草坪区', '山西,太原,尖草坪', '112.486691', '37.940387', 1);
INSERT INTO `eb_system_city` VALUES (625, 68368, 2, 67748, '140109000000', '万柏林区', '山西,太原,万柏林', '112.515748', '37.859447', 1);
INSERT INTO `eb_system_city` VALUES (626, 68542, 2, 67748, '140110000000', '晋源区', '山西,太原,晋源', '112.477940', '37.715193', 1);
INSERT INTO `eb_system_city` VALUES (627, 68671, 2, 67748, '140121000000', '清徐县', '山西,太原,清徐', '112.358667', '37.607443', 1);
INSERT INTO `eb_system_city` VALUES (628, 68893, 2, 67748, '140122000000', '阳曲县', '山西,太原,阳曲', '112.672953', '38.058489', 1);
INSERT INTO `eb_system_city` VALUES (629, 69032, 2, 67748, '140123000000', '娄烦县', '山西,太原,娄烦', '111.797083', '38.067932', 1);
INSERT INTO `eb_system_city` VALUES (630, 69190, 2, 67748, '140181000000', '古交市', '山西,太原,古交', '112.175875', '37.907109', 1);
INSERT INTO `eb_system_city` VALUES (631, 69391, 2, 69390, '140201000000', '市辖区', '山西,大同', '113.612440', '40.040295', 1);
INSERT INTO `eb_system_city` VALUES (632, 69392, 2, 69390, '140202000000', '城区', '山西,大同,城区', '113.298027', '40.075667', 1);
INSERT INTO `eb_system_city` VALUES (633, 69546, 2, 69390, '140203000000', '矿区', '山西,大同,矿区', '113.612440', '40.040295', 1);
INSERT INTO `eb_system_city` VALUES (634, 69691, 2, 69390, '140211000000', '南郊区', '山西,大同,南郊', '113.149693', '40.005405', 1);
INSERT INTO `eb_system_city` VALUES (635, 69891, 2, 69390, '140212000000', '新荣区', '山西,大同,新荣', '113.140005', '40.255866', 1);
INSERT INTO `eb_system_city` VALUES (636, 70045, 2, 69390, '140221000000', '阳高县', '山西,大同,阳高', '113.748945', '40.361060', 1);
INSERT INTO `eb_system_city` VALUES (637, 70336, 2, 69390, '140222000000', '天镇县', '山西,大同,天镇', '114.090867', '40.420237', 1);
INSERT INTO `eb_system_city` VALUES (638, 70582, 2, 69390, '140223000000', '广灵县', '山西,大同,广灵', '114.282758', '39.760281', 1);
INSERT INTO `eb_system_city` VALUES (639, 70778, 2, 69390, '140224000000', '灵丘县', '山西,大同,灵丘', '114.234350', '39.442406', 1);
INSERT INTO `eb_system_city` VALUES (640, 71059, 2, 69390, '140225000000', '浑源县', '山西,大同,浑源', '113.699475', '39.693407', 1);
INSERT INTO `eb_system_city` VALUES (641, 71402, 2, 69390, '140226000000', '左云县', '山西,大同,左云', '112.703008', '40.013442', 1);
INSERT INTO `eb_system_city` VALUES (642, 71649, 2, 69390, '140227000000', '大同县', '山西,大同,大同', '113.397170', '40.067276', 1);
INSERT INTO `eb_system_city` VALUES (643, 71851, 2, 71850, '140301000000', '市辖区', '山西,阳泉', '113.580519', '37.856971', 1);
INSERT INTO `eb_system_city` VALUES (644, 71852, 2, 71850, '140302000000', '城区', '山西,阳泉,城区', '113.600670', '37.847437', 1);
INSERT INTO `eb_system_city` VALUES (645, 71905, 2, 71850, '140303000000', '矿区', '山西,阳泉,矿区', '113.580519', '37.856971', 1);
INSERT INTO `eb_system_city` VALUES (646, 71950, 2, 71850, '140311000000', '郊区', '山西,阳泉,郊区', '113.594164', '37.944679', 1);
INSERT INTO `eb_system_city` VALUES (647, 72145, 2, 71850, '140321000000', '平定县', '山西,阳泉,平定', '113.657841', '37.786653', 1);
INSERT INTO `eb_system_city` VALUES (648, 72497, 2, 71850, '140322000000', '盂县', '山西,阳泉,盂县', '113.412330', '38.085619', 1);
INSERT INTO `eb_system_city` VALUES (649, 72976, 2, 72975, '140401000000', '市辖区', '山西,长治', '113.116255', '36.195386', 1);
INSERT INTO `eb_system_city` VALUES (650, 72977, 2, 72975, '140402000000', '城区', '山西,长治,城区', '113.123085', '36.203519', 1);
INSERT INTO `eb_system_city` VALUES (651, 73071, 2, 72975, '140411000000', '郊区', '山西,长治,郊区', '113.101211', '36.218388', 1);
INSERT INTO `eb_system_city` VALUES (652, 73222, 2, 72975, '140421000000', '长治县', '山西,长治,长治', '113.051407', '36.052858', 1);
INSERT INTO `eb_system_city` VALUES (653, 73495, 2, 72975, '140423000000', '襄垣县', '山西,长治,襄垣', '113.051491', '36.535817', 1);
INSERT INTO `eb_system_city` VALUES (654, 73840, 2, 72975, '140424000000', '屯留县', '山西,长治,屯留', '112.892151', '36.315929', 1);
INSERT INTO `eb_system_city` VALUES (655, 74151, 2, 72975, '140425000000', '平顺县', '山西,长治,平顺', '113.435961', '36.200179', 1);
INSERT INTO `eb_system_city` VALUES (656, 74429, 2, 72975, '140426000000', '黎城县', '山西,长治,黎城', '113.387155', '36.502328', 1);
INSERT INTO `eb_system_city` VALUES (657, 74694, 2, 72975, '140427000000', '壶关县', '山西,长治,壶关', '113.207049', '36.115449', 1);
INSERT INTO `eb_system_city` VALUES (658, 75101, 2, 72975, '140428000000', '长子县', '山西,长治,长子', '112.877900', '36.122334', 1);
INSERT INTO `eb_system_city` VALUES (659, 75515, 2, 72975, '140429000000', '武乡县', '山西,长治,武乡', '112.864562', '36.837625', 1);
INSERT INTO `eb_system_city` VALUES (660, 75911, 2, 72975, '140430000000', '沁县', '山西,长治,沁县', '112.699226', '36.756064', 1);
INSERT INTO `eb_system_city` VALUES (661, 76237, 2, 72975, '140431000000', '沁源县', '山西,长治,沁源', '112.337446', '36.500200', 1);
INSERT INTO `eb_system_city` VALUES (662, 76512, 2, 72975, '140481000000', '潞城市', '山西,长治,潞城', '113.228852', '36.334104', 1);
INSERT INTO `eb_system_city` VALUES (663, 76727, 2, 76726, '140501000000', '市辖区', '山西,晋城', '112.851831', '35.490701', 1);
INSERT INTO `eb_system_city` VALUES (664, 76728, 2, 76726, '140502000000', '城区', '山西,晋城,城区', '112.853555', '35.501572', 1);
INSERT INTO `eb_system_city` VALUES (665, 76874, 2, 76726, '140521000000', '沁水县', '山西,晋城,沁水', '112.186739', '35.690141', 1);
INSERT INTO `eb_system_city` VALUES (666, 77140, 2, 76726, '140522000000', '阳城县', '山西,晋城,阳城', '112.414738', '35.486029', 1);
INSERT INTO `eb_system_city` VALUES (667, 77632, 2, 76726, '140524000000', '陵川县', '山西,晋城,陵川', '113.280688', '35.775685', 1);
INSERT INTO `eb_system_city` VALUES (668, 78024, 2, 76726, '140525000000', '泽州县', '山西,晋城,泽州', '112.899137', '35.617221', 1);
INSERT INTO `eb_system_city` VALUES (669, 78678, 2, 76726, '140581000000', '高平市', '山西,晋城,高平', '112.923920', '35.797997', 1);
INSERT INTO `eb_system_city` VALUES (670, 79164, 2, 79163, '140601000000', '市辖区', '山西,朔州', '112.432825', '39.331595', 1);
INSERT INTO `eb_system_city` VALUES (671, 79165, 2, 79163, '140602000000', '朔城区', '山西,朔州,朔城', '112.432250', '39.318940', 1);
INSERT INTO `eb_system_city` VALUES (672, 79533, 2, 79163, '140603000000', '平鲁区', '山西,朔州,平鲁', '112.288331', '39.512155', 1);
INSERT INTO `eb_system_city` VALUES (673, 79843, 2, 79163, '140621000000', '山阴县', '山西,朔州,山阴', '112.816600', '39.526227', 1);
INSERT INTO `eb_system_city` VALUES (674, 80134, 2, 79163, '140622000000', '应县', '山西,朔州,应县', '113.191099', '39.554247', 1);
INSERT INTO `eb_system_city` VALUES (675, 80454, 2, 79163, '140623000000', '右玉县', '山西,朔州,右玉', '112.466989', '39.989064', 1);
INSERT INTO `eb_system_city` VALUES (676, 80799, 2, 79163, '140624000000', '怀仁县', '山西,朔州,怀仁', '113.099958', '39.827916', 1);
INSERT INTO `eb_system_city` VALUES (677, 81001, 2, 81000, '140701000000', '市辖区', '山西,晋中', '112.752694', '37.687024', 1);
INSERT INTO `eb_system_city` VALUES (678, 81002, 2, 81000, '140702000000', '榆次区', '山西,晋中,榆次', '112.708241', '37.697792', 1);
INSERT INTO `eb_system_city` VALUES (679, 81361, 2, 81000, '140721000000', '榆社县', '山西,晋中,榆社', '112.975287', '37.070788', 1);
INSERT INTO `eb_system_city` VALUES (680, 81649, 2, 81000, '140722000000', '左权县', '山西,晋中,左权', '113.379372', '37.082681', 1);
INSERT INTO `eb_system_city` VALUES (681, 81872, 2, 81000, '140723000000', '和顺县', '山西,晋中,和顺', '113.570438', '37.329664', 1);
INSERT INTO `eb_system_city` VALUES (682, 82183, 2, 81000, '140724000000', '昔阳县', '山西,晋中,昔阳', '113.706875', '37.611210', 1);
INSERT INTO `eb_system_city` VALUES (683, 82535, 2, 81000, '140725000000', '寿阳县', '山西,晋中,寿阳', '113.176434', '37.895325', 1);
INSERT INTO `eb_system_city` VALUES (684, 82765, 2, 81000, '140726000000', '太谷县', '山西,晋中,太谷', '112.551357', '37.421308', 1);
INSERT INTO `eb_system_city` VALUES (685, 82986, 2, 81000, '140727000000', '祁县', '山西,晋中,祁县', '112.335297', '37.358317', 1);
INSERT INTO `eb_system_city` VALUES (686, 83165, 2, 81000, '140728000000', '平遥县', '山西,晋中,平遥', '112.176273', '37.189559', 1);
INSERT INTO `eb_system_city` VALUES (687, 83472, 2, 81000, '140729000000', '灵石县', '山西,晋中,灵石', '111.778685', '36.847860', 1);
INSERT INTO `eb_system_city` VALUES (688, 83810, 2, 81000, '140781000000', '介休市', '山西,晋中,介休', '111.916712', '37.026945', 1);
INSERT INTO `eb_system_city` VALUES (689, 84093, 2, 84092, '140801000000', '市辖区', '山西,运城', '111.007528', '35.026412', 1);
INSERT INTO `eb_system_city` VALUES (690, 84094, 2, 84092, '140802000000', '盐湖区', '山西,运城,盐湖', '111.007528', '35.026412', 1);
INSERT INTO `eb_system_city` VALUES (691, 84483, 2, 84092, '140821000000', '临猗县', '山西,运城,临猗', '110.774547', '35.144277', 1);
INSERT INTO `eb_system_city` VALUES (692, 84893, 2, 84092, '140822000000', '万荣县', '山西,运城,万荣', '110.838024', '35.415254', 1);
INSERT INTO `eb_system_city` VALUES (693, 85194, 2, 84092, '140823000000', '闻喜县', '山西,运城,闻喜', '111.224720', '35.356644', 1);
INSERT INTO `eb_system_city` VALUES (694, 85569, 2, 84092, '140824000000', '稷山县', '山西,运城,稷山', '110.983333', '35.604025', 1);
INSERT INTO `eb_system_city` VALUES (695, 85780, 2, 84092, '140825000000', '新绛县', '山西,运城,新绛', '111.224778', '35.616288', 1);
INSERT INTO `eb_system_city` VALUES (696, 86023, 2, 84092, '140826000000', '绛县', '山西,运城,绛县', '111.568236', '35.491190', 1);
INSERT INTO `eb_system_city` VALUES (697, 86238, 2, 84092, '140827000000', '垣曲县', '山西,运城,垣曲', '111.669917', '35.297620', 1);
INSERT INTO `eb_system_city` VALUES (698, 86448, 2, 84092, '140828000000', '夏县', '山西,运城,夏县', '111.220456', '35.141363', 1);
INSERT INTO `eb_system_city` VALUES (699, 86706, 2, 84092, '140829000000', '平陆县', '山西,运城,平陆', '111.194133', '34.829260', 1);
INSERT INTO `eb_system_city` VALUES (700, 86949, 2, 84092, '140830000000', '芮城县', '山西,运城,芮城', '110.694369', '34.693580', 1);
INSERT INTO `eb_system_city` VALUES (701, 87129, 2, 84092, '140881000000', '永济市', '山西,运城,永济', '110.447549', '34.867050', 1);
INSERT INTO `eb_system_city` VALUES (702, 87434, 2, 84092, '140882000000', '河津市', '山西,运城,河津', '110.712063', '35.596383', 1);
INSERT INTO `eb_system_city` VALUES (703, 87614, 2, 87613, '140901000000', '市辖区', '山西,忻州', '112.734174', '38.416663', 1);
INSERT INTO `eb_system_city` VALUES (704, 87615, 2, 87613, '140902000000', '忻府区', '山西,忻州,忻府', '112.746046', '38.404243', 1);
INSERT INTO `eb_system_city` VALUES (705, 88061, 2, 87613, '140921000000', '定襄县', '山西,忻州,定襄', '112.957215', '38.473548', 1);
INSERT INTO `eb_system_city` VALUES (706, 88227, 2, 87613, '140922000000', '五台县', '山西,忻州,五台', '113.255309', '38.728315', 1);
INSERT INTO `eb_system_city` VALUES (707, 88754, 2, 87613, '140923000000', '代县', '山西,忻州,代县', '112.960282', '39.066917', 1);
INSERT INTO `eb_system_city` VALUES (708, 89144, 2, 87613, '140924000000', '繁峙县', '山西,忻州,繁峙', '113.265564', '39.188811', 1);
INSERT INTO `eb_system_city` VALUES (709, 89570, 2, 87613, '140925000000', '宁武县', '山西,忻州,宁武', '112.304722', '39.001524', 1);
INSERT INTO `eb_system_city` VALUES (710, 90066, 2, 87613, '140926000000', '静乐县', '山西,忻州,静乐', '111.939440', '38.359036', 1);
INSERT INTO `eb_system_city` VALUES (711, 90462, 2, 87613, '140927000000', '神池县', '山西,忻州,神池', '112.211297', '39.090553', 1);
INSERT INTO `eb_system_city` VALUES (712, 90715, 2, 87613, '140928000000', '五寨县', '山西,忻州,五寨', '111.846905', '38.910726', 1);
INSERT INTO `eb_system_city` VALUES (713, 90978, 2, 87613, '140929000000', '岢岚县', '山西,忻州,岢岚', '111.572850', '38.704180', 1);
INSERT INTO `eb_system_city` VALUES (714, 91193, 2, 87613, '140930000000', '河曲县', '山西,忻州,河曲', '111.138472', '39.384482', 1);
INSERT INTO `eb_system_city` VALUES (715, 91548, 2, 87613, '140931000000', '保德县', '山西,忻州,保德', '111.086564', '39.022488', 1);
INSERT INTO `eb_system_city` VALUES (716, 91912, 2, 87613, '140932000000', '偏关县', '山西,忻州,偏关', '111.508831', '39.436306', 1);
INSERT INTO `eb_system_city` VALUES (717, 92172, 2, 87613, '140981000000', '原平市', '山西,忻州,原平', '112.711059', '38.731402', 1);
INSERT INTO `eb_system_city` VALUES (718, 92739, 2, 92738, '141001000000', '市辖区', '山西,临汾', '111.518976', '36.088005', 1);
INSERT INTO `eb_system_city` VALUES (719, 92740, 2, 92738, '141002000000', '尧都区', '山西,临汾,尧都', '111.579554', '36.078841', 1);
INSERT INTO `eb_system_city` VALUES (720, 93208, 2, 92738, '141021000000', '曲沃县', '山西,临汾,曲沃', '111.475861', '35.641087', 1);
INSERT INTO `eb_system_city` VALUES (721, 93375, 2, 92738, '141022000000', '翼城县', '山西,临汾,翼城', '111.718951', '35.738576', 1);
INSERT INTO `eb_system_city` VALUES (722, 93604, 2, 92738, '141023000000', '襄汾县', '山西,临汾,襄汾', '111.441725', '35.876293', 1);
INSERT INTO `eb_system_city` VALUES (723, 93972, 2, 92738, '141024000000', '洪洞县', '山西,临汾,洪洞', '111.674966', '36.253748', 1);
INSERT INTO `eb_system_city` VALUES (724, 94457, 2, 92738, '141025000000', '古县', '山西,临汾,古县', '111.920466', '36.266914', 1);
INSERT INTO `eb_system_city` VALUES (725, 94580, 2, 92738, '141026000000', '安泽县', '山西,临汾,安泽', '112.250144', '36.147787', 1);
INSERT INTO `eb_system_city` VALUES (726, 94696, 2, 92738, '141027000000', '浮山县', '山西,临汾,浮山', '111.848883', '35.968124', 1);
INSERT INTO `eb_system_city` VALUES (727, 94893, 2, 92738, '141028000000', '吉县', '山西,临汾,吉县', '110.681763', '36.098188', 1);
INSERT INTO `eb_system_city` VALUES (728, 94981, 2, 92738, '141029000000', '乡宁县', '山西,临汾,乡宁', '110.847021', '35.970389', 1);
INSERT INTO `eb_system_city` VALUES (729, 95181, 2, 92738, '141030000000', '大宁县', '山西,临汾,大宁', '110.752903', '36.465133', 1);
INSERT INTO `eb_system_city` VALUES (730, 95272, 2, 92738, '141031000000', '隰县', '山西,临汾,隰县', '110.940638', '36.693331', 1);
INSERT INTO `eb_system_city` VALUES (731, 95381, 2, 92738, '141032000000', '永和县', '山西,临汾,永和', '110.632007', '36.759507', 1);
INSERT INTO `eb_system_city` VALUES (732, 95472, 2, 92738, '141033000000', '蒲县', '山西,临汾,蒲县', '111.096439', '36.411827', 1);
INSERT INTO `eb_system_city` VALUES (733, 95579, 2, 92738, '141034000000', '汾西县', '山西,临汾,汾西', '111.563951', '36.652854', 1);
INSERT INTO `eb_system_city` VALUES (734, 95715, 2, 92738, '141081000000', '侯马市', '山西,临汾,侯马', '111.372002', '35.619105', 1);
INSERT INTO `eb_system_city` VALUES (735, 95828, 2, 92738, '141082000000', '霍州市', '山西,临汾,霍州', '111.755398', '36.568931', 1);
INSERT INTO `eb_system_city` VALUES (736, 96065, 2, 96064, '141101000000', '市辖区', '山西,吕梁', '111.144319', '37.518314', 1);
INSERT INTO `eb_system_city` VALUES (737, 96066, 2, 96064, '141102000000', '离石区', '山西,吕梁,离石', '111.150733', '37.517641', 1);
INSERT INTO `eb_system_city` VALUES (738, 96332, 2, 96064, '141121000000', '文水县', '山西,吕梁,文水', '112.028866', '37.438102', 1);
INSERT INTO `eb_system_city` VALUES (739, 96548, 2, 96064, '141122000000', '交城县', '山西,吕梁,交城', '112.155841', '37.551970', 1);
INSERT INTO `eb_system_city` VALUES (740, 96711, 2, 96064, '141123000000', '兴县', '山西,吕梁,兴县', '111.127668', '38.462390', 1);
INSERT INTO `eb_system_city` VALUES (741, 97113, 2, 96064, '141124000000', '临县', '山西,吕梁,临县', '110.992094', '37.950758', 1);
INSERT INTO `eb_system_city` VALUES (742, 97779, 2, 96064, '141125000000', '柳林县', '山西,吕梁,柳林', '110.889071', '37.429832', 1);
INSERT INTO `eb_system_city` VALUES (743, 98056, 2, 96064, '141126000000', '石楼县', '山西,吕梁,石楼', '110.834561', '36.997412', 1);
INSERT INTO `eb_system_city` VALUES (744, 98201, 2, 96064, '141127000000', '岚县', '山西,吕梁,岚县', '111.671917', '38.279299', 1);
INSERT INTO `eb_system_city` VALUES (745, 98383, 2, 96064, '141128000000', '方山县', '山西,吕梁,方山', '111.244098', '37.894631', 1);
INSERT INTO `eb_system_city` VALUES (746, 98562, 2, 96064, '141129000000', '中阳县', '山西,吕梁,中阳', '111.179657', '37.357058', 1);
INSERT INTO `eb_system_city` VALUES (747, 98670, 2, 96064, '141130000000', '交口县', '山西,吕梁,交口', '111.181151', '36.982186', 1);
INSERT INTO `eb_system_city` VALUES (748, 98774, 2, 96064, '141181000000', '孝义市', '山西,吕梁,孝义', '111.778818', '37.146294', 1);
INSERT INTO `eb_system_city` VALUES (749, 99219, 2, 96064, '141182000000', '汾阳市', '山西,吕梁,汾阳', '111.769894', '37.261564', 1);
INSERT INTO `eb_system_city` VALUES (750, 99539, 2, 99538, '150101000000', '市辖区', '内蒙古,呼和浩特', '111.749180', '40.842585', 1);
INSERT INTO `eb_system_city` VALUES (751, 99540, 2, 99538, '150102000000', '新城区', '内蒙古,呼和浩特,新城', '111.665544', '40.858289', 1);
INSERT INTO `eb_system_city` VALUES (752, 99624, 2, 99538, '150103000000', '回民区', '内蒙古,呼和浩特,回民', '111.623692', '40.808608', 1);
INSERT INTO `eb_system_city` VALUES (753, 99696, 2, 99538, '150104000000', '玉泉区', '内蒙古,呼和浩特,玉泉', '111.673881', '40.753655', 1);
INSERT INTO `eb_system_city` VALUES (754, 99807, 2, 99538, '150105000000', '赛罕区', '内蒙古,呼和浩特,赛罕', '111.701857', '40.792097', 1);
INSERT INTO `eb_system_city` VALUES (755, 100011, 2, 99538, '150121000000', '土默特左旗', '内蒙古,呼和浩特,土默特左旗', '111.163902', '40.729573', 1);
INSERT INTO `eb_system_city` VALUES (756, 100358, 2, 99538, '150122000000', '托克托县', '内蒙古,呼和浩特,托克托', '111.194313', '40.277431', 1);
INSERT INTO `eb_system_city` VALUES (757, 100502, 2, 99538, '150123000000', '和林格尔县', '内蒙古,呼和浩特,和林格尔', '111.821843', '40.378787', 1);
INSERT INTO `eb_system_city` VALUES (758, 100672, 2, 99538, '150124000000', '清水河县', '内蒙古,呼和浩特,清水河', '111.647609', '39.921095', 1);
INSERT INTO `eb_system_city` VALUES (759, 100790, 2, 99538, '150125000000', '武川县', '内蒙古,呼和浩特,武川', '111.451303', '41.096471', 1);
INSERT INTO `eb_system_city` VALUES (760, 100905, 2, 100904, '150201000000', '市辖区', '内蒙古,包头', '109.840347', '40.657449', 1);
INSERT INTO `eb_system_city` VALUES (761, 100906, 2, 100904, '150202000000', '东河区', '内蒙古,包头,东河', '110.044142', '40.575948', 1);
INSERT INTO `eb_system_city` VALUES (762, 101033, 2, 100904, '150203000000', '昆都仑区', '内蒙古,包头,昆都仑', '109.838178', '40.642236', 1);
INSERT INTO `eb_system_city` VALUES (763, 101148, 2, 100904, '150204000000', '青山区', '内蒙古,包头,青山', '109.901572', '40.643246', 1);
INSERT INTO `eb_system_city` VALUES (764, 101235, 2, 100904, '150205000000', '石拐区', '内蒙古,包头,石拐', '110.060686', '40.676645', 1);
INSERT INTO `eb_system_city` VALUES (765, 101268, 2, 100904, '150206000000', '白云鄂博矿区', '内蒙古,包头,白云鄂博', '109.840347', '40.657449', 1);
INSERT INTO `eb_system_city` VALUES (766, 101275, 2, 100904, '150207000000', '九原区', '内蒙古,包头,九原', '109.968122', '40.600581', 1);
INSERT INTO `eb_system_city` VALUES (767, 101359, 2, 100904, '150221000000', '土默特右旗', '内蒙古,包头,土默特右旗', '110.524263', '40.569426', 1);
INSERT INTO `eb_system_city` VALUES (768, 101583, 2, 100904, '150222000000', '固阳县', '内蒙古,包头,固阳', '110.060514', '41.034106', 1);
INSERT INTO `eb_system_city` VALUES (769, 101673, 2, 100904, '150223000000', '达尔罕茂明安联合旗', '内蒙古,包头,达尔罕茂明安联合旗', '110.432626', '41.698992', 1);
INSERT INTO `eb_system_city` VALUES (770, 101773, 2, 101772, '150301000000', '市辖区', '内蒙古,乌海', '106.794249', '39.655388', 1);
INSERT INTO `eb_system_city` VALUES (771, 101774, 2, 101772, '150302000000', '海勃湾区', '内蒙古,乌海,海勃湾', '106.822779', '39.691156', 1);
INSERT INTO `eb_system_city` VALUES (772, 101824, 2, 101772, '150303000000', '海南区', '内蒙古,乌海,海南', '106.891424', '39.441364', 1);
INSERT INTO `eb_system_city` VALUES (773, 101850, 2, 101772, '150304000000', '乌达区', '内蒙古,乌海,乌达', '106.726099', '39.505925', 1);
INSERT INTO `eb_system_city` VALUES (774, 101885, 2, 101884, '150401000000', '市辖区', '内蒙古,赤峰', '118.886856', '42.257817', 1);
INSERT INTO `eb_system_city` VALUES (775, 101886, 2, 101884, '150402000000', '红山区', '内蒙古,赤峰,红山', '118.955528', '42.295818', 1);
INSERT INTO `eb_system_city` VALUES (776, 101986, 2, 101884, '150403000000', '元宝山区', '内蒙古,赤峰,元宝山', '119.288611', '42.038902', 1);
INSERT INTO `eb_system_city` VALUES (777, 102110, 2, 101884, '150404000000', '松山区', '内蒙古,赤峰,松山', '118.931962', '42.286873', 1);
INSERT INTO `eb_system_city` VALUES (778, 102434, 2, 101884, '150421000000', '阿鲁科尔沁旗', '内蒙古,赤峰,阿鲁科尔沁旗', '120.065700', '43.872299', 1);
INSERT INTO `eb_system_city` VALUES (779, 102714, 2, 101884, '150422000000', '巴林左旗', '内蒙古,赤峰,巴林左旗', '119.379490', '43.971126', 1);
INSERT INTO `eb_system_city` VALUES (780, 102913, 2, 101884, '150423000000', '巴林右旗', '内蒙古,赤峰,巴林右旗', '118.665180', '43.534414', 1);
INSERT INTO `eb_system_city` VALUES (781, 103097, 2, 101884, '150424000000', '林西县', '内蒙古,赤峰,林西', '118.055450', '43.618120', 1);
INSERT INTO `eb_system_city` VALUES (782, 103225, 2, 101884, '150425000000', '克什克腾旗', '内蒙古,赤峰,克什克腾旗', '117.545798', '43.264989', 1);
INSERT INTO `eb_system_city` VALUES (783, 103385, 2, 101884, '150426000000', '翁牛特旗', '内蒙古,赤峰,翁牛特旗', '119.006580', '42.936188', 1);
INSERT INTO `eb_system_city` VALUES (784, 103647, 2, 101884, '150428000000', '喀喇沁旗', '内蒙古,赤峰,喀喇沁旗', '118.701938', '41.927364', 1);
INSERT INTO `eb_system_city` VALUES (785, 103835, 2, 101884, '150429000000', '宁城县', '内蒙古,赤峰,宁城', '119.318876', '41.601375', 1);
INSERT INTO `eb_system_city` VALUES (786, 104189, 2, 101884, '150430000000', '敖汉旗', '内蒙古,赤峰,敖汉旗', '119.921604', '42.290782', 1);
INSERT INTO `eb_system_city` VALUES (787, 104458, 2, 104457, '150501000000', '市辖区', '内蒙古,通辽', '122.243444', '43.652890', 1);
INSERT INTO `eb_system_city` VALUES (788, 104459, 2, 104457, '150502000000', '科尔沁区', '内蒙古,通辽,科尔沁', '122.255675', '43.623077', 1);
INSERT INTO `eb_system_city` VALUES (789, 104954, 2, 104457, '150521000000', '科尔沁左翼中旗', '内蒙古,通辽,科尔沁左翼中旗', '123.312265', '44.126626', 1);
INSERT INTO `eb_system_city` VALUES (790, 105531, 2, 104457, '150522000000', '科尔沁左翼后旗', '内蒙古,通辽,科尔沁左翼后旗', '122.356749', '42.935159', 1);
INSERT INTO `eb_system_city` VALUES (791, 105865, 2, 104457, '150523000000', '开鲁县', '内蒙古,通辽,开鲁', '121.319309', '43.601244', 1);
INSERT INTO `eb_system_city` VALUES (792, 106150, 2, 104457, '150524000000', '库伦旗', '内蒙古,通辽,库伦旗', '121.810701', '42.735657', 1);
INSERT INTO `eb_system_city` VALUES (793, 106356, 2, 104457, '150525000000', '奈曼旗', '内蒙古,通辽,奈曼旗', '120.658283', '42.867226', 1);
INSERT INTO `eb_system_city` VALUES (794, 106746, 2, 104457, '150526000000', '扎鲁特旗', '内蒙古,通辽,扎鲁特旗', '120.911676', '44.556389', 1);
INSERT INTO `eb_system_city` VALUES (795, 107028, 2, 104457, '150581000000', '霍林郭勒市', '内蒙古,通辽,霍林郭勒', '119.663534', '45.531726', 1);
INSERT INTO `eb_system_city` VALUES (796, 107066, 2, 107065, '150601000000', '市辖区', '内蒙古,鄂尔多斯', '109.781327', '39.608266', 1);
INSERT INTO `eb_system_city` VALUES (797, 107067, 2, 107065, '150602000000', '东胜区', '内蒙古,鄂尔多斯,东胜', '109.963339', '39.822507', 1);
INSERT INTO `eb_system_city` VALUES (798, 107193, 2, 107065, '150603000000', '康巴什区', '内蒙古,鄂尔多斯,康巴什', '109.999325', '39.809941', 1);
INSERT INTO `eb_system_city` VALUES (799, 107213, 2, 107065, '150621000000', '达拉特旗', '内蒙古,鄂尔多斯,达拉特旗', '110.033833', '40.412438', 1);
INSERT INTO `eb_system_city` VALUES (800, 107388, 2, 107065, '150622000000', '准格尔旗', '内蒙古,鄂尔多斯,准格尔旗', '111.240171', '39.864362', 1);
INSERT INTO `eb_system_city` VALUES (801, 107593, 2, 107065, '150623000000', '鄂托克前旗', '内蒙古,鄂尔多斯,鄂托克前旗', '107.477515', '38.182362', 1);
INSERT INTO `eb_system_city` VALUES (802, 107684, 2, 107065, '150624000000', '鄂托克旗', '内蒙古,鄂尔多斯,鄂托克旗', '107.976161', '39.089650', 1);
INSERT INTO `eb_system_city` VALUES (803, 107792, 2, 107065, '150625000000', '杭锦旗', '内蒙古,鄂尔多斯,杭锦旗', '108.736208', '39.833309', 1);
INSERT INTO `eb_system_city` VALUES (804, 107892, 2, 107065, '150626000000', '乌审旗', '内蒙古,鄂尔多斯,乌审旗', '108.817607', '38.604136', 1);
INSERT INTO `eb_system_city` VALUES (805, 107982, 2, 107065, '150627000000', '伊金霍洛旗', '内蒙古,鄂尔多斯,伊金霍洛旗', '109.747740', '39.564660', 1);
INSERT INTO `eb_system_city` VALUES (806, 108167, 2, 108166, '150701000000', '市辖区', '内蒙古,呼伦贝尔', '119.765744', '49.211574', 1);
INSERT INTO `eb_system_city` VALUES (807, 108168, 2, 108166, '150702000000', '海拉尔区', '内蒙古,呼伦贝尔,海拉尔', '119.736279', '49.212189', 1);
INSERT INTO `eb_system_city` VALUES (808, 108232, 2, 108166, '150703000000', '扎赉诺尔区', '内蒙古,呼伦贝尔,扎赉诺尔', '117.670248', '49.510375', 1);
INSERT INTO `eb_system_city` VALUES (809, 108260, 2, 108166, '150721000000', '阿荣旗', '内蒙古,呼伦贝尔,阿荣旗', '123.459050', '48.126585', 1);
INSERT INTO `eb_system_city` VALUES (810, 108483, 2, 108166, '150722000000', '莫力达瓦达斡尔族自治旗', '内蒙古,呼伦贝尔,莫力达瓦', '123.810423', '48.852112', 1);
INSERT INTO `eb_system_city` VALUES (811, 108785, 2, 108166, '150723000000', '鄂伦春自治旗', '内蒙古,呼伦贝尔,鄂伦春自治旗', '123.726201', '50.591842', 1);
INSERT INTO `eb_system_city` VALUES (812, 109030, 2, 108166, '150724000000', '鄂温克族自治旗', '内蒙古,呼伦贝尔,鄂温克族自治旗', '119.755213', '49.146588', 1);
INSERT INTO `eb_system_city` VALUES (813, 109113, 2, 108166, '150725000000', '陈巴尔虎旗', '内蒙古,呼伦贝尔,陈巴尔虎旗', '119.424026', '49.328916', 1);
INSERT INTO `eb_system_city` VALUES (814, 109205, 2, 108166, '150726000000', '新巴尔虎左旗', '内蒙古,呼伦贝尔,新巴尔虎左旗', '118.269820', '48.218241', 1);
INSERT INTO `eb_system_city` VALUES (815, 109281, 2, 108166, '150727000000', '新巴尔虎右旗', '内蒙古,呼伦贝尔,新巴尔虎右旗', '116.823690', '48.672101', 1);
INSERT INTO `eb_system_city` VALUES (816, 109355, 2, 108166, '150781000000', '满洲里市', '内蒙古,呼伦贝尔,满洲里', '117.378530', '49.597841', 1);
INSERT INTO `eb_system_city` VALUES (817, 109393, 2, 108166, '150782000000', '牙克石市', '内蒙古,呼伦贝尔,牙克石', '120.711770', '49.285568', 1);
INSERT INTO `eb_system_city` VALUES (818, 109490, 2, 108166, '150783000000', '扎兰屯市', '内蒙古,呼伦贝尔,扎兰屯', '122.737467', '48.013733', 1);
INSERT INTO `eb_system_city` VALUES (819, 109738, 2, 108166, '150784000000', '额尔古纳市', '内蒙古,呼伦贝尔,额尔古纳', '120.180506', '50.243102', 1);
INSERT INTO `eb_system_city` VALUES (820, 109813, 2, 108166, '150785000000', '根河市', '内蒙古,呼伦贝尔,根河', '121.520388', '50.780345', 1);
INSERT INTO `eb_system_city` VALUES (821, 109848, 2, 109847, '150801000000', '市辖区', '内蒙古,巴彦淖尔', '107.387657', '40.743213', 1);
INSERT INTO `eb_system_city` VALUES (822, 109849, 2, 109847, '150802000000', '临河区', '内蒙古,巴彦淖尔,临河', '107.363919', '40.751187', 1);
INSERT INTO `eb_system_city` VALUES (823, 110095, 2, 109847, '150821000000', '五原县', '内蒙古,巴彦淖尔,五原', '108.267562', '41.088422', 1);
INSERT INTO `eb_system_city` VALUES (824, 110255, 2, 109847, '150822000000', '磴口县', '内蒙古,巴彦淖尔,磴口', '107.008248', '40.330524', 1);
INSERT INTO `eb_system_city` VALUES (825, 110372, 2, 109847, '150823000000', '乌拉特前旗', '内蒙古,巴彦淖尔,乌拉特前旗', '108.652119', '40.737030', 1);
INSERT INTO `eb_system_city` VALUES (826, 110557, 2, 109847, '150824000000', '乌拉特中旗', '内蒙古,巴彦淖尔,乌拉特中旗', '108.513645', '41.587732', 1);
INSERT INTO `eb_system_city` VALUES (827, 110676, 2, 109847, '150825000000', '乌拉特后旗', '内蒙古,巴彦淖尔,乌拉特后旗', '107.074621', '41.084283', 1);
INSERT INTO `eb_system_city` VALUES (828, 110743, 2, 109847, '150826000000', '杭锦后旗', '内蒙古,巴彦淖尔,杭锦后旗', '107.150909', '40.885896', 1);
INSERT INTO `eb_system_city` VALUES (829, 110890, 2, 110889, '150901000000', '市辖区', '内蒙古,乌兰察布', '113.132585', '40.994785', 1);
INSERT INTO `eb_system_city` VALUES (830, 110891, 2, 110889, '150902000000', '集宁区', '内蒙古,乌兰察布,集宁', '113.123779', '40.990689', 1);
INSERT INTO `eb_system_city` VALUES (831, 110998, 2, 110889, '150921000000', '卓资县', '内蒙古,乌兰察布,卓资', '112.577528', '40.894692', 1);
INSERT INTO `eb_system_city` VALUES (832, 111127, 2, 110889, '150922000000', '化德县', '内蒙古,乌兰察布,化德', '114.010438', '41.904560', 1);
INSERT INTO `eb_system_city` VALUES (833, 111237, 2, 110889, '150923000000', '商都县', '内蒙古,乌兰察布,商都', '113.577816', '41.562113', 1);
INSERT INTO `eb_system_city` VALUES (834, 111481, 2, 110889, '150924000000', '兴和县', '内蒙古,乌兰察布,兴和', '113.834173', '40.872301', 1);
INSERT INTO `eb_system_city` VALUES (835, 111666, 2, 110889, '150925000000', '凉城县', '内蒙古,乌兰察布,凉城', '112.503971', '40.531555', 1);
INSERT INTO `eb_system_city` VALUES (836, 111824, 2, 110889, '150926000000', '察哈尔右翼前旗', '内蒙古,乌兰察布,察哈尔右翼前旗', '113.214733', '40.785631', 1);
INSERT INTO `eb_system_city` VALUES (837, 111969, 2, 110889, '150927000000', '察哈尔右翼中旗', '内蒙古,乌兰察布,察哈尔右翼中旗', '112.635577', '41.277462', 1);
INSERT INTO `eb_system_city` VALUES (838, 112164, 2, 110889, '150928000000', '察哈尔右翼后旗', '内蒙古,乌兰察布,察哈尔右翼后旗', '113.191035', '41.436069', 1);
INSERT INTO `eb_system_city` VALUES (839, 112277, 2, 110889, '150929000000', '四子王旗', '内蒙古,乌兰察布,四子王旗', '111.706618', '41.533462', 1);
INSERT INTO `eb_system_city` VALUES (840, 112427, 2, 110889, '150981000000', '丰镇市', '内蒙古,乌兰察布,丰镇', '113.109892', '40.436983', 1);
INSERT INTO `eb_system_city` VALUES (841, 112553, 2, 112552, '152201000000', '乌兰浩特市', '内蒙古,兴安,乌兰浩特', '122.093123', '46.072732', 1);
INSERT INTO `eb_system_city` VALUES (842, 112694, 2, 112552, '152202000000', '阿尔山市', '内蒙古,兴安,阿尔山', '119.943575', '47.177440', 1);
INSERT INTO `eb_system_city` VALUES (843, 112734, 2, 112552, '152221000000', '科尔沁右翼前旗', '内蒙古,兴安,科尔沁右翼前旗', '121.952550', '46.079810', 1);
INSERT INTO `eb_system_city` VALUES (844, 113051, 2, 112552, '152222000000', '科尔沁右翼中旗', '内蒙古,兴安,科尔沁右翼中旗', '121.476530', '45.060837', 1);
INSERT INTO `eb_system_city` VALUES (845, 113294, 2, 112552, '152223000000', '扎赉特旗', '内蒙古,兴安,扎赉特旗', '122.899656', '46.723237', 1);
INSERT INTO `eb_system_city` VALUES (846, 113554, 2, 112552, '152224000000', '突泉县', '内蒙古,兴安,突泉', '121.593799', '45.381930', 1);
INSERT INTO `eb_system_city` VALUES (847, 113778, 2, 113777, '152501000000', '二连浩特市', '内蒙古,锡林郭勒,二连浩特', '111.977943', '43.653170', 1);
INSERT INTO `eb_system_city` VALUES (848, 113796, 2, 113777, '152502000000', '锡林浩特市', '内蒙古,锡林郭勒,锡林浩特', '116.086032', '43.933411', 1);
INSERT INTO `eb_system_city` VALUES (849, 113912, 2, 113777, '152522000000', '阿巴嘎旗', '内蒙古,锡林郭勒,阿巴嘎旗', '114.950248', '44.022995', 1);
INSERT INTO `eb_system_city` VALUES (850, 113999, 2, 113777, '152523000000', '苏尼特左旗', '内蒙古,锡林郭勒,苏尼特左旗', '113.667248', '43.859880', 1);
INSERT INTO `eb_system_city` VALUES (851, 114065, 2, 113777, '152524000000', '苏尼特右旗', '内蒙古,锡林郭勒,苏尼特右旗', '112.641783', '42.742892', 1);
INSERT INTO `eb_system_city` VALUES (852, 114152, 2, 113777, '152525000000', '东乌珠穆沁旗', '内蒙古,锡林郭勒,东乌珠穆沁旗', '116.974494', '45.498221', 1);
INSERT INTO `eb_system_city` VALUES (853, 114239, 2, 113777, '152526000000', '西乌珠穆沁旗', '内蒙古,锡林郭勒,西乌珠穆沁旗', '117.608911', '44.587882', 1);
INSERT INTO `eb_system_city` VALUES (854, 114358, 2, 113777, '152527000000', '太仆寺旗', '内蒙古,锡林郭勒,太仆寺旗', '115.282986', '41.877136', 1);
INSERT INTO `eb_system_city` VALUES (855, 114557, 2, 113777, '152528000000', '镶黄旗', '内蒙古,锡林郭勒,镶黄旗', '113.847287', '42.232371', 1);
INSERT INTO `eb_system_city` VALUES (856, 114628, 2, 113777, '152529000000', '正镶白旗', '内蒙古,锡林郭勒,正镶白旗', '115.029849', '42.287471', 1);
INSERT INTO `eb_system_city` VALUES (857, 114722, 2, 113777, '152530000000', '正蓝旗', '内蒙古,锡林郭勒,正蓝旗', '115.992470', '42.241638', 1);
INSERT INTO `eb_system_city` VALUES (858, 114859, 2, 113777, '152531000000', '多伦县', '内蒙古,锡林郭勒,多伦', '116.485556', '42.203591', 1);
INSERT INTO `eb_system_city` VALUES (859, 114941, 2, 114940, '152921000000', '阿拉善左旗', '内蒙古,阿拉善,阿拉善左旗', '105.666293', '38.833411', 1);
INSERT INTO `eb_system_city` VALUES (860, 115132, 2, 114940, '152922000000', '阿拉善右旗', '内蒙古,阿拉善,阿拉善右旗', '101.666917', '39.216186', 1);
INSERT INTO `eb_system_city` VALUES (861, 115189, 2, 114940, '152923000000', '额济纳旗', '内蒙古,阿拉善,额济纳旗', '101.055590', '41.954347', 1);
INSERT INTO `eb_system_city` VALUES (862, 115226, 2, 115225, '210101000000', '市辖区', '辽宁,沈阳', '123.431474', '41.805698', 1);
INSERT INTO `eb_system_city` VALUES (863, 115227, 2, 115225, '210102000000', '和平区', '辽宁,沈阳,和平', '123.420382', '41.789809', 1);
INSERT INTO `eb_system_city` VALUES (864, 115347, 2, 115225, '210103000000', '沈河区', '辽宁,沈阳,沈河', '123.458897', '41.795655', 1);
INSERT INTO `eb_system_city` VALUES (865, 115474, 2, 115225, '210104000000', '大东区', '辽宁,沈阳,大东', '123.469949', '41.805137', 1);
INSERT INTO `eb_system_city` VALUES (866, 115612, 2, 115225, '210105000000', '皇姑区', '辽宁,沈阳,皇姑', '123.441970', '41.824796', 1);
INSERT INTO `eb_system_city` VALUES (867, 115752, 2, 115225, '210106000000', '铁西区', '辽宁,沈阳,铁西', '123.376301', '41.802914', 1);
INSERT INTO `eb_system_city` VALUES (868, 115964, 2, 115225, '210111000000', '苏家屯区', '辽宁,沈阳,苏家屯', '123.344031', '41.664757', 1);
INSERT INTO `eb_system_city` VALUES (869, 116159, 2, 115225, '210112000000', '浑南区', '辽宁,沈阳,浑南', '123.449715', '41.714914', 1);
INSERT INTO `eb_system_city` VALUES (870, 116399, 2, 115225, '210113000000', '沈北新区', '辽宁,沈阳,沈北', '123.431474', '41.805698', 1);
INSERT INTO `eb_system_city` VALUES (871, 116614, 2, 115225, '210114000000', '于洪区', '辽宁,沈阳,于洪', '123.308136', '41.793743', 1);
INSERT INTO `eb_system_city` VALUES (872, 116820, 2, 115225, '210115000000', '辽中区', '辽宁,沈阳,辽中', '122.765409', '41.516827', 1);
INSERT INTO `eb_system_city` VALUES (873, 117075, 2, 115225, '210123000000', '康平县', '辽宁,沈阳,康平', '123.355701', '42.741005', 1);
INSERT INTO `eb_system_city` VALUES (874, 117268, 2, 115225, '210124000000', '法库县', '辽宁,沈阳,法库', '123.440495', '42.500730', 1);
INSERT INTO `eb_system_city` VALUES (875, 117530, 2, 115225, '210181000000', '新民市', '辽宁,沈阳,新民', '122.836726', '41.985193', 1);
INSERT INTO `eb_system_city` VALUES (876, 117933, 2, 117932, '210201000000', '市辖区', '辽宁,大连', '121.614682', '38.914003', 1);
INSERT INTO `eb_system_city` VALUES (877, 117934, 2, 117932, '210202000000', '中山区', '辽宁,大连,中山', '121.644927', '38.918574', 1);
INSERT INTO `eb_system_city` VALUES (878, 117997, 2, 117932, '210203000000', '西岗区', '辽宁,大连,西岗', '121.612325', '38.914687', 1);
INSERT INTO `eb_system_city` VALUES (879, 118050, 2, 117932, '210204000000', '沙河口区', '辽宁,大连,沙河口', '121.594200', '38.904808', 1);
INSERT INTO `eb_system_city` VALUES (880, 118150, 2, 117932, '210211000000', '甘井子区', '辽宁,大连,甘井子', '121.525461', '38.953351', 1);
INSERT INTO `eb_system_city` VALUES (881, 118405, 2, 117932, '210212000000', '旅顺口区', '辽宁,大连,旅顺口', '121.261953', '38.851705', 1);
INSERT INTO `eb_system_city` VALUES (882, 118523, 2, 117932, '210213000000', '金州区', '辽宁,大连,金州', '121.782769', '39.050460', 1);
INSERT INTO `eb_system_city` VALUES (883, 118884, 2, 117932, '210214000000', '普兰店区', '辽宁,大连,普兰店', '121.970512', '39.401551', 1);
INSERT INTO `eb_system_city` VALUES (884, 119090, 2, 117932, '210224000000', '长海县', '辽宁,大连,长海', '122.588494', '39.272728', 1);
INSERT INTO `eb_system_city` VALUES (885, 119126, 2, 117932, '210281000000', '瓦房店市', '辽宁,大连,瓦房店', '121.979603', '39.627114', 1);
INSERT INTO `eb_system_city` VALUES (886, 119483, 2, 117932, '210283000000', '庄河市', '辽宁,大连,庄河', '122.967328', '39.680811', 1);
INSERT INTO `eb_system_city` VALUES (887, 119790, 2, 119789, '210301000000', '市辖区', '辽宁,鞍山', '122.994329', '41.108647', 1);
INSERT INTO `eb_system_city` VALUES (888, 119791, 2, 119789, '210302000000', '铁东区', '辽宁,鞍山,铁东', '122.991052', '41.089933', 1);
INSERT INTO `eb_system_city` VALUES (889, 119915, 2, 119789, '210303000000', '铁西区', '辽宁,鞍山,铁西', '122.969630', '41.119885', 1);
INSERT INTO `eb_system_city` VALUES (890, 120021, 2, 119789, '210304000000', '立山区', '辽宁,鞍山,立山', '123.029091', '41.150401', 1);
INSERT INTO `eb_system_city` VALUES (891, 120150, 2, 119789, '210311000000', '千山区', '辽宁,鞍山,千山', '122.949298', '41.068909', 1);
INSERT INTO `eb_system_city` VALUES (892, 120221, 2, 119789, '210321000000', '台安县', '辽宁,鞍山,台安', '122.436196', '41.412768', 1);
INSERT INTO `eb_system_city` VALUES (893, 120401, 2, 119789, '210323000000', '岫岩满族自治县', '辽宁,鞍山,岫岩', '123.280935', '40.290880', 1);
INSERT INTO `eb_system_city` VALUES (894, 120634, 2, 119789, '210381000000', '海城市', '辽宁,鞍山,海城', '122.685217', '40.882377', 1);
INSERT INTO `eb_system_city` VALUES (895, 121082, 2, 121081, '210401000000', '市辖区', '辽宁,抚顺', '123.957208', '41.880872', 1);
INSERT INTO `eb_system_city` VALUES (896, 121083, 2, 121081, '210402000000', '新抚区', '辽宁,抚顺,新抚', '123.912861', '41.862080', 1);
INSERT INTO `eb_system_city` VALUES (897, 121181, 2, 121081, '210403000000', '东洲区', '辽宁,抚顺,东洲', '124.038685', '41.853192', 1);
INSERT INTO `eb_system_city` VALUES (898, 121326, 2, 121081, '210404000000', '望花区', '辽宁,抚顺,望花', '123.784206', '41.853646', 1);
INSERT INTO `eb_system_city` VALUES (899, 121484, 2, 121081, '210411000000', '顺城区', '辽宁,抚顺,顺城', '123.945040', '41.883375', 1);
INSERT INTO `eb_system_city` VALUES (900, 121604, 2, 121081, '210421000000', '抚顺县', '辽宁,抚顺,抚顺', '124.097979', '41.922644', 1);
INSERT INTO `eb_system_city` VALUES (901, 121710, 2, 121081, '210422000000', '新宾满族自治县', '辽宁,抚顺,新宾', '125.039978', '41.734256', 1);
INSERT INTO `eb_system_city` VALUES (902, 121920, 2, 121081, '210423000000', '清原满族自治县', '辽宁,抚顺,清原', '124.924083', '42.100539', 1);
INSERT INTO `eb_system_city` VALUES (903, 122143, 2, 122142, '210501000000', '市辖区', '辽宁,本溪', '123.766485', '41.294175', 1);
INSERT INTO `eb_system_city` VALUES (904, 122144, 2, 122142, '210502000000', '平山区', '辽宁,本溪,平山', '123.768926', '41.299702', 1);
INSERT INTO `eb_system_city` VALUES (905, 122216, 2, 122142, '210503000000', '溪湖区', '辽宁,本溪,溪湖', '123.767647', '41.329219', 1);
INSERT INTO `eb_system_city` VALUES (906, 122310, 2, 122142, '210504000000', '明山区', '辽宁,本溪,明山', '123.817212', '41.308710', 1);
INSERT INTO `eb_system_city` VALUES (907, 122400, 2, 122142, '210505000000', '南芬区', '辽宁,本溪,南芬', '123.744802', '41.100445', 1);
INSERT INTO `eb_system_city` VALUES (908, 122444, 2, 122142, '210521000000', '本溪满族自治县', '辽宁,本溪,本溪', '124.120436', '41.301892', 1);
INSERT INTO `eb_system_city` VALUES (909, 122591, 2, 122142, '210522000000', '桓仁满族自治县', '辽宁,本溪,桓仁', '125.361007', '41.267128', 1);
INSERT INTO `eb_system_city` VALUES (910, 122731, 2, 122730, '210601000000', '市辖区', '辽宁,丹东', '124.354706', '40.000499', 1);
INSERT INTO `eb_system_city` VALUES (911, 122732, 2, 122730, '210602000000', '元宝区', '辽宁,丹东,元宝', '124.395757', '40.136520', 1);
INSERT INTO `eb_system_city` VALUES (912, 122785, 2, 122730, '210603000000', '振兴区', '辽宁,丹东,振兴', '124.360264', '40.105194', 1);
INSERT INTO `eb_system_city` VALUES (913, 122886, 2, 122730, '210604000000', '振安区', '辽宁,丹东,振安', '124.428162', '40.158267', 1);
INSERT INTO `eb_system_city` VALUES (914, 122958, 2, 122730, '210624000000', '宽甸满族自治县', '辽宁,丹东,宽甸', '124.783660', '40.731317', 1);
INSERT INTO `eb_system_city` VALUES (915, 123177, 2, 122730, '210681000000', '东港市', '辽宁,丹东,东港', '124.152705', '39.863008', 1);
INSERT INTO `eb_system_city` VALUES (916, 123438, 2, 122730, '210682000000', '凤城市', '辽宁,丹东,凤城', '124.066919', '40.452298', 1);
INSERT INTO `eb_system_city` VALUES (917, 123699, 2, 123698, '210701000000', '市辖区', '辽宁,锦州', '121.127003', '41.095119', 1);
INSERT INTO `eb_system_city` VALUES (918, 123700, 2, 123698, '210702000000', '古塔区', '辽宁,锦州,古塔', '121.128279', '41.117245', 1);
INSERT INTO `eb_system_city` VALUES (919, 123778, 2, 123698, '210703000000', '凌河区', '辽宁,锦州,凌河', '121.150877', '41.114990', 1);
INSERT INTO `eb_system_city` VALUES (920, 123869, 2, 123698, '210711000000', '太和区', '辽宁,锦州,太和', '121.103892', '41.109147', 1);
INSERT INTO `eb_system_city` VALUES (921, 124044, 2, 123698, '210726000000', '黑山县', '辽宁,锦州,黑山', '122.123443', '41.666028', 1);
INSERT INTO `eb_system_city` VALUES (922, 124398, 2, 123698, '210727000000', '义县', '辽宁,锦州,义县', '121.239080', '41.533087', 1);
INSERT INTO `eb_system_city` VALUES (923, 124670, 2, 123698, '210781000000', '凌海市', '辽宁,锦州,凌海', '121.357730', '41.173400', 1);
INSERT INTO `eb_system_city` VALUES (924, 124980, 2, 123698, '210782000000', '北镇市', '辽宁,锦州,北镇', '121.795962', '41.598764', 1);
INSERT INTO `eb_system_city` VALUES (925, 125250, 2, 125249, '210801000000', '市辖区', '辽宁,营口', '122.235417', '40.667012', 1);
INSERT INTO `eb_system_city` VALUES (926, 125251, 2, 125249, '210802000000', '站前区', '辽宁,营口,站前', '122.258961', '40.672670', 1);
INSERT INTO `eb_system_city` VALUES (927, 125305, 2, 125249, '210803000000', '西市区', '辽宁,营口,西市', '122.206414', '40.666408', 1);
INSERT INTO `eb_system_city` VALUES (928, 125353, 2, 125249, '210804000000', '鲅鱼圈区', '辽宁,营口,鲅鱼圈', '122.107814', '40.230636', 1);
INSERT INTO `eb_system_city` VALUES (929, 125454, 2, 125249, '210811000000', '老边区', '辽宁,营口,老边', '122.379967', '40.680303', 1);
INSERT INTO `eb_system_city` VALUES (930, 125520, 2, 125249, '210881000000', '盖州市', '辽宁,营口,盖州', '122.348936', '40.400611', 1);
INSERT INTO `eb_system_city` VALUES (931, 125849, 2, 125249, '210882000000', '大石桥市', '辽宁,营口,大石桥', '122.509131', '40.644622', 1);
INSERT INTO `eb_system_city` VALUES (932, 126157, 2, 126156, '210901000000', '市辖区', '辽宁,阜新', '121.670323', '42.021619', 1);
INSERT INTO `eb_system_city` VALUES (933, 126158, 2, 126156, '210902000000', '海州区', '辽宁,阜新,海州', '121.656255', '42.013242', 1);
INSERT INTO `eb_system_city` VALUES (934, 126236, 2, 126156, '210903000000', '新邱区', '辽宁,阜新,新邱', '121.792535', '42.087632', 1);
INSERT INTO `eb_system_city` VALUES (935, 126264, 2, 126156, '210904000000', '太平区', '辽宁,阜新,太平', '121.678512', '42.010600', 1);
INSERT INTO `eb_system_city` VALUES (936, 126314, 2, 126156, '210905000000', '清河门区', '辽宁,阜新,清河门', '121.416105', '41.783100', 1);
INSERT INTO `eb_system_city` VALUES (937, 126349, 2, 126156, '210911000000', '细河区', '辽宁,阜新,细河', '121.680540', '42.025495', 1);
INSERT INTO `eb_system_city` VALUES (938, 126417, 2, 126156, '210921000000', '阜新蒙古族自治县', '辽宁,阜新,阜新', '121.757901', '42.065175', 1);
INSERT INTO `eb_system_city` VALUES (939, 126845, 2, 126156, '210922000000', '彰武县', '辽宁,阜新,彰武', '122.538793', '42.386544', 1);
INSERT INTO `eb_system_city` VALUES (940, 127071, 2, 127070, '211001000000', '市辖区', '辽宁,辽阳', '123.236944', '41.267244', 1);
INSERT INTO `eb_system_city` VALUES (941, 127072, 2, 127070, '211002000000', '白塔区', '辽宁,辽阳,白塔', '123.174325', '41.270347', 1);
INSERT INTO `eb_system_city` VALUES (942, 127152, 2, 127070, '211003000000', '文圣区', '辽宁,辽阳,文圣', '123.185386', '41.262608', 1);
INSERT INTO `eb_system_city` VALUES (943, 127218, 2, 127070, '211004000000', '宏伟区', '辽宁,辽阳,宏伟', '123.196672', '41.217649', 1);
INSERT INTO `eb_system_city` VALUES (944, 127266, 2, 127070, '211005000000', '弓长岭区', '辽宁,辽阳,弓长岭', '123.419804', '41.151847', 1);
INSERT INTO `eb_system_city` VALUES (945, 127305, 2, 127070, '211011000000', '太子河区', '辽宁,辽阳,太子河', '123.181782', '41.253277', 1);
INSERT INTO `eb_system_city` VALUES (946, 127386, 2, 127070, '211021000000', '辽阳县', '辽宁,辽阳,辽阳', '123.105695', '41.205329', 1);
INSERT INTO `eb_system_city` VALUES (947, 127612, 2, 127070, '211081000000', '灯塔市', '辽宁,辽阳,灯塔', '123.339312', '41.426372', 1);
INSERT INTO `eb_system_city` VALUES (948, 127835, 2, 127834, '211101000000', '市辖区', '辽宁,盘锦', '122.070714', '41.119997', 1);
INSERT INTO `eb_system_city` VALUES (949, 127836, 2, 127834, '211102000000', '双台子区', '辽宁,盘锦,双台子', '122.060112', '41.190606', 1);
INSERT INTO `eb_system_city` VALUES (950, 127896, 2, 127834, '211103000000', '兴隆台区', '辽宁,盘锦,兴隆台', '122.069897', '41.158678', 1);
INSERT INTO `eb_system_city` VALUES (951, 128037, 2, 127834, '211104000000', '大洼区', '辽宁,盘锦,大洼', '122.082575', '41.002279', 1);
INSERT INTO `eb_system_city` VALUES (952, 128231, 2, 127834, '211122000000', '盘山县', '辽宁,盘锦,盘山', '121.996499', '41.242873', 1);
INSERT INTO `eb_system_city` VALUES (953, 128422, 2, 128421, '211201000000', '市辖区', '辽宁,铁岭', '123.726166', '42.223769', 1);
INSERT INTO `eb_system_city` VALUES (954, 128423, 2, 128421, '211202000000', '银州区', '辽宁,铁岭,银州', '123.842305', '42.286130', 1);
INSERT INTO `eb_system_city` VALUES (955, 128530, 2, 128421, '211204000000', '清河区', '辽宁,铁岭,清河', '123.726166', '42.223769', 1);
INSERT INTO `eb_system_city` VALUES (956, 128591, 2, 128421, '211221000000', '铁岭县', '辽宁,铁岭,铁岭', '123.729004', '42.223383', 1);
INSERT INTO `eb_system_city` VALUES (957, 128839, 2, 128421, '211223000000', '西丰县', '辽宁,铁岭,西丰', '124.727393', '42.738030', 1);
INSERT INTO `eb_system_city` VALUES (958, 129043, 2, 128421, '211224000000', '昌图县', '辽宁,铁岭,昌图', '124.111100', '42.785791', 1);
INSERT INTO `eb_system_city` VALUES (959, 129592, 2, 128421, '211281000000', '调兵山市', '辽宁,铁岭,调兵山', '123.567117', '42.467521', 1);
INSERT INTO `eb_system_city` VALUES (960, 129661, 2, 128421, '211282000000', '开原市', '辽宁,铁岭,开原', '124.038268', '42.546307', 1);
INSERT INTO `eb_system_city` VALUES (961, 129978, 2, 129977, '211301000000', '市辖区', '辽宁,朝阳', '120.389862', '41.497767', 1);
INSERT INTO `eb_system_city` VALUES (962, 129979, 2, 129977, '211302000000', '双塔区', '辽宁,朝阳,双塔', '120.453744', '41.565628', 1);
INSERT INTO `eb_system_city` VALUES (963, 130102, 2, 129977, '211303000000', '龙城区', '辽宁,朝阳,龙城', '120.413376', '41.576749', 1);
INSERT INTO `eb_system_city` VALUES (964, 130205, 2, 129977, '211321000000', '朝阳县', '辽宁,朝阳,朝阳', '120.389862', '41.497767', 1);
INSERT INTO `eb_system_city` VALUES (965, 130534, 2, 129977, '211322000000', '建平县', '辽宁,朝阳,建平', '119.643280', '41.403128', 1);
INSERT INTO `eb_system_city` VALUES (966, 130860, 2, 129977, '211324000000', '喀喇沁左翼蒙古族自治县', '辽宁,朝阳,喀喇沁左翼', '120.389862', '41.497767', 1);
INSERT INTO `eb_system_city` VALUES (967, 131089, 2, 129977, '211381000000', '北票市', '辽宁,朝阳,北票', '120.770730', '41.800684', 1);
INSERT INTO `eb_system_city` VALUES (968, 131425, 2, 129977, '211382000000', '凌源市', '辽宁,朝阳,凌源', '119.401574', '41.245445', 1);
INSERT INTO `eb_system_city` VALUES (969, 131739, 2, 131738, '211401000000', '市辖区', '辽宁,葫芦岛', '120.836932', '40.711052', 1);
INSERT INTO `eb_system_city` VALUES (970, 131740, 2, 131738, '211402000000', '连山区', '辽宁,葫芦岛,连山', '120.869231', '40.774461', 1);
INSERT INTO `eb_system_city` VALUES (971, 131976, 2, 131738, '211403000000', '龙港区', '辽宁,葫芦岛,龙港', '120.893786', '40.735519', 1);
INSERT INTO `eb_system_city` VALUES (972, 132073, 2, 131738, '211404000000', '南票区', '辽宁,葫芦岛,南票', '120.749728', '41.107108', 1);
INSERT INTO `eb_system_city` VALUES (973, 132258, 2, 131738, '211421000000', '绥中县', '辽宁,葫芦岛,绥中', '120.344229', '40.325659', 1);
INSERT INTO `eb_system_city` VALUES (974, 132590, 2, 131738, '211422000000', '建昌县', '辽宁,葫芦岛,建昌', '119.837124', '40.824368', 1);
INSERT INTO `eb_system_city` VALUES (975, 132912, 2, 131738, '211481000000', '兴城市', '辽宁,葫芦岛,兴城', '120.728310', '40.614762', 1);
INSERT INTO `eb_system_city` VALUES (976, 133210, 2, 133209, '220101000000', '市辖区', '吉林,长春', '125.323544', '43.817071', 1);
INSERT INTO `eb_system_city` VALUES (977, 133211, 2, 133209, '220102000000', '南关区', '吉林,长春,南关', '125.350173', '43.863989', 1);
INSERT INTO `eb_system_city` VALUES (978, 133289, 2, 133209, '220103000000', '宽城区', '吉林,长春,宽城', '125.326578', '43.943614', 1);
INSERT INTO `eb_system_city` VALUES (979, 133453, 2, 133209, '220104000000', '朝阳区', '吉林,长春,朝阳', '125.288319', '43.833513', 1);
INSERT INTO `eb_system_city` VALUES (980, 133543, 2, 133209, '220105000000', '二道区', '吉林,长春,二道', '125.374217', '43.865596', 1);
INSERT INTO `eb_system_city` VALUES (981, 133631, 2, 133209, '220106000000', '绿园区', '吉林,长春,绿园', '125.256136', '43.880975', 1);
INSERT INTO `eb_system_city` VALUES (982, 133719, 2, 133209, '220112000000', '双阳区', '吉林,长春,双阳', '125.664662', '43.525311', 1);
INSERT INTO `eb_system_city` VALUES (983, 133881, 2, 133209, '220113000000', '九台区', '吉林,长春,九台', '125.839574', '44.151742', 1);
INSERT INTO `eb_system_city` VALUES (984, 134236, 2, 133209, '220122000000', '农安县', '吉林,长春,农安', '125.184742', '44.432889', 1);
INSERT INTO `eb_system_city` VALUES (985, 134628, 2, 133209, '220182000000', '榆树市', '吉林,长春,榆树', '126.533146', '44.840288', 1);
INSERT INTO `eb_system_city` VALUES (986, 135061, 2, 133209, '220183000000', '德惠市', '吉林,长春,德惠', '125.728620', '44.521785', 1);
INSERT INTO `eb_system_city` VALUES (987, 135393, 2, 135392, '220201000000', '市辖区', '吉林,吉林', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (988, 135394, 2, 135392, '220202000000', '昌邑区', '吉林,吉林,昌邑', '126.574710', '43.881818', 1);
INSERT INTO `eb_system_city` VALUES (989, 135568, 2, 135392, '220203000000', '龙潭区', '吉林,吉林,龙潭', '126.562197', '43.910803', 1);
INSERT INTO `eb_system_city` VALUES (990, 135755, 2, 135392, '220204000000', '船营区', '吉林,吉林,船营', '126.540966', '43.833445', 1);
INSERT INTO `eb_system_city` VALUES (991, 135885, 2, 135392, '220211000000', '丰满区', '吉林,吉林,丰满', '126.562274', '43.821601', 1);
INSERT INTO `eb_system_city` VALUES (992, 135986, 2, 135392, '220221000000', '永吉县', '吉林,吉林,永吉', '126.497741', '43.672582', 1);
INSERT INTO `eb_system_city` VALUES (993, 136136, 2, 135392, '220281000000', '蛟河市', '吉林,吉林,蛟河', '127.344501', '43.723713', 1);
INSERT INTO `eb_system_city` VALUES (994, 136439, 2, 135392, '220282000000', '桦甸市', '吉林,吉林,桦甸', '126.746310', '42.972097', 1);
INSERT INTO `eb_system_city` VALUES (995, 136629, 2, 135392, '220283000000', '舒兰市', '吉林,吉林,舒兰', '126.965607', '44.406106', 1);
INSERT INTO `eb_system_city` VALUES (996, 136889, 2, 135392, '220284000000', '磐石市', '吉林,吉林,磐石', '126.060427', '42.946285', 1);
INSERT INTO `eb_system_city` VALUES (997, 137207, 2, 137206, '220301000000', '市辖区', '吉林,四平', '124.350398', '43.166419', 1);
INSERT INTO `eb_system_city` VALUES (998, 137208, 2, 137206, '220302000000', '铁西区', '吉林,四平,铁西', '124.345722', '43.146155', 1);
INSERT INTO `eb_system_city` VALUES (999, 137275, 2, 137206, '220303000000', '铁东区', '吉林,四平,铁东', '124.409622', '43.162048', 1);
INSERT INTO `eb_system_city` VALUES (1000, 137386, 2, 137206, '220322000000', '梨树县', '吉林,四平,梨树', '124.335390', '43.307060', 1);
INSERT INTO `eb_system_city` VALUES (1001, 137756, 2, 137206, '220323000000', '伊通满族自治县', '吉林,四平,伊通', '125.305394', '43.345754', 1);
INSERT INTO `eb_system_city` VALUES (1002, 137973, 2, 137206, '220381000000', '公主岭市', '吉林,四平,公主岭', '124.822830', '43.504687', 1);
INSERT INTO `eb_system_city` VALUES (1003, 138477, 2, 137206, '220382000000', '双辽市', '吉林,四平,双辽', '123.502724', '43.518302', 1);
INSERT INTO `eb_system_city` VALUES (1004, 138722, 2, 138721, '220401000000', '市辖区', '吉林,辽源', '125.143532', '42.887918', 1);
INSERT INTO `eb_system_city` VALUES (1005, 138723, 2, 138721, '220402000000', '龙山区', '吉林,辽源,龙山', '125.136452', '42.901534', 1);
INSERT INTO `eb_system_city` VALUES (1006, 138780, 2, 138721, '220403000000', '西安区', '吉林,辽源,西安', '125.149283', '42.927265', 1);
INSERT INTO `eb_system_city` VALUES (1007, 138818, 2, 138721, '220421000000', '东丰县', '吉林,辽源,东丰', '125.530991', '42.676935', 1);
INSERT INTO `eb_system_city` VALUES (1008, 139072, 2, 138721, '220422000000', '东辽县', '吉林,辽源,东辽', '124.991521', '42.926331', 1);
INSERT INTO `eb_system_city` VALUES (1009, 139341, 2, 139340, '220501000000', '市辖区', '吉林,通化', '125.939697', '41.728401', 1);
INSERT INTO `eb_system_city` VALUES (1010, 139342, 2, 139340, '220502000000', '东昌区', '吉林,通化,东昌', '125.955102', '41.728498', 1);
INSERT INTO `eb_system_city` VALUES (1011, 139405, 2, 139340, '220503000000', '二道江区', '吉林,通化,二道江', '126.042535', '41.774053', 1);
INSERT INTO `eb_system_city` VALUES (1012, 139453, 2, 139340, '220521000000', '通化县', '吉林,通化,通化', '125.759259', '41.679808', 1);
INSERT INTO `eb_system_city` VALUES (1013, 139654, 2, 139340, '220523000000', '辉南县', '吉林,通化,辉南', '126.046912', '42.684993', 1);
INSERT INTO `eb_system_city` VALUES (1014, 139824, 2, 139340, '220524000000', '柳河县', '吉林,通化,柳河', '125.744735', '42.284606', 1);
INSERT INTO `eb_system_city` VALUES (1015, 140077, 2, 139340, '220581000000', '梅河口市', '吉林,通化,梅河口', '125.683832', '42.530341', 1);
INSERT INTO `eb_system_city` VALUES (1016, 140432, 2, 139340, '220582000000', '集安市', '吉林,通化,集安', '126.194031', '41.125307', 1);
INSERT INTO `eb_system_city` VALUES (1017, 140602, 2, 140601, '220601000000', '市辖区', '吉林,白山', '126.423587', '41.939994', 1);
INSERT INTO `eb_system_city` VALUES (1018, 140603, 2, 140601, '220602000000', '浑江区', '吉林,白山,浑江', '126.416094', '41.945409', 1);
INSERT INTO `eb_system_city` VALUES (1019, 140714, 2, 140601, '220605000000', '江源区', '吉林,白山,江源', '126.591144', '42.056773', 1);
INSERT INTO `eb_system_city` VALUES (1020, 140816, 2, 140601, '220621000000', '抚松县', '吉林,白山,抚松', '127.449764', '42.221208', 1);
INSERT INTO `eb_system_city` VALUES (1021, 141003, 2, 140601, '220622000000', '靖宇县', '吉林,白山,靖宇', '126.813625', '42.388760', 1);
INSERT INTO `eb_system_city` VALUES (1022, 141140, 2, 140601, '220623000000', '长白朝鲜族自治县', '吉林,白山,长白', '128.200789', '41.420018', 1);
INSERT INTO `eb_system_city` VALUES (1023, 141237, 2, 140601, '220681000000', '临江市', '吉林,白山,临江', '126.918087', '41.811979', 1);
INSERT INTO `eb_system_city` VALUES (1024, 141362, 2, 141361, '220701000000', '市辖区', '吉林,松原', '124.825117', '45.141789', 1);
INSERT INTO `eb_system_city` VALUES (1025, 141363, 2, 141361, '220702000000', '宁江区', '吉林,松原,宁江', '124.817054', '45.171792', 1);
INSERT INTO `eb_system_city` VALUES (1026, 141560, 2, 141361, '220721000000', '前郭尔罗斯蒙古族自治县', '吉林,松原,前郭尔罗斯', '124.823242', '45.118030', 1);
INSERT INTO `eb_system_city` VALUES (1027, 141870, 2, 141361, '220722000000', '长岭县', '吉林,松原,长岭', '123.967484', '44.275895', 1);
INSERT INTO `eb_system_city` VALUES (1028, 142157, 2, 141361, '220723000000', '乾安县', '吉林,松原,乾安', '124.041139', '45.003774', 1);
INSERT INTO `eb_system_city` VALUES (1029, 142353, 2, 141361, '220781000000', '扶余市', '吉林,松原,扶余', '126.049774', '44.988449', 1);
INSERT INTO `eb_system_city` VALUES (1030, 142787, 2, 142786, '220801000000', '市辖区', '吉林,白城', '122.839024', '45.619641', 1);
INSERT INTO `eb_system_city` VALUES (1031, 142788, 2, 142786, '220802000000', '洮北区', '吉林,白城,洮北', '122.851029', '45.621716', 1);
INSERT INTO `eb_system_city` VALUES (1032, 143021, 2, 142786, '220821000000', '镇赉县', '吉林,白城,镇赉', '123.199890', '45.847435', 1);
INSERT INTO `eb_system_city` VALUES (1033, 143209, 2, 142786, '220822000000', '通榆县', '吉林,白城,通榆', '123.088239', '44.812911', 1);
INSERT INTO `eb_system_city` VALUES (1034, 143428, 2, 142786, '220881000000', '洮南市', '吉林,白城,洮南', '122.783779', '45.339113', 1);
INSERT INTO `eb_system_city` VALUES (1035, 143702, 2, 142786, '220882000000', '大安市', '吉林,白城,大安', '124.292626', '45.506996', 1);
INSERT INTO `eb_system_city` VALUES (1036, 143991, 2, 143990, '222401000000', '延吉市', '吉林,延边,延吉', '129.508946', '42.891255', 1);
INSERT INTO `eb_system_city` VALUES (1037, 144147, 2, 143990, '222402000000', '图们市', '吉林,延边,图们', '129.843710', '42.968044', 1);
INSERT INTO `eb_system_city` VALUES (1038, 144226, 2, 143990, '222403000000', '敦化市', '吉林,延边,敦化', '128.232013', '43.372413', 1);
INSERT INTO `eb_system_city` VALUES (1039, 144665, 2, 143990, '222404000000', '珲春市', '吉林,延边,珲春', '130.366036', '42.862821', 1);
INSERT INTO `eb_system_city` VALUES (1040, 144844, 2, 143990, '222405000000', '龙井市', '吉林,延边,龙井', '129.427066', '42.766311', 1);
INSERT INTO `eb_system_city` VALUES (1041, 144953, 2, 143990, '222406000000', '和龙市', '吉林,延边,和龙', '129.010106', '42.546675', 1);
INSERT INTO `eb_system_city` VALUES (1042, 145096, 2, 143990, '222424000000', '汪清县', '吉林,延边,汪清', '129.771607', '43.312522', 1);
INSERT INTO `eb_system_city` VALUES (1043, 145421, 2, 143990, '222426000000', '安图县', '吉林,延边,安图', '128.899807', '43.111964', 1);
INSERT INTO `eb_system_city` VALUES (1044, 145667, 2, 145666, '230101000000', '市辖区', '黑龙江,哈尔滨', '126.534967', '45.803775', 1);
INSERT INTO `eb_system_city` VALUES (1045, 145668, 2, 145666, '230102000000', '道里区', '黑龙江,哈尔滨,道里', '126.616957', '45.755777', 1);
INSERT INTO `eb_system_city` VALUES (1046, 145864, 2, 145666, '230103000000', '南岗区', '黑龙江,哈尔滨,南岗', '126.668788', '45.759970', 1);
INSERT INTO `eb_system_city` VALUES (1047, 146071, 2, 145666, '230104000000', '道外区', '黑龙江,哈尔滨,道外', '126.649451', '45.792113', 1);
INSERT INTO `eb_system_city` VALUES (1048, 146266, 2, 145666, '230108000000', '平房区', '黑龙江,哈尔滨,平房', '126.534967', '45.803775', 1);
INSERT INTO `eb_system_city` VALUES (1049, 146313, 2, 145666, '230109000000', '松北区', '黑龙江,哈尔滨,松北', '126.510275', '45.802756', 1);
INSERT INTO `eb_system_city` VALUES (1050, 146399, 2, 145666, '230110000000', '香坊区', '黑龙江,哈尔滨,香坊', '126.662593', '45.707716', 1);
INSERT INTO `eb_system_city` VALUES (1051, 146587, 2, 145666, '230111000000', '呼兰区', '黑龙江,哈尔滨,呼兰', '126.587709', '45.889427', 1);
INSERT INTO `eb_system_city` VALUES (1052, 146825, 2, 145666, '230112000000', '阿城区', '黑龙江,哈尔滨,阿城', '126.958098', '45.548670', 1);
INSERT INTO `eb_system_city` VALUES (1053, 147032, 2, 145666, '230113000000', '双城区', '黑龙江,哈尔滨,双城', '126.312745', '45.383263', 1);
INSERT INTO `eb_system_city` VALUES (1054, 147391, 2, 145666, '230123000000', '依兰县', '黑龙江,哈尔滨,依兰', '129.567985', '46.324534', 1);
INSERT INTO `eb_system_city` VALUES (1055, 147571, 2, 145666, '230124000000', '方正县', '黑龙江,哈尔滨,方正', '128.829536', '45.851695', 1);
INSERT INTO `eb_system_city` VALUES (1056, 147676, 2, 145666, '230125000000', '宾县', '黑龙江,哈尔滨,宾县', '127.466634', '45.745918', 1);
INSERT INTO `eb_system_city` VALUES (1057, 147884, 2, 145666, '230126000000', '巴彦县', '黑龙江,哈尔滨,巴彦', '127.403182', '46.085379', 1);
INSERT INTO `eb_system_city` VALUES (1058, 148060, 2, 145666, '230127000000', '木兰县', '黑龙江,哈尔滨,木兰', '128.043466', '45.950582', 1);
INSERT INTO `eb_system_city` VALUES (1059, 148178, 2, 145666, '230128000000', '通河县', '黑龙江,哈尔滨,通河', '128.749352', '45.972425', 1);
INSERT INTO `eb_system_city` VALUES (1060, 148351, 2, 145666, '230129000000', '延寿县', '黑龙江,哈尔滨,延寿', '128.331644', '45.451897', 1);
INSERT INTO `eb_system_city` VALUES (1061, 148502, 2, 145666, '230183000000', '尚志市', '黑龙江,哈尔滨,尚志', '128.009895', '45.209586', 1);
INSERT INTO `eb_system_city` VALUES (1062, 148755, 2, 145666, '230184000000', '五常市', '黑龙江,哈尔滨,五常', '127.167619', '44.931992', 1);
INSERT INTO `eb_system_city` VALUES (1063, 149080, 2, 149079, '230201000000', '市辖区', '黑龙江,齐齐哈尔', '123.918186', '47.354348', 1);
INSERT INTO `eb_system_city` VALUES (1064, 149081, 2, 149079, '230202000000', '龙沙区', '黑龙江,齐齐哈尔,龙沙', '123.957531', '47.317309', 1);
INSERT INTO `eb_system_city` VALUES (1065, 149129, 2, 149079, '230203000000', '建华区', '黑龙江,齐齐哈尔,建华', '123.955464', '47.354364', 1);
INSERT INTO `eb_system_city` VALUES (1066, 149173, 2, 149079, '230204000000', '铁锋区', '黑龙江,齐齐哈尔,铁锋', '123.978293', '47.340518', 1);
INSERT INTO `eb_system_city` VALUES (1067, 149231, 2, 149079, '230205000000', '昂昂溪区', '黑龙江,齐齐哈尔,昂昂溪', '123.822401', '47.155160', 1);
INSERT INTO `eb_system_city` VALUES (1068, 149266, 2, 149079, '230206000000', '富拉尔基区', '黑龙江,齐齐哈尔,富拉尔基', '123.629190', '47.208843', 1);
INSERT INTO `eb_system_city` VALUES (1069, 149317, 2, 149079, '230207000000', '碾子山区', '黑龙江,齐齐哈尔,碾子山', '122.887775', '47.516872', 1);
INSERT INTO `eb_system_city` VALUES (1070, 149338, 2, 149079, '230208000000', '梅里斯达斡尔族区', '黑龙江,齐齐哈尔,梅里斯', '123.752910', '47.309537', 1);
INSERT INTO `eb_system_city` VALUES (1071, 149404, 2, 149079, '230221000000', '龙江县', '黑龙江,齐齐哈尔,龙江', '123.205323', '47.338665', 1);
INSERT INTO `eb_system_city` VALUES (1072, 149588, 2, 149079, '230223000000', '依安县', '黑龙江,齐齐哈尔,依安', '125.306279', '47.893548', 1);
INSERT INTO `eb_system_city` VALUES (1073, 149767, 2, 149079, '230224000000', '泰来县', '黑龙江,齐齐哈尔,泰来', '123.416631', '46.393694', 1);
INSERT INTO `eb_system_city` VALUES (1074, 149896, 2, 149079, '230225000000', '甘南县', '黑龙江,齐齐哈尔,甘南', '123.507429', '47.922406', 1);
INSERT INTO `eb_system_city` VALUES (1075, 150046, 2, 149079, '230227000000', '富裕县', '黑龙江,齐齐哈尔,富裕', '124.473793', '47.774347', 1);
INSERT INTO `eb_system_city` VALUES (1076, 150168, 2, 149079, '230229000000', '克山县', '黑龙江,齐齐哈尔,克山', '125.875705', '48.037031', 1);
INSERT INTO `eb_system_city` VALUES (1077, 150337, 2, 149079, '230230000000', '克东县', '黑龙江,齐齐哈尔,克东', '126.248721', '48.042060', 1);
INSERT INTO `eb_system_city` VALUES (1078, 150471, 2, 149079, '230231000000', '拜泉县', '黑龙江,齐齐哈尔,拜泉', '126.100213', '47.595851', 1);
INSERT INTO `eb_system_city` VALUES (1079, 150680, 2, 149079, '230281000000', '讷河市', '黑龙江,齐齐哈尔,讷河', '124.884244', '48.484099', 1);
INSERT INTO `eb_system_city` VALUES (1080, 150916, 2, 150915, '230301000000', '市辖区', '黑龙江,鸡西', '130.969333', '45.295075', 1);
INSERT INTO `eb_system_city` VALUES (1081, 150917, 2, 150915, '230302000000', '鸡冠区', '黑龙江,鸡西,鸡冠', '130.980894', '45.304073', 1);
INSERT INTO `eb_system_city` VALUES (1082, 150984, 2, 150915, '230303000000', '恒山区', '黑龙江,鸡西,恒山', '130.904963', '45.210668', 1);
INSERT INTO `eb_system_city` VALUES (1083, 151039, 2, 150915, '230304000000', '滴道区', '黑龙江,鸡西,滴道', '130.843613', '45.348764', 1);
INSERT INTO `eb_system_city` VALUES (1084, 151084, 2, 150915, '230305000000', '梨树区', '黑龙江,鸡西,梨树', '130.696990', '45.092046', 1);
INSERT INTO `eb_system_city` VALUES (1085, 151113, 2, 150915, '230306000000', '城子河区', '黑龙江,鸡西,城子河', '131.011304', '45.336970', 1);
INSERT INTO `eb_system_city` VALUES (1086, 151154, 2, 150915, '230307000000', '麻山区', '黑龙江,鸡西,麻山', '130.478187', '45.212088', 1);
INSERT INTO `eb_system_city` VALUES (1087, 151177, 2, 150915, '230321000000', '鸡东县', '黑龙江,鸡西,鸡东', '131.124080', '45.260412', 1);
INSERT INTO `eb_system_city` VALUES (1088, 151347, 2, 150915, '230381000000', '虎林市', '黑龙江,鸡西,虎林', '132.937210', '45.762686', 1);
INSERT INTO `eb_system_city` VALUES (1089, 151577, 2, 150915, '230382000000', '密山市', '黑龙江,鸡西,密山', '131.846636', '45.529775', 1);
INSERT INTO `eb_system_city` VALUES (1090, 151831, 2, 151830, '230401000000', '市辖区', '黑龙江,鹤岗', '130.297964', '47.349916', 1);
INSERT INTO `eb_system_city` VALUES (1091, 151832, 2, 151830, '230402000000', '向阳区', '黑龙江,鹤岗,向阳', '130.294309', '47.342478', 1);
INSERT INTO `eb_system_city` VALUES (1092, 151855, 2, 151830, '230403000000', '工农区', '黑龙江,鹤岗,工农', '130.274684', '47.318781', 1);
INSERT INTO `eb_system_city` VALUES (1093, 151880, 2, 151830, '230404000000', '南山区', '黑龙江,鹤岗,南山', '130.287057', '47.315127', 1);
INSERT INTO `eb_system_city` VALUES (1094, 151912, 2, 151830, '230405000000', '兴安区', '黑龙江,鹤岗,兴安', '130.239245', '47.252850', 1);
INSERT INTO `eb_system_city` VALUES (1095, 151947, 2, 151830, '230406000000', '东山区', '黑龙江,鹤岗,东山', '130.317062', '47.338535', 1);
INSERT INTO `eb_system_city` VALUES (1096, 152026, 2, 151830, '230407000000', '兴山区', '黑龙江,鹤岗,兴山', '130.303574', '47.357666', 1);
INSERT INTO `eb_system_city` VALUES (1097, 152047, 2, 151830, '230421000000', '萝北县', '黑龙江,鹤岗,萝北', '130.828626', '47.577495', 1);
INSERT INTO `eb_system_city` VALUES (1098, 152237, 2, 151830, '230422000000', '绥滨县', '黑龙江,鹤岗,绥滨', '131.852759', '47.289116', 1);
INSERT INTO `eb_system_city` VALUES (1099, 152414, 2, 152413, '230501000000', '市辖区', '黑龙江,双鸭山', '131.159133', '46.646508', 1);
INSERT INTO `eb_system_city` VALUES (1100, 152415, 2, 152413, '230502000000', '尖山区', '黑龙江,双鸭山,尖山', '131.158416', '46.646350', 1);
INSERT INTO `eb_system_city` VALUES (1101, 152469, 2, 152413, '230503000000', '岭东区', '黑龙江,双鸭山,岭东', '131.164724', '46.592721', 1);
INSERT INTO `eb_system_city` VALUES (1102, 152508, 2, 152413, '230505000000', '四方台区', '黑龙江,双鸭山,四方台', '131.334503', '46.594316', 1);
INSERT INTO `eb_system_city` VALUES (1103, 152544, 2, 152413, '230506000000', '宝山区', '黑龙江,双鸭山,宝山', '131.401589', '46.577167', 1);
INSERT INTO `eb_system_city` VALUES (1104, 152590, 2, 152413, '230521000000', '集贤县', '黑龙江,双鸭山,集贤', '131.140483', '46.728377', 1);
INSERT INTO `eb_system_city` VALUES (1105, 152810, 2, 152413, '230522000000', '友谊县', '黑龙江,双鸭山,友谊', '131.808064', '46.767299', 1);
INSERT INTO `eb_system_city` VALUES (1106, 152910, 2, 152413, '230523000000', '宝清县', '黑龙江,双鸭山,宝清', '132.197243', '46.326925', 1);
INSERT INTO `eb_system_city` VALUES (1107, 153142, 2, 152413, '230524000000', '饶河县', '黑龙江,双鸭山,饶河', '134.013872', '46.798164', 1);
INSERT INTO `eb_system_city` VALUES (1108, 153314, 2, 153313, '230601000000', '市辖区', '黑龙江,大庆', '125.103784', '46.589309', 1);
INSERT INTO `eb_system_city` VALUES (1109, 153315, 2, 153313, '230602000000', '萨尔图区', '黑龙江,大庆,萨尔图', '125.114643', '46.596356', 1);
INSERT INTO `eb_system_city` VALUES (1110, 153371, 2, 153313, '230603000000', '龙凤区', '黑龙江,大庆,龙凤', '125.135326', '46.562247', 1);
INSERT INTO `eb_system_city` VALUES (1111, 153423, 2, 153313, '230604000000', '让胡路区', '黑龙江,大庆,让胡路', '124.870597', '46.652358', 1);
INSERT INTO `eb_system_city` VALUES (1112, 153513, 2, 153313, '230605000000', '红岗区', '黑龙江,大庆,红岗', '124.891039', '46.398418', 1);
INSERT INTO `eb_system_city` VALUES (1113, 153561, 2, 153313, '230606000000', '大同区', '黑龙江,大庆,大同', '124.812364', '46.039828', 1);
INSERT INTO `eb_system_city` VALUES (1114, 153659, 2, 153313, '230621000000', '肇州县', '黑龙江,大庆,肇州', '125.268643', '45.699066', 1);
INSERT INTO `eb_system_city` VALUES (1115, 153791, 2, 153313, '230622000000', '肇源县', '黑龙江,大庆,肇源', '125.078223', '45.519320', 1);
INSERT INTO `eb_system_city` VALUES (1116, 153974, 2, 153313, '230623000000', '林甸县', '黑龙江,大庆,林甸', '124.863603', '47.171717', 1);
INSERT INTO `eb_system_city` VALUES (1117, 154082, 2, 153313, '230624000000', '杜尔伯特蒙古族自治县', '黑龙江,大庆,杜尔伯特', '124.446705', '46.866580', 1);
INSERT INTO `eb_system_city` VALUES (1118, 154202, 2, 154201, '230701000000', '市辖区', '黑龙江,伊春', '128.841147', '47.727536', 1);
INSERT INTO `eb_system_city` VALUES (1119, 154203, 2, 154201, '230702000000', '伊春区', '黑龙江,伊春,伊春', '128.907303', '47.728171', 1);
INSERT INTO `eb_system_city` VALUES (1120, 154252, 2, 154201, '230703000000', '南岔区', '黑龙江,伊春,南岔', '129.283467', '47.138035', 1);
INSERT INTO `eb_system_city` VALUES (1121, 154342, 2, 154201, '230704000000', '友好区', '黑龙江,伊春,友好', '128.840750', '47.853778', 1);
INSERT INTO `eb_system_city` VALUES (1122, 154389, 2, 154201, '230705000000', '西林区', '黑龙江,伊春,西林', '129.312851', '47.480735', 1);
INSERT INTO `eb_system_city` VALUES (1123, 154404, 2, 154201, '230706000000', '翠峦区', '黑龙江,伊春,翠峦', '128.669859', '47.726728', 1);
INSERT INTO `eb_system_city` VALUES (1124, 154434, 2, 154201, '230707000000', '新青区', '黑龙江,伊春,新青', '129.533600', '48.290455', 1);
INSERT INTO `eb_system_city` VALUES (1125, 154473, 2, 154201, '230708000000', '美溪区', '黑龙江,伊春,美溪', '129.129314', '47.635090', 1);
INSERT INTO `eb_system_city` VALUES (1126, 154511, 2, 154201, '230709000000', '金山屯区', '黑龙江,伊春,金山屯', '129.429117', '47.413074', 1);
INSERT INTO `eb_system_city` VALUES (1127, 154547, 2, 154201, '230710000000', '五营区', '黑龙江,伊春,五营', '129.245344', '48.107910', 1);
INSERT INTO `eb_system_city` VALUES (1128, 154579, 2, 154201, '230711000000', '乌马河区', '黑龙江,伊春,乌马河', '128.799478', '47.727687', 1);
INSERT INTO `eb_system_city` VALUES (1129, 154616, 2, 154201, '230712000000', '汤旺河区', '黑龙江,伊春,汤旺河', '129.571108', '48.454651', 1);
INSERT INTO `eb_system_city` VALUES (1130, 154659, 2, 154201, '230713000000', '带岭区', '黑龙江,伊春,带岭', '129.020793', '47.028397', 1);
INSERT INTO `eb_system_city` VALUES (1131, 154695, 2, 154201, '230714000000', '乌伊岭区', '黑龙江,伊春,乌伊岭', '129.437920', '48.590323', 1);
INSERT INTO `eb_system_city` VALUES (1132, 154729, 2, 154201, '230715000000', '红星区', '黑龙江,伊春,红星', '129.390983', '48.239432', 1);
INSERT INTO `eb_system_city` VALUES (1133, 154759, 2, 154201, '230716000000', '上甘岭区', '黑龙江,伊春,上甘岭', '129.024260', '47.974708', 1);
INSERT INTO `eb_system_city` VALUES (1134, 154793, 2, 154201, '230722000000', '嘉荫县', '黑龙江,伊春,嘉荫', '130.403564', '48.889109', 1);
INSERT INTO `eb_system_city` VALUES (1135, 154899, 2, 154201, '230781000000', '铁力市', '黑龙江,伊春,铁力', '128.032422', '46.986640', 1);
INSERT INTO `eb_system_city` VALUES (1136, 155077, 2, 155076, '230801000000', '市辖区', '黑龙江,佳木斯', '130.318917', '46.799922', 1);
INSERT INTO `eb_system_city` VALUES (1137, 155078, 2, 155076, '230803000000', '向阳区', '黑龙江,佳木斯,向阳', '130.365346', '46.807790', 1);
INSERT INTO `eb_system_city` VALUES (1138, 155166, 2, 155076, '230804000000', '前进区', '黑龙江,佳木斯,前进', '130.375063', '46.814103', 1);
INSERT INTO `eb_system_city` VALUES (1139, 155191, 2, 155076, '230805000000', '东风区', '黑龙江,佳木斯,东风', '130.403664', '46.822572', 1);
INSERT INTO `eb_system_city` VALUES (1140, 155254, 2, 155076, '230811000000', '郊区', '黑龙江,佳木斯,郊区', '130.327195', '46.810086', 1);
INSERT INTO `eb_system_city` VALUES (1141, 155435, 2, 155076, '230822000000', '桦南县', '黑龙江,佳木斯,桦南', '130.553343', '46.239185', 1);
INSERT INTO `eb_system_city` VALUES (1142, 155702, 2, 155076, '230826000000', '桦川县', '黑龙江,佳木斯,桦川', '130.719081', '47.023001', 1);
INSERT INTO `eb_system_city` VALUES (1143, 155838, 2, 155076, '230828000000', '汤原县', '黑龙江,佳木斯,汤原', '129.905072', '46.730706', 1);
INSERT INTO `eb_system_city` VALUES (1144, 156034, 2, 155076, '230881000000', '同江市', '黑龙江,佳木斯,同江', '132.510919', '47.642707', 1);
INSERT INTO `eb_system_city` VALUES (1145, 156209, 2, 155076, '230882000000', '富锦市', '黑龙江,佳木斯,富锦', '132.037686', '47.250108', 1);
INSERT INTO `eb_system_city` VALUES (1146, 156599, 2, 155076, '230883000000', '抚远市', '黑龙江,佳木斯,抚远', '134.307884', '48.364687', 1);
INSERT INTO `eb_system_city` VALUES (1147, 156714, 2, 156713, '230901000000', '市辖区', '黑龙江,七台河', '131.003138', '45.771726', 1);
INSERT INTO `eb_system_city` VALUES (1148, 156715, 2, 156713, '230902000000', '新兴区', '黑龙江,七台河,新兴', '130.932143', '45.815930', 1);
INSERT INTO `eb_system_city` VALUES (1149, 156815, 2, 156713, '230903000000', '桃山区', '黑龙江,七台河,桃山', '131.020275', '45.765594', 1);
INSERT INTO `eb_system_city` VALUES (1150, 156865, 2, 156713, '230904000000', '茄子河区', '黑龙江,七台河,茄子河', '131.068075', '45.785215', 1);
INSERT INTO `eb_system_city` VALUES (1151, 156956, 2, 156713, '230921000000', '勃利县', '黑龙江,七台河,勃利', '130.592093', '45.755507', 1);
INSERT INTO `eb_system_city` VALUES (1152, 157131, 2, 157130, '231001000000', '市辖区', '黑龙江,牡丹江', '129.633168', '44.551653', 1);
INSERT INTO `eb_system_city` VALUES (1153, 157132, 2, 157130, '231002000000', '东安区', '黑龙江,牡丹江,东安', '129.626642', '44.581360', 1);
INSERT INTO `eb_system_city` VALUES (1154, 157170, 2, 157130, '231003000000', '阳明区', '黑龙江,牡丹江,阳明', '129.635615', '44.596104', 1);
INSERT INTO `eb_system_city` VALUES (1155, 157273, 2, 157130, '231004000000', '爱民区', '黑龙江,牡丹江,爱民', '129.591657', '44.596053', 1);
INSERT INTO `eb_system_city` VALUES (1156, 157321, 2, 157130, '231005000000', '西安区', '黑龙江,牡丹江,西安', '129.616121', '44.577625', 1);
INSERT INTO `eb_system_city` VALUES (1157, 157406, 2, 157130, '231025000000', '林口县', '黑龙江,牡丹江,林口', '130.284033', '45.278046', 1);
INSERT INTO `eb_system_city` VALUES (1158, 157646, 2, 157130, '231081000000', '绥芬河市', '黑龙江,牡丹江,绥芬河', '131.152546', '44.412309', 1);
INSERT INTO `eb_system_city` VALUES (1159, 157678, 2, 157130, '231083000000', '海林市', '黑龙江,牡丹江,海林', '129.380482', '44.594213', 1);
INSERT INTO `eb_system_city` VALUES (1160, 157911, 2, 157130, '231084000000', '宁安市', '黑龙江,牡丹江,宁安', '129.482851', '44.340720', 1);
INSERT INTO `eb_system_city` VALUES (1161, 158233, 2, 157130, '231085000000', '穆棱市', '黑龙江,牡丹江,穆棱', '130.524437', '44.918813', 1);
INSERT INTO `eb_system_city` VALUES (1162, 158470, 2, 157130, '231086000000', '东宁市', '黑龙江,牡丹江,东宁', '131.122915', '44.087585', 1);
INSERT INTO `eb_system_city` VALUES (1163, 158624, 2, 158623, '231101000000', '市辖区', '黑龙江,黑河', '127.528560', '50.245329', 1);
INSERT INTO `eb_system_city` VALUES (1164, 158625, 2, 158623, '231102000000', '爱辉区', '黑龙江,黑河,爱辉', '127.500451', '50.252106', 1);
INSERT INTO `eb_system_city` VALUES (1165, 158797, 2, 158623, '231121000000', '嫩江县', '黑龙江,黑河,嫩江', '125.221192', '49.185766', 1);
INSERT INTO `eb_system_city` VALUES (1166, 159105, 2, 158623, '231123000000', '逊克县', '黑龙江,黑河,逊克', '128.478750', '49.564252', 1);
INSERT INTO `eb_system_city` VALUES (1167, 159220, 2, 158623, '231124000000', '孙吴县', '黑龙江,黑河,孙吴', '127.336304', '49.425652', 1);
INSERT INTO `eb_system_city` VALUES (1168, 159359, 2, 158623, '231181000000', '北安市', '黑龙江,黑河,北安', '126.491199', '48.241374', 1);
INSERT INTO `eb_system_city` VALUES (1169, 159526, 2, 158623, '231182000000', '五大连池市', '黑龙江,黑河,五大连池', '126.205516', '48.517257', 1);
INSERT INTO `eb_system_city` VALUES (1170, 159770, 2, 159769, '231201000000', '市辖区', '黑龙江,绥化', '126.968887', '46.653845', 1);
INSERT INTO `eb_system_city` VALUES (1171, 159771, 2, 159769, '231202000000', '北林区', '黑龙江,绥化,北林', '126.985593', '46.637344', 1);
INSERT INTO `eb_system_city` VALUES (1172, 159985, 2, 159769, '231221000000', '望奎县', '黑龙江,绥化,望奎', '126.486076', '46.832719', 1);
INSERT INTO `eb_system_city` VALUES (1173, 160128, 2, 159769, '231222000000', '兰西县', '黑龙江,绥化,兰西', '126.288113', '46.252447', 1);
INSERT INTO `eb_system_city` VALUES (1174, 160271, 2, 159769, '231223000000', '青冈县', '黑龙江,绥化,青冈', '126.113860', '46.689671', 1);
INSERT INTO `eb_system_city` VALUES (1175, 160478, 2, 159769, '231224000000', '庆安县', '黑龙江,绥化,庆安', '127.507825', '46.880102', 1);
INSERT INTO `eb_system_city` VALUES (1176, 160610, 2, 159769, '231225000000', '明水县', '黑龙江,绥化,明水', '125.906301', '47.173426', 1);
INSERT INTO `eb_system_city` VALUES (1177, 160744, 2, 159769, '231226000000', '绥棱县', '黑龙江,绥化,绥棱', '127.114832', '47.236015', 1);
INSERT INTO `eb_system_city` VALUES (1178, 160910, 2, 159769, '231281000000', '安达市', '黑龙江,绥化,安达', '125.352188', '46.423508', 1);
INSERT INTO `eb_system_city` VALUES (1179, 161079, 2, 159769, '231282000000', '肇东市', '黑龙江,绥化,肇东', '125.961814', '46.051126', 1);
INSERT INTO `eb_system_city` VALUES (1180, 161331, 2, 159769, '231283000000', '海伦市', '黑龙江,绥化,海伦', '126.973143', '47.461971', 1);
INSERT INTO `eb_system_city` VALUES (1181, 161652, 2, 161651, '232721000000', '呼玛县', '黑龙江,大兴安岭,呼玛', '126.665319', '51.725637', 1);
INSERT INTO `eb_system_city` VALUES (1182, 161720, 2, 161651, '232722000000', '塔河县', '黑龙江,大兴安岭,塔河', '124.709996', '52.334457', 1);
INSERT INTO `eb_system_city` VALUES (1183, 161754, 2, 161651, '232723000000', '漠河县', '黑龙江,大兴安岭,漠河', '122.538592', '52.972272', 1);
INSERT INTO `eb_system_city` VALUES (1184, 161794, 2, 161793, '310101000000', '黄浦区', '上海,黄浦', '121.484443', '31.231763', 1);
INSERT INTO `eb_system_city` VALUES (1185, 161988, 2, 161793, '310104000000', '徐汇区', '上海,徐汇', '121.436525', '31.188523', 1);
INSERT INTO `eb_system_city` VALUES (1186, 162309, 2, 161793, '310105000000', '长宁区', '上海,长宁', '121.424624', '31.220367', 1);
INSERT INTO `eb_system_city` VALUES (1187, 162505, 2, 161793, '310106000000', '静安区', '上海,静安', '121.459384', '31.247105', 1);
INSERT INTO `eb_system_city` VALUES (1188, 162794, 2, 161793, '310107000000', '普陀区', '上海,普陀', '121.395555', '31.249840', 1);
INSERT INTO `eb_system_city` VALUES (1189, 163069, 2, 161793, '310109000000', '虹口区', '上海,虹口', '121.505133', '31.264600', 1);
INSERT INTO `eb_system_city` VALUES (1190, 163290, 2, 161793, '310110000000', '杨浦区', '上海,杨浦', '121.526077', '31.259541', 1);
INSERT INTO `eb_system_city` VALUES (1191, 163621, 2, 161793, '310112000000', '闵行区', '上海,闵行', '121.381709', '31.112813', 1);
INSERT INTO `eb_system_city` VALUES (1192, 164194, 2, 161793, '310113000000', '宝山区', '上海,宝山', '121.489612', '31.405457', 1);
INSERT INTO `eb_system_city` VALUES (1193, 164682, 2, 161793, '310114000000', '嘉定区', '上海,嘉定', '121.265300', '31.375602', 1);
INSERT INTO `eb_system_city` VALUES (1194, 165026, 2, 161793, '310115000000', '浦东新区', '上海,浦东', '121.544379', '31.221517', 1);
INSERT INTO `eb_system_city` VALUES (1195, 166350, 2, 161793, '310116000000', '金山区', '上海,金山', '121.341970', '30.741991', 1);
INSERT INTO `eb_system_city` VALUES (1196, 166585, 2, 161793, '310117000000', '松江区', '上海,松江', '121.227747', '31.032243', 1);
INSERT INTO `eb_system_city` VALUES (1197, 166927, 2, 161793, '310118000000', '青浦区', '上海,青浦', '121.124178', '31.150681', 1);
INSERT INTO `eb_system_city` VALUES (1198, 167228, 2, 161793, '310120000000', '奉贤区', '上海,奉贤', '121.474042', '30.917795', 1);
INSERT INTO `eb_system_city` VALUES (1199, 167533, 2, 161793, '310151000000', '崇明区', '上海,崇明', '121.473701', '31.230416', 1);
INSERT INTO `eb_system_city` VALUES (1200, 167906, 2, 167905, '320101000000', '市辖区', '江苏,南京', '118.796877', '32.060255', 1);
INSERT INTO `eb_system_city` VALUES (1201, 167907, 2, 167905, '320102000000', '玄武区', '江苏,南京,玄武', '118.797861', '32.048687', 1);
INSERT INTO `eb_system_city` VALUES (1202, 167974, 2, 167905, '320104000000', '秦淮区', '江苏,南京,秦淮', '118.794744', '32.039133', 1);
INSERT INTO `eb_system_city` VALUES (1203, 168104, 2, 167905, '320105000000', '建邺区', '江苏,南京,建邺', '118.731694', '32.003552', 1);
INSERT INTO `eb_system_city` VALUES (1204, 168174, 2, 167905, '320106000000', '鼓楼区', '江苏,南京,鼓楼', '118.769790', '32.066336', 1);
INSERT INTO `eb_system_city` VALUES (1205, 168310, 2, 167905, '320111000000', '浦口区', '江苏,南京,浦口', '118.627895', '32.059093', 1);
INSERT INTO `eb_system_city` VALUES (1206, 168451, 2, 167905, '320113000000', '栖霞区', '江苏,南京,栖霞', '118.909246', '32.096228', 1);
INSERT INTO `eb_system_city` VALUES (1207, 168604, 2, 167905, '320114000000', '雨花台区', '江苏,南京,雨花台', '118.779073', '31.991347', 1);
INSERT INTO `eb_system_city` VALUES (1208, 168704, 2, 167905, '320115000000', '江宁区', '江苏,南京,江宁', '118.839685', '31.953702', 1);
INSERT INTO `eb_system_city` VALUES (1209, 168925, 2, 167905, '320116000000', '六合区', '江苏,南京,六合', '118.821401', '32.322247', 1);
INSERT INTO `eb_system_city` VALUES (1210, 169096, 2, 167905, '320117000000', '溧水区', '江苏,南京,溧水', '119.028296', '31.651125', 1);
INSERT INTO `eb_system_city` VALUES (1211, 169214, 2, 167905, '320118000000', '高淳区', '江苏,南京,高淳', '118.892085', '31.328471', 1);
INSERT INTO `eb_system_city` VALUES (1212, 169376, 2, 169375, '320201000000', '市辖区', '江苏,无锡', '120.311910', '31.491169', 1);
INSERT INTO `eb_system_city` VALUES (1213, 169377, 2, 169375, '320205000000', '锡山区', '江苏,无锡,锡山', '120.357858', '31.589715', 1);
INSERT INTO `eb_system_city` VALUES (1214, 169507, 2, 169375, '320206000000', '惠山区', '江苏,无锡,惠山', '120.298500', '31.681012', 1);
INSERT INTO `eb_system_city` VALUES (1215, 169628, 2, 169375, '320211000000', '滨湖区', '江苏,无锡,滨湖', '120.282692', '31.527954', 1);
INSERT INTO `eb_system_city` VALUES (1216, 169751, 2, 169375, '320213000000', '梁溪区', '江苏,无锡,梁溪', '120.296591', '31.575719', 1);
INSERT INTO `eb_system_city` VALUES (1217, 169924, 2, 169375, '320214000000', '新吴区', '江苏,无锡,新吴', '120.352778', '31.550957', 1);
INSERT INTO `eb_system_city` VALUES (1218, 170064, 2, 169375, '320281000000', '江阴市', '江苏,无锡,江阴', '120.284939', '31.920658', 1);
INSERT INTO `eb_system_city` VALUES (1219, 170390, 2, 169375, '320282000000', '宜兴市', '江苏,无锡,宜兴', '119.823308', '31.340637', 1);
INSERT INTO `eb_system_city` VALUES (1220, 170725, 2, 170724, '320301000000', '市辖区', '江苏,徐州', '117.284124', '34.205768', 1);
INSERT INTO `eb_system_city` VALUES (1221, 170726, 2, 170724, '320302000000', '鼓楼区', '江苏,徐州,鼓楼', '117.185591', '34.288511', 1);
INSERT INTO `eb_system_city` VALUES (1222, 170800, 2, 170724, '320303000000', '云龙区', '江苏,徐州,云龙', '117.251560', '34.253167', 1);
INSERT INTO `eb_system_city` VALUES (1223, 170886, 2, 170724, '320305000000', '贾汪区', '江苏,徐州,贾汪', '117.466687', '34.435506', 1);
INSERT INTO `eb_system_city` VALUES (1224, 171049, 2, 170724, '320311000000', '泉山区', '江苏,徐州,泉山', '117.193805', '34.244258', 1);
INSERT INTO `eb_system_city` VALUES (1225, 171182, 2, 170724, '320312000000', '铜山区', '江苏,徐州,铜山', '117.169421', '34.180700', 1);
INSERT INTO `eb_system_city` VALUES (1226, 171537, 2, 170724, '320321000000', '丰县', '江苏,徐州,丰县', '116.595391', '34.693906', 1);
INSERT INTO `eb_system_city` VALUES (1227, 171966, 2, 170724, '320322000000', '沛县', '江苏,徐州,沛县', '116.937532', '34.721656', 1);
INSERT INTO `eb_system_city` VALUES (1228, 172381, 2, 170724, '320324000000', '睢宁县', '江苏,徐州,睢宁', '117.941563', '33.912598', 1);
INSERT INTO `eb_system_city` VALUES (1229, 172804, 2, 170724, '320381000000', '新沂市', '江苏,徐州,新沂', '118.354537', '34.369580', 1);
INSERT INTO `eb_system_city` VALUES (1230, 173105, 2, 170724, '320382000000', '邳州市', '江苏,徐州,邳州', '118.012531', '34.338888', 1);
INSERT INTO `eb_system_city` VALUES (1231, 173636, 2, 173635, '320401000000', '市辖区', '江苏,常州', '119.973987', '31.810689', 1);
INSERT INTO `eb_system_city` VALUES (1232, 173637, 2, 173635, '320402000000', '天宁区', '江苏,常州,天宁', '119.974991', '31.779619', 1);
INSERT INTO `eb_system_city` VALUES (1233, 173773, 2, 173635, '320404000000', '钟楼区', '江苏,常州,钟楼', '119.902112', '31.802192', 1);
INSERT INTO `eb_system_city` VALUES (1234, 173891, 2, 173635, '320411000000', '新北区', '江苏,常州,新北', '119.972182', '31.830641', 1);
INSERT INTO `eb_system_city` VALUES (1235, 174038, 2, 173635, '320412000000', '武进区', '江苏,常州,武进', '119.942437', '31.701188', 1);
INSERT INTO `eb_system_city` VALUES (1236, 174347, 2, 173635, '320413000000', '金坛区', '江苏,常州,金坛', '119.597897', '31.723247', 1);
INSERT INTO `eb_system_city` VALUES (1237, 174508, 2, 173635, '320481000000', '溧阳市', '江苏,常州,溧阳', '119.484211', '31.416911', 1);
INSERT INTO `eb_system_city` VALUES (1238, 174765, 2, 174764, '320501000000', '市辖区', '江苏,苏州', '120.585315', '31.298886', 1);
INSERT INTO `eb_system_city` VALUES (1239, 174766, 2, 174764, '320505000000', '虎丘区', '江苏,苏州,虎丘', '120.566833', '31.294845', 1);
INSERT INTO `eb_system_city` VALUES (1240, 174872, 2, 174764, '320506000000', '吴中区', '江苏,苏州,吴中', '120.631898', '31.264212', 1);
INSERT INTO `eb_system_city` VALUES (1241, 175088, 2, 174764, '320507000000', '相城区', '江苏,苏州,相城', '120.642663', '31.369088', 1);
INSERT INTO `eb_system_city` VALUES (1242, 175247, 2, 174764, '320508000000', '姑苏区', '江苏,苏州,姑苏', '120.617296', '31.336392', 1);
INSERT INTO `eb_system_city` VALUES (1243, 175444, 2, 174764, '320509000000', '吴江区', '江苏,苏州,吴江', '120.645158', '31.138677', 1);
INSERT INTO `eb_system_city` VALUES (1244, 175765, 2, 174764, '320581000000', '常熟市', '江苏,苏州,常熟', '120.752481', '31.654376', 1);
INSERT INTO `eb_system_city` VALUES (1245, 176120, 2, 174764, '320582000000', '张家港市', '江苏,苏州,张家港', '120.553200', '31.870405', 1);
INSERT INTO `eb_system_city` VALUES (1246, 176424, 2, 174764, '320583000000', '昆山市', '江苏,苏州,昆山', '120.980737', '31.385598', 1);
INSERT INTO `eb_system_city` VALUES (1247, 176763, 2, 174764, '320585000000', '太仓市', '江苏,苏州,太仓', '121.130550', '31.457735', 1);
INSERT INTO `eb_system_city` VALUES (1248, 176921, 2, 176920, '320601000000', '市辖区', '江苏,南通', '120.894291', '31.980171', 1);
INSERT INTO `eb_system_city` VALUES (1249, 176922, 2, 176920, '320602000000', '崇川区', '江苏,南通,崇川', '120.857434', '32.009875', 1);
INSERT INTO `eb_system_city` VALUES (1250, 177040, 2, 176920, '320611000000', '港闸区', '江苏,南通,港闸', '120.818527', '32.032442', 1);
INSERT INTO `eb_system_city` VALUES (1251, 177119, 2, 176920, '320612000000', '通州区', '江苏,南通,通州', '121.075087', '32.064161', 1);
INSERT INTO `eb_system_city` VALUES (1252, 177415, 2, 176920, '320621000000', '海安县', '江苏,南通,海安', '120.467370', '32.533549', 1);
INSERT INTO `eb_system_city` VALUES (1253, 177665, 2, 176920, '320623000000', '如东县', '江苏,南通,如东', '121.185201', '32.331766', 1);
INSERT INTO `eb_system_city` VALUES (1254, 177946, 2, 176920, '320681000000', '启东市', '江苏,南通,启东', '121.657441', '31.808026', 1);
INSERT INTO `eb_system_city` VALUES (1255, 178291, 2, 176920, '320682000000', '如皋市', '江苏,南通,如皋', '120.574946', '32.370557', 1);
INSERT INTO `eb_system_city` VALUES (1256, 178669, 2, 176920, '320684000000', '海门市', '江苏,南通,海门', '121.181615', '31.871173', 1);
INSERT INTO `eb_system_city` VALUES (1257, 179000, 2, 178999, '320701000000', '市辖区', '江苏,连云港', '119.221611', '34.596653', 1);
INSERT INTO `eb_system_city` VALUES (1258, 179001, 2, 178999, '320703000000', '连云区', '江苏,连云港,连云', '119.338788', '34.760249', 1);
INSERT INTO `eb_system_city` VALUES (1259, 179081, 2, 178999, '320706000000', '海州区', '江苏,连云港,海州', '119.193710', '34.606756', 1);
INSERT INTO `eb_system_city` VALUES (1260, 179296, 2, 178999, '320707000000', '赣榆区', '江苏,连云港,赣榆', '119.173331', '34.841349', 1);
INSERT INTO `eb_system_city` VALUES (1261, 179786, 2, 178999, '320722000000', '东海县', '江苏,连云港,东海', '118.752842', '34.542309', 1);
INSERT INTO `eb_system_city` VALUES (1262, 180136, 2, 178999, '320723000000', '灌云县', '江苏,连云港,灌云', '119.239381', '34.284381', 1);
INSERT INTO `eb_system_city` VALUES (1263, 180493, 2, 178999, '320724000000', '灌南县', '江苏,连云港,灌南', '119.315651', '34.087135', 1);
INSERT INTO `eb_system_city` VALUES (1264, 180744, 2, 180743, '320801000000', '市辖区', '江苏,淮安', '119.015285', '33.610353', 1);
INSERT INTO `eb_system_city` VALUES (1265, 180745, 2, 180743, '320803000000', '淮安区', '江苏,淮安,淮安', '119.141099', '33.502869', 1);
INSERT INTO `eb_system_city` VALUES (1266, 181117, 2, 180743, '320804000000', '淮阴区', '江苏,淮安,淮阴', '119.034725', '33.631893', 1);
INSERT INTO `eb_system_city` VALUES (1267, 181401, 2, 180743, '320812000000', '清江浦区', '江苏,淮安,清江浦', '119.028099', '33.624341', 1);
INSERT INTO `eb_system_city` VALUES (1268, 181547, 2, 180743, '320813000000', '洪泽区', '江苏,淮安,洪泽', '119.015285', '33.610353', 1);
INSERT INTO `eb_system_city` VALUES (1269, 181681, 2, 180743, '320826000000', '涟水县', '江苏,淮安,涟水', '119.260335', '33.780960', 1);
INSERT INTO `eb_system_city` VALUES (1270, 182092, 2, 180743, '320830000000', '盱眙县', '江苏,淮安,盱眙', '118.544360', '33.011971', 1);
INSERT INTO `eb_system_city` VALUES (1271, 182372, 2, 180743, '320831000000', '金湖县', '江苏,淮安,金湖', '119.020585', '33.025433', 1);
INSERT INTO `eb_system_city` VALUES (1272, 182539, 2, 182538, '320901000000', '市辖区', '江苏,盐城', '120.163561', '33.347382', 1);
INSERT INTO `eb_system_city` VALUES (1273, 182540, 2, 182538, '320902000000', '亭湖区', '江苏,盐城,亭湖', '120.197358', '33.390536', 1);
INSERT INTO `eb_system_city` VALUES (1274, 182762, 2, 182538, '320903000000', '盐都区', '江苏,盐城,盐都', '120.153898', '33.338094', 1);
INSERT INTO `eb_system_city` VALUES (1275, 183048, 2, 182538, '320904000000', '大丰区', '江苏,盐城,大丰', '120.500858', '33.200331', 1);
INSERT INTO `eb_system_city` VALUES (1276, 183334, 2, 182538, '320921000000', '响水县', '江苏,盐城,响水', '119.578364', '34.199479', 1);
INSERT INTO `eb_system_city` VALUES (1277, 183510, 2, 182538, '320922000000', '滨海县', '江苏,盐城,滨海', '119.820831', '33.990334', 1);
INSERT INTO `eb_system_city` VALUES (1278, 183829, 2, 182538, '320923000000', '阜宁县', '江苏,盐城,阜宁', '119.802527', '33.759325', 1);
INSERT INTO `eb_system_city` VALUES (1279, 184188, 2, 182538, '320924000000', '射阳县', '江苏,盐城,射阳', '120.258053', '33.774806', 1);
INSERT INTO `eb_system_city` VALUES (1280, 184485, 2, 182538, '320925000000', '建湖县', '江苏,盐城,建湖', '119.798581', '33.464204', 1);
INSERT INTO `eb_system_city` VALUES (1281, 184748, 2, 182538, '320981000000', '东台市', '江苏,盐城,东台', '120.320331', '32.868440', 1);
INSERT INTO `eb_system_city` VALUES (1282, 185202, 2, 185201, '321001000000', '市辖区', '江苏,扬州', '119.412966', '32.394210', 1);
INSERT INTO `eb_system_city` VALUES (1283, 185203, 2, 185201, '321002000000', '广陵区', '江苏,扬州,广陵', '119.431849', '32.394720', 1);
INSERT INTO `eb_system_city` VALUES (1284, 185360, 2, 185201, '321003000000', '邗江区', '江苏,扬州,邗江', '119.398015', '32.377528', 1);
INSERT INTO `eb_system_city` VALUES (1285, 185555, 2, 185201, '321012000000', '江都区', '江苏,扬州,江都', '119.569989', '32.434672', 1);
INSERT INTO `eb_system_city` VALUES (1286, 185905, 2, 185201, '321023000000', '宝应县', '江苏,扬州,宝应', '119.360729', '33.240392', 1);
INSERT INTO `eb_system_city` VALUES (1287, 186203, 2, 185201, '321081000000', '仪征市', '江苏,扬州,仪征', '119.184766', '32.272258', 1);
INSERT INTO `eb_system_city` VALUES (1288, 186414, 2, 185201, '321084000000', '高邮市', '江苏,扬州,高邮', '119.459161', '32.781659', 1);
INSERT INTO `eb_system_city` VALUES (1289, 186658, 2, 186657, '321101000000', '市辖区', '江苏,镇江', '119.425836', '32.187849', 1);
INSERT INTO `eb_system_city` VALUES (1290, 186659, 2, 186657, '321102000000', '京口区', '江苏,镇江,京口', '119.470160', '32.198280', 1);
INSERT INTO `eb_system_city` VALUES (1291, 186734, 2, 186657, '321111000000', '润州区', '江苏,镇江,润州', '119.411945', '32.195333', 1);
INSERT INTO `eb_system_city` VALUES (1292, 186817, 2, 186657, '321112000000', '丹徒区', '江苏,镇江,丹徒', '119.433854', '32.131962', 1);
INSERT INTO `eb_system_city` VALUES (1293, 186919, 2, 186657, '321181000000', '丹阳市', '江苏,镇江,丹阳', '119.606536', '32.010117', 1);
INSERT INTO `eb_system_city` VALUES (1294, 187149, 2, 186657, '321182000000', '扬中市', '江苏,镇江,扬中', '119.797635', '32.234831', 1);
INSERT INTO `eb_system_city` VALUES (1295, 187235, 2, 186657, '321183000000', '句容市', '江苏,镇江,句容', '119.168695', '31.944999', 1);
INSERT INTO `eb_system_city` VALUES (1296, 187442, 2, 187441, '321201000000', '市辖区', '江苏,泰州', '119.923116', '32.455778', 1);
INSERT INTO `eb_system_city` VALUES (1297, 187443, 2, 187441, '321202000000', '海陵区', '江苏,泰州,海陵', '119.919425', '32.491016', 1);
INSERT INTO `eb_system_city` VALUES (1298, 187593, 2, 187441, '321203000000', '高港区', '江苏,泰州,高港', '119.881717', '32.318822', 1);
INSERT INTO `eb_system_city` VALUES (1299, 187693, 2, 187441, '321204000000', '姜堰区', '江苏,泰州,姜堰', '120.127934', '32.509155', 1);
INSERT INTO `eb_system_city` VALUES (1300, 188035, 2, 187441, '321281000000', '兴化市', '江苏,泰州,兴化', '119.852541', '32.910459', 1);
INSERT INTO `eb_system_city` VALUES (1301, 188752, 2, 187441, '321282000000', '靖江市', '江苏,泰州,靖江', '120.277138', '31.982751', 1);
INSERT INTO `eb_system_city` VALUES (1302, 189026, 2, 187441, '321283000000', '泰兴市', '江苏,泰州,泰兴', '120.051744', '32.171854', 1);
INSERT INTO `eb_system_city` VALUES (1303, 189403, 2, 189402, '321301000000', '市辖区', '江苏,宿迁', '118.275198', '33.963232', 1);
INSERT INTO `eb_system_city` VALUES (1304, 189404, 2, 189402, '321302000000', '宿城区', '江苏,宿迁,宿城', '118.242534', '33.963029', 1);
INSERT INTO `eb_system_city` VALUES (1305, 189637, 2, 189402, '321311000000', '宿豫区', '江苏,宿迁,宿豫', '118.330782', '33.946822', 1);
INSERT INTO `eb_system_city` VALUES (1306, 189850, 2, 189402, '321322000000', '沭阳县', '江苏,宿迁,沭阳', '118.804784', '34.111022', 1);
INSERT INTO `eb_system_city` VALUES (1307, 190377, 2, 189402, '321323000000', '泗阳县', '江苏,宿迁,泗阳', '118.703038', '33.723140', 1);
INSERT INTO `eb_system_city` VALUES (1308, 190642, 2, 189402, '321324000000', '泗洪县', '江苏,宿迁,泗洪', '118.223591', '33.476051', 1);
INSERT INTO `eb_system_city` VALUES (1309, 191021, 2, 191020, '330101000000', '市辖区', '浙江,杭州', '120.155070', '30.274084', 1);
INSERT INTO `eb_system_city` VALUES (1310, 191022, 2, 191020, '330102000000', '上城区', '浙江,杭州,上城', '120.169329', '30.242312', 1);
INSERT INTO `eb_system_city` VALUES (1311, 191083, 2, 191020, '330103000000', '下城区', '浙江,杭州,下城', '120.180895', '30.281714', 1);
INSERT INTO `eb_system_city` VALUES (1312, 191166, 2, 191020, '330104000000', '江干区', '浙江,杭州,江干', '120.205001', '30.257012', 1);
INSERT INTO `eb_system_city` VALUES (1313, 191360, 2, 191020, '330105000000', '拱墅区', '浙江,杭州,拱墅', '120.141406', '30.319037', 1);
INSERT INTO `eb_system_city` VALUES (1314, 191479, 2, 191020, '330106000000', '西湖区', '浙江,杭州,西湖', '120.130203', '30.259324', 1);
INSERT INTO `eb_system_city` VALUES (1315, 191693, 2, 191020, '330108000000', '滨江区', '浙江,杭州,滨江', '120.211816', '30.208560', 1);
INSERT INTO `eb_system_city` VALUES (1316, 191756, 2, 191020, '330109000000', '萧山区', '浙江,杭州,萧山', '120.264253', '30.183806', 1);
INSERT INTO `eb_system_city` VALUES (1317, 192388, 2, 191020, '330110000000', '余杭区', '浙江,杭州,余杭', '120.299402', '30.419045', 1);
INSERT INTO `eb_system_city` VALUES (1318, 192753, 2, 191020, '330111000000', '富阳区', '浙江,杭州,富阳', '119.960076', '30.048692', 1);
INSERT INTO `eb_system_city` VALUES (1319, 193085, 2, 191020, '330122000000', '桐庐县', '浙江,杭州,桐庐', '119.691434', '29.793535', 1);
INSERT INTO `eb_system_city` VALUES (1320, 193304, 2, 191020, '330127000000', '淳安县', '浙江,杭州,淳安', '119.041864', '29.608772', 1);
INSERT INTO `eb_system_city` VALUES (1321, 193766, 2, 191020, '330182000000', '建德市', '浙江,杭州,建德', '119.281164', '29.474871', 1);
INSERT INTO `eb_system_city` VALUES (1322, 194060, 2, 191020, '330185000000', '临安市', '浙江,杭州,临安', '119.724733', '30.233873', 1);
INSERT INTO `eb_system_city` VALUES (1323, 194396, 2, 194395, '330201000000', '市辖区', '浙江,宁波', '121.550357', '29.874556', 1);
INSERT INTO `eb_system_city` VALUES (1324, 194397, 2, 194395, '330203000000', '海曙区', '浙江,宁波,海曙', '121.551066', '29.859772', 1);
INSERT INTO `eb_system_city` VALUES (1325, 194484, 2, 194395, '330204000000', '江东区', '浙江,宁波,江东', '121.570383', '29.866819', 1);
INSERT INTO `eb_system_city` VALUES (1326, 194568, 2, 194395, '330205000000', '江北区', '浙江,宁波,江北', '121.555227', '29.886757', 1);
INSERT INTO `eb_system_city` VALUES (1327, 194747, 2, 194395, '330206000000', '北仑区', '浙江,宁波,北仑', '121.844618', '29.899044', 1);
INSERT INTO `eb_system_city` VALUES (1328, 195023, 2, 194395, '330211000000', '镇海区', '浙江,宁波,镇海', '121.716540', '29.948998', 1);
INSERT INTO `eb_system_city` VALUES (1329, 195132, 2, 194395, '330212000000', '鄞州区', '浙江,宁波,鄞州', '121.546603', '29.816511', 1);
INSERT INTO `eb_system_city` VALUES (1330, 195703, 2, 194395, '330225000000', '象山县', '浙江,宁波,象山', '121.869339', '29.476705', 1);
INSERT INTO `eb_system_city` VALUES (1331, 196257, 2, 194395, '330226000000', '宁海县', '浙江,宁波,宁海', '121.429477', '29.287939', 1);
INSERT INTO `eb_system_city` VALUES (1332, 196686, 2, 194395, '330281000000', '余姚市', '浙江,宁波,余姚', '121.154634', '30.037192', 1);
INSERT INTO `eb_system_city` VALUES (1333, 197031, 2, 194395, '330282000000', '慈溪市', '浙江,宁波,慈溪', '121.266579', '30.169665', 1);
INSERT INTO `eb_system_city` VALUES (1334, 197440, 2, 194395, '330283000000', '奉化市', '浙江,宁波,奉化', '121.406995', '29.655143', 1);
INSERT INTO `eb_system_city` VALUES (1335, 197851, 2, 197850, '330301000000', '市辖区', '浙江,温州', '120.699366', '27.994267', 1);
INSERT INTO `eb_system_city` VALUES (1336, 197852, 2, 197850, '330302000000', '鹿城区', '浙江,温州,鹿城', '120.655135', '28.015455', 1);
INSERT INTO `eb_system_city` VALUES (1337, 198091, 2, 197850, '330303000000', '龙湾区', '浙江,温州,龙湾', '120.811213', '27.932747', 1);
INSERT INTO `eb_system_city` VALUES (1338, 198210, 2, 197850, '330304000000', '瓯海区', '浙江,温州,瓯海', '120.614910', '27.966844', 1);
INSERT INTO `eb_system_city` VALUES (1339, 198508, 2, 197850, '330305000000', '洞头区', '浙江,温州,洞头', '121.157249', '27.836154', 1);
INSERT INTO `eb_system_city` VALUES (1340, 198619, 2, 197850, '330324000000', '永嘉县', '浙江,温州,永嘉', '120.682144', '28.150591', 1);
INSERT INTO `eb_system_city` VALUES (1341, 199581, 2, 197850, '330326000000', '平阳县', '浙江,温州,平阳', '120.565793', '27.661918', 1);
INSERT INTO `eb_system_city` VALUES (1342, 200239, 2, 197850, '330327000000', '苍南县', '浙江,温州,苍南', '120.425766', '27.518280', 1);
INSERT INTO `eb_system_city` VALUES (1343, 201140, 2, 197850, '330328000000', '文成县', '浙江,温州,文成', '120.091498', '27.786996', 1);
INSERT INTO `eb_system_city` VALUES (1344, 201556, 2, 197850, '330329000000', '泰顺县', '浙江,温州,泰顺', '119.717649', '27.556884', 1);
INSERT INTO `eb_system_city` VALUES (1345, 201882, 2, 197850, '330381000000', '瑞安市', '浙江,温州,瑞安', '120.655148', '27.778657', 1);
INSERT INTO `eb_system_city` VALUES (1346, 202864, 2, 197850, '330382000000', '乐清市', '浙江,温州,乐清', '120.967147', '28.116083', 1);
INSERT INTO `eb_system_city` VALUES (1347, 203853, 2, 203852, '330401000000', '市辖区', '浙江,嘉兴', '120.755486', '30.746129', 1);
INSERT INTO `eb_system_city` VALUES (1348, 203854, 2, 203852, '330402000000', '南湖区', '浙江,嘉兴,南湖', '120.783025', '30.747842', 1);
INSERT INTO `eb_system_city` VALUES (1349, 204008, 2, 203852, '330411000000', '秀洲区', '浙江,嘉兴,秀洲', '120.709018', '30.765168', 1);
INSERT INTO `eb_system_city` VALUES (1350, 204177, 2, 203852, '330421000000', '嘉善县', '浙江,嘉兴,嘉善', '120.925850', '30.830898', 1);
INSERT INTO `eb_system_city` VALUES (1351, 204341, 2, 203852, '330424000000', '海盐县', '浙江,嘉兴,海盐', '120.946263', '30.526436', 1);
INSERT INTO `eb_system_city` VALUES (1352, 204486, 2, 203852, '330481000000', '海宁市', '浙江,嘉兴,海宁', '120.680757', '30.510659', 1);
INSERT INTO `eb_system_city` VALUES (1353, 204723, 2, 203852, '330482000000', '平湖市', '浙江,嘉兴,平湖', '121.015142', '30.677233', 1);
INSERT INTO `eb_system_city` VALUES (1354, 204877, 2, 203852, '330483000000', '桐乡市', '浙江,嘉兴,桐乡', '120.565099', '30.630173', 1);
INSERT INTO `eb_system_city` VALUES (1355, 205102, 2, 205101, '330501000000', '市辖区', '浙江,湖州', '120.086823', '30.894348', 1);
INSERT INTO `eb_system_city` VALUES (1356, 205103, 2, 205101, '330502000000', '吴兴区', '浙江,湖州,吴兴', '120.185838', '30.857151', 1);
INSERT INTO `eb_system_city` VALUES (1357, 205449, 2, 205101, '330503000000', '南浔区', '浙江,湖州,南浔', '120.418512', '30.849690', 1);
INSERT INTO `eb_system_city` VALUES (1358, 205717, 2, 205101, '330521000000', '德清县', '浙江,湖州,德清', '119.977401', '30.542510', 1);
INSERT INTO `eb_system_city` VALUES (1359, 205910, 2, 205101, '330522000000', '长兴县', '浙江,湖州,长兴', '119.910952', '31.026666', 1);
INSERT INTO `eb_system_city` VALUES (1360, 206213, 2, 205101, '330523000000', '安吉县', '浙江,湖州,安吉', '119.680353', '30.638675', 1);
INSERT INTO `eb_system_city` VALUES (1361, 206439, 2, 206438, '330601000000', '市辖区', '浙江,绍兴', '120.580232', '30.029752', 1);
INSERT INTO `eb_system_city` VALUES (1362, 206440, 2, 206438, '330602000000', '越城区', '浙江,绍兴,越城', '120.582633', '29.988245', 1);
INSERT INTO `eb_system_city` VALUES (1363, 206875, 2, 206438, '330603000000', '柯桥区', '浙江,绍兴,柯桥', '120.495065', '30.081942', 1);
INSERT INTO `eb_system_city` VALUES (1364, 207247, 2, 206438, '330604000000', '上虞区', '浙江,绍兴,上虞', '120.868122', '30.033121', 1);
INSERT INTO `eb_system_city` VALUES (1365, 207715, 2, 206438, '330624000000', '新昌县', '浙江,绍兴,新昌', '120.903866', '29.499832', 1);
INSERT INTO `eb_system_city` VALUES (1366, 208171, 2, 206438, '330681000000', '诸暨市', '浙江,绍兴,诸暨', '120.246863', '29.708692', 1);
INSERT INTO `eb_system_city` VALUES (1367, 208733, 2, 206438, '330683000000', '嵊州市', '浙江,绍兴,嵊州', '120.831025', '29.561410', 1);
INSERT INTO `eb_system_city` VALUES (1368, 209251, 2, 209250, '330701000000', '市辖区', '浙江,金华', '119.647444', '29.079059', 1);
INSERT INTO `eb_system_city` VALUES (1369, 209252, 2, 209250, '330702000000', '婺城区', '浙江,金华,婺城', '119.571633', '29.086221', 1);
INSERT INTO `eb_system_city` VALUES (1370, 209949, 2, 209250, '330703000000', '金东区', '浙江,金华,金东', '119.692862', '29.099122', 1);
INSERT INTO `eb_system_city` VALUES (1371, 210474, 2, 209250, '330723000000', '武义县', '浙江,金华,武义', '119.816318', '28.892721', 1);
INSERT INTO `eb_system_city` VALUES (1372, 211047, 2, 209250, '330726000000', '浦江县', '浙江,金华,浦江', '119.892222', '29.452477', 1);
INSERT INTO `eb_system_city` VALUES (1373, 211492, 2, 209250, '330727000000', '磐安县', '浙江,金华,磐安', '120.450178', '29.054048', 1);
INSERT INTO `eb_system_city` VALUES (1374, 211883, 2, 209250, '330781000000', '兰溪市', '浙江,金华,兰溪', '119.460526', '29.208919', 1);
INSERT INTO `eb_system_city` VALUES (1375, 212256, 2, 209250, '330782000000', '义乌市', '浙江,金华,义乌', '120.075058', '29.306841', 1);
INSERT INTO `eb_system_city` VALUES (1376, 213076, 2, 209250, '330783000000', '东阳市', '浙江,金华,东阳', '120.241566', '29.289648', 1);
INSERT INTO `eb_system_city` VALUES (1377, 213485, 2, 209250, '330784000000', '永康市', '浙江,金华,永康', '120.047651', '28.888555', 1);
INSERT INTO `eb_system_city` VALUES (1378, 214261, 2, 214260, '330801000000', '市辖区', '浙江,衢州', '118.859457', '28.970079', 1);
INSERT INTO `eb_system_city` VALUES (1379, 214262, 2, 214260, '330802000000', '柯城区', '浙江,衢州,柯城', '118.871333', '28.968504', 1);
INSERT INTO `eb_system_city` VALUES (1380, 214536, 2, 214260, '330803000000', '衢江区', '浙江,衢州,衢江', '118.959460', '28.979780', 1);
INSERT INTO `eb_system_city` VALUES (1381, 214843, 2, 214260, '330822000000', '常山县', '浙江,衢州,常山', '118.511287', '28.901343', 1);
INSERT INTO `eb_system_city` VALUES (1382, 215051, 2, 214260, '330824000000', '开化县', '浙江,衢州,开化', '118.415495', '29.137337', 1);
INSERT INTO `eb_system_city` VALUES (1383, 215332, 2, 214260, '330825000000', '龙游县', '浙江,衢州,龙游', '119.172304', '29.028319', 1);
INSERT INTO `eb_system_city` VALUES (1384, 215624, 2, 214260, '330881000000', '江山市', '浙江,衢州,江山', '118.626974', '28.737223', 1);
INSERT INTO `eb_system_city` VALUES (1385, 215956, 2, 215955, '330901000000', '市辖区', '浙江,舟山', '122.207215', '29.985295', 1);
INSERT INTO `eb_system_city` VALUES (1386, 215957, 2, 215955, '330902000000', '定海区', '浙江,舟山,定海', '122.106773', '30.019858', 1);
INSERT INTO `eb_system_city` VALUES (1387, 216139, 2, 215955, '330903000000', '普陀区', '浙江,舟山,普陀', '122.323867', '29.971760', 1);
INSERT INTO `eb_system_city` VALUES (1388, 216290, 2, 215955, '330921000000', '岱山县', '浙江,舟山,岱山', '122.226237', '30.264139', 1);
INSERT INTO `eb_system_city` VALUES (1389, 216394, 2, 215955, '330922000000', '嵊泗县', '浙江,舟山,嵊泗', '122.451382', '30.725686', 1);
INSERT INTO `eb_system_city` VALUES (1390, 216450, 2, 216449, '331001000000', '市辖区', '浙江,台州', '121.420757', '28.656386', 1);
INSERT INTO `eb_system_city` VALUES (1391, 216451, 2, 216449, '331002000000', '椒江区', '浙江,台州,椒江', '121.442676', '28.673726', 1);
INSERT INTO `eb_system_city` VALUES (1392, 216788, 2, 216449, '331003000000', '黄岩区', '浙江,台州,黄岩', '121.261893', '28.650117', 1);
INSERT INTO `eb_system_city` VALUES (1393, 217324, 2, 216449, '331004000000', '路桥区', '浙江,台州,路桥', '121.365123', '28.582655', 1);
INSERT INTO `eb_system_city` VALUES (1394, 217666, 2, 216449, '331021000000', '玉环县', '浙江,台州,玉环', '121.231805', '28.135930', 1);
INSERT INTO `eb_system_city` VALUES (1395, 217998, 2, 216449, '331022000000', '三门县', '浙江,台州,三门', '121.395777', '29.104873', 1);
INSERT INTO `eb_system_city` VALUES (1396, 218534, 2, 216449, '331023000000', '天台县', '浙江,台州,天台', '121.006725', '29.144079', 1);
INSERT INTO `eb_system_city` VALUES (1397, 219162, 2, 216449, '331024000000', '仙居县', '浙江,台州,仙居', '120.735081', '28.849213', 1);
INSERT INTO `eb_system_city` VALUES (1398, 219609, 2, 216449, '331081000000', '温岭市', '浙江,台州,温岭', '121.385604', '28.372506', 1);
INSERT INTO `eb_system_city` VALUES (1399, 220555, 2, 216449, '331082000000', '临海市', '浙江,台州,临海', '121.145047', '28.858457', 1);
INSERT INTO `eb_system_city` VALUES (1400, 221611, 2, 221610, '331101000000', '市辖区', '浙江,丽水', '119.922796', '28.467630', 1);
INSERT INTO `eb_system_city` VALUES (1401, 221612, 2, 221610, '331102000000', '莲都区', '浙江,丽水,莲都', '119.912612', '28.445836', 1);
INSERT INTO `eb_system_city` VALUES (1402, 221903, 2, 221610, '331121000000', '青田县', '浙江,丽水,青田', '120.289597', '28.139059', 1);
INSERT INTO `eb_system_city` VALUES (1403, 222380, 2, 221610, '331122000000', '缙云县', '浙江,丽水,缙云', '120.091573', '28.659279', 1);
INSERT INTO `eb_system_city` VALUES (1404, 222658, 2, 221610, '331123000000', '遂昌县', '浙江,丽水,遂昌', '119.276104', '28.592119', 1);
INSERT INTO `eb_system_city` VALUES (1405, 222890, 2, 221610, '331124000000', '松阳县', '浙江,丽水,松阳', '119.482015', '28.449171', 1);
INSERT INTO `eb_system_city` VALUES (1406, 223324, 2, 221610, '331125000000', '云和县', '浙江,丽水,云和', '119.573397', '28.115790', 1);
INSERT INTO `eb_system_city` VALUES (1407, 223512, 2, 221610, '331126000000', '庆元县', '浙江,丽水,庆元', '119.062590', '27.619220', 1);
INSERT INTO `eb_system_city` VALUES (1408, 223885, 2, 221610, '331127000000', '景宁畲族自治县', '浙江,丽水,景宁', '119.635697', '27.973312', 1);
INSERT INTO `eb_system_city` VALUES (1409, 224172, 2, 221610, '331181000000', '龙泉市', '浙江,丽水,龙泉', '119.141461', '28.074623', 1);
INSERT INTO `eb_system_city` VALUES (1410, 224651, 2, 224650, '340101000000', '市辖区', '安徽,合肥', '117.227239', '31.820586', 1);
INSERT INTO `eb_system_city` VALUES (1411, 224652, 2, 224650, '340102000000', '瑶海区', '安徽,合肥,瑶海', '117.309229', '31.858048', 1);
INSERT INTO `eb_system_city` VALUES (1412, 224755, 2, 224650, '340103000000', '庐阳区', '安徽,合肥,庐阳', '117.264595', '31.878641', 1);
INSERT INTO `eb_system_city` VALUES (1413, 224838, 2, 224650, '340104000000', '蜀山区', '安徽,合肥,蜀山', '117.260536', '31.851158', 1);
INSERT INTO `eb_system_city` VALUES (1414, 224946, 2, 224650, '340111000000', '包河区', '安徽,合肥,包河', '117.309658', '31.793093', 1);
INSERT INTO `eb_system_city` VALUES (1415, 225062, 2, 224650, '340121000000', '长丰县', '安徽,合肥,长丰', '117.167564', '32.478018', 1);
INSERT INTO `eb_system_city` VALUES (1416, 225352, 2, 224650, '340122000000', '肥东县', '安徽,合肥,肥东', '117.469383', '31.887940', 1);
INSERT INTO `eb_system_city` VALUES (1417, 225705, 2, 224650, '340123000000', '肥西县', '安徽,合肥,肥西', '117.157981', '31.706810', 1);
INSERT INTO `eb_system_city` VALUES (1418, 225998, 2, 224650, '340124000000', '庐江县', '安徽,合肥,庐江', '117.287800', '31.255550', 1);
INSERT INTO `eb_system_city` VALUES (1419, 226249, 2, 224650, '340181000000', '巢湖市', '安徽,合肥,巢湖', '117.861800', '31.598628', 1);
INSERT INTO `eb_system_city` VALUES (1420, 226470, 2, 226469, '340201000000', '市辖区', '安徽,芜湖', '118.432941', '31.352859', 1);
INSERT INTO `eb_system_city` VALUES (1421, 226471, 2, 226469, '340202000000', '镜湖区', '安徽,芜湖,镜湖', '118.385146', '31.340404', 1);
INSERT INTO `eb_system_city` VALUES (1422, 226550, 2, 226469, '340203000000', '弋江区', '安徽,芜湖,弋江', '118.372655', '31.311757', 1);
INSERT INTO `eb_system_city` VALUES (1423, 226612, 2, 226469, '340207000000', '鸠江区', '安徽,芜湖,鸠江', '118.391734', '31.369373', 1);
INSERT INTO `eb_system_city` VALUES (1424, 226735, 2, 226469, '340208000000', '三山区', '安徽,芜湖,三山', '118.268101', '31.219568', 1);
INSERT INTO `eb_system_city` VALUES (1425, 226786, 2, 226469, '340221000000', '芜湖县', '安徽,芜湖,芜湖', '118.576124', '31.134809', 1);
INSERT INTO `eb_system_city` VALUES (1426, 226891, 2, 226469, '340222000000', '繁昌县', '安徽,芜湖,繁昌', '118.201349', '31.080896', 1);
INSERT INTO `eb_system_city` VALUES (1427, 226995, 2, 226469, '340223000000', '南陵县', '安徽,芜湖,南陵', '118.334360', '30.914923', 1);
INSERT INTO `eb_system_city` VALUES (1428, 227183, 2, 226469, '340225000000', '无为县', '安徽,芜湖,无为', '117.902366', '31.303168', 1);
INSERT INTO `eb_system_city` VALUES (1429, 227483, 2, 227482, '340301000000', '市辖区', '安徽,蚌埠', '117.389719', '32.916287', 1);
INSERT INTO `eb_system_city` VALUES (1430, 227484, 2, 227482, '340302000000', '龙子湖区', '安徽,蚌埠,龙子湖', '117.393790', '32.943014', 1);
INSERT INTO `eb_system_city` VALUES (1431, 227551, 2, 227482, '340303000000', '蚌山区', '安徽,蚌埠,蚌山', '117.367614', '32.944198', 1);
INSERT INTO `eb_system_city` VALUES (1432, 227598, 2, 227482, '340304000000', '禹会区', '安徽,蚌埠,禹会', '117.342451', '32.929711', 1);
INSERT INTO `eb_system_city` VALUES (1433, 227677, 2, 227482, '340311000000', '淮上区', '安徽,蚌埠,淮上', '117.359331', '32.965435', 1);
INSERT INTO `eb_system_city` VALUES (1434, 227769, 2, 227482, '340321000000', '怀远县', '安徽,蚌埠,怀远', '117.205234', '32.970031', 1);
INSERT INTO `eb_system_city` VALUES (1435, 228155, 2, 227482, '340322000000', '五河县', '安徽,蚌埠,五河', '117.879486', '33.127823', 1);
INSERT INTO `eb_system_city` VALUES (1436, 228388, 2, 227482, '340323000000', '固镇县', '安徽,蚌埠,固镇', '117.316955', '33.316899', 1);
INSERT INTO `eb_system_city` VALUES (1437, 228631, 2, 228630, '340401000000', '市辖区', '安徽,淮南', '116.999932', '32.625478', 1);
INSERT INTO `eb_system_city` VALUES (1438, 228632, 2, 228630, '340402000000', '大通区', '安徽,淮南,大通', '117.053273', '32.631533', 1);
INSERT INTO `eb_system_city` VALUES (1439, 228710, 2, 228630, '340403000000', '田家庵区', '安徽,淮南,田家庵', '117.017409', '32.647155', 1);
INSERT INTO `eb_system_city` VALUES (1440, 228853, 2, 228630, '340404000000', '谢家集区', '安徽,淮南,谢家集', '116.859048', '32.599901', 1);
INSERT INTO `eb_system_city` VALUES (1441, 228960, 2, 228630, '340405000000', '八公山区', '安徽,淮南,八公山', '116.833490', '32.631379', 1);
INSERT INTO `eb_system_city` VALUES (1442, 229029, 2, 228630, '340406000000', '潘集区', '安徽,淮南,潘集', '116.834716', '32.772080', 1);
INSERT INTO `eb_system_city` VALUES (1443, 229221, 2, 228630, '340421000000', '凤台县', '安徽,淮南,凤台', '116.711051', '32.709445', 1);
INSERT INTO `eb_system_city` VALUES (1444, 229527, 2, 228630, '340422000000', '寿县', '安徽,淮南,寿县', '116.787141', '32.573306', 1);
INSERT INTO `eb_system_city` VALUES (1445, 229845, 2, 229844, '340501000000', '市辖区', '安徽,马鞍山', '118.506759', '31.670452', 1);
INSERT INTO `eb_system_city` VALUES (1446, 229846, 2, 229844, '340503000000', '花山区', '安徽,马鞍山,花山', '118.492562', '31.719710', 1);
INSERT INTO `eb_system_city` VALUES (1447, 229922, 2, 229844, '340504000000', '雨山区', '安徽,马鞍山,雨山', '118.498560', '31.682208', 1);
INSERT INTO `eb_system_city` VALUES (1448, 229992, 2, 229844, '340506000000', '博望区', '安徽,马鞍山,博望', '118.844538', '31.558471', 1);
INSERT INTO `eb_system_city` VALUES (1449, 230041, 2, 229844, '340521000000', '当涂县', '安徽,马鞍山,当涂', '118.497972', '31.571213', 1);
INSERT INTO `eb_system_city` VALUES (1450, 230213, 2, 229844, '340522000000', '含山县', '安徽,马鞍山,含山', '118.101421', '31.735599', 1);
INSERT INTO `eb_system_city` VALUES (1451, 230345, 2, 229844, '340523000000', '和县', '安徽,马鞍山,和县', '118.351405', '31.741794', 1);
INSERT INTO `eb_system_city` VALUES (1452, 230477, 2, 230476, '340601000000', '市辖区', '安徽,淮北', '116.798265', '33.955844', 1);
INSERT INTO `eb_system_city` VALUES (1453, 230478, 2, 230476, '340602000000', '杜集区', '安徽,淮北,杜集', '116.828134', '33.991451', 1);
INSERT INTO `eb_system_city` VALUES (1454, 230539, 2, 230476, '340603000000', '相山区', '安徽,淮北,相山', '116.794345', '33.959893', 1);
INSERT INTO `eb_system_city` VALUES (1455, 230648, 2, 230476, '340604000000', '烈山区', '安徽,淮北,烈山', '116.813042', '33.895139', 1);
INSERT INTO `eb_system_city` VALUES (1456, 230720, 2, 230476, '340621000000', '濉溪县', '安徽,淮北,濉溪', '116.766299', '33.915477', 1);
INSERT INTO `eb_system_city` VALUES (1457, 230982, 2, 230981, '340701000000', '市辖区', '安徽,铜陵', '117.812079', '30.945429', 1);
INSERT INTO `eb_system_city` VALUES (1458, 230983, 2, 230981, '340705000000', '铜官区', '安徽,铜陵,铜官', '117.816174', '30.927608', 1);
INSERT INTO `eb_system_city` VALUES (1459, 231043, 2, 230981, '340706000000', '义安区', '安徽,铜陵,义安', '117.791544', '30.952823', 1);
INSERT INTO `eb_system_city` VALUES (1460, 231171, 2, 230981, '340711000000', '郊区', '安徽,铜陵,郊区', '117.807070', '30.908927', 1);
INSERT INTO `eb_system_city` VALUES (1461, 231216, 2, 230981, '340722000000', '枞阳县', '安徽,铜陵,枞阳', '117.220200', '30.700733', 1);
INSERT INTO `eb_system_city` VALUES (1462, 231500, 2, 231499, '340801000000', '市辖区', '安徽,安庆', '117.063754', '30.543494', 1);
INSERT INTO `eb_system_city` VALUES (1463, 231501, 2, 231499, '340802000000', '迎江区', '安徽,安庆,迎江', '117.091150', '30.511548', 1);
INSERT INTO `eb_system_city` VALUES (1464, 231558, 2, 231499, '340803000000', '大观区', '安徽,安庆,大观', '117.021670', '30.553957', 1);
INSERT INTO `eb_system_city` VALUES (1465, 231646, 2, 231499, '340811000000', '宜秀区', '安徽,安庆,宜秀', '117.070003', '30.541323', 1);
INSERT INTO `eb_system_city` VALUES (1466, 231710, 2, 231499, '340822000000', '怀宁县', '安徽,安庆,怀宁', '116.829475', '30.733825', 1);
INSERT INTO `eb_system_city` VALUES (1467, 231974, 2, 231499, '340824000000', '潜山县', '安徽,安庆,潜山', '116.581270', '30.631129', 1);
INSERT INTO `eb_system_city` VALUES (1468, 232180, 2, 231499, '340825000000', '太湖县', '安徽,安庆,太湖', '116.308795', '30.454220', 1);
INSERT INTO `eb_system_city` VALUES (1469, 232386, 2, 231499, '340826000000', '宿松县', '安徽,安庆,宿松', '116.129105', '30.153746', 1);
INSERT INTO `eb_system_city` VALUES (1470, 232631, 2, 231499, '340827000000', '望江县', '安徽,安庆,望江', '116.694183', '30.124428', 1);
INSERT INTO `eb_system_city` VALUES (1471, 232781, 2, 231499, '340828000000', '岳西县', '安徽,安庆,岳西', '116.359921', '30.849442', 1);
INSERT INTO `eb_system_city` VALUES (1472, 232996, 2, 231499, '340881000000', '桐城市', '安徽,安庆,桐城', '116.974120', '31.035800', 1);
INSERT INTO `eb_system_city` VALUES (1473, 233237, 2, 233236, '341001000000', '市辖区', '安徽,黄山', '118.337481', '29.714655', 1);
INSERT INTO `eb_system_city` VALUES (1474, 233238, 2, 233236, '341002000000', '屯溪区', '安徽,黄山,屯溪', '118.315329', '29.696109', 1);
INSERT INTO `eb_system_city` VALUES (1475, 233321, 2, 233236, '341003000000', '黄山区', '安徽,黄山,黄山', '118.141568', '30.272942', 1);
INSERT INTO `eb_system_city` VALUES (1476, 233423, 2, 233236, '341004000000', '徽州区', '安徽,黄山,徽州', '118.336751', '29.827279', 1);
INSERT INTO `eb_system_city` VALUES (1477, 233487, 2, 233236, '341021000000', '歙县', '安徽,黄山,歙县', '118.415356', '29.861308', 1);
INSERT INTO `eb_system_city` VALUES (1478, 233714, 2, 233236, '341022000000', '休宁县', '安徽,黄山,休宁', '118.199179', '29.789095', 1);
INSERT INTO `eb_system_city` VALUES (1479, 233894, 2, 233236, '341023000000', '黟县', '安徽,黄山,黟县', '117.938373', '29.924805', 1);
INSERT INTO `eb_system_city` VALUES (1480, 233973, 2, 233236, '341024000000', '祁门县', '安徽,黄山,祁门', '117.717396', '29.854055', 1);
INSERT INTO `eb_system_city` VALUES (1481, 234110, 2, 234109, '341101000000', '市辖区', '安徽,滁州', '118.317106', '32.301556', 1);
INSERT INTO `eb_system_city` VALUES (1482, 234111, 2, 234109, '341102000000', '琅琊区', '安徽,滁州,琅琊', '118.305843', '32.294530', 1);
INSERT INTO `eb_system_city` VALUES (1483, 234174, 2, 234109, '341103000000', '南谯区', '安徽,滁州,南谯', '118.296955', '32.329842', 1);
INSERT INTO `eb_system_city` VALUES (1484, 234274, 2, 234109, '341122000000', '来安县', '安徽,滁州,来安', '118.435792', '32.452172', 1);
INSERT INTO `eb_system_city` VALUES (1485, 234434, 2, 234109, '341124000000', '全椒县', '安徽,滁州,全椒', '118.273090', '32.085407', 1);
INSERT INTO `eb_system_city` VALUES (1486, 234560, 2, 234109, '341125000000', '定远县', '安徽,滁州,定远', '117.698563', '32.530982', 1);
INSERT INTO `eb_system_city` VALUES (1487, 234847, 2, 234109, '341126000000', '凤阳县', '安徽,滁州,凤阳', '117.531623', '32.874735', 1);
INSERT INTO `eb_system_city` VALUES (1488, 235112, 2, 234109, '341181000000', '天长市', '安徽,滁州,天长', '119.004817', '32.667571', 1);
INSERT INTO `eb_system_city` VALUES (1489, 235305, 2, 234109, '341182000000', '明光市', '安徽,滁州,明光', '118.018276', '32.781995', 1);
INSERT INTO `eb_system_city` VALUES (1490, 235484, 2, 235483, '341201000000', '市辖区', '安徽,阜阳', '115.814204', '32.890124', 1);
INSERT INTO `eb_system_city` VALUES (1491, 235485, 2, 235483, '341202000000', '颍州区', '安徽,阜阳,颍州', '115.806942', '32.883468', 1);
INSERT INTO `eb_system_city` VALUES (1492, 235646, 2, 235483, '341203000000', '颍东区', '安徽,阜阳,颍东', '115.856687', '32.912478', 1);
INSERT INTO `eb_system_city` VALUES (1493, 235778, 2, 235483, '341204000000', '颍泉区', '安徽,阜阳,颍泉', '115.808327', '32.924918', 1);
INSERT INTO `eb_system_city` VALUES (1494, 235909, 2, 235483, '341221000000', '临泉县', '安徽,阜阳,临泉', '115.261473', '33.040261', 1);
INSERT INTO `eb_system_city` VALUES (1495, 236338, 2, 235483, '341222000000', '太和县', '安徽,阜阳,太和', '115.621934', '33.160326', 1);
INSERT INTO `eb_system_city` VALUES (1496, 236685, 2, 235483, '341225000000', '阜南县', '安徽,阜阳,阜南', '115.595644', '32.658297', 1);
INSERT INTO `eb_system_city` VALUES (1497, 237046, 2, 235483, '341226000000', '颍上县', '安徽,阜阳,颍上', '116.256789', '32.653255', 1);
INSERT INTO `eb_system_city` VALUES (1498, 237428, 2, 235483, '341282000000', '界首市', '安徽,阜阳,界首', '115.374564', '33.257013', 1);
INSERT INTO `eb_system_city` VALUES (1499, 237608, 2, 237607, '341301000000', '市辖区', '安徽,宿州', '116.964356', '33.646373', 1);
INSERT INTO `eb_system_city` VALUES (1500, 237609, 2, 237607, '341302000000', '埇桥区', '安徽,宿州,埇桥', '116.977463', '33.640061', 1);
INSERT INTO `eb_system_city` VALUES (1501, 238022, 2, 237607, '341321000000', '砀山县', '安徽,宿州,砀山', '116.367095', '34.442561', 1);
INSERT INTO `eb_system_city` VALUES (1502, 238207, 2, 237607, '341322000000', '萧县', '安徽,宿州,萧县', '116.947290', '34.188728', 1);
INSERT INTO `eb_system_city` VALUES (1503, 238533, 2, 237607, '341323000000', '灵璧县', '安徽,宿州,灵璧', '117.552462', '33.552998', 1);
INSERT INTO `eb_system_city` VALUES (1504, 238872, 2, 237607, '341324000000', '泗县', '安徽,宿州,泗县', '117.910629', '33.482982', 1);
INSERT INTO `eb_system_city` VALUES (1505, 239085, 2, 239084, '341501000000', '市辖区', '安徽,六安', '116.521854', '31.733699', 1);
INSERT INTO `eb_system_city` VALUES (1506, 239086, 2, 239084, '341502000000', '金安区', '安徽,六安,金安', '116.539679', '31.749265', 1);
INSERT INTO `eb_system_city` VALUES (1507, 239450, 2, 239084, '341503000000', '裕安区', '安徽,六安,裕安', '116.479920', '31.737813', 1);
INSERT INTO `eb_system_city` VALUES (1508, 239780, 2, 239084, '341504000000', '叶集区', '安徽,六安,叶集', '116.521854', '31.733699', 1);
INSERT INTO `eb_system_city` VALUES (1509, 239834, 2, 239084, '341522000000', '霍邱县', '安徽,六安,霍邱', '116.277912', '32.353038', 1);
INSERT INTO `eb_system_city` VALUES (1510, 240310, 2, 239084, '341523000000', '舒城县', '安徽,六安,舒城', '116.948623', '31.462027', 1);
INSERT INTO `eb_system_city` VALUES (1511, 240759, 2, 239084, '341524000000', '金寨县', '安徽,六安,金寨', '115.934366', '31.727170', 1);
INSERT INTO `eb_system_city` VALUES (1512, 241016, 2, 239084, '341525000000', '霍山县', '安徽,六安,霍山', '116.332951', '31.392786', 1);
INSERT INTO `eb_system_city` VALUES (1513, 241181, 2, 241180, '341601000000', '市辖区', '安徽,亳州', '115.778676', '33.844582', 1);
INSERT INTO `eb_system_city` VALUES (1514, 241182, 2, 241180, '341602000000', '谯城区', '安徽,亳州,谯城', '115.779025', '33.876235', 1);
INSERT INTO `eb_system_city` VALUES (1515, 241517, 2, 241180, '341621000000', '涡阳县', '安徽,亳州,涡阳', '116.215665', '33.492921', 1);
INSERT INTO `eb_system_city` VALUES (1516, 241927, 2, 241180, '341622000000', '蒙城县', '安徽,亳州,蒙城', '116.564248', '33.265831', 1);
INSERT INTO `eb_system_city` VALUES (1517, 242245, 2, 241180, '341623000000', '利辛县', '安徽,亳州,利辛', '116.208635', '33.144724', 1);
INSERT INTO `eb_system_city` VALUES (1518, 242635, 2, 242634, '341701000000', '市辖区', '安徽,池州', '117.491568', '30.664800', 1);
INSERT INTO `eb_system_city` VALUES (1519, 242636, 2, 242634, '341702000000', '贵池区', '安徽,池州,贵池', '117.567379', '30.687181', 1);
INSERT INTO `eb_system_city` VALUES (1520, 242888, 2, 242634, '341721000000', '东至县', '安徽,池州,东至', '117.027533', '30.111182', 1);
INSERT INTO `eb_system_city` VALUES (1521, 243159, 2, 242634, '341722000000', '石台县', '安徽,池州,石台', '117.486306', '30.210313', 1);
INSERT INTO `eb_system_city` VALUES (1522, 243254, 2, 242634, '341723000000', '青阳县', '安徽,池州,青阳', '117.847362', '30.639230', 1);
INSERT INTO `eb_system_city` VALUES (1523, 243400, 2, 243399, '341801000000', '市辖区', '安徽,宣城', '118.758816', '30.940718', 1);
INSERT INTO `eb_system_city` VALUES (1524, 243401, 2, 243399, '341802000000', '宣州区', '安徽,宣城,宣州', '118.756328', '30.946319', 1);
INSERT INTO `eb_system_city` VALUES (1525, 243636, 2, 243399, '341821000000', '郎溪县', '安徽,宣城,郎溪', '119.179657', '31.126412', 1);
INSERT INTO `eb_system_city` VALUES (1526, 243753, 2, 243399, '341822000000', '广德县', '安徽,宣城,广德', '119.420935', '30.877555', 1);
INSERT INTO `eb_system_city` VALUES (1527, 243902, 2, 243399, '341823000000', '泾县', '安徽,宣城,泾县', '118.419864', '30.688578', 1);
INSERT INTO `eb_system_city` VALUES (1528, 244058, 2, 243399, '341824000000', '绩溪县', '安徽,宣城,绩溪', '118.578519', '30.067533', 1);
INSERT INTO `eb_system_city` VALUES (1529, 244153, 2, 243399, '341825000000', '旌德县', '安徽,宣城,旌德', '118.540487', '30.286350', 1);
INSERT INTO `eb_system_city` VALUES (1530, 244232, 2, 243399, '341881000000', '宁国市', '安徽,宣城,宁国', '118.982915', '30.633571', 1);
INSERT INTO `eb_system_city` VALUES (1531, 244379, 2, 244378, '350101000000', '市辖区', '福建,福州', '119.296494', '26.074507', 1);
INSERT INTO `eb_system_city` VALUES (1532, 244380, 2, 244378, '350102000000', '鼓楼区', '福建,福州,鼓楼', '119.303822', '26.082294', 1);
INSERT INTO `eb_system_city` VALUES (1533, 244460, 2, 244378, '350103000000', '台江区', '福建,福州,台江', '119.314054', '26.052842', 1);
INSERT INTO `eb_system_city` VALUES (1534, 244523, 2, 244378, '350104000000', '仓山区', '福建,福州,仓山', '119.273546', '26.046744', 1);
INSERT INTO `eb_system_city` VALUES (1535, 244713, 2, 244378, '350105000000', '马尾区', '福建,福州,马尾', '119.455589', '25.989500', 1);
INSERT INTO `eb_system_city` VALUES (1536, 244793, 2, 244378, '350111000000', '晋安区', '福建,福州,晋安', '119.328515', '26.082105', 1);
INSERT INTO `eb_system_city` VALUES (1537, 244987, 2, 244378, '350121000000', '闽侯县', '福建,福州,闽侯', '119.131725', '26.150047', 1);
INSERT INTO `eb_system_city` VALUES (1538, 245329, 2, 244378, '350122000000', '连江县', '福建,福州,连江', '119.539704', '26.197364', 1);
INSERT INTO `eb_system_city` VALUES (1539, 245633, 2, 244378, '350123000000', '罗源县', '福建,福州,罗源', '119.549776', '26.489559', 1);
INSERT INTO `eb_system_city` VALUES (1540, 245845, 2, 244378, '350124000000', '闽清县', '福建,福州,闽清', '118.863361', '26.221198', 1);
INSERT INTO `eb_system_city` VALUES (1541, 246154, 2, 244378, '350125000000', '永泰县', '福建,福州,永泰', '118.932592', '25.866695', 1);
INSERT INTO `eb_system_city` VALUES (1542, 246443, 2, 244378, '350128000000', '平潭县', '福建,福州,平潭', '119.790168', '25.498720', 1);
INSERT INTO `eb_system_city` VALUES (1543, 246667, 2, 244378, '350181000000', '福清市', '福建,福州,福清', '119.384334', '25.721143', 1);
INSERT INTO `eb_system_city` VALUES (1544, 247200, 2, 244378, '350182000000', '长乐市', '福建,福州,长乐', '119.523266', '25.962888', 1);
INSERT INTO `eb_system_city` VALUES (1545, 247479, 2, 247478, '350201000000', '市辖区', '福建,厦门', '118.089425', '24.479833', 1);
INSERT INTO `eb_system_city` VALUES (1546, 247480, 2, 247478, '350203000000', '思明区', '福建,厦门,思明', '118.082658', '24.445567', 1);
INSERT INTO `eb_system_city` VALUES (1547, 247590, 2, 247478, '350205000000', '海沧区', '福建,厦门,海沧', '118.032818', '24.484503', 1);
INSERT INTO `eb_system_city` VALUES (1548, 247641, 2, 247478, '350206000000', '湖里区', '福建,厦门,湖里', '118.146769', '24.512905', 1);
INSERT INTO `eb_system_city` VALUES (1549, 247704, 2, 247478, '350211000000', '集美区', '福建,厦门,集美', '118.097337', '24.575970', 1);
INSERT INTO `eb_system_city` VALUES (1550, 247782, 2, 247478, '350212000000', '同安区', '福建,厦门,同安', '118.152149', '24.722747', 1);
INSERT INTO `eb_system_city` VALUES (1551, 247933, 2, 247478, '350213000000', '翔安区', '福建,厦门,翔安', '118.248034', '24.618544', 1);
INSERT INTO `eb_system_city` VALUES (1552, 248060, 2, 248059, '350301000000', '市辖区', '福建,莆田', '119.007777', '25.454084', 1);
INSERT INTO `eb_system_city` VALUES (1553, 248061, 2, 248059, '350302000000', '城厢区', '福建,莆田,城厢', '118.993885', '25.419319', 1);
INSERT INTO `eb_system_city` VALUES (1554, 248189, 2, 248059, '350303000000', '涵江区', '福建,莆田,涵江', '119.116290', '25.458720', 1);
INSERT INTO `eb_system_city` VALUES (1555, 248403, 2, 248059, '350304000000', '荔城区', '福建,莆田,荔城', '119.015123', '25.431979', 1);
INSERT INTO `eb_system_city` VALUES (1556, 248540, 2, 248059, '350305000000', '秀屿区', '福建,莆田,秀屿', '119.105528', '25.318672', 1);
INSERT INTO `eb_system_city` VALUES (1557, 248753, 2, 248059, '350322000000', '仙游县', '福建,莆田,仙游', '118.691601', '25.362094', 1);
INSERT INTO `eb_system_city` VALUES (1558, 249099, 2, 249098, '350401000000', '市辖区', '福建,三明', '117.638678', '26.263406', 1);
INSERT INTO `eb_system_city` VALUES (1559, 249100, 2, 249098, '350402000000', '梅列区', '福建,三明,梅列', '117.645856', '26.271711', 1);
INSERT INTO `eb_system_city` VALUES (1560, 249157, 2, 249098, '350403000000', '三元区', '福建,三明,三元', '117.608045', '26.234020', 1);
INSERT INTO `eb_system_city` VALUES (1561, 249245, 2, 249098, '350421000000', '明溪县', '福建,三明,明溪', '117.201847', '26.357379', 1);
INSERT INTO `eb_system_city` VALUES (1562, 249351, 2, 249098, '350423000000', '清流县', '福建,三明,清流', '116.816909', '26.177797', 1);
INSERT INTO `eb_system_city` VALUES (1563, 249484, 2, 249098, '350424000000', '宁化县', '福建,三明,宁化', '116.654365', '26.261754', 1);
INSERT INTO `eb_system_city` VALUES (1564, 249728, 2, 249098, '350425000000', '大田县', '福建,三明,大田', '117.847115', '25.692699', 1);
INSERT INTO `eb_system_city` VALUES (1565, 250026, 2, 249098, '350426000000', '尤溪县', '福建,三明,尤溪', '118.190467', '26.170171', 1);
INSERT INTO `eb_system_city` VALUES (1566, 250307, 2, 249098, '350427000000', '沙县', '福建,三明,沙县', '117.792450', '26.397300', 1);
INSERT INTO `eb_system_city` VALUES (1567, 250512, 2, 249098, '350428000000', '将乐县', '福建,三明,将乐', '117.471373', '26.728953', 1);
INSERT INTO `eb_system_city` VALUES (1568, 250680, 2, 249098, '350429000000', '泰宁县', '福建,三明,泰宁', '117.175740', '26.900259', 1);
INSERT INTO `eb_system_city` VALUES (1569, 250809, 2, 249098, '350430000000', '建宁县', '福建,三明,建宁', '116.846084', '26.830902', 1);
INSERT INTO `eb_system_city` VALUES (1570, 250920, 2, 249098, '350481000000', '永安市', '福建,三明,永安', '117.365053', '25.941937', 1);
INSERT INTO `eb_system_city` VALUES (1571, 251198, 2, 251197, '350501000000', '市辖区', '福建,泉州', '118.675675', '24.874132', 1);
INSERT INTO `eb_system_city` VALUES (1572, 251199, 2, 251197, '350502000000', '鲤城区', '福建,泉州,鲤城', '118.586884', '24.907581', 1);
INSERT INTO `eb_system_city` VALUES (1573, 251289, 2, 251197, '350503000000', '丰泽区', '福建,泉州,丰泽', '118.613173', '24.891173', 1);
INSERT INTO `eb_system_city` VALUES (1574, 251376, 2, 251197, '350504000000', '洛江区', '福建,泉州,洛江', '118.671193', '24.939796', 1);
INSERT INTO `eb_system_city` VALUES (1575, 251470, 2, 251197, '350505000000', '泉港区', '福建,泉州,泉港', '118.916309', '25.119815', 1);
INSERT INTO `eb_system_city` VALUES (1576, 251580, 2, 251197, '350521000000', '惠安县', '福建,泉州,惠安', '118.796605', '25.030781', 1);
INSERT INTO `eb_system_city` VALUES (1577, 251897, 2, 251197, '350524000000', '安溪县', '福建,泉州,安溪', '118.186289', '25.055955', 1);
INSERT INTO `eb_system_city` VALUES (1578, 252406, 2, 251197, '350525000000', '永春县', '福建,泉州,永春', '118.294048', '25.321565', 1);
INSERT INTO `eb_system_city` VALUES (1579, 252665, 2, 251197, '350526000000', '德化县', '福建,泉州,德化', '118.241094', '25.491494', 1);
INSERT INTO `eb_system_city` VALUES (1580, 252894, 2, 251197, '350527000000', '金门县', '福建,泉州,金门', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (1581, 252895, 2, 251197, '350581000000', '石狮市', '福建,泉州,石狮', '118.648066', '24.732204', 1);
INSERT INTO `eb_system_city` VALUES (1582, 253032, 2, 251197, '350582000000', '晋江市', '福建,泉州,晋江', '118.552365', '24.781681', 1);
INSERT INTO `eb_system_city` VALUES (1583, 253454, 2, 251197, '350583000000', '南安市', '福建,泉州,南安', '118.386279', '24.960385', 1);
INSERT INTO `eb_system_city` VALUES (1584, 253906, 2, 253905, '350601000000', '市辖区', '福建,漳州', '117.647481', '24.512948', 1);
INSERT INTO `eb_system_city` VALUES (1585, 253907, 2, 253905, '350602000000', '芗城区', '福建,漳州,芗城', '117.653975', '24.510900', 1);
INSERT INTO `eb_system_city` VALUES (1586, 254093, 2, 253905, '350603000000', '龙文区', '福建,漳州,龙文', '117.709755', '24.503113', 1);
INSERT INTO `eb_system_city` VALUES (1587, 254170, 2, 253905, '350622000000', '云霄县', '福建,漳州,云霄', '117.339573', '23.957936', 1);
INSERT INTO `eb_system_city` VALUES (1588, 254394, 2, 253905, '350623000000', '漳浦县', '福建,漳州,漳浦', '117.613808', '24.117102', 1);
INSERT INTO `eb_system_city` VALUES (1589, 254747, 2, 253905, '350624000000', '诏安县', '福建,漳州,诏安', '117.175185', '23.711579', 1);
INSERT INTO `eb_system_city` VALUES (1590, 255011, 2, 253905, '350625000000', '长泰县', '福建,漳州,长泰', '117.759153', '24.625449', 1);
INSERT INTO `eb_system_city` VALUES (1591, 255105, 2, 253905, '350626000000', '东山县', '福建,漳州,东山', '117.430061', '23.701262', 1);
INSERT INTO `eb_system_city` VALUES (1592, 255190, 2, 253905, '350627000000', '南靖县', '福建,漳州,南靖', '117.357321', '24.514654', 1);
INSERT INTO `eb_system_city` VALUES (1593, 255405, 2, 253905, '350628000000', '平和县', '福建,漳州,平和', '117.314891', '24.363437', 1);
INSERT INTO `eb_system_city` VALUES (1594, 255680, 2, 253905, '350629000000', '华安县', '福建,漳州,华安', '117.534103', '25.004425', 1);
INSERT INTO `eb_system_city` VALUES (1595, 255789, 2, 253905, '350681000000', '龙海市', '福建,漳州,龙海', '117.818197', '24.446706', 1);
INSERT INTO `eb_system_city` VALUES (1596, 256113, 2, 256112, '350701000000', '市辖区', '福建,南平', '118.177708', '26.641768', 1);
INSERT INTO `eb_system_city` VALUES (1597, 256114, 2, 256112, '350702000000', '延平区', '福建,南平,延平', '118.181894', '26.637457', 1);
INSERT INTO `eb_system_city` VALUES (1598, 256452, 2, 256112, '350703000000', '建阳区', '福建,南平,建阳', '118.120464', '27.331876', 1);
INSERT INTO `eb_system_city` VALUES (1599, 256687, 2, 256112, '350721000000', '顺昌县', '福建,南平,顺昌', '117.810357', '26.793288', 1);
INSERT INTO `eb_system_city` VALUES (1600, 256849, 2, 256112, '350722000000', '浦城县', '福建,南平,浦城', '118.541256', '27.917263', 1);
INSERT INTO `eb_system_city` VALUES (1601, 257172, 2, 256112, '350723000000', '光泽县', '福建,南平,光泽', '117.334106', '27.540988', 1);
INSERT INTO `eb_system_city` VALUES (1602, 257276, 2, 256112, '350724000000', '松溪县', '福建,南平,松溪', '118.785468', '27.526232', 1);
INSERT INTO `eb_system_city` VALUES (1603, 257395, 2, 256112, '350725000000', '政和县', '福建,南平,政和', '118.857642', '27.366104', 1);
INSERT INTO `eb_system_city` VALUES (1604, 257539, 2, 256112, '350781000000', '邵武市', '福建,南平,邵武', '117.492534', '27.340327', 1);
INSERT INTO `eb_system_city` VALUES (1605, 257733, 2, 256112, '350782000000', '武夷山市', '福建,南平,武夷山', '118.035310', '27.756648', 1);
INSERT INTO `eb_system_city` VALUES (1606, 257886, 2, 256112, '350783000000', '建瓯市', '福建,南平,建瓯', '118.304988', '27.022727', 1);
INSERT INTO `eb_system_city` VALUES (1607, 258161, 2, 258160, '350801000000', '市辖区', '福建,龙岩', '117.017536', '25.075123', 1);
INSERT INTO `eb_system_city` VALUES (1608, 258162, 2, 258160, '350802000000', '新罗区', '福建,龙岩,新罗', '117.037264', '25.098292', 1);
INSERT INTO `eb_system_city` VALUES (1609, 258520, 2, 258160, '350803000000', '永定区', '福建,龙岩,永定', '116.732092', '24.723962', 1);
INSERT INTO `eb_system_city` VALUES (1610, 258825, 2, 258160, '350821000000', '长汀县', '福建,龙岩,长汀', '116.357581', '25.833531', 1);
INSERT INTO `eb_system_city` VALUES (1611, 259144, 2, 258160, '350823000000', '上杭县', '福建,龙岩,上杭', '116.420099', '25.049518', 1);
INSERT INTO `eb_system_city` VALUES (1612, 259512, 2, 258160, '350824000000', '武平县', '福建,龙岩,武平', '116.100342', '25.095277', 1);
INSERT INTO `eb_system_city` VALUES (1613, 259749, 2, 258160, '350825000000', '连城县', '福建,龙岩,连城', '116.754473', '25.710539', 1);
INSERT INTO `eb_system_city` VALUES (1614, 260014, 2, 258160, '350881000000', '漳平市', '福建,龙岩,漳平', '117.419998', '25.290185', 1);
INSERT INTO `eb_system_city` VALUES (1615, 260231, 2, 260230, '350901000000', '市辖区', '福建,宁德', '119.547932', '26.665617', 1);
INSERT INTO `eb_system_city` VALUES (1616, 260232, 2, 260230, '350902000000', '蕉城区', '福建,宁德,蕉城', '119.526299', '26.660611', 1);
INSERT INTO `eb_system_city` VALUES (1617, 260575, 2, 260230, '350921000000', '霞浦县', '福建,宁德,霞浦', '120.005643', '26.885204', 1);
INSERT INTO `eb_system_city` VALUES (1618, 260905, 2, 260230, '350922000000', '古田县', '福建,宁德,古田', '118.746284', '26.577837', 1);
INSERT INTO `eb_system_city` VALUES (1619, 261211, 2, 260230, '350923000000', '屏南县', '福建,宁德,屏南', '118.985895', '26.908276', 1);
INSERT INTO `eb_system_city` VALUES (1620, 261382, 2, 260230, '350924000000', '寿宁县', '福建,宁德,寿宁', '119.514987', '27.454479', 1);
INSERT INTO `eb_system_city` VALUES (1621, 261602, 2, 260230, '350925000000', '周宁县', '福建,宁德,周宁', '119.339025', '27.104591', 1);
INSERT INTO `eb_system_city` VALUES (1622, 261759, 2, 260230, '350926000000', '柘荣县', '福建,宁德,柘荣', '119.900609', '27.233933', 1);
INSERT INTO `eb_system_city` VALUES (1623, 261885, 2, 260230, '350981000000', '福安市', '福建,宁德,福安', '119.647770', '27.088049', 1);
INSERT INTO `eb_system_city` VALUES (1624, 262395, 2, 260230, '350982000000', '福鼎市', '福建,宁德,福鼎', '120.216978', '27.324479', 1);
INSERT INTO `eb_system_city` VALUES (1625, 262700, 2, 262699, '360101000000', '市辖区', '江西,南昌', '115.858197', '28.682892', 1);
INSERT INTO `eb_system_city` VALUES (1626, 262701, 2, 262699, '360102000000', '东湖区', '江西,南昌,东湖', '115.899262', '28.685085', 1);
INSERT INTO `eb_system_city` VALUES (1627, 262889, 2, 262699, '360103000000', '西湖区', '江西,南昌,西湖', '115.877233', '28.657595', 1);
INSERT INTO `eb_system_city` VALUES (1628, 263058, 2, 262699, '360104000000', '青云谱区', '江西,南昌,青云谱', '115.925749', '28.621169', 1);
INSERT INTO `eb_system_city` VALUES (1629, 263152, 2, 262699, '360105000000', '湾里区', '江西,南昌,湾里', '115.730847', '28.714796', 1);
INSERT INTO `eb_system_city` VALUES (1630, 263217, 2, 262699, '360111000000', '青山湖区', '江西,南昌,青山湖', '115.962144', '28.682985', 1);
INSERT INTO `eb_system_city` VALUES (1631, 263496, 2, 262699, '360112000000', '新建区', '江西,南昌,新建', '115.815278', '28.692864', 1);
INSERT INTO `eb_system_city` VALUES (1632, 263948, 2, 262699, '360121000000', '南昌县', '江西,南昌,南昌', '115.944304', '28.545602', 1);
INSERT INTO `eb_system_city` VALUES (1633, 264375, 2, 262699, '360123000000', '安义县', '江西,南昌,安义', '115.549247', '28.844507', 1);
INSERT INTO `eb_system_city` VALUES (1634, 264517, 2, 262699, '360124000000', '进贤县', '江西,南昌,进贤', '116.240924', '28.376918', 1);
INSERT INTO `eb_system_city` VALUES (1635, 264863, 2, 264862, '360201000000', '市辖区', '江西,景德镇', '117.178419', '29.268835', 1);
INSERT INTO `eb_system_city` VALUES (1636, 264864, 2, 264862, '360202000000', '昌江区', '江西,景德镇,昌江', '117.183748', '29.273435', 1);
INSERT INTO `eb_system_city` VALUES (1637, 264962, 2, 264862, '360203000000', '珠山区', '江西,景德镇,珠山', '117.202893', '29.299923', 1);
INSERT INTO `eb_system_city` VALUES (1638, 265083, 2, 264862, '360222000000', '浮梁县', '江西,景德镇,浮梁', '117.215086', '29.351681', 1);
INSERT INTO `eb_system_city` VALUES (1639, 265297, 2, 264862, '360281000000', '乐平市', '江西,景德镇,乐平', '117.151796', '28.978440', 1);
INSERT INTO `eb_system_city` VALUES (1640, 265678, 2, 265677, '360301000000', '市辖区', '江西,萍乡', '113.854556', '27.622768', 1);
INSERT INTO `eb_system_city` VALUES (1641, 265679, 2, 265677, '360302000000', '安源区', '江西,萍乡,安源', '113.870730', '27.615202', 1);
INSERT INTO `eb_system_city` VALUES (1642, 265826, 2, 265677, '360313000000', '湘东区', '江西,萍乡,湘东', '113.733047', '27.640075', 1);
INSERT INTO `eb_system_city` VALUES (1643, 265994, 2, 265677, '360321000000', '莲花县', '江西,萍乡,莲花', '113.961465', '27.127669', 1);
INSERT INTO `eb_system_city` VALUES (1644, 266171, 2, 265677, '360322000000', '上栗县', '江西,萍乡,上栗', '113.795311', '27.880302', 1);
INSERT INTO `eb_system_city` VALUES (1645, 266356, 2, 265677, '360323000000', '芦溪县', '江西,萍乡,芦溪', '114.029828', '27.630806', 1);
INSERT INTO `eb_system_city` VALUES (1646, 266522, 2, 266521, '360401000000', '市辖区', '江西,九江', '116.001930', '29.705077', 1);
INSERT INTO `eb_system_city` VALUES (1647, 266523, 2, 266521, '360402000000', '濂溪区', '江西,九江,濂溪', '116.011380', '29.678540', 1);
INSERT INTO `eb_system_city` VALUES (1648, 266665, 2, 266521, '360403000000', '浔阳区', '江西,九江,浔阳', '115.990301', '29.727593', 1);
INSERT INTO `eb_system_city` VALUES (1649, 266781, 2, 266521, '360421000000', '九江县', '江西,九江,九江', '115.911323', '29.608431', 1);
INSERT INTO `eb_system_city` VALUES (1650, 266946, 2, 266521, '360423000000', '武宁县', '江西,九江,武宁', '115.100578', '29.256323', 1);
INSERT INTO `eb_system_city` VALUES (1651, 267168, 2, 266521, '360424000000', '修水县', '江西,九江,修水', '114.546702', '29.026022', 1);
INSERT INTO `eb_system_city` VALUES (1652, 267613, 2, 266521, '360425000000', '永修县', '江西,九江,永修', '115.832453', '29.012297', 1);
INSERT INTO `eb_system_city` VALUES (1653, 267868, 2, 266521, '360426000000', '德安县', '江西,九江,德安', '115.767484', '29.298738', 1);
INSERT INTO `eb_system_city` VALUES (1654, 267982, 2, 266521, '360428000000', '都昌县', '江西,九江,都昌', '116.204099', '29.273194', 1);
INSERT INTO `eb_system_city` VALUES (1655, 268318, 2, 266521, '360429000000', '湖口县', '江西,九江,湖口', '116.251947', '29.731101', 1);
INSERT INTO `eb_system_city` VALUES (1656, 268480, 2, 266521, '360430000000', '彭泽县', '江西,九江,彭泽', '116.549359', '29.896061', 1);
INSERT INTO `eb_system_city` VALUES (1657, 268689, 2, 266521, '360481000000', '瑞昌市', '江西,九江,瑞昌', '115.681337', '29.675874', 1);
INSERT INTO `eb_system_city` VALUES (1658, 268926, 2, 266521, '360482000000', '共青城市', '江西,九江,共青城', '115.808844', '29.248317', 1);
INSERT INTO `eb_system_city` VALUES (1659, 268995, 2, 266521, '360483000000', '庐山市', '江西,九江,庐山', '116.045060', '29.448128', 1);
INSERT INTO `eb_system_city` VALUES (1660, 269108, 2, 269107, '360501000000', '市辖区', '江西,新余', '114.917346', '27.817808', 1);
INSERT INTO `eb_system_city` VALUES (1661, 269109, 2, 269107, '360502000000', '渝水区', '江西,新余,渝水', '114.944646', '27.800387', 1);
INSERT INTO `eb_system_city` VALUES (1662, 269465, 2, 269107, '360521000000', '分宜县', '江西,新余,分宜', '114.692050', '27.814758', 1);
INSERT INTO `eb_system_city` VALUES (1663, 269655, 2, 269654, '360601000000', '市辖区', '江西,鹰潭', '117.069202', '28.260189', 1);
INSERT INTO `eb_system_city` VALUES (1664, 269656, 2, 269654, '360602000000', '月湖区', '江西,鹰潭,月湖', '117.037137', '28.239153', 1);
INSERT INTO `eb_system_city` VALUES (1665, 269746, 2, 269654, '360622000000', '余江县', '江西,鹰潭,余江', '116.822763', '28.206177', 1);
INSERT INTO `eb_system_city` VALUES (1666, 269942, 2, 269654, '360681000000', '贵溪市', '江西,鹰潭,贵溪', '117.245497', '28.292519', 1);
INSERT INTO `eb_system_city` VALUES (1667, 270223, 2, 270222, '360701000000', '市辖区', '江西,赣州', '114.935029', '25.831829', 1);
INSERT INTO `eb_system_city` VALUES (1668, 270224, 2, 270222, '360702000000', '章贡区', '江西,赣州,章贡', '114.921171', '25.817816', 1);
INSERT INTO `eb_system_city` VALUES (1669, 270442, 2, 270222, '360703000000', '南康区', '江西,赣州,南康', '114.765403', '25.661471', 1);
INSERT INTO `eb_system_city` VALUES (1670, 270780, 2, 270222, '360721000000', '赣县', '江西,赣州,赣县', '115.011561', '25.860691', 1);
INSERT INTO `eb_system_city` VALUES (1671, 271095, 2, 270222, '360722000000', '信丰县', '江西,赣州,信丰', '114.922830', '25.386704', 1);
INSERT INTO `eb_system_city` VALUES (1672, 271410, 2, 270222, '360723000000', '大余县', '江西,赣州,大余', '114.362112', '25.401314', 1);
INSERT INTO `eb_system_city` VALUES (1673, 271541, 2, 270222, '360724000000', '上犹县', '江西,赣州,上犹', '114.551138', '25.785172', 1);
INSERT INTO `eb_system_city` VALUES (1674, 271699, 2, 270222, '360725000000', '崇义县', '江西,赣州,崇义', '114.308267', '25.681784', 1);
INSERT INTO `eb_system_city` VALUES (1675, 271848, 2, 270222, '360726000000', '安远县', '江西,赣州,安远', '115.393922', '25.136927', 1);
INSERT INTO `eb_system_city` VALUES (1676, 272033, 2, 270222, '360727000000', '龙南县', '江西,赣州,龙南', '114.789873', '24.911069', 1);
INSERT INTO `eb_system_city` VALUES (1677, 272156, 2, 270222, '360728000000', '定南县', '江西,赣州,定南', '115.027845', '24.784410', 1);
INSERT INTO `eb_system_city` VALUES (1678, 272302, 2, 270222, '360729000000', '全南县', '江西,赣州,全南', '114.530125', '24.742403', 1);
INSERT INTO `eb_system_city` VALUES (1679, 272408, 2, 270222, '360730000000', '宁都县', '江西,赣州,宁都', '116.009472', '26.470116', 1);
INSERT INTO `eb_system_city` VALUES (1680, 272767, 2, 270222, '360731000000', '于都县', '江西,赣州,于都', '115.415508', '25.952069', 1);
INSERT INTO `eb_system_city` VALUES (1681, 273183, 2, 270222, '360732000000', '兴国县', '江西,赣州,兴国', '115.363190', '26.337937', 1);
INSERT INTO `eb_system_city` VALUES (1682, 273525, 2, 270222, '360733000000', '会昌县', '江西,赣州,会昌', '115.786057', '25.600272', 1);
INSERT INTO `eb_system_city` VALUES (1683, 273820, 2, 270222, '360734000000', '寻乌县', '江西,赣州,寻乌', '115.646636', '24.963371', 1);
INSERT INTO `eb_system_city` VALUES (1684, 274020, 2, 270222, '360735000000', '石城县', '江西,赣州,石城', '116.346995', '26.314775', 1);
INSERT INTO `eb_system_city` VALUES (1685, 274184, 2, 270222, '360781000000', '瑞金市', '江西,赣州,瑞金', '116.027135', '25.885555', 1);
INSERT INTO `eb_system_city` VALUES (1686, 274445, 2, 274444, '360801000000', '市辖区', '江西,吉安', '114.992509', '27.113443', 1);
INSERT INTO `eb_system_city` VALUES (1687, 274446, 2, 274444, '360802000000', '吉州区', '江西,吉安,吉州', '114.994764', '27.143801', 1);
INSERT INTO `eb_system_city` VALUES (1688, 274592, 2, 274444, '360803000000', '青原区', '江西,吉安,青原', '115.014812', '27.081977', 1);
INSERT INTO `eb_system_city` VALUES (1689, 274736, 2, 274444, '360821000000', '吉安县', '江西,吉安,吉安', '114.907733', '27.039890', 1);
INSERT INTO `eb_system_city` VALUES (1690, 275105, 2, 274444, '360822000000', '吉水县', '江西,吉安,吉水', '115.135507', '27.229632', 1);
INSERT INTO `eb_system_city` VALUES (1691, 275406, 2, 274444, '360823000000', '峡江县', '江西,吉安,峡江', '115.316566', '27.582901', 1);
INSERT INTO `eb_system_city` VALUES (1692, 275511, 2, 274444, '360824000000', '新干县', '江西,吉安,新干', '115.387052', '27.740192', 1);
INSERT INTO `eb_system_city` VALUES (1693, 275694, 2, 274444, '360825000000', '永丰县', '江西,吉安,永丰', '115.444320', '27.318852', 1);
INSERT INTO `eb_system_city` VALUES (1694, 275956, 2, 274444, '360826000000', '泰和县', '江西,吉安,泰和', '114.908869', '26.789960', 1);
INSERT INTO `eb_system_city` VALUES (1695, 276331, 2, 274444, '360827000000', '遂川县', '江西,吉安,遂川', '114.520537', '26.313737', 1);
INSERT INTO `eb_system_city` VALUES (1696, 276700, 2, 274444, '360828000000', '万安县', '江西,吉安,万安', '114.786182', '26.458254', 1);
INSERT INTO `eb_system_city` VALUES (1697, 276874, 2, 274444, '360829000000', '安福县', '江西,吉安,安福', '114.619893', '27.392874', 1);
INSERT INTO `eb_system_city` VALUES (1698, 277170, 2, 274444, '360830000000', '永新县', '江西,吉安,永新', '114.243096', '26.945002', 1);
INSERT INTO `eb_system_city` VALUES (1699, 277459, 2, 274444, '360881000000', '井冈山市', '江西,吉安,井冈山', '114.289228', '26.748081', 1);
INSERT INTO `eb_system_city` VALUES (1700, 277616, 2, 277615, '360901000000', '市辖区', '江西,宜春', '114.416778', '27.815619', 1);
INSERT INTO `eb_system_city` VALUES (1701, 277617, 2, 277615, '360902000000', '袁州区', '江西,宜春,袁州', '114.424657', '27.798846', 1);
INSERT INTO `eb_system_city` VALUES (1702, 278033, 2, 277615, '360921000000', '奉新县', '江西,宜春,奉新', '115.400491', '28.688423', 1);
INSERT INTO `eb_system_city` VALUES (1703, 278249, 2, 277615, '360922000000', '万载县', '江西,宜春,万载', '114.445523', '28.106004', 1);
INSERT INTO `eb_system_city` VALUES (1704, 278471, 2, 277615, '360923000000', '上高县', '江西,宜春,上高', '114.947594', '28.238509', 1);
INSERT INTO `eb_system_city` VALUES (1705, 278710, 2, 277615, '360924000000', '宜丰县', '江西,宜春,宜丰', '114.803515', '28.393666', 1);
INSERT INTO `eb_system_city` VALUES (1706, 278975, 2, 277615, '360925000000', '靖安县', '江西,宜春,靖安', '115.362629', '28.861479', 1);
INSERT INTO `eb_system_city` VALUES (1707, 279095, 2, 277615, '360926000000', '铜鼓县', '江西,宜春,铜鼓', '114.371172', '28.520770', 1);
INSERT INTO `eb_system_city` VALUES (1708, 279220, 2, 277615, '360981000000', '丰城市', '江西,宜春,丰城', '115.771094', '28.159142', 1);
INSERT INTO `eb_system_city` VALUES (1709, 279845, 2, 277615, '360982000000', '樟树市', '江西,宜春,樟树', '115.546385', '28.054814', 1);
INSERT INTO `eb_system_city` VALUES (1710, 280166, 2, 277615, '360983000000', '高安市', '江西,宜春,高安', '115.375616', '28.417255', 1);
INSERT INTO `eb_system_city` VALUES (1711, 280563, 2, 280562, '361001000000', '市辖区', '江西,抚州', '116.358181', '27.949217', 1);
INSERT INTO `eb_system_city` VALUES (1712, 280564, 2, 280562, '361002000000', '临川区', '江西,抚州,临川', '116.312167', '27.934573', 1);
INSERT INTO `eb_system_city` VALUES (1713, 281098, 2, 280562, '361021000000', '南城县', '江西,抚州,南城', '116.637040', '27.569678', 1);
INSERT INTO `eb_system_city` VALUES (1714, 281285, 2, 280562, '361022000000', '黎川县', '江西,抚州,黎川', '116.907681', '27.282333', 1);
INSERT INTO `eb_system_city` VALUES (1715, 281443, 2, 280562, '361023000000', '南丰县', '江西,抚州,南丰', '116.525725', '27.218445', 1);
INSERT INTO `eb_system_city` VALUES (1716, 281641, 2, 280562, '361024000000', '崇仁县', '江西,抚州,崇仁', '116.061101', '27.764394', 1);
INSERT INTO `eb_system_city` VALUES (1717, 281827, 2, 280562, '361025000000', '乐安县', '江西,抚州,乐安', '115.830481', '27.428765', 1);
INSERT INTO `eb_system_city` VALUES (1718, 282036, 2, 280562, '361026000000', '宜黄县', '江西,抚州,宜黄', '116.222128', '27.546146', 1);
INSERT INTO `eb_system_city` VALUES (1719, 282206, 2, 280562, '361027000000', '金溪县', '江西,抚州,金溪', '116.755058', '27.918959', 1);
INSERT INTO `eb_system_city` VALUES (1720, 282391, 2, 280562, '361028000000', '资溪县', '江西,抚州,资溪', '117.060264', '27.706102', 1);
INSERT INTO `eb_system_city` VALUES (1721, 282482, 2, 280562, '361029000000', '东乡县', '江西,抚州,东乡县', '116.603560', '28.247697', 1);
INSERT INTO `eb_system_city` VALUES (1722, 282684, 2, 280562, '361030000000', '广昌县', '江西,抚州,广昌', '116.325757', '26.837267', 1);
INSERT INTO `eb_system_city` VALUES (1723, 282842, 2, 282841, '361101000000', '市辖区', '江西,上饶', '117.943433', '28.454862', 1);
INSERT INTO `eb_system_city` VALUES (1724, 282843, 2, 282841, '361102000000', '信州区', '江西,上饶,信州', '117.966460', '28.431002', 1);
INSERT INTO `eb_system_city` VALUES (1725, 282978, 2, 282841, '361103000000', '广丰区', '江西,上饶,广丰', '118.191240', '28.436286', 1);
INSERT INTO `eb_system_city` VALUES (1726, 283240, 2, 282841, '361121000000', '上饶县', '江西,上饶,上饶', '117.907850', '28.448983', 1);
INSERT INTO `eb_system_city` VALUES (1727, 283511, 2, 282841, '361123000000', '玉山县', '江西,上饶,玉山', '118.245124', '28.682055', 1);
INSERT INTO `eb_system_city` VALUES (1728, 283769, 2, 282841, '361124000000', '铅山县', '江西,上饶,铅山', '117.709451', '28.315217', 1);
INSERT INTO `eb_system_city` VALUES (1729, 283970, 2, 282841, '361125000000', '横峰县', '江西,上饶,横峰', '117.596452', '28.407118', 1);
INSERT INTO `eb_system_city` VALUES (1730, 284066, 2, 282841, '361126000000', '弋阳县', '江西,上饶,弋阳', '117.449588', '28.378044', 1);
INSERT INTO `eb_system_city` VALUES (1731, 284239, 2, 282841, '361127000000', '余干县', '江西,上饶,余干', '116.695647', '28.702302', 1);
INSERT INTO `eb_system_city` VALUES (1732, 284706, 2, 282841, '361128000000', '鄱阳县', '江西,上饶,鄱阳', '116.699746', '29.011699', 1);
INSERT INTO `eb_system_city` VALUES (1733, 285319, 2, 282841, '361129000000', '万年县', '江西,上饶,万年', '117.058445', '28.694582', 1);
INSERT INTO `eb_system_city` VALUES (1734, 285488, 2, 282841, '361130000000', '婺源县', '江西,上饶,婺源', '117.861798', '29.248086', 1);
INSERT INTO `eb_system_city` VALUES (1735, 285711, 2, 282841, '361181000000', '德兴市', '江西,上饶,德兴', '117.578713', '28.946464', 1);
INSERT INTO `eb_system_city` VALUES (1736, 285862, 2, 285861, '370101000000', '市辖区', '山东,济南', '117.119999', '36.651216', 1);
INSERT INTO `eb_system_city` VALUES (1737, 285863, 2, 285861, '370102000000', '历下区', '山东,济南,历下', '117.076455', '36.666412', 1);
INSERT INTO `eb_system_city` VALUES (1738, 285991, 2, 285861, '370103000000', '市中区', '山东,济南,市中', '116.997777', '36.651474', 1);
INSERT INTO `eb_system_city` VALUES (1739, 286215, 2, 285861, '370104000000', '槐荫区', '山东,济南,槐荫', '116.901224', '36.651441', 1);
INSERT INTO `eb_system_city` VALUES (1740, 286404, 2, 285861, '370105000000', '天桥区', '山东,济南,天桥', '116.987492', '36.678016', 1);
INSERT INTO `eb_system_city` VALUES (1741, 286683, 2, 285861, '370112000000', '历城区', '山东,济南,历城', '117.065237', '36.680017', 1);
INSERT INTO `eb_system_city` VALUES (1742, 287424, 2, 285861, '370113000000', '长清区', '山东,济南,长清', '116.751937', '36.553571', 1);
INSERT INTO `eb_system_city` VALUES (1743, 288084, 2, 285861, '370124000000', '平阴县', '山东,济南,平阴', '116.456187', '36.289265', 1);
INSERT INTO `eb_system_city` VALUES (1744, 288448, 2, 285861, '370125000000', '济阳县', '山东,济南,济阳', '117.173525', '36.978537', 1);
INSERT INTO `eb_system_city` VALUES (1745, 289313, 2, 285861, '370126000000', '商河县', '山东,济南,商河', '117.157183', '37.309045', 1);
INSERT INTO `eb_system_city` VALUES (1746, 290291, 2, 285861, '370181000000', '章丘市', '山东,济南,章丘', '117.526228', '36.681259', 1);
INSERT INTO `eb_system_city` VALUES (1747, 291236, 2, 291235, '370201000000', '市辖区', '山东,青岛', '120.382639', '36.067082', 1);
INSERT INTO `eb_system_city` VALUES (1748, 291237, 2, 291235, '370202000000', '市南区', '山东,青岛,市南', '120.412392', '36.075651', 1);
INSERT INTO `eb_system_city` VALUES (1749, 291313, 2, 291235, '370203000000', '市北区', '山东,青岛,市北', '120.374731', '36.087609', 1);
INSERT INTO `eb_system_city` VALUES (1750, 291468, 2, 291235, '370211000000', '黄岛区', '山东,青岛,黄岛', '120.046190', '35.872664', 1);
INSERT INTO `eb_system_city` VALUES (1751, 292713, 2, 291235, '370212000000', '崂山区', '山东,青岛,崂山', '120.468956', '36.107538', 1);
INSERT INTO `eb_system_city` VALUES (1752, 292879, 2, 291235, '370213000000', '李沧区', '山东,青岛,李沧', '120.432697', '36.145463', 1);
INSERT INTO `eb_system_city` VALUES (1753, 293008, 2, 291235, '370214000000', '城阳区', '山东,青岛,城阳', '120.396310', '36.307064', 1);
INSERT INTO `eb_system_city` VALUES (1754, 293241, 2, 291235, '370281000000', '胶州市', '山东,青岛,胶州', '120.033382', '36.264680', 1);
INSERT INTO `eb_system_city` VALUES (1755, 294138, 2, 291235, '370282000000', '即墨市', '山东,青岛,即墨', '120.447128', '36.389639', 1);
INSERT INTO `eb_system_city` VALUES (1756, 295251, 2, 291235, '370283000000', '平度市', '山东,青岛,平度', '119.988420', '36.776358', 1);
INSERT INTO `eb_system_city` VALUES (1757, 297121, 2, 291235, '370285000000', '莱西市', '山东,青岛,莱西', '120.517690', '36.889084', 1);
INSERT INTO `eb_system_city` VALUES (1758, 298026, 2, 298025, '370301000000', '市辖区', '山东,淄博', '118.054927', '36.813487', 1);
INSERT INTO `eb_system_city` VALUES (1759, 298027, 2, 298025, '370302000000', '淄川区', '山东,淄博,淄川', '117.966723', '36.643452', 1);
INSERT INTO `eb_system_city` VALUES (1760, 298507, 2, 298025, '370303000000', '张店区', '山东,淄博,张店', '118.017913', '36.806674', 1);
INSERT INTO `eb_system_city` VALUES (1761, 298821, 2, 298025, '370304000000', '博山区', '山东,淄博,博山', '117.861677', '36.494721', 1);
INSERT INTO `eb_system_city` VALUES (1762, 299159, 2, 298025, '370305000000', '临淄区', '山东,淄博,临淄', '118.309118', '36.826981', 1);
INSERT INTO `eb_system_city` VALUES (1763, 299652, 2, 298025, '370306000000', '周村区', '山东,淄博,周村', '117.869886', '36.803072', 1);
INSERT INTO `eb_system_city` VALUES (1764, 299919, 2, 298025, '370321000000', '桓台县', '山东,淄博,桓台', '118.097923', '36.959804', 1);
INSERT INTO `eb_system_city` VALUES (1765, 300276, 2, 298025, '370322000000', '高青县', '山东,淄博,高青', '117.826916', '37.171063', 1);
INSERT INTO `eb_system_city` VALUES (1766, 301056, 2, 298025, '370323000000', '沂源县', '山东,淄博,沂源', '118.170856', '36.185038', 1);
INSERT INTO `eb_system_city` VALUES (1767, 301712, 2, 301711, '370401000000', '市辖区', '山东,枣庄', '117.323725', '34.810487', 1);
INSERT INTO `eb_system_city` VALUES (1768, 301713, 2, 301711, '370402000000', '市中区', '山东,枣庄,市中', '117.556123', '34.864114', 1);
INSERT INTO `eb_system_city` VALUES (1769, 301888, 2, 301711, '370403000000', '薛城区', '山东,枣庄,薛城', '117.263164', '34.795063', 1);
INSERT INTO `eb_system_city` VALUES (1770, 302179, 2, 301711, '370404000000', '峄城区', '山东,枣庄,峄城', '117.590816', '34.773263', 1);
INSERT INTO `eb_system_city` VALUES (1771, 302532, 2, 301711, '370405000000', '台儿庄区', '山东,枣庄,台儿庄', '117.733832', '34.562528', 1);
INSERT INTO `eb_system_city` VALUES (1772, 302750, 2, 301711, '370406000000', '山亭区', '山东,枣庄,山亭', '117.461517', '35.099528', 1);
INSERT INTO `eb_system_city` VALUES (1773, 303037, 2, 301711, '370481000000', '滕州市', '山东,枣庄,滕州', '117.165824', '35.114156', 1);
INSERT INTO `eb_system_city` VALUES (1774, 304310, 2, 304309, '370501000000', '市辖区', '山东,东营', '118.674767', '37.434751', 1);
INSERT INTO `eb_system_city` VALUES (1775, 304311, 2, 304309, '370502000000', '东营区', '山东,东营,东营', '118.582184', '37.448963', 1);
INSERT INTO `eb_system_city` VALUES (1776, 304647, 2, 304309, '370503000000', '河口区', '山东,东营,河口', '118.525543', '37.886162', 1);
INSERT INTO `eb_system_city` VALUES (1777, 304845, 2, 304309, '370505000000', '垦利区', '山东,东营,垦利', '118.674767', '37.434751', 1);
INSERT INTO `eb_system_city` VALUES (1778, 305208, 2, 304309, '370522000000', '利津县', '山东,东营,利津', '118.255273', '37.490260', 1);
INSERT INTO `eb_system_city` VALUES (1779, 305747, 2, 304309, '370523000000', '广饶县', '山东,东营,广饶', '118.407107', '37.053555', 1);
INSERT INTO `eb_system_city` VALUES (1780, 306340, 2, 306339, '370601000000', '市辖区', '山东,烟台', '121.447935', '37.463822', 1);
INSERT INTO `eb_system_city` VALUES (1781, 306341, 2, 306339, '370602000000', '芝罘区', '山东,烟台,芝罘', '121.400031', '37.540687', 1);
INSERT INTO `eb_system_city` VALUES (1782, 306496, 2, 306339, '370611000000', '福山区', '山东,烟台,福山', '121.267741', '37.498246', 1);
INSERT INTO `eb_system_city` VALUES (1783, 306743, 2, 306339, '370612000000', '牟平区', '山东,烟台,牟平', '121.600512', '37.386901', 1);
INSERT INTO `eb_system_city` VALUES (1784, 307348, 2, 306339, '370613000000', '莱山区', '山东,烟台,莱山', '121.445151', '37.511361', 1);
INSERT INTO `eb_system_city` VALUES (1785, 307481, 2, 306339, '370634000000', '长岛县', '山东,烟台,长岛', '120.736580', '37.921368', 1);
INSERT INTO `eb_system_city` VALUES (1786, 307530, 2, 306339, '370681000000', '龙口市', '山东,烟台,龙口', '120.477813', '37.646108', 1);
INSERT INTO `eb_system_city` VALUES (1787, 308140, 2, 306339, '370682000000', '莱阳市', '山东,烟台,莱阳', '120.711673', '36.978941', 1);
INSERT INTO `eb_system_city` VALUES (1788, 308953, 2, 306339, '370683000000', '莱州市', '山东,烟台,莱州', '119.942327', '37.177017', 1);
INSERT INTO `eb_system_city` VALUES (1789, 309985, 2, 306339, '370684000000', '蓬莱市', '山东,烟台,蓬莱', '120.758848', '37.810661', 1);
INSERT INTO `eb_system_city` VALUES (1790, 310581, 2, 306339, '370685000000', '招远市', '山东,烟台,招远', '120.434072', '37.355469', 1);
INSERT INTO `eb_system_city` VALUES (1791, 311342, 2, 306339, '370686000000', '栖霞市', '山东,烟台,栖霞', '120.849675', '37.335123', 1);
INSERT INTO `eb_system_city` VALUES (1792, 312312, 2, 306339, '370687000000', '海阳市', '山东,烟台,海阳', '121.158434', '36.776378', 1);
INSERT INTO `eb_system_city` VALUES (1793, 313064, 2, 313063, '370701000000', '市辖区', '山东,潍坊', '119.161755', '36.706774', 1);
INSERT INTO `eb_system_city` VALUES (1794, 313065, 2, 313063, '370702000000', '潍城区', '山东,潍坊,潍城', '119.024836', '36.728100', 1);
INSERT INTO `eb_system_city` VALUES (1795, 313327, 2, 313063, '370703000000', '寒亭区', '山东,潍坊,寒亭', '119.219734', '36.775491', 1);
INSERT INTO `eb_system_city` VALUES (1796, 313701, 2, 313063, '370704000000', '坊子区', '山东,潍坊,坊子', '119.166485', '36.654448', 1);
INSERT INTO `eb_system_city` VALUES (1797, 314288, 2, 313063, '370705000000', '奎文区', '山东,潍坊,奎文', '119.132486', '36.707676', 1);
INSERT INTO `eb_system_city` VALUES (1798, 314533, 2, 313063, '370724000000', '临朐县', '山东,潍坊,临朐', '118.542982', '36.512506', 1);
INSERT INTO `eb_system_city` VALUES (1799, 314894, 2, 313063, '370725000000', '昌乐县', '山东,潍坊,昌乐', '118.829914', '36.706945', 1);
INSERT INTO `eb_system_city` VALUES (1800, 315273, 2, 313063, '370781000000', '青州市', '山东,潍坊,青州', '118.479636', '36.684600', 1);
INSERT INTO `eb_system_city` VALUES (1801, 316361, 2, 313063, '370782000000', '诸城市', '山东,潍坊,诸城', '119.410103', '35.995654', 1);
INSERT INTO `eb_system_city` VALUES (1802, 316642, 2, 313063, '370783000000', '寿光市', '山东,潍坊,寿光', '118.790652', '36.855480', 1);
INSERT INTO `eb_system_city` VALUES (1803, 317633, 2, 313063, '370784000000', '安丘市', '山东,潍坊,安丘', '119.218978', '36.478494', 1);
INSERT INTO `eb_system_city` VALUES (1804, 318512, 2, 313063, '370785000000', '高密市', '山东,潍坊,高密', '119.755597', '36.382595', 1);
INSERT INTO `eb_system_city` VALUES (1805, 319478, 2, 313063, '370786000000', '昌邑市', '山东,潍坊,昌邑', '119.398525', '36.858820', 1);
INSERT INTO `eb_system_city` VALUES (1806, 320180, 2, 320179, '370801000000', '市辖区', '山东,济宁', '116.587098', '35.414921', 1);
INSERT INTO `eb_system_city` VALUES (1807, 320181, 2, 320179, '370811000000', '任城区', '山东,济宁,任城', '116.595050', '35.406596', 1);
INSERT INTO `eb_system_city` VALUES (1808, 320795, 2, 320179, '370812000000', '兖州区', '山东,济宁,兖州', '116.783834', '35.553144', 1);
INSERT INTO `eb_system_city` VALUES (1809, 321246, 2, 320179, '370826000000', '微山县', '山东,济宁,微山', '117.128828', '34.806554', 1);
INSERT INTO `eb_system_city` VALUES (1810, 321804, 2, 320179, '370827000000', '鱼台县', '山东,济宁,鱼台', '116.650608', '35.012749', 1);
INSERT INTO `eb_system_city` VALUES (1811, 322209, 2, 320179, '370828000000', '金乡县', '山东,济宁,金乡', '116.311532', '35.066620', 1);
INSERT INTO `eb_system_city` VALUES (1812, 322882, 2, 320179, '370829000000', '嘉祥县', '山东,济宁,嘉祥', '116.342442', '35.407829', 1);
INSERT INTO `eb_system_city` VALUES (1813, 323607, 2, 320179, '370830000000', '汶上县', '山东,济宁,汶上', '116.489043', '35.732799', 1);
INSERT INTO `eb_system_city` VALUES (1814, 324118, 2, 320179, '370831000000', '泗水县', '山东,济宁,泗水', '117.251195', '35.664323', 1);
INSERT INTO `eb_system_city` VALUES (1815, 324729, 2, 320179, '370832000000', '梁山县', '山东,济宁,梁山', '116.096044', '35.802306', 1);
INSERT INTO `eb_system_city` VALUES (1816, 325372, 2, 320179, '370881000000', '曲阜市', '山东,济宁,曲阜', '116.986503', '35.580996', 1);
INSERT INTO `eb_system_city` VALUES (1817, 325791, 2, 320179, '370883000000', '邹城市', '山东,济宁,邹城', '117.003743', '35.405185', 1);
INSERT INTO `eb_system_city` VALUES (1818, 326707, 2, 326706, '370901000000', '市辖区', '山东,泰安', '117.087614', '36.200252', 1);
INSERT INTO `eb_system_city` VALUES (1819, 326708, 2, 326706, '370902000000', '泰山区', '山东,泰安,泰山', '117.135354', '36.192084', 1);
INSERT INTO `eb_system_city` VALUES (1820, 326926, 2, 326706, '370911000000', '岱岳区', '山东,泰安,岱岳', '117.041582', '36.187990', 1);
INSERT INTO `eb_system_city` VALUES (1821, 327655, 2, 326706, '370921000000', '宁阳县', '山东,泰安,宁阳', '116.805797', '35.758787', 1);
INSERT INTO `eb_system_city` VALUES (1822, 328231, 2, 326706, '370923000000', '东平县', '山东,泰安,东平', '116.470304', '35.937102', 1);
INSERT INTO `eb_system_city` VALUES (1823, 328962, 2, 326706, '370982000000', '新泰市', '山东,泰安,新泰', '117.767953', '35.909032', 1);
INSERT INTO `eb_system_city` VALUES (1824, 329897, 2, 326706, '370983000000', '肥城市', '山东,泰安,肥城', '116.768358', '36.182572', 1);
INSERT INTO `eb_system_city` VALUES (1825, 330548, 2, 330547, '371001000000', '市辖区', '山东,威海', '122.120419', '37.513068', 1);
INSERT INTO `eb_system_city` VALUES (1826, 330549, 2, 330547, '371002000000', '环翠区', '山东,威海,环翠', '122.123444', '37.501991', 1);
INSERT INTO `eb_system_city` VALUES (1827, 330748, 2, 330547, '371003000000', '文登区', '山东,威海,文登', '122.057941', '37.193886', 1);
INSERT INTO `eb_system_city` VALUES (1828, 331529, 2, 330547, '371082000000', '荣成市', '山东,威海,荣成', '122.486658', '37.165160', 1);
INSERT INTO `eb_system_city` VALUES (1829, 332496, 2, 330547, '371083000000', '乳山市', '山东,威海,乳山', '121.539765', '36.919816', 1);
INSERT INTO `eb_system_city` VALUES (1830, 333141, 2, 333140, '371101000000', '市辖区', '山东,日照', '119.526888', '35.416377', 1);
INSERT INTO `eb_system_city` VALUES (1831, 333142, 2, 333140, '371102000000', '东港区', '山东,日照,东港', '119.462228', '35.425475', 1);
INSERT INTO `eb_system_city` VALUES (1832, 333755, 2, 333140, '371103000000', '岚山区', '山东,日照,岚山', '119.318929', '35.121884', 1);
INSERT INTO `eb_system_city` VALUES (1833, 334188, 2, 333140, '371121000000', '五莲县', '山东,日照,五莲', '119.206763', '35.751927', 1);
INSERT INTO `eb_system_city` VALUES (1834, 334833, 2, 333140, '371122000000', '莒县', '山东,日照,莒县', '118.837064', '35.579868', 1);
INSERT INTO `eb_system_city` VALUES (1835, 336051, 2, 336050, '371201000000', '市辖区', '山东,莱芜', '117.676723', '36.213813', 1);
INSERT INTO `eb_system_city` VALUES (1836, 336052, 2, 336050, '371202000000', '莱城区', '山东,莱芜,莱城', '117.659884', '36.203180', 1);
INSERT INTO `eb_system_city` VALUES (1837, 336908, 2, 336050, '371203000000', '钢城区', '山东,莱芜,钢城', '117.811355', '36.058572', 1);
INSERT INTO `eb_system_city` VALUES (1838, 337145, 2, 337144, '371301000000', '市辖区', '山东,临沂', '118.356448', '35.104672', 1);
INSERT INTO `eb_system_city` VALUES (1839, 337146, 2, 337144, '371302000000', '兰山区', '山东,临沂,兰山', '118.347731', '35.051734', 1);
INSERT INTO `eb_system_city` VALUES (1840, 337621, 2, 337144, '371311000000', '罗庄区', '山东,临沂,罗庄', '118.284786', '34.996741', 1);
INSERT INTO `eb_system_city` VALUES (1841, 337844, 2, 337144, '371312000000', '河东区', '山东,临沂,河东', '118.402893', '35.089917', 1);
INSERT INTO `eb_system_city` VALUES (1842, 338188, 2, 337144, '371321000000', '沂南县', '山东,临沂,沂南', '118.465213', '35.549976', 1);
INSERT INTO `eb_system_city` VALUES (1843, 338778, 2, 337144, '371322000000', '郯城县', '山东,临沂,郯城', '118.367263', '34.613557', 1);
INSERT INTO `eb_system_city` VALUES (1844, 339408, 2, 337144, '371323000000', '沂水县', '山东,临沂,沂水', '118.627918', '35.790450', 1);
INSERT INTO `eb_system_city` VALUES (1845, 340490, 2, 337144, '371324000000', '兰陵县', '山东,临沂,兰陵', '118.070650', '34.857149', 1);
INSERT INTO `eb_system_city` VALUES (1846, 341532, 2, 337144, '371325000000', '费县', '山东,临沂,费县', '117.977325', '35.265961', 1);
INSERT INTO `eb_system_city` VALUES (1847, 342020, 2, 337144, '371326000000', '平邑县', '山东,临沂,平邑', '117.640352', '35.505943', 1);
INSERT INTO `eb_system_city` VALUES (1848, 342766, 2, 337144, '371327000000', '莒南县', '山东,临沂,莒南', '118.835163', '35.174846', 1);
INSERT INTO `eb_system_city` VALUES (1849, 343361, 2, 337144, '371328000000', '蒙阴县', '山东,临沂,蒙阴', '117.945085', '35.710032', 1);
INSERT INTO `eb_system_city` VALUES (1850, 343836, 2, 337144, '371329000000', '临沭县', '山东,临沂,临沭', '118.650782', '34.919852', 1);
INSERT INTO `eb_system_city` VALUES (1851, 344134, 2, 344133, '371401000000', '市辖区', '山东,德州', '116.357464', '37.434092', 1);
INSERT INTO `eb_system_city` VALUES (1852, 344135, 2, 344133, '371402000000', '德城区', '山东,德州,德城', '116.299471', '37.450805', 1);
INSERT INTO `eb_system_city` VALUES (1853, 344244, 2, 344133, '371403000000', '陵城区', '山东,德州,陵城', '116.576092', '37.335794', 1);
INSERT INTO `eb_system_city` VALUES (1854, 345248, 2, 344133, '371422000000', '宁津县', '山东,德州,宁津', '116.800306', '37.652190', 1);
INSERT INTO `eb_system_city` VALUES (1855, 346117, 2, 344133, '371423000000', '庆云县', '山东,德州,庆云', '117.385257', '37.775350', 1);
INSERT INTO `eb_system_city` VALUES (1856, 346518, 2, 344133, '371424000000', '临邑县', '山东,德州,临邑', '116.866800', '37.189798', 1);
INSERT INTO `eb_system_city` VALUES (1857, 346715, 2, 344133, '371425000000', '齐河县', '山东,德州,齐河', '116.762810', '36.783415', 1);
INSERT INTO `eb_system_city` VALUES (1858, 347749, 2, 344133, '371426000000', '平原县', '山东,德州,平原', '116.434056', '37.165314', 1);
INSERT INTO `eb_system_city` VALUES (1859, 347943, 2, 344133, '371427000000', '夏津县', '山东,德州,夏津', '116.001726', '36.948371', 1);
INSERT INTO `eb_system_city` VALUES (1860, 348268, 2, 344133, '371428000000', '武城县', '山东,德州,武城', '116.069302', '37.213311', 1);
INSERT INTO `eb_system_city` VALUES (1861, 348472, 2, 344133, '371481000000', '乐陵市', '山东,德州,乐陵', '117.231935', '37.729907', 1);
INSERT INTO `eb_system_city` VALUES (1862, 348980, 2, 344133, '371482000000', '禹城市', '山东,德州,禹城', '116.638327', '36.933812', 1);
INSERT INTO `eb_system_city` VALUES (1863, 349383, 2, 349382, '371501000000', '市辖区', '山东,聊城', '115.985371', '36.456703', 1);
INSERT INTO `eb_system_city` VALUES (1864, 349384, 2, 349382, '371502000000', '东昌府区', '山东,聊城,东昌府', '115.988491', '36.434645', 1);
INSERT INTO `eb_system_city` VALUES (1865, 350543, 2, 349382, '371521000000', '阳谷县', '山东,聊城,阳谷', '115.791820', '36.114392', 1);
INSERT INTO `eb_system_city` VALUES (1866, 351436, 2, 349382, '371522000000', '莘县', '山东,聊城,莘县', '115.671191', '36.233598', 1);
INSERT INTO `eb_system_city` VALUES (1867, 352587, 2, 349382, '371523000000', '茌平县', '山东,聊城,茌平', '115.985371', '36.456703', 1);
INSERT INTO `eb_system_city` VALUES (1868, 353334, 2, 349382, '371524000000', '东阿县', '山东,聊城,东阿', '116.247580', '36.334917', 1);
INSERT INTO `eb_system_city` VALUES (1869, 353863, 2, 349382, '371525000000', '冠县', '山东,聊城,冠县', '115.442740', '36.484009', 1);
INSERT INTO `eb_system_city` VALUES (1870, 354643, 2, 349382, '371526000000', '高唐县', '山东,聊城,高唐', '116.230158', '36.846755', 1);
INSERT INTO `eb_system_city` VALUES (1871, 355301, 2, 349382, '371581000000', '临清市', '山东,聊城,临清', '115.704881', '36.838277', 1);
INSERT INTO `eb_system_city` VALUES (1872, 355973, 2, 355972, '371601000000', '市辖区', '山东,滨州', '117.970703', '37.381990', 1);
INSERT INTO `eb_system_city` VALUES (1873, 355974, 2, 355972, '371602000000', '滨城区', '山东,滨州,滨城', '118.019326', '37.430724', 1);
INSERT INTO `eb_system_city` VALUES (1874, 356960, 2, 355972, '371603000000', '沾化区', '山东,滨州,沾化', '118.098902', '37.699260', 1);
INSERT INTO `eb_system_city` VALUES (1875, 357420, 2, 355972, '371621000000', '惠民县', '山东,滨州,惠民', '117.509921', '37.489877', 1);
INSERT INTO `eb_system_city` VALUES (1876, 358556, 2, 355972, '371622000000', '阳信县', '山东,滨州,阳信', '117.578262', '37.641106', 1);
INSERT INTO `eb_system_city` VALUES (1877, 359424, 2, 355972, '371623000000', '无棣县', '山东,滨州,无棣', '117.625696', '37.770260', 1);
INSERT INTO `eb_system_city` VALUES (1878, 360038, 2, 355972, '371625000000', '博兴县', '山东,滨州,博兴', '118.131815', '37.150226', 1);
INSERT INTO `eb_system_city` VALUES (1879, 360507, 2, 355972, '371626000000', '邹平县', '山东,滨州,邹平', '117.743109', '36.862989', 1);
INSERT INTO `eb_system_city` VALUES (1880, 361376, 2, 361375, '371701000000', '市辖区', '山东,菏泽', '115.480656', '35.233750', 1);
INSERT INTO `eb_system_city` VALUES (1881, 361377, 2, 361375, '371702000000', '牡丹区', '山东,菏泽,牡丹', '115.417827', '35.252512', 1);
INSERT INTO `eb_system_city` VALUES (1882, 361988, 2, 361375, '371703000000', '定陶区', '山东,菏泽,定陶', '115.569619', '35.072701', 1);
INSERT INTO `eb_system_city` VALUES (1883, 362368, 2, 361375, '371721000000', '曹县', '山东,菏泽,曹县', '115.542328', '34.825508', 1);
INSERT INTO `eb_system_city` VALUES (1884, 363576, 2, 361375, '371722000000', '单县', '山东,菏泽,单县', '116.107428', '34.778808', 1);
INSERT INTO `eb_system_city` VALUES (1885, 364107, 2, 361375, '371723000000', '成武县', '山东,菏泽,成武', '115.889765', '34.952459', 1);
INSERT INTO `eb_system_city` VALUES (1886, 364606, 2, 361375, '371724000000', '巨野县', '山东,菏泽,巨野', '116.065396', '35.387374', 1);
INSERT INTO `eb_system_city` VALUES (1887, 365498, 2, 361375, '371725000000', '郓城县', '山东,菏泽,郓城', '115.943613', '35.599758', 1);
INSERT INTO `eb_system_city` VALUES (1888, 366562, 2, 361375, '371726000000', '鄄城县', '山东,菏泽,鄄城', '115.510193', '35.563408', 1);
INSERT INTO `eb_system_city` VALUES (1889, 366971, 2, 361375, '371728000000', '东明县', '山东,菏泽,东明', '115.089905', '35.289368', 1);
INSERT INTO `eb_system_city` VALUES (1890, 367397, 2, 367396, '410101000000', '市辖区', '河南,郑州', '113.625368', '34.746599', 1);
INSERT INTO `eb_system_city` VALUES (1891, 367398, 2, 367396, '410102000000', '中原区', '河南,郑州,中原', '113.612850', '34.748257', 1);
INSERT INTO `eb_system_city` VALUES (1892, 367563, 2, 367396, '410103000000', '二七区', '河南,郑州,二七', '113.640179', '34.723930', 1);
INSERT INTO `eb_system_city` VALUES (1893, 367741, 2, 367396, '410104000000', '管城回族区', '河南,郑州,管城', '113.625368', '34.746599', 1);
INSERT INTO `eb_system_city` VALUES (1894, 367877, 2, 367396, '410105000000', '金水区', '河南,郑州,金水', '113.660555', '34.800156', 1);
INSERT INTO `eb_system_city` VALUES (1895, 368151, 2, 367396, '410106000000', '上街区', '河南,郑州,上街', '113.308961', '34.802780', 1);
INSERT INTO `eb_system_city` VALUES (1896, 368217, 2, 367396, '410108000000', '惠济区', '河南,郑州,惠济', '113.616901', '34.867458', 1);
INSERT INTO `eb_system_city` VALUES (1897, 368291, 2, 367396, '410122000000', '中牟县', '河南,郑州,中牟', '113.976254', '34.718937', 1);
INSERT INTO `eb_system_city` VALUES (1898, 368635, 2, 367396, '410181000000', '巩义市', '河南,郑州,巩义', '113.022497', '34.747834', 1);
INSERT INTO `eb_system_city` VALUES (1899, 368975, 2, 367396, '410182000000', '荥阳市', '河南,郑州,荥阳', '113.383221', '34.787375', 1);
INSERT INTO `eb_system_city` VALUES (1900, 369293, 2, 367396, '410183000000', '新密市', '河南,郑州,新密', '113.390891', '34.539443', 1);
INSERT INTO `eb_system_city` VALUES (1901, 369663, 2, 367396, '410184000000', '新郑市', '河南,郑州,新郑', '113.740529', '34.395562', 1);
INSERT INTO `eb_system_city` VALUES (1902, 369963, 2, 367396, '410185000000', '登封市', '河南,郑州,登封', '113.050492', '34.453667', 1);
INSERT INTO `eb_system_city` VALUES (1903, 370305, 2, 370304, '410201000000', '市辖区', '河南,开封', '114.307581', '34.797239', 1);
INSERT INTO `eb_system_city` VALUES (1904, 370306, 2, 370304, '410202000000', '龙亭区', '河南,开封,龙亭', '114.354730', '34.815784', 1);
INSERT INTO `eb_system_city` VALUES (1905, 370373, 2, 370304, '410203000000', '顺河回族区', '河南,开封,顺河', '114.369716', '34.811344', 1);
INSERT INTO `eb_system_city` VALUES (1906, 370450, 2, 370304, '410204000000', '鼓楼区', '河南,开封,鼓楼', '114.348307', '34.788561', 1);
INSERT INTO `eb_system_city` VALUES (1907, 370501, 2, 370304, '410205000000', '禹王台区', '河南,开封,禹王台', '114.348170', '34.777104', 1);
INSERT INTO `eb_system_city` VALUES (1908, 370557, 2, 370304, '410211000000', '金明区', '河南,开封,金明', '114.307581', '34.797239', 1);
INSERT INTO `eb_system_city` VALUES (1909, 370634, 2, 370304, '410212000000', '祥符区', '河南,开封,祥符', '114.441327', '34.756921', 1);
INSERT INTO `eb_system_city` VALUES (1910, 370995, 2, 370304, '410221000000', '杞县', '河南,开封,杞县', '114.783041', '34.549166', 1);
INSERT INTO `eb_system_city` VALUES (1911, 371618, 2, 370304, '410222000000', '通许县', '河南,开封,通许', '114.467467', '34.480433', 1);
INSERT INTO `eb_system_city` VALUES (1912, 371942, 2, 370304, '410223000000', '尉氏县', '河南,开封,尉氏', '114.193081', '34.411494', 1);
INSERT INTO `eb_system_city` VALUES (1913, 372481, 2, 370304, '410225000000', '兰考县', '河南,开封,兰考', '114.821348', '34.822211', 1);
INSERT INTO `eb_system_city` VALUES (1914, 372972, 2, 372971, '410301000000', '市辖区', '河南,洛阳', '112.454040', '34.619682', 1);
INSERT INTO `eb_system_city` VALUES (1915, 372973, 2, 372971, '410302000000', '老城区', '河南,洛阳,老城', '112.469024', '34.683646', 1);
INSERT INTO `eb_system_city` VALUES (1916, 373030, 2, 372971, '410303000000', '西工区', '河南,洛阳,西工', '112.428413', '34.659900', 1);
INSERT INTO `eb_system_city` VALUES (1917, 373105, 2, 372971, '410304000000', '瀍河回族区', '河南,洛阳,瀍河', '112.479653', '34.714976', 1);
INSERT INTO `eb_system_city` VALUES (1918, 373143, 2, 372971, '410305000000', '涧西区', '河南,洛阳,涧西', '112.395756', '34.658034', 1);
INSERT INTO `eb_system_city` VALUES (1919, 373227, 2, 372971, '410306000000', '吉利区', '河南,洛阳,吉利', '112.589052', '34.900889', 1);
INSERT INTO `eb_system_city` VALUES (1920, 373268, 2, 372971, '410311000000', '洛龙区', '河南,洛阳,洛龙', '112.464173', '34.619404', 1);
INSERT INTO `eb_system_city` VALUES (1921, 373554, 2, 372971, '410322000000', '孟津县', '河南,洛阳,孟津', '112.445252', '34.825307', 1);
INSERT INTO `eb_system_city` VALUES (1922, 373799, 2, 372971, '410323000000', '新安县', '河南,洛阳,新安', '112.132488', '34.728584', 1);
INSERT INTO `eb_system_city` VALUES (1923, 374121, 2, 372971, '410324000000', '栾川县', '河南,洛阳,栾川', '111.615769', '33.785698', 1);
INSERT INTO `eb_system_city` VALUES (1924, 374349, 2, 372971, '410325000000', '嵩县', '河南,洛阳,嵩县', '112.085634', '34.134517', 1);
INSERT INTO `eb_system_city` VALUES (1925, 374694, 2, 372971, '410326000000', '汝阳县', '河南,洛阳,汝阳', '112.473139', '34.153940', 1);
INSERT INTO `eb_system_city` VALUES (1926, 374929, 2, 372971, '410327000000', '宜阳县', '河南,洛阳,宜阳', '112.179238', '34.514645', 1);
INSERT INTO `eb_system_city` VALUES (1927, 375308, 2, 372971, '410328000000', '洛宁县', '河南,洛阳,洛宁', '111.653039', '34.389414', 1);
INSERT INTO `eb_system_city` VALUES (1928, 375717, 2, 372971, '410329000000', '伊川县', '河南,洛阳,伊川', '112.425651', '34.421460', 1);
INSERT INTO `eb_system_city` VALUES (1929, 376105, 2, 372971, '410381000000', '偃师市', '河南,洛阳,偃师', '112.789535', '34.727220', 1);
INSERT INTO `eb_system_city` VALUES (1930, 376366, 2, 376365, '410401000000', '市辖区', '河南,平顶山', '113.192661', '33.766169', 1);
INSERT INTO `eb_system_city` VALUES (1931, 376367, 2, 376365, '410402000000', '新华区', '河南,平顶山,新华', '113.293999', '33.737365', 1);
INSERT INTO `eb_system_city` VALUES (1932, 376442, 2, 376365, '410403000000', '卫东区', '河南,平顶山,卫东', '113.335193', '33.734707', 1);
INSERT INTO `eb_system_city` VALUES (1933, 376513, 2, 376365, '410404000000', '石龙区', '河南,平顶山,石龙', '112.898818', '33.898713', 1);
INSERT INTO `eb_system_city` VALUES (1934, 376532, 2, 376365, '410411000000', '湛河区', '河南,平顶山,湛河', '113.320873', '33.725681', 1);
INSERT INTO `eb_system_city` VALUES (1935, 376643, 2, 376365, '410421000000', '宝丰县', '河南,平顶山,宝丰', '113.054754', '33.868441', 1);
INSERT INTO `eb_system_city` VALUES (1936, 376984, 2, 376365, '410422000000', '叶县', '河南,平顶山,叶县', '113.357239', '33.626731', 1);
INSERT INTO `eb_system_city` VALUES (1937, 377555, 2, 376365, '410423000000', '鲁山县', '河南,平顶山,鲁山', '112.908023', '33.738518', 1);
INSERT INTO `eb_system_city` VALUES (1938, 378139, 2, 376365, '410425000000', '郏县', '河南,平顶山,郏县', '113.212609', '33.971787', 1);
INSERT INTO `eb_system_city` VALUES (1939, 378532, 2, 376365, '410481000000', '舞钢市', '河南,平顶山,舞钢', '113.524794', '33.307776', 1);
INSERT INTO `eb_system_city` VALUES (1940, 378764, 2, 376365, '410482000000', '汝州市', '河南,平顶山,汝州', '112.844517', '34.167030', 1);
INSERT INTO `eb_system_city` VALUES (1941, 379246, 2, 379245, '410501000000', '市辖区', '河南,安阳', '114.392392', '36.097577', 1);
INSERT INTO `eb_system_city` VALUES (1942, 379247, 2, 379245, '410502000000', '文峰区', '河南,安阳,文峰', '114.357082', '36.090468', 1);
INSERT INTO `eb_system_city` VALUES (1943, 379400, 2, 379245, '410503000000', '北关区', '河南,安阳,北关', '114.355822', '36.107255', 1);
INSERT INTO `eb_system_city` VALUES (1944, 379488, 2, 379245, '410505000000', '殷都区', '河南,安阳,殷都', '114.303410', '36.109890', 1);
INSERT INTO `eb_system_city` VALUES (1945, 379584, 2, 379245, '410506000000', '龙安区', '河南,安阳,龙安', '114.323522', '36.095568', 1);
INSERT INTO `eb_system_city` VALUES (1946, 379742, 2, 379245, '410522000000', '安阳县', '河南,安阳,安阳', '114.130207', '36.130585', 1);
INSERT INTO `eb_system_city` VALUES (1947, 380371, 2, 379245, '410523000000', '汤阴县', '河南,安阳,汤阴', '114.357763', '35.924515', 1);
INSERT INTO `eb_system_city` VALUES (1948, 380688, 2, 379245, '410526000000', '滑县', '河南,安阳,滑县', '114.518997', '35.575002', 1);
INSERT INTO `eb_system_city` VALUES (1949, 381731, 2, 379245, '410527000000', '内黄县', '河南,安阳,内黄', '114.901492', '35.971653', 1);
INSERT INTO `eb_system_city` VALUES (1950, 382281, 2, 379245, '410581000000', '林州市', '河南,安阳,林州', '113.820130', '36.083047', 1);
INSERT INTO `eb_system_city` VALUES (1951, 382879, 2, 382878, '410601000000', '市辖区', '河南,鹤壁', '114.297272', '35.747225', 1);
INSERT INTO `eb_system_city` VALUES (1952, 382880, 2, 382878, '410602000000', '鹤山区', '河南,鹤壁,鹤山', '114.163367', '35.954582', 1);
INSERT INTO `eb_system_city` VALUES (1953, 382969, 2, 382878, '410603000000', '山城区', '河南,鹤壁,山城', '114.184428', '35.897703', 1);
INSERT INTO `eb_system_city` VALUES (1954, 383079, 2, 382878, '410611000000', '淇滨区', '河南,鹤壁,淇滨', '114.298694', '35.741296', 1);
INSERT INTO `eb_system_city` VALUES (1955, 383228, 2, 382878, '410621000000', '浚县', '河南,鹤壁,浚县', '114.550813', '35.676240', 1);
INSERT INTO `eb_system_city` VALUES (1956, 383704, 2, 382878, '410622000000', '淇县', '河南,鹤壁,淇县', '114.197651', '35.607762', 1);
INSERT INTO `eb_system_city` VALUES (1957, 383891, 2, 383890, '410701000000', '市辖区', '河南,新乡', '113.926800', '35.303004', 1);
INSERT INTO `eb_system_city` VALUES (1958, 383892, 2, 383890, '410702000000', '红旗区', '河南,新乡,红旗', '113.875245', '35.303851', 1);
INSERT INTO `eb_system_city` VALUES (1959, 383978, 2, 383890, '410703000000', '卫滨区', '河南,新乡,卫滨', '113.865780', '35.302117', 1);
INSERT INTO `eb_system_city` VALUES (1960, 384041, 2, 383890, '410704000000', '凤泉区', '河南,新乡,凤泉', '113.915184', '35.383978', 1);
INSERT INTO `eb_system_city` VALUES (1961, 384093, 2, 383890, '410711000000', '牧野区', '河南,新乡,牧野', '113.908772', '35.315039', 1);
INSERT INTO `eb_system_city` VALUES (1962, 384193, 2, 383890, '410721000000', '新乡县', '河南,新乡,新乡', '113.805205', '35.190836', 1);
INSERT INTO `eb_system_city` VALUES (1963, 384380, 2, 383890, '410724000000', '获嘉县', '河南,新乡,获嘉', '113.657433', '35.259808', 1);
INSERT INTO `eb_system_city` VALUES (1964, 384622, 2, 383890, '410725000000', '原阳县', '河南,新乡,原阳', '113.940115', '35.065587', 1);
INSERT INTO `eb_system_city` VALUES (1965, 385122, 2, 383890, '410726000000', '延津县', '河南,新乡,延津', '114.205197', '35.141956', 1);
INSERT INTO `eb_system_city` VALUES (1966, 385485, 2, 383890, '410727000000', '封丘县', '河南,新乡,封丘', '114.418882', '35.041198', 1);
INSERT INTO `eb_system_city` VALUES (1967, 386113, 2, 383890, '410728000000', '长垣县', '河南,新乡,长垣', '114.668936', '35.201548', 1);
INSERT INTO `eb_system_city` VALUES (1968, 386744, 2, 383890, '410781000000', '卫辉市', '河南,新乡,卫辉', '114.064907', '35.398494', 1);
INSERT INTO `eb_system_city` VALUES (1969, 387125, 2, 383890, '410782000000', '辉县市', '河南,新乡,辉', '113.926800', '35.303004', 1);
INSERT INTO `eb_system_city` VALUES (1970, 387708, 2, 387707, '410801000000', '市辖区', '河南,焦作', '113.241823', '35.215892', 1);
INSERT INTO `eb_system_city` VALUES (1971, 387709, 2, 387707, '410802000000', '解放区', '河南,焦作,解放', '113.230817', '35.240282', 1);
INSERT INTO `eb_system_city` VALUES (1972, 387776, 2, 387707, '410803000000', '中站区', '河南,焦作,中站', '113.182946', '35.236820', 1);
INSERT INTO `eb_system_city` VALUES (1973, 387836, 2, 387707, '410804000000', '马村区', '河南,焦作,马村', '113.322332', '35.256108', 1);
INSERT INTO `eb_system_city` VALUES (1974, 387922, 2, 387707, '410811000000', '山阳区', '河南,焦作,山阳', '113.254881', '35.214507', 1);
INSERT INTO `eb_system_city` VALUES (1975, 387985, 2, 387707, '410821000000', '修武县', '河南,焦作,修武', '113.447755', '35.223514', 1);
INSERT INTO `eb_system_city` VALUES (1976, 388187, 2, 387707, '410822000000', '博爱县', '河南,焦作,博爱', '113.064379', '35.171045', 1);
INSERT INTO `eb_system_city` VALUES (1977, 388415, 2, 387707, '410823000000', '武陟县', '河南,焦作,武陟', '113.401679', '35.099378', 1);
INSERT INTO `eb_system_city` VALUES (1978, 388783, 2, 387707, '410825000000', '温县', '河南,焦作,温县', '113.080530', '34.940189', 1);
INSERT INTO `eb_system_city` VALUES (1979, 389064, 2, 387707, '410882000000', '沁阳市', '河南,焦作,沁阳', '112.950716', '35.087539', 1);
INSERT INTO `eb_system_city` VALUES (1980, 389418, 2, 387707, '410883000000', '孟州市', '河南,焦作,孟州', '112.789612', '34.907970', 1);
INSERT INTO `eb_system_city` VALUES (1981, 389720, 2, 389719, '410901000000', '市辖区', '河南,濮阳', '115.029215', '35.761829', 1);
INSERT INTO `eb_system_city` VALUES (1982, 389721, 2, 389719, '410902000000', '华龙区', '河南,濮阳,华龙', '115.074151', '35.777346', 1);
INSERT INTO `eb_system_city` VALUES (1983, 389884, 2, 389719, '410922000000', '清丰县', '河南,濮阳,清丰', '115.104389', '35.885180', 1);
INSERT INTO `eb_system_city` VALUES (1984, 390411, 2, 389719, '410923000000', '南乐县', '河南,濮阳,南乐', '115.204752', '36.069664', 1);
INSERT INTO `eb_system_city` VALUES (1985, 390751, 2, 389719, '410926000000', '范县', '河南,濮阳,范县', '115.504201', '35.851907', 1);
INSERT INTO `eb_system_city` VALUES (1986, 391345, 2, 389719, '410927000000', '台前县', '河南,濮阳,台前', '115.871906', '35.969390', 1);
INSERT INTO `eb_system_city` VALUES (1987, 391730, 2, 389719, '410928000000', '濮阳县', '河南,濮阳,濮阳', '115.029078', '35.712193', 1);
INSERT INTO `eb_system_city` VALUES (1988, 392738, 2, 392737, '411001000000', '市辖区', '河南,许昌', '113.852640', '34.035506', 1);
INSERT INTO `eb_system_city` VALUES (1989, 392739, 2, 392737, '411002000000', '魏都区', '河南,许昌,魏都', '113.822647', '34.025342', 1);
INSERT INTO `eb_system_city` VALUES (1990, 392850, 2, 392737, '411023000000', '许昌县', '河南,许昌,许昌', '113.822983', '34.124660', 1);
INSERT INTO `eb_system_city` VALUES (1991, 393306, 2, 392737, '411024000000', '鄢陵县', '河南,许昌,鄢陵', '114.177400', '34.102332', 1);
INSERT INTO `eb_system_city` VALUES (1992, 393705, 2, 392737, '411025000000', '襄城县', '河南,许昌,襄城', '113.482453', '33.846369', 1);
INSERT INTO `eb_system_city` VALUES (1993, 394170, 2, 392737, '411081000000', '禹州市', '河南,许昌,禹州', '113.488478', '34.140701', 1);
INSERT INTO `eb_system_city` VALUES (1994, 394863, 2, 392737, '411082000000', '长葛市', '河南,许昌,长葛', '113.819888', '34.194136', 1);
INSERT INTO `eb_system_city` VALUES (1995, 395255, 2, 395254, '411101000000', '市辖区', '河南,漯河', '114.016539', '33.581412', 1);
INSERT INTO `eb_system_city` VALUES (1996, 395256, 2, 395254, '411102000000', '源汇区', '河南,漯河,源汇', '114.017948', '33.565441', 1);
INSERT INTO `eb_system_city` VALUES (1997, 395392, 2, 395254, '411103000000', '郾城区', '河南,漯河,郾城', '114.006944', '33.587409', 1);
INSERT INTO `eb_system_city` VALUES (1998, 395601, 2, 395254, '411104000000', '召陵区', '河南,漯河,召陵', '114.093902', '33.586565', 1);
INSERT INTO `eb_system_city` VALUES (1999, 395816, 2, 395254, '411121000000', '舞阳县', '河南,漯河,舞阳', '113.609286', '33.437877', 1);
INSERT INTO `eb_system_city` VALUES (2000, 396228, 2, 395254, '411122000000', '临颍县', '河南,漯河,临颍', '113.931203', '33.827304', 1);
INSERT INTO `eb_system_city` VALUES (2001, 396612, 2, 396611, '411201000000', '市辖区', '河南,三门峡', '111.200135', '34.772493', 1);
INSERT INTO `eb_system_city` VALUES (2002, 396613, 2, 396611, '411202000000', '湖滨区', '河南,三门峡,湖滨', '111.188398', '34.770886', 1);
INSERT INTO `eb_system_city` VALUES (2003, 396710, 2, 396611, '411203000000', '陕州区', '河南,三门峡,陕州', '111.103563', '34.720548', 1);
INSERT INTO `eb_system_city` VALUES (2004, 396996, 2, 396611, '411221000000', '渑池县', '河南,三门峡,渑池', '111.761504', '34.767244', 1);
INSERT INTO `eb_system_city` VALUES (2005, 397257, 2, 396611, '411224000000', '卢氏县', '河南,三门峡,卢氏', '111.047858', '34.054324', 1);
INSERT INTO `eb_system_city` VALUES (2006, 397644, 2, 396611, '411281000000', '义马市', '河南,三门峡,义马', '111.874393', '34.747129', 1);
INSERT INTO `eb_system_city` VALUES (2007, 397687, 2, 396611, '411282000000', '灵宝市', '河南,三门峡,灵宝', '110.894220', '34.516828', 1);
INSERT INTO `eb_system_city` VALUES (2008, 398170, 2, 398169, '411301000000', '市辖区', '河南,南阳', '112.528321', '32.990833', 1);
INSERT INTO `eb_system_city` VALUES (2009, 398171, 2, 398169, '411302000000', '宛城区', '河南,南阳,宛城', '112.539559', '33.003784', 1);
INSERT INTO `eb_system_city` VALUES (2010, 398437, 2, 398169, '411303000000', '卧龙区', '河南,南阳,卧龙', '112.528789', '32.989877', 1);
INSERT INTO `eb_system_city` VALUES (2011, 398747, 2, 398169, '411321000000', '南召县', '河南,南阳,南召', '112.429133', '33.489877', 1);
INSERT INTO `eb_system_city` VALUES (2012, 399117, 2, 398169, '411322000000', '方城县', '河南,南阳,方城', '113.012494', '33.254391', 1);
INSERT INTO `eb_system_city` VALUES (2013, 399702, 2, 398169, '411323000000', '西峡县', '河南,南阳,西峡', '111.473530', '33.307294', 1);
INSERT INTO `eb_system_city` VALUES (2014, 400021, 2, 398169, '411324000000', '镇平县', '河南,南阳,镇平', '112.234698', '33.034111', 1);
INSERT INTO `eb_system_city` VALUES (2015, 400474, 2, 398169, '411325000000', '内乡县', '河南,南阳,内乡', '111.849392', '33.044865', 1);
INSERT INTO `eb_system_city` VALUES (2016, 400787, 2, 398169, '411326000000', '淅川县', '河南,南阳,淅川', '111.490964', '33.137820', 1);
INSERT INTO `eb_system_city` VALUES (2017, 401305, 2, 398169, '411327000000', '社旗县', '河南,南阳,社旗', '112.948245', '33.056109', 1);
INSERT INTO `eb_system_city` VALUES (2018, 401579, 2, 398169, '411328000000', '唐河县', '河南,南阳,唐河', '112.807637', '32.681335', 1);
INSERT INTO `eb_system_city` VALUES (2019, 402141, 2, 398169, '411329000000', '新野县', '河南,南阳,新野', '112.360026', '32.520805', 1);
INSERT INTO `eb_system_city` VALUES (2020, 402429, 2, 398169, '411330000000', '桐柏县', '河南,南阳,桐柏', '113.428287', '32.380073', 1);
INSERT INTO `eb_system_city` VALUES (2021, 402668, 2, 398169, '411381000000', '邓州市', '河南,南阳,邓州', '112.087278', '32.687938', 1);
INSERT INTO `eb_system_city` VALUES (2022, 403312, 2, 403311, '411401000000', '市辖区', '河南,商丘', '115.656370', '34.414172', 1);
INSERT INTO `eb_system_city` VALUES (2023, 403313, 2, 403311, '411402000000', '梁园区', '河南,商丘,梁园', '115.613965', '34.443893', 1);
INSERT INTO `eb_system_city` VALUES (2024, 403577, 2, 403311, '411403000000', '睢阳区', '河南,商丘,睢阳', '115.653302', '34.388390', 1);
INSERT INTO `eb_system_city` VALUES (2025, 403992, 2, 403311, '411421000000', '民权县', '河南,商丘,民权', '115.179594', '34.647758', 1);
INSERT INTO `eb_system_city` VALUES (2026, 404572, 2, 403311, '411422000000', '睢县', '河南,商丘,睢县', '115.071879', '34.445656', 1);
INSERT INTO `eb_system_city` VALUES (2027, 405150, 2, 403311, '411423000000', '宁陵县', '河南,商丘,宁陵', '115.313690', '34.460232', 1);
INSERT INTO `eb_system_city` VALUES (2028, 405530, 2, 403311, '411424000000', '柘城县', '河南,商丘,柘城', '115.305843', '34.091045', 1);
INSERT INTO `eb_system_city` VALUES (2029, 406070, 2, 403311, '411425000000', '虞城县', '河南,商丘,虞城', '115.840511', '34.402512', 1);
INSERT INTO `eb_system_city` VALUES (2030, 406717, 2, 403311, '411426000000', '夏邑县', '河南,商丘,夏邑', '116.131447', '34.237554', 1);
INSERT INTO `eb_system_city` VALUES (2031, 407487, 2, 403311, '411481000000', '永城市', '河南,商丘,永城', '116.449500', '33.929291', 1);
INSERT INTO `eb_system_city` VALUES (2032, 408288, 2, 408287, '411501000000', '市辖区', '河南,信阳', '114.091023', '32.146983', 1);
INSERT INTO `eb_system_city` VALUES (2033, 408289, 2, 408287, '411502000000', '浉河区', '河南,信阳,浉河', '114.058713', '32.116803', 1);
INSERT INTO `eb_system_city` VALUES (2034, 408566, 2, 408287, '411503000000', '平桥区', '河南,信阳,平桥', '114.125656', '32.101031', 1);
INSERT INTO `eb_system_city` VALUES (2035, 408914, 2, 408287, '411521000000', '罗山县', '河南,信阳,罗山', '114.513012', '32.203073', 1);
INSERT INTO `eb_system_city` VALUES (2036, 409241, 2, 408287, '411522000000', '光山县', '河南,信阳,光山', '114.919033', '32.011103', 1);
INSERT INTO `eb_system_city` VALUES (2037, 409621, 2, 408287, '411523000000', '新县', '河南,信阳,新县', '114.879239', '31.643918', 1);
INSERT INTO `eb_system_city` VALUES (2038, 409844, 2, 408287, '411524000000', '商城县', '河南,信阳,商城', '115.406862', '31.798378', 1);
INSERT INTO `eb_system_city` VALUES (2039, 410235, 2, 408287, '411525000000', '固始县', '河南,信阳,固始', '115.654482', '32.168137', 1);
INSERT INTO `eb_system_city` VALUES (2040, 410916, 2, 408287, '411526000000', '潢川县', '河南,信阳,潢川', '115.051808', '32.131383', 1);
INSERT INTO `eb_system_city` VALUES (2041, 411226, 2, 408287, '411527000000', '淮滨县', '河南,信阳,淮滨', '115.419538', '32.473258', 1);
INSERT INTO `eb_system_city` VALUES (2042, 411541, 2, 408287, '411528000000', '息县', '河南,信阳,息县', '114.740456', '32.342792', 1);
INSERT INTO `eb_system_city` VALUES (2043, 411926, 2, 411925, '411601000000', '市辖区', '河南,周口', '114.696951', '33.626149', 1);
INSERT INTO `eb_system_city` VALUES (2044, 411927, 2, 411925, '411602000000', '川汇区', '河南,周口,川汇', '114.650628', '33.647598', 1);
INSERT INTO `eb_system_city` VALUES (2045, 412097, 2, 411925, '411621000000', '扶沟县', '河南,周口,扶沟', '114.394915', '34.059862', 1);
INSERT INTO `eb_system_city` VALUES (2046, 412526, 2, 411925, '411622000000', '西华县', '河南,周口,西华', '114.529756', '33.767408', 1);
INSERT INTO `eb_system_city` VALUES (2047, 413030, 2, 411925, '411623000000', '商水县', '河南,周口,商水', '114.611596', '33.542480', 1);
INSERT INTO `eb_system_city` VALUES (2048, 413644, 2, 411925, '411624000000', '沈丘县', '河南,周口,沈丘', '115.098583', '33.409369', 1);
INSERT INTO `eb_system_city` VALUES (2049, 414239, 2, 411925, '411625000000', '郸城县', '河南,周口,郸城', '115.177189', '33.644743', 1);
INSERT INTO `eb_system_city` VALUES (2050, 414779, 2, 411925, '411626000000', '淮阳县', '河南,周口,淮阳', '114.886154', '33.731561', 1);
INSERT INTO `eb_system_city` VALUES (2051, 415271, 2, 411925, '411627000000', '太康县', '河南,周口,太康', '114.837887', '34.063798', 1);
INSERT INTO `eb_system_city` VALUES (2052, 416070, 2, 411925, '411628000000', '鹿邑县', '河南,周口,鹿邑', '115.484454', '33.860000', 1);
INSERT INTO `eb_system_city` VALUES (2053, 416651, 2, 411925, '411681000000', '项城市', '河南,周口,项城', '114.875333', '33.465838', 1);
INSERT INTO `eb_system_city` VALUES (2054, 417175, 2, 417174, '411701000000', '市辖区', '河南,驻马店', '114.022298', '33.011529', 1);
INSERT INTO `eb_system_city` VALUES (2055, 417176, 2, 417174, '411702000000', '驿城区', '河南,驻马店,驿城', '113.993914', '32.973054', 1);
INSERT INTO `eb_system_city` VALUES (2056, 417405, 2, 417174, '411721000000', '西平县', '河南,驻马店,西平', '114.021539', '33.387685', 1);
INSERT INTO `eb_system_city` VALUES (2057, 417712, 2, 417174, '411722000000', '上蔡县', '河南,驻马店,上蔡', '114.264381', '33.262439', 1);
INSERT INTO `eb_system_city` VALUES (2058, 418199, 2, 417174, '411723000000', '平舆县', '河南,驻马店,平舆', '114.619159', '32.962710', 1);
INSERT INTO `eb_system_city` VALUES (2059, 418443, 2, 417174, '411724000000', '正阳县', '河南,驻马店,正阳', '114.392774', '32.605697', 1);
INSERT INTO `eb_system_city` VALUES (2060, 418759, 2, 417174, '411725000000', '确山县', '河南,驻马店,确山', '114.026430', '32.802065', 1);
INSERT INTO `eb_system_city` VALUES (2061, 418973, 2, 417174, '411726000000', '泌阳县', '河南,驻马店,泌阳', '113.327144', '32.723975', 1);
INSERT INTO `eb_system_city` VALUES (2062, 419354, 2, 417174, '411727000000', '汝南县', '河南,驻马店,汝南', '114.362379', '33.006729', 1);
INSERT INTO `eb_system_city` VALUES (2063, 419654, 2, 417174, '411728000000', '遂平县', '河南,驻马店,遂平', '114.013182', '33.145649', 1);
INSERT INTO `eb_system_city` VALUES (2064, 419874, 2, 417174, '411729000000', '新蔡县', '河南,驻马店,新蔡', '114.965469', '32.744855', 1);
INSERT INTO `eb_system_city` VALUES (2065, 420259, 2, 420258, '419001000000', '济源市', '河南,济源', '112.602341', '35.069031', 1);
INSERT INTO `eb_system_city` VALUES (2066, 420826, 2, 420825, '420101000000', '市辖区', '湖北,武汉', '114.305392', '30.593098', 1);
INSERT INTO `eb_system_city` VALUES (2067, 420827, 2, 420825, '420102000000', '江岸区', '湖北,武汉,江岸', '114.309091', '30.600064', 1);
INSERT INTO `eb_system_city` VALUES (2068, 420996, 2, 420825, '420103000000', '江汉区', '湖北,武汉,江汉', '114.270871', '30.601430', 1);
INSERT INTO `eb_system_city` VALUES (2069, 421122, 2, 420825, '420104000000', '硚口区', '湖北,武汉,硚口', '114.214920', '30.582202', 1);
INSERT INTO `eb_system_city` VALUES (2070, 421270, 2, 420825, '420105000000', '汉阳区', '湖北,武汉,汉阳', '114.218724', '30.553905', 1);
INSERT INTO `eb_system_city` VALUES (2071, 421400, 2, 420825, '420106000000', '武昌区', '湖北,武汉,武昌', '114.316223', '30.554235', 1);
INSERT INTO `eb_system_city` VALUES (2072, 421559, 2, 420825, '420107000000', '青山区', '湖北,武汉,青山', '114.385539', '30.639630', 1);
INSERT INTO `eb_system_city` VALUES (2073, 421676, 2, 420825, '420111000000', '洪山区', '湖北,武汉,洪山', '114.343913', '30.500317', 1);
INSERT INTO `eb_system_city` VALUES (2074, 421983, 2, 420825, '420112000000', '东西湖区', '湖北,武汉,东西湖', '114.136886', '30.620020', 1);
INSERT INTO `eb_system_city` VALUES (2075, 422149, 2, 420825, '420113000000', '汉南区', '湖北,武汉,汉南', '114.084445', '30.308856', 1);
INSERT INTO `eb_system_city` VALUES (2076, 422220, 2, 420825, '420114000000', '蔡甸区', '湖北,武汉,蔡甸', '114.029328', '30.582271', 1);
INSERT INTO `eb_system_city` VALUES (2077, 422631, 2, 420825, '420115000000', '江夏区', '湖北,武汉,江夏', '114.321551', '30.375748', 1);
INSERT INTO `eb_system_city` VALUES (2078, 423075, 2, 420825, '420116000000', '黄陂区', '湖北,武汉,黄陂', '114.375743', '30.882557', 1);
INSERT INTO `eb_system_city` VALUES (2079, 423775, 2, 420825, '420117000000', '新洲区', '湖北,武汉,新洲', '114.801107', '30.841544', 1);
INSERT INTO `eb_system_city` VALUES (2080, 424450, 2, 424449, '420201000000', '市辖区', '湖北,黄石', '115.038520', '30.199652', 1);
INSERT INTO `eb_system_city` VALUES (2081, 424451, 2, 424449, '420202000000', '黄石港区', '湖北,黄石,黄石港', '115.065978', '30.223003', 1);
INSERT INTO `eb_system_city` VALUES (2082, 424489, 2, 424449, '420203000000', '西塞山区', '湖北,黄石,西塞山', '115.109955', '30.204924', 1);
INSERT INTO `eb_system_city` VALUES (2083, 424531, 2, 424449, '420204000000', '下陆区', '湖北,黄石,下陆', '114.961327', '30.173913', 1);
INSERT INTO `eb_system_city` VALUES (2084, 424574, 2, 424449, '420205000000', '铁山区', '湖北,黄石,铁山', '114.901412', '30.206592', 1);
INSERT INTO `eb_system_city` VALUES (2085, 424590, 2, 424449, '420222000000', '阳新县', '湖北,黄石,阳新', '115.215227', '29.830258', 1);
INSERT INTO `eb_system_city` VALUES (2086, 425070, 2, 424449, '420281000000', '大冶市', '湖北,黄石,大冶', '114.979875', '30.095643', 1);
INSERT INTO `eb_system_city` VALUES (2087, 425509, 2, 425508, '420301000000', '市辖区', '湖北,十堰', '110.797990', '32.629397', 1);
INSERT INTO `eb_system_city` VALUES (2088, 425510, 2, 425508, '420302000000', '茅箭区', '湖北,十堰,茅箭', '110.813621', '32.591929', 1);
INSERT INTO `eb_system_city` VALUES (2089, 425592, 2, 425508, '420303000000', '张湾区', '湖北,十堰,张湾', '110.769133', '32.652297', 1);
INSERT INTO `eb_system_city` VALUES (2090, 425709, 2, 425508, '420304000000', '郧阳区', '湖北,十堰,郧阳', '110.812050', '32.834776', 1);
INSERT INTO `eb_system_city` VALUES (2091, 426078, 2, 425508, '420322000000', '郧西县', '湖北,十堰,郧西', '110.425983', '32.993182', 1);
INSERT INTO `eb_system_city` VALUES (2092, 426440, 2, 425508, '420323000000', '竹山县', '湖北,十堰,竹山', '110.228694', '32.224875', 1);
INSERT INTO `eb_system_city` VALUES (2093, 426708, 2, 425508, '420324000000', '竹溪县', '湖北,十堰,竹溪', '109.715304', '32.318255', 1);
INSERT INTO `eb_system_city` VALUES (2094, 427085, 2, 425508, '420325000000', '房县', '湖北,十堰,房县', '110.726670', '32.040085', 1);
INSERT INTO `eb_system_city` VALUES (2095, 427420, 2, 425508, '420381000000', '丹江口市', '湖北,十堰,丹江口', '111.513127', '32.540157', 1);
INSERT INTO `eb_system_city` VALUES (2096, 427711, 2, 427710, '420501000000', '市辖区', '湖北,宜昌', '111.286471', '30.691967', 1);
INSERT INTO `eb_system_city` VALUES (2097, 427712, 2, 427710, '420502000000', '西陵区', '湖北,宜昌,西陵', '111.285646', '30.710782', 1);
INSERT INTO `eb_system_city` VALUES (2098, 427828, 2, 427710, '420503000000', '伍家岗区', '湖北,宜昌,伍家岗', '111.361037', '30.644334', 1);
INSERT INTO `eb_system_city` VALUES (2099, 427894, 2, 427710, '420504000000', '点军区', '湖北,宜昌,点军', '111.268120', '30.693247', 1);
INSERT INTO `eb_system_city` VALUES (2100, 427953, 2, 427710, '420505000000', '猇亭区', '湖北,宜昌,猇亭', '111.434620', '30.530903', 1);
INSERT INTO `eb_system_city` VALUES (2101, 427983, 2, 427710, '420506000000', '夷陵区', '湖北,宜昌,夷陵', '111.326380', '30.770006', 1);
INSERT INTO `eb_system_city` VALUES (2102, 428194, 2, 427710, '420525000000', '远安县', '湖北,宜昌,远安', '111.640508', '31.060869', 1);
INSERT INTO `eb_system_city` VALUES (2103, 428319, 2, 427710, '420526000000', '兴山县', '湖北,宜昌,兴山', '110.746805', '31.348196', 1);
INSERT INTO `eb_system_city` VALUES (2104, 428424, 2, 427710, '420527000000', '秭归县', '湖北,宜昌,秭归', '110.977711', '30.825897', 1);
INSERT INTO `eb_system_city` VALUES (2105, 428630, 2, 427710, '420528000000', '长阳土家族自治县', '湖北,宜昌,长阳', '111.207242', '30.472763', 1);
INSERT INTO `eb_system_city` VALUES (2106, 428807, 2, 427710, '420529000000', '五峰土家族自治县', '湖北,宜昌,五峰', '110.674706', '30.199688', 1);
INSERT INTO `eb_system_city` VALUES (2107, 428924, 2, 427710, '420581000000', '宜都市', '湖北,宜昌,宜都', '111.450006', '30.378327', 1);
INSERT INTO `eb_system_city` VALUES (2108, 429089, 2, 427710, '420582000000', '当阳市', '湖北,宜昌,当阳', '111.788312', '30.821266', 1);
INSERT INTO `eb_system_city` VALUES (2109, 429273, 2, 427710, '420583000000', '枝江市', '湖北,宜昌,枝江', '111.760530', '30.425940', 1);
INSERT INTO `eb_system_city` VALUES (2110, 429502, 2, 429501, '420601000000', '市辖区', '湖北,襄阳', '112.122414', '32.008986', 1);
INSERT INTO `eb_system_city` VALUES (2111, 429503, 2, 429501, '420602000000', '襄城区', '湖北,襄阳,襄城', '112.133974', '32.010351', 1);
INSERT INTO `eb_system_city` VALUES (2112, 429687, 2, 429501, '420606000000', '樊城区', '湖北,襄阳,樊城', '112.135684', '32.044833', 1);
INSERT INTO `eb_system_city` VALUES (2113, 429907, 2, 429501, '420607000000', '襄州区', '湖北,襄阳,襄州', '112.211899', '32.087298', 1);
INSERT INTO `eb_system_city` VALUES (2114, 430402, 2, 429501, '420624000000', '南漳县', '湖北,襄阳,南漳', '111.838905', '31.774636', 1);
INSERT INTO `eb_system_city` VALUES (2115, 430723, 2, 429501, '420625000000', '谷城县', '湖北,襄阳,谷城', '111.652982', '32.263849', 1);
INSERT INTO `eb_system_city` VALUES (2116, 431025, 2, 429501, '420626000000', '保康县', '湖北,襄阳,保康', '111.261309', '31.878310', 1);
INSERT INTO `eb_system_city` VALUES (2117, 431301, 2, 429501, '420682000000', '老河口市', '湖北,襄阳,老河口', '111.683861', '32.359068', 1);
INSERT INTO `eb_system_city` VALUES (2118, 431575, 2, 429501, '420683000000', '枣阳市', '湖北,襄阳,枣阳', '112.771959', '32.128818', 1);
INSERT INTO `eb_system_city` VALUES (2119, 432166, 2, 429501, '420684000000', '宜城市', '湖北,襄阳,宜城', '112.257788', '31.719806', 1);
INSERT INTO `eb_system_city` VALUES (2120, 432416, 2, 432415, '420701000000', '市辖区', '湖北,鄂州', '114.894843', '30.391940', 1);
INSERT INTO `eb_system_city` VALUES (2121, 432417, 2, 432415, '420702000000', '梁子湖区', '湖北,鄂州,梁子湖', '114.684731', '30.100141', 1);
INSERT INTO `eb_system_city` VALUES (2122, 432510, 2, 432415, '420703000000', '华容区', '湖北,鄂州,华容', '114.729878', '30.534310', 1);
INSERT INTO `eb_system_city` VALUES (2123, 432633, 2, 432415, '420704000000', '鄂城区', '湖北,鄂州,鄂城', '114.891615', '30.400572', 1);
INSERT INTO `eb_system_city` VALUES (2124, 432830, 2, 432829, '420801000000', '市辖区', '湖北,荆门', '112.199265', '31.035423', 1);
INSERT INTO `eb_system_city` VALUES (2125, 432831, 2, 432829, '420802000000', '东宝区', '湖北,荆门,东宝', '112.201493', '31.051852', 1);
INSERT INTO `eb_system_city` VALUES (2126, 433052, 2, 432829, '420804000000', '掇刀区', '湖北,荆门,掇刀', '112.207833', '30.973431', 1);
INSERT INTO `eb_system_city` VALUES (2127, 433182, 2, 432829, '420821000000', '京山县', '湖北,荆门,京山', '113.119566', '31.018457', 1);
INSERT INTO `eb_system_city` VALUES (2128, 433634, 2, 432829, '420822000000', '沙洋县', '湖北,荆门,沙洋', '112.588581', '30.709221', 1);
INSERT INTO `eb_system_city` VALUES (2129, 433944, 2, 432829, '420881000000', '钟祥市', '湖北,荆门,钟祥', '112.588121', '31.167820', 1);
INSERT INTO `eb_system_city` VALUES (2130, 434549, 2, 434548, '420901000000', '市辖区', '湖北,孝感', '113.916902', '30.924568', 1);
INSERT INTO `eb_system_city` VALUES (2131, 434550, 2, 434548, '420902000000', '孝南区', '湖北,孝感,孝南', '113.910958', '30.916874', 1);
INSERT INTO `eb_system_city` VALUES (2132, 435091, 2, 434548, '420921000000', '孝昌县', '湖北,孝感,孝昌', '113.998010', '31.258159', 1);
INSERT INTO `eb_system_city` VALUES (2133, 435563, 2, 434548, '420922000000', '大悟县', '湖北,孝感,大悟', '114.127022', '31.561165', 1);
INSERT INTO `eb_system_city` VALUES (2134, 435956, 2, 434548, '420923000000', '云梦县', '湖北,孝感,云梦', '113.753554', '31.020983', 1);
INSERT INTO `eb_system_city` VALUES (2135, 436267, 2, 434548, '420981000000', '应城市', '湖北,孝感,应城', '113.572707', '30.928370', 1);
INSERT INTO `eb_system_city` VALUES (2136, 436706, 2, 434548, '420982000000', '安陆市', '湖北,孝感,安陆', '113.688941', '31.255610', 1);
INSERT INTO `eb_system_city` VALUES (2137, 437119, 2, 434548, '420984000000', '汉川市', '湖北,孝感,汉川', '113.839149', '30.661244', 1);
INSERT INTO `eb_system_city` VALUES (2138, 437780, 2, 437779, '421001000000', '市辖区', '湖北,荆州', '112.239741', '30.335165', 1);
INSERT INTO `eb_system_city` VALUES (2139, 437781, 2, 437779, '421002000000', '沙市区', '湖北,荆州,沙市', '112.255583', '30.311056', 1);
INSERT INTO `eb_system_city` VALUES (2140, 437909, 2, 437779, '421003000000', '荆州区', '湖北,荆州,荆州', '112.190185', '30.352832', 1);
INSERT INTO `eb_system_city` VALUES (2141, 438103, 2, 437779, '421022000000', '公安县', '湖北,荆州,公安', '112.229648', '30.058336', 1);
INSERT INTO `eb_system_city` VALUES (2142, 438512, 2, 437779, '421023000000', '监利县', '湖北,荆州,监利', '112.897465', '29.811574', 1);
INSERT INTO `eb_system_city` VALUES (2143, 439263, 2, 437779, '421024000000', '江陵县', '湖北,荆州,江陵', '112.424664', '30.041822', 1);
INSERT INTO `eb_system_city` VALUES (2144, 439491, 2, 437779, '421081000000', '石首市', '湖北,荆州,石首', '112.425454', '29.720938', 1);
INSERT INTO `eb_system_city` VALUES (2145, 439836, 2, 437779, '421083000000', '洪湖市', '湖北,荆州,洪湖', '113.475980', '29.825458', 1);
INSERT INTO `eb_system_city` VALUES (2146, 440344, 2, 437779, '421087000000', '松滋市', '湖北,荆州,松滋', '111.756773', '30.174522', 1);
INSERT INTO `eb_system_city` VALUES (2147, 440640, 2, 440639, '421101000000', '市辖区', '湖北,黄冈', '114.872316', '30.453905', 1);
INSERT INTO `eb_system_city` VALUES (2148, 440641, 2, 440639, '421102000000', '黄州区', '湖北,黄冈,黄州', '114.879398', '30.434050', 1);
INSERT INTO `eb_system_city` VALUES (2149, 440797, 2, 440639, '421121000000', '团风县', '湖北,黄冈,团风', '114.872191', '30.643569', 1);
INSERT INTO `eb_system_city` VALUES (2150, 441110, 2, 440639, '421122000000', '红安县', '湖北,黄冈,红安', '114.618236', '31.288153', 1);
INSERT INTO `eb_system_city` VALUES (2151, 441550, 2, 440639, '421123000000', '罗田县', '湖北,黄冈,罗田', '115.399492', '30.783100', 1);
INSERT INTO `eb_system_city` VALUES (2152, 442017, 2, 440639, '421124000000', '英山县', '湖北,黄冈,英山', '115.681259', '30.734959', 1);
INSERT INTO `eb_system_city` VALUES (2153, 442351, 2, 440639, '421125000000', '浠水县', '湖北,黄冈,浠水', '115.265535', '30.451867', 1);
INSERT INTO `eb_system_city` VALUES (2154, 443040, 2, 440639, '421126000000', '蕲春县', '湖北,黄冈,蕲春', '115.437008', '30.225964', 1);
INSERT INTO `eb_system_city` VALUES (2155, 443641, 2, 440639, '421127000000', '黄梅县', '湖北,黄冈,黄梅', '115.944219', '30.070454', 1);
INSERT INTO `eb_system_city` VALUES (2156, 444186, 2, 440639, '421181000000', '麻城市', '湖北,黄冈,麻城', '115.008163', '31.172740', 1);
INSERT INTO `eb_system_city` VALUES (2157, 444684, 2, 440639, '421182000000', '武穴市', '湖北,黄冈,武穴', '115.561217', '29.844107', 1);
INSERT INTO `eb_system_city` VALUES (2158, 445041, 2, 445040, '421201000000', '市辖区', '湖北,咸宁', '114.322492', '29.841443', 1);
INSERT INTO `eb_system_city` VALUES (2159, 445042, 2, 445040, '421202000000', '咸安区', '湖北,咸宁,咸安', '114.298711', '29.852892', 1);
INSERT INTO `eb_system_city` VALUES (2160, 445249, 2, 445040, '421221000000', '嘉鱼县', '湖北,咸宁,嘉鱼', '113.939277', '29.970737', 1);
INSERT INTO `eb_system_city` VALUES (2161, 445363, 2, 445040, '421222000000', '通城县', '湖北,咸宁,通城', '113.816966', '29.245269', 1);
INSERT INTO `eb_system_city` VALUES (2162, 445569, 2, 445040, '421223000000', '崇阳县', '湖北,咸宁,崇阳', '114.039828', '29.555605', 1);
INSERT INTO `eb_system_city` VALUES (2163, 445786, 2, 445040, '421224000000', '通山县', '湖北,咸宁,通山', '114.482606', '29.605376', 1);
INSERT INTO `eb_system_city` VALUES (2164, 446007, 2, 445040, '421281000000', '赤壁市', '湖北,咸宁,赤壁', '113.900628', '29.724692', 1);
INSERT INTO `eb_system_city` VALUES (2165, 446213, 2, 446212, '421301000000', '市辖区', '湖北,随州', '113.382458', '31.690215', 1);
INSERT INTO `eb_system_city` VALUES (2166, 446214, 2, 446212, '421303000000', '曾都区', '湖北,随州,曾都', '113.371121', '31.716280', 1);
INSERT INTO `eb_system_city` VALUES (2167, 446433, 2, 446212, '421321000000', '随县', '湖北,随州,随县', '113.299528', '31.853833', 1);
INSERT INTO `eb_system_city` VALUES (2168, 446847, 2, 446212, '421381000000', '广水市', '湖北,随州,广水', '113.825890', '31.616854', 1);
INSERT INTO `eb_system_city` VALUES (2169, 447269, 2, 447268, '422801000000', '恩施市', '湖北,恩施,恩施', '109.479665', '30.294680', 1);
INSERT INTO `eb_system_city` VALUES (2170, 447495, 2, 447268, '422802000000', '利川市', '湖北,恩施,利川', '108.936376', '30.290996', 1);
INSERT INTO `eb_system_city` VALUES (2171, 448099, 2, 447268, '422822000000', '建始县', '湖北,恩施,建始', '109.726667', '30.601555', 1);
INSERT INTO `eb_system_city` VALUES (2172, 448521, 2, 447268, '422823000000', '巴东县', '湖北,恩施,巴东', '110.340756', '31.042324', 1);
INSERT INTO `eb_system_city` VALUES (2173, 448856, 2, 447268, '422825000000', '宣恩县', '湖北,恩施,宣恩', '109.491485', '29.986899', 1);
INSERT INTO `eb_system_city` VALUES (2174, 449150, 2, 447268, '422826000000', '咸丰县', '湖北,恩施,咸丰', '109.139726', '29.665203', 1);
INSERT INTO `eb_system_city` VALUES (2175, 449431, 2, 447268, '422827000000', '来凤县', '湖北,恩施,来凤', '109.407828', '29.493485', 1);
INSERT INTO `eb_system_city` VALUES (2176, 449636, 2, 447268, '422828000000', '鹤峰县', '湖北,恩施,鹤峰', '110.033662', '29.890171', 1);
INSERT INTO `eb_system_city` VALUES (2177, 449866, 2, 449865, '429004000000', '仙桃市', '湖北,仙桃', '113.442970', '30.328407', 1);
INSERT INTO `eb_system_city` VALUES (2178, 450653, 2, 449865, '429005000000', '潜江市', '湖北,潜江', '112.900284', '30.401947', 1);
INSERT INTO `eb_system_city` VALUES (2179, 451150, 2, 449865, '429006000000', '天门市', '湖北,天门', '113.166557', '30.663719', 1);
INSERT INTO `eb_system_city` VALUES (2180, 452034, 2, 449865, '429021000000', '神农架林区', '湖北,神农架林', '110.675758', '31.744898', 1);
INSERT INTO `eb_system_city` VALUES (2181, 452125, 2, 452124, '430101000000', '市辖区', '湖南,长沙', '112.938814', '28.228209', 1);
INSERT INTO `eb_system_city` VALUES (2182, 452126, 2, 452124, '430102000000', '芙蓉区', '湖南,长沙,芙蓉', '113.032539', '28.185386', 1);
INSERT INTO `eb_system_city` VALUES (2183, 452213, 2, 452124, '430103000000', '天心区', '湖南,长沙,天心', '112.989855', '28.112525', 1);
INSERT INTO `eb_system_city` VALUES (2184, 452314, 2, 452124, '430104000000', '岳麓区', '湖南,长沙,岳麓', '112.931383', '28.235243', 1);
INSERT INTO `eb_system_city` VALUES (2185, 452486, 2, 452124, '430105000000', '开福区', '湖南,长沙,开福', '112.985545', '28.257269', 1);
INSERT INTO `eb_system_city` VALUES (2186, 452610, 2, 452124, '430111000000', '雨花区', '湖南,长沙,雨花', '113.038017', '28.137710', 1);
INSERT INTO `eb_system_city` VALUES (2187, 452771, 2, 452124, '430112000000', '望城区', '湖南,长沙,望城', '112.819549', '28.347458', 1);
INSERT INTO `eb_system_city` VALUES (2188, 452924, 2, 452124, '430121000000', '长沙县', '湖南,长沙,长沙', '113.080810', '28.246150', 1);
INSERT INTO `eb_system_city` VALUES (2189, 453140, 2, 452124, '430124000000', '宁乡县', '湖南,长沙,宁乡', '112.551885', '28.277483', 1);
INSERT INTO `eb_system_city` VALUES (2190, 453444, 2, 452124, '430181000000', '浏阳市', '湖南,长沙,浏阳', '113.643076', '28.162833', 1);
INSERT INTO `eb_system_city` VALUES (2191, 453800, 2, 453799, '430201000000', '市辖区', '湖南,株洲', '113.134002', '27.827550', 1);
INSERT INTO `eb_system_city` VALUES (2192, 453801, 2, 453799, '430202000000', '荷塘区', '湖南,株洲,荷塘', '113.173487', '27.855929', 1);
INSERT INTO `eb_system_city` VALUES (2193, 453867, 2, 453799, '430203000000', '芦淞区', '湖南,株洲,芦淞', '113.152724', '27.785070', 1);
INSERT INTO `eb_system_city` VALUES (2194, 453957, 2, 453799, '430204000000', '石峰区', '湖南,株洲,石峰', '113.117732', '27.875445', 1);
INSERT INTO `eb_system_city` VALUES (2195, 454008, 2, 453799, '430211000000', '天元区', '湖南,株洲,天元', '113.082216', '27.826867', 1);
INSERT INTO `eb_system_city` VALUES (2196, 454113, 2, 453799, '430221000000', '株洲县', '湖南,株洲,株洲', '113.144006', '27.699346', 1);
INSERT INTO `eb_system_city` VALUES (2197, 454261, 2, 453799, '430223000000', '攸县', '湖南,株洲,攸县', '113.345309', '27.000227', 1);
INSERT INTO `eb_system_city` VALUES (2198, 454580, 2, 453799, '430224000000', '茶陵县', '湖南,株洲,茶陵', '113.539280', '26.777492', 1);
INSERT INTO `eb_system_city` VALUES (2199, 454845, 2, 453799, '430225000000', '炎陵县', '湖南,株洲,炎陵', '113.772655', '26.489902', 1);
INSERT INTO `eb_system_city` VALUES (2200, 454989, 2, 453799, '430281000000', '醴陵市', '湖南,株洲,醴陵', '113.496894', '27.646130', 1);
INSERT INTO `eb_system_city` VALUES (2201, 455284, 2, 455283, '430301000000', '市辖区', '湖南,湘潭', '112.944049', '27.829738', 1);
INSERT INTO `eb_system_city` VALUES (2202, 455285, 2, 455283, '430302000000', '雨湖区', '湖南,湘潭,雨湖', '112.907238', '27.856250', 1);
INSERT INTO `eb_system_city` VALUES (2203, 455426, 2, 455283, '430304000000', '岳塘区', '湖南,湘潭,岳塘', '112.969480', '27.872028', 1);
INSERT INTO `eb_system_city` VALUES (2204, 455515, 2, 455283, '430321000000', '湘潭县', '湖南,湘潭,湘潭', '112.950831', '27.778958', 1);
INSERT INTO `eb_system_city` VALUES (2205, 455889, 2, 455283, '430381000000', '湘乡市', '湖南,湘潭,湘乡', '112.535028', '27.734120', 1);
INSERT INTO `eb_system_city` VALUES (2206, 456260, 2, 455283, '430382000000', '韶山市', '湖南,湘潭,韶山', '112.526671', '27.915009', 1);
INSERT INTO `eb_system_city` VALUES (2207, 456304, 2, 456303, '430401000000', '市辖区', '湖南,衡阳', '112.571997', '26.893230', 1);
INSERT INTO `eb_system_city` VALUES (2208, 456305, 2, 456303, '430405000000', '珠晖区', '湖南,衡阳,珠晖', '112.620112', '26.894657', 1);
INSERT INTO `eb_system_city` VALUES (2209, 456391, 2, 456303, '430406000000', '雁峰区', '湖南,衡阳,雁峰', '112.616546', '26.888666', 1);
INSERT INTO `eb_system_city` VALUES (2210, 456449, 2, 456303, '430407000000', '石鼓区', '湖南,衡阳,石鼓', '112.598089', '26.943215', 1);
INSERT INTO `eb_system_city` VALUES (2211, 456502, 2, 456303, '430408000000', '蒸湘区', '湖南,衡阳,蒸湘', '112.567064', '26.911404', 1);
INSERT INTO `eb_system_city` VALUES (2212, 456558, 2, 456303, '430412000000', '南岳区', '湖南,衡阳,南岳', '112.738604', '27.232444', 1);
INSERT INTO `eb_system_city` VALUES (2213, 456587, 2, 456303, '430421000000', '衡阳县', '湖南,衡阳,衡阳', '112.370532', '26.969635', 1);
INSERT INTO `eb_system_city` VALUES (2214, 457104, 2, 456303, '430422000000', '衡南县', '湖南,衡阳,衡南', '112.677877', '26.738248', 1);
INSERT INTO `eb_system_city` VALUES (2215, 457576, 2, 456303, '430423000000', '衡山县', '湖南,衡阳,衡山', '112.868268', '27.230291', 1);
INSERT INTO `eb_system_city` VALUES (2216, 457742, 2, 456303, '430424000000', '衡东县', '湖南,衡阳,衡东', '112.953168', '27.081170', 1);
INSERT INTO `eb_system_city` VALUES (2217, 458018, 2, 456303, '430426000000', '祁东县', '湖南,衡阳,祁东', '112.090357', '26.799896', 1);
INSERT INTO `eb_system_city` VALUES (2218, 458411, 2, 456303, '430481000000', '耒阳市', '湖南,衡阳,耒阳', '112.859795', '26.422275', 1);
INSERT INTO `eb_system_city` VALUES (2219, 458820, 2, 456303, '430482000000', '常宁市', '湖南,衡阳,常宁', '112.399995', '26.420932', 1);
INSERT INTO `eb_system_city` VALUES (2220, 459252, 2, 459251, '430501000000', '市辖区', '湖南,邵阳', '111.467791', '27.238892', 1);
INSERT INTO `eb_system_city` VALUES (2221, 459253, 2, 459251, '430502000000', '双清区', '湖南,邵阳,双清', '111.496341', '27.232708', 1);
INSERT INTO `eb_system_city` VALUES (2222, 459357, 2, 459251, '430503000000', '大祥区', '湖南,邵阳,大祥', '111.439091', '27.221452', 1);
INSERT INTO `eb_system_city` VALUES (2223, 459470, 2, 459251, '430511000000', '北塔区', '湖南,邵阳,北塔', '111.452197', '27.246489', 1);
INSERT INTO `eb_system_city` VALUES (2224, 459517, 2, 459251, '430521000000', '邵东县', '湖南,邵阳,邵东', '111.744258', '27.258942', 1);
INSERT INTO `eb_system_city` VALUES (2225, 460126, 2, 459251, '430522000000', '新邵县', '湖南,邵阳,新邵', '111.458657', '27.320918', 1);
INSERT INTO `eb_system_city` VALUES (2226, 460558, 2, 459251, '430523000000', '邵阳县', '湖南,邵阳,邵阳', '111.273806', '26.990637', 1);
INSERT INTO `eb_system_city` VALUES (2227, 461014, 2, 459251, '430524000000', '隆回县', '湖南,邵阳,隆回', '111.032438', '27.113978', 1);
INSERT INTO `eb_system_city` VALUES (2228, 461613, 2, 459251, '430525000000', '洞口县', '湖南,邵阳,洞口', '110.575846', '27.060321', 1);
INSERT INTO `eb_system_city` VALUES (2229, 462000, 2, 459251, '430527000000', '绥宁县', '湖南,邵阳,绥宁', '110.155655', '26.581955', 1);
INSERT INTO `eb_system_city` VALUES (2230, 462257, 2, 459251, '430528000000', '新宁县', '湖南,邵阳,新宁', '110.856623', '26.433418', 1);
INSERT INTO `eb_system_city` VALUES (2231, 462600, 2, 459251, '430529000000', '城步苗族自治县', '湖南,邵阳,城步', '111.467791', '27.238892', 1);
INSERT INTO `eb_system_city` VALUES (2232, 462807, 2, 459251, '430581000000', '武冈市', '湖南,邵阳,武冈', '110.631884', '26.726599', 1);
INSERT INTO `eb_system_city` VALUES (2233, 463142, 2, 463141, '430601000000', '市辖区', '湖南,岳阳', '113.128958', '29.357104', 1);
INSERT INTO `eb_system_city` VALUES (2234, 463143, 2, 463141, '430602000000', '岳阳楼区', '湖南,岳阳,岳阳楼', '113.129702', '29.371903', 1);
INSERT INTO `eb_system_city` VALUES (2235, 463333, 2, 463141, '430603000000', '云溪区', '湖南,岳阳,云溪', '113.272313', '29.472746', 1);
INSERT INTO `eb_system_city` VALUES (2236, 463397, 2, 463141, '430611000000', '君山区', '湖南,岳阳,君山', '113.006435', '29.461106', 1);
INSERT INTO `eb_system_city` VALUES (2237, 463489, 2, 463141, '430621000000', '岳阳县', '湖南,岳阳,岳阳', '113.116418', '29.144067', 1);
INSERT INTO `eb_system_city` VALUES (2238, 463722, 2, 463141, '430623000000', '华容县', '湖南,岳阳,华容', '112.540463', '29.531057', 1);
INSERT INTO `eb_system_city` VALUES (2239, 463961, 2, 463141, '430624000000', '湘阴县', '湖南,岳阳,湘阴', '112.909426', '28.689105', 1);
INSERT INTO `eb_system_city` VALUES (2240, 464180, 2, 463141, '430626000000', '平江县', '湖南,岳阳,平江', '113.581234', '28.701868', 1);
INSERT INTO `eb_system_city` VALUES (2241, 464747, 2, 463141, '430681000000', '汨罗市', '湖南,岳阳,汨罗', '113.067259', '28.806890', 1);
INSERT INTO `eb_system_city` VALUES (2242, 464944, 2, 463141, '430682000000', '临湘市', '湖南,岳阳,临湘', '113.450423', '29.476849', 1);
INSERT INTO `eb_system_city` VALUES (2243, 465106, 2, 465105, '430701000000', '市辖区', '湖南,常德', '111.698497', '29.031673', 1);
INSERT INTO `eb_system_city` VALUES (2244, 465107, 2, 465105, '430702000000', '武陵区', '湖南,常德,武陵', '111.683153', '29.055163', 1);
INSERT INTO `eb_system_city` VALUES (2245, 465295, 2, 465105, '430703000000', '鼎城区', '湖南,常德,鼎城', '111.680783', '29.018593', 1);
INSERT INTO `eb_system_city` VALUES (2246, 465661, 2, 465105, '430721000000', '安乡县', '湖南,常德,安乡', '112.171131', '29.411309', 1);
INSERT INTO `eb_system_city` VALUES (2247, 465844, 2, 465105, '430722000000', '汉寿县', '湖南,常德,汉寿', '111.970514', '28.906107', 1);
INSERT INTO `eb_system_city` VALUES (2248, 466173, 2, 465105, '430723000000', '澧县', '湖南,常德,澧县', '111.758702', '29.633237', 1);
INSERT INTO `eb_system_city` VALUES (2249, 466483, 2, 465105, '430724000000', '临澧县', '湖南,常德,临澧', '111.647518', '29.440793', 1);
INSERT INTO `eb_system_city` VALUES (2250, 466654, 2, 465105, '430725000000', '桃源县', '湖南,常德,桃源', '111.488925', '28.902503', 1);
INSERT INTO `eb_system_city` VALUES (2251, 467112, 2, 465105, '430726000000', '石门县', '湖南,常德,石门', '111.380014', '29.584293', 1);
INSERT INTO `eb_system_city` VALUES (2252, 467471, 2, 465105, '430781000000', '津市市', '湖南,常德,津', '111.698497', '29.031673', 1);
INSERT INTO `eb_system_city` VALUES (2253, 467563, 2, 467562, '430801000000', '市辖区', '湖南,张家界', '110.479191', '29.117096', 1);
INSERT INTO `eb_system_city` VALUES (2254, 467564, 2, 467562, '430802000000', '永定区', '湖南,张家界,永定', '110.537138', '29.119856', 1);
INSERT INTO `eb_system_city` VALUES (2255, 467841, 2, 467562, '430811000000', '武陵源区', '湖南,张家界,武陵源', '110.550434', '29.345730', 1);
INSERT INTO `eb_system_city` VALUES (2256, 467881, 2, 467562, '430821000000', '慈利县', '湖南,张家界,慈利', '111.139711', '29.429972', 1);
INSERT INTO `eb_system_city` VALUES (2257, 468338, 2, 467562, '430822000000', '桑植县', '湖南,张家界,桑植', '110.204911', '29.414264', 1);
INSERT INTO `eb_system_city` VALUES (2258, 468661, 2, 468660, '430901000000', '市辖区', '湖南,益阳', '112.355180', '28.553860', 1);
INSERT INTO `eb_system_city` VALUES (2259, 468662, 2, 468660, '430902000000', '资阳区', '湖南,益阳,资阳', '112.324322', '28.590966', 1);
INSERT INTO `eb_system_city` VALUES (2260, 468790, 2, 468660, '430903000000', '赫山区', '湖南,益阳,赫山', '112.374024', '28.579343', 1);
INSERT INTO `eb_system_city` VALUES (2261, 469015, 2, 468660, '430921000000', '南县', '湖南,益阳,南县', '112.396241', '29.361338', 1);
INSERT INTO `eb_system_city` VALUES (2262, 469192, 2, 468660, '430922000000', '桃江县', '湖南,益阳,桃江', '112.155822', '28.518085', 1);
INSERT INTO `eb_system_city` VALUES (2263, 469452, 2, 468660, '430923000000', '安化县', '湖南,益阳,安化', '111.212846', '28.374107', 1);
INSERT INTO `eb_system_city` VALUES (2264, 469909, 2, 468660, '430981000000', '沅江市', '湖南,益阳,沅江', '112.355954', '28.847045', 1);
INSERT INTO `eb_system_city` VALUES (2265, 470124, 2, 470123, '431001000000', '市辖区', '湖南,郴州', '113.014717', '25.770509', 1);
INSERT INTO `eb_system_city` VALUES (2266, 470125, 2, 470123, '431002000000', '北湖区', '湖南,郴州,北湖', '113.011035', '25.784054', 1);
INSERT INTO `eb_system_city` VALUES (2267, 470300, 2, 470123, '431003000000', '苏仙区', '湖南,郴州,苏仙', '113.042441', '25.800370', 1);
INSERT INTO `eb_system_city` VALUES (2268, 470500, 2, 470123, '431021000000', '桂阳县', '湖南,郴州,桂阳', '112.734176', '25.754167', 1);
INSERT INTO `eb_system_city` VALUES (2269, 470894, 2, 470123, '431022000000', '宜章县', '湖南,郴州,宜章', '112.948772', '25.399792', 1);
INSERT INTO `eb_system_city` VALUES (2270, 471178, 2, 470123, '431023000000', '永兴县', '湖南,郴州,永兴', '113.116528', '26.127151', 1);
INSERT INTO `eb_system_city` VALUES (2271, 471473, 2, 470123, '431024000000', '嘉禾县', '湖南,郴州,嘉禾', '112.369021', '25.587520', 1);
INSERT INTO `eb_system_city` VALUES (2272, 471685, 2, 470123, '431025000000', '临武县', '湖南,郴州,临武', '112.563456', '25.275560', 1);
INSERT INTO `eb_system_city` VALUES (2273, 471908, 2, 470123, '431026000000', '汝城县', '湖南,郴州,汝城', '113.684727', '25.532816', 1);
INSERT INTO `eb_system_city` VALUES (2274, 472174, 2, 470123, '431027000000', '桂东县', '湖南,郴州,桂东', '113.944614', '26.077616', 1);
INSERT INTO `eb_system_city` VALUES (2275, 472301, 2, 470123, '431028000000', '安仁县', '湖南,郴州,安仁', '113.269441', '26.709056', 1);
INSERT INTO `eb_system_city` VALUES (2276, 472477, 2, 470123, '431081000000', '资兴市', '湖南,郴州,资兴', '113.236146', '25.976243', 1);
INSERT INTO `eb_system_city` VALUES (2277, 472710, 2, 472709, '431101000000', '市辖区', '湖南,永州', '111.613445', '26.420394', 1);
INSERT INTO `eb_system_city` VALUES (2278, 472711, 2, 472709, '431102000000', '零陵区', '湖南,永州,零陵', '111.631109', '26.221936', 1);
INSERT INTO `eb_system_city` VALUES (2279, 473062, 2, 472709, '431103000000', '冷水滩区', '湖南,永州,冷水滩', '111.592143', '26.461077', 1);
INSERT INTO `eb_system_city` VALUES (2280, 473284, 2, 472709, '431121000000', '祁阳县', '湖南,永州,祁阳', '111.840657', '26.580120', 1);
INSERT INTO `eb_system_city` VALUES (2281, 473871, 2, 472709, '431122000000', '东安县', '湖南,永州,东安', '111.314117', '26.394404', 1);
INSERT INTO `eb_system_city` VALUES (2282, 474233, 2, 472709, '431123000000', '双牌县', '湖南,永州,双牌', '111.659967', '25.961910', 1);
INSERT INTO `eb_system_city` VALUES (2283, 474367, 2, 472709, '431124000000', '道县', '湖南,永州,道县', '111.600796', '25.526438', 1);
INSERT INTO `eb_system_city` VALUES (2284, 474761, 2, 472709, '431125000000', '江永县', '湖南,永州,江永', '111.343911', '25.273539', 1);
INSERT INTO `eb_system_city` VALUES (2285, 474883, 2, 472709, '431126000000', '宁远县', '湖南,永州,宁远', '111.945805', '25.570976', 1);
INSERT INTO `eb_system_city` VALUES (2286, 475326, 2, 472709, '431127000000', '蓝山县', '湖南,永州,蓝山', '112.196731', '25.369898', 1);
INSERT INTO `eb_system_city` VALUES (2287, 475574, 2, 472709, '431128000000', '新田县', '湖南,永州,新田', '112.203287', '25.904305', 1);
INSERT INTO `eb_system_city` VALUES (2288, 475819, 2, 472709, '431129000000', '江华瑶族自治县', '湖南,永州,江华', '111.579305', '25.185590', 1);
INSERT INTO `eb_system_city` VALUES (2289, 476149, 2, 476148, '431201000000', '市辖区', '湖南,怀化', '109.998488', '27.554978', 1);
INSERT INTO `eb_system_city` VALUES (2290, 476150, 2, 476148, '431202000000', '鹤城区', '湖南,怀化,鹤城', '110.040315', '27.578926', 1);
INSERT INTO `eb_system_city` VALUES (2291, 476288, 2, 476148, '431221000000', '中方县', '湖南,怀化,中方', '109.944712', '27.440139', 1);
INSERT INTO `eb_system_city` VALUES (2292, 476449, 2, 476148, '431222000000', '沅陵县', '湖南,怀化,沅陵', '110.393844', '28.452686', 1);
INSERT INTO `eb_system_city` VALUES (2293, 476874, 2, 476148, '431223000000', '辰溪县', '湖南,怀化,辰溪', '110.183917', '28.006336', 1);
INSERT INTO `eb_system_city` VALUES (2294, 477191, 2, 476148, '431224000000', '溆浦县', '湖南,怀化,溆浦', '110.594921', '27.908281', 1);
INSERT INTO `eb_system_city` VALUES (2295, 477633, 2, 476148, '431225000000', '会同县', '湖南,怀化,会同', '109.735661', '26.887239', 1);
INSERT INTO `eb_system_city` VALUES (2296, 477895, 2, 476148, '431226000000', '麻阳苗族自治县', '湖南,怀化,麻阳', '109.802587', '27.865548', 1);
INSERT INTO `eb_system_city` VALUES (2297, 478135, 2, 476148, '431227000000', '新晃侗族自治县', '湖南,怀化,新晃', '109.174932', '27.352673', 1);
INSERT INTO `eb_system_city` VALUES (2298, 478299, 2, 476148, '431228000000', '芷江侗族自治县', '湖南,怀化,芷江', '109.684629', '27.443499', 1);
INSERT INTO `eb_system_city` VALUES (2299, 478536, 2, 476148, '431229000000', '靖州苗族侗族自治县', '湖南,怀化,靖州', '109.696311', '26.575052', 1);
INSERT INTO `eb_system_city` VALUES (2300, 478685, 2, 476148, '431230000000', '通道侗族自治县', '湖南,怀化,通道', '109.784412', '26.158054', 1);
INSERT INTO `eb_system_city` VALUES (2301, 478864, 2, 476148, '431281000000', '洪江市', '湖南,怀化,洪江', '109.836669', '27.208609', 1);
INSERT INTO `eb_system_city` VALUES (2302, 479104, 2, 479103, '431301000000', '市辖区', '湖南,娄底', '111.993497', '27.700062', 1);
INSERT INTO `eb_system_city` VALUES (2303, 479105, 2, 479103, '431302000000', '娄星区', '湖南,娄底,娄星', '112.001936', '27.729924', 1);
INSERT INTO `eb_system_city` VALUES (2304, 479285, 2, 479103, '431321000000', '双峰县', '湖南,娄底,双峰', '112.175246', '27.456658', 1);
INSERT INTO `eb_system_city` VALUES (2305, 479889, 2, 479103, '431322000000', '新化县', '湖南,娄底,新化', '111.327412', '27.726515', 1);
INSERT INTO `eb_system_city` VALUES (2306, 480606, 2, 479103, '431381000000', '冷水江市', '湖南,娄底,冷水江', '111.435623', '27.685850', 1);
INSERT INTO `eb_system_city` VALUES (2307, 480767, 2, 479103, '431382000000', '涟源市', '湖南,娄底,涟源', '111.664316', '27.692542', 1);
INSERT INTO `eb_system_city` VALUES (2308, 481320, 2, 481319, '433101000000', '吉首市', '湖南,湘西,吉首', '109.698055', '28.262507', 1);
INSERT INTO `eb_system_city` VALUES (2309, 481465, 2, 481319, '433122000000', '泸溪县', '湖南,湘西,泸溪', '110.219610', '28.216641', 1);
INSERT INTO `eb_system_city` VALUES (2310, 481626, 2, 481319, '433123000000', '凤凰县', '湖南,湘西,凤凰', '109.598719', '27.948116', 1);
INSERT INTO `eb_system_city` VALUES (2311, 481925, 2, 481319, '433124000000', '花垣县', '湖南,湘西,花垣', '109.482078', '28.572030', 1);
INSERT INTO `eb_system_city` VALUES (2312, 482179, 2, 481319, '433125000000', '保靖县', '湖南,湘西,保靖', '109.660577', '28.699774', 1);
INSERT INTO `eb_system_city` VALUES (2313, 482377, 2, 481319, '433126000000', '古丈县', '湖南,湘西,古丈', '109.950728', '28.616935', 1);
INSERT INTO `eb_system_city` VALUES (2314, 482506, 2, 481319, '433127000000', '永顺县', '湖南,湘西,永顺', '109.851254', '29.001440', 1);
INSERT INTO `eb_system_city` VALUES (2315, 482831, 2, 481319, '433130000000', '龙山县', '湖南,湘西,龙山', '109.443939', '29.457663', 1);
INSERT INTO `eb_system_city` VALUES (2316, 483252, 2, 483251, '440101000000', '市辖区', '广东,广州', '113.264434', '23.129162', 1);
INSERT INTO `eb_system_city` VALUES (2317, 483253, 2, 483251, '440103000000', '荔湾区', '广东,广州,荔湾', '113.244261', '23.125981', 1);
INSERT INTO `eb_system_city` VALUES (2318, 483462, 2, 483251, '440104000000', '越秀区', '广东,广州,越秀', '113.266841', '23.128524', 1);
INSERT INTO `eb_system_city` VALUES (2319, 483703, 2, 483251, '440105000000', '海珠区', '广东,广州,海珠', '113.317388', '23.083801', 1);
INSERT INTO `eb_system_city` VALUES (2320, 483979, 2, 483251, '440106000000', '天河区', '广东,广州,天河', '113.361200', '23.124680', 1);
INSERT INTO `eb_system_city` VALUES (2321, 484218, 2, 483251, '440111000000', '白云区', '广东,广州,白云', '113.273289', '23.157290', 1);
INSERT INTO `eb_system_city` VALUES (2322, 484627, 2, 483251, '440112000000', '黄埔区', '广东,广州,黄埔', '113.459749', '23.106402', 1);
INSERT INTO `eb_system_city` VALUES (2323, 484770, 2, 483251, '440113000000', '番禺区', '广东,广州,番禺', '113.384129', '22.937244', 1);
INSERT INTO `eb_system_city` VALUES (2324, 485059, 2, 483251, '440114000000', '花都区', '广东,广州,花都', '113.220218', '23.404165', 1);
INSERT INTO `eb_system_city` VALUES (2325, 485312, 2, 483251, '440115000000', '南沙区', '广东,广州,南沙', '113.525172', '22.801627', 1);
INSERT INTO `eb_system_city` VALUES (2326, 485489, 2, 483251, '440117000000', '从化区', '广东,广州,从化', '113.586605', '23.548852', 1);
INSERT INTO `eb_system_city` VALUES (2327, 485776, 2, 483251, '440118000000', '增城区', '广东,广州,增城', '113.810860', '23.261141', 1);
INSERT INTO `eb_system_city` VALUES (2328, 486130, 2, 486129, '440201000000', '市辖区', '广东,韶关', '113.597522', '24.810403', 1);
INSERT INTO `eb_system_city` VALUES (2329, 486131, 2, 486129, '440203000000', '武江区', '广东,韶关,武江', '113.587774', '24.792924', 1);
INSERT INTO `eb_system_city` VALUES (2330, 486223, 2, 486129, '440204000000', '浈江区', '广东,韶关,浈江', '113.611098', '24.804381', 1);
INSERT INTO `eb_system_city` VALUES (2331, 486345, 2, 486129, '440205000000', '曲江区', '广东,韶关,曲江', '113.604549', '24.682728', 1);
INSERT INTO `eb_system_city` VALUES (2332, 486469, 2, 486129, '440222000000', '始兴县', '广东,韶关,始兴', '114.061789', '24.952977', 1);
INSERT INTO `eb_system_city` VALUES (2333, 486609, 2, 486129, '440224000000', '仁化县', '广东,韶关,仁化', '113.749027', '25.085621', 1);
INSERT INTO `eb_system_city` VALUES (2334, 486746, 2, 486129, '440229000000', '翁源县', '广东,韶关,翁源', '114.130342', '24.350347', 1);
INSERT INTO `eb_system_city` VALUES (2335, 486929, 2, 486129, '440232000000', '乳源瑶族自治县', '广东,韶关,乳源', '113.275883', '24.776078', 1);
INSERT INTO `eb_system_city` VALUES (2336, 487058, 2, 486129, '440233000000', '新丰县', '广东,韶关,新丰', '114.206867', '24.059760', 1);
INSERT INTO `eb_system_city` VALUES (2337, 487223, 2, 486129, '440281000000', '乐昌市', '广东,韶关,乐昌', '113.347519', '25.130136', 1);
INSERT INTO `eb_system_city` VALUES (2338, 487468, 2, 486129, '440282000000', '南雄市', '广东,韶关,南雄', '114.311982', '25.117753', 1);
INSERT INTO `eb_system_city` VALUES (2339, 487722, 2, 487721, '440301000000', '市辖区', '广东,深圳', '114.057868', '22.543099', 1);
INSERT INTO `eb_system_city` VALUES (2340, 487723, 2, 487721, '440303000000', '罗湖区', '广东,深圳,罗湖', '114.131764', '22.548171', 1);
INSERT INTO `eb_system_city` VALUES (2341, 487849, 2, 487721, '440304000000', '福田区', '广东,深圳,福田', '114.055036', '22.521530', 1);
INSERT INTO `eb_system_city` VALUES (2342, 487977, 2, 487721, '440305000000', '南山区', '广东,深圳,南山', '113.930476', '22.533013', 1);
INSERT INTO `eb_system_city` VALUES (2343, 488090, 2, 487721, '440306000000', '宝安区', '广东,深圳,宝安', '113.884020', '22.555259', 1);
INSERT INTO `eb_system_city` VALUES (2344, 488375, 2, 487721, '440307000000', '龙岗区', '广东,深圳,龙岗', '114.246899', '22.720968', 1);
INSERT INTO `eb_system_city` VALUES (2345, 488558, 2, 487721, '440308000000', '盐田区', '广东,深圳,盐田', '114.236875', '22.556499', 1);
INSERT INTO `eb_system_city` VALUES (2346, 488590, 2, 488589, '440401000000', '市辖区', '广东,珠海', '113.576726', '22.270715', 1);
INSERT INTO `eb_system_city` VALUES (2347, 488591, 2, 488589, '440402000000', '香洲区', '广东,珠海,香洲', '113.543785', '22.265811', 1);
INSERT INTO `eb_system_city` VALUES (2348, 488768, 2, 488589, '440403000000', '斗门区', '广东,珠海,斗门', '113.296467', '22.209200', 1);
INSERT INTO `eb_system_city` VALUES (2349, 488905, 2, 488589, '440404000000', '金湾区', '广东,珠海,金湾', '113.363393', '22.146874', 1);
INSERT INTO `eb_system_city` VALUES (2350, 488955, 2, 488954, '440501000000', '市辖区', '广东,汕头', '116.681972', '23.354091', 1);
INSERT INTO `eb_system_city` VALUES (2351, 488956, 2, 488954, '440507000000', '龙湖区', '广东,汕头,龙湖', '116.716534', '23.371476', 1);
INSERT INTO `eb_system_city` VALUES (2352, 489082, 2, 488954, '440511000000', '金平区', '广东,汕头,金平', '116.703426', '23.365613', 1);
INSERT INTO `eb_system_city` VALUES (2353, 489270, 2, 488954, '440512000000', '濠江区', '广东,汕头,濠江', '116.726973', '23.286079', 1);
INSERT INTO `eb_system_city` VALUES (2354, 489338, 2, 488954, '440513000000', '潮阳区', '广东,汕头,潮阳', '116.601515', '23.264936', 1);
INSERT INTO `eb_system_city` VALUES (2355, 489624, 2, 488954, '440514000000', '潮南区', '广东,汕头,潮南', '116.433017', '23.250425', 1);
INSERT INTO `eb_system_city` VALUES (2356, 489868, 2, 488954, '440515000000', '澄海区', '广东,汕头,澄海', '116.756092', '23.465960', 1);
INSERT INTO `eb_system_city` VALUES (2357, 490064, 2, 488954, '440523000000', '南澳县', '广东,汕头,南澳', '117.023374', '23.421724', 1);
INSERT INTO `eb_system_city` VALUES (2358, 490107, 2, 490106, '440601000000', '市辖区', '广东,佛山', '113.121416', '23.021548', 1);
INSERT INTO `eb_system_city` VALUES (2359, 490108, 2, 490106, '440604000000', '禅城区', '广东,佛山,禅城', '113.122440', '23.009505', 1);
INSERT INTO `eb_system_city` VALUES (2360, 490257, 2, 490106, '440605000000', '南海区', '广东,佛山,南海', '113.143441', '23.028956', 1);
INSERT INTO `eb_system_city` VALUES (2361, 490531, 2, 490106, '440606000000', '顺德区', '广东,佛山,顺德', '113.293359', '22.805240', 1);
INSERT INTO `eb_system_city` VALUES (2362, 490746, 2, 490106, '440607000000', '三水区', '广东,佛山,三水', '112.896668', '23.156065', 1);
INSERT INTO `eb_system_city` VALUES (2363, 490834, 2, 490106, '440608000000', '高明区', '广东,佛山,高明', '112.892578', '22.900182', 1);
INSERT INTO `eb_system_city` VALUES (2364, 490920, 2, 490919, '440701000000', '市辖区', '广东,江门', '113.081901', '22.578738', 1);
INSERT INTO `eb_system_city` VALUES (2365, 490921, 2, 490919, '440703000000', '蓬江区', '广东,江门,蓬江', '113.078521', '22.595149', 1);
INSERT INTO `eb_system_city` VALUES (2366, 491070, 2, 490919, '440704000000', '江海区', '广东,江门,江海', '113.111612', '22.560474', 1);
INSERT INTO `eb_system_city` VALUES (2367, 491136, 2, 490919, '440705000000', '新会区', '广东,江门,新会', '113.034187', '22.458300', 1);
INSERT INTO `eb_system_city` VALUES (2368, 491380, 2, 490919, '440781000000', '台山市', '广东,江门,台山', '112.794065', '22.251924', 1);
INSERT INTO `eb_system_city` VALUES (2369, 491711, 2, 490919, '440783000000', '开平市', '广东,江门,开平', '112.698545', '22.376395', 1);
INSERT INTO `eb_system_city` VALUES (2370, 492000, 2, 490919, '440784000000', '鹤山市', '广东,江门,鹤山', '112.964446', '22.765392', 1);
INSERT INTO `eb_system_city` VALUES (2371, 492153, 2, 490919, '440785000000', '恩平市', '广东,江门,恩平', '112.305145', '22.183206', 1);
INSERT INTO `eb_system_city` VALUES (2372, 492342, 2, 492341, '440801000000', '市辖区', '广东,湛江', '110.359377', '21.270707', 1);
INSERT INTO `eb_system_city` VALUES (2373, 492343, 2, 492341, '440802000000', '赤坎区', '广东,湛江,赤坎', '110.365900', '21.266119', 1);
INSERT INTO `eb_system_city` VALUES (2374, 492393, 2, 492341, '440803000000', '霞山区', '广东,湛江,霞山', '110.398070', '21.191720', 1);
INSERT INTO `eb_system_city` VALUES (2375, 492484, 2, 492341, '440804000000', '坡头区', '广东,湛江,坡头', '110.455332', '21.244721', 1);
INSERT INTO `eb_system_city` VALUES (2376, 492563, 2, 492341, '440811000000', '麻章区', '广东,湛江,麻章', '110.334387', '21.263443', 1);
INSERT INTO `eb_system_city` VALUES (2377, 492716, 2, 492341, '440823000000', '遂溪县', '广东,湛江,遂溪', '110.250124', '21.377246', 1);
INSERT INTO `eb_system_city` VALUES (2378, 493015, 2, 492341, '440825000000', '徐闻县', '广东,湛江,徐闻', '110.176750', '20.325489', 1);
INSERT INTO `eb_system_city` VALUES (2379, 493241, 2, 492341, '440881000000', '廉江市', '广东,湛江,廉江', '110.286209', '21.609700', 1);
INSERT INTO `eb_system_city` VALUES (2380, 493663, 2, 492341, '440882000000', '雷州市', '广东,湛江,雷州', '110.096749', '20.914278', 1);
INSERT INTO `eb_system_city` VALUES (2381, 494182, 2, 492341, '440883000000', '吴川市', '广东,湛江,吴川', '110.778411', '21.441808', 1);
INSERT INTO `eb_system_city` VALUES (2382, 494395, 2, 494394, '440901000000', '市辖区', '广东,茂名', '110.925456', '21.662999', 1);
INSERT INTO `eb_system_city` VALUES (2383, 494396, 2, 494394, '440902000000', '茂南区', '广东,茂名,茂南', '110.918026', '21.641337', 1);
INSERT INTO `eb_system_city` VALUES (2384, 494629, 2, 494394, '440904000000', '电白区', '广东,茂名,电白', '111.013556', '21.514164', 1);
INSERT INTO `eb_system_city` VALUES (2385, 495088, 2, 494394, '440981000000', '高州市', '广东,茂名,高州', '110.853302', '21.917982', 1);
INSERT INTO `eb_system_city` VALUES (2386, 495611, 2, 494394, '440982000000', '化州市', '广东,茂名,化州', '110.639569', '21.664044', 1);
INSERT INTO `eb_system_city` VALUES (2387, 496016, 2, 494394, '440983000000', '信宜市', '广东,茂名,信宜', '110.947044', '22.354385', 1);
INSERT INTO `eb_system_city` VALUES (2388, 496439, 2, 496438, '441201000000', '市辖区', '广东,肇庆', '112.465091', '23.047191', 1);
INSERT INTO `eb_system_city` VALUES (2389, 496440, 2, 496438, '441202000000', '端州区', '广东,肇庆,端州', '112.484848', '23.052101', 1);
INSERT INTO `eb_system_city` VALUES (2390, 496505, 2, 496438, '441203000000', '鼎湖区', '广东,肇庆,鼎湖', '112.567588', '23.158447', 1);
INSERT INTO `eb_system_city` VALUES (2391, 496594, 2, 496438, '441204000000', '高要区', '广东,肇庆,高要', '112.457771', '23.025668', 1);
INSERT INTO `eb_system_city` VALUES (2392, 496964, 2, 496438, '441223000000', '广宁县', '广东,肇庆,广宁', '112.440690', '23.634676', 1);
INSERT INTO `eb_system_city` VALUES (2393, 497158, 2, 496438, '441224000000', '怀集县', '广东,肇庆,怀集', '112.184652', '23.911899', 1);
INSERT INTO `eb_system_city` VALUES (2394, 497503, 2, 496438, '441225000000', '封开县', '广东,肇庆,封开', '111.512343', '23.424033', 1);
INSERT INTO `eb_system_city` VALUES (2395, 497719, 2, 496438, '441226000000', '德庆县', '广东,肇庆,德庆', '111.785937', '23.143722', 1);
INSERT INTO `eb_system_city` VALUES (2396, 497926, 2, 496438, '441284000000', '四会市', '广东,肇庆,四会', '112.733773', '23.326504', 1);
INSERT INTO `eb_system_city` VALUES (2397, 498105, 2, 498104, '441301000000', '市辖区', '广东,惠州', '114.416196', '23.111847', 1);
INSERT INTO `eb_system_city` VALUES (2398, 498106, 2, 498104, '441302000000', '惠城区', '广东,惠州,惠城', '114.382541', '23.084122', 1);
INSERT INTO `eb_system_city` VALUES (2399, 498397, 2, 498104, '441303000000', '惠阳区', '广东,惠州,惠阳', '114.456696', '22.788734', 1);
INSERT INTO `eb_system_city` VALUES (2400, 498578, 2, 498104, '441322000000', '博罗县', '广东,惠州,博罗', '114.289496', '23.172899', 1);
INSERT INTO `eb_system_city` VALUES (2401, 498978, 2, 498104, '441323000000', '惠东县', '广东,惠州,惠东', '114.720079', '22.984975', 1);
INSERT INTO `eb_system_city` VALUES (2402, 499292, 2, 498104, '441324000000', '龙门县', '广东,惠州,龙门', '114.254863', '23.727737', 1);
INSERT INTO `eb_system_city` VALUES (2403, 499490, 2, 499489, '441401000000', '市辖区', '广东,梅州', '116.122238', '24.288615', 1);
INSERT INTO `eb_system_city` VALUES (2404, 499491, 2, 499489, '441402000000', '梅江区', '广东,梅州,梅江', '116.116616', '24.310384', 1);
INSERT INTO `eb_system_city` VALUES (2405, 499625, 2, 499489, '441403000000', '梅县区', '广东,梅州,梅县', '116.082183', '24.265312', 1);
INSERT INTO `eb_system_city` VALUES (2406, 500036, 2, 499489, '441422000000', '大埔县', '广东,梅州,大埔', '116.695195', '24.347783', 1);
INSERT INTO `eb_system_city` VALUES (2407, 500312, 2, 499489, '441423000000', '丰顺县', '广东,梅州,丰顺', '116.182299', '23.739526', 1);
INSERT INTO `eb_system_city` VALUES (2408, 500611, 2, 499489, '441424000000', '五华县', '广东,梅州,五华', '115.775788', '23.932409', 1);
INSERT INTO `eb_system_city` VALUES (2409, 501074, 2, 499489, '441426000000', '平远县', '广东,梅州,平远', '115.891638', '24.567262', 1);
INSERT INTO `eb_system_city` VALUES (2410, 501230, 2, 499489, '441427000000', '蕉岭县', '广东,梅州,蕉岭', '116.171356', '24.658700', 1);
INSERT INTO `eb_system_city` VALUES (2411, 501351, 2, 499489, '441481000000', '兴宁市', '广东,梅州,兴宁', '115.731110', '24.136630', 1);
INSERT INTO `eb_system_city` VALUES (2412, 501868, 2, 501867, '441501000000', '市辖区', '广东,汕尾', '115.375278', '22.786211', 1);
INSERT INTO `eb_system_city` VALUES (2413, 501869, 2, 501867, '441502000000', '城区', '广东,汕尾,城区', '115.365029', '22.778699', 1);
INSERT INTO `eb_system_city` VALUES (2414, 502002, 2, 501867, '441521000000', '海丰县', '广东,汕尾,海丰', '115.323436', '22.966586', 1);
INSERT INTO `eb_system_city` VALUES (2415, 502303, 2, 501867, '441523000000', '陆河县', '广东,汕尾,陆河', '115.660143', '23.301617', 1);
INSERT INTO `eb_system_city` VALUES (2416, 502439, 2, 501867, '441581000000', '陆丰市', '广东,汕尾,陆丰', '115.652260', '22.917576', 1);
INSERT INTO `eb_system_city` VALUES (2417, 502829, 2, 502828, '441601000000', '市辖区', '广东,河源', '114.700447', '23.743538', 1);
INSERT INTO `eb_system_city` VALUES (2418, 502830, 2, 502828, '441602000000', '源城区', '广东,河源,源城', '114.702517', '23.733969', 1);
INSERT INTO `eb_system_city` VALUES (2419, 502907, 2, 502828, '441621000000', '紫金县', '广东,河源,紫金', '115.184061', '23.635271', 1);
INSERT INTO `eb_system_city` VALUES (2420, 503226, 2, 502828, '441622000000', '龙川县', '广东,河源,龙川', '115.259872', '24.100066', 1);
INSERT INTO `eb_system_city` VALUES (2421, 503608, 2, 502828, '441623000000', '连平县', '广东,河源,连平', '114.488714', '24.369588', 1);
INSERT INTO `eb_system_city` VALUES (2422, 503797, 2, 502828, '441624000000', '和平县', '广东,河源,和平', '114.938684', '24.442180', 1);
INSERT INTO `eb_system_city` VALUES (2423, 504060, 2, 502828, '441625000000', '东源县', '广东,河源,东源', '114.746380', '23.788393', 1);
INSERT INTO `eb_system_city` VALUES (2424, 504367, 2, 504366, '441701000000', '市辖区', '广东,阳江', '111.982232', '21.857958', 1);
INSERT INTO `eb_system_city` VALUES (2425, 504368, 2, 504366, '441702000000', '江城区', '广东,阳江,江城', '111.955059', '21.861787', 1);
INSERT INTO `eb_system_city` VALUES (2426, 504549, 2, 504366, '441704000000', '阳东区', '广东,阳江,阳东', '112.006338', '21.868358', 1);
INSERT INTO `eb_system_city` VALUES (2427, 504749, 2, 504366, '441721000000', '阳西县', '广东,阳江,阳西', '111.617849', '21.752396', 1);
INSERT INTO `eb_system_city` VALUES (2428, 504911, 2, 504366, '441781000000', '阳春市', '广东,阳江,阳春', '111.791539', '22.170438', 1);
INSERT INTO `eb_system_city` VALUES (2429, 505299, 2, 505298, '441801000000', '市辖区', '广东,清远', '113.056031', '23.681763', 1);
INSERT INTO `eb_system_city` VALUES (2430, 505300, 2, 505298, '441802000000', '清城区', '广东,清远,清城', '113.062692', '23.697899', 1);
INSERT INTO `eb_system_city` VALUES (2431, 505466, 2, 505298, '441803000000', '清新区', '广东,清远,清新', '113.017749', '23.734673', 1);
INSERT INTO `eb_system_city` VALUES (2432, 505685, 2, 505298, '441821000000', '佛冈县', '广东,清远,佛冈', '113.531607', '23.879192', 1);
INSERT INTO `eb_system_city` VALUES (2433, 505782, 2, 505298, '441823000000', '阳山县', '广东,清远,阳山', '112.641363', '24.465359', 1);
INSERT INTO `eb_system_city` VALUES (2434, 505963, 2, 505298, '441825000000', '连山壮族瑶族自治县', '广东,清远,连山', '112.093617', '24.570491', 1);
INSERT INTO `eb_system_city` VALUES (2435, 506027, 2, 505298, '441826000000', '连南瑶族自治县', '广东,清远,连南', '112.287012', '24.726017', 1);
INSERT INTO `eb_system_city` VALUES (2436, 506106, 2, 505298, '441881000000', '英德市', '广东,清远,英德', '113.402376', '24.205024', 1);
INSERT INTO `eb_system_city` VALUES (2437, 506430, 2, 505298, '441882000000', '连州市', '广东,清远,连州', '112.377361', '24.780966', 1);
INSERT INTO `eb_system_city` VALUES (2438, 506617, 2, 506616, '441900003000', '东城街道办事处', '广东,东莞,东城', '113.754635', '23.002896', 1);
INSERT INTO `eb_system_city` VALUES (2439, 506643, 2, 506616, '441900004000', '南城街道办事处', '广东,东莞,南城', '113.753133', '22.987560', 1);
INSERT INTO `eb_system_city` VALUES (2440, 506662, 2, 506616, '441900005000', '万江街道办事处', '广东,东莞,万江', '113.740409', '23.052146', 1);
INSERT INTO `eb_system_city` VALUES (2441, 506691, 2, 506616, '441900006000', '莞城街道办事处', '广东,东莞,莞城', '113.751050', '23.053413', 1);
INSERT INTO `eb_system_city` VALUES (2442, 506700, 2, 506616, '441900101000', '石碣镇', '广东,东莞,石碣', '113.802109', '23.094111', 1);
INSERT INTO `eb_system_city` VALUES (2443, 506716, 2, 506616, '441900102000', '石龙镇', '广东,东莞,石龙', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2444, 506727, 2, 506616, '441900103000', '茶山镇', '广东,东莞,茶山', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2445, 506746, 2, 506616, '441900104000', '石排镇', '广东,东莞,石排', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2446, 506766, 2, 506616, '441900105000', '企石镇', '广东,东莞,企石', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2447, 506787, 2, 506616, '441900106000', '横沥镇', '广东,东莞,横沥', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2448, 506805, 2, 506616, '441900107000', '桥头镇', '广东,东莞,桥头', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2449, 506823, 2, 506616, '441900108000', '谢岗镇', '广东,东莞,谢岗', '114.141456', '22.972083', 1);
INSERT INTO `eb_system_city` VALUES (2450, 506836, 2, 506616, '441900109000', '东坑镇', '广东,东莞,东坑', '113.948089', '22.989033', 1);
INSERT INTO `eb_system_city` VALUES (2451, 506853, 2, 506616, '441900110000', '常平镇', '广东,东莞,常平', '113.992186', '22.975601', 1);
INSERT INTO `eb_system_city` VALUES (2452, 506887, 2, 506616, '441900111000', '寮步镇', '广东,东莞,寮步', '113.818996', '23.025373', 1);
INSERT INTO `eb_system_city` VALUES (2453, 506918, 2, 506616, '441900112000', '樟木头镇', '广东,东莞,樟木头镇', '114.083278', '22.914909', 1);
INSERT INTO `eb_system_city` VALUES (2454, 506930, 2, 506616, '441900113000', '大朗镇', '广东,东莞,大朗', '113.915820', '22.915996', 1);
INSERT INTO `eb_system_city` VALUES (2455, 506959, 2, 506616, '441900114000', '黄江镇', '广东,东莞,黄江', '113.996039', '22.877840', 1);
INSERT INTO `eb_system_city` VALUES (2456, 506967, 2, 506616, '441900115000', '清溪镇', '广东,东莞,清溪', '114.164330', '22.844557', 1);
INSERT INTO `eb_system_city` VALUES (2457, 506990, 2, 506616, '441900116000', '塘厦镇', '广东,东莞,塘厦', '113.774481', '22.791051', 1);
INSERT INTO `eb_system_city` VALUES (2458, 507015, 2, 506616, '441900117000', '凤岗镇', '广东,东莞,凤岗', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2459, 507028, 2, 506616, '441900118000', '大岭山镇', '广东,东莞,大岭山镇', '113.842223', '22.899965', 1);
INSERT INTO `eb_system_city` VALUES (2460, 507052, 2, 506616, '441900119000', '长安镇', '广东,东莞,长安', '113.794060', '22.803590', 1);
INSERT INTO `eb_system_city` VALUES (2461, 507066, 2, 506616, '441900121000', '虎门镇', '广东,东莞,虎门', '113.672560', '22.814835', 1);
INSERT INTO `eb_system_city` VALUES (2462, 507099, 2, 506616, '441900122000', '厚街镇', '广东,东莞,厚街', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2463, 507124, 2, 506616, '441900123000', '沙田镇', '广东,东莞,沙田', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2464, 507143, 2, 506616, '441900124000', '道滘镇', '广东,东莞,道滘', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2465, 507158, 2, 506616, '441900125000', '洪梅镇', '广东,东莞,洪梅', '113.608903', '22.994717', 1);
INSERT INTO `eb_system_city` VALUES (2466, 507169, 2, 506616, '441900126000', '麻涌镇', '广东,东莞,麻涌', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2467, 507185, 2, 506616, '441900127000', '望牛墩镇', '广东,东莞,望牛墩镇', '113.656243', '23.055331', 1);
INSERT INTO `eb_system_city` VALUES (2468, 507208, 2, 506616, '441900128000', '中堂镇', '广东,东莞,中堂', '113.751765', '23.020536', 1);
INSERT INTO `eb_system_city` VALUES (2469, 507229, 2, 506616, '441900129000', '高埗镇', '广东,东莞,高埗', '113.722126', '23.078713', 1);
INSERT INTO `eb_system_city` VALUES (2470, 507249, 2, 506616, '441900401000', '松山湖管委会', '广东,东莞,松山湖', '113.909208', '22.960541', 1);
INSERT INTO `eb_system_city` VALUES (2471, 507251, 2, 506616, '441900402000', '虎门港管委会', '广东,东莞,虎门港', '113.583070', '22.864175', 1);
INSERT INTO `eb_system_city` VALUES (2472, 507253, 2, 506616, '441900403000', '东莞生态园', '广东,东莞,东莞生态园', '113.927452', '23.063210', 1);
INSERT INTO `eb_system_city` VALUES (2473, 507256, 2, 507255, '442000001000', '石岐区街道办事处', '广东,中山,石岐区', '113.384930', '22.532046', 1);
INSERT INTO `eb_system_city` VALUES (2474, 507276, 2, 507255, '442000002000', '东区街道办事处', '广东,中山,东区', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2475, 507287, 2, 507255, '442000003000', '火炬开发区街道办事处', '广东,中山,火炬开发区', '113.480528', '22.566086', 1);
INSERT INTO `eb_system_city` VALUES (2476, 507295, 2, 507255, '442000004000', '西区街道办事处', '广东,中山,西区', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2477, 507305, 2, 507255, '442000005000', '南区街道办事处', '广东,中山,南区', '113.358509', '22.472530', 1);
INSERT INTO `eb_system_city` VALUES (2478, 507310, 2, 507255, '442000006000', '五桂山街道办事处', '广东,中山,五桂山', '113.463397', '22.421549', 1);
INSERT INTO `eb_system_city` VALUES (2479, 507316, 2, 507255, '442000100000', '小榄镇', '广东,中山,小榄', '113.250897', '22.672099', 1);
INSERT INTO `eb_system_city` VALUES (2480, 507332, 2, 507255, '442000101000', '黄圃镇', '广东,中山,黄圃', '113.335242', '22.709897', 1);
INSERT INTO `eb_system_city` VALUES (2481, 507349, 2, 507255, '442000102000', '民众镇', '广东,中山,民众', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2482, 507369, 2, 507255, '442000103000', '东凤镇', '广东,中山,东凤', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2483, 507384, 2, 507255, '442000104000', '东升镇', '广东,中山,东升', '113.294393', '22.616908', 1);
INSERT INTO `eb_system_city` VALUES (2484, 507399, 2, 507255, '442000105000', '古镇镇', '广东,中山,古镇', '113.190869', '22.613406', 1);
INSERT INTO `eb_system_city` VALUES (2485, 507413, 2, 507255, '442000106000', '沙溪镇', '广东,中山,沙溪', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2486, 507430, 2, 507255, '442000107000', '坦洲镇', '广东,中山,坦洲', '113.460373', '22.265182', 1);
INSERT INTO `eb_system_city` VALUES (2487, 507445, 2, 507255, '442000108000', '港口镇', '广东,中山,港口', '113.247148', '22.683616', 1);
INSERT INTO `eb_system_city` VALUES (2488, 507455, 2, 507255, '442000109000', '三角镇', '广东,中山,三角', '113.422371', '22.684688', 1);
INSERT INTO `eb_system_city` VALUES (2489, 507464, 2, 507255, '442000110000', '横栏镇', '广东,中山,横栏', '113.265845', '22.523201', 1);
INSERT INTO `eb_system_city` VALUES (2490, 507476, 2, 507255, '442000111000', '南头镇', '广东,中山,南头', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2491, 507483, 2, 507255, '442000112000', '阜沙镇', '广东,中山,阜沙', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2492, 507493, 2, 507255, '442000113000', '南朗镇', '广东,中山,南朗', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2493, 507509, 2, 507255, '442000114000', '三乡镇', '广东,中山,三乡', '113.441614', '22.357754', 1);
INSERT INTO `eb_system_city` VALUES (2494, 507526, 2, 507255, '442000115000', '板芙镇', '广东,中山,板芙', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2495, 507538, 2, 507255, '442000116000', '大涌镇', '广东,中山,大涌', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2496, 507550, 2, 507255, '442000117000', '神湾镇', '广东,中山,神湾', '113.392782', '22.517645', 1);
INSERT INTO `eb_system_city` VALUES (2497, 507558, 2, 507557, '445101000000', '市辖区', '广东,潮州', '116.622603', '23.656950', 1);
INSERT INTO `eb_system_city` VALUES (2498, 507559, 2, 507557, '445102000000', '湘桥区', '广东,潮州,湘桥', '116.628632', '23.674536', 1);
INSERT INTO `eb_system_city` VALUES (2499, 507748, 2, 507557, '445103000000', '潮安区', '广东,潮州,潮安', '116.678204', '23.462613', 1);
INSERT INTO `eb_system_city` VALUES (2500, 508223, 2, 507557, '445122000000', '饶平县', '广东,潮州,饶平', '117.003900', '23.663824', 1);
INSERT INTO `eb_system_city` VALUES (2501, 508649, 2, 508648, '445201000000', '市辖区', '广东,揭阳', '116.372831', '23.549993', 1);
INSERT INTO `eb_system_city` VALUES (2502, 508650, 2, 508648, '445202000000', '榕城区', '广东,揭阳,榕城', '116.367026', '23.525153', 1);
INSERT INTO `eb_system_city` VALUES (2503, 508863, 2, 508648, '445203000000', '揭东区', '广东,揭阳,揭东', '116.412015', '23.566127', 1);
INSERT INTO `eb_system_city` VALUES (2504, 509101, 2, 508648, '445222000000', '揭西县', '广东,揭阳,揭西', '115.841838', '23.431294', 1);
INSERT INTO `eb_system_city` VALUES (2505, 509449, 2, 508648, '445224000000', '惠来县', '广东,揭阳,惠来', '116.295150', '23.033267', 1);
INSERT INTO `eb_system_city` VALUES (2506, 509796, 2, 508648, '445281000000', '普宁市', '广东,揭阳,普宁', '116.166004', '23.297642', 1);
INSERT INTO `eb_system_city` VALUES (2507, 510409, 2, 510408, '445301000000', '市辖区', '广东,云浮', '112.044491', '22.915094', 1);
INSERT INTO `eb_system_city` VALUES (2508, 510410, 2, 510408, '445302000000', '云城区', '广东,云浮,云城', '112.043857', '22.928115', 1);
INSERT INTO `eb_system_city` VALUES (2509, 510536, 2, 510408, '445303000000', '云安区', '广东,云浮,云安', '112.003209', '23.071020', 1);
INSERT INTO `eb_system_city` VALUES (2510, 510660, 2, 510408, '445321000000', '新兴县', '广东,云浮,新兴', '112.225335', '22.695690', 1);
INSERT INTO `eb_system_city` VALUES (2511, 510878, 2, 510408, '445322000000', '郁南县', '广东,云浮,郁南', '111.535249', '23.234627', 1);
INSERT INTO `eb_system_city` VALUES (2512, 511102, 2, 510408, '445381000000', '罗定市', '广东,云浮,罗定', '111.570010', '22.768595', 1);
INSERT INTO `eb_system_city` VALUES (2513, 511464, 2, 511463, '450101000000', '市辖区', '广西,南宁', '108.366543', '22.817002', 1);
INSERT INTO `eb_system_city` VALUES (2514, 511465, 2, 511463, '450102000000', '兴宁区', '广西,南宁,兴宁', '108.368871', '22.854021', 1);
INSERT INTO `eb_system_city` VALUES (2515, 511545, 2, 511463, '450103000000', '青秀区', '广西,南宁,青秀', '108.494024', '22.785879', 1);
INSERT INTO `eb_system_city` VALUES (2516, 511662, 2, 511463, '450105000000', '江南区', '广西,南宁,江南', '108.273158', '22.781632', 1);
INSERT INTO `eb_system_city` VALUES (2517, 511790, 2, 511463, '450107000000', '西乡塘区', '广西,南宁,西乡塘', '108.306886', '22.832770', 1);
INSERT INTO `eb_system_city` VALUES (2518, 511960, 2, 511463, '450108000000', '良庆区', '广西,南宁,良庆', '108.322102', '22.759090', 1);
INSERT INTO `eb_system_city` VALUES (2519, 512044, 2, 511463, '450109000000', '邕宁区', '广西,南宁,邕宁', '108.487369', '22.758390', 1);
INSERT INTO `eb_system_city` VALUES (2520, 512124, 2, 511463, '450110000000', '武鸣区', '广西,南宁,武鸣', '108.274712', '23.158693', 1);
INSERT INTO `eb_system_city` VALUES (2521, 512381, 2, 511463, '450123000000', '隆安县', '广西,南宁,隆安', '107.696153', '23.166028', 1);
INSERT INTO `eb_system_city` VALUES (2522, 512530, 2, 511463, '450124000000', '马山县', '广西,南宁,马山', '108.176979', '23.708192', 1);
INSERT INTO `eb_system_city` VALUES (2523, 512695, 2, 511463, '450125000000', '上林县', '广西,南宁,上林', '108.604921', '23.431936', 1);
INSERT INTO `eb_system_city` VALUES (2524, 512838, 2, 511463, '450126000000', '宾阳县', '广西,南宁,宾阳', '108.810326', '23.217787', 1);
INSERT INTO `eb_system_city` VALUES (2525, 513091, 2, 511463, '450127000000', '横县', '广西,南宁,横县', '109.261384', '22.679932', 1);
INSERT INTO `eb_system_city` VALUES (2526, 513435, 2, 513434, '450201000000', '市辖区', '广西,柳州', '109.415953', '24.325502', 1);
INSERT INTO `eb_system_city` VALUES (2527, 513436, 2, 513434, '450202000000', '城中区', '广西,柳州,城中', '109.410736', '24.315602', 1);
INSERT INTO `eb_system_city` VALUES (2528, 513477, 2, 513434, '450203000000', '鱼峰区', '广西,柳州,鱼峰', '109.452442', '24.318517', 1);
INSERT INTO `eb_system_city` VALUES (2529, 513569, 2, 513434, '450204000000', '柳南区', '广西,柳州,柳南', '109.385519', '24.336229', 1);
INSERT INTO `eb_system_city` VALUES (2530, 513661, 2, 513434, '450205000000', '柳北区', '广西,柳州,柳北', '109.402050', '24.362691', 1);
INSERT INTO `eb_system_city` VALUES (2531, 513772, 2, 513434, '450206000000', '柳江区', '广西,柳州,柳江', '109.326380', '24.254892', 1);
INSERT INTO `eb_system_city` VALUES (2532, 513938, 2, 513434, '450222000000', '柳城县', '广西,柳州,柳城', '109.244730', '24.651518', 1);
INSERT INTO `eb_system_city` VALUES (2533, 514091, 2, 513434, '450223000000', '鹿寨县', '广西,柳州,鹿寨', '109.750638', '24.472897', 1);
INSERT INTO `eb_system_city` VALUES (2534, 514219, 2, 513434, '450224000000', '融安县', '广西,柳州,融安', '109.397538', '25.224550', 1);
INSERT INTO `eb_system_city` VALUES (2535, 514380, 2, 513434, '450225000000', '融水苗族自治县', '广西,柳州,融水', '109.256334', '25.065934', 1);
INSERT INTO `eb_system_city` VALUES (2536, 514607, 2, 513434, '450226000000', '三江侗族自治县', '广西,柳州,三江', '109.607675', '25.783198', 1);
INSERT INTO `eb_system_city` VALUES (2537, 514791, 2, 514790, '450301000000', '市辖区', '广西,桂林', '110.290194', '25.273566', 1);
INSERT INTO `eb_system_city` VALUES (2538, 514792, 2, 514790, '450302000000', '秀峰区', '广西,桂林,秀峰', '110.264183', '25.273625', 1);
INSERT INTO `eb_system_city` VALUES (2539, 514824, 2, 514790, '450303000000', '叠彩区', '广西,桂林,叠彩', '110.301723', '25.314001', 1);
INSERT INTO `eb_system_city` VALUES (2540, 514864, 2, 514790, '450304000000', '象山区', '广西,桂林,象山', '110.281082', '25.261687', 1);
INSERT INTO `eb_system_city` VALUES (2541, 514911, 2, 514790, '450305000000', '七星区', '广西,桂林,七星', '110.317826', '25.252701', 1);
INSERT INTO `eb_system_city` VALUES (2542, 514964, 2, 514790, '450311000000', '雁山区', '广西,桂林,雁山', '110.286690', '25.101935', 1);
INSERT INTO `eb_system_city` VALUES (2543, 515012, 2, 514790, '450312000000', '临桂区', '广西,桂林,临桂', '110.212463', '25.238628', 1);
INSERT INTO `eb_system_city` VALUES (2544, 515195, 2, 514790, '450321000000', '阳朔县', '广西,桂林,阳朔', '110.496593', '24.778481', 1);
INSERT INTO `eb_system_city` VALUES (2545, 515319, 2, 514790, '450323000000', '灵川县', '广西,桂林,灵川', '110.325636', '25.409747', 1);
INSERT INTO `eb_system_city` VALUES (2546, 515481, 2, 514790, '450324000000', '全州县', '广西,桂林,全州', '111.072926', '25.928617', 1);
INSERT INTO `eb_system_city` VALUES (2547, 515784, 2, 514790, '450325000000', '兴安县', '广西,桂林,兴安', '110.671670', '25.611705', 1);
INSERT INTO `eb_system_city` VALUES (2548, 515920, 2, 514790, '450326000000', '永福县', '广西,桂林,永福', '109.983076', '24.979856', 1);
INSERT INTO `eb_system_city` VALUES (2549, 516029, 2, 514790, '450327000000', '灌阳县', '广西,桂林,灌阳', '111.160851', '25.489383', 1);
INSERT INTO `eb_system_city` VALUES (2550, 516180, 2, 514790, '450328000000', '龙胜各族自治县', '广西,桂林,龙胜各族', '110.011238', '25.797931', 1);
INSERT INTO `eb_system_city` VALUES (2551, 516317, 2, 514790, '450329000000', '资源县', '广西,桂林,资源', '110.652700', '26.042443', 1);
INSERT INTO `eb_system_city` VALUES (2552, 516399, 2, 514790, '450330000000', '平乐县', '广西,桂林,平乐', '110.643305', '24.633362', 1);
INSERT INTO `eb_system_city` VALUES (2553, 516563, 2, 514790, '450331000000', '荔浦县', '广西,桂林,荔浦', '110.395287', '24.487824', 1);
INSERT INTO `eb_system_city` VALUES (2554, 516721, 2, 514790, '450332000000', '恭城瑶族自治县', '广西,桂林,恭城', '110.830193', '24.822522', 1);
INSERT INTO `eb_system_city` VALUES (2555, 516859, 2, 516858, '450401000000', '市辖区', '广西,梧州', '111.279115', '23.476962', 1);
INSERT INTO `eb_system_city` VALUES (2556, 516860, 2, 516858, '450403000000', '万秀区', '广西,梧州,万秀', '111.320542', '23.472962', 1);
INSERT INTO `eb_system_city` VALUES (2557, 516945, 2, 516858, '450405000000', '长洲区', '广西,梧州,长洲', '111.274777', '23.485695', 1);
INSERT INTO `eb_system_city` VALUES (2558, 516991, 2, 516858, '450406000000', '龙圩区', '广西,梧州,龙圩', '111.246035', '23.409960', 1);
INSERT INTO `eb_system_city` VALUES (2559, 517075, 2, 516858, '450421000000', '苍梧县', '广西,梧州,苍梧', '111.544008', '23.845097', 1);
INSERT INTO `eb_system_city` VALUES (2560, 517230, 2, 516858, '450422000000', '藤县', '广西,梧州,藤县', '110.914849', '23.374984', 1);
INSERT INTO `eb_system_city` VALUES (2561, 517542, 2, 516858, '450423000000', '蒙山县', '广西,梧州,蒙山', '110.525003', '24.193570', 1);
INSERT INTO `eb_system_city` VALUES (2562, 517636, 2, 516858, '450481000000', '岑溪市', '广西,梧州,岑溪', '110.994913', '22.918350', 1);
INSERT INTO `eb_system_city` VALUES (2563, 517934, 2, 517933, '450501000000', '市辖区', '广西,北海', '109.119927', '21.481254', 1);
INSERT INTO `eb_system_city` VALUES (2564, 517935, 2, 517933, '450502000000', '海城区', '广西,北海,海城', '109.117210', '21.475005', 1);
INSERT INTO `eb_system_city` VALUES (2565, 518010, 2, 517933, '450503000000', '银海区', '广西,北海,银海', '109.139990', '21.449219', 1);
INSERT INTO `eb_system_city` VALUES (2566, 518067, 2, 517933, '450512000000', '铁山港区', '广西,北海,铁山港', '109.421581', '21.529128', 1);
INSERT INTO `eb_system_city` VALUES (2567, 518115, 2, 517933, '450521000000', '合浦县', '广西,北海,合浦', '109.207336', '21.660936', 1);
INSERT INTO `eb_system_city` VALUES (2568, 518408, 2, 518407, '450601000000', '市辖区', '广西,防城港', '108.353846', '21.686860', 1);
INSERT INTO `eb_system_city` VALUES (2569, 518409, 2, 518407, '450602000000', '港口区', '广西,防城港,港口', '108.380144', '21.643384', 1);
INSERT INTO `eb_system_city` VALUES (2570, 518455, 2, 518407, '450603000000', '防城区', '广西,防城港,防城', '108.353499', '21.769212', 1);
INSERT INTO `eb_system_city` VALUES (2571, 518641, 2, 518407, '450621000000', '上思县', '广西,防城港,上思', '107.983626', '22.153672', 1);
INSERT INTO `eb_system_city` VALUES (2572, 518762, 2, 518407, '450681000000', '东兴市', '广西,防城港,东兴', '107.971826', '21.547822', 1);
INSERT INTO `eb_system_city` VALUES (2573, 518809, 2, 518808, '450701000000', '市辖区', '广西,钦州', '108.654146', '21.979933', 1);
INSERT INTO `eb_system_city` VALUES (2574, 518810, 2, 518808, '450702000000', '钦南区', '广西,钦州,钦南', '108.657210', '21.938860', 1);
INSERT INTO `eb_system_city` VALUES (2575, 519003, 2, 518808, '450703000000', '钦北区', '广西,钦州,钦北', '108.449110', '22.132761', 1);
INSERT INTO `eb_system_city` VALUES (2576, 519201, 2, 518808, '450721000000', '灵山县', '广西,钦州,灵山', '109.291007', '22.416537', 1);
INSERT INTO `eb_system_city` VALUES (2577, 519637, 2, 518808, '450722000000', '浦北县', '广西,钦州,浦北', '109.556953', '22.271651', 1);
INSERT INTO `eb_system_city` VALUES (2578, 519930, 2, 519929, '450801000000', '市辖区', '广西,贵港', '109.598926', '23.111530', 1);
INSERT INTO `eb_system_city` VALUES (2579, 519931, 2, 519929, '450802000000', '港北区', '广西,贵港,港北', '109.572240', '23.111531', 1);
INSERT INTO `eb_system_city` VALUES (2580, 520063, 2, 519929, '450803000000', '港南区', '广西,贵港,港南', '109.599557', '23.075573', 1);
INSERT INTO `eb_system_city` VALUES (2581, 520240, 2, 519929, '450804000000', '覃塘区', '广西,贵港,覃塘', '109.452662', '23.127149', 1);
INSERT INTO `eb_system_city` VALUES (2582, 520397, 2, 519929, '450821000000', '平南县', '广西,贵港,平南', '110.392168', '23.539127', 1);
INSERT INTO `eb_system_city` VALUES (2583, 520707, 2, 519929, '450881000000', '桂平市', '广西,贵港,桂平', '110.079379', '23.394326', 1);
INSERT INTO `eb_system_city` VALUES (2584, 521167, 2, 521166, '450901000000', '市辖区', '广西,玉林', '110.164756', '22.636379', 1);
INSERT INTO `eb_system_city` VALUES (2585, 521168, 2, 521166, '450902000000', '玉州区', '广西,玉林,玉州', '110.151147', '22.628102', 1);
INSERT INTO `eb_system_city` VALUES (2586, 521286, 2, 521166, '450903000000', '福绵区', '广西,玉林,福绵', '110.059439', '22.585557', 1);
INSERT INTO `eb_system_city` VALUES (2587, 521409, 2, 521166, '450921000000', '容县', '广西,玉林,容县', '110.557874', '22.857823', 1);
INSERT INTO `eb_system_city` VALUES (2588, 521652, 2, 521166, '450922000000', '陆川县', '广西,玉林,陆川', '110.264052', '22.321048', 1);
INSERT INTO `eb_system_city` VALUES (2589, 521832, 2, 521166, '450923000000', '博白县', '广西,玉林,博白', '109.975985', '22.273048', 1);
INSERT INTO `eb_system_city` VALUES (2590, 522220, 2, 521166, '450924000000', '兴业县', '广西,玉林,兴业', '109.875304', '22.736421', 1);
INSERT INTO `eb_system_city` VALUES (2591, 522448, 2, 521166, '450981000000', '北流市', '广西,玉林,北流', '110.354215', '22.708311', 1);
INSERT INTO `eb_system_city` VALUES (2592, 522787, 2, 522786, '451001000000', '市辖区', '广西,百色', '106.618201', '23.902333', 1);
INSERT INTO `eb_system_city` VALUES (2593, 522788, 2, 522786, '451002000000', '右江区', '广西,百色,右江', '106.618645', '23.901383', 1);
INSERT INTO `eb_system_city` VALUES (2594, 522918, 2, 522786, '451021000000', '田阳县', '广西,百色,田阳', '106.915418', '23.735682', 1);
INSERT INTO `eb_system_city` VALUES (2595, 523086, 2, 522786, '451022000000', '田东县', '广西,百色,田东', '107.126081', '23.597194', 1);
INSERT INTO `eb_system_city` VALUES (2596, 523265, 2, 522786, '451023000000', '平果县', '广西,百色,平果', '107.589810', '23.329376', 1);
INSERT INTO `eb_system_city` VALUES (2597, 523461, 2, 522786, '451024000000', '德保县', '广西,百色,德保', '106.615374', '23.323450', 1);
INSERT INTO `eb_system_city` VALUES (2598, 523661, 2, 522786, '451026000000', '那坡县', '广西,百色,那坡', '105.832530', '23.387441', 1);
INSERT INTO `eb_system_city` VALUES (2599, 523801, 2, 522786, '451027000000', '凌云县', '广西,百色,凌云', '106.561310', '24.347557', 1);
INSERT INTO `eb_system_city` VALUES (2600, 523920, 2, 522786, '451028000000', '乐业县', '广西,百色,乐业', '106.556519', '24.776827', 1);
INSERT INTO `eb_system_city` VALUES (2601, 524017, 2, 522786, '451029000000', '田林县', '广西,百色,田林', '106.228538', '24.294488', 1);
INSERT INTO `eb_system_city` VALUES (2602, 524200, 2, 522786, '451030000000', '西林县', '广西,百色,西林', '105.093837', '24.489810', 1);
INSERT INTO `eb_system_city` VALUES (2603, 524306, 2, 522786, '451031000000', '隆林各族自治县', '广西,百色,隆林各族', '105.344040', '24.770896', 1);
INSERT INTO `eb_system_city` VALUES (2604, 524502, 2, 522786, '451081000000', '靖西市', '广西,百色,靖西', '106.417549', '23.134766', 1);
INSERT INTO `eb_system_city` VALUES (2605, 524815, 2, 524814, '451101000000', '市辖区', '广西,贺州', '111.566694', '24.403582', 1);
INSERT INTO `eb_system_city` VALUES (2606, 524816, 2, 524814, '451102000000', '八步区', '广西,贺州,八步', '111.552096', '24.411805', 1);
INSERT INTO `eb_system_city` VALUES (2607, 525035, 2, 524814, '451103000000', '平桂区', '广西,贺州,平桂', '111.566694', '24.403582', 1);
INSERT INTO `eb_system_city` VALUES (2608, 525169, 2, 524814, '451121000000', '昭平县', '广西,贺州,昭平', '110.811287', '24.169480', 1);
INSERT INTO `eb_system_city` VALUES (2609, 525341, 2, 524814, '451122000000', '钟山县', '广西,贺州,钟山', '111.303111', '24.526022', 1);
INSERT INTO `eb_system_city` VALUES (2610, 525470, 2, 524814, '451123000000', '富川瑶族自治县', '广西,贺州,富川', '111.277389', '24.814444', 1);
INSERT INTO `eb_system_city` VALUES (2611, 525639, 2, 525638, '451201000000', '市辖区', '广西,河池', '108.085261', '24.692931', 1);
INSERT INTO `eb_system_city` VALUES (2612, 525640, 2, 525638, '451202000000', '金城江区', '广西,河池,金城江', '108.037277', '24.689703', 1);
INSERT INTO `eb_system_city` VALUES (2613, 525798, 2, 525638, '451221000000', '南丹县', '广西,河池,南丹', '107.540722', '24.974486', 1);
INSERT INTO `eb_system_city` VALUES (2614, 525961, 2, 525638, '451222000000', '天峨县', '广西,河池,天峨', '107.173802', '24.999108', 1);
INSERT INTO `eb_system_city` VALUES (2615, 526066, 2, 525638, '451223000000', '凤山县', '广西,河池,凤山', '107.042191', '24.546876', 1);
INSERT INTO `eb_system_city` VALUES (2616, 526174, 2, 525638, '451224000000', '东兰县', '广西,河池,东兰', '107.374294', '24.510842', 1);
INSERT INTO `eb_system_city` VALUES (2617, 526338, 2, 525638, '451225000000', '罗城仫佬族自治县', '广西,河池,罗城', '108.904707', '24.777413', 1);
INSERT INTO `eb_system_city` VALUES (2618, 526493, 2, 525638, '451226000000', '环江毛南族自治县', '广西,河池,环江', '108.258028', '24.825664', 1);
INSERT INTO `eb_system_city` VALUES (2619, 526654, 2, 525638, '451227000000', '巴马瑶族自治县', '广西,河池,巴马', '107.258588', '24.142299', 1);
INSERT INTO `eb_system_city` VALUES (2620, 526772, 2, 525638, '451228000000', '都安瑶族自治县', '广西,河池,都安', '108.128403', '23.919338', 1);
INSERT INTO `eb_system_city` VALUES (2621, 527041, 2, 525638, '451229000000', '大化瑶族自治县', '广西,河池,大化', '108.085261', '24.692931', 1);
INSERT INTO `eb_system_city` VALUES (2622, 527216, 2, 525638, '451281000000', '宜州市', '广西,河池,宜州', '108.636415', '24.485214', 1);
INSERT INTO `eb_system_city` VALUES (2623, 527444, 2, 527443, '451301000000', '市辖区', '广西,来宾', '109.221465', '23.750306', 1);
INSERT INTO `eb_system_city` VALUES (2624, 527445, 2, 527443, '451302000000', '兴宾区', '广西,来宾,兴宾', '109.230541', '23.732926', 1);
INSERT INTO `eb_system_city` VALUES (2625, 527762, 2, 527443, '451321000000', '忻城县', '广西,来宾,忻城', '108.665666', '24.066235', 1);
INSERT INTO `eb_system_city` VALUES (2626, 527905, 2, 527443, '451322000000', '象州县', '广西,来宾,象州', '109.683985', '23.958528', 1);
INSERT INTO `eb_system_city` VALUES (2627, 528042, 2, 527443, '451323000000', '武宣县', '广西,来宾,武宣', '109.663207', '23.594110', 1);
INSERT INTO `eb_system_city` VALUES (2628, 528205, 2, 527443, '451324000000', '金秀瑶族自治县', '广西,来宾,金秀', '110.189462', '24.130374', 1);
INSERT INTO `eb_system_city` VALUES (2629, 528299, 2, 527443, '451381000000', '合山市', '广西,来宾,合山', '108.886082', '23.806536', 1);
INSERT INTO `eb_system_city` VALUES (2630, 528340, 2, 528339, '451401000000', '市辖区', '广西,崇左', '107.364711', '22.376532', 1);
INSERT INTO `eb_system_city` VALUES (2631, 528341, 2, 528339, '451402000000', '江州区', '广西,崇左,江州', '107.353437', '22.405325', 1);
INSERT INTO `eb_system_city` VALUES (2632, 528494, 2, 528339, '451421000000', '扶绥县', '广西,崇左,扶绥', '107.904187', '22.635013', 1);
INSERT INTO `eb_system_city` VALUES (2633, 528647, 2, 528339, '451422000000', '宁明县', '广西,崇左,宁明', '107.076457', '22.140192', 1);
INSERT INTO `eb_system_city` VALUES (2634, 528845, 2, 528339, '451423000000', '龙州县', '广西,崇左,龙州', '106.854451', '22.342797', 1);
INSERT INTO `eb_system_city` VALUES (2635, 528986, 2, 528339, '451424000000', '大新县', '广西,崇左,大新', '107.200654', '22.829288', 1);
INSERT INTO `eb_system_city` VALUES (2636, 529159, 2, 528339, '451425000000', '天等县', '广西,崇左,天等', '107.143433', '23.081394', 1);
INSERT INTO `eb_system_city` VALUES (2637, 529297, 2, 528339, '451481000000', '凭祥市', '广西,崇左,凭祥', '106.766293', '22.094485', 1);
INSERT INTO `eb_system_city` VALUES (2638, 529346, 2, 529345, '460101000000', '市辖区', '海南,海口', '110.198293', '20.044001', 1);
INSERT INTO `eb_system_city` VALUES (2639, 529347, 2, 529345, '460105000000', '秀英区', '海南,海口,秀英', '110.293561', '20.007969', 1);
INSERT INTO `eb_system_city` VALUES (2640, 529451, 2, 529345, '460106000000', '龙华区', '海南,海口,龙华', '110.328492', '20.031007', 1);
INSERT INTO `eb_system_city` VALUES (2641, 529589, 2, 529345, '460107000000', '琼山区', '海南,海口,琼山', '110.353972', '20.003170', 1);
INSERT INTO `eb_system_city` VALUES (2642, 529720, 2, 529345, '460108000000', '美兰区', '海南,海口,美兰', '110.366357', '20.029083', 1);
INSERT INTO `eb_system_city` VALUES (2643, 529879, 2, 529878, '460201000000', '市辖区', '海南,三亚', '109.511909', '18.252847', 1);
INSERT INTO `eb_system_city` VALUES (2644, 529910, 2, 529878, '460202000000', '海棠区', '海南,三亚,海棠', '109.760778', '18.407516', 1);
INSERT INTO `eb_system_city` VALUES (2645, 529934, 2, 529878, '460203000000', '吉阳区', '海南,三亚,吉阳', '109.578330', '18.281397', 1);
INSERT INTO `eb_system_city` VALUES (2646, 529973, 2, 529878, '460204000000', '天涯区', '海南,三亚,天涯', '109.506357', '18.247340', 1);
INSERT INTO `eb_system_city` VALUES (2647, 530027, 2, 529878, '460205000000', '崖州区', '海南,三亚,崖州', '109.174313', '18.352212', 1);
INSERT INTO `eb_system_city` VALUES (2648, 530061, 2, 530060, '460321000000', '西沙群岛', '海南,三沙,西沙群岛', '112.338695', '16.831839', 1);
INSERT INTO `eb_system_city` VALUES (2649, 530064, 2, 530060, '460322000000', '南沙群岛', '海南,三沙,南沙群岛', '112.338695', '16.831839', 1);
INSERT INTO `eb_system_city` VALUES (2650, 530067, 2, 530060, '460323000000', '中沙群岛的岛礁及其海域', '海南,三沙,中沙群岛的岛礁及其海域', '112.338695', '16.831839', 1);
INSERT INTO `eb_system_city` VALUES (2651, 530071, 2, 530070, '460400100000', '那大镇', '海南,儋州,那大', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2652, 530112, 2, 530070, '460400101000', '和庆镇', '海南,儋州,和庆', '109.640856', '19.525399', 1);
INSERT INTO `eb_system_city` VALUES (2653, 530126, 2, 530070, '460400102000', '南丰镇', '海南,儋州,南丰', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2654, 530139, 2, 530070, '460400103000', '大成镇', '海南,儋州,大成', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2655, 530162, 2, 530070, '460400104000', '雅星镇', '海南,儋州,雅星', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2656, 530188, 2, 530070, '460400105000', '兰洋镇', '海南,儋州,兰洋', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2657, 530207, 2, 530070, '460400106000', '光村镇', '海南,儋州,光村', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2658, 530220, 2, 530070, '460400107000', '木棠镇', '海南,儋州,木棠', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2659, 530246, 2, 530070, '460400108000', '海头镇', '海南,儋州,海头', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2660, 530261, 2, 530070, '460400109000', '峨蔓镇', '海南,儋州,峨蔓', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2661, 530275, 2, 530070, '460400110000', '三都镇', '海南,儋州,三都', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2662, 530285, 2, 530070, '460400111000', '王五镇', '海南,儋州,王五', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2663, 530295, 2, 530070, '460400112000', '白马井镇', '海南,儋州,白马井镇', '109.218734', '19.696407', 1);
INSERT INTO `eb_system_city` VALUES (2664, 530318, 2, 530070, '460400113000', '中和镇', '海南,儋州,中和', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2665, 530331, 2, 530070, '460400114000', '排浦镇', '海南,儋州,排浦', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2666, 530340, 2, 530070, '460400115000', '东成镇', '海南,儋州,东成', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2667, 530361, 2, 530070, '460400116000', '新州镇', '海南,儋州,新州', '110.349228', '20.017377', 1);
INSERT INTO `eb_system_city` VALUES (2668, 530394, 2, 530070, '460400400000', '国营西培农场', '海南,儋州,国营西培农场', '109.455554', '19.476422', 1);
INSERT INTO `eb_system_city` VALUES (2669, 530410, 2, 530070, '460400404000', '国营西联农场', '海南,儋州,国营西联农场', '109.539074', '19.673015', 1);
INSERT INTO `eb_system_city` VALUES (2670, 530431, 2, 530070, '460400405000', '国营蓝洋农场', '海南,儋州,国营蓝洋农场', '109.670723', '19.458984', 1);
INSERT INTO `eb_system_city` VALUES (2671, 530437, 2, 530070, '460400407000', '国营八一农场', '海南,儋州,国营八一农场', '109.364519', '19.413460', 1);
INSERT INTO `eb_system_city` VALUES (2672, 530447, 2, 530070, '460400499000', '洋浦经济开发区', '海南,儋州,洋浦经济开发', '109.202064', '19.736941', 1);
INSERT INTO `eb_system_city` VALUES (2673, 530466, 2, 530070, '460400500000', '华南热作学院', '海南,儋州,华南热作学院', '109.494073', '19.505382', 1);
INSERT INTO `eb_system_city` VALUES (2674, 530469, 2, 530468, '469001000000', '五指山市', '海南,五指山', '109.516922', '18.775146', 1);
INSERT INTO `eb_system_city` VALUES (2675, 530552, 2, 530468, '469002000000', '琼海市', '海南,琼海', '110.474579', '19.259140', 1);
INSERT INTO `eb_system_city` VALUES (2676, 530809, 2, 530468, '469005000000', '文昌市', '海南,文昌', '110.797714', '19.543423', 1);
INSERT INTO `eb_system_city` VALUES (2677, 531148, 2, 530468, '469006000000', '万宁市', '海南,万宁', '110.391075', '18.795143', 1);
INSERT INTO `eb_system_city` VALUES (2678, 531426, 2, 530468, '469007000000', '东方市', '海南,东方', '108.651817', '19.095350', 1);
INSERT INTO `eb_system_city` VALUES (2679, 531647, 2, 530468, '469021000000', '定安县', '海南,定安', '110.358891', '19.681434', 1);
INSERT INTO `eb_system_city` VALUES (2680, 531811, 2, 530468, '469022000000', '屯昌县', '海南,屯昌', '110.103415', '19.351766', 1);
INSERT INTO `eb_system_city` VALUES (2681, 531971, 2, 530468, '469023000000', '澄迈县', '海南,澄迈', '110.006755', '19.738521', 1);
INSERT INTO `eb_system_city` VALUES (2682, 532200, 2, 530468, '469024000000', '临高县', '海南,临高', '109.690508', '19.912026', 1);
INSERT INTO `eb_system_city` VALUES (2683, 532409, 2, 530468, '469025000000', '白沙黎族自治县', '海南,白沙', '109.451484', '19.224823', 1);
INSERT INTO `eb_system_city` VALUES (2684, 532558, 2, 530468, '469026000000', '昌江黎族自治县', '海南,昌江', '109.055724', '19.298062', 1);
INSERT INTO `eb_system_city` VALUES (2685, 532672, 2, 530468, '469027000000', '乐东黎族自治县', '海南,乐东', '109.173055', '18.750260', 1);
INSERT INTO `eb_system_city` VALUES (2686, 532906, 2, 530468, '469028000000', '陵水黎族自治县', '海南,陵水', '110.037504', '18.506048', 1);
INSERT INTO `eb_system_city` VALUES (2687, 533053, 2, 530468, '469029000000', '保亭黎族苗族自治县', '海南,保亭', '109.702590', '18.639130', 1);
INSERT INTO `eb_system_city` VALUES (2688, 533161, 2, 530468, '469030000000', '琼中黎族苗族自治县', '海南,琼中', '109.838389', '19.033369', 1);
INSERT INTO `eb_system_city` VALUES (2689, 533330, 2, 533329, '500101000000', '万州区', '重庆,万州', '108.408661', '30.807667', 1);
INSERT INTO `eb_system_city` VALUES (2690, 534019, 2, 533329, '500102000000', '涪陵区', '重庆,涪陵', '107.389298', '29.703113', 1);
INSERT INTO `eb_system_city` VALUES (2691, 534468, 2, 533329, '500103000000', '渝中区', '重庆,渝中', '106.568892', '29.552750', 1);
INSERT INTO `eb_system_city` VALUES (2692, 534558, 2, 533329, '500104000000', '大渡口区', '重庆,大渡口', '106.482347', '29.484527', 1);
INSERT INTO `eb_system_city` VALUES (2693, 534656, 2, 533329, '500105000000', '江北区', '重庆,江北', '106.574271', '29.606703', 1);
INSERT INTO `eb_system_city` VALUES (2694, 534799, 2, 533329, '500106000000', '沙坪坝区', '重庆,沙坪坝', '106.456878', '29.541145', 1);
INSERT INTO `eb_system_city` VALUES (2695, 535021, 2, 533329, '500107000000', '九龙坡区', '重庆,九龙坡', '106.510676', '29.502272', 1);
INSERT INTO `eb_system_city` VALUES (2696, 535262, 2, 533329, '500108000000', '南岸区', '重庆,南岸', '106.644428', '29.500297', 1);
INSERT INTO `eb_system_city` VALUES (2697, 535428, 2, 533329, '500109000000', '北碚区', '重庆,北碚', '106.395612', '29.805108', 1);
INSERT INTO `eb_system_city` VALUES (2698, 535629, 2, 533329, '500110000000', '綦江区', '重庆,綦江', '106.651362', '29.028067', 1);
INSERT INTO `eb_system_city` VALUES (2699, 536131, 2, 533329, '500111000000', '大足区', '重庆,大足', '105.721733', '29.707032', 1);
INSERT INTO `eb_system_city` VALUES (2700, 536468, 2, 533329, '500112000000', '渝北区', '重庆,渝北', '106.631187', '29.718143', 1);
INSERT INTO `eb_system_city` VALUES (2701, 536890, 2, 533329, '500113000000', '巴南区', '重庆,巴南', '106.540257', '29.402408', 1);
INSERT INTO `eb_system_city` VALUES (2702, 537212, 2, 533329, '500114000000', '黔江区', '重庆,黔江', '108.770678', '29.533610', 1);
INSERT INTO `eb_system_city` VALUES (2703, 537461, 2, 533329, '500115000000', '长寿区', '重庆,长寿', '107.081283', '29.857996', 1);
INSERT INTO `eb_system_city` VALUES (2704, 537745, 2, 533329, '500116000000', '江津区', '重庆,江津', '106.259281', '29.290069', 1);
INSERT INTO `eb_system_city` VALUES (2705, 538050, 2, 533329, '500117000000', '合川区', '重庆,合川', '106.276130', '29.972084', 1);
INSERT INTO `eb_system_city` VALUES (2706, 538493, 2, 533329, '500118000000', '永川区', '重庆,永川', '105.927376', '29.356117', 1);
INSERT INTO `eb_system_city` VALUES (2707, 538778, 2, 533329, '500119000000', '南川区', '重庆,南川', '107.099266', '29.157891', 1);
INSERT INTO `eb_system_city` VALUES (2708, 539057, 2, 533329, '500120000000', '璧山区', '重庆,璧山', '106.227305', '29.592024', 1);
INSERT INTO `eb_system_city` VALUES (2709, 539260, 2, 533329, '500151000000', '铜梁区', '重庆,铜梁', '106.056404', '29.844811', 1);
INSERT INTO `eb_system_city` VALUES (2710, 539615, 2, 533329, '500152000000', '潼南区', '重庆,潼南', '105.840556', '30.191013', 1);
INSERT INTO `eb_system_city` VALUES (2711, 539942, 2, 533329, '500153000000', '荣昌区', '重庆,荣昌', '105.594623', '29.405002', 1);
INSERT INTO `eb_system_city` VALUES (2712, 540131, 2, 533329, '500154000000', '开州区', '重庆,开州', '106.551556', '29.563009', 1);
INSERT INTO `eb_system_city` VALUES (2713, 540701, 2, 540700, '500228000000', '梁平县', '重庆,梁平', '107.769312', '30.654203', 1);
INSERT INTO `eb_system_city` VALUES (2714, 541080, 2, 540700, '500229000000', '城口县', '重庆,城口', '108.664214', '31.947633', 1);
INSERT INTO `eb_system_city` VALUES (2715, 541310, 2, 540700, '500230000000', '丰都县', '重庆,丰都', '107.730895', '29.863500', 1);
INSERT INTO `eb_system_city` VALUES (2716, 541671, 2, 540700, '500231000000', '垫江县', '重庆,垫江', '107.333390', '30.327717', 1);
INSERT INTO `eb_system_city` VALUES (2717, 541999, 2, 540700, '500232000000', '武隆县', '重庆,武隆', '107.760025', '29.325601', 1);
INSERT INTO `eb_system_city` VALUES (2718, 542236, 2, 540700, '500233000000', '忠县', '重庆,忠县', '108.039002', '30.299560', 1);
INSERT INTO `eb_system_city` VALUES (2719, 542631, 2, 540700, '500235000000', '云阳县', '重庆,云阳', '108.697324', '30.930613', 1);
INSERT INTO `eb_system_city` VALUES (2720, 543152, 2, 540700, '500236000000', '奉节县', '重庆,奉节', '109.463987', '31.018498', 1);
INSERT INTO `eb_system_city` VALUES (2721, 543575, 2, 540700, '500237000000', '巫山县', '重庆,巫山', '109.879153', '31.074834', 1);
INSERT INTO `eb_system_city` VALUES (2722, 543943, 2, 540700, '500238000000', '巫溪县', '重庆,巫溪', '109.570062', '31.398604', 1);
INSERT INTO `eb_system_city` VALUES (2723, 544307, 2, 540700, '500240000000', '石柱土家族自治县', '重庆,石柱', '108.114069', '29.999285', 1);
INSERT INTO `eb_system_city` VALUES (2724, 544583, 2, 540700, '500241000000', '秀山土家族苗族自治县', '重庆,秀山', '109.007094', '28.447997', 1);
INSERT INTO `eb_system_city` VALUES (2725, 544878, 2, 540700, '500242000000', '酉阳土家族苗族自治县', '重庆,酉阳', '108.767747', '28.841244', 1);
INSERT INTO `eb_system_city` VALUES (2726, 545196, 2, 540700, '500243000000', '彭水苗族土家族自治县', '重庆,彭水', '108.165538', '29.293902', 1);
INSERT INTO `eb_system_city` VALUES (2727, 545534, 2, 545533, '510101000000', '市辖区', '四川,成都', '104.066541', '30.572269', 1);
INSERT INTO `eb_system_city` VALUES (2728, 545535, 2, 545533, '510104000000', '锦江区', '四川,成都,锦江', '104.080989', '30.657689', 1);
INSERT INTO `eb_system_city` VALUES (2729, 545669, 2, 545533, '510105000000', '青羊区', '四川,成都,青羊', '104.062499', '30.674406', 1);
INSERT INTO `eb_system_city` VALUES (2730, 545763, 2, 545533, '510106000000', '金牛区', '四川,成都,金牛', '104.052236', '30.691359', 1);
INSERT INTO `eb_system_city` VALUES (2731, 545889, 2, 545533, '510107000000', '武侯区', '四川,成都,武侯', '104.043390', '30.641982', 1);
INSERT INTO `eb_system_city` VALUES (2732, 546035, 2, 545533, '510108000000', '成华区', '四川,成都,成华', '104.101255', '30.660122', 1);
INSERT INTO `eb_system_city` VALUES (2733, 546151, 2, 545533, '510112000000', '龙泉驿区', '四川,成都,龙泉驿', '104.274632', '30.556507', 1);
INSERT INTO `eb_system_city` VALUES (2734, 546306, 2, 545533, '510113000000', '青白江区', '四川,成都,青白江', '104.250877', '30.878681', 1);
INSERT INTO `eb_system_city` VALUES (2735, 546441, 2, 545533, '510114000000', '新都区', '四川,成都,新都', '104.158705', '30.823499', 1);
INSERT INTO `eb_system_city` VALUES (2736, 546710, 2, 545533, '510115000000', '温江区', '四川,成都,温江', '103.856646', '30.682203', 1);
INSERT INTO `eb_system_city` VALUES (2737, 546835, 2, 545533, '510116000000', '双流区', '四川,成都,双流', '103.923588', '30.574488', 1);
INSERT INTO `eb_system_city` VALUES (2738, 547144, 2, 545533, '510121000000', '金堂县', '四川,成都,金堂', '104.412005', '30.862017', 1);
INSERT INTO `eb_system_city` VALUES (2739, 547398, 2, 545533, '510124000000', '郫县', '四川,成都,郫县', '103.901092', '30.795854', 1);
INSERT INTO `eb_system_city` VALUES (2740, 547634, 2, 545533, '510129000000', '大邑县', '四川,成都,大邑', '103.511875', '30.572269', 1);
INSERT INTO `eb_system_city` VALUES (2741, 547873, 2, 545533, '510131000000', '蒲江县', '四川,成都,蒲江', '103.506498', '30.196789', 1);
INSERT INTO `eb_system_city` VALUES (2742, 548018, 2, 545533, '510132000000', '新津县', '四川,成都,新津', '103.811345', '30.410222', 1);
INSERT INTO `eb_system_city` VALUES (2743, 548137, 2, 545533, '510181000000', '都江堰市', '四川,成都,都江堰', '103.646912', '30.988435', 1);
INSERT INTO `eb_system_city` VALUES (2744, 548412, 2, 545533, '510182000000', '彭州市', '四川,成都,彭州', '103.958013', '30.990165', 1);
INSERT INTO `eb_system_city` VALUES (2745, 548788, 2, 545533, '510183000000', '邛崃市', '四川,成都,邛崃', '103.464156', '30.410275', 1);
INSERT INTO `eb_system_city` VALUES (2746, 549084, 2, 545533, '510184000000', '崇州市', '四川,成都,崇州', '103.673001', '30.630122', 1);
INSERT INTO `eb_system_city` VALUES (2747, 549363, 2, 545533, '510185000000', '简阳市', '四川,成都,简阳', '104.546774', '30.410755', 1);
INSERT INTO `eb_system_city` VALUES (2748, 550276, 2, 550275, '510301000000', '市辖区', '四川,自贡', '104.778442', '29.339030', 1);
INSERT INTO `eb_system_city` VALUES (2749, 550277, 2, 550275, '510302000000', '自流井区', '四川,自贡,自流井', '104.777191', '29.337430', 1);
INSERT INTO `eb_system_city` VALUES (2750, 550413, 2, 550275, '510303000000', '贡井区', '四川,自贡,贡井', '104.715117', '29.345546', 1);
INSERT INTO `eb_system_city` VALUES (2751, 550609, 2, 550275, '510304000000', '大安区', '四川,自贡,大安', '104.773968', '29.363634', 1);
INSERT INTO `eb_system_city` VALUES (2752, 550816, 2, 550275, '510311000000', '沿滩区', '四川,自贡,沿滩', '104.874073', '29.272581', 1);
INSERT INTO `eb_system_city` VALUES (2753, 551023, 2, 550275, '510321000000', '荣县', '四川,自贡,荣县', '104.417388', '29.445410', 1);
INSERT INTO `eb_system_city` VALUES (2754, 551398, 2, 550275, '510322000000', '富顺县', '四川,自贡,富顺', '104.975048', '29.181430', 1);
INSERT INTO `eb_system_city` VALUES (2755, 551810, 2, 551809, '510401000000', '市辖区', '四川,攀枝花', '101.718637', '26.582347', 1);
INSERT INTO `eb_system_city` VALUES (2756, 551811, 2, 551809, '510402000000', '东区', '四川,攀枝花,东区', '101.718637', '26.582347', 1);
INSERT INTO `eb_system_city` VALUES (2757, 551891, 2, 551809, '510403000000', '西区', '四川,攀枝花,西区', '101.718637', '26.582347', 1);
INSERT INTO `eb_system_city` VALUES (2758, 551941, 2, 551809, '510411000000', '仁和区', '四川,攀枝花,仁和', '101.738528', '26.497765', 1);
INSERT INTO `eb_system_city` VALUES (2759, 552057, 2, 551809, '510421000000', '米易县', '四川,攀枝花,米易', '102.110339', '26.890689', 1);
INSERT INTO `eb_system_city` VALUES (2760, 552169, 2, 551809, '510422000000', '盐边县', '四川,攀枝花,盐边', '101.855071', '26.683213', 1);
INSERT INTO `eb_system_city` VALUES (2761, 552359, 2, 552358, '510501000000', '市辖区', '四川,泸州', '105.442258', '28.871810', 1);
INSERT INTO `eb_system_city` VALUES (2762, 552360, 2, 552358, '510502000000', '江阳区', '四川,泸州,江阳', '105.435009', '28.878818', 1);
INSERT INTO `eb_system_city` VALUES (2763, 552536, 2, 552358, '510503000000', '纳溪区', '四川,泸州,纳溪', '105.371151', '28.773428', 1);
INSERT INTO `eb_system_city` VALUES (2764, 552755, 2, 552358, '510504000000', '龙马潭区', '四川,泸州,龙马潭', '105.437765', '28.913221', 1);
INSERT INTO `eb_system_city` VALUES (2765, 552858, 2, 552358, '510521000000', '泸县', '四川,泸州,泸县', '105.381893', '29.151534', 1);
INSERT INTO `eb_system_city` VALUES (2766, 553181, 2, 552358, '510522000000', '合江县', '四川,泸州,合江', '105.831067', '28.811203', 1);
INSERT INTO `eb_system_city` VALUES (2767, 553536, 2, 552358, '510524000000', '叙永县', '四川,泸州,叙永', '105.444765', '28.155801', 1);
INSERT INTO `eb_system_city` VALUES (2768, 553823, 2, 552358, '510525000000', '古蔺县', '四川,泸州,古蔺', '105.812602', '28.038802', 1);
INSERT INTO `eb_system_city` VALUES (2769, 554143, 2, 554142, '510601000000', '市辖区', '四川,德阳', '104.397894', '31.126855', 1);
INSERT INTO `eb_system_city` VALUES (2770, 554144, 2, 554142, '510603000000', '旌阳区', '四川,德阳,旌阳', '104.416943', '31.142498', 1);
INSERT INTO `eb_system_city` VALUES (2771, 554397, 2, 554142, '510623000000', '中江县', '四川,德阳,中江', '104.678749', '31.033051', 1);
INSERT INTO `eb_system_city` VALUES (2772, 555280, 2, 554142, '510626000000', '罗江县', '四川,德阳,罗江', '104.510249', '31.317045', 1);
INSERT INTO `eb_system_city` VALUES (2773, 555418, 2, 554142, '510681000000', '广汉市', '四川,德阳,广汉', '104.282331', '30.976165', 1);
INSERT INTO `eb_system_city` VALUES (2774, 555660, 2, 554142, '510682000000', '什邡市', '四川,德阳,什邡', '104.167501', '31.126780', 1);
INSERT INTO `eb_system_city` VALUES (2775, 555848, 2, 554142, '510683000000', '绵竹市', '四川,德阳,绵竹', '104.220750', '31.338077', 1);
INSERT INTO `eb_system_city` VALUES (2776, 556078, 2, 556077, '510701000000', '市辖区', '四川,绵阳', '104.679114', '31.467450', 1);
INSERT INTO `eb_system_city` VALUES (2777, 556079, 2, 556077, '510703000000', '涪城区', '四川,绵阳,涪城', '104.756944', '31.455101', 1);
INSERT INTO `eb_system_city` VALUES (2778, 556357, 2, 556077, '510704000000', '游仙区', '四川,绵阳,游仙', '104.766393', '31.473779', 1);
INSERT INTO `eb_system_city` VALUES (2779, 556705, 2, 556077, '510705000000', '安州区', '四川,绵阳,安州', '104.679114', '31.467450', 1);
INSERT INTO `eb_system_city` VALUES (2780, 556985, 2, 556077, '510722000000', '三台县', '四川,绵阳,三台', '105.094586', '31.095979', 1);
INSERT INTO `eb_system_city` VALUES (2781, 558091, 2, 556077, '510723000000', '盐亭县', '四川,绵阳,盐亭', '105.389453', '31.208363', 1);
INSERT INTO `eb_system_city` VALUES (2782, 558648, 2, 556077, '510725000000', '梓潼县', '四川,绵阳,梓潼', '105.170845', '31.642718', 1);
INSERT INTO `eb_system_city` VALUES (2783, 559030, 2, 556077, '510726000000', '北川羌族自治县', '四川,绵阳,北川', '104.467970', '31.617203', 1);
INSERT INTO `eb_system_city` VALUES (2784, 559397, 2, 556077, '510727000000', '平武县', '四川,绵阳,平武', '104.555583', '32.409675', 1);
INSERT INTO `eb_system_city` VALUES (2785, 559687, 2, 556077, '510781000000', '江油市', '四川,绵阳,江油', '104.745877', '31.778025', 1);
INSERT INTO `eb_system_city` VALUES (2786, 560192, 2, 560191, '510801000000', '市辖区', '四川,广元', '105.843357', '32.435435', 1);
INSERT INTO `eb_system_city` VALUES (2787, 560193, 2, 560191, '510802000000', '利州区', '四川,广元,利州', '105.845218', '32.433898', 1);
INSERT INTO `eb_system_city` VALUES (2788, 560469, 2, 560191, '510811000000', '昭化区', '四川,广元,昭化', '105.964121', '32.322788', 1);
INSERT INTO `eb_system_city` VALUES (2789, 560735, 2, 560191, '510812000000', '朝天区', '四川,广元,朝天', '105.890445', '32.643982', 1);
INSERT INTO `eb_system_city` VALUES (2790, 560982, 2, 560191, '510821000000', '旺苍县', '四川,广元,旺苍', '106.289905', '32.228917', 1);
INSERT INTO `eb_system_city` VALUES (2791, 561413, 2, 560191, '510822000000', '青川县', '四川,广元,青川', '105.238842', '32.575485', 1);
INSERT INTO `eb_system_city` VALUES (2792, 561756, 2, 560191, '510823000000', '剑阁县', '四川,广元,剑阁', '105.524766', '32.287723', 1);
INSERT INTO `eb_system_city` VALUES (2793, 562393, 2, 560191, '510824000000', '苍溪县', '四川,广元,苍溪', '105.934801', '31.732432', 1);
INSERT INTO `eb_system_city` VALUES (2794, 563243, 2, 563242, '510901000000', '市辖区', '四川,遂宁', '105.592898', '30.532847', 1);
INSERT INTO `eb_system_city` VALUES (2795, 563244, 2, 563242, '510903000000', '船山区', '四川,遂宁,船山', '105.568297', '30.525475', 1);
INSERT INTO `eb_system_city` VALUES (2796, 563569, 2, 563242, '510904000000', '安居区', '四川,遂宁,安居', '105.456342', '30.355379', 1);
INSERT INTO `eb_system_city` VALUES (2797, 564115, 2, 563242, '510921000000', '蓬溪县', '四川,遂宁,蓬溪', '105.707570', '30.757575', 1);
INSERT INTO `eb_system_city` VALUES (2798, 564699, 2, 563242, '510922000000', '射洪县', '四川,遂宁,射洪', '105.388405', '30.870986', 1);
INSERT INTO `eb_system_city` VALUES (2799, 565387, 2, 563242, '510923000000', '大英县', '四川,遂宁,大英', '105.236904', '30.594337', 1);
INSERT INTO `eb_system_city` VALUES (2800, 565736, 2, 565735, '511001000000', '市辖区', '四川,内江', '105.058433', '29.580228', 1);
INSERT INTO `eb_system_city` VALUES (2801, 565737, 2, 565735, '511002000000', '市中区', '四川,内江,市中', '105.067597', '29.587053', 1);
INSERT INTO `eb_system_city` VALUES (2802, 565956, 2, 565735, '511011000000', '东兴区', '四川,内江,东兴', '105.075490', '29.592756', 1);
INSERT INTO `eb_system_city` VALUES (2803, 566504, 2, 565735, '511024000000', '威远县', '四川,内江,威远', '104.668879', '29.527440', 1);
INSERT INTO `eb_system_city` VALUES (2804, 566895, 2, 565735, '511025000000', '资中县', '四川,内江,资中', '104.851944', '29.764059', 1);
INSERT INTO `eb_system_city` VALUES (2805, 567769, 2, 565735, '511028000000', '隆昌县', '四川,内江,隆昌', '105.287612', '29.339476', 1);
INSERT INTO `eb_system_city` VALUES (2806, 568203, 2, 568202, '511101000000', '市辖区', '四川,乐山', '103.765568', '29.552106', 1);
INSERT INTO `eb_system_city` VALUES (2807, 568204, 2, 568202, '511102000000', '市中区', '四川,乐山,市中', '103.761330', '29.555375', 1);
INSERT INTO `eb_system_city` VALUES (2808, 568549, 2, 568202, '511111000000', '沙湾区', '四川,乐山,沙湾', '103.549991', '29.413091', 1);
INSERT INTO `eb_system_city` VALUES (2809, 568712, 2, 568202, '511112000000', '五通桥区', '四川,乐山,五通桥', '103.818009', '29.406932', 1);
INSERT INTO `eb_system_city` VALUES (2810, 568897, 2, 568202, '511113000000', '金口河区', '四川,乐山,金口河', '103.078621', '29.244345', 1);
INSERT INTO `eb_system_city` VALUES (2811, 568949, 2, 568202, '511123000000', '犍为县', '四川,乐山,犍为', '103.949326', '29.208171', 1);
INSERT INTO `eb_system_city` VALUES (2812, 569368, 2, 568202, '511124000000', '井研县', '四川,乐山,井研', '104.069726', '29.651287', 1);
INSERT INTO `eb_system_city` VALUES (2813, 569627, 2, 568202, '511126000000', '夹江县', '四川,乐山,夹江', '103.571657', '29.737630', 1);
INSERT INTO `eb_system_city` VALUES (2814, 569905, 2, 568202, '511129000000', '沐川县', '四川,乐山,沐川', '103.902335', '28.956647', 1);
INSERT INTO `eb_system_city` VALUES (2815, 570138, 2, 568202, '511132000000', '峨边彝族自治县', '四川,乐山,峨边', '103.765568', '29.552106', 1);
INSERT INTO `eb_system_city` VALUES (2816, 570296, 2, 568202, '511133000000', '马边彝族自治县', '四川,乐山,马边', '103.546348', '28.835521', 1);
INSERT INTO `eb_system_city` VALUES (2817, 570440, 2, 568202, '511181000000', '峨眉山市', '四川,乐山,峨眉山', '103.484504', '29.601199', 1);
INSERT INTO `eb_system_city` VALUES (2818, 570734, 2, 570733, '511301000000', '市辖区', '四川,南充', '106.110698', '30.837793', 1);
INSERT INTO `eb_system_city` VALUES (2819, 570735, 2, 570733, '511302000000', '顺庆区', '四川,南充,顺庆', '106.092399', '30.796486', 1);
INSERT INTO `eb_system_city` VALUES (2820, 571078, 2, 570733, '511303000000', '高坪区', '四川,南充,高坪', '106.118808', '30.781623', 1);
INSERT INTO `eb_system_city` VALUES (2821, 571510, 2, 570733, '511304000000', '嘉陵区', '四川,南充,嘉陵', '106.071793', '30.758748', 1);
INSERT INTO `eb_system_city` VALUES (2822, 572146, 2, 570733, '511321000000', '南部县', '四川,南充,南部', '106.036584', '31.347467', 1);
INSERT INTO `eb_system_city` VALUES (2823, 573339, 2, 570733, '511322000000', '营山县', '四川,南充,营山', '106.565473', '31.076458', 1);
INSERT INTO `eb_system_city` VALUES (2824, 574080, 2, 570733, '511323000000', '蓬安县', '四川,南充,蓬安', '106.412151', '31.029097', 1);
INSERT INTO `eb_system_city` VALUES (2825, 574767, 2, 570733, '511324000000', '仪陇县', '四川,南充,仪陇', '106.303042', '31.271562', 1);
INSERT INTO `eb_system_city` VALUES (2826, 575761, 2, 570733, '511325000000', '西充县', '四川,南充,西充', '105.900878', '30.995669', 1);
INSERT INTO `eb_system_city` VALUES (2827, 576427, 2, 570733, '511381000000', '阆中市', '四川,南充,阆中', '106.005047', '31.558357', 1);
INSERT INTO `eb_system_city` VALUES (2828, 576993, 2, 576992, '511401000000', '市辖区', '四川,眉山', '103.848538', '30.075439', 1);
INSERT INTO `eb_system_city` VALUES (2829, 576994, 2, 576992, '511402000000', '东坡区', '四川,眉山,东坡', '103.831752', '30.042345', 1);
INSERT INTO `eb_system_city` VALUES (2830, 577323, 2, 576992, '511403000000', '彭山区', '四川,眉山,彭山', '103.872950', '30.193056', 1);
INSERT INTO `eb_system_city` VALUES (2831, 577445, 2, 576992, '511421000000', '仁寿县', '四川,眉山,仁寿', '104.134082', '29.995630', 1);
INSERT INTO `eb_system_city` VALUES (2832, 578124, 2, 576992, '511423000000', '洪雅县', '四川,眉山,洪雅', '103.372863', '29.904890', 1);
INSERT INTO `eb_system_city` VALUES (2833, 578299, 2, 576992, '511424000000', '丹棱县', '四川,眉山,丹棱', '103.512733', '30.014448', 1);
INSERT INTO `eb_system_city` VALUES (2834, 578385, 2, 576992, '511425000000', '青神县', '四川,眉山,青神', '103.846688', '29.831358', 1);
INSERT INTO `eb_system_city` VALUES (2835, 578486, 2, 578485, '511501000000', '市辖区', '四川,宜宾', '104.643215', '28.751768', 1);
INSERT INTO `eb_system_city` VALUES (2836, 578487, 2, 578485, '511502000000', '翠屏区', '四川,宜宾,翠屏', '104.620009', '28.765690', 1);
INSERT INTO `eb_system_city` VALUES (2837, 578857, 2, 578485, '511503000000', '南溪区', '四川,宜宾,南溪', '104.969882', '28.845626', 1);
INSERT INTO `eb_system_city` VALUES (2838, 579114, 2, 578485, '511521000000', '宜宾县', '四川,宜宾,宜宾', '104.533213', '28.690045', 1);
INSERT INTO `eb_system_city` VALUES (2839, 579727, 2, 578485, '511523000000', '江安县', '四川,宜宾,江安', '105.066943', '28.723999', 1);
INSERT INTO `eb_system_city` VALUES (2840, 580070, 2, 578485, '511524000000', '长宁县', '四川,宜宾,长宁', '104.921174', '28.582169', 1);
INSERT INTO `eb_system_city` VALUES (2841, 580388, 2, 578485, '511525000000', '高县', '四川,宜宾,高县', '104.517739', '28.436226', 1);
INSERT INTO `eb_system_city` VALUES (2842, 580725, 2, 578485, '511526000000', '珙县', '四川,宜宾,珙县', '104.709202', '28.438630', 1);
INSERT INTO `eb_system_city` VALUES (2843, 581025, 2, 578485, '511527000000', '筠连县', '四川,宜宾,筠连', '104.510988', '28.163860', 1);
INSERT INTO `eb_system_city` VALUES (2844, 581304, 2, 578485, '511528000000', '兴文县', '四川,宜宾,兴文', '105.236325', '28.303614', 1);
INSERT INTO `eb_system_city` VALUES (2845, 581579, 2, 578485, '511529000000', '屏山县', '四川,宜宾,屏山', '104.345974', '28.828482', 1);
INSERT INTO `eb_system_city` VALUES (2846, 581871, 2, 581870, '511601000000', '市辖区', '四川,广安', '106.633212', '30.455961', 1);
INSERT INTO `eb_system_city` VALUES (2847, 581872, 2, 581870, '511602000000', '广安区', '四川,广安,广安', '106.641608', '30.474003', 1);
INSERT INTO `eb_system_city` VALUES (2848, 582526, 2, 581870, '511603000000', '前锋区', '四川,广安,前锋', '106.893277', '30.496300', 1);
INSERT INTO `eb_system_city` VALUES (2849, 582827, 2, 581870, '511621000000', '岳池县', '四川,广安,岳池', '106.440114', '30.537863', 1);
INSERT INTO `eb_system_city` VALUES (2850, 583751, 2, 581870, '511622000000', '武胜县', '四川,广安,武胜', '106.295764', '30.348772', 1);
INSERT INTO `eb_system_city` VALUES (2851, 584332, 2, 581870, '511623000000', '邻水县', '四川,广安,邻水', '106.930380', '30.334769', 1);
INSERT INTO `eb_system_city` VALUES (2852, 584900, 2, 581870, '511681000000', '华蓥市', '四川,广安,华蓥', '106.783088', '30.390435', 1);
INSERT INTO `eb_system_city` VALUES (2853, 585050, 2, 585049, '511701000000', '市辖区', '四川,达州', '107.468023', '31.209571', 1);
INSERT INTO `eb_system_city` VALUES (2854, 585051, 2, 585049, '511702000000', '通川区', '四川,达州,通川', '107.504517', '31.214724', 1);
INSERT INTO `eb_system_city` VALUES (2855, 585347, 2, 585049, '511703000000', '达川区', '四川,达州,达川', '107.511845', '31.196118', 1);
INSERT INTO `eb_system_city` VALUES (2856, 586085, 2, 585049, '511722000000', '宣汉县', '四川,达州,宣汉', '107.727191', '31.353835', 1);
INSERT INTO `eb_system_city` VALUES (2857, 586709, 2, 585049, '511723000000', '开江县', '四川,达州,开江', '107.868736', '31.082987', 1);
INSERT INTO `eb_system_city` VALUES (2858, 586957, 2, 585049, '511724000000', '大竹县', '四川,达州,大竹', '107.204744', '30.736266', 1);
INSERT INTO `eb_system_city` VALUES (2859, 587452, 2, 585049, '511725000000', '渠县', '四川,达州,渠县', '106.972996', '30.836659', 1);
INSERT INTO `eb_system_city` VALUES (2860, 588071, 2, 585049, '511781000000', '万源市', '四川,达州,万源', '108.034657', '32.081631', 1);
INSERT INTO `eb_system_city` VALUES (2861, 588539, 2, 588538, '511801000000', '市辖区', '四川,雅安', '103.013261', '29.980537', 1);
INSERT INTO `eb_system_city` VALUES (2862, 588540, 2, 588538, '511802000000', '雨城区', '四川,雅安,雨城', '103.033083', '30.005447', 1);
INSERT INTO `eb_system_city` VALUES (2863, 588771, 2, 588538, '511803000000', '名山区', '四川,雅安,名山', '103.109185', '30.069954', 1);
INSERT INTO `eb_system_city` VALUES (2864, 589001, 2, 588538, '511822000000', '荥经县', '四川,雅安,荥经', '102.846738', '29.792931', 1);
INSERT INTO `eb_system_city` VALUES (2865, 589135, 2, 588538, '511823000000', '汉源县', '四川,雅安,汉源', '102.645453', '29.347187', 1);
INSERT INTO `eb_system_city` VALUES (2866, 589376, 2, 588538, '511824000000', '石棉县', '四川,雅安,石棉', '102.359462', '29.227874', 1);
INSERT INTO `eb_system_city` VALUES (2867, 589494, 2, 588538, '511825000000', '天全县', '四川,雅安,天全', '102.758317', '30.066713', 1);
INSERT INTO `eb_system_city` VALUES (2868, 589654, 2, 588538, '511826000000', '芦山县', '四川,雅安,芦山', '102.928260', '30.144084', 1);
INSERT INTO `eb_system_city` VALUES (2869, 589711, 2, 588538, '511827000000', '宝兴县', '四川,雅安,宝兴', '102.814531', '30.368126', 1);
INSERT INTO `eb_system_city` VALUES (2870, 589780, 2, 589779, '511901000000', '市辖区', '四川,巴中', '106.747477', '31.867903', 1);
INSERT INTO `eb_system_city` VALUES (2871, 589781, 2, 589779, '511902000000', '巴州区', '四川,巴中,巴州', '106.768878', '31.851478', 1);
INSERT INTO `eb_system_city` VALUES (2872, 590246, 2, 589779, '511903000000', '恩阳区', '四川,巴中,恩阳', '106.655347', '31.786691', 1);
INSERT INTO `eb_system_city` VALUES (2873, 590712, 2, 589779, '511921000000', '通江县', '四川,巴中,通江', '107.245033', '31.911705', 1);
INSERT INTO `eb_system_city` VALUES (2874, 591330, 2, 589779, '511922000000', '南江县', '四川,巴中,南江', '106.828697', '32.346589', 1);
INSERT INTO `eb_system_city` VALUES (2875, 592003, 2, 589779, '511923000000', '平昌县', '四川,巴中,平昌', '107.104008', '31.560874', 1);
INSERT INTO `eb_system_city` VALUES (2876, 592599, 2, 592598, '512001000000', '市辖区', '四川,资阳', '104.627636', '30.128901', 1);
INSERT INTO `eb_system_city` VALUES (2877, 592600, 2, 592598, '512002000000', '雁江区', '四川,资阳,雁江', '104.677096', '30.108210', 1);
INSERT INTO `eb_system_city` VALUES (2878, 593157, 2, 592598, '512021000000', '安岳县', '四川,资阳,安岳', '105.335613', '30.097246', 1);
INSERT INTO `eb_system_city` VALUES (2879, 594205, 2, 592598, '512022000000', '乐至县', '四川,资阳,乐至', '105.020204', '30.276120', 1);
INSERT INTO `eb_system_city` VALUES (2880, 594865, 2, 594864, '513201000000', '马尔康市', '四川,阿坝,马尔康', '102.206504', '31.905813', 1);
INSERT INTO `eb_system_city` VALUES (2881, 594988, 2, 594864, '513221000000', '汶川县', '四川,阿坝,汶川', '103.590387', '31.476822', 1);
INSERT INTO `eb_system_city` VALUES (2882, 595128, 2, 594864, '513222000000', '理县', '四川,阿坝,理县', '103.166853', '31.436473', 1);
INSERT INTO `eb_system_city` VALUES (2883, 595230, 2, 594864, '513223000000', '茂县', '四川,阿坝,茂县', '103.853522', '31.681154', 1);
INSERT INTO `eb_system_city` VALUES (2884, 595404, 2, 594864, '513224000000', '松潘县', '四川,阿坝,松潘', '103.604698', '32.655325', 1);
INSERT INTO `eb_system_city` VALUES (2885, 595579, 2, 594864, '513225000000', '九寨沟县', '四川,阿坝,九寨沟', '104.243841', '33.252056', 1);
INSERT INTO `eb_system_city` VALUES (2886, 595731, 2, 594864, '513226000000', '金川县', '四川,阿坝,金川', '102.063829', '31.476277', 1);
INSERT INTO `eb_system_city` VALUES (2887, 595864, 2, 594864, '513227000000', '小金县', '四川,阿坝,小金', '102.364373', '30.999031', 1);
INSERT INTO `eb_system_city` VALUES (2888, 596022, 2, 594864, '513228000000', '黑水县', '四川,阿坝,黑水', '102.990108', '32.061895', 1);
INSERT INTO `eb_system_city` VALUES (2889, 596167, 2, 594864, '513230000000', '壤塘县', '四川,阿坝,壤塘', '100.978526', '32.265796', 1);
INSERT INTO `eb_system_city` VALUES (2890, 596243, 2, 594864, '513231000000', '阿坝县', '四川,阿坝,阿坝', '101.706655', '32.902459', 1);
INSERT INTO `eb_system_city` VALUES (2891, 596354, 2, 594864, '513232000000', '若尔盖县', '四川,阿坝,若尔盖', '102.961798', '33.575892', 1);
INSERT INTO `eb_system_city` VALUES (2892, 596475, 2, 594864, '513233000000', '红原县', '四川,阿坝,红原', '102.544405', '32.790891', 1);
INSERT INTO `eb_system_city` VALUES (2893, 596526, 2, 596525, '513301000000', '康定市', '四川,甘孜,康定', '101.957146', '29.998436', 1);
INSERT INTO `eb_system_city` VALUES (2894, 596792, 2, 596525, '513322000000', '泸定县', '四川,甘孜,泸定', '102.234618', '29.914160', 1);
INSERT INTO `eb_system_city` VALUES (2895, 596957, 2, 596525, '513323000000', '丹巴县', '四川,甘孜,丹巴', '101.890358', '30.878577', 1);
INSERT INTO `eb_system_city` VALUES (2896, 597158, 2, 596525, '513324000000', '九龙县', '四川,甘孜,九龙', '101.507294', '29.000348', 1);
INSERT INTO `eb_system_city` VALUES (2897, 597242, 2, 596525, '513325000000', '雅江县', '四川,甘孜,雅江', '101.014425', '30.031533', 1);
INSERT INTO `eb_system_city` VALUES (2898, 597374, 2, 596525, '513326000000', '道孚县', '四川,甘孜,道孚', '101.125237', '30.979545', 1);
INSERT INTO `eb_system_city` VALUES (2899, 597557, 2, 596525, '513327000000', '炉霍县', '四川,甘孜,炉霍', '100.676372', '31.391790', 1);
INSERT INTO `eb_system_city` VALUES (2900, 597749, 2, 596525, '513328000000', '甘孜县', '四川,甘孜,甘孜', '99.992671', '31.622934', 1);
INSERT INTO `eb_system_city` VALUES (2901, 597992, 2, 596525, '513329000000', '新龙县', '四川,甘孜,新龙', '100.311369', '30.939169', 1);
INSERT INTO `eb_system_city` VALUES (2902, 598162, 2, 596525, '513330000000', '德格县', '四川,甘孜,德格', '98.580915', '31.806118', 1);
INSERT INTO `eb_system_city` VALUES (2903, 598363, 2, 596525, '513331000000', '白玉县', '四川,甘孜,白玉', '98.824182', '31.209913', 1);
INSERT INTO `eb_system_city` VALUES (2904, 598540, 2, 596525, '513332000000', '石渠县', '四川,甘孜,石渠', '98.102900', '32.978960', 1);
INSERT INTO `eb_system_city` VALUES (2905, 598733, 2, 596525, '513333000000', '色达县', '四川,甘孜,色达', '100.332743', '32.268129', 1);
INSERT INTO `eb_system_city` VALUES (2906, 598889, 2, 596525, '513334000000', '理塘县', '四川,甘孜,理塘', '100.269818', '29.996049', 1);
INSERT INTO `eb_system_city` VALUES (2907, 599129, 2, 596525, '513335000000', '巴塘县', '四川,甘孜,巴塘', '99.110712', '30.004677', 1);
INSERT INTO `eb_system_city` VALUES (2908, 599272, 2, 596525, '513336000000', '乡城县', '四川,甘孜,乡城', '99.798435', '28.931172', 1);
INSERT INTO `eb_system_city` VALUES (2909, 599377, 2, 596525, '513337000000', '稻城县', '四川,甘孜,稻城', '100.298403', '29.037007', 1);
INSERT INTO `eb_system_city` VALUES (2910, 599516, 2, 596525, '513338000000', '得荣县', '四川,甘孜,得荣', '99.286335', '28.713037', 1);
INSERT INTO `eb_system_city` VALUES (2911, 599660, 2, 599659, '513401000000', '西昌市', '四川,凉山,西昌', '102.264449', '27.894504', 1);
INSERT INTO `eb_system_city` VALUES (2912, 599974, 2, 599659, '513422000000', '木里藏族自治县', '四川,凉山,木里', '101.280206', '27.928835', 1);
INSERT INTO `eb_system_city` VALUES (2913, 600127, 2, 599659, '513423000000', '盐源县', '四川,凉山,盐源', '101.509188', '27.422645', 1);
INSERT INTO `eb_system_city` VALUES (2914, 600415, 2, 599659, '513424000000', '德昌县', '四川,凉山,德昌', '102.175670', '27.402839', 1);
INSERT INTO `eb_system_city` VALUES (2915, 600579, 2, 599659, '513425000000', '会理县', '四川,凉山,会理', '102.244683', '26.655026', 1);
INSERT INTO `eb_system_city` VALUES (2916, 600938, 2, 599659, '513426000000', '会东县', '四川,凉山,会东', '102.577961', '26.634669', 1);
INSERT INTO `eb_system_city` VALUES (2917, 601284, 2, 599659, '513427000000', '宁南县', '四川,凉山,宁南', '102.759634', '27.066384', 1);
INSERT INTO `eb_system_city` VALUES (2918, 601444, 2, 599659, '513428000000', '普格县', '四川,凉山,普格', '102.540901', '27.376413', 1);
INSERT INTO `eb_system_city` VALUES (2919, 601640, 2, 599659, '513429000000', '布拖县', '四川,凉山,布拖', '102.811631', '27.706192', 1);
INSERT INTO `eb_system_city` VALUES (2920, 601863, 2, 599659, '513430000000', '金阳县', '四川,凉山,金阳', '103.248772', '27.696861', 1);
INSERT INTO `eb_system_city` VALUES (2921, 602076, 2, 599659, '513431000000', '昭觉县', '四川,凉山,昭觉', '102.842611', '28.014088', 1);
INSERT INTO `eb_system_city` VALUES (2922, 602396, 2, 599659, '513432000000', '喜德县', '四川,凉山,喜德', '102.412518', '28.306726', 1);
INSERT INTO `eb_system_city` VALUES (2923, 602594, 2, 599659, '513433000000', '冕宁县', '四川,凉山,冕宁', '102.177010', '28.549657', 1);
INSERT INTO `eb_system_city` VALUES (2924, 602865, 2, 599659, '513434000000', '越西县', '四川,凉山,越西', '102.507680', '28.639801', 1);
INSERT INTO `eb_system_city` VALUES (2925, 603201, 2, 599659, '513435000000', '甘洛县', '四川,凉山,甘洛', '102.771749', '28.966069', 1);
INSERT INTO `eb_system_city` VALUES (2926, 603460, 2, 599659, '513436000000', '美姑县', '四川,凉山,美姑', '103.132180', '28.328640', 1);
INSERT INTO `eb_system_city` VALUES (2927, 603792, 2, 599659, '513437000000', '雷波县', '四川,凉山,雷波', '103.571696', '28.262683', 1);
INSERT INTO `eb_system_city` VALUES (2928, 604133, 2, 604132, '520101000000', '市辖区', '贵州,贵阳', '106.630153', '26.647661', 1);
INSERT INTO `eb_system_city` VALUES (2929, 604134, 2, 604132, '520102000000', '南明区', '贵州,贵阳,南明', '106.714371', '26.567944', 1);
INSERT INTO `eb_system_city` VALUES (2930, 604342, 2, 604132, '520103000000', '云岩区', '贵州,贵阳,云岩', '106.630153', '26.647661', 1);
INSERT INTO `eb_system_city` VALUES (2931, 604530, 2, 604132, '520111000000', '花溪区', '贵州,贵阳,花溪', '106.670258', '26.409817', 1);
INSERT INTO `eb_system_city` VALUES (2932, 604769, 2, 604132, '520112000000', '乌当区', '贵州,贵阳,乌当', '106.630153', '26.647661', 1);
INSERT INTO `eb_system_city` VALUES (2933, 604883, 2, 604132, '520113000000', '白云区', '贵州,贵阳,白云', '106.630153', '26.647661', 1);
INSERT INTO `eb_system_city` VALUES (2934, 604989, 2, 604132, '520115000000', '观山湖区', '贵州,贵阳,观山湖', '106.622452', '26.601450', 1);
INSERT INTO `eb_system_city` VALUES (2935, 605114, 2, 604132, '520121000000', '开阳县', '贵州,贵阳,开阳', '106.965088', '27.057764', 1);
INSERT INTO `eb_system_city` VALUES (2936, 605264, 2, 604132, '520122000000', '息烽县', '贵州,贵阳,息烽', '106.740410', '27.090479', 1);
INSERT INTO `eb_system_city` VALUES (2937, 605453, 2, 604132, '520123000000', '修文县', '贵州,贵阳,修文', '106.592110', '26.838926', 1);
INSERT INTO `eb_system_city` VALUES (2938, 605593, 2, 604132, '520181000000', '清镇市', '贵州,贵阳,清镇', '106.470711', '26.556080', 1);
INSERT INTO `eb_system_city` VALUES (2939, 605835, 2, 605834, '520201000000', '钟山区', '贵州,六盘水,钟山', '104.843555', '26.574979', 1);
INSERT INTO `eb_system_city` VALUES (2940, 605994, 2, 605834, '520203000000', '六枝特区', '贵州,六盘水,六枝特', '105.480029', '26.201228', 1);
INSERT INTO `eb_system_city` VALUES (2941, 606258, 2, 605834, '520221000000', '水城县', '贵州,六盘水,水城', '104.957831', '26.547904', 1);
INSERT INTO `eb_system_city` VALUES (2942, 606493, 2, 605834, '520222000000', '盘县', '贵州,六盘水,盘县', '104.471535', '25.710002', 1);
INSERT INTO `eb_system_city` VALUES (2943, 607030, 2, 607029, '520301000000', '市辖区', '贵州,遵义', '106.927389', '27.725654', 1);
INSERT INTO `eb_system_city` VALUES (2944, 607031, 2, 607029, '520302000000', '红花岗区', '贵州,遵义,红花岗', '106.893709', '27.644755', 1);
INSERT INTO `eb_system_city` VALUES (2945, 607235, 2, 607029, '520303000000', '汇川区', '贵州,遵义,汇川', '106.934270', '27.750125', 1);
INSERT INTO `eb_system_city` VALUES (2946, 607385, 2, 607029, '520304000000', '播州区', '贵州,遵义,播州', '106.927389', '27.725654', 1);
INSERT INTO `eb_system_city` VALUES (2947, 607584, 2, 607029, '520322000000', '桐梓县', '贵州,遵义,桐梓', '106.825644', '28.133583', 1);
INSERT INTO `eb_system_city` VALUES (2948, 607833, 2, 607029, '520323000000', '绥阳县', '贵州,遵义,绥阳', '107.191222', '27.946222', 1);
INSERT INTO `eb_system_city` VALUES (2949, 607966, 2, 607029, '520324000000', '正安县', '贵州,遵义,正安', '107.453945', '28.553285', 1);
INSERT INTO `eb_system_city` VALUES (2950, 608138, 2, 607029, '520325000000', '道真仡佬族苗族自治县', '贵州,遵义,道真', '106.927389', '27.725654', 1);
INSERT INTO `eb_system_city` VALUES (2951, 608236, 2, 607029, '520326000000', '务川仡佬族苗族自治县', '贵州,遵义,务川', '107.898957', '28.563086', 1);
INSERT INTO `eb_system_city` VALUES (2952, 608370, 2, 607029, '520327000000', '凤冈县', '贵州,遵义,凤冈', '107.716356', '27.954695', 1);
INSERT INTO `eb_system_city` VALUES (2953, 608471, 2, 607029, '520328000000', '湄潭县', '贵州,遵义,湄潭', '107.465407', '27.749055', 1);
INSERT INTO `eb_system_city` VALUES (2954, 608620, 2, 607029, '520329000000', '余庆县', '贵州,遵义,余庆', '107.905278', '27.215420', 1);
INSERT INTO `eb_system_city` VALUES (2955, 608701, 2, 607029, '520330000000', '习水县', '贵州,遵义,习水', '106.197138', '28.331270', 1);
INSERT INTO `eb_system_city` VALUES (2956, 608974, 2, 607029, '520381000000', '赤水市', '贵州,遵义,赤水', '105.697472', '28.590337', 1);
INSERT INTO `eb_system_city` VALUES (2957, 609114, 2, 607029, '520382000000', '仁怀市', '贵州,遵义,仁怀', '106.400342', '27.791650', 1);
INSERT INTO `eb_system_city` VALUES (2958, 609310, 2, 609309, '520401000000', '市辖区', '贵州,安顺', '105.947593', '26.253072', 1);
INSERT INTO `eb_system_city` VALUES (2959, 609311, 2, 609309, '520402000000', '西秀区', '贵州,安顺,西秀', '105.965535', '26.245433', 1);
INSERT INTO `eb_system_city` VALUES (2960, 609686, 2, 609309, '520403000000', '平坝区', '贵州,安顺,平坝', '106.255557', '26.405502', 1);
INSERT INTO `eb_system_city` VALUES (2961, 609845, 2, 609309, '520422000000', '普定县', '贵州,安顺,普定', '105.743196', '26.301446', 1);
INSERT INTO `eb_system_city` VALUES (2962, 610030, 2, 609309, '520423000000', '镇宁布依族苗族自治县', '贵州,安顺,镇宁', '105.770402', '26.057362', 1);
INSERT INTO `eb_system_city` VALUES (2963, 610256, 2, 609309, '520424000000', '关岭布依族苗族自治县', '贵州,安顺,关岭', '105.622053', '25.940378', 1);
INSERT INTO `eb_system_city` VALUES (2964, 610426, 2, 609309, '520425000000', '紫云苗族布依族自治县', '贵州,安顺,紫云', '106.087216', '25.755886', 1);
INSERT INTO `eb_system_city` VALUES (2965, 610608, 2, 610607, '520501000000', '市辖区', '贵州,毕节', '105.283992', '27.302589', 1);
INSERT INTO `eb_system_city` VALUES (2966, 610609, 2, 610607, '520502000000', '七星关区', '贵州,毕节,七星关', '105.305138', '27.298494', 1);
INSERT INTO `eb_system_city` VALUES (2967, 611207, 2, 610607, '520521000000', '大方县', '贵州,毕节,大方', '105.613174', '27.141682', 1);
INSERT INTO `eb_system_city` VALUES (2968, 611627, 2, 610607, '520522000000', '黔西县', '贵州,毕节,黔西', '106.033544', '27.007713', 1);
INSERT INTO `eb_system_city` VALUES (2969, 612043, 2, 610607, '520523000000', '金沙县', '贵州,毕节,金沙', '106.220228', '27.459214', 1);
INSERT INTO `eb_system_city` VALUES (2970, 612308, 2, 610607, '520524000000', '织金县', '贵州,毕节,织金', '105.770542', '26.663450', 1);
INSERT INTO `eb_system_city` VALUES (2971, 612915, 2, 610607, '520525000000', '纳雍县', '贵州,毕节,纳雍', '105.382715', '26.777645', 1);
INSERT INTO `eb_system_city` VALUES (2972, 613369, 2, 610607, '520526000000', '威宁彝族回族苗族自治县', '贵州,毕节,威宁', '104.278740', '26.856210', 1);
INSERT INTO `eb_system_city` VALUES (2973, 614035, 2, 610607, '520527000000', '赫章县', '贵州,毕节,赫章', '104.727418', '27.123079', 1);
INSERT INTO `eb_system_city` VALUES (2974, 614531, 2, 614530, '520601000000', '市辖区', '贵州,铜仁', '109.189598', '27.731514', 1);
INSERT INTO `eb_system_city` VALUES (2975, 614532, 2, 614530, '520602000000', '碧江区', '贵州,铜仁,碧江', '109.181122', '27.690653', 1);
INSERT INTO `eb_system_city` VALUES (2976, 614636, 2, 614530, '520603000000', '万山区', '贵州,铜仁,万山', '109.213644', '27.517896', 1);
INSERT INTO `eb_system_city` VALUES (2977, 614733, 2, 614530, '520621000000', '江口县', '贵州,铜仁,江口', '108.839557', '27.699650', 1);
INSERT INTO `eb_system_city` VALUES (2978, 614900, 2, 614530, '520622000000', '玉屏侗族自治县', '贵州,铜仁,玉屏', '108.914680', '27.243012', 1);
INSERT INTO `eb_system_city` VALUES (2979, 615001, 2, 614530, '520623000000', '石阡县', '贵州,铜仁,石阡', '108.223612', '27.513829', 1);
INSERT INTO `eb_system_city` VALUES (2980, 615331, 2, 614530, '520624000000', '思南县', '贵州,铜仁,思南', '108.253873', '27.937560', 1);
INSERT INTO `eb_system_city` VALUES (2981, 615886, 2, 614530, '520625000000', '印江土家族苗族自治县', '贵州,铜仁,印江', '108.409752', '27.994247', 1);
INSERT INTO `eb_system_city` VALUES (2982, 616278, 2, 614530, '520626000000', '德江县', '贵州,铜仁,德江', '108.119807', '28.263964', 1);
INSERT INTO `eb_system_city` VALUES (2983, 616644, 2, 614530, '520627000000', '沿河土家族自治县', '贵州,铜仁,沿河', '108.503870', '28.563928', 1);
INSERT INTO `eb_system_city` VALUES (2984, 617116, 2, 614530, '520628000000', '松桃苗族自治县', '贵州,铜仁,松桃', '109.202886', '28.154071', 1);
INSERT INTO `eb_system_city` VALUES (2985, 617671, 2, 617670, '522301000000', '兴义市', '贵州,黔西南,兴义', '104.895467', '25.092040', 1);
INSERT INTO `eb_system_city` VALUES (2986, 617923, 2, 617670, '522322000000', '兴仁县', '贵州,黔西南,兴仁', '105.186238', '25.435183', 1);
INSERT INTO `eb_system_city` VALUES (2987, 618102, 2, 617670, '522323000000', '普安县', '贵州,黔西南,普安', '104.953063', '25.784135', 1);
INSERT INTO `eb_system_city` VALUES (2988, 618205, 2, 617670, '522324000000', '晴隆县', '贵州,黔西南,晴隆', '105.218991', '25.834784', 1);
INSERT INTO `eb_system_city` VALUES (2989, 618316, 2, 617670, '522325000000', '贞丰县', '贵州,黔西南,贞丰', '105.649864', '25.385760', 1);
INSERT INTO `eb_system_city` VALUES (2990, 618489, 2, 617670, '522326000000', '望谟县', '贵州,黔西南,望谟', '106.099617', '25.178422', 1);
INSERT INTO `eb_system_city` VALUES (2991, 618671, 2, 617670, '522327000000', '册亨县', '贵州,黔西南,册亨', '105.811593', '24.983663', 1);
INSERT INTO `eb_system_city` VALUES (2992, 618816, 2, 617670, '522328000000', '安龙县', '贵州,黔西南,安龙', '105.442701', '25.099014', 1);
INSERT INTO `eb_system_city` VALUES (2993, 619018, 2, 619017, '522601000000', '凯里市', '贵州,黔东南,凯里', '107.981212', '26.566867', 1);
INSERT INTO `eb_system_city` VALUES (2994, 619308, 2, 619017, '522622000000', '黄平县', '贵州,黔东南,黄平', '107.916412', '26.905396', 1);
INSERT INTO `eb_system_city` VALUES (2995, 619574, 2, 619017, '522623000000', '施秉县', '贵州,黔东南,施秉', '108.124380', '27.032920', 1);
INSERT INTO `eb_system_city` VALUES (2996, 619657, 2, 619017, '522624000000', '三穗县', '贵州,黔东南,三穗', '108.675267', '26.952968', 1);
INSERT INTO `eb_system_city` VALUES (2997, 619831, 2, 619017, '522625000000', '镇远县', '贵州,黔东南,镇远', '108.429691', '27.049110', 1);
INSERT INTO `eb_system_city` VALUES (2998, 619970, 2, 619017, '522626000000', '岑巩县', '贵州,黔东南,岑巩', '108.816060', '27.173887', 1);
INSERT INTO `eb_system_city` VALUES (2999, 620122, 2, 619017, '522627000000', '天柱县', '贵州,黔东南,天柱', '109.207757', '26.909678', 1);
INSERT INTO `eb_system_city` VALUES (3000, 620465, 2, 619017, '522628000000', '锦屏县', '贵州,黔东南,锦屏', '109.200534', '26.676233', 1);
INSERT INTO `eb_system_city` VALUES (3001, 620673, 2, 619017, '522629000000', '剑河县', '贵州,黔东南,剑河', '108.441501', '26.728274', 1);
INSERT INTO `eb_system_city` VALUES (3002, 620996, 2, 619017, '522630000000', '台江县', '贵州,黔东南,台江', '108.321245', '26.667525', 1);
INSERT INTO `eb_system_city` VALUES (3003, 621166, 2, 619017, '522631000000', '黎平县', '贵州,黔东南,黎平', '109.136658', '26.230424', 1);
INSERT INTO `eb_system_city` VALUES (3004, 621616, 2, 619017, '522632000000', '榕江县', '贵州,黔东南,榕江', '108.521881', '25.931893', 1);
INSERT INTO `eb_system_city` VALUES (3005, 621906, 2, 619017, '522633000000', '从江县', '贵州,黔东南,从江', '108.905329', '25.753009', 1);
INSERT INTO `eb_system_city` VALUES (3006, 622312, 2, 619017, '522634000000', '雷山县', '贵州,黔东南,雷山', '108.077540', '26.378443', 1);
INSERT INTO `eb_system_city` VALUES (3007, 622484, 2, 619017, '522635000000', '麻江县', '贵州,黔东南,麻江', '107.589359', '26.491105', 1);
INSERT INTO `eb_system_city` VALUES (3008, 622561, 2, 619017, '522636000000', '丹寨县', '贵州,黔东南,丹寨', '107.788728', '26.198320', 1);
INSERT INTO `eb_system_city` VALUES (3009, 622735, 2, 622734, '522701000000', '都匀市', '贵州,黔南,都匀', '107.518847', '26.259427', 1);
INSERT INTO `eb_system_city` VALUES (3010, 622888, 2, 622734, '522702000000', '福泉市', '贵州,黔南,福泉', '107.520386', '26.686335', 1);
INSERT INTO `eb_system_city` VALUES (3011, 622973, 2, 622734, '522722000000', '荔波县', '贵州,黔南,荔波', '107.886450', '25.410654', 1);
INSERT INTO `eb_system_city` VALUES (3012, 623082, 2, 622734, '522723000000', '贵定县', '贵州,黔南,贵定', '107.232889', '26.557071', 1);
INSERT INTO `eb_system_city` VALUES (3013, 623205, 2, 622734, '522725000000', '瓮安县', '贵州,黔南,瓮安', '107.471555', '27.078472', 1);
INSERT INTO `eb_system_city` VALUES (3014, 623318, 2, 622734, '522726000000', '独山县', '贵州,黔南,独山', '107.545048', '25.822132', 1);
INSERT INTO `eb_system_city` VALUES (3015, 623391, 2, 622734, '522727000000', '平塘县', '贵州,黔南,平塘', '107.323077', '25.831955', 1);
INSERT INTO `eb_system_city` VALUES (3016, 623530, 2, 622734, '522728000000', '罗甸县', '贵州,黔南,罗甸', '106.751418', '25.424845', 1);
INSERT INTO `eb_system_city` VALUES (3017, 623723, 2, 622734, '522729000000', '长顺县', '贵州,黔南,长顺', '106.447376', '26.022116', 1);
INSERT INTO `eb_system_city` VALUES (3018, 623813, 2, 622734, '522730000000', '龙里县', '贵州,黔南,龙里', '106.979524', '26.453154', 1);
INSERT INTO `eb_system_city` VALUES (3019, 623901, 2, 622734, '522731000000', '惠水县', '贵州,黔南,惠水', '106.657089', '26.132061', 1);
INSERT INTO `eb_system_city` VALUES (3020, 624122, 2, 622734, '522732000000', '三都水族自治县', '贵州,黔南,三都', '107.869749', '25.983202', 1);
INSERT INTO `eb_system_city` VALUES (3021, 624374, 2, 624373, '530101000000', '市辖区', '云南,昆明', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3022, 624375, 2, 624373, '530102000000', '五华区', '云南,昆明,五华', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3023, 624486, 2, 624373, '530103000000', '盘龙区', '云南,昆明,盘龙', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3024, 624599, 2, 624373, '530111000000', '官渡区', '云南,昆明,官渡', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3025, 624730, 2, 624373, '530112000000', '西山区', '云南,昆明,西山', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3026, 624860, 2, 624373, '530113000000', '东川区', '云南,昆明,东川', '103.187820', '26.082872', 1);
INSERT INTO `eb_system_city` VALUES (3027, 625034, 2, 624373, '530114000000', '呈贡区', '云南,昆明,呈贡', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3028, 625111, 2, 624373, '530122000000', '晋宁县', '云南,昆明,晋宁', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3029, 625255, 2, 624373, '530124000000', '富民县', '云南,昆明,富民', '102.497681', '25.222046', 1);
INSERT INTO `eb_system_city` VALUES (3030, 625337, 2, 624373, '530125000000', '宜良县', '云南,昆明,宜良', '103.141304', '24.919704', 1);
INSERT INTO `eb_system_city` VALUES (3031, 625486, 2, 624373, '530126000000', '石林彝族自治县', '云南,昆明,石林', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3032, 625585, 2, 624373, '530127000000', '嵩明县', '云南,昆明,嵩明', '103.036911', '25.338642', 1);
INSERT INTO `eb_system_city` VALUES (3033, 625669, 2, 624373, '530128000000', '禄劝彝族苗族自治县', '云南,昆明,禄劝', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3034, 625883, 2, 624373, '530129000000', '寻甸回族彝族自治县', '云南,昆明,寻甸', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3035, 626074, 2, 624373, '530181000000', '安宁市', '云南,昆明,安宁', '102.832891', '24.880095', 1);
INSERT INTO `eb_system_city` VALUES (3036, 626182, 2, 626181, '530301000000', '市辖区', '云南,曲靖', '103.796167', '25.489999', 1);
INSERT INTO `eb_system_city` VALUES (3037, 626183, 2, 626181, '530302000000', '麒麟区', '云南,曲靖,麒麟', '103.805012', '25.495241', 1);
INSERT INTO `eb_system_city` VALUES (3038, 626343, 2, 626181, '530303000000', '沾益区', '云南,曲靖,沾益', '103.822324', '25.600507', 1);
INSERT INTO `eb_system_city` VALUES (3039, 626485, 2, 626181, '530321000000', '马龙县', '云南,曲靖,马龙', '103.578454', '25.428130', 1);
INSERT INTO `eb_system_city` VALUES (3040, 626569, 2, 626181, '530322000000', '陆良县', '云南,曲靖,陆良', '103.666663', '25.030051', 1);
INSERT INTO `eb_system_city` VALUES (3041, 626731, 2, 626181, '530323000000', '师宗县', '云南,曲靖,师宗', '103.985478', '24.822403', 1);
INSERT INTO `eb_system_city` VALUES (3042, 626852, 2, 626181, '530324000000', '罗平县', '云南,曲靖,罗平', '104.308675', '24.884626', 1);
INSERT INTO `eb_system_city` VALUES (3043, 627020, 2, 626181, '530325000000', '富源县', '云南,曲靖,富源', '104.255015', '25.674238', 1);
INSERT INTO `eb_system_city` VALUES (3044, 627194, 2, 626181, '530326000000', '会泽县', '云南,曲靖,会泽', '103.297361', '26.417947', 1);
INSERT INTO `eb_system_city` VALUES (3045, 627596, 2, 626181, '530381000000', '宣威市', '云南,曲靖,宣威', '104.104475', '26.219767', 1);
INSERT INTO `eb_system_city` VALUES (3046, 627982, 2, 627981, '530401000000', '市辖区', '云南,玉溪', '102.546543', '24.352036', 1);
INSERT INTO `eb_system_city` VALUES (3047, 627983, 2, 627981, '530402000000', '红塔区', '云南,玉溪,红塔', '102.540179', '24.341098', 1);
INSERT INTO `eb_system_city` VALUES (3048, 628099, 2, 627981, '530403000000', '江川区', '云南,玉溪,江川', '102.753734', '24.287534', 1);
INSERT INTO `eb_system_city` VALUES (3049, 628181, 2, 627981, '530422000000', '澄江县', '云南,玉溪,澄江', '102.908248', '24.673734', 1);
INSERT INTO `eb_system_city` VALUES (3050, 628228, 2, 627981, '530423000000', '通海县', '云南,玉溪,通海', '102.760039', '24.112205', 1);
INSERT INTO `eb_system_city` VALUES (3051, 628314, 2, 627981, '530424000000', '华宁县', '云南,玉溪,华宁', '102.928835', '24.192761', 1);
INSERT INTO `eb_system_city` VALUES (3052, 628397, 2, 627981, '530425000000', '易门县', '云南,玉溪,易门', '102.162531', '24.671651', 1);
INSERT INTO `eb_system_city` VALUES (3053, 628463, 2, 627981, '530426000000', '峨山彝族自治县', '云南,玉溪,峨山', '102.397333', '24.169401', 1);
INSERT INTO `eb_system_city` VALUES (3054, 628548, 2, 627981, '530427000000', '新平彝族傣族自治县', '云南,玉溪,新平', '101.990157', '24.070051', 1);
INSERT INTO `eb_system_city` VALUES (3055, 628684, 2, 627981, '530428000000', '元江哈尼族彝族傣族自治县', '云南,玉溪,元江', '101.998103', '23.596503', 1);
INSERT INTO `eb_system_city` VALUES (3056, 628777, 2, 628776, '530501000000', '市辖区', '云南,保山', '99.161761', '25.112046', 1);
INSERT INTO `eb_system_city` VALUES (3057, 628778, 2, 628776, '530502000000', '隆阳区', '云南,保山,隆阳', '99.165607', '25.121154', 1);
INSERT INTO `eb_system_city` VALUES (3058, 629117, 2, 628776, '530521000000', '施甸县', '云南,保山,施甸', '99.189221', '24.723064', 1);
INSERT INTO `eb_system_city` VALUES (3059, 629271, 2, 628776, '530523000000', '龙陵县', '云南,保山,龙陵', '98.689230', '24.586766', 1);
INSERT INTO `eb_system_city` VALUES (3060, 629403, 2, 628776, '530524000000', '昌宁县', '云南,保山,昌宁', '99.605142', '24.827839', 1);
INSERT INTO `eb_system_city` VALUES (3061, 629541, 2, 628776, '530581000000', '腾冲市', '云南,保山,腾冲', '98.497291', '25.017570', 1);
INSERT INTO `eb_system_city` VALUES (3062, 629782, 2, 629781, '530601000000', '市辖区', '云南,昭通', '103.717465', '27.338257', 1);
INSERT INTO `eb_system_city` VALUES (3063, 629783, 2, 629781, '530602000000', '昭阳区', '云南,昭通,昭阳', '103.706539', '27.320075', 1);
INSERT INTO `eb_system_city` VALUES (3064, 629988, 2, 629781, '530621000000', '鲁甸县', '云南,昭通,鲁甸', '103.558042', '27.186659', 1);
INSERT INTO `eb_system_city` VALUES (3065, 630098, 2, 629781, '530622000000', '巧家县', '云南,昭通,巧家', '102.930164', '26.908461', 1);
INSERT INTO `eb_system_city` VALUES (3066, 630299, 2, 629781, '530623000000', '盐津县', '云南,昭通,盐津', '104.234442', '28.108710', 1);
INSERT INTO `eb_system_city` VALUES (3067, 630404, 2, 629781, '530624000000', '大关县', '云南,昭通,大关', '103.891146', '27.747978', 1);
INSERT INTO `eb_system_city` VALUES (3068, 630498, 2, 629781, '530625000000', '永善县', '云南,昭通,永善', '103.638067', '28.229113', 1);
INSERT INTO `eb_system_city` VALUES (3069, 630656, 2, 629781, '530626000000', '绥江县', '云南,昭通,绥江', '103.968978', '28.592100', 1);
INSERT INTO `eb_system_city` VALUES (3070, 630704, 2, 629781, '530627000000', '镇雄县', '云南,昭通,镇雄', '104.873579', '27.441668', 1);
INSERT INTO `eb_system_city` VALUES (3071, 630989, 2, 629781, '530628000000', '彝良县', '云南,昭通,彝良', '104.048289', '27.625419', 1);
INSERT INTO `eb_system_city` VALUES (3072, 631144, 2, 629781, '530629000000', '威信县', '云南,昭通,威信', '105.049027', '27.846901', 1);
INSERT INTO `eb_system_city` VALUES (3073, 631242, 2, 629781, '530630000000', '水富县', '云南,昭通,水富', '104.416031', '28.629880', 1);
INSERT INTO `eb_system_city` VALUES (3074, 631277, 2, 631276, '530701000000', '市辖区', '云南,丽江', '100.227750', '26.855047', 1);
INSERT INTO `eb_system_city` VALUES (3075, 631278, 2, 631276, '530702000000', '古城区', '云南,丽江,古城', '100.225766', '26.877190', 1);
INSERT INTO `eb_system_city` VALUES (3076, 631349, 2, 631276, '530721000000', '玉龙纳西族自治县', '云南,丽江,玉龙', '100.236955', '26.821460', 1);
INSERT INTO `eb_system_city` VALUES (3077, 631469, 2, 631276, '530722000000', '永胜县', '云南,丽江,永胜', '100.750795', '26.684225', 1);
INSERT INTO `eb_system_city` VALUES (3078, 631634, 2, 631276, '530723000000', '华坪县', '云南,丽江,华坪', '101.266195', '26.629211', 1);
INSERT INTO `eb_system_city` VALUES (3079, 631704, 2, 631276, '530724000000', '宁蒗彝族自治县', '云南,丽江,宁蒗', '100.852001', '27.282071', 1);
INSERT INTO `eb_system_city` VALUES (3080, 631812, 2, 631811, '530801000000', '市辖区', '云南,普洱', '100.966512', '22.825065', 1);
INSERT INTO `eb_system_city` VALUES (3081, 631813, 2, 631811, '530802000000', '思茅区', '云南,普洱,思茅', '100.977165', '22.786910', 1);
INSERT INTO `eb_system_city` VALUES (3082, 631894, 2, 631811, '530821000000', '宁洱哈尼族彝族自治县', '云南,普洱,宁洱', '100.980485', '22.781242', 1);
INSERT INTO `eb_system_city` VALUES (3083, 631993, 2, 631811, '530822000000', '墨江哈尼族自治县', '云南,普洱,墨江', '101.692461', '23.431894', 1);
INSERT INTO `eb_system_city` VALUES (3084, 632177, 2, 631811, '530823000000', '景东彝族自治县', '云南,普洱,景东', '100.833877', '24.446731', 1);
INSERT INTO `eb_system_city` VALUES (3085, 632361, 2, 631811, '530824000000', '景谷傣族彝族自治县', '云南,普洱,景谷', '100.702871', '23.497028', 1);
INSERT INTO `eb_system_city` VALUES (3086, 632513, 2, 631811, '530825000000', '镇沅彝族哈尼族拉祜族自治县', '云南,普洱,镇沅', '101.108595', '24.004442', 1);
INSERT INTO `eb_system_city` VALUES (3087, 632634, 2, 631811, '530826000000', '江城哈尼族彝族自治县', '云南,普洱,江城', '101.862120', '22.585868', 1);
INSERT INTO `eb_system_city` VALUES (3088, 632693, 2, 631811, '530827000000', '孟连傣族拉祜族佤族自治县', '云南,普洱,孟连', '99.584157', '22.329100', 1);
INSERT INTO `eb_system_city` VALUES (3089, 632742, 2, 631811, '530828000000', '澜沧拉祜族自治县', '云南,普洱,澜沧', '99.931975', '22.555905', 1);
INSERT INTO `eb_system_city` VALUES (3090, 632924, 2, 631811, '530829000000', '西盟佤族自治县', '云南,普洱,西', '100.966512', '22.825065', 1);
INSERT INTO `eb_system_city` VALUES (3091, 632972, 2, 632971, '530901000000', '市辖区', '云南,临沧', '100.079583', '23.877573', 1);
INSERT INTO `eb_system_city` VALUES (3092, 632973, 2, 632971, '530902000000', '临翔区', '云南,临沧,临翔', '100.082523', '23.895137', 1);
INSERT INTO `eb_system_city` VALUES (3093, 633086, 2, 632971, '530921000000', '凤庆县', '云南,临沧,凤庆', '99.928460', '24.580424', 1);
INSERT INTO `eb_system_city` VALUES (3094, 633287, 2, 632971, '530922000000', '云县', '云南,临沧,云县', '100.123248', '24.437061', 1);
INSERT INTO `eb_system_city` VALUES (3095, 633498, 2, 632971, '530923000000', '永德县', '云南,临沧,永德', '99.259340', '24.018357', 1);
INSERT INTO `eb_system_city` VALUES (3096, 633629, 2, 632971, '530924000000', '镇康县', '云南,临沧,镇康', '98.825285', '23.762584', 1);
INSERT INTO `eb_system_city` VALUES (3097, 633711, 2, 632971, '530925000000', '双江拉祜族佤族布朗族傣族自治县', '云南,临沧,双江', '99.827698', '23.473499', 1);
INSERT INTO `eb_system_city` VALUES (3098, 633793, 2, 632971, '530926000000', '耿马傣族佤族自治县', '云南,临沧,耿马', '99.395366', '23.529249', 1);
INSERT INTO `eb_system_city` VALUES (3099, 633898, 2, 632971, '530927000000', '沧源佤族自治县', '云南,临沧,沧源', '99.246197', '23.146712', 1);
INSERT INTO `eb_system_city` VALUES (3100, 634007, 2, 634006, '532301000000', '楚雄市', '云南,楚雄,楚雄', '101.545906', '25.032889', 1);
INSERT INTO `eb_system_city` VALUES (3101, 634176, 2, 634006, '532322000000', '双柏县', '云南,楚雄,双柏', '101.641937', '24.688875', 1);
INSERT INTO `eb_system_city` VALUES (3102, 634269, 2, 634006, '532323000000', '牟定县', '云南,楚雄,牟定', '101.546566', '25.313122', 1);
INSERT INTO `eb_system_city` VALUES (3103, 634366, 2, 634006, '532324000000', '南华县', '云南,楚雄,南华', '101.273577', '25.192293', 1);
INSERT INTO `eb_system_city` VALUES (3104, 634505, 2, 634006, '532325000000', '姚安县', '云南,楚雄,姚安', '101.241728', '25.504173', 1);
INSERT INTO `eb_system_city` VALUES (3105, 634592, 2, 634006, '532326000000', '大姚县', '云南,楚雄,大姚', '101.336617', '25.729513', 1);
INSERT INTO `eb_system_city` VALUES (3106, 634734, 2, 634006, '532327000000', '永仁县', '云南,楚雄,永仁', '101.666133', '26.049464', 1);
INSERT INTO `eb_system_city` VALUES (3107, 634805, 2, 634006, '532328000000', '元谋县', '云南,楚雄,元谋', '101.874520', '25.704338', 1);
INSERT INTO `eb_system_city` VALUES (3108, 634894, 2, 634006, '532329000000', '武定县', '云南,楚雄,武定', '102.404338', '25.530389', 1);
INSERT INTO `eb_system_city` VALUES (3109, 635039, 2, 634006, '532331000000', '禄丰县', '云南,楚雄,禄丰', '102.079027', '25.150111', 1);
INSERT INTO `eb_system_city` VALUES (3110, 635220, 2, 635219, '532501000000', '个旧市', '云南,红河,个旧', '103.160034', '23.359121', 1);
INSERT INTO `eb_system_city` VALUES (3111, 635347, 2, 635219, '532502000000', '开远市', '云南,红河,开远', '103.267143', '23.714316', 1);
INSERT INTO `eb_system_city` VALUES (3112, 635435, 2, 635219, '532503000000', '蒙自市', '云南,红河,蒙自', '103.364905', '23.396201', 1);
INSERT INTO `eb_system_city` VALUES (3113, 635548, 2, 635219, '532504000000', '弥勒市', '云南,红河,弥勒', '103.414874', '24.411912', 1);
INSERT INTO `eb_system_city` VALUES (3114, 635698, 2, 635219, '532523000000', '屏边苗族自治县', '云南,红河,屏边', '103.687612', '22.983560', 1);
INSERT INTO `eb_system_city` VALUES (3115, 635786, 2, 635219, '532524000000', '建水县', '云南,红河,建水', '102.826557', '23.634700', 1);
INSERT INTO `eb_system_city` VALUES (3116, 635955, 2, 635219, '532525000000', '石屏县', '云南,红河,石屏', '102.494984', '23.705936', 1);
INSERT INTO `eb_system_city` VALUES (3117, 636080, 2, 635219, '532527000000', '泸西县', '云南,红河,泸西', '103.766196', '24.532025', 1);
INSERT INTO `eb_system_city` VALUES (3118, 636176, 2, 635219, '532528000000', '元阳县', '云南,红河,元阳', '102.835223', '23.219932', 1);
INSERT INTO `eb_system_city` VALUES (3119, 636329, 2, 635219, '532529000000', '红河县', '云南,红河,红河', '102.420600', '23.369161', 1);
INSERT INTO `eb_system_city` VALUES (3120, 636434, 2, 635219, '532530000000', '金平苗族瑶族傣族自治县', '云南,红河,金平', '103.226448', '22.779543', 1);
INSERT INTO `eb_system_city` VALUES (3121, 636546, 2, 635219, '532531000000', '绿春县', '云南,红河,绿春', '102.392463', '22.993718', 1);
INSERT INTO `eb_system_city` VALUES (3122, 636647, 2, 635219, '532532000000', '河口瑶族自治县', '云南,红河,河口', '103.960560', '22.509593', 1);
INSERT INTO `eb_system_city` VALUES (3123, 636689, 2, 636688, '532601000000', '文山市', '云南,文山,文山', '104.232510', '23.386306', 1);
INSERT INTO `eb_system_city` VALUES (3124, 636850, 2, 636688, '532622000000', '砚山县', '云南,文山,砚山', '104.337244', '23.605740', 1);
INSERT INTO `eb_system_city` VALUES (3125, 636970, 2, 636688, '532623000000', '西畴县', '云南,文山,西畴', '104.672597', '23.437782', 1);
INSERT INTO `eb_system_city` VALUES (3126, 637052, 2, 636688, '532624000000', '麻栗坡县', '云南,文山,麻栗坡', '104.702799', '23.125714', 1);
INSERT INTO `eb_system_city` VALUES (3127, 637166, 2, 636688, '532625000000', '马关县', '云南,文山,马关', '104.394158', '23.012915', 1);
INSERT INTO `eb_system_city` VALUES (3128, 637312, 2, 636688, '532626000000', '丘北县', '云南,文山,丘北', '104.195820', '24.041919', 1);
INSERT INTO `eb_system_city` VALUES (3129, 637426, 2, 636688, '532627000000', '广南县', '云南,文山,广南', '105.054981', '24.045941', 1);
INSERT INTO `eb_system_city` VALUES (3130, 637619, 2, 636688, '532628000000', '富宁县', '云南,文山,富宁', '105.630999', '23.625283', 1);
INSERT INTO `eb_system_city` VALUES (3131, 637779, 2, 637778, '532801000000', '景洪市', '云南,西双版纳,景洪', '100.771679', '22.000143', 1);
INSERT INTO `eb_system_city` VALUES (3132, 637910, 2, 637778, '532822000000', '勐海县', '云南,西双版纳,勐海', '100.452548', '21.957354', 1);
INSERT INTO `eb_system_city` VALUES (3133, 638015, 2, 637778, '532823000000', '勐腊县', '云南,西双版纳,勐腊', '101.564636', '21.459233', 1);
INSERT INTO `eb_system_city` VALUES (3134, 638093, 2, 638092, '532901000000', '大理市', '云南,大理,大理', '100.241369', '25.593067', 1);
INSERT INTO `eb_system_city` VALUES (3135, 638249, 2, 638092, '532922000000', '漾濞彝族自治县', '云南,大理,漾濞', '99.958015', '25.670148', 1);
INSERT INTO `eb_system_city` VALUES (3136, 638325, 2, 638092, '532923000000', '祥云县', '云南,大理,祥云', '100.550946', '25.483850', 1);
INSERT INTO `eb_system_city` VALUES (3137, 638475, 2, 638092, '532924000000', '宾川县', '云南,大理,宾川', '100.575412', '25.827182', 1);
INSERT INTO `eb_system_city` VALUES (3138, 638576, 2, 638092, '532925000000', '弥渡县', '云南,大理,弥渡', '100.490991', '25.343804', 1);
INSERT INTO `eb_system_city` VALUES (3139, 638674, 2, 638092, '532926000000', '南涧彝族自治县', '云南,大理,南涧', '100.509036', '25.043510', 1);
INSERT INTO `eb_system_city` VALUES (3140, 638764, 2, 638092, '532927000000', '巍山彝族回族自治县', '云南,大理,巍山', '100.307175', '25.227212', 1);
INSERT INTO `eb_system_city` VALUES (3141, 638858, 2, 638092, '532928000000', '永平县', '云南,大理,永平', '99.541236', '25.464681', 1);
INSERT INTO `eb_system_city` VALUES (3142, 638941, 2, 638092, '532929000000', '云龙县', '云南,大理,云龙', '99.371121', '25.885596', 1);
INSERT INTO `eb_system_city` VALUES (3143, 639039, 2, 638092, '532930000000', '洱源县', '云南,大理,洱源', '99.951054', '26.111160', 1);
INSERT INTO `eb_system_city` VALUES (3144, 639139, 2, 638092, '532931000000', '剑川县', '云南,大理,剑川', '99.905559', '26.537033', 1);
INSERT INTO `eb_system_city` VALUES (3145, 639241, 2, 638092, '532932000000', '鹤庆县', '云南,大理,鹤庆', '100.176498', '26.560231', 1);
INSERT INTO `eb_system_city` VALUES (3146, 639369, 2, 639368, '533102000000', '瑞丽市', '云南,德宏,瑞丽', '97.855477', '24.017836', 1);
INSERT INTO `eb_system_city` VALUES (3147, 639416, 2, 639368, '533103000000', '芒市', '云南,德宏,芒市', '98.588086', '24.433690', 1);
INSERT INTO `eb_system_city` VALUES (3148, 639524, 2, 639368, '533122000000', '梁河县', '云南,德宏,梁河', '98.296657', '24.804232', 1);
INSERT INTO `eb_system_city` VALUES (3149, 639600, 2, 639368, '533123000000', '盈江县', '云南,德宏,盈江', '97.931955', '24.705211', 1);
INSERT INTO `eb_system_city` VALUES (3150, 639719, 2, 639368, '533124000000', '陇川县', '云南,德宏,陇川', '97.792105', '24.182965', 1);
INSERT INTO `eb_system_city` VALUES (3151, 639803, 2, 639802, '533301000000', '泸水市', '云南,怒江,泸水', '98.853097', '25.852547', 1);
INSERT INTO `eb_system_city` VALUES (3152, 639889, 2, 639802, '533323000000', '福贡县', '云南,怒江,福贡', '98.869132', '26.901832', 1);
INSERT INTO `eb_system_city` VALUES (3153, 639956, 2, 639802, '533324000000', '贡山独龙族怒族自治县', '云南,怒江,贡山', '98.853097', '25.852547', 1);
INSERT INTO `eb_system_city` VALUES (3154, 639990, 2, 639802, '533325000000', '兰坪白族普米族自治县', '云南,怒江,兰坪', '99.416677', '26.453571', 1);
INSERT INTO `eb_system_city` VALUES (3155, 640108, 2, 640107, '533401000000', '香格里拉市', '云南,迪庆,香格里拉', '99.700836', '27.829743', 1);
INSERT INTO `eb_system_city` VALUES (3156, 640184, 2, 640107, '533422000000', '德钦县', '云南,迪庆,德钦', '98.911561', '28.486162', 1);
INSERT INTO `eb_system_city` VALUES (3157, 640239, 2, 640107, '533423000000', '维西傈僳族自治县', '云南,迪庆,维西', '99.287173', '27.177162', 1);
INSERT INTO `eb_system_city` VALUES (3158, 640334, 2, 640333, '540101000000', '市辖区', '西藏,拉萨', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3159, 640335, 2, 640333, '540102000000', '城关区', '西藏,拉萨,城关', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3160, 640399, 2, 640333, '540103000000', '堆龙德庆区', '西藏,拉萨,堆龙德庆', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3161, 640441, 2, 640333, '540121000000', '林周县', '西藏,拉萨,林周', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3162, 640497, 2, 640333, '540122000000', '当雄县', '西藏,拉萨,当雄', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3163, 640534, 2, 640333, '540123000000', '尼木县', '西藏,拉萨,尼木', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3164, 640575, 2, 640333, '540124000000', '曲水县', '西藏,拉萨,曲水', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3165, 640599, 2, 640333, '540126000000', '达孜县', '西藏,拉萨,达孜', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3166, 640626, 2, 640333, '540127000000', '墨竹工卡县', '西藏,拉萨,墨竹工卡', '91.140856', '29.645554', 1);
INSERT INTO `eb_system_city` VALUES (3167, 640676, 2, 640675, '540202000000', '桑珠孜区', '西藏,日喀则,桑珠孜', '88.887270', '29.270389', 1);
INSERT INTO `eb_system_city` VALUES (3168, 640865, 2, 640675, '540221000000', '南木林县', '西藏,日喀则,南木林', '89.099243', '29.682331', 1);
INSERT INTO `eb_system_city` VALUES (3169, 641029, 2, 640675, '540222000000', '江孜县', '西藏,日喀则,江孜', '89.605574', '28.911659', 1);
INSERT INTO `eb_system_city` VALUES (3170, 641204, 2, 640675, '540223000000', '定日县', '西藏,日喀则,定日', '87.126120', '28.658743', 1);
INSERT INTO `eb_system_city` VALUES (3171, 641393, 2, 640675, '540224000000', '萨迦县', '西藏,日喀则,萨迦', '88.021674', '28.899664', 1);
INSERT INTO `eb_system_city` VALUES (3172, 641512, 2, 640675, '540225000000', '拉孜县', '西藏,日喀则,拉孜', '87.637041', '29.081660', 1);
INSERT INTO `eb_system_city` VALUES (3173, 641622, 2, 640675, '540226000000', '昂仁县', '西藏,日喀则,昂仁', '87.236051', '29.294802', 1);
INSERT INTO `eb_system_city` VALUES (3174, 641825, 2, 640675, '540227000000', '谢通门县', '西藏,日喀则,谢通门', '88.261620', '29.432641', 1);
INSERT INTO `eb_system_city` VALUES (3175, 641940, 2, 640675, '540228000000', '白朗县', '西藏,日喀则,白朗', '89.261977', '29.107688', 1);
INSERT INTO `eb_system_city` VALUES (3176, 642063, 2, 640675, '540229000000', '仁布县', '西藏,日喀则,仁布', '89.841984', '29.230933', 1);
INSERT INTO `eb_system_city` VALUES (3177, 642146, 2, 640675, '540230000000', '康马县', '西藏,日喀则,康马', '89.681663', '28.555627', 1);
INSERT INTO `eb_system_city` VALUES (3178, 642203, 2, 640675, '540231000000', '定结县', '西藏,日喀则,定结', '87.765872', '28.364159', 1);
INSERT INTO `eb_system_city` VALUES (3179, 642284, 2, 640675, '540232000000', '仲巴县', '西藏,日喀则,仲巴', '84.031530', '29.770279', 1);
INSERT INTO `eb_system_city` VALUES (3180, 642356, 2, 640675, '540233000000', '亚东县', '西藏,日喀则,亚东', '88.907094', '27.484806', 1);
INSERT INTO `eb_system_city` VALUES (3181, 642389, 2, 640675, '540234000000', '吉隆县', '西藏,日喀则,吉隆', '85.297535', '28.852394', 1);
INSERT INTO `eb_system_city` VALUES (3182, 642437, 2, 640675, '540235000000', '聂拉木县', '西藏,日喀则,聂拉木', '85.982237', '28.155186', 1);
INSERT INTO `eb_system_city` VALUES (3183, 642489, 2, 640675, '540236000000', '萨嘎县', '西藏,日喀则,萨嘎', '85.232941', '29.328818', 1);
INSERT INTO `eb_system_city` VALUES (3184, 642536, 2, 640675, '540237000000', '岗巴县', '西藏,日喀则,岗巴', '88.520031', '28.274601', 1);
INSERT INTO `eb_system_city` VALUES (3185, 642572, 2, 642571, '540302000000', '卡若区', '西藏,昌都,卡若', '97.180437', '31.138507', 1);
INSERT INTO `eb_system_city` VALUES (3186, 642755, 2, 642571, '540321000000', '江达县', '西藏,昌都,江达', '98.218430', '31.499202', 1);
INSERT INTO `eb_system_city` VALUES (3187, 642864, 2, 642571, '540322000000', '贡觉县', '西藏,昌都,贡觉', '98.270970', '30.860099', 1);
INSERT INTO `eb_system_city` VALUES (3188, 643026, 2, 642571, '540323000000', '类乌齐县', '西藏,昌都,类乌齐', '96.600246', '31.211601', 1);
INSERT INTO `eb_system_city` VALUES (3189, 643119, 2, 642571, '540324000000', '丁青县', '西藏,昌都,丁青', '95.595761', '31.412405', 1);
INSERT INTO `eb_system_city` VALUES (3190, 643197, 2, 642571, '540325000000', '察雅县', '西藏,昌都,察雅', '97.568752', '30.653943', 1);
INSERT INTO `eb_system_city` VALUES (3191, 643349, 2, 642571, '540326000000', '八宿县', '西藏,昌都,八宿', '96.917836', '30.053209', 1);
INSERT INTO `eb_system_city` VALUES (3192, 643474, 2, 642571, '540327000000', '左贡县', '西藏,昌都,左贡', '97.841022', '29.671069', 1);
INSERT INTO `eb_system_city` VALUES (3193, 643613, 2, 642571, '540328000000', '芒康县', '西藏,昌都,芒康', '98.593113', '29.679908', 1);
INSERT INTO `eb_system_city` VALUES (3194, 643691, 2, 642571, '540329000000', '洛隆县', '西藏,昌都,洛隆', '95.824567', '30.741571', 1);
INSERT INTO `eb_system_city` VALUES (3195, 643769, 2, 642571, '540330000000', '边坝县', '西藏,昌都,边坝', '94.707800', '30.933652', 1);
INSERT INTO `eb_system_city` VALUES (3196, 643864, 2, 643863, '540402000000', '巴宜区', '西藏,林芝,巴宜', '94.360994', '29.653727', 1);
INSERT INTO `eb_system_city` VALUES (3197, 643943, 2, 643863, '540421000000', '工布江达县', '西藏,林芝,工布江达', '93.246077', '29.885280', 1);
INSERT INTO `eb_system_city` VALUES (3198, 644033, 2, 643863, '540422000000', '米林县', '西藏,林芝,米林', '94.213486', '29.215833', 1);
INSERT INTO `eb_system_city` VALUES (3199, 644109, 2, 643863, '540423000000', '墨脱县', '西藏,林芝,墨脱', '95.332241', '29.325734', 1);
INSERT INTO `eb_system_city` VALUES (3200, 644164, 2, 643863, '540424000000', '波密县', '西藏,林芝,波密', '95.768158', '29.858766', 1);
INSERT INTO `eb_system_city` VALUES (3201, 644260, 2, 643863, '540425000000', '察隅县', '西藏,林芝,察隅', '94.361490', '29.649128', 1);
INSERT INTO `eb_system_city` VALUES (3202, 644364, 2, 643863, '540426000000', '朗县', '西藏,林芝,朗县', '93.074702', '29.046337', 1);
INSERT INTO `eb_system_city` VALUES (3203, 644424, 2, 644423, '540501000000', '市辖区', '西藏,山南', '91.117212', '29.646922', 1);
INSERT INTO `eb_system_city` VALUES (3204, 644425, 2, 644423, '540502000000', '乃东区', '西藏,山南,乃东', '91.761539', '29.224904', 1);
INSERT INTO `eb_system_city` VALUES (3205, 644480, 2, 644423, '540521000000', '扎囊县', '西藏,山南,扎囊', '91.337250', '29.245114', 1);
INSERT INTO `eb_system_city` VALUES (3206, 644548, 2, 644423, '540522000000', '贡嘎县', '西藏,山南,贡嘎', '90.984140', '29.289455', 1);
INSERT INTO `eb_system_city` VALUES (3207, 644600, 2, 644423, '540523000000', '桑日县', '西藏,山南,桑日', '92.015818', '29.259189', 1);
INSERT INTO `eb_system_city` VALUES (3208, 644647, 2, 644423, '540524000000', '琼结县', '西藏,山南,琼结', '91.683881', '29.024625', 1);
INSERT INTO `eb_system_city` VALUES (3209, 644672, 2, 644423, '540525000000', '曲松县', '西藏,山南,曲松', '92.203739', '29.062826', 1);
INSERT INTO `eb_system_city` VALUES (3210, 644699, 2, 644423, '540526000000', '措美县', '西藏,山南,措美', '91.433509', '28.438202', 1);
INSERT INTO `eb_system_city` VALUES (3211, 644720, 2, 644423, '540527000000', '洛扎县', '西藏,山南,洛扎', '90.859992', '28.385713', 1);
INSERT INTO `eb_system_city` VALUES (3212, 644755, 2, 644423, '540528000000', '加查县', '西藏,山南,加查', '92.593993', '29.140290', 1);
INSERT INTO `eb_system_city` VALUES (3213, 644840, 2, 644423, '540529000000', '隆子县', '西藏,山南,隆子', '92.463305', '28.408552', 1);
INSERT INTO `eb_system_city` VALUES (3214, 644932, 2, 644423, '540530000000', '错那县', '西藏,山南,错那', '91.960139', '27.991716', 1);
INSERT INTO `eb_system_city` VALUES (3215, 644967, 2, 644423, '540531000000', '浪卡子县', '西藏,山南,浪卡子', '90.397977', '28.968031', 1);
INSERT INTO `eb_system_city` VALUES (3216, 645077, 2, 645076, '542421000000', '那曲县', '西藏,那曲,那曲', '92.053500', '31.469643', 1);
INSERT INTO `eb_system_city` VALUES (3217, 645231, 2, 645076, '542422000000', '嘉黎县', '西藏,那曲,嘉黎', '93.232528', '30.640815', 1);
INSERT INTO `eb_system_city` VALUES (3218, 645364, 2, 645076, '542423000000', '比如县', '西藏,那曲,比如', '93.679639', '31.480250', 1);
INSERT INTO `eb_system_city` VALUES (3219, 645550, 2, 645076, '542424000000', '聂荣县', '西藏,那曲,聂荣', '92.303346', '32.107772', 1);
INSERT INTO `eb_system_city` VALUES (3220, 645703, 2, 645076, '542425000000', '安多县', '西藏,那曲,安多', '91.682330', '32.265176', 1);
INSERT INTO `eb_system_city` VALUES (3221, 645791, 2, 645076, '542426000000', '申扎县', '西藏,那曲,申扎', '88.709853', '30.930505', 1);
INSERT INTO `eb_system_city` VALUES (3222, 645862, 2, 645076, '542427000000', '索县', '西藏,那曲,索县', '93.785631', '31.886918', 1);
INSERT INTO `eb_system_city` VALUES (3223, 645997, 2, 645076, '542428000000', '班戈县', '西藏,那曲,班戈', '90.009957', '31.392411', 1);
INSERT INTO `eb_system_city` VALUES (3224, 646094, 2, 645076, '542429000000', '巴青县', '西藏,那曲,巴青', '94.053463', '31.918563', 1);
INSERT INTO `eb_system_city` VALUES (3225, 646261, 2, 645076, '542430000000', '尼玛县', '西藏,那曲,尼玛', '87.236772', '31.784701', 1);
INSERT INTO `eb_system_city` VALUES (3226, 646353, 2, 645076, '542431000000', '双湖县', '西藏,那曲,双湖', '88.837642', '33.188515', 1);
INSERT INTO `eb_system_city` VALUES (3227, 646393, 2, 646392, '542521000000', '普兰县', '西藏,阿里,普兰', '81.176237', '30.294402', 1);
INSERT INTO `eb_system_city` VALUES (3228, 646407, 2, 646392, '542522000000', '札达县', '西藏,阿里,札达', '79.802706', '31.479217', 1);
INSERT INTO `eb_system_city` VALUES (3229, 646431, 2, 646392, '542523000000', '噶尔县', '西藏,阿里,噶尔', '80.096419', '32.491488', 1);
INSERT INTO `eb_system_city` VALUES (3230, 646451, 2, 646392, '542524000000', '日土县', '西藏,阿里,日土', '79.732427', '33.381359', 1);
INSERT INTO `eb_system_city` VALUES (3231, 646470, 2, 646392, '542525000000', '革吉县', '西藏,阿里,革吉', '81.145433', '32.387233', 1);
INSERT INTO `eb_system_city` VALUES (3232, 646495, 2, 646392, '542526000000', '改则县', '西藏,阿里,改则', '84.062590', '32.302713', 1);
INSERT INTO `eb_system_city` VALUES (3233, 646551, 2, 646392, '542527000000', '措勤县', '西藏,阿里,措勤', '85.159494', '31.016769', 1);
INSERT INTO `eb_system_city` VALUES (3234, 646580, 2, 646579, '610101000000', '市辖区', '陕西,西安', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3235, 646581, 2, 646579, '610102000000', '新城区', '陕西,西安,新城', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3236, 646694, 2, 646579, '610103000000', '碑林区', '陕西,西安,碑林', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3237, 646800, 2, 646579, '610104000000', '莲湖区', '陕西,西安,莲湖', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3238, 646944, 2, 646579, '610111000000', '灞桥区', '陕西,西安,灞桥', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3239, 647214, 2, 646579, '610112000000', '未央区', '陕西,西安,未央', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3240, 647486, 2, 646579, '610113000000', '雁塔区', '陕西,西安,雁塔', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3241, 647710, 2, 646579, '610114000000', '阎良区', '陕西,西安,阎良', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3242, 647821, 2, 646579, '610115000000', '临潼区', '陕西,西安,临潼', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3243, 648113, 2, 646579, '610116000000', '长安区', '陕西,西安,长安', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3244, 648645, 2, 646579, '610117000000', '高陵区', '陕西,西安,高陵', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3245, 648756, 2, 646579, '610122000000', '蓝田县', '陕西,西安,蓝田', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3246, 649123, 2, 646579, '610124000000', '周至县', '陕西,西安,周至', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3247, 649424, 2, 646579, '610125000000', '户县', '陕西,西安,户县', '108.940174', '34.341568', 1);
INSERT INTO `eb_system_city` VALUES (3248, 649980, 2, 649979, '610201000000', '市辖区', '陕西,铜川', '108.945233', '34.896756', 1);
INSERT INTO `eb_system_city` VALUES (3249, 649981, 2, 649979, '610202000000', '王益区', '陕西,铜川,王益', '109.075578', '35.068964', 1);
INSERT INTO `eb_system_city` VALUES (3250, 650048, 2, 649979, '610203000000', '印台区', '陕西,铜川,印台', '109.099975', '35.114492', 1);
INSERT INTO `eb_system_city` VALUES (3251, 650189, 2, 649979, '610204000000', '耀州区', '陕西,铜川,耀州', '108.980514', '34.908916', 1);
INSERT INTO `eb_system_city` VALUES (3252, 650386, 2, 649979, '610222000000', '宜君县', '陕西,铜川,宜君', '109.116932', '35.398577', 1);
INSERT INTO `eb_system_city` VALUES (3253, 650576, 2, 650575, '610301000000', '市辖区', '陕西,宝鸡', '107.237974', '34.361979', 1);
INSERT INTO `eb_system_city` VALUES (3254, 650577, 2, 650575, '610302000000', '渭滨区', '陕西,宝鸡,渭滨', '107.149968', '34.371184', 1);
INSERT INTO `eb_system_city` VALUES (3255, 650747, 2, 650575, '610303000000', '金台区', '陕西,宝鸡,金台', '107.146806', '34.376069', 1);
INSERT INTO `eb_system_city` VALUES (3256, 650913, 2, 650575, '610304000000', '陈仓区', '陕西,宝鸡,陈仓', '107.387436', '34.354456', 1);
INSERT INTO `eb_system_city` VALUES (3257, 651278, 2, 650575, '610322000000', '凤翔县', '陕西,宝鸡,凤翔', '107.400737', '34.521218', 1);
INSERT INTO `eb_system_city` VALUES (3258, 651528, 2, 650575, '610323000000', '岐山县', '陕西,宝鸡,岐山', '107.621054', '34.443459', 1);
INSERT INTO `eb_system_city` VALUES (3259, 651697, 2, 650575, '610324000000', '扶风县', '陕西,宝鸡,扶风', '107.900219', '34.375411', 1);
INSERT INTO `eb_system_city` VALUES (3260, 651872, 2, 650575, '610326000000', '眉县', '陕西,宝鸡,眉县', '107.749767', '34.274247', 1);
INSERT INTO `eb_system_city` VALUES (3261, 652014, 2, 650575, '610327000000', '陇县', '陕西,宝鸡,陇县', '106.864397', '34.893050', 1);
INSERT INTO `eb_system_city` VALUES (3262, 652186, 2, 650575, '610328000000', '千阳县', '陕西,宝鸡,千阳', '107.132442', '34.642381', 1);
INSERT INTO `eb_system_city` VALUES (3263, 652294, 2, 650575, '610329000000', '麟游县', '陕西,宝鸡,麟游', '107.793525', '34.677902', 1);
INSERT INTO `eb_system_city` VALUES (3264, 652387, 2, 650575, '610330000000', '凤县', '陕西,宝鸡,凤县', '106.515756', '33.908469', 1);
INSERT INTO `eb_system_city` VALUES (3265, 652505, 2, 650575, '610331000000', '太白县', '陕西,宝鸡,太白', '107.319116', '34.058401', 1);
INSERT INTO `eb_system_city` VALUES (3266, 652582, 2, 652581, '610401000000', '市辖区', '陕西,咸阳', '108.708991', '34.329605', 1);
INSERT INTO `eb_system_city` VALUES (3267, 652583, 2, 652581, '610402000000', '秦都区', '陕西,咸阳,秦都', '108.706272', '34.329567', 1);
INSERT INTO `eb_system_city` VALUES (3268, 652779, 2, 652581, '610403000000', '杨陵区', '陕西,咸阳,杨陵', '108.084732', '34.272117', 1);
INSERT INTO `eb_system_city` VALUES (3269, 652863, 2, 652581, '610404000000', '渭城区', '陕西,咸阳,渭城', '108.737213', '34.361988', 1);
INSERT INTO `eb_system_city` VALUES (3270, 653042, 2, 652581, '610422000000', '三原县', '陕西,咸阳,三原', '108.940509', '34.617382', 1);
INSERT INTO `eb_system_city` VALUES (3271, 653234, 2, 652581, '610423000000', '泾阳县', '陕西,咸阳,泾阳', '108.842623', '34.527114', 1);
INSERT INTO `eb_system_city` VALUES (3272, 653470, 2, 652581, '610424000000', '乾县', '陕西,咸阳,乾县', '108.239473', '34.527551', 1);
INSERT INTO `eb_system_city` VALUES (3273, 653679, 2, 652581, '610425000000', '礼泉县', '陕西,咸阳,礼泉', '108.425018', '34.481764', 1);
INSERT INTO `eb_system_city` VALUES (3274, 653918, 2, 652581, '610426000000', '永寿县', '陕西,咸阳,永寿', '108.142311', '34.691979', 1);
INSERT INTO `eb_system_city` VALUES (3275, 654101, 2, 652581, '610427000000', '彬县', '陕西,咸阳,彬县', '108.077658', '35.043911', 1);
INSERT INTO `eb_system_city` VALUES (3276, 654369, 2, 652581, '610428000000', '长武县', '陕西,咸阳,长武', '107.798757', '35.205886', 1);
INSERT INTO `eb_system_city` VALUES (3277, 654525, 2, 652581, '610429000000', '旬邑县', '陕西,咸阳,旬邑', '108.333986', '35.111978', 1);
INSERT INTO `eb_system_city` VALUES (3278, 654661, 2, 652581, '610430000000', '淳化县', '陕西,咸阳,淳化', '108.580681', '34.799250', 1);
INSERT INTO `eb_system_city` VALUES (3279, 654876, 2, 652581, '610431000000', '武功县', '陕西,咸阳,武功', '108.200398', '34.260204', 1);
INSERT INTO `eb_system_city` VALUES (3280, 655081, 2, 652581, '610481000000', '兴平市', '陕西,咸阳,兴平', '108.490475', '34.299221', 1);
INSERT INTO `eb_system_city` VALUES (3281, 655296, 2, 655295, '610501000000', '市辖区', '陕西,渭南', '109.509786', '34.499995', 1);
INSERT INTO `eb_system_city` VALUES (3282, 655297, 2, 655295, '610502000000', '临渭区', '陕西,渭南,临渭', '109.492726', '34.498192', 1);
INSERT INTO `eb_system_city` VALUES (3283, 655724, 2, 655295, '610503000000', '华州区', '陕西,渭南,华州', '109.761417', '34.511949', 1);
INSERT INTO `eb_system_city` VALUES (3284, 655885, 2, 655295, '610522000000', '潼关县', '陕西,渭南,潼关', '110.246350', '34.544296', 1);
INSERT INTO `eb_system_city` VALUES (3285, 655919, 2, 655295, '610523000000', '大荔县', '陕西,渭南,大荔', '109.941658', '34.797184', 1);
INSERT INTO `eb_system_city` VALUES (3286, 656260, 2, 655295, '610524000000', '合阳县', '陕西,渭南,合阳', '110.149466', '35.237986', 1);
INSERT INTO `eb_system_city` VALUES (3287, 656494, 2, 655295, '610525000000', '澄城县', '陕西,渭南,澄城', '109.932350', '35.190245', 1);
INSERT INTO `eb_system_city` VALUES (3288, 656682, 2, 655295, '610526000000', '蒲城县', '陕西,渭南,蒲城', '109.586506', '34.955855', 1);
INSERT INTO `eb_system_city` VALUES (3289, 656988, 2, 655295, '610527000000', '白水县', '陕西,渭南,白水', '109.590671', '35.177452', 1);
INSERT INTO `eb_system_city` VALUES (3290, 657132, 2, 655295, '610528000000', '富平县', '陕西,渭南,富平', '109.180331', '34.751086', 1);
INSERT INTO `eb_system_city` VALUES (3291, 657425, 2, 655295, '610581000000', '韩城市', '陕西,渭南,韩城', '110.442847', '35.476788', 1);
INSERT INTO `eb_system_city` VALUES (3292, 657706, 2, 655295, '610582000000', '华阴市', '陕西,渭南,华阴', '110.092301', '34.566096', 1);
INSERT INTO `eb_system_city` VALUES (3293, 657849, 2, 657848, '610601000000', '市辖区', '陕西,延安', '109.489727', '36.585455', 1);
INSERT INTO `eb_system_city` VALUES (3294, 657850, 2, 657848, '610602000000', '宝塔区', '陕西,延安,宝塔', '109.493106', '36.591266', 1);
INSERT INTO `eb_system_city` VALUES (3295, 658235, 2, 657848, '610603000000', '安塞区', '陕西,延安,安塞', '109.489727', '36.585455', 1);
INSERT INTO `eb_system_city` VALUES (3296, 658462, 2, 657848, '610621000000', '延长县', '陕西,延安,延长', '110.012334', '36.579313', 1);
INSERT INTO `eb_system_city` VALUES (3297, 658765, 2, 657848, '610622000000', '延川县', '陕西,延安,延川', '110.193514', '36.878117', 1);
INSERT INTO `eb_system_city` VALUES (3298, 658951, 2, 657848, '610623000000', '子长县', '陕西,延安,子长', '109.675234', '37.142668', 1);
INSERT INTO `eb_system_city` VALUES (3299, 659327, 2, 657848, '610625000000', '志丹县', '陕西,延安,志丹', '108.768432', '36.822194', 1);
INSERT INTO `eb_system_city` VALUES (3300, 659450, 2, 657848, '610626000000', '吴起县', '陕西,延安,吴起', '108.175933', '36.927216', 1);
INSERT INTO `eb_system_city` VALUES (3301, 659554, 2, 657848, '610627000000', '甘泉县', '陕西,延安,甘泉', '109.351020', '36.276526', 1);
INSERT INTO `eb_system_city` VALUES (3302, 659632, 2, 657848, '610628000000', '富县', '陕西,延安,富县', '109.379711', '35.988010', 1);
INSERT INTO `eb_system_city` VALUES (3303, 659777, 2, 657848, '610629000000', '洛川县', '陕西,延安,洛川', '109.432369', '35.761975', 1);
INSERT INTO `eb_system_city` VALUES (3304, 660160, 2, 657848, '610630000000', '宜川县', '陕西,延安,宜川', '110.168963', '36.050178', 1);
INSERT INTO `eb_system_city` VALUES (3305, 660375, 2, 657848, '610631000000', '黄龙县', '陕西,延安,黄龙', '109.840373', '35.584467', 1);
INSERT INTO `eb_system_city` VALUES (3306, 660433, 2, 657848, '610632000000', '黄陵县', '陕西,延安,黄陵', '109.262961', '35.579428', 1);
INSERT INTO `eb_system_city` VALUES (3307, 660644, 2, 660643, '610701000000', '市辖区', '陕西,汉中', '107.023323', '33.067480', 1);
INSERT INTO `eb_system_city` VALUES (3308, 660645, 2, 660643, '610702000000', '汉台区', '陕西,汉中,汉台', '107.031856', '33.067771', 1);
INSERT INTO `eb_system_city` VALUES (3309, 660909, 2, 660643, '610721000000', '南郑县', '陕西,汉中,南郑', '106.936230', '32.999334', 1);
INSERT INTO `eb_system_city` VALUES (3310, 661244, 2, 660643, '610722000000', '城固县', '陕西,汉中,城固', '107.333930', '33.157131', 1);
INSERT INTO `eb_system_city` VALUES (3311, 661535, 2, 660643, '610723000000', '洋县', '陕西,汉中,洋县', '107.545837', '33.222739', 1);
INSERT INTO `eb_system_city` VALUES (3312, 661839, 2, 660643, '610724000000', '西乡县', '陕西,汉中,西乡', '107.766614', '32.983101', 1);
INSERT INTO `eb_system_city` VALUES (3313, 662072, 2, 660643, '610725000000', '勉县', '陕西,汉中,勉县', '106.673221', '33.153553', 1);
INSERT INTO `eb_system_city` VALUES (3314, 662289, 2, 660643, '610726000000', '宁强县', '陕西,汉中,宁强', '106.257171', '32.829694', 1);
INSERT INTO `eb_system_city` VALUES (3315, 662521, 2, 660643, '610727000000', '略阳县', '陕西,汉中,略阳', '106.156718', '33.327281', 1);
INSERT INTO `eb_system_city` VALUES (3316, 662704, 2, 660643, '610728000000', '镇巴县', '陕西,汉中,镇巴', '107.895035', '32.536704', 1);
INSERT INTO `eb_system_city` VALUES (3317, 662908, 2, 660643, '610729000000', '留坝县', '陕西,汉中,留坝', '106.920808', '33.617571', 1);
INSERT INTO `eb_system_city` VALUES (3318, 662993, 2, 660643, '610730000000', '佛坪县', '陕西,汉中,佛坪', '107.990539', '33.524359', 1);
INSERT INTO `eb_system_city` VALUES (3319, 663047, 2, 663046, '610801000000', '市辖区', '陕西,榆林', '109.734589', '38.285390', 1);
INSERT INTO `eb_system_city` VALUES (3320, 663048, 2, 663046, '610802000000', '榆阳区', '陕西,榆林,榆阳', '109.720309', '38.277029', 1);
INSERT INTO `eb_system_city` VALUES (3321, 663445, 2, 663046, '610803000000', '横山区', '陕西,榆林,横山', '109.294346', '37.962209', 1);
INSERT INTO `eb_system_city` VALUES (3322, 663827, 2, 663046, '610821000000', '神木县', '陕西,榆林,神木', '110.498868', '38.842498', 1);
INSERT INTO `eb_system_city` VALUES (3323, 664184, 2, 663046, '610822000000', '府谷县', '陕西,榆林,府谷', '111.067366', '39.028116', 1);
INSERT INTO `eb_system_city` VALUES (3324, 664441, 2, 663046, '610824000000', '靖边县', '陕西,榆林,靖边', '108.793988', '37.599438', 1);
INSERT INTO `eb_system_city` VALUES (3325, 664686, 2, 663046, '610825000000', '定边县', '陕西,榆林,定边', '107.601267', '37.594612', 1);
INSERT INTO `eb_system_city` VALUES (3326, 665047, 2, 663046, '610826000000', '绥德县', '陕西,榆林,绥德', '110.263362', '37.502940', 1);
INSERT INTO `eb_system_city` VALUES (3327, 665732, 2, 663046, '610827000000', '米脂县', '陕西,榆林,米脂', '110.183754', '37.755417', 1);
INSERT INTO `eb_system_city` VALUES (3328, 665953, 2, 663046, '610828000000', '佳县', '陕西,榆林,佳县', '110.491345', '38.019511', 1);
INSERT INTO `eb_system_city` VALUES (3329, 666627, 2, 663046, '610829000000', '吴堡县', '陕西,榆林,吴堡', '110.739673', '37.452068', 1);
INSERT INTO `eb_system_city` VALUES (3330, 666741, 2, 663046, '610830000000', '清涧县', '陕西,榆林,清涧', '110.121209', '37.088878', 1);
INSERT INTO `eb_system_city` VALUES (3331, 667106, 2, 663046, '610831000000', '子洲县', '陕西,榆林,子洲', '110.035250', '37.610683', 1);
INSERT INTO `eb_system_city` VALUES (3332, 667682, 2, 667681, '610901000000', '市辖区', '陕西,安康', '109.029022', '32.684714', 1);
INSERT INTO `eb_system_city` VALUES (3333, 667683, 2, 667681, '610902000000', '汉滨区', '陕西,安康,汉滨', '109.026836', '32.695173', 1);
INSERT INTO `eb_system_city` VALUES (3334, 668237, 2, 667681, '610921000000', '汉阴县', '陕西,安康,汉阴', '108.508745', '32.893026', 1);
INSERT INTO `eb_system_city` VALUES (3335, 668397, 2, 667681, '610922000000', '石泉县', '陕西,安康,石泉', '108.247887', '33.038408', 1);
INSERT INTO `eb_system_city` VALUES (3336, 668570, 2, 667681, '610923000000', '宁陕县', '陕西,安康,宁陕', '108.314283', '33.310527', 1);
INSERT INTO `eb_system_city` VALUES (3337, 668662, 2, 667681, '610924000000', '紫阳县', '陕西,安康,紫阳', '108.534229', '32.520246', 1);
INSERT INTO `eb_system_city` VALUES (3338, 668877, 2, 667681, '610925000000', '岚皋县', '陕西,安康,岚皋', '108.902049', '32.307001', 1);
INSERT INTO `eb_system_city` VALUES (3339, 669026, 2, 667681, '610926000000', '平利县', '陕西,安康,平利', '109.361864', '32.388854', 1);
INSERT INTO `eb_system_city` VALUES (3340, 669181, 2, 667681, '610927000000', '镇坪县', '陕西,安康,镇坪', '109.526873', '31.883672', 1);
INSERT INTO `eb_system_city` VALUES (3341, 669251, 2, 667681, '610928000000', '旬阳县', '陕西,安康,旬阳', '109.365265', '32.834086', 1);
INSERT INTO `eb_system_city` VALUES (3342, 669578, 2, 667681, '610929000000', '白河县', '陕西,安康,白河', '110.112629', '32.809026', 1);
INSERT INTO `eb_system_city` VALUES (3343, 669708, 2, 669707, '611001000000', '市辖区', '陕西,商洛', '109.940477', '33.870422', 1);
INSERT INTO `eb_system_city` VALUES (3344, 669709, 2, 669707, '611002000000', '商州区', '陕西,商洛,商州', '109.941241', '33.862703', 1);
INSERT INTO `eb_system_city` VALUES (3345, 670030, 2, 669707, '611021000000', '洛南县', '陕西,商洛,洛南', '110.148509', '34.090838', 1);
INSERT INTO `eb_system_city` VALUES (3346, 670291, 2, 669707, '611022000000', '丹凤县', '陕西,商洛,丹凤', '110.327331', '33.695783', 1);
INSERT INTO `eb_system_city` VALUES (3347, 670459, 2, 669707, '611023000000', '商南县', '陕西,商洛,商南', '110.881807', '33.530995', 1);
INSERT INTO `eb_system_city` VALUES (3348, 670594, 2, 669707, '611024000000', '山阳县', '陕西,商洛,山阳', '109.882290', '33.532172', 1);
INSERT INTO `eb_system_city` VALUES (3349, 670852, 2, 669707, '611025000000', '镇安县', '陕西,商洛,镇安', '109.152893', '33.423357', 1);
INSERT INTO `eb_system_city` VALUES (3350, 671028, 2, 669707, '611026000000', '柞水县', '陕西,商洛,柞水', '109.114207', '33.686110', 1);
INSERT INTO `eb_system_city` VALUES (3351, 671121, 2, 671120, '620101000000', '市辖区', '甘肃,兰州', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3352, 671122, 2, 671120, '620102000000', '城关区', '甘肃,兰州,城关', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3353, 671324, 2, 671120, '620103000000', '七里河区', '甘肃,兰州,七里河', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3354, 671477, 2, 671120, '620104000000', '西固区', '甘肃,兰州,西固', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3355, 671606, 2, 671120, '620105000000', '安宁区', '甘肃,兰州,安宁', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3356, 671675, 2, 671120, '620111000000', '红古区', '甘肃,兰州,红古', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3357, 671740, 2, 671120, '620121000000', '永登县', '甘肃,兰州,永登', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3358, 671967, 2, 671120, '620122000000', '皋兰县', '甘肃,兰州,皋兰', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3359, 672034, 2, 671120, '620123000000', '榆中县', '甘肃,兰州,榆中', '103.834303', '36.061089', 1);
INSERT INTO `eb_system_city` VALUES (3360, 672331, 2, 672330, '620201000000', '市辖区', '甘肃,嘉峪关', '98.289152', '39.773130', 1);
INSERT INTO `eb_system_city` VALUES (3361, 672386, 2, 672385, '620301000000', '市辖区', '甘肃,金昌', '102.188043', '38.520089', 1);
INSERT INTO `eb_system_city` VALUES (3362, 672387, 2, 672385, '620302000000', '金川区', '甘肃,金昌,金川', '102.194089', '38.521085', 1);
INSERT INTO `eb_system_city` VALUES (3363, 672439, 2, 672385, '620321000000', '永昌县', '甘肃,金昌,永昌', '101.984649', '38.243170', 1);
INSERT INTO `eb_system_city` VALUES (3364, 672578, 2, 672577, '620401000000', '市辖区', '甘肃,白银', '104.138559', '36.544756', 1);
INSERT INTO `eb_system_city` VALUES (3365, 672579, 2, 672577, '620402000000', '白银区', '甘肃,白银,白银', '104.148556', '36.535398', 1);
INSERT INTO `eb_system_city` VALUES (3366, 672670, 2, 672577, '620403000000', '平川区', '甘肃,白银,平川', '104.825208', '36.728304', 1);
INSERT INTO `eb_system_city` VALUES (3367, 672773, 2, 672577, '620421000000', '靖远县', '甘肃,白银,靖远', '104.676774', '36.571366', 1);
INSERT INTO `eb_system_city` VALUES (3368, 672978, 2, 672577, '620422000000', '会宁县', '甘肃,白银,会宁', '105.053358', '35.692823', 1);
INSERT INTO `eb_system_city` VALUES (3369, 673307, 2, 672577, '620423000000', '景泰县', '甘肃,白银,景泰', '104.063091', '37.183804', 1);
INSERT INTO `eb_system_city` VALUES (3370, 673464, 2, 673463, '620501000000', '市辖区', '甘肃,天水', '105.724947', '34.580863', 1);
INSERT INTO `eb_system_city` VALUES (3371, 673465, 2, 673463, '620502000000', '秦州区', '甘肃,天水,秦州', '105.724199', '34.580892', 1);
INSERT INTO `eb_system_city` VALUES (3372, 673952, 2, 673463, '620503000000', '麦积区', '甘肃,天水,麦积', '105.889557', '34.570384', 1);
INSERT INTO `eb_system_city` VALUES (3373, 674399, 2, 673463, '620521000000', '清水县', '甘肃,天水,清水', '106.137293', '34.749865', 1);
INSERT INTO `eb_system_city` VALUES (3374, 674684, 2, 673463, '620522000000', '秦安县', '甘肃,天水,秦安', '105.674983', '34.858916', 1);
INSERT INTO `eb_system_city` VALUES (3375, 675138, 2, 673463, '620523000000', '甘谷县', '甘肃,天水,甘谷', '105.340864', '34.745465', 1);
INSERT INTO `eb_system_city` VALUES (3376, 675568, 2, 673463, '620524000000', '武山县', '甘肃,天水,武山', '104.890782', '34.721380', 1);
INSERT INTO `eb_system_city` VALUES (3377, 675938, 2, 673463, '620525000000', '张家川回族自治县', '甘肃,天水,张家川', '106.204518', '34.988037', 1);
INSERT INTO `eb_system_city` VALUES (3378, 676216, 2, 676215, '620601000000', '市辖区', '甘肃,武威', '102.638011', '37.928264', 1);
INSERT INTO `eb_system_city` VALUES (3379, 676217, 2, 676215, '620602000000', '凉州区', '甘肃,武威,凉州', '102.642184', '37.928225', 1);
INSERT INTO `eb_system_city` VALUES (3380, 676751, 2, 676215, '620621000000', '民勤县', '甘肃,武威,民勤', '103.093792', '38.624350', 1);
INSERT INTO `eb_system_city` VALUES (3381, 677055, 2, 676215, '620622000000', '古浪县', '甘肃,武威,古浪', '102.897533', '37.470120', 1);
INSERT INTO `eb_system_city` VALUES (3382, 677344, 2, 676215, '620623000000', '天祝藏族自治县', '甘肃,武威,天祝', '103.141757', '36.971740', 1);
INSERT INTO `eb_system_city` VALUES (3383, 677569, 2, 677568, '620701000000', '市辖区', '甘肃,张掖', '100.449818', '38.925875', 1);
INSERT INTO `eb_system_city` VALUES (3384, 677570, 2, 677568, '620702000000', '甘州区', '甘肃,张掖,甘州', '100.478058', '38.929763', 1);
INSERT INTO `eb_system_city` VALUES (3385, 677865, 2, 677568, '620721000000', '肃南裕固族自治县', '甘肃,张掖,肃南', '99.615601', '38.836932', 1);
INSERT INTO `eb_system_city` VALUES (3386, 677983, 2, 677568, '620722000000', '民乐县', '甘肃,张掖,民乐', '100.812860', '38.430794', 1);
INSERT INTO `eb_system_city` VALUES (3387, 678174, 2, 677568, '620723000000', '临泽县', '甘肃,张掖,临泽', '100.164445', '39.152642', 1);
INSERT INTO `eb_system_city` VALUES (3388, 678270, 2, 677568, '620724000000', '高台县', '甘肃,张掖,高台', '99.819317', '39.377733', 1);
INSERT INTO `eb_system_city` VALUES (3389, 678427, 2, 677568, '620725000000', '山丹县', '甘肃,张掖,山丹', '101.088575', '38.784758', 1);
INSERT INTO `eb_system_city` VALUES (3390, 678561, 2, 678560, '620801000000', '市辖区', '甘肃,平凉', '106.665240', '35.543051', 1);
INSERT INTO `eb_system_city` VALUES (3391, 678562, 2, 678560, '620802000000', '崆峒区', '甘肃,平凉,崆峒', '106.674767', '35.542491', 1);
INSERT INTO `eb_system_city` VALUES (3392, 678825, 2, 678560, '620821000000', '泾川县', '甘肃,平凉,泾川', '107.367850', '35.332666', 1);
INSERT INTO `eb_system_city` VALUES (3393, 679066, 2, 678560, '620822000000', '灵台县', '甘肃,平凉,灵台', '107.621124', '35.065399', 1);
INSERT INTO `eb_system_city` VALUES (3394, 679271, 2, 678560, '620823000000', '崇信县', '甘肃,平凉,崇信', '107.035409', '35.302123', 1);
INSERT INTO `eb_system_city` VALUES (3395, 679368, 2, 678560, '620824000000', '华亭县', '甘肃,平凉,华亭', '106.653158', '35.218292', 1);
INSERT INTO `eb_system_city` VALUES (3396, 679507, 2, 678560, '620825000000', '庄浪县', '甘肃,平凉,庄浪', '106.036687', '35.202385', 1);
INSERT INTO `eb_system_city` VALUES (3397, 679825, 2, 678560, '620826000000', '静宁县', '甘肃,平凉,静宁', '105.732556', '35.521977', 1);
INSERT INTO `eb_system_city` VALUES (3398, 680192, 2, 680191, '620901000000', '市辖区', '甘肃,酒泉', '98.494483', '39.732410', 1);
INSERT INTO `eb_system_city` VALUES (3399, 680193, 2, 680191, '620902000000', '肃州区', '甘肃,酒泉,肃州', '98.507850', '39.745071', 1);
INSERT INTO `eb_system_city` VALUES (3400, 680365, 2, 680191, '620921000000', '金塔县', '甘肃,酒泉,金塔', '98.903270', '39.983599', 1);
INSERT INTO `eb_system_city` VALUES (3401, 680478, 2, 680191, '620922000000', '瓜州县', '甘肃,酒泉,瓜州', '95.782306', '40.520545', 1);
INSERT INTO `eb_system_city` VALUES (3402, 680582, 2, 680191, '620923000000', '肃北蒙古族自治县', '甘肃,酒泉,肃北', '94.876579', '39.512450', 1);
INSERT INTO `eb_system_city` VALUES (3403, 680615, 2, 680191, '620924000000', '阿克塞哈萨克族自治县', '甘肃,酒泉,阿克塞', '94.340204', '39.633943', 1);
INSERT INTO `eb_system_city` VALUES (3404, 680634, 2, 680191, '620981000000', '玉门市', '甘肃,酒泉,玉门', '97.045679', '40.291843', 1);
INSERT INTO `eb_system_city` VALUES (3405, 680736, 2, 680191, '620982000000', '敦煌市', '甘肃,酒泉,敦煌', '94.661967', '40.142128', 1);
INSERT INTO `eb_system_city` VALUES (3406, 680816, 2, 680815, '621001000000', '市辖区', '甘肃,庆阳', '107.643631', '35.709077', 1);
INSERT INTO `eb_system_city` VALUES (3407, 680817, 2, 680815, '621002000000', '西峰区', '甘肃,庆阳,西峰', '107.651077', '35.730652', 1);
INSERT INTO `eb_system_city` VALUES (3408, 680943, 2, 680815, '621021000000', '庆城县', '甘肃,庆阳,庆城', '107.881802', '36.016299', 1);
INSERT INTO `eb_system_city` VALUES (3409, 681132, 2, 680815, '621022000000', '环县', '甘肃,庆阳,环县', '107.308501', '36.568435', 1);
INSERT INTO `eb_system_city` VALUES (3410, 681414, 2, 680815, '621023000000', '华池县', '甘肃,庆阳,华池', '107.990035', '36.461355', 1);
INSERT INTO `eb_system_city` VALUES (3411, 681559, 2, 680815, '621024000000', '合水县', '甘肃,庆阳,合水', '108.019530', '35.819243', 1);
INSERT INTO `eb_system_city` VALUES (3412, 681665, 2, 680815, '621025000000', '正宁县', '甘肃,庆阳,正宁', '108.359976', '35.491890', 1);
INSERT INTO `eb_system_city` VALUES (3413, 681784, 2, 680815, '621026000000', '宁县', '甘肃,庆阳,宁县', '107.928369', '35.502177', 1);
INSERT INTO `eb_system_city` VALUES (3414, 682081, 2, 680815, '621027000000', '镇原县', '甘肃,庆阳,镇原', '107.200832', '35.677462', 1);
INSERT INTO `eb_system_city` VALUES (3415, 682323, 2, 682322, '621101000000', '市辖区', '甘肃,定西', '104.626282', '35.580662', 1);
INSERT INTO `eb_system_city` VALUES (3416, 682324, 2, 682322, '621102000000', '安定区', '甘肃,定西,安定', '104.610668', '35.580629', 1);
INSERT INTO `eb_system_city` VALUES (3417, 682673, 2, 682322, '621121000000', '通渭县', '甘肃,定西,通渭', '105.242061', '35.210831', 1);
INSERT INTO `eb_system_city` VALUES (3418, 683034, 2, 682322, '621122000000', '陇西县', '甘肃,定西,陇西', '104.634984', '35.003940', 1);
INSERT INTO `eb_system_city` VALUES (3419, 683278, 2, 682322, '621123000000', '渭源县', '甘肃,定西,渭源', '104.215467', '35.136755', 1);
INSERT INTO `eb_system_city` VALUES (3420, 683515, 2, 682322, '621124000000', '临洮县', '甘肃,定西,临洮', '103.859565', '35.394989', 1);
INSERT INTO `eb_system_city` VALUES (3421, 683869, 2, 682322, '621125000000', '漳县', '甘肃,定西,漳县', '104.471572', '34.848444', 1);
INSERT INTO `eb_system_city` VALUES (3422, 684024, 2, 682322, '621126000000', '岷县', '甘肃,定西,岷县', '104.036880', '34.438076', 1);
INSERT INTO `eb_system_city` VALUES (3423, 684416, 2, 684415, '621201000000', '市辖区', '甘肃,陇南', '104.921841', '33.400684', 1);
INSERT INTO `eb_system_city` VALUES (3424, 684417, 2, 684415, '621202000000', '武都区', '甘肃,陇南,武都', '104.926337', '33.392211', 1);
INSERT INTO `eb_system_city` VALUES (3425, 685162, 2, 684415, '621221000000', '成县', '甘肃,陇南,成县', '105.742203', '33.750477', 1);
INSERT INTO `eb_system_city` VALUES (3426, 685439, 2, 684415, '621222000000', '文县', '甘肃,陇南,文县', '104.683434', '32.943815', 1);
INSERT INTO `eb_system_city` VALUES (3427, 685772, 2, 684415, '621223000000', '宕昌县', '甘肃,陇南,宕昌', '104.393385', '34.047261', 1);
INSERT INTO `eb_system_city` VALUES (3428, 686138, 2, 684415, '621224000000', '康县', '甘肃,陇南,康县', '105.609169', '33.329136', 1);
INSERT INTO `eb_system_city` VALUES (3429, 686518, 2, 684415, '621225000000', '西和县', '甘肃,陇南,西和', '105.298756', '34.014215', 1);
INSERT INTO `eb_system_city` VALUES (3430, 686933, 2, 684415, '621226000000', '礼县', '甘肃,陇南,礼县', '105.178640', '34.189345', 1);
INSERT INTO `eb_system_city` VALUES (3431, 687542, 2, 684415, '621227000000', '徽县', '甘肃,陇南,徽县', '106.087780', '33.768826', 1);
INSERT INTO `eb_system_city` VALUES (3432, 687781, 2, 684415, '621228000000', '两当县', '甘肃,陇南,两当', '106.304967', '33.908917', 1);
INSERT INTO `eb_system_city` VALUES (3433, 687917, 2, 687916, '622901000000', '临夏市', '甘肃,临夏,临夏', '103.243021', '35.604376', 1);
INSERT INTO `eb_system_city` VALUES (3434, 687999, 2, 687916, '622921000000', '临夏县', '甘肃,临夏,临夏', '103.243021', '35.604376', 1);
INSERT INTO `eb_system_city` VALUES (3435, 688248, 2, 687916, '622922000000', '康乐县', '甘肃,临夏,康乐', '103.708354', '35.370505', 1);
INSERT INTO `eb_system_city` VALUES (3436, 688417, 2, 687916, '622923000000', '永靖县', '甘肃,临夏,永靖', '103.285854', '35.958306', 1);
INSERT INTO `eb_system_city` VALUES (3437, 688588, 2, 687916, '622924000000', '广河县', '甘肃,临夏,广河', '103.575834', '35.488052', 1);
INSERT INTO `eb_system_city` VALUES (3438, 688701, 2, 687916, '622925000000', '和政县', '甘肃,临夏,和政', '103.350997', '35.424603', 1);
INSERT INTO `eb_system_city` VALUES (3439, 688841, 2, 687916, '622926000000', '东乡族自治县', '甘肃,临夏,东乡族自治县', '103.389346', '35.663752', 1);
INSERT INTO `eb_system_city` VALUES (3440, 689096, 2, 687916, '622927000000', '积石山保安族东乡族撒拉族自治县', '甘肃,临夏,积石山', '102.875843', '35.717661', 1);
INSERT INTO `eb_system_city` VALUES (3441, 689266, 2, 689265, '623001000000', '合作市', '甘肃,甘南,合作', '102.910882', '35.000399', 1);
INSERT INTO `eb_system_city` VALUES (3442, 689327, 2, 689265, '623021000000', '临潭县', '甘肃,甘南,临潭', '103.353919', '34.692747', 1);
INSERT INTO `eb_system_city` VALUES (3443, 689488, 2, 689265, '623022000000', '卓尼县', '甘肃,甘南,卓尼', '103.507109', '34.589588', 1);
INSERT INTO `eb_system_city` VALUES (3444, 689610, 2, 689265, '623023000000', '舟曲县', '甘肃,甘南,舟曲', '104.371586', '33.785259', 1);
INSERT INTO `eb_system_city` VALUES (3445, 689845, 2, 689265, '623024000000', '迭部县', '甘肃,甘南,迭部', '103.221870', '34.055939', 1);
INSERT INTO `eb_system_city` VALUES (3446, 689913, 2, 689265, '623025000000', '玛曲县', '甘肃,甘南,玛曲', '102.072698', '33.997712', 1);
INSERT INTO `eb_system_city` VALUES (3447, 689966, 2, 689265, '623026000000', '碌曲县', '甘肃,甘南,碌曲', '102.487327', '34.590944', 1);
INSERT INTO `eb_system_city` VALUES (3448, 690005, 2, 689265, '623027000000', '夏河县', '甘肃,甘南,夏河', '102.521807', '35.202503', 1);
INSERT INTO `eb_system_city` VALUES (3449, 690096, 2, 690095, '630101000000', '市辖区', '青海,西宁', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (3450, 690097, 2, 690095, '630102000000', '城东区', '青海,西宁,城东', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (3451, 690164, 2, 690095, '630103000000', '城中区', '青海,西宁,城中', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (3452, 690235, 2, 690095, '630104000000', '城西区', '青海,西宁,城西', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (3453, 690283, 2, 690095, '630105000000', '城北区', '青海,西宁,城北', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (3454, 690357, 2, 690095, '630121000000', '大通回族土族自治县', '青海,西宁,大通', '101.679987', '36.930717', 1);
INSERT INTO `eb_system_city` VALUES (3455, 690689, 2, 690095, '630122000000', '湟中县', '青海,西宁,湟中', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (3456, 691114, 2, 690095, '630123000000', '湟源县', '青海,西宁,湟源', '101.778228', '36.617144', 1);
INSERT INTO `eb_system_city` VALUES (3457, 691279, 2, 691278, '630202000000', '乐都区', '青海,海东,乐都', '102.401725', '36.482058', 1);
INSERT INTO `eb_system_city` VALUES (3458, 691667, 2, 691278, '630203000000', '平安区', '青海,海东,平安', '102.108835', '36.500563', 1);
INSERT INTO `eb_system_city` VALUES (3459, 691796, 2, 691278, '630222000000', '民和回族土族自治县', '青海,海东,民和', '102.830892', '36.320321', 1);
INSERT INTO `eb_system_city` VALUES (3460, 692148, 2, 691278, '630223000000', '互助土族自治县', '青海,海东,互助', '101.959271', '36.844249', 1);
INSERT INTO `eb_system_city` VALUES (3461, 692479, 2, 691278, '630224000000', '化隆回族自治县', '青海,海东,化隆', '102.264143', '36.094908', 1);
INSERT INTO `eb_system_city` VALUES (3462, 692870, 2, 691278, '630225000000', '循化撒拉族自治县', '青海,海东,循化', '102.485646', '35.848586', 1);
INSERT INTO `eb_system_city` VALUES (3463, 693041, 2, 693040, '632221000000', '门源回族自治县', '青海,海北,门源', '101.622364', '37.376449', 1);
INSERT INTO `eb_system_city` VALUES (3464, 693186, 2, 693040, '632222000000', '祁连县', '青海,海北,祁连', '100.253211', '38.177112', 1);
INSERT INTO `eb_system_city` VALUES (3465, 693243, 2, 693040, '632223000000', '海晏县', '青海,海北,海晏', '100.994430', '36.896467', 1);
INSERT INTO `eb_system_city` VALUES (3466, 693286, 2, 693040, '632224000000', '刚察县', '青海,海北,刚察', '100.145833', '37.325470', 1);
INSERT INTO `eb_system_city` VALUES (3467, 693343, 2, 693342, '632321000000', '同仁县', '青海,黄南,同仁', '102.018323', '35.516063', 1);
INSERT INTO `eb_system_city` VALUES (3468, 693437, 2, 693342, '632322000000', '尖扎县', '青海,黄南,尖扎', '102.031183', '35.938299', 1);
INSERT INTO `eb_system_city` VALUES (3469, 693541, 2, 693342, '632323000000', '泽库县', '青海,黄南,泽库', '101.466689', '35.035313', 1);
INSERT INTO `eb_system_city` VALUES (3470, 693623, 2, 693342, '632324000000', '河南蒙古族自治县', '青海,黄南,河南', '102.015248', '35.519548', 1);
INSERT INTO `eb_system_city` VALUES (3471, 693673, 2, 693672, '632521000000', '共和县', '青海,海南,共和', '100.620031', '36.284107', 1);
INSERT INTO `eb_system_city` VALUES (3472, 693808, 2, 693672, '632522000000', '同德县', '青海,海南,同德', '100.578052', '35.254791', 1);
INSERT INTO `eb_system_city` VALUES (3473, 693906, 2, 693672, '632523000000', '贵德县', '青海,海南,贵德', '101.433298', '36.040150', 1);
INSERT INTO `eb_system_city` VALUES (3474, 694046, 2, 693672, '632524000000', '兴海县', '青海,海南,兴海', '99.987966', '35.588613', 1);
INSERT INTO `eb_system_city` VALUES (3475, 694121, 2, 693672, '632525000000', '贵南县', '青海,海南,贵南', '100.747503', '35.586715', 1);
INSERT INTO `eb_system_city` VALUES (3476, 694221, 2, 694220, '632621000000', '玛沁县', '青海,果洛,玛沁', '100.238888', '34.477433', 1);
INSERT INTO `eb_system_city` VALUES (3477, 694272, 2, 694220, '632622000000', '班玛县', '青海,果洛,班玛', '100.737138', '32.932723', 1);
INSERT INTO `eb_system_city` VALUES (3478, 694315, 2, 694220, '632623000000', '甘德县', '青海,果洛,甘德', '99.900905', '33.969219', 1);
INSERT INTO `eb_system_city` VALUES (3479, 694361, 2, 694220, '632624000000', '达日县', '青海,果洛,达日', '99.651392', '33.748921', 1);
INSERT INTO `eb_system_city` VALUES (3480, 694407, 2, 694220, '632625000000', '久治县', '青海,果洛,久治', '101.482831', '33.429471', 1);
INSERT INTO `eb_system_city` VALUES (3481, 694440, 2, 694220, '632626000000', '玛多县', '青海,果洛,玛多', '98.209206', '34.915946', 1);
INSERT INTO `eb_system_city` VALUES (3482, 694479, 2, 694478, '632701000000', '玉树市', '青海,玉树,玉树', '97.008785', '32.993107', 1);
INSERT INTO `eb_system_city` VALUES (3483, 694572, 2, 694478, '632722000000', '杂多县', '青海,玉树,杂多', '95.300723', '32.893185', 1);
INSERT INTO `eb_system_city` VALUES (3484, 694622, 2, 694478, '632723000000', '称多县', '青海,玉树,称多', '97.110832', '33.369218', 1);
INSERT INTO `eb_system_city` VALUES (3485, 694695, 2, 694478, '632724000000', '治多县', '青海,玉树,治多', '95.613080', '33.852751', 1);
INSERT INTO `eb_system_city` VALUES (3486, 694728, 2, 694478, '632725000000', '囊谦县', '青海,玉树,囊谦', '96.480650', '32.203246', 1);
INSERT INTO `eb_system_city` VALUES (3487, 694816, 2, 694478, '632726000000', '曲麻莱县', '青海,玉树,曲麻莱', '95.797367', '34.126429', 1);
INSERT INTO `eb_system_city` VALUES (3488, 694847, 2, 694846, '632801000000', '格尔木市', '青海,海西,格尔木', '94.928484', '36.406404', 1);
INSERT INTO `eb_system_city` VALUES (3489, 694932, 2, 694846, '632802000000', '德令哈市', '青海,海西,德令哈', '97.360985', '37.369436', 1);
INSERT INTO `eb_system_city` VALUES (3490, 695009, 2, 694846, '632821000000', '乌兰县', '青海,海西,乌兰', '98.480195', '36.929749', 1);
INSERT INTO `eb_system_city` VALUES (3491, 695060, 2, 694846, '632822000000', '都兰县', '青海,海西,都兰', '98.095844', '36.302496', 1);
INSERT INTO `eb_system_city` VALUES (3492, 695184, 2, 694846, '632823000000', '天峻县', '青海,海西,天峻', '99.022984', '37.300851', 1);
INSERT INTO `eb_system_city` VALUES (3493, 695261, 2, 695260, '640101000000', '市辖区', '宁夏,银川', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (3494, 695262, 2, 695260, '640104000000', '兴庆区', '宁夏,银川,兴庆', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (3495, 695412, 2, 695260, '640105000000', '西夏区', '宁夏,银川,西夏', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (3496, 695500, 2, 695260, '640106000000', '金凤区', '宁夏,银川,金凤', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (3497, 695575, 2, 695260, '640121000000', '永宁县', '宁夏,银川,永宁', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (3498, 695675, 2, 695260, '640122000000', '贺兰县', '宁夏,银川,贺兰', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (3499, 695767, 2, 695260, '640181000000', '灵武市', '宁夏,银川,灵武', '106.230909', '38.487193', 1);
INSERT INTO `eb_system_city` VALUES (3500, 695884, 2, 695883, '640201000000', '市辖区', '宁夏,石嘴山', '106.383303', '38.983236', 1);
INSERT INTO `eb_system_city` VALUES (3501, 695885, 2, 695883, '640202000000', '大武口区', '宁夏,石嘴山,大武口', '106.367861', '39.019060', 1);
INSERT INTO `eb_system_city` VALUES (3502, 695959, 2, 695883, '640205000000', '惠农区', '宁夏,石嘴山,惠农', '106.781176', '39.239302', 1);
INSERT INTO `eb_system_city` VALUES (3503, 696058, 2, 695883, '640221000000', '平罗县', '宁夏,石嘴山,平罗', '106.523474', '38.913544', 1);
INSERT INTO `eb_system_city` VALUES (3504, 696253, 2, 696252, '640301000000', '市辖区', '宁夏,吴忠', '106.198393', '37.997460', 1);
INSERT INTO `eb_system_city` VALUES (3505, 696254, 2, 696252, '640302000000', '利通区', '宁夏,吴忠,利通', '106.212566', '37.983458', 1);
INSERT INTO `eb_system_city` VALUES (3506, 696427, 2, 696252, '640303000000', '红寺堡区', '宁夏,吴忠,红寺堡', '106.062114', '37.425702', 1);
INSERT INTO `eb_system_city` VALUES (3507, 696505, 2, 696252, '640323000000', '盐池县', '宁夏,吴忠,盐池', '107.407359', '37.783205', 1);
INSERT INTO `eb_system_city` VALUES (3508, 696633, 2, 696252, '640324000000', '同心县', '宁夏,吴忠,同心', '105.914458', '36.980575', 1);
INSERT INTO `eb_system_city` VALUES (3509, 696803, 2, 696252, '640381000000', '青铜峡市', '宁夏,吴忠,青铜峡', '106.078818', '38.021302', 1);
INSERT INTO `eb_system_city` VALUES (3510, 696929, 2, 696928, '640401000000', '市辖区', '宁夏,固原', '106.242610', '36.015855', 1);
INSERT INTO `eb_system_city` VALUES (3511, 696930, 2, 696928, '640402000000', '原州区', '宁夏,固原,原州', '106.287782', '36.003740', 1);
INSERT INTO `eb_system_city` VALUES (3512, 697133, 2, 696928, '640422000000', '西吉县', '宁夏,固原,西吉', '105.729085', '35.963913', 1);
INSERT INTO `eb_system_city` VALUES (3513, 697457, 2, 696928, '640423000000', '隆德县', '宁夏,固原,隆德', '106.111595', '35.625915', 1);
INSERT INTO `eb_system_city` VALUES (3514, 697594, 2, 696928, '640424000000', '泾源县', '宁夏,固原,泾源', '106.330646', '35.498160', 1);
INSERT INTO `eb_system_city` VALUES (3515, 697714, 2, 696928, '640425000000', '彭阳县', '宁夏,固原,彭阳', '106.638340', '35.849565', 1);
INSERT INTO `eb_system_city` VALUES (3516, 697888, 2, 697887, '640501000000', '市辖区', '宁夏,中卫', '105.196902', '37.499972', 1);
INSERT INTO `eb_system_city` VALUES (3517, 697889, 2, 697887, '640502000000', '沙坡头区', '宁夏,中卫,沙坡头', '105.190536', '37.514564', 1);
INSERT INTO `eb_system_city` VALUES (3518, 698087, 2, 697887, '640521000000', '中宁县', '宁夏,中卫,中宁', '105.685285', '37.491505', 1);
INSERT INTO `eb_system_city` VALUES (3519, 698240, 2, 697887, '640522000000', '海原县', '宁夏,中卫,海原', '105.643487', '36.565033', 1);
INSERT INTO `eb_system_city` VALUES (3520, 698442, 2, 698441, '650101000000', '市辖区', '新疆,乌鲁木齐', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3521, 698443, 2, 698441, '650102000000', '天山区', '新疆,乌鲁木齐,天山', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3522, 698654, 2, 698441, '650103000000', '沙依巴克区', '新疆,乌鲁木齐,沙依巴克', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3523, 698884, 2, 698441, '650104000000', '新市区', '新疆,乌鲁木齐,新市区', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3524, 699054, 2, 698441, '650105000000', '水磨沟区', '新疆,乌鲁木齐,水磨沟', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3525, 699229, 2, 698441, '650106000000', '头屯河区', '新疆,乌鲁木齐,头屯河', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3526, 699313, 2, 698441, '650107000000', '达坂城区', '新疆,乌鲁木齐,达坂城', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3527, 699363, 2, 698441, '650109000000', '米东区', '新疆,乌鲁木齐,米东', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3528, 699535, 2, 698441, '650121000000', '乌鲁木齐县', '新疆,乌鲁木齐,乌鲁木齐', '87.616848', '43.825592', 1);
INSERT INTO `eb_system_city` VALUES (3529, 699584, 2, 699583, '650201000000', '市辖区', '新疆,克拉玛依', '84.889207', '45.579888', 1);
INSERT INTO `eb_system_city` VALUES (3530, 699585, 2, 699583, '650202000000', '独山子区', '新疆,克拉玛依,独山子', '84.886974', '44.328096', 1);
INSERT INTO `eb_system_city` VALUES (3531, 699606, 2, 699583, '650203000000', '克拉玛依区', '新疆,克拉玛依,克拉玛依', '84.867844', '45.602526', 1);
INSERT INTO `eb_system_city` VALUES (3532, 699730, 2, 699583, '650204000000', '白碱滩区', '新疆,克拉玛依,白碱滩', '85.131696', '45.687855', 1);
INSERT INTO `eb_system_city` VALUES (3533, 699752, 2, 699583, '650205000000', '乌尔禾区', '新疆,克拉玛依,乌尔禾', '85.693742', '46.089148', 1);
INSERT INTO `eb_system_city` VALUES (3534, 699774, 2, 699773, '650402000000', '高昌区', '新疆,吐鲁番,高昌', '89.182342', '42.947635', 1);
INSERT INTO `eb_system_city` VALUES (3535, 699884, 2, 699773, '650421000000', '鄯善县', '新疆,吐鲁番,鄯善', '90.213330', '42.868744', 1);
INSERT INTO `eb_system_city` VALUES (3536, 700000, 2, 699773, '650422000000', '托克逊县', '新疆,吐鲁番,托克逊', '88.653814', '42.792521', 1);
INSERT INTO `eb_system_city` VALUES (3537, 700071, 2, 700070, '650502000000', '伊州区', '新疆,哈密,伊州', '93.514916', '42.818501', 1);
INSERT INTO `eb_system_city` VALUES (3538, 700350, 2, 700070, '650521000000', '巴里坤哈萨克自治县', '新疆,哈密,巴里坤', '93.016625', '43.598763', 1);
INSERT INTO `eb_system_city` VALUES (3539, 700438, 2, 700070, '650522000000', '伊吾县', '新疆,哈密,伊吾', '94.697074', '43.254978', 1);
INSERT INTO `eb_system_city` VALUES (3540, 700490, 2, 700489, '652301000000', '昌吉市', '新疆,昌吉,昌吉', '87.304112', '44.013183', 1);
INSERT INTO `eb_system_city` VALUES (3541, 700685, 2, 700489, '652302000000', '阜康市', '新疆,昌吉,阜康', '87.946894', '44.168576', 1);
INSERT INTO `eb_system_city` VALUES (3542, 700805, 2, 700489, '652323000000', '呼图壁县', '新疆,昌吉,呼图壁', '86.898902', '44.191428', 1);
INSERT INTO `eb_system_city` VALUES (3543, 700956, 2, 700489, '652324000000', '玛纳斯县', '新疆,昌吉,玛纳斯', '86.213997', '44.303893', 1);
INSERT INTO `eb_system_city` VALUES (3544, 701230, 2, 700489, '652325000000', '奇台县', '新疆,昌吉,奇台', '89.593967', '44.022066', 1);
INSERT INTO `eb_system_city` VALUES (3545, 701375, 2, 700489, '652327000000', '吉木萨尔县', '新疆,昌吉,吉木萨尔', '89.180437', '44.000497', 1);
INSERT INTO `eb_system_city` VALUES (3546, 701474, 2, 700489, '652328000000', '木垒哈萨克自治县', '新疆,昌吉,木垒', '90.286028', '43.834689', 1);
INSERT INTO `eb_system_city` VALUES (3547, 701560, 2, 701559, '652701000000', '博乐市', '新疆,博尔塔拉,博乐', '82.051005', '44.853870', 1);
INSERT INTO `eb_system_city` VALUES (3548, 701834, 2, 701559, '652702000000', '阿拉山口市', '新疆,博尔塔拉,阿拉山口', '82.559396', '45.172228', 1);
INSERT INTO `eb_system_city` VALUES (3549, 701839, 2, 701559, '652722000000', '精河县', '新疆,博尔塔拉,精河', '82.894195', '44.600408', 1);
INSERT INTO `eb_system_city` VALUES (3550, 701978, 2, 701559, '652723000000', '温泉县', '新疆,博尔塔拉,温泉', '81.024816', '44.968857', 1);
INSERT INTO `eb_system_city` VALUES (3551, 702105, 2, 702104, '652801000000', '库尔勒市', '新疆,巴音郭楞,库尔勒', '86.174633', '41.725892', 1);
INSERT INTO `eb_system_city` VALUES (3552, 702357, 2, 702104, '652822000000', '轮台县', '新疆,巴音郭楞,轮台', '84.252156', '41.777702', 1);
INSERT INTO `eb_system_city` VALUES (3553, 702447, 2, 702104, '652823000000', '尉犁县', '新疆,巴音郭楞,尉犁', '86.261321', '41.343933', 1);
INSERT INTO `eb_system_city` VALUES (3554, 702573, 2, 702104, '652824000000', '若羌县', '新疆,巴音郭楞,若羌', '88.167152', '39.023242', 1);
INSERT INTO `eb_system_city` VALUES (3555, 702634, 2, 702104, '652825000000', '且末县', '新疆,巴音郭楞,且末', '85.528865', '38.147895', 1);
INSERT INTO `eb_system_city` VALUES (3556, 702727, 2, 702104, '652826000000', '焉耆回族自治县', '新疆,巴音郭楞,焉耆', '86.574067', '42.059759', 1);
INSERT INTO `eb_system_city` VALUES (3557, 702821, 2, 702104, '652827000000', '和静县', '新疆,巴音郭楞,和静', '86.384065', '42.323625', 1);
INSERT INTO `eb_system_city` VALUES (3558, 702995, 2, 702104, '652828000000', '和硕县', '新疆,巴音郭楞,和硕', '86.863963', '42.268371', 1);
INSERT INTO `eb_system_city` VALUES (3559, 703063, 2, 702104, '652829000000', '博湖县', '新疆,巴音郭楞,博湖', '86.631998', '41.980152', 1);
INSERT INTO `eb_system_city` VALUES (3560, 703120, 2, 703119, '652901000000', '阿克苏市', '新疆,阿克苏,阿克苏', '80.260605', '41.168779', 1);
INSERT INTO `eb_system_city` VALUES (3561, 703353, 2, 703119, '652922000000', '温宿县', '新疆,阿克苏,温宿', '80.238959', '41.276688', 1);
INSERT INTO `eb_system_city` VALUES (3562, 703576, 2, 703119, '652923000000', '库车县', '新疆,阿克苏,库车', '82.962016', '41.717906', 1);
INSERT INTO `eb_system_city` VALUES (3563, 703858, 2, 703119, '652924000000', '沙雅县', '新疆,阿克苏,沙雅', '82.781819', '41.221667', 1);
INSERT INTO `eb_system_city` VALUES (3564, 704059, 2, 703119, '652925000000', '新和县', '新疆,阿克苏,新和', '82.609220', '41.548118', 1);
INSERT INTO `eb_system_city` VALUES (3565, 704209, 2, 703119, '652926000000', '拜城县', '新疆,阿克苏,拜城', '81.874156', '41.796910', 1);
INSERT INTO `eb_system_city` VALUES (3566, 704413, 2, 703119, '652927000000', '乌什县', '新疆,阿克苏,乌什', '79.224445', '41.214652', 1);
INSERT INTO `eb_system_city` VALUES (3567, 704556, 2, 703119, '652928000000', '阿瓦提县', '新疆,阿克苏,阿瓦提', '80.373137', '40.644529', 1);
INSERT INTO `eb_system_city` VALUES (3568, 704733, 2, 703119, '652929000000', '柯坪县', '新疆,阿克苏,柯坪', '79.047291', '40.508340', 1);
INSERT INTO `eb_system_city` VALUES (3569, 704780, 2, 704779, '653001000000', '阿图什市', '新疆,克孜勒苏,阿图什', '76.168400', '39.716160', 1);
INSERT INTO `eb_system_city` VALUES (3570, 704893, 2, 704779, '653022000000', '阿克陶县', '新疆,克孜勒苏,阿克陶', '75.962509', '37.993697', 1);
INSERT INTO `eb_system_city` VALUES (3571, 705047, 2, 704779, '653023000000', '阿合奇县', '新疆,克孜勒苏,阿合奇', '78.446253', '40.936936', 1);
INSERT INTO `eb_system_city` VALUES (3572, 705084, 2, 704779, '653024000000', '乌恰县', '新疆,克孜勒苏,乌恰', '76.167819', '39.714526', 1);
INSERT INTO `eb_system_city` VALUES (3573, 705146, 2, 705145, '653101000000', '喀什市', '新疆,喀什,喀什', '75.989755', '39.470400', 1);
INSERT INTO `eb_system_city` VALUES (3574, 705344, 2, 705145, '653121000000', '疏附县', '新疆,喀什,疏附', '75.862814', '39.375044', 1);
INSERT INTO `eb_system_city` VALUES (3575, 705496, 2, 705145, '653122000000', '疏勒县', '新疆,喀什,疏勒', '76.048139', '39.401385', 1);
INSERT INTO `eb_system_city` VALUES (3576, 705764, 2, 705145, '653123000000', '英吉沙县', '新疆,喀什,英吉沙', '76.175729', '38.930382', 1);
INSERT INTO `eb_system_city` VALUES (3577, 705961, 2, 705145, '653124000000', '泽普县', '新疆,喀什,泽普', '77.260103', '38.184955', 1);
INSERT INTO `eb_system_city` VALUES (3578, 706133, 2, 705145, '653125000000', '莎车县', '新疆,喀什,莎车', '77.245761', '38.414217', 1);
INSERT INTO `eb_system_city` VALUES (3579, 706753, 2, 705145, '653126000000', '叶城县', '新疆,喀什,叶城', '77.413836', '37.882989', 1);
INSERT INTO `eb_system_city` VALUES (3580, 707143, 2, 705145, '653127000000', '麦盖提县', '新疆,喀什,麦盖提', '77.610105', '38.898666', 1);
INSERT INTO `eb_system_city` VALUES (3581, 707342, 2, 705145, '653128000000', '岳普湖县', '新疆,喀什,岳普湖', '76.773163', '39.224200', 1);
INSERT INTO `eb_system_city` VALUES (3582, 707464, 2, 705145, '653129000000', '伽师县', '新疆,喀什,伽师', '76.723720', '39.488182', 1);
INSERT INTO `eb_system_city` VALUES (3583, 707806, 2, 705145, '653130000000', '巴楚县', '新疆,喀什,巴楚', '78.549297', '39.785155', 1);
INSERT INTO `eb_system_city` VALUES (3584, 708055, 2, 705145, '653131000000', '塔什库尔干塔吉克自治县', '新疆,喀什,塔什库尔干', '75.989755', '39.470400', 1);
INSERT INTO `eb_system_city` VALUES (3585, 708118, 2, 708117, '653201000000', '和田市', '新疆,和田,和田', '79.913534', '37.112149', 1);
INSERT INTO `eb_system_city` VALUES (3586, 708305, 2, 708117, '653221000000', '和田县', '新疆,和田,和田', '79.913534', '37.112149', 1);
INSERT INTO `eb_system_city` VALUES (3587, 708528, 2, 708117, '653222000000', '墨玉县', '新疆,和田,墨玉', '79.728841', '37.277340', 1);
INSERT INTO `eb_system_city` VALUES (3588, 708940, 2, 708117, '653223000000', '皮山县', '新疆,和田,皮山', '78.283669', '37.621450', 1);
INSERT INTO `eb_system_city` VALUES (3589, 709155, 2, 708117, '653224000000', '洛浦县', '新疆,和田,洛浦', '80.188986', '37.073667', 1);
INSERT INTO `eb_system_city` VALUES (3590, 709393, 2, 708117, '653225000000', '策勒县', '新疆,和田,策勒', '80.806159', '36.998335', 1);
INSERT INTO `eb_system_city` VALUES (3591, 709538, 2, 708117, '653226000000', '于田县', '新疆,和田,于田', '81.677418', '36.857081', 1);
INSERT INTO `eb_system_city` VALUES (3592, 709746, 2, 708117, '653227000000', '民丰县', '新疆,和田,民丰', '82.695862', '37.064080', 1);
INSERT INTO `eb_system_city` VALUES (3593, 709793, 2, 709792, '654002000000', '伊宁市', '新疆,伊犁,伊宁', '81.277950', '43.908558', 1);
INSERT INTO `eb_system_city` VALUES (3594, 709978, 2, 709792, '654003000000', '奎屯市', '新疆,伊犁,奎屯', '84.903267', '44.426529', 1);
INSERT INTO `eb_system_city` VALUES (3595, 710057, 2, 709792, '654004000000', '霍尔果斯市', '新疆,伊犁,霍尔果斯', '80.420759', '44.201669', 1);
INSERT INTO `eb_system_city` VALUES (3596, 710090, 2, 709792, '654021000000', '伊宁县', '新疆,伊犁,伊宁', '81.277950', '43.908558', 1);
INSERT INTO `eb_system_city` VALUES (3597, 710275, 2, 709792, '654022000000', '察布查尔锡伯自治县', '新疆,伊犁,察布查尔', '81.151337', '43.840726', 1);
INSERT INTO `eb_system_city` VALUES (3598, 710410, 2, 709792, '654023000000', '霍城县', '新疆,伊犁,霍城', '80.874181', '44.053592', 1);
INSERT INTO `eb_system_city` VALUES (3599, 710612, 2, 709792, '654024000000', '巩留县', '新疆,伊犁,巩留', '82.231718', '43.482628', 1);
INSERT INTO `eb_system_city` VALUES (3600, 710730, 2, 709792, '654025000000', '新源县', '新疆,伊犁,新源', '83.260770', '43.429930', 1);
INSERT INTO `eb_system_city` VALUES (3601, 710868, 2, 709792, '654026000000', '昭苏县', '新疆,伊犁,昭苏', '81.130975', '43.157293', 1);
INSERT INTO `eb_system_city` VALUES (3602, 711013, 2, 709792, '654027000000', '特克斯县', '新疆,伊犁,特克斯', '81.836206', '43.217184', 1);
INSERT INTO `eb_system_city` VALUES (3603, 711105, 2, 709792, '654028000000', '尼勒克县', '新疆,伊犁,尼勒克', '82.511810', '43.800247', 1);
INSERT INTO `eb_system_city` VALUES (3604, 711219, 2, 711218, '654201000000', '塔城市', '新疆,塔城,塔城', '82.978928', '46.748523', 1);
INSERT INTO `eb_system_city` VALUES (3605, 711436, 2, 711218, '654202000000', '乌苏市', '新疆,塔城,乌苏', '84.713736', '44.418887', 1);
INSERT INTO `eb_system_city` VALUES (3606, 711820, 2, 711218, '654221000000', '额敏县', '新疆,塔城,额敏', '83.628303', '46.524673', 1);
INSERT INTO `eb_system_city` VALUES (3607, 712103, 2, 711218, '654223000000', '沙湾县', '新疆,塔城,沙湾', '85.619416', '44.326388', 1);
INSERT INTO `eb_system_city` VALUES (3608, 712601, 2, 711218, '654224000000', '托里县', '新疆,塔城,托里', '83.606951', '45.947638', 1);
INSERT INTO `eb_system_city` VALUES (3609, 712700, 2, 711218, '654225000000', '裕民县', '新疆,塔城,裕民', '82.982668', '46.201104', 1);
INSERT INTO `eb_system_city` VALUES (3610, 712777, 2, 711218, '654226000000', '和布克赛尔蒙古自治县', '新疆,塔城,和布克赛尔', '85.738335', '46.798895', 1);
INSERT INTO `eb_system_city` VALUES (3611, 712894, 2, 712893, '654301000000', '阿勒泰市', '新疆,阿勒泰,阿勒泰', '88.131842', '47.827309', 1);
INSERT INTO `eb_system_city` VALUES (3612, 713072, 2, 712893, '654321000000', '布尔津县', '新疆,阿勒泰,布尔津', '86.874897', '47.701850', 1);
INSERT INTO `eb_system_city` VALUES (3613, 713161, 2, 712893, '654322000000', '富蕴县', '新疆,阿勒泰,富蕴', '89.525504', '46.994115', 1);
INSERT INTO `eb_system_city` VALUES (3614, 713261, 2, 712893, '654323000000', '福海县', '新疆,阿勒泰,福海', '87.486703', '47.111919', 1);
INSERT INTO `eb_system_city` VALUES (3615, 713426, 2, 712893, '654324000000', '哈巴河县', '新疆,阿勒泰,哈巴河', '86.418621', '48.060846', 1);
INSERT INTO `eb_system_city` VALUES (3616, 713568, 2, 712893, '654325000000', '青河县', '新疆,阿勒泰,青河', '90.382961', '46.674205', 1);
INSERT INTO `eb_system_city` VALUES (3617, 713635, 2, 712893, '654326000000', '吉木乃县', '新疆,阿勒泰,吉木乃', '85.874096', '47.443101', 1);
INSERT INTO `eb_system_city` VALUES (3618, 713698, 2, 713697, '659001000000', '石河子市', '新疆,石河子', '86.080460', '44.305428', 1);
INSERT INTO `eb_system_city` VALUES (3619, 713842, 2, 713697, '659002000000', '阿拉尔市', '新疆,阿拉尔', '81.280525', '40.547653', 1);
INSERT INTO `eb_system_city` VALUES (3620, 714172, 2, 713697, '659003000000', '图木舒克市', '新疆,图木舒克', '79.074089', '39.868969', 1);
INSERT INTO `eb_system_city` VALUES (3621, 714310, 2, 713697, '659004000000', '五家渠市', '新疆,五家渠', '87.543243', '44.166756', 1);
INSERT INTO `eb_system_city` VALUES (3622, 714363, 2, 713697, '659006000000', '铁门关市', '新疆,铁门关', '85.669533', '41.863300', 1);
INSERT INTO `eb_system_city` VALUES (3648, 714403, 2, 714402, '0', '芳苑乡', '台湾,彰化,芳苑', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3649, 714632, 2, 714402, '0', '芬园乡', '台湾,彰化,芬园', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3650, 714701, 2, 714402, '0', '福兴乡', '台湾,彰化,福兴', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3651, 714777, 2, 714402, '0', '和美镇', '台湾,彰化,和美', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3652, 715055, 2, 714402, '0', '花坛乡', '台湾,彰化,花坛', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3653, 715172, 2, 714402, '0', '鹿港镇', '台湾,彰化,鹿港', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3654, 715490, 2, 714402, '0', '埤头乡', '台湾,彰化,埤头', '120.464542', '23.890392', 1);
INSERT INTO `eb_system_city` VALUES (3655, 715602, 2, 714402, '0', '埔心乡', '台湾,彰化,埔心', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3656, 715745, 2, 714402, '0', '埔盐乡', '台湾,彰化,埔盐', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3657, 715795, 2, 714402, '0', '伸港乡', '台湾,彰化,伸港', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3658, 715960, 2, 714402, '0', '社头乡', '台湾,彰化,社头', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3659, 716105, 2, 714402, '0', '田尾乡', '台湾,彰化,田尾', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3660, 716202, 2, 714402, '0', '田中镇', '台湾,彰化,田中', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3661, 716341, 2, 714402, '0', '线西乡', '台湾,彰化,线西', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3662, 716421, 2, 714402, '0', '溪湖镇', '台湾,彰化,溪湖', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3663, 716750, 2, 714402, '0', '秀水乡', '台湾,彰化,秀水', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3664, 716874, 2, 714402, '0', '溪州乡', '台湾,彰化,溪州', '120.492906', '23.853578', 1);
INSERT INTO `eb_system_city` VALUES (3665, 717107, 2, 714402, '0', '永靖乡', '台湾,彰化,永靖', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3666, 717238, 2, 714402, '0', '员林市', '台湾,彰化,员林市', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3667, 717447, 2, 714402, '0', '竹塘乡', '台湾,彰化,竹塘', '120.416000', '24.000000', 1);
INSERT INTO `eb_system_city` VALUES (3668, 717532, 2, 717531, '0', '八里区', '台湾,新北,八里区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3669, 717645, 2, 717531, '0', '板桥区', '台湾,新北,板桥区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3670, 717902, 2, 717531, '0', '贡寮区', '台湾,新北,贡寮区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3671, 717955, 2, 717531, '0', '金山区', '台湾,新北,金山区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3672, 718036, 2, 717531, '0', '林口区', '台湾,新北,林口区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3673, 718195, 2, 717531, '0', '芦洲区', '台湾,新北,芦洲区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3674, 718266, 2, 717531, '0', '坪林区', '台湾,新北,坪林区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3675, 718327, 2, 717531, '0', '平溪区', '台湾,新北,平溪区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3676, 718375, 2, 717531, '0', '瑞芳区', '台湾,新北,瑞芳区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3677, 718490, 2, 717531, '0', '三重区', '台湾,新北,三重区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3678, 718786, 2, 717531, '0', '三峡区', '台湾,新北,三峡区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3679, 718879, 2, 717531, '0', '三芝区', '台湾,新北,三芝区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3680, 718980, 2, 717531, '0', '深坑区', '台湾,新北,深坑区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3681, 719023, 2, 717531, '0', '石碇区', '台湾,新北,石碇区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3682, 719115, 2, 717531, '0', '石门区', '台湾,新北,石门区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3683, 719155, 2, 717531, '0', '双溪区', '台湾,新北,双溪区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3684, 719243, 2, 717531, '0', '树林区', '台湾,新北,树林区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3685, 719382, 2, 717531, '0', '泰山区', '台湾,新北,泰山区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3686, 719498, 2, 717531, '0', '淡水区', '台湾,新北,淡水区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3687, 719731, 2, 717531, '0', '土城区', '台湾,新北,土城区', '121.465746', '25.012366', 1);
INSERT INTO `eb_system_city` VALUES (3688, 719869, 2, 719868, '0', '白沙乡', '台湾,澎湖,白沙', '119.566417', '23.569733', 1);
INSERT INTO `eb_system_city` VALUES (3689, 719890, 2, 719868, '0', '湖西乡', '台湾,澎湖,湖西', '119.566417', '23.569733', 1);
INSERT INTO `eb_system_city` VALUES (3690, 719916, 2, 719868, '0', '马公市', '台湾,澎湖,马公市', '119.566417', '23.569733', 1);
INSERT INTO `eb_system_city` VALUES (3691, 720065, 2, 719868, '0', '七美乡', '台湾,澎湖,七美', '119.566417', '23.569733', 1);
INSERT INTO `eb_system_city` VALUES (3692, 720090, 2, 719868, '0', '望安乡', '台湾,澎湖,望安', '119.566417', '23.569733', 1);
INSERT INTO `eb_system_city` VALUES (3693, 720102, 2, 719868, '0', '西屿乡', '台湾,澎湖,西屿', '119.566417', '23.569733', 1);
INSERT INTO `eb_system_city` VALUES (3694, 720119, 2, 720118, '0', '三地门乡', '台湾,屏东,三地门', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3695, 720142, 2, 720118, '0', '狮子乡', '台湾,屏东,狮子', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3696, 720163, 2, 720118, '0', '泰武乡', '台湾,屏东,泰武', '120.626012', '22.591307', 1);
INSERT INTO `eb_system_city` VALUES (3697, 720186, 2, 720118, '0', '万丹乡', '台湾,屏东,万丹', '120.486423', '22.588123', 1);
INSERT INTO `eb_system_city` VALUES (3698, 720415, 2, 720118, '0', '万峦乡', '台湾,屏东,万峦', '120.566478', '22.571966', 1);
INSERT INTO `eb_system_city` VALUES (3699, 720480, 2, 720118, '0', '雾臺乡', '台湾,屏东,雾臺', '120.727653', '22.743675', 1);
INSERT INTO `eb_system_city` VALUES (3700, 720502, 2, 720118, '0', '新埤乡', '台湾,屏东,新埤', '120.545190', '22.465998', 1);
INSERT INTO `eb_system_city` VALUES (3701, 720553, 2, 720118, '0', '新园乡', '台湾,屏东,新园', '120.459758', '22.544147', 1);
INSERT INTO `eb_system_city` VALUES (3702, 720649, 2, 720118, '0', '盐埔乡', '台湾,屏东,盐埔', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3703, 720748, 2, 720118, '0', '竹田乡', '台湾,屏东,竹田', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3704, 720835, 2, 720118, '0', '长治乡', '台湾,屏东,长治', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3705, 720975, 2, 720118, '0', '潮州镇', '台湾,屏东,潮州', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3706, 721293, 2, 720118, '0', '车城乡', '台湾,屏东,车城', '120.707694', '22.072115', 1);
INSERT INTO `eb_system_city` VALUES (3707, 721335, 2, 720118, '0', '春日乡', '台湾,屏东,春日', '120.622000', '22.368284', 1);
INSERT INTO `eb_system_city` VALUES (3708, 721344, 2, 720118, '0', '东港镇', '台湾,屏东,东港', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3709, 721490, 2, 720118, '0', '枋寮乡', '台湾,屏东,枋寮', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3710, 721617, 2, 720118, '0', '枋山乡', '台湾,屏东,枋山', '120.647762', '22.262550', 1);
INSERT INTO `eb_system_city` VALUES (3711, 721638, 2, 720118, '0', '高树乡', '台湾,屏东,高树', '120.595945', '22.825131', 1);
INSERT INTO `eb_system_city` VALUES (3712, 721805, 2, 720118, '0', '恆春镇', '台湾,屏东,恆春', '120.487928', '22.682802', 1);
INSERT INTO `eb_system_city` VALUES (3713, 721930, 2, 720118, '0', '佳冬乡', '台湾,屏东,佳冬', '120.545370', '22.417786', 1);
INSERT INTO `eb_system_city` VALUES (3714, 722025, 2, 722024, '0', '梧栖区', '台湾,臺中,梧栖区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3715, 722212, 2, 722024, '0', '乌日区', '台湾,臺中,乌日区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3716, 722402, 2, 722024, '0', '新社区', '台湾,臺中,新社区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3717, 722474, 2, 722024, '0', '西屯区', '台湾,臺中,西屯区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3718, 722699, 2, 722024, '0', '北屯区', '台湾,臺中,北屯区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3719, 722879, 2, 722024, '0', '中区', '台湾,臺中,中区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3720, 722923, 2, 722024, '0', '大肚区', '台湾,臺中,大肚区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3721, 723021, 2, 722024, '0', '大甲区', '台湾,臺中,大甲区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3722, 723211, 2, 722024, '0', '大里区', '台湾,臺中,大里区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3723, 723592, 2, 722024, '0', '大雅区', '台湾,臺中,大雅区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3724, 723756, 2, 722024, '0', '大安区', '台湾,臺中,大安区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3725, 723802, 2, 722024, '0', '东势区', '台湾,臺中,东势区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3726, 723966, 2, 722024, '0', '东区', '台湾,臺中,东区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3727, 724148, 2, 722024, '0', '丰原区', '台湾,臺中,丰原区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3728, 724424, 2, 722024, '0', '和平区', '台湾,臺中,和平区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3729, 724504, 2, 722024, '0', '后里区', '台湾,臺中,后里区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3730, 724656, 2, 722024, '0', '龙井区', '台湾,臺中,龙井区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3731, 724797, 2, 722024, '0', '南屯区', '台湾,臺中,南屯区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3732, 724872, 2, 722024, '0', '北区', '台湾,臺中,北区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3733, 725199, 2, 722024, '0', '清水区', '台湾,臺中,清水区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3734, 725489, 2, 725488, '0', '佳里区', '台湾,臺南,佳里区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3735, 725588, 2, 725488, '0', '将军区', '台湾,臺南,将军区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3736, 725620, 2, 725488, '0', '六甲区', '台湾,臺南,六甲区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3737, 725679, 2, 725488, '0', '柳营区', '台湾,臺南,柳营区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3738, 725795, 2, 725488, '0', '龙崎区', '台湾,臺南,龙崎区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3739, 725841, 2, 725488, '0', '麻豆区', '台湾,臺南,麻豆区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3740, 725927, 2, 725488, '0', '南化区', '台湾,臺南,南化区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3741, 725938, 2, 725488, '0', '楠西区', '台湾,臺南,楠西区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3742, 725973, 2, 725488, '0', '北区', '台湾,臺南,北区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3743, 726300, 2, 725488, '0', '七股区', '台湾,臺南,七股区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3744, 726338, 2, 725488, '0', '仁德区', '台湾,臺南,仁德区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3745, 726539, 2, 725488, '0', '善化区', '台湾,臺南,善化区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3746, 726675, 2, 725488, '0', '山上区', '台湾,臺南,山上区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3747, 726691, 2, 725488, '0', '南区', '台湾,臺南,南区', '120.679305', '24.133453', 1);
INSERT INTO `eb_system_city` VALUES (3748, 727041, 2, 725488, '0', '中西区', '台湾,臺南,中西区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3749, 727251, 2, 725488, '0', '下营区', '台湾,臺南,下营区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3750, 727339, 2, 725488, '0', '西港区', '台湾,臺南,西港区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3751, 727375, 2, 725488, '0', '新化区', '台湾,臺南,新化区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3752, 727425, 2, 725488, '0', '新市区', '台湾,臺南,新市区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3753, 727529, 2, 725488, '0', '新营区', '台湾,臺南,新营区', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3754, 727731, 2, 727730, '0', '北投区', '台湾,臺北,北投区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3755, 727897, 2, 727730, '0', '大同区', '台湾,臺北,大同区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3756, 728070, 2, 727730, '0', '大安区', '台湾,臺北,大安区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3757, 728116, 2, 727730, '0', '南港区', '台湾,臺北,南港区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3758, 728220, 2, 727730, '0', '内湖区', '台湾,臺北,内湖区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3759, 728340, 2, 727730, '0', '士林区', '台湾,臺北,士林区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3760, 728550, 2, 727730, '0', '松山区', '台湾,臺北,松山区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3761, 728713, 2, 727730, '0', '万华区', '台湾,臺北,万华区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3762, 728920, 2, 727730, '0', '文山区', '台湾,臺北,文山区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3763, 729073, 2, 727730, '0', '信义区', '台湾,臺北,信义区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3764, 729277, 2, 727730, '0', '中山区', '台湾,臺北,中山区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3765, 729583, 2, 727730, '0', '中正区', '台湾,臺北,中正区', '121.517057', '25.048074', 1);
INSERT INTO `eb_system_city` VALUES (3766, 729929, 2, 729928, '0', '卑南乡', '台湾,臺东,卑南', '121.117213', '22.781744', 1);
INSERT INTO `eb_system_city` VALUES (3767, 729994, 2, 729928, '0', '长滨乡', '台湾,臺东,长滨', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3768, 730033, 2, 729928, '0', '成功镇', '台湾,臺东,成功', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3769, 730107, 2, 729928, '0', '池上乡', '台湾,臺东,池上', '121.212999', '23.123275', 1);
INSERT INTO `eb_system_city` VALUES (3770, 730196, 2, 729928, '0', '达仁乡', '台湾,臺东,达仁', '120.878316', '22.296142', 1);
INSERT INTO `eb_system_city` VALUES (3771, 730219, 2, 729928, '0', '大武乡', '台湾,臺东,大武', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3772, 730268, 2, 729928, '0', '东河乡', '台湾,臺东,东河', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3773, 730308, 2, 729928, '0', '关山镇', '台湾,臺东,关山', '121.158084', '23.047483', 1);
INSERT INTO `eb_system_city` VALUES (3774, 730384, 2, 729928, '0', '海端乡', '台湾,臺东,海端', '121.172009', '23.101079', 1);
INSERT INTO `eb_system_city` VALUES (3775, 730409, 2, 729928, '0', '金峰乡', '台湾,臺东,金峰', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3776, 730416, 2, 729928, '0', '兰屿乡', '台湾,臺东,兰屿', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3777, 730423, 2, 729928, '0', '绿岛乡', '台湾,臺东,绿岛', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3778, 730438, 2, 729928, '0', '鹿野乡', '台湾,臺东,鹿野', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3779, 730510, 2, 729928, '0', '太麻里乡', '台湾,臺东,太麻里', '120.999365', '22.610919', 1);
INSERT INTO `eb_system_city` VALUES (3780, 730565, 2, 729928, '0', '臺东市', '台湾,臺东,臺东市', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3781, 730832, 2, 729928, '0', '延平乡', '台湾,臺东,延平', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3782, 730844, 2, 730843, '0', '八德区', '台湾,桃园,八德区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3783, 731212, 2, 730843, '0', '大溪区', '台湾,桃园,大溪区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3784, 731471, 2, 730843, '0', '大园区', '台湾,桃园,大园区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3785, 731767, 2, 730843, '0', '復兴区', '台湾,桃园,復兴区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3786, 731835, 2, 730843, '0', '观音区', '台湾,桃园,观音区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3787, 732079, 2, 730843, '0', '龟山区', '台湾,桃园,龟山区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3788, 732469, 2, 730843, '0', '龙潭区', '台湾,桃园,龙潭区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3789, 732800, 2, 730843, '0', '芦竹区', '台湾,桃园,芦竹区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3790, 733144, 2, 730843, '0', '平镇区', '台湾,桃园,平区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3791, 733179, 2, 730843, '0', '桃园区', '台湾,桃园,桃园区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3792, 733390, 2, 730843, '0', '新屋区', '台湾,桃园,新屋区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3793, 733537, 2, 730843, '0', '杨梅区', '台湾,桃园,杨梅区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3794, 733876, 2, 730843, '0', '中坜区', '台湾,桃园,中坜区', '121.083000', '25.000000', 1);
INSERT INTO `eb_system_city` VALUES (3795, 734180, 2, 734179, '0', '大同乡', '台湾,宜兰,大同', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3796, 734246, 2, 734179, '0', '钓鱼臺', '台湾,宜兰,钓鱼臺', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3797, 734248, 2, 734179, '0', '冬山乡', '台湾,宜兰,冬山', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3798, 734579, 2, 734179, '0', '礁溪乡', '台湾,宜兰,礁溪', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3799, 734681, 2, 734179, '0', '罗东镇', '台湾,宜兰,罗东', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3800, 734842, 2, 734179, '0', '南澳乡', '台湾,宜兰,南澳', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3801, 734865, 2, 734179, '0', '三星乡', '台湾,宜兰,三星', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3802, 735104, 2, 734179, '0', '苏澳镇', '台湾,宜兰,苏澳', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3803, 735319, 2, 734179, '0', '头城镇', '台湾,宜兰,头城', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3804, 735419, 2, 734179, '0', '五结乡', '台湾,宜兰,五结', '121.796468', '24.685615', 1);
INSERT INTO `eb_system_city` VALUES (3805, 735620, 2, 734179, '0', '宜兰市', '台湾,宜兰,宜兰市', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3806, 735851, 2, 734179, '0', '员山乡', '台湾,宜兰,员山', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3807, 735970, 2, 734179, '0', '壮围乡', '台湾,宜兰,壮围', '121.500000', '24.600000', 1);
INSERT INTO `eb_system_city` VALUES (3808, 736052, 2, 736051, '0', '草屯镇', '台湾,南投,草屯', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3809, 736305, 2, 736051, '0', '国姓乡', '台湾,南投,国姓', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3810, 736356, 2, 736051, '0', '集集镇', '台湾,南投,集集', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3811, 736449, 2, 736051, '0', '鹿谷乡', '台湾,南投,鹿谷', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3812, 736522, 2, 736051, '0', '名间乡', '台湾,南投,名间', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3813, 736622, 2, 736051, '0', '南投市', '台湾,南投,南投市', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3814, 736887, 2, 736051, '0', '埔里镇', '台湾,南投,埔里', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3815, 737266, 2, 736051, '0', '仁爱乡', '台湾,南投,仁爱', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3816, 737337, 2, 736051, '0', '水里乡', '台湾,南投,水里', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3817, 737496, 2, 736051, '0', '信义乡', '台湾,南投,信义', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3818, 737533, 2, 736051, '0', '鱼池乡', '台湾,南投,鱼池', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3819, 737591, 2, 736051, '0', '中寮乡', '台湾,南投,中寮', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3820, 737625, 2, 736051, '0', '竹山镇', '台湾,南投,竹山', '120.830000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3821, 737857, 2, 737856, '0', '东沙群岛', '台湾,南海岛,东沙群岛', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3822, 737859, 2, 737856, '0', '南沙群岛', '台湾,南海岛,南沙群岛', '0.000000', '0.000000', 1);
INSERT INTO `eb_system_city` VALUES (3823, 737862, 2, 737861, '0', '头屋乡', '台湾,苗栗,头屋', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3824, 737894, 2, 737861, '0', '西湖乡', '台湾,苗栗,西湖', '120.743700', '24.556610', 1);
INSERT INTO `eb_system_city` VALUES (3825, 737948, 2, 737861, '0', '苑里镇', '台湾,苗栗,苑里', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3826, 738050, 2, 737861, '0', '造桥乡', '台湾,苗栗,造桥', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3827, 738158, 2, 737861, '0', '竹南镇', '台湾,苗栗,竹南', '120.872636', '24.685510', 1);
INSERT INTO `eb_system_city` VALUES (3828, 738454, 2, 737861, '0', '卓兰镇', '台湾,苗栗,卓兰', '120.823440', '24.309510', 1);
INSERT INTO `eb_system_city` VALUES (3829, 738528, 2, 737861, '0', '大湖乡', '台湾,苗栗,大湖', '120.863640', '24.422548', 1);
INSERT INTO `eb_system_city` VALUES (3830, 738619, 2, 737861, '0', '公馆乡', '台湾,苗栗,公馆', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3831, 738695, 2, 737861, '0', '后龙镇', '台湾,苗栗,后龙', '120.786474', '24.612613', 1);
INSERT INTO `eb_system_city` VALUES (3832, 738882, 2, 737861, '0', '苗栗市', '台湾,苗栗,苗栗市', '120.819288', '24.561582', 1);
INSERT INTO `eb_system_city` VALUES (3833, 739250, 2, 737861, '0', '南庄乡', '台湾,苗栗,南庄', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3834, 739302, 2, 737861, '0', '三湾乡', '台湾,苗栗,三湾', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3835, 739369, 2, 737861, '0', '三义乡', '台湾,苗栗,三义', '120.765515', '24.413037', 1);
INSERT INTO `eb_system_city` VALUES (3836, 739419, 2, 737861, '0', '狮潭乡', '台湾,苗栗,狮潭', '120.918024', '24.540004', 1);
INSERT INTO `eb_system_city` VALUES (3837, 739465, 2, 737861, '0', '泰安乡', '台湾,苗栗,泰安', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3838, 739487, 2, 737861, '0', '铜锣乡', '台湾,苗栗,铜锣', '120.786475', '24.489502', 1);
INSERT INTO `eb_system_city` VALUES (3839, 739564, 2, 737861, '0', '通霄镇', '台湾,苗栗,通霄', '120.676696', '24.489084', 1);
INSERT INTO `eb_system_city` VALUES (3840, 739642, 2, 737861, '0', '头份市', '台湾,苗栗,头份市', '120.818985', '24.561601', 1);
INSERT INTO `eb_system_city` VALUES (3841, 739958, 2, 739957, '0', '东区', '台湾,嘉义,东区', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3842, 740140, 2, 739957, '0', '西区', '台湾,嘉义,西区', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3843, 740511, 2, 740510, '0', '阿里山乡', '台湾,嘉义,阿里山', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3844, 740536, 2, 740510, '0', '布袋镇', '台湾,嘉义,布袋', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3845, 740625, 2, 740510, '0', '大林镇', '台湾,嘉义,大林', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3846, 740746, 2, 740510, '0', '大埔乡', '台湾,嘉义,大埔', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3847, 740792, 2, 740510, '0', '东石乡', '台湾,嘉义,东石', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3848, 740845, 2, 740510, '0', '番路乡', '台湾,嘉义,番路', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3849, 740943, 2, 740510, '0', '六脚乡', '台湾,嘉义,六脚', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3850, 740975, 2, 740510, '0', '鹿草乡', '台湾,嘉义,鹿草', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3851, 741010, 2, 740510, '0', '梅山乡', '台湾,嘉义,梅山', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3852, 741137, 2, 740510, '0', '民雄乡', '台湾,嘉义,民雄', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3853, 741312, 2, 740510, '0', '朴子市', '台湾,嘉义,朴子市', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3854, 741451, 2, 740510, '0', '水上乡', '台湾,嘉义,水上', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3855, 741550, 2, 740510, '0', '太保市', '台湾,嘉义,太保市', '120.332737', '23.459115', 1);
INSERT INTO `eb_system_city` VALUES (3856, 741646, 2, 740510, '0', '溪口乡', '台湾,嘉义,溪口', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3857, 741688, 2, 740510, '0', '新港乡', '台湾,嘉义,新港', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3858, 741750, 2, 740510, '0', '义竹乡', '台湾,嘉义,义竹', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3859, 741785, 2, 740510, '0', '中埔乡', '台湾,嘉义,中埔', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3860, 741936, 2, 740510, '0', '竹崎乡', '台湾,嘉义,竹崎', '120.452538', '23.481568', 1);
INSERT INTO `eb_system_city` VALUES (3861, 742127, 2, 742126, '0', '东区', '台湾,新竹,东区', '120.973544', '24.805226', 1);
INSERT INTO `eb_system_city` VALUES (3862, 742309, 2, 742126, '0', '北区', '台湾,新竹,北区', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3863, 742637, 2, 742636, '0', '峨眉乡', '台湾,新竹,峨眉', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3864, 742674, 2, 742636, '0', '关西镇', '台湾,新竹,关西', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3865, 742797, 2, 742636, '0', '横山乡', '台湾,新竹,横山', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3866, 742852, 2, 742636, '0', '湖口乡', '台湾,新竹,湖口', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3867, 743201, 2, 742636, '0', '尖石乡', '台湾,新竹,尖石', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3868, 743246, 2, 742636, '0', '芎林乡', '台湾,新竹,芎林', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3869, 743298, 2, 742636, '0', '五峰乡', '台湾,新竹,五峰', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3870, 743319, 2, 742636, '0', '新丰乡', '台湾,新竹,新丰', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3871, 743414, 2, 742636, '0', '新埔镇', '台湾,新竹,新埔', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3872, 743527, 2, 742636, '0', '竹北市', '台湾,新竹,竹北市', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3873, 743565, 2, 742636, '0', '竹东镇', '台湾,新竹,竹东', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3874, 743725, 2, 742636, '0', '宝山乡', '台湾,新竹,宝山', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3875, 743888, 2, 742636, '0', '北埔乡', '台湾,新竹,北埔', '120.968798', '24.806738', 1);
INSERT INTO `eb_system_city` VALUES (3876, 743939, 2, 743938, '0', '卓溪乡', '台湾,花莲,卓溪', '121.301890', '23.344908', 1);
INSERT INTO `eb_system_city` VALUES (3877, 743956, 2, 743938, '0', '丰滨乡', '台湾,花莲,丰滨', '121.300000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3878, 743993, 2, 743938, '0', '凤林镇', '台湾,花莲,凤林', '121.300000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3879, 744128, 2, 743938, '0', '富里乡', '台湾,花莲,富里', '121.244694', '23.175468', 1);
INSERT INTO `eb_system_city` VALUES (3880, 744185, 2, 743938, '0', '光復乡', '台湾,花莲,光復', '121.300000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3881, 744246, 2, 743938, '0', '花莲市', '台湾,花莲,花莲市', '121.606927', '23.981993', 1);
INSERT INTO `eb_system_city` VALUES (3882, 744625, 2, 743938, '0', '吉安乡', '台湾,花莲,吉安', '121.300000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3883, 745050, 2, 743938, '0', '瑞穗乡', '台湾,花莲,瑞穗', '121.373373', '23.496080', 1);
INSERT INTO `eb_system_city` VALUES (3884, 745196, 2, 743938, '0', '寿丰乡', '台湾,花莲,寿丰', '121.506030', '23.869774', 1);
INSERT INTO `eb_system_city` VALUES (3885, 745354, 2, 743938, '0', '万荣乡', '台湾,花莲,万荣', '121.300000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3886, 745363, 2, 743938, '0', '新城乡', '台湾,花莲,新城', '121.604120', '24.039243', 1);
INSERT INTO `eb_system_city` VALUES (3887, 745486, 2, 743938, '0', '秀林乡', '台湾,花莲,秀林', '121.300000', '23.830000', 1);
INSERT INTO `eb_system_city` VALUES (3888, 745532, 2, 743938, '0', '玉里镇', '台湾,花莲,玉里', '121.312109', '23.334236', 1);
INSERT INTO `eb_system_city` VALUES (3889, 745675, 2, 745674, '0', '阿莲区', '台湾,高雄,阿莲区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3890, 745715, 2, 745674, '0', '大寮区', '台湾,高雄,大寮区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3891, 746083, 2, 745674, '0', '大社区', '台湾,高雄,大社区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3892, 746199, 2, 745674, '0', '大树区', '台湾,高雄,大树区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3893, 746294, 2, 745674, '0', '凤山区', '台湾,高雄,凤山区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3894, 746624, 2, 745674, '0', '冈山区', '台湾,高雄,冈山区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3895, 746906, 2, 745674, '0', '鼓山区', '台湾,高雄,鼓山区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3896, 747053, 2, 745674, '0', '湖内区', '台湾,高雄,湖内区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3897, 747108, 2, 745674, '0', '甲仙区', '台湾,高雄,甲仙区', '120.587980', '23.083957', 1);
INSERT INTO `eb_system_city` VALUES (3898, 747150, 2, 745674, '0', '苓雅区', '台湾,高雄,苓雅区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3899, 747342, 2, 745674, '0', '林园区', '台湾,高雄,林园区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3900, 747481, 2, 745674, '0', '六龟区', '台湾,高雄,六龟区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3901, 747536, 2, 745674, '0', '路竹区', '台湾,高雄,路竹区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3902, 747643, 2, 745674, '0', '茂林区', '台湾,高雄,茂林区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3903, 747647, 2, 745674, '0', '美浓区', '台湾,高雄,美浓区', '120.542419', '22.894882', 1);
INSERT INTO `eb_system_city` VALUES (3904, 747764, 2, 745674, '0', '弥陀区', '台湾,高雄,弥陀区', '120.250672', '22.781561', 1);
INSERT INTO `eb_system_city` VALUES (3905, 747894, 2, 745674, '0', '那玛夏区', '台湾,高雄,那玛夏区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3906, 747902, 2, 745674, '0', '楠梓区', '台湾,高雄,楠梓区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3907, 748258, 2, 745674, '0', '内门区', '台湾,高雄,内门区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3908, 748344, 2, 745674, '0', '鸟松区', '台湾,高雄,鸟松区', '120.311922', '22.620856', 1);
INSERT INTO `eb_system_city` VALUES (3909, 748554, 2, 748553, '0', '安乐区', '台湾,基隆,安乐区', '121.746248', '25.130741', 1);
INSERT INTO `eb_system_city` VALUES (3910, 748581, 2, 748553, '0', '暖暖区', '台湾,基隆,暖暖区', '121.746248', '25.130741', 1);
INSERT INTO `eb_system_city` VALUES (3911, 748599, 2, 748553, '0', '七堵区', '台湾,基隆,七堵区', '121.746248', '25.130741', 1);
INSERT INTO `eb_system_city` VALUES (3912, 748670, 2, 748553, '0', '仁爱区', '台湾,基隆,仁爱区', '121.746248', '25.130741', 1);
INSERT INTO `eb_system_city` VALUES (3913, 748716, 2, 748553, '0', '信义区', '台湾,基隆,信义区', '121.746248', '25.130741', 1);
INSERT INTO `eb_system_city` VALUES (3914, 748920, 2, 748553, '0', '中山区', '台湾,基隆,中山区', '121.746248', '25.130741', 1);
INSERT INTO `eb_system_city` VALUES (3915, 749226, 2, 748553, '0', '中正区', '台湾,基隆,中正区', '121.768000', '25.151647', 1);
INSERT INTO `eb_system_city` VALUES (3916, 749572, 2, 749571, '0', '金城镇', '台湾,金门,金城', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (3917, 749647, 2, 749571, '0', '金湖镇', '台湾,金门,金湖', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (3918, 749752, 2, 749571, '0', '金宁乡', '台湾,金门,金宁', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (3919, 749810, 2, 749571, '0', '金沙镇', '台湾,金门,金沙', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (3920, 749894, 2, 749571, '0', '烈屿乡', '台湾,金门,烈屿', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (3921, 749928, 2, 749571, '0', '乌坵乡', '台湾,金门,乌坵', '118.317089', '24.432706', 1);
INSERT INTO `eb_system_city` VALUES (3922, 749931, 2, 749930, '0', '北竿乡', '台湾,连江,北竿', '119.539704', '26.197364', 1);
INSERT INTO `eb_system_city` VALUES (3923, 749938, 2, 749930, '0', '东引乡', '台湾,连江,东引', '119.539704', '26.197364', 1);
INSERT INTO `eb_system_city` VALUES (3924, 749941, 2, 749930, '0', '莒光乡', '台湾,连江,莒光', '119.539704', '26.197364', 1);
INSERT INTO `eb_system_city` VALUES (3925, 749947, 2, 749930, '0', '南竿乡', '台湾,连江,南竿', '119.539704', '26.197364', 1);
INSERT INTO `eb_system_city` VALUES (3926, 749958, 2, 749957, '0', '褒忠乡', '台湾,云林,褒忠', '120.309069', '23.695652', 1);
INSERT INTO `eb_system_city` VALUES (3927, 749991, 2, 749957, '0', '北港镇', '台湾,云林,北港', '120.296759', '23.572428', 1);
INSERT INTO `eb_system_city` VALUES (3928, 750170, 2, 749957, '0', '莿桐乡', '台湾,云林,莿桐', '120.497033', '23.757251', 1);
INSERT INTO `eb_system_city` VALUES (3929, 750218, 2, 749957, '0', '大埤乡', '台湾,云林,大埤', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3930, 750291, 2, 749957, '0', '东势乡', '台湾,云林,东势', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3931, 750363, 2, 749957, '0', '斗六市', '台湾,云林,斗六市', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3932, 750795, 2, 749957, '0', '斗南镇', '台湾,云林,斗南', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3933, 751009, 2, 749957, '0', '二崙乡', '台湾,云林,二崙', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3934, 751071, 2, 749957, '0', '古坑乡', '台湾,云林,古坑', '120.558553', '23.644734', 1);
INSERT INTO `eb_system_city` VALUES (3935, 751147, 2, 749957, '0', '虎尾镇', '台湾,云林,虎尾', '120.429231', '23.707796', 1);
INSERT INTO `eb_system_city` VALUES (3936, 751400, 2, 749957, '0', '口湖乡', '台湾,云林,口湖', '120.178640', '23.585506', 1);
INSERT INTO `eb_system_city` VALUES (3937, 751493, 2, 749957, '0', '林内乡', '台湾,云林,林内', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3938, 751555, 2, 749957, '0', '崙背乡', '台湾,云林,崙背', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3939, 751674, 2, 749957, '0', '麦寮乡', '台湾,云林,麦寮', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3940, 751764, 2, 749957, '0', '水林乡', '台湾,云林,水林', '120.241228', '23.571067', 1);
INSERT INTO `eb_system_city` VALUES (3941, 751832, 2, 749957, '0', '四湖乡', '台湾,云林,四湖', '120.220781', '23.635426', 1);
INSERT INTO `eb_system_city` VALUES (3942, 751907, 2, 749957, '0', '臺西乡', '台湾,云林,臺西', '120.196139', '23.702821', 1);
INSERT INTO `eb_system_city` VALUES (3943, 751956, 2, 749957, '0', '土库镇', '台湾,云林,土库', '120.527173', '23.696887', 1);
INSERT INTO `eb_system_city` VALUES (3944, 752034, 2, 749957, '0', '西螺镇', '台湾,云林,西螺', '120.457123', '23.797412', 1);
INSERT INTO `eb_system_city` VALUES (3945, 752149, 2, 749957, '0', '元长乡', '台湾,云林,元长', '120.311052', '23.649577', 1);
INSERT INTO `eb_system_city` VALUES (3946, 752150, 1, 714368, '', '香港特别行政区', '香港特别行政区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3947, 752151, 2, 752150, '', '中西区', '中西区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3948, 752152, 2, 752150, '', '东区', '东区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3949, 752153, 2, 752150, '', '九龙城区', '九龙城区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3950, 752154, 2, 752150, '', '观塘区', '香港,九龙,观塘', '114.231268', '22.309430', 1);
INSERT INTO `eb_system_city` VALUES (3951, 752155, 2, 752150, '', '南区', '香港,香港岛,南区', '114.174134', '22.246760', 1);
INSERT INTO `eb_system_city` VALUES (3953, 752156, 2, 752150, '', '深水埗区', '香港特别行政区,香港特别行政区,深水埗区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3954, 752157, 2, 752150, '', '湾仔区', '湾仔区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3955, 752158, 2, 752150, '', '黄大仙区', '黄大仙区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3956, 752159, 2, 752150, '', '油尖旺区', '油尖旺区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3957, 752160, 2, 752150, '', '离岛区', '离岛区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3958, 752161, 2, 752150, '', '葵青区', '葵青区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3959, 752162, 2, 752150, '', '北区', '北区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3960, 752163, 2, 752150, '', '西贡区', '西贡区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3961, 752164, 2, 752150, '', '沙田区', '沙田区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3962, 752165, 2, 752150, '', '屯门区', '屯门区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3963, 752166, 2, 752150, '', '大埔区', '大埔区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3964, 752167, 2, 752150, '', '荃湾区', '荃湾区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3965, 752168, 2, 752150, '', '元朗区', '元朗区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3966, 752169, 1, 714390, '', '澳门特别行政区', '澳门特别行政区', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3967, 752170, 2, 752169, '', '澳门半岛', '澳门半岛', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3968, 752171, 2, 752169, '', '凼仔', '凼仔', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3969, 752172, 2, 752169, '', '路凼城', '路凼城', '', '', 1);
INSERT INTO `eb_system_city` VALUES (3970, 752173, 2, 752169, '', '路环', '路环', '', '', 1);

-- ----------------------------
-- Table structure for eb_system_config
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_config`;
CREATE TABLE `eb_system_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置id',
  `menu_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名称',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型(文本框,单选按钮...)',
  `input_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'input' COMMENT '表单类型',
  `config_tab_id` int(10) UNSIGNED NOT NULL COMMENT '配置分类id',
  `parameter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则 单选框和多选框',
  `upload_type` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '上传文件格式1单图2多图3文件',
  `required` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则',
  `width` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '多行文本框的宽度',
  `high` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '多行文框的高度',
  `value` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置简介',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 164 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_config
-- ----------------------------
INSERT INTO `eb_system_config` VALUES (1, 'site_name', 'text', 'input', 1, '', 0, 'required:true', 100, 0, '\"FOODTRUST\\u00ae\"', '网站名称', '网站名称', 0, 1);
INSERT INTO `eb_system_config` VALUES (2, 'site_url', 'text', 'input', 1, '', 0, 'required:true,url:true', 100, 0, '\"https:\\/\\/mall.foodtrust.cn\"', '网站地址', '网站地址', 0, 1);
INSERT INTO `eb_system_config` VALUES (3, 'site_logo', 'upload', NULL, 1, NULL, 1, NULL, 0, 0, '\"https:\\/\\/oss.foodtrust.cn\\/\\/21bed202004250044441257.png\"', '后台LOGO', '左上角logo,建议尺寸[170*50]', 0, 1);
INSERT INTO `eb_system_config` VALUES (4, 'site_phone', 'text', 'input', 1, '', 0, '', 100, 0, '\"\"', '联系电话', '联系电话', 0, 0);
INSERT INTO `eb_system_config` VALUES (5, 'seo_title', 'text', 'input', 1, '', 0, 'required:true', 100, 0, '\"\\u8ba9\\u5065\\u5eb7\\u548c\\u53cb\\u5584\\u89e6\\u624b\\u53ef\\u53ca \\u6bcf\\u4e00\\u5929 \\u66f4\\u5b89\\u5fc3\\u7684\\u9009\\u62e9 \\u6709\\u673a \\u751f\\u9c9c \\u5065\\u5eb7\\u98df\\u7269 \\u65e5\\u7528\\u54c1 \\u76ca\\u751f\\u83cc \\u5065\\u5eb7\\u7761\\u7720 \\u80a0\\u9053 \\u6d88\\u6bd2\\u5668 \\u73af\\u4fdd\\u65e5\\u7528\\u54c1 \\u65e0\\u5316\\u5b66\\u6dfb\\u52a0 \\u65e0\\u519c\\u836f\\uff0c\\u65e0\\u5316\\u80a5 \\u53ef\\u6eaf\\u6e90 \\u53ef\\u4fe1\\u4efb \\u53ef\\u9a8c\\u8bc1  \\u770b\\u5f97\\u89c1\\u7684\\u4fe1\\u4efb \\u6709\\u540d\\u6709\\u6027  \\u98df\\u6709\\u6e90 \\u5fc3\\u6709\\u6839 \\u5e7f\\u5dde \\u5e7f\\u4e1c\\u7701 \\u6709\\u673a \\u751f\\u9c9c \\u5b85\\u914d\"', 'SEO标题', 'SEO标题', 0, 1);
INSERT INTO `eb_system_config` VALUES (6, 'site_email', 'text', 'input', 1, '', 0, 'email:true', 100, 0, '\"\"', '联系邮箱', '联系邮箱', 0, 0);
INSERT INTO `eb_system_config` VALUES (7, 'site_qq', 'text', 'input', 1, '', 0, 'qq:true', 100, 0, '\"\"', '联系QQ', '联系QQ', 0, 0);
INSERT INTO `eb_system_config` VALUES (8, 'site_close', 'radio', 'input', 1, '0=>开启\n1=>PC端关闭\n2=>WAP端关闭(含微信)\n3=>全部关闭', 0, '', 0, 0, '\"0\"', '网站关闭', '网站后台、商家中心不受影响。关闭网站也可访问', 0, 2);
INSERT INTO `eb_system_config` VALUES (9, 'close_system', 'radio', 'input', 1, '0=>开启\n1=>关闭', 0, '', 0, 0, '\"0\"', '关闭后台', '关闭后台', 0, 2);
INSERT INTO `eb_system_config` VALUES (13, 'wechat_appid', 'text', 'input', 2, '', 0, 'required:true', 100, 0, '\"wxff8cf329bc5ec6be\"', 'AppID', 'AppID', 0, 1);
INSERT INTO `eb_system_config` VALUES (14, 'wechat_appsecret', 'text', 'input', 2, '', 0, 'required:true', 100, 0, '\"afe523e9bcd47bdc320a3b336cee95f1\"', 'AppSecret', 'AppSecret', 0, 1);
INSERT INTO `eb_system_config` VALUES (15, 'wechat_token', 'text', 'input', 2, '', 0, 'required:true', 100, 0, '\"Hell0Crmeb\"', '微信验证TOKEN', '微信验证TOKEN', 0, 1);
INSERT INTO `eb_system_config` VALUES (16, 'wechat_encode', 'radio', 'input', 2, '0=>明文模式\n1=>兼容模式\n2=>安全模式', 0, '', 0, 0, '\"0\"', '消息加解密方式', '如需使用安全模式请在管理中心修改，仅限服务号和认证订阅号', 0, 1);
INSERT INTO `eb_system_config` VALUES (17, 'wechat_encodingaeskey', 'text', 'input', 2, '', 0, 'required:true', 100, 0, '\"oSjQUZ8mjasrtRkki5DKp776o06wkLDK47Osa7YLQ6z\"', 'EncodingAESKey', '公众号消息加解密Key,在使用安全模式情况下要填写该值，请先在管理中心修改，然后填写该值，仅限服务号和认证订阅号', 0, 1);
INSERT INTO `eb_system_config` VALUES (18, 'wechat_share_img', 'upload', NULL, 2, NULL, 1, NULL, 0, 0, '\"https:\\/\\/oss.foodtrust.cn\\/\\/859a4202004250121543840.jpg\"', '微信分享图片', '若填写此图片地址，则分享网页出去时会分享此图片。可有效防止分享图片变形', 0, 1);
INSERT INTO `eb_system_config` VALUES (19, 'wechat_qrcode', 'upload', 'input', 2, '', 1, '', 0, 0, '\"https:\\/\\/oss.foodtrust.cn\\/\\/bb182202004250209263716.jpg\"', '公众号关注二维码', '公众号关注二维码', 0, 1);
INSERT INTO `eb_system_config` VALUES (20, 'wechat_type', 'radio', 'input', 2, '0=>服务号\n1=>订阅号', 0, '', 0, 0, '\"0\"', '公众号类型', '公众号的类型', 0, 1);
INSERT INTO `eb_system_config` VALUES (21, 'wechat_share_title', 'text', 'input', 2, NULL, NULL, 'required:true', 100, 0, '\"FOODTRUST\\u00ae \"', '微信分享标题', '微信分享标题', 0, 1);
INSERT INTO `eb_system_config` VALUES (22, 'wechat_share_synopsis', 'textarea', NULL, 2, NULL, NULL, NULL, 100, 5, '\"\\u8ba9\\u5065\\u5eb7\\u548c\\u53cb\\u5584\\u89e6\\u624b\\u53ef\\u53ca\"', '微信分享简介', '微信分享简介', 0, 1);
INSERT INTO `eb_system_config` VALUES (23, 'pay_weixin_appid', 'text', 'input', 4, '', 0, '', 100, 0, '\"wxff8cf329bc5ec6be\"', 'Appid', '微信公众号身份的唯一标识。审核通过后，在微信发送的邮件中查看。', 0, 1);
INSERT INTO `eb_system_config` VALUES (24, 'pay_weixin_appsecret', 'text', 'input', 4, '', 0, '', 100, 0, '\"afe523e9bcd47bdc320a3b336cee95f1\"', 'Appsecret', 'JSAPI接口中获取openid，审核后在公众平台开启开发模式后可查看。', 0, 1);
INSERT INTO `eb_system_config` VALUES (25, 'pay_weixin_mchid', 'text', 'input', 4, '', 0, '', 100, 0, '\"1253923601\"', 'Mchid', '受理商ID，身份标识', 0, 1);
INSERT INTO `eb_system_config` VALUES (26, 'pay_weixin_client_cert', 'upload', 'input', 4, '', 3, '', 0, 0, '\"\\/uploads\\/config\\/file\\/20200425\\/59538600bbe0c151040d6d25cc2a1404.pem\"', '微信支付证书', '微信支付证书，在微信商家平台中可以下载！文件名一般为apiclient_cert.pem', 0, 1);
INSERT INTO `eb_system_config` VALUES (27, 'pay_weixin_client_key', 'upload', 'input', 4, '', 3, '', 0, 0, '\"\\/uploads\\/config\\/file\\/20200425\\/9e956e1e26e345af3a7dca59d584c679.pem\"', '微信支付证书密钥', '微信支付证书密钥，在微信商家平台中可以下载！文件名一般为apiclient_key.pem', 0, 1);
INSERT INTO `eb_system_config` VALUES (28, 'pay_weixin_key', 'text', 'input', 4, '', 0, '', 100, 0, '\"afe523e9bcd47bdc320a3b336cee95f1\"', 'Key', '商户支付密钥Key。审核通过后，在微信发送的邮件中查看。', 0, 1);
INSERT INTO `eb_system_config` VALUES (29, 'pay_weixin_open', 'radio', 'input', 4, '1=>开启\n0=>关闭', 0, '', 0, 0, '\"1\"', '开启', '是否启用微信支付', 0, 1);
INSERT INTO `eb_system_config` VALUES (31, 'store_postage', 'text', 'input', 10, '', 0, 'number:true,min:0', 100, 0, '\"20\"', '邮费基础价', '商品邮费基础价格,最终金额为(基础价 + 商品1邮费 + 商品2邮费)', 0, 1);
INSERT INTO `eb_system_config` VALUES (32, 'store_free_postage', 'text', 'input', 10, '', 0, 'number:true,min:-1', 100, 0, '\"198\"', '满额包邮', '商城商品满多少金额即可包邮', 0, 1);
INSERT INTO `eb_system_config` VALUES (33, 'offline_postage', 'radio', 'input', 10, '0=>不包邮\n1=>包邮', 0, '', 0, 0, '\"0\"', '线下支付是否包邮', '用户选择线下支付时是否包邮', 0, 1);
INSERT INTO `eb_system_config` VALUES (34, 'integral_ratio', 'text', 'input', 11, '', 0, 'number:true', 100, 0, '\"0.01\"', '积分抵用比例', '积分抵用比例(1积分抵多少金额)', 0, 1);
INSERT INTO `eb_system_config` VALUES (35, 'site_service_phone', 'text', 'input', 1, '', 0, '', 100, 0, '\"\"', '客服电话', '客服联系电话', 0, 0);
INSERT INTO `eb_system_config` VALUES (44, 'store_user_min_recharge', 'text', 'input', 5, '', 0, 'required:true,number:true,min:0', 100, 0, '\"0.01\"', '用户最低充值金额', '用户单次最低充值金额', 0, 1);
INSERT INTO `eb_system_config` VALUES (46, 'system_express_app_code', 'text', 'input', 10, '', 0, '', 100, 0, '\"onmd7tdujxhf68xh5z4wblcgxtq7htgo\"', '快递查询密钥', '阿里云快递查询接口密钥购买地址：https://market.aliyun.com/products/56928004/cmapi021863.html', 0, 1);
INSERT INTO `eb_system_config` VALUES (47, 'main_business', 'text', 'input', 2, '', 0, 'required:true', 100, 0, '\" IT\\u79d1\\u6280 \\u4e92\\u8054\\u7f51|\\u7535\\u5b50\\u5546\\u52a1\"', '微信模板消息_主营行业', '微信公众号模板消息中选择开通的主营行业', 0, 0);
INSERT INTO `eb_system_config` VALUES (48, 'vice_business', 'text', 'input', 2, '', 0, 'required:true', 100, 0, '\"IT\\u79d1\\u6280 IT\\u8f6f\\u4ef6\\u4e0e\\u670d\\u52a1 \"', '微信模板消息_副营行业', '微信公众号模板消息中选择开通的副营行业', 0, 0);
INSERT INTO `eb_system_config` VALUES (49, 'store_brokerage_ratio', 'text', 'input', 9, '', 0, 'required:true,min:0,max:100,number:true', 100, 0, '\"4\"', '一级返佣比例', '订单交易成功后给上级返佣的比例0 - 100,例:5 = 反订单金额的5%', 5, 1);
INSERT INTO `eb_system_config` VALUES (53, 'user_extract_min_price', 'text', 'input', 9, '', 0, 'required:true,number:true,min:0', 100, 0, '\"499\"', '提现最低金额', '用户提现最低金额', 0, 1);
INSERT INTO `eb_system_config` VALUES (54, 'sx_sign_min_int', 'text', 'input', 11, '', 0, 'required:true,number:true,min:0', 100, 0, '\"1\"', '签到奖励最低积分', '签到奖励最低积分', 0, 2);
INSERT INTO `eb_system_config` VALUES (55, 'sx_sign_max_int', 'text', 'input', 11, '', 0, 'required:true,number:true,min:0', 100, 0, '\"5\"', '签到奖励最高积分', '签到奖励最高积分', 0, 2);
INSERT INTO `eb_system_config` VALUES (57, 'about_us', 'upload', NULL, 1, NULL, 1, NULL, 0, 0, '\"\"', '关于我们', '系统的标识', 0, 2);
INSERT INTO `eb_system_config` VALUES (58, 'replenishment_num', 'text', 'input', 5, '', 0, 'required:true,number:true,min:0', 100, 0, '\"9\"', '待补货数量', '商品待补货数量低于多少时，提示补货', 0, 1);
INSERT INTO `eb_system_config` VALUES (59, 'routine_appId', 'text', 'input', 7, '', 0, '', 100, 0, '\"wx178dff54752cf02b\"', 'appId', '小程序appID', 0, 1);
INSERT INTO `eb_system_config` VALUES (60, 'routine_appsecret', 'text', 'input', 7, '', 0, '', 100, 0, '\"f51d06d5c561f0bbe12bef062236547c\"', 'AppSecret', '小程序AppSecret', 0, 1);
INSERT INTO `eb_system_config` VALUES (61, 'api', 'text', 'input', 2, '', 0, '', 100, 0, '\"\\/api\\/wechat\\/serve\"', '接口地址', '微信接口例如：http://www.abc.com/api/wechat/serve', 0, 1);
INSERT INTO `eb_system_config` VALUES (62, 'paydir', 'textarea', 'input', 4, '', 0, '', 100, 5, '\"\"', '配置目录', '支付目录配置系统不调用提示作用', 0, 1);
INSERT INTO `eb_system_config` VALUES (73, 'routine_logo', 'upload', NULL, 7, NULL, 1, NULL, 0, 0, '\"https:\\/\\/oss.foodtrust.cn\\/\\/859a4202004250121543840.jpg\"', '小程序授权logo', '小程序授权logo', 0, 1);
INSERT INTO `eb_system_config` VALUES (74, 'routine_name', 'text', 'input', 7, '', 0, '', 100, 0, '\"\\u6709\\u673a\\u751f\\u6d3b\\u597d\\u7269\\u5206\\u4eab\"', '小程序名称', '小程序名称', 0, 1);
INSERT INTO `eb_system_config` VALUES (77, 'store_stock', 'text', 'input', 5, '', 0, '', 100, 0, '\"2\"', '警戒库存', '警戒库存提醒值', 0, 1);
INSERT INTO `eb_system_config` VALUES (85, 'stor_reason', 'textarea', 'input', 5, '', 0, '', 100, 8, '\"\\u5bf9\\u54c1\\u8d28\\u4e0d\\u6ee1\\u610f\\n\\u4fe1\\u606f\\u586b\\u9519\\u91cd\\u65b0\\u62cd\\n\\u6536\\u5230\\u5546\\u54c1\\u635f\\u574f\\u4e86\\n\\u672a\\u6309\\u9884\\u5b9a\\u65f6\\u95f4\\u53d1\\u8d27\\n\\u5176\\u5b83\\u539f\\u56e0\"', '退货理由', '配置退货理由，一行一个理由', 0, 1);
INSERT INTO `eb_system_config` VALUES (87, 'store_brokerage_two', 'text', 'input', 9, '', 0, 'required:true,min:0,max:100,number:true', 100, 0, '\"1\"', '二级返佣比例', '订单交易成功后给上级返佣的比例0 - 100,例:5 = 反订单金额的5%', 4, 1);
INSERT INTO `eb_system_config` VALUES (88, 'store_brokerage_statu', 'radio', 'input', 9, '1=>指定分销\n2=>人人分销', 0, '', 0, 0, '\"1\"', '分销模式', '人人分销默认每个人都可以分销，制定人分销后台制定人开启分销', 10, 1);
INSERT INTO `eb_system_config` VALUES (89, 'pay_routine_appid', 'text', 'input', 14, '', 0, 'required:true', 100, 0, '\"wx178dff54752cf02b\"', 'Appid', '小程序Appid', 0, 1);
INSERT INTO `eb_system_config` VALUES (90, 'pay_routine_appsecret', 'text', 'input', 14, '', 0, 'required:true', 100, 0, '\"f51d06d5c561f0bbe12bef062236547c\"', 'Appsecret', '小程序Appsecret', 0, 1);
INSERT INTO `eb_system_config` VALUES (91, 'pay_routine_mchid', 'text', 'input', 14, '', 0, 'required:true', 100, 0, '\"1253923601\"', 'Mchid', '商户号', 0, 1);
INSERT INTO `eb_system_config` VALUES (92, 'pay_routine_key', 'text', 'input', 14, '', 0, 'required:true', 100, 0, '\"afe523e9bcd47bdc320a3b336cee95f1\"', 'Key', '商户key', 0, 1);
INSERT INTO `eb_system_config` VALUES (93, 'pay_routine_client_cert', 'upload', 'input', 14, '', 3, '', 0, 0, '\"\\/uploads\\/config\\/file\\/20200425\\/e184c747388e408ab7b593326b80b7b9.pem\"', '小程序支付证书', '小程序支付证书', 0, 1);
INSERT INTO `eb_system_config` VALUES (94, 'pay_routine_client_key', 'upload', 'input', 14, '', 3, '', 0, 0, '\"\\/uploads\\/config\\/file\\/20200425\\/7324ecaaacff2daa182fcbe902623cfd.pem\"', '小程序支付证书密钥', '小程序支付证书密钥', 0, 1);
INSERT INTO `eb_system_config` VALUES (98, 'wechat_avatar', 'upload', 'input', 2, '', 1, '', 0, 0, '\"https:\\/\\/oss.foodtrust.cn\\/\\/859a4202004250121543840.jpg\"', 'H5登录logo', 'H5登录logo', 0, 1);
INSERT INTO `eb_system_config` VALUES (99, 'user_extract_bank', 'textarea', 'input', 9, '', 0, '', 100, 5, '\"\\u519c\\u4e1a\\u94f6\\u884c\\n\\u5efa\\u8bbe\\u94f6\\u884c\\n\\u4e2d\\u56fd\\u94f6\\u884c\\n\\u5de5\\u5546\\u94f6\\u884c\\n\\u62db\\u5546\\u94f6\\u884c\"', '提现银行卡', '提现银行卡，每个银行换行', 0, 1);
INSERT INTO `eb_system_config` VALUES (104, 'fast_number', 'text', 'input', 16, NULL, NULL, 'required:true,digits:true,min:1', 100, NULL, '\"10\"', '快速选择分类个数', '首页配置快速选择分类个数', 0, 1);
INSERT INTO `eb_system_config` VALUES (105, 'bast_number', 'text', 'input', 16, NULL, NULL, 'required:true,digits:true,min:1', 100, NULL, '\"10\"', '精品推荐个数', '首页配置精品推荐个数', 0, 1);
INSERT INTO `eb_system_config` VALUES (106, 'first_number', 'text', 'input', 16, NULL, NULL, 'required:true,digits:true,min:1', 100, NULL, '\"10\"', '首发新品个数', '首页配置首发新品个数', 0, 1);
INSERT INTO `eb_system_config` VALUES (107, 'routine_index_logo', 'upload', NULL, 5, NULL, 1, NULL, NULL, NULL, '\"https:\\/\\/oss.foodtrust.cn\\/\\/5c6cf202004250051322208.png\"', '首页顶部logo图标', '主页logo图标尺寸(127*45)', 0, 1);
INSERT INTO `eb_system_config` VALUES (108, 'upload_type', 'radio', 'input', 17, '1=>本地存储\n2=>七牛云存储\n3=>阿里云OSS\n4=>腾讯COS', NULL, NULL, NULL, NULL, '\"3\"', '上传类型', '文件上传的类型', 0, 1);
INSERT INTO `eb_system_config` VALUES (109, 'uploadUrl', 'text', 'input', 17, NULL, NULL, 'url:true', 100, NULL, '\"https:\\/\\/oss.foodtrust.cn\\/\"', '空间域名 Domain', '空间域名 Domain', 0, 1);
INSERT INTO `eb_system_config` VALUES (110, 'accessKey', 'text', 'input', 17, NULL, NULL, '', 100, NULL, '\"LTAIj8EUL5orY6N9\"', 'accessKey', 'accessKey', 0, 1);
INSERT INTO `eb_system_config` VALUES (111, 'secretKey', 'text', 'input', 17, NULL, NULL, '', 100, NULL, '\"ZtG0NkNq9MBLnmUuiXk0KzbeVLZzFl\"', 'secretKey', 'secretKey', 0, 1);
INSERT INTO `eb_system_config` VALUES (112, 'storage_name', 'text', 'input', 17, NULL, NULL, '', 100, NULL, '\"fc4\"', '存储空间名称', '存储空间名称', 0, 1);
INSERT INTO `eb_system_config` VALUES (113, 'order_cancel_time', 'text', 'input', 5, NULL, NULL, '', 100, NULL, '\"0.1\"', '普通商品未支付取消订单时间', '普通商品未支付取消订单时间，单位（小时）', 0, 1);
INSERT INTO `eb_system_config` VALUES (114, 'order_activity_time', 'text', 'input', 5, NULL, NULL, '', 100, NULL, '\"2\"', '活动商品未支付取消订单时间', '活动商品未支付取消订单时间，单位（小时）', 0, 1);
INSERT INTO `eb_system_config` VALUES (115, 'order_bargain_time', 'text', 'input', 5, NULL, NULL, NULL, 100, NULL, '\"24\"', '砍价未支付取消订单时间', '砍价未支付默认取消订单时间，单位（小时），如果为0将使用默认活动取消时间，优先使用单独活动配置', 0, 1);
INSERT INTO `eb_system_config` VALUES (116, 'order_seckill_time', 'text', 'input', 5, NULL, NULL, NULL, 100, NULL, '\"24\"', '秒杀未支付订单取消时间', '秒杀未支付订单取消时间，单位（小时），如果为0将使用默认活动取消时间，优先使用单独活动配置', 0, 1);
INSERT INTO `eb_system_config` VALUES (117, 'order_pink_time', 'text', 'input', 5, NULL, NULL, NULL, 100, NULL, '\"72\"', '拼团未支付取消订单时间', '拼团未支付取消订单时间,单位（小时），如果为0将使用默认活动取消时间，优先使用单独活动配置', 0, 1);
INSERT INTO `eb_system_config` VALUES (118, 'storage_region', 'text', 'input', 17, NULL, NULL, '', 100, NULL, '\"oss-cn-shenzhen.aliyuncs.com\"', '所属地域', '所属地域', 0, 1);
INSERT INTO `eb_system_config` VALUES (119, 'vip_open', 'radio', 'input', 5, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"1\"', '会员功能是否开启', '会员功能是否开启', 0, 1);
INSERT INTO `eb_system_config` VALUES (120, 'new_order_audio_link', 'upload', 'input', 5, NULL, 3, NULL, NULL, NULL, '\"\\/public\\/uploads\\/config\\/file\\/5cedd83eedba2.mp3\"', '新订单语音提示', '新订单语音提示', 0, 1);
INSERT INTO `eb_system_config` VALUES (122, 'system_delivery_time', 'text', 'input', 5, NULL, NULL, 'required:true,digits:true,min:0', 100, NULL, '\"1\"', '自动收货时间', '系统自动收货时间,单位(天),0为不设置自动收货', 0, 1);
INSERT INTO `eb_system_config` VALUES (123, 'sms_account', 'text', 'input', 18, NULL, NULL, '', 100, NULL, '\"foodtrust\"', '账号', '短信后台的登录账号', 0, 1);
INSERT INTO `eb_system_config` VALUES (137, 'sms_token', 'text', 'input', 18, NULL, NULL, '', 100, NULL, '\"Qwer1234temp\"', 'token/密码', 'token(注册时候的密码)', 0, 1);
INSERT INTO `eb_system_config` VALUES (138, 'h5_avatar', 'upload', NULL, 2, NULL, 1, NULL, 0, 0, '\"https:\\/\\/oss.foodtrust.cn\\/\\/9c9c2202004250136523040.png\"', '用户H5默认头像', '用户H5默认头像尺寸(80*80)', 0, 1);
INSERT INTO `eb_system_config` VALUES (139, 'offline_pay_status', 'radio', NULL, 5, '1=>开启\n2=>关闭', NULL, NULL, NULL, NULL, '\"2\"', '线下支付状态', '线下支付状态', 0, 1);
INSERT INTO `eb_system_config` VALUES (140, 'news_slides_limit', 'text', 'number', 1, NULL, NULL, 'required:true,digits:true,min:1', 100, NULL, '\"5\"', '新闻幻灯片限制数量', '新闻幻灯片限制数量', 0, 1);
INSERT INTO `eb_system_config` VALUES (141, 'recharge_switch', 'radio', 'input', 5, '1=>开启\n0=>关闭', NULL, NULL, NULL, NULL, '\"0\"', '小程序充值开关', '小程序充值开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (142, 'tengxun_map_key', 'text', 'input', 10, NULL, NULL, '', 100, NULL, '\"BZ7BZ-GNZR3-T7O3V-YP4Z3-M5O4H-OPFEH\"', '腾讯地图KEY', '腾讯地图KEY', 0, 1);
INSERT INTO `eb_system_config` VALUES (143, 'store_self_mention', 'radio', NULL, 10, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"1\"', '是否开启门店自提', '是否开启门店自提', 0, 1);
INSERT INTO `eb_system_config` VALUES (144, 'cache_config', 'text', 'input', 1, NULL, NULL, '', 100, NULL, '\"86400\"', '网站缓存时间', '配置全局缓存时间（秒），默认留空为永久缓存', 0, 1);
INSERT INTO `eb_system_config` VALUES (145, 'pay_success_printing_switch', 'radio', NULL, 21, '0=>关\n1=>开', NULL, NULL, NULL, NULL, '\"1\"', '支付成功订单打印开关', '支付成功订单打印开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (146, 'develop_id', 'text', 'input', 21, NULL, NULL, '', 100, NULL, '\"\"', '开发者ID', '易联云开发者ID', 0, 1);
INSERT INTO `eb_system_config` VALUES (147, 'printing_api_key', 'text', 'input', 21, NULL, NULL, '', 100, NULL, '\"\"', '应用密钥', '易联应用密钥', 0, 1);
INSERT INTO `eb_system_config` VALUES (148, 'printing_client_id', 'text', 'input', 21, NULL, NULL, '', 100, NULL, '\"\"', '应用ID', '易联应用ID', 0, 1);
INSERT INTO `eb_system_config` VALUES (149, 'terminal_number', 'text', 'input', 21, NULL, NULL, '', 100, NULL, '\"\"', '终端号', '易联云打印机终端号', 0, 1);
INSERT INTO `eb_system_config` VALUES (150, 'lower_order_switch', 'radio', NULL, 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"0\"', '支付成功提醒开关', '支付成功提醒开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (151, 'deliver_goods_switch', 'radio', NULL, 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"0\"', '发货提醒开关', '发货提醒开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (152, 'confirm_take_over_switch', 'radio', NULL, 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"0\"', '确认收货提醒开关', '确认收货提醒开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (153, 'admin_lower_order_switch', 'radio', NULL, 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"0\"', '用户下单管理员提醒开关', '用户下单管理员提醒开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (154, 'admin_pay_success_switch', 'radio', NULL, 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"0\"', '用户支付成功管理员提醒开关', '用户支付成功管理员提醒开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (155, 'admin_refund_switch', 'radio', NULL, 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"0\"', '用户退款管理员提醒开关', '用户退款管理员提醒开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (156, 'admin_confirm_take_over_switch', 'radio', NULL, 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"0\"', '用户确认收货管理员短信提醒', '用户确认收货管理员短信提醒', 0, 1);
INSERT INTO `eb_system_config` VALUES (157, 'new_goods_bananr', 'upload', NULL, 5, NULL, 1, NULL, NULL, NULL, '\"https:\\/\\/oss.foodtrust.cn\\/\\/d7e2d202004250057222459.jpg\"', '首发新品广告图（414*99）', '首发新品广告图', 0, 1);
INSERT INTO `eb_system_config` VALUES (158, 'recharge_attention', 'textarea', NULL, 5, NULL, NULL, NULL, 100, 5, '\"* \\u5145\\u503c\\u540e\\u5e10\\u6237\\u7684\\u91d1\\u989d\\u53ef\\u7528\\u4e8e\\u6d88\\u8d39\\u4f7f\\u7528\\n* \\u4f63\\u91d1\\u5bfc\\u5165\\u8d26\\u6237\\u4e4b\\u4e0d\\u80fd\\u518d\\u6b21\\u5bfc\\u51fa\\u63d0\\u73b0\\n* \\u8d26\\u6237\\u5145\\u503c\\u51fa\\u73b0\\u95ee\\u9898\\u8bf7\\u8054\\u7cfb\\u4e30\\u5de2\\u5c0f\\u871c\\n\\u4e30\\u5de2\\u5c0f\\u871c\\u624b\\u673a\\u5fae\\u4fe1\\u540c\\u53f718998382701\"', '充值注意事项', '充值注意事项', 0, 1);
INSERT INTO `eb_system_config` VALUES (159, 'extract_time', 'text', 'input', 9, NULL, NULL, '', 100, NULL, '\"30\"', '冻结时间', '佣金冻结时间(天)', 0, 1);
INSERT INTO `eb_system_config` VALUES (160, 'store_brokerage_price', 'text', 'input', 9, NULL, NULL, '', 100, NULL, '\"999\"', '人人分销满足金额', '人人分销满足金额开通分销权限', 0, 1);
INSERT INTO `eb_system_config` VALUES (162, 'price_revision_switch', 'radio', 'input', 20, '0=>关闭\n1=>开启', NULL, NULL, NULL, NULL, '\"1\"', '改价短信提醒开关', '改价短信提醒开关', 0, 1);
INSERT INTO `eb_system_config` VALUES (163, 'promotion_number', 'text', 'input', 16, '', NULL, 'required:true,digits:true,min:1', 100, NULL, '\"3\"', '促销单品个数', '小程序首页配置促销单品个数', 0, 1);

-- ----------------------------
-- Table structure for eb_system_config_tab
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_config_tab`;
CREATE TABLE `eb_system_config_tab`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置分类id',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '上级分类id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置分类名称',
  `eng_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置分类英文名称',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '配置分类状态',
  `info` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配置分类是否显示',
  `icon` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `type` int(2) NULL DEFAULT 0 COMMENT '配置类型',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_config_tab
-- ----------------------------
INSERT INTO `eb_system_config_tab` VALUES (1, 0, '基础配置', 'basics', 1, 0, 'cog', 0, 100);
INSERT INTO `eb_system_config_tab` VALUES (2, 22, '公众号配置', 'wechat', 1, 0, 'weixin', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (4, 23, '公众号支付配置', 'pay', 1, 0, 'jpy', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (5, 0, '商城配置', 'store', 1, 0, 'shopping-cart', 0, 90);
INSERT INTO `eb_system_config_tab` VALUES (7, 22, '小程序配置', 'routine', 1, 0, 'weixin', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (9, 0, '分销配置', 'fenxiao', 1, 0, 'sitemap', 3, 0);
INSERT INTO `eb_system_config_tab` VALUES (10, 0, '物流配置', 'express', 1, 0, 'motorcycle', 3, 0);
INSERT INTO `eb_system_config_tab` VALUES (11, 0, '积分配置', 'point', 1, 0, 'powerpoint-o', 3, 0);
INSERT INTO `eb_system_config_tab` VALUES (14, 23, '小程序支付配置', 'routine_pay', 1, 0, 'jpy', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (16, 0, '首页配置', 'routine_index_page', 1, 0, 'home', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (17, 0, '文件上传配置', 'upload_set', 1, 0, 'cloud-upload', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (18, 0, '短信配置', 'system_sms', 1, 0, 'send', 3, 0);
INSERT INTO `eb_system_config_tab` VALUES (20, 0, '短信提醒开关', 'short_letter_switch', 1, 0, 'rss', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (21, 0, '小票打印配置', 'printing_deploy', 1, 0, 'plug', 0, 0);
INSERT INTO `eb_system_config_tab` VALUES (22, 0, '应用配置', 'appconfig', 1, 0, 'whatsapp', 0, 80);
INSERT INTO `eb_system_config_tab` VALUES (23, 0, '支付配置', 'pay_config', 1, 0, 'credit-card', 0, 70);

-- ----------------------------
-- Table structure for eb_system_file
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_file`;
CREATE TABLE `eb_system_file`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文件对比ID',
  `cthash` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件内容',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文价名称',
  `atime` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '上次访问时间',
  `mtime` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '上次修改时间',
  `ctime` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '上次改变时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2187 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件对比表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_system_group
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_group`;
CREATE TABLE `eb_system_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合数据ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '数据组名称',
  `info` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '数据提示',
  `config_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '数据字段',
  `fields` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据组字段以及类型（json数据）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `config_name`(`config_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组合数据表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_group
-- ----------------------------
INSERT INTO `eb_system_group` VALUES (37, '拼团、秒杀、砍价顶部banner图', '拼团、秒杀、砍价顶部banner图', 'routine_lovely', '[{\"name\":\"\\u56fe\\u7247\",\"title\":\"img\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u63cf\\u8ff0\",\"title\":\"comment\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (38, '砍价列表页左上小图标', '砍价列表页左上小图标', 'bargain_banner', '[{\"name\":\"banner\",\"title\":\"banner\",\"type\":\"upload\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (47, '首页分类图标', '首页分类图标', 'routine_home_menus', '[{\"name\":\"\\u5206\\u7c7b\\u540d\\u79f0\",\"title\":\"name\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5206\\u7c7b\\u56fe\\u6807(90*90)\",\"title\":\"pic\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u8df3\\u8f6c\\u8def\\u5f84\",\"title\":\"url\",\"type\":\"select\",\"param\":\"\\/pages\\/index\\/index=>\\u5546\\u57ce\\u9996\\u9875\\n\\/pages\\/user_spread_user\\/index=>\\u4e2a\\u4eba\\u63a8\\u5e7f\\n\\/pages\\/user_sgin\\/index=>\\u6211\\u8981\\u7b7e\\u5230\\n\\/pages\\/user_get_coupon\\/index=>\\u4f18\\u60e0\\u5238\\n\\/pages\\/user\\/user=>\\u4e2a\\u4eba\\u4e2d\\u5fc3\\n\\/pages\\/activity\\/goods_seckill\\/index=>\\u79d2\\u6740\\u5217\\u8868\\n\\/pages\\/activity\\/goods_combination\\/index=>\\u62fc\\u56e2\\u5217\\u8868\\u9875\\n\\/pages\\/activity\\/goods_bargain\\/index=>\\u780d\\u4ef7\\u5217\\u8868\\n\\/pages\\/goods_cate\\/goods_cate=>\\u5206\\u7c7b\\u9875\\u9762\\n\\/pages\\/user_address_list\\/index=>\\u5730\\u5740\\u5217\\u8868\\n\\/pages\\/user_cash\\/index=>\\u63d0\\u73b0\\u9875\\u9762\\n\\/pages\\/promoter-list\\/index=>\\u63a8\\u5e7f\\u7edf\\u8ba1\\n\\/pages\\/user_money\\/index=>\\u8d26\\u6237\\u91d1\\u989d\\n\\/pages\\/user_goods_collection\\/index=>\\u6211\\u7684\\u6536\\u85cf\\n\\/pages\\/promotion-card\\/promotion-card=>\\u63a8\\u5e7f\\u4e8c\\u7ef4\\u7801\\u9875\\u9762\\n\\/pages\\/order_addcart\\/order_addcart=>\\u8d2d\\u7269\\u8f66\\u9875\\u9762\\n\\/pages\\/order_list\\/index=>\\u8ba2\\u5355\\u5217\\u8868\\u9875\\u9762\\n\\/pages\\/news_list\\/index=>\\u6587\\u7ae0\\u5217\\u8868\\u9875\"},{\"name\":\"\\u5e95\\u90e8\\u83dc\\u5355\",\"title\":\"show\",\"type\":\"radio\",\"param\":\"1=>\\u662f\\n2=>\\u5426\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u8df3\\u8f6c\\u8def\\u5f84\",\"title\":\"wap_url\",\"type\":\"select\",\"param\":\"\\/=>\\u5546\\u57ce\\u9996\\u9875\\n\\/user\\/user_promotion=>\\u4e2a\\u4eba\\u63a8\\u5e7f\\n\\/user\\/sign=>\\u6211\\u8981\\u7b7e\\u5230\\n\\/user\\/get_coupon=>\\u4f18\\u60e0\\u5238\\n\\/user=>\\u4e2a\\u4eba\\u4e2d\\u5fc3\\n\\/activity\\/goods_seckill=>\\u79d2\\u6740\\u5217\\u8868\\n\\/activity\\/group=>\\u62fc\\u56e2\\u5217\\u8868\\u9875\\n\\/activity\\/bargain=>\\u780d\\u4ef7\\u5217\\u8868\\n\\/category=>\\u5206\\u7c7b\\u9875\\u9762\\n\\/user\\/add_manage=>\\u5730\\u5740\\u5217\\u8868\\n\\/user\\/user_cash=>\\u63d0\\u73b0\\u9875\\u9762\\n\\/user\\/promoter_list=>\\u63a8\\u5e7f\\u7edf\\u8ba1\\n\\/user\\/account=>\\u8d26\\u6237\\u91d1\\u989d\\n\\/collection=>\\u6211\\u7684\\u6536\\u85cf\\n\\/user\\/poster=>\\u63a8\\u5e7f\\u4e8c\\u7ef4\\u7801\\u9875\\u9762\\n\\/cart=>\\u8d2d\\u7269\\u8f66\\u9875\\u9762\\n\\/order\\/list\\/=>\\u8ba2\\u5355\\u5217\\u8868\\u9875\\u9762\\n\\/news_list=>\\u6587\\u7ae0\\u5217\\u8868\\u9875\"}]');
INSERT INTO `eb_system_group` VALUES (48, '首页banner滚动图', '首页banner滚动图', 'routine_home_banner', '[{\"name\":\"\\u6807\\u9898\",\"title\":\"name\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u94fe\\u63a5\",\"title\":\"url\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u56fe\\u7247(750*375)\",\"title\":\"pic\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u94fe\\u63a5\",\"title\":\"wap_url\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (49, '秒杀时间段', '秒杀时间段', 'routine_seckill_time', '[{\"name\":\"\\u5f00\\u542f\\u65f6\\u95f4(\\u6574\\u6570\\u5c0f\\u65f6)\",\"title\":\"time\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u6301\\u7eed\\u65f6\\u95f4(\\u6574\\u6570\\u5c0f\\u65f6)\",\"title\":\"continued\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5e7b\\u706f\\u7247\",\"title\":\"slide\",\"type\":\"upload\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (50, '首页滚动新闻', '首页滚动新闻', 'routine_home_roll_news', '[{\"name\":\"\\u6eda\\u52a8\\u6587\\u5b57\",\"title\":\"info\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u8df3\\u8f6c\\u8def\\u5f84\",\"title\":\"url\",\"type\":\"select\",\"param\":\"\\/pages\\/index\\/index=>\\u5546\\u57ce\\u9996\\u9875\\n\\/pages\\/user_spread_user\\/index=>\\u4e2a\\u4eba\\u63a8\\u5e7f\\n\\/pages\\/user_sgin\\/index=>\\u6211\\u8981\\u7b7e\\u5230\\n\\/pages\\/user_get_coupon\\/index=>\\u4f18\\u60e0\\u5238\\n\\/pages\\/user\\/user=>\\u4e2a\\u4eba\\u4e2d\\u5fc3\\n\\/pages\\/activity\\/goods_seckill\\/index=>\\u79d2\\u6740\\u5217\\u8868\\n\\/pages\\/activity\\/goods_combination\\/index=>\\u62fc\\u56e2\\u5217\\u8868\\u9875\\n\\/pages\\/activity\\/goods_bargain\\/index=>\\u780d\\u4ef7\\u5217\\u8868\\n\\/pages\\/goods_cate\\/goods_cate=>\\u5206\\u7c7b\\u9875\\u9762\\n\\/pages\\/user_address_list\\/index=>\\u5730\\u5740\\u5217\\u8868\\n\\/pages\\/user_cash\\/index=>\\u63d0\\u73b0\\u9875\\u9762\\n\\/pages\\/promoter-list\\/index=>\\u63a8\\u5e7f\\u7edf\\u8ba1\\n\\/pages\\/user_money\\/index=>\\u8d26\\u6237\\u91d1\\u989d\\n\\/pages\\/user_goods_collection\\/index=>\\u6211\\u7684\\u6536\\u85cf\\n\\/pages\\/promotion-card\\/promotion-card=>\\u63a8\\u5e7f\\u4e8c\\u7ef4\\u7801\\u9875\\u9762\\n\\/pages\\/order_addcart\\/order_addcart=>\\u8d2d\\u7269\\u8f66\\u9875\\u9762\\n\\/pages\\/order_list\\/index=>\\u8ba2\\u5355\\u5217\\u8868\\u9875\\u9762\\n\\/pages\\/news_list\\/index=>\\u6587\\u7ae0\\u5217\\u8868\\u9875\"},{\"name\":\"\\u5e95\\u90e8\\u83dc\\u5355\",\"title\":\"show\",\"type\":\"radio\",\"param\":\"1=>\\u662f\\n2=>\\u5426\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u8df3\\u8f6c\\u8def\\u5f84\",\"title\":\"wap_url\",\"type\":\"select\",\"param\":\"\\/=>\\u5546\\u57ce\\u9996\\u9875\\n\\/user\\/user_promotion=>\\u4e2a\\u4eba\\u63a8\\u5e7f\\n\\/user\\/sign=>\\u6211\\u8981\\u7b7e\\u5230\\n\\/user\\/get_coupon=>\\u4f18\\u60e0\\u5238\\n\\/user=>\\u4e2a\\u4eba\\u4e2d\\u5fc3\\n\\/activity\\/goods_seckill=>\\u79d2\\u6740\\u5217\\u8868\\n\\/activity\\/group=>\\u62fc\\u56e2\\u5217\\u8868\\u9875\\n\\/activity\\/bargain=>\\u780d\\u4ef7\\u5217\\u8868\\n\\/category=>\\u5206\\u7c7b\\u9875\\u9762\\n\\/user\\/add_manage=>\\u5730\\u5740\\u5217\\u8868\\n\\/user\\/user_cash=>\\u63d0\\u73b0\\u9875\\u9762\\n\\/user\\/promoter_list=>\\u63a8\\u5e7f\\u7edf\\u8ba1\\n\\/user\\/account=>\\u8d26\\u6237\\u91d1\\u989d\\n\\/collection=>\\u6211\\u7684\\u6536\\u85cf\\n\\/user\\/poster=>\\u63a8\\u5e7f\\u4e8c\\u7ef4\\u7801\\u9875\\u9762\\n\\/cart=>\\u8d2d\\u7269\\u8f66\\u9875\\u9762\\n\\/order\\/list\\/=>\\u8ba2\\u5355\\u5217\\u8868\\u9875\\u9762\\n\\/news_list=>\\u6587\\u7ae0\\u5217\\u8868\\u9875\"}]');
INSERT INTO `eb_system_group` VALUES (51, '首页活动区域图片', '首页活动区域图片', 'routine_home_activity', '[{\"name\":\"\\u56fe\\u7247(260*260\\/416*214)\",\"title\":\"pic\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u6807\\u9898\",\"title\":\"title\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u7b80\\u4ecb\",\"title\":\"info\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u94fe\\u63a5\",\"title\":\"link\",\"type\":\"select\",\"param\":\"\\/pages\\/activity\\/goods_seckill\\/index=>\\u79d2\\u6740\\u5217\\u8868\\n\\/pages\\/activity\\/goods_bargain\\/index=>\\u780d\\u4ef7\\u5217\\u8868\\n\\/pages\\/activity\\/goods_combination\\/index=>\\u62fc\\u56e2\\u5217\\u8868\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u94fe\\u63a5\",\"title\":\"wap_link\",\"type\":\"select\",\"param\":\"\\/activity\\/goods_seckill=>\\u79d2\\u6740\\u5217\\u8868\\n\\/activity\\/bargain=>\\u780d\\u4ef7\\u5217\\u8868\\n\\/activity\\/group=>\\u62fc\\u56e2\\u5217\\u8868\"}]');
INSERT INTO `eb_system_group` VALUES (52, '首页精品推荐benner图', '首页精品推荐benner图', 'routine_home_bast_banner', '[{\"name\":\"\\u56fe\\u7247\",\"title\":\"img\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u63cf\\u8ff0\",\"title\":\"comment\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u8df3\\u8f6c\\u94fe\\u63a5\",\"title\":\"link\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u8df3\\u8f6c\\u94fe\\u63a5\",\"title\":\"wap_link\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (53, '订单详情状态图', '订单详情状态图', 'order_details_images', '[{\"name\":\"\\u8ba2\\u5355\\u72b6\\u6001\",\"title\":\"order_status\",\"type\":\"select\",\"param\":\"0=>\\u672a\\u652f\\u4ed8\\n1=>\\u5f85\\u53d1\\u8d27\\n2=>\\u5f85\\u6536\\u8d27\\n3=>\\u5f85\\u8bc4\\u4ef7\\n4=>\\u5df2\\u5b8c\\u6210\\n9=>\\u7ebf\\u4e0b\\u4ed8\\u6b3e\"},{\"name\":\"\\u56fe\\u6807\",\"title\":\"pic\",\"type\":\"upload\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (54, '个人中心菜单', '个人中心菜单', 'routine_my_menus', '[{\"name\":\"\\u83dc\\u5355\\u540d\",\"title\":\"name\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u56fe\\u6807(52*52)\",\"title\":\"pic\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u8df3\\u8f6c\\u8def\\u5f84\",\"title\":\"url\",\"type\":\"select\",\"param\":\"\\/pages\\/user_address_list\\/index=>\\u5730\\u5740\\u7ba1\\u7406\\n\\/pages\\/user_vip\\/index=>\\u4f1a\\u5458\\u4e2d\\u5fc3\\n\\/pages\\/activity\\/user_goods_bargain_list\\/index=>\\u780d\\u4ef7\\u8bb0\\u5f55\\n\\/pages\\/user_spread_user\\/index=>\\u63a8\\u5e7f\\u4e2d\\u5fc3\\n\\/pages\\/user_money\\/index=>\\u6211\\u7684\\u4f59\\u989d\\n\\/pages\\/user_goods_collection\\/index=>\\u6211\\u7684\\u6536\\u85cf\\n\\/pages\\/user_coupon\\/index=>\\u4f18\\u60e0\\u5238\\n\\/pages\\/admin\\/order\\/index=>\\u540e\\u53f0\\u8ba2\\u5355\\u7ba1\\u7406\\n\\/pages\\/service\\/index=>\\u8054\\u7cfb\\u5ba2\\u670d\\n\\/pages\\/admin\\/order_cancellation\\/index=>\\u8ba2\\u5355\\u6838\\u9500\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u8df3\\u8f6c\\u8def\\u5f84\",\"title\":\"wap_url\",\"type\":\"select\",\"param\":\"\\/user\\/add_manage=>\\u5730\\u5740\\u7ba1\\u7406\\n\\/user\\/vip=>\\u4f1a\\u5458\\u4e2d\\u5fc3\\n\\/activity\\/bargain\\/record=>\\u780d\\u4ef7\\u8bb0\\u5f55\\n\\/user\\/user_promotion=>\\u63a8\\u5e7f\\u4e2d\\u5fc3\\n\\/user\\/account=>\\u6211\\u7684\\u4f59\\u989d\\n\\/collection=>\\u6211\\u7684\\u6536\\u85cf\\n\\/user\\/user_coupon=>\\u4f18\\u60e0\\u5238\\n\\/customer\\/list=>\\u5ba2\\u670d\\u5217\\u8868\\n\\/customer\\/index=>\\u540e\\u53f0\\u8ba2\\u5355\\u7ba1\\u7406\\n\\/order\\/order_cancellation=>\\u8ba2\\u5355\\u6838\\u9500\"}]');
INSERT INTO `eb_system_group` VALUES (55, '签到天数配置', '签到天数配置', 'sign_day_num', '[{\"name\":\"\\u7b2c\\u51e0\\u5929\",\"title\":\"day\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u83b7\\u53d6\\u79ef\\u5206\",\"title\":\"sign_num\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (56, '热门搜索', '热门搜索', 'routine_hot_search', '[{\"name\":\"\\u6807\\u7b7e\",\"title\":\"title\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (57, '热门榜单推荐图片', '热门榜单推荐图片', 'routine_home_hot_banner', '[{\"name\":\"\\u56fe\\u7247\",\"title\":\"img\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u63cf\\u8ff0\",\"title\":\"comment\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (58, '首发新品推荐图片', '首发新品推荐图片', 'routine_home_new_banner', '[{\"name\":\"\\u56fe\\u7247\",\"title\":\"img\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u63cf\\u8ff0\",\"title\":\"comment\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u8df3\\u8f6c\\u94fe\\u63a5\",\"title\":\"link\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u8df3\\u8f6c\\u94fe\\u63a5\",\"title\":\"wap_link\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (59, '促销单品推荐图片', '促销单品推荐图片', 'routine_home_benefit_banner', '[{\"name\":\"\\u56fe\\u7247\",\"title\":\"img\",\"type\":\"upload\",\"param\":\"\"},{\"name\":\"\\u63cf\\u8ff0\",\"title\":\"comment\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u5c0f\\u7a0b\\u5e8f\\u8df3\\u8f6c\\u94fe\\u63a5\",\"title\":\"link\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u516c\\u4f17\\u53f7\\u8df3\\u8f6c\\u94fe\\u63a5\",\"title\":\"wap_link\",\"type\":\"input\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (60, '分享海报', '分享海报', 'routine_spread_banner', '[{\"name\":\"\\u540d\\u79f0\",\"title\":\"title\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u80cc\\u666f\\u56fe\",\"title\":\"pic\",\"type\":\"upload\",\"param\":\"\"}]');
INSERT INTO `eb_system_group` VALUES (61, '首页文字配置', '首页文字配置', 'routine_index_page', '[{\"name\":\"\\u5feb\\u901f\\u9009\\u62e9\\u7b80\\u4ecb\",\"title\":\"fast_info\",\"type\":\"input\",\"param\":\"\\u4e0a\\u767e\\u79cd\\u5546\\u54c1\\u5206\\u7c7b\\u4efb\\u60a8\\u9009\\u62e9\"},{\"name\":\"\\u7cbe\\u54c1\\u63a8\\u8350\\u7b80\\u4ecb\",\"title\":\"bast_info\",\"type\":\"input\",\"param\":\"\\u8bda\\u610f\\u63a8\\u8350\\u54c1\\u8d28\\u5546\\u54c1\"},{\"name\":\"\\u9996\\u53d1\\u65b0\\u54c1\\u7b80\\u4ecb\",\"title\":\"first_info\",\"type\":\"input\",\"param\":\"\\u591a\\u4e2a\\u4f18\\u8d28\\u5546\\u54c1\\u6700\\u65b0\\u4e0a\\u67b6\"},{\"name\":\"\\u4fc3\\u9500\\u5355\\u54c1\\u7b80\\u4ecb\",\"title\":\"sales_info\",\"type\":\"input\",\"param\":\"\\u5e93\\u5b58\\u5546\\u54c1\\u4f18\\u60e0\\u4fc3\\u9500\\u6d3b\\u52a8\"}]');
INSERT INTO `eb_system_group` VALUES (62, '充值金额设置', '设置充值金额额度选择', 'user_recharge_quota', '[{\"name\":\"\\u552e\\u4ef7\",\"title\":\"price\",\"type\":\"input\",\"param\":\"\"},{\"name\":\"\\u8d60\\u9001\",\"title\":\"give_money\",\"type\":\"input\",\"param\":\"\"}]');

-- ----------------------------
-- Table structure for eb_system_group_data
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_group_data`;
CREATE TABLE `eb_system_group_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合数据详情ID',
  `gid` int(11) NOT NULL DEFAULT 0 COMMENT '对应的数据组id',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据组对应的数据值（json数据）',
  `add_time` int(10) NOT NULL DEFAULT 0 COMMENT '添加数据时间',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '数据排序',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态（1：开启；2：关闭；）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组合数据详情表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_group_data
-- ----------------------------
INSERT INTO `eb_system_group_data` VALUES (89, 38, '{\"banner\":{\"type\":\"upload\",\"value\":\"http:\\/\\/datong.crmeb.net\\/public\\/uploads\\/attach\\/2019\\/01\\/15\\/5c3dc730dead2.png\"}}', 1527153599, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (91, 37, '{\"img\":{\"type\":\"upload\",\"value\":\"http:\\/\\/www.crmeb3.net\\/uploads\\/config\\/image\\/20190712\\/9a79a97de87d099f4e3a07ddff11a229.png\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u79d2\\u6740\\u5217\\u8868\\u9876\\u90e8baaner\"}}', 1528688012, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (99, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u6240\\u6709\\u4ea7\\u54c1\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/0c4ec202004250358016966.gif\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/goods_cate\\/goods_cate\"},\"show\":{\"type\":\"radio\",\"value\":\"1\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/category\"}}', 1533721963, 8, 1);
INSERT INTO `eb_system_group_data` VALUES (100, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u8282\\u6c14\\u795e\\u5238\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/14532202004250359139546.gif\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_get_coupon\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/user\\/get_coupon\"}}', 1533722009, 7, 1);
INSERT INTO `eb_system_group_data` VALUES (101, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u597d\\u7269\\u80cc\\u540e\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/dddf6202004250401001173.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/news_list\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/news_list\"}}', 1533722037, 6, 1);
INSERT INTO `eb_system_group_data` VALUES (102, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u6211\\u8981\\u7b7e\\u5230\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/c45ac202004250404047597.gif\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_sgin\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/user\\/sign\"}}', 1533722063, 5, 1);
INSERT INTO `eb_system_group_data` VALUES (104, 48, '{\"name\":{\"type\":\"input\",\"value\":\"banner-1\"},\"url\":{\"type\":\"input\",\"value\":\"pages\\/news_list\\/index\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/8322720200425033706535.jpg\"},\"wap_url\":{\"type\":\"input\",\"value\":\"\\/news_list\"}}', 1533722286, 10, 1);
INSERT INTO `eb_system_group_data` VALUES (105, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u6211\\u7684\\u6536\\u85cf\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/7ec90202004250404568624.gif\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_goods_collection\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/collection\"}}', 1533797064, 5, 1);
INSERT INTO `eb_system_group_data` VALUES (113, 49, '{\"time\":{\"type\":\"input\",\"value\":\"5\"},\"continued\":{\"type\":\"input\",\"value\":\"2\"}}', 1552443280, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (114, 49, '{\"time\":{\"type\":\"input\",\"value\":\"7\"},\"continued\":{\"type\":\"input\",\"value\":\"3\"}}', 1552443293, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (115, 49, '{\"time\":{\"type\":\"input\",\"value\":\"10\"},\"continued\":{\"type\":\"input\",\"value\":\"2\"}}', 1552443304, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (116, 49, '{\"time\":{\"type\":\"input\",\"value\":\"12\"},\"continued\":{\"type\":\"input\",\"value\":\"2\"}}', 1552481140, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (117, 49, '{\"time\":{\"type\":\"input\",\"value\":\"14\"},\"continued\":{\"type\":\"input\",\"value\":\"2\"}}', 1552481146, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (118, 49, '{\"time\":{\"type\":\"input\",\"value\":\"16\"},\"continued\":{\"type\":\"input\",\"value\":\"2\"}}', 1552481151, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (119, 49, '{\"time\":{\"type\":\"input\",\"value\":\"18\"},\"continued\":{\"type\":\"input\",\"value\":\"2\"}}', 1552481157, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (120, 49, '{\"time\":{\"type\":\"input\",\"value\":\"20\"},\"continued\":{\"type\":\"input\",\"value\":\"9\"}}', 1552481163, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (121, 50, '{\"info\":{\"type\":\"input\",\"value\":\"\\u4e30\\u5de2\\u6709\\u673a\\u5546\\u5e97 V4.1 \\u5373\\u5c06\\u4e0a\\u7ebf\\uff01\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/news_list\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/news_list\"}}', 1552611989, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (122, 50, '{\"info\":{\"type\":\"input\",\"value\":\"5.1-5.3\\u65e5\\u653e\\u5047\\u4e09\\u5929\\uff0c\\u8ba2\\u5355\\u5904\\u7406\\u987a\\u5ef6\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/news_list\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/news_list\"}}', 1552612003, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (124, 51, '{\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/8240d202004250940439202.jpg\"},\"title\":{\"type\":\"input\",\"value\":\"\\u5171\\u8d2d\\u62fc\\u56e2\"},\"info\":{\"type\":\"input\",\"value\":\"\\u60e0\\u4eba\\u5229\\u5df1\"},\"link\":{\"type\":\"select\",\"value\":\"\\/pages\\/activity\\/goods_combination\\/index\"},\"wap_link\":{\"type\":\"select\",\"value\":\"\\/activity\\/group\"}}', 1552620002, 3, 1);
INSERT INTO `eb_system_group_data` VALUES (125, 51, '{\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/7e77e202004250940496399.jpg\"},\"title\":{\"type\":\"input\",\"value\":\"\\u534f\\u529b\\u780d\\u4ef7\"},\"info\":{\"type\":\"input\",\"value\":\"\\u547c\\u670b\\u5524\\u53cb\"},\"link\":{\"type\":\"select\",\"value\":\"\\/pages\\/activity\\/goods_bargain\\/index\"},\"wap_link\":{\"type\":\"select\",\"value\":\"\\/activity\\/bargain\"}}', 1552620022, 2, 1);
INSERT INTO `eb_system_group_data` VALUES (126, 51, '{\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/09ee3202004250940532165.jpg\"},\"title\":{\"type\":\"input\",\"value\":\"\\u5b9a\\u65f6\\u79d2\\u6740\"},\"info\":{\"type\":\"input\",\"value\":\"\\u5149\\u9634\\u5982\\u91d1\"},\"link\":{\"type\":\"select\",\"value\":\"\\/pages\\/activity\\/goods_seckill\\/index\"},\"wap_link\":{\"type\":\"select\",\"value\":\"\\/activity\\/goods_seckill\"}}', 1552620041, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (127, 52, '{\"img\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/98517202004250933362595.jpg\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u7cbe\\u54c1\\u63a8\\u83501\"},\"link\":{\"type\":\"input\",\"value\":\"\\/pages\\/first-new-product\\/index\"},\"wap_link\":{\"type\":\"input\",\"value\":\"\\/hot_new_goods\\/1\"}}', 1552633893, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (128, 52, '{\"img\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/d13cb202004250935335429.jpg\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u7cbe\\u54c1\\u63a8\\u83502\"},\"link\":{\"type\":\"input\",\"value\":\"\\/pages\\/first-new-product\\/index\"},\"wap_link\":{\"type\":\"input\",\"value\":\"\\/hot_new_goods\\/1\"}}', 1552633912, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (135, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u4f1a\\u5458\\u4e2d\\u5fc3\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/06322202004252022151781.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_vip\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/user\\/vip\"}}', 1553779918, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (136, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u780d\\u4ef7\\u8bb0\\u5f55\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/e0792202004252022151244.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/activity\\/user_goods_bargain_list\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/activity\\/bargain\\/record\"}}', 1553779935, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (137, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u6211\\u7684\\u63a8\\u5e7f\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/d9975202004252022152724.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_spread_user\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/user\\/user_promotion\"}}', 1553779950, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (138, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u6211\\u7684\\u4f59\\u989d\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/b1a09202004252022154002.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_money\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/user\\/account\"}}', 1553779973, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (139, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u5730\\u5740\\u4fe1\\u606f\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/24282202004252022154243.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_address_list\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/user\\/add_manage\"}}', 1553779988, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (140, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u6211\\u7684\\u6536\\u85cf\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/668b4202004252022156019.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_goods_collection\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/collection\"}}', 1553780003, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (141, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u4f18\\u60e0\\u5238\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/89131202004252022154902.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/user_coupon\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/user\\/user_coupon\"}}', 1553780017, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (142, 53, '{\"order_status\":{\"type\":\"select\",\"value\":\"0\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/6f97f202004250415171693.gif\"}}', 1553780202, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (143, 53, '{\"order_status\":{\"type\":\"select\",\"value\":\"1\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/27e5f202004250415175691.gif\"}}', 1553780210, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (144, 53, '{\"order_status\":{\"type\":\"select\",\"value\":\"2\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/e1017202004250415175972.gif\"}}', 1553780221, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (145, 53, '{\"order_status\":{\"type\":\"select\",\"value\":\"3\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/18665202004250415176069.gif\"}}', 1553780230, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (146, 53, '{\"order_status\":{\"type\":\"select\",\"value\":\"4\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/c67b3202004250415173509.gif\"}}', 1553780237, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (147, 55, '{\"day\":{\"type\":\"input\",\"value\":\"\\u7b2c\\u4e00\\u5929\"},\"sign_num\":{\"type\":\"input\",\"value\":\"10\"}}', 1553780276, 100, 1);
INSERT INTO `eb_system_group_data` VALUES (148, 55, '{\"day\":{\"type\":\"input\",\"value\":\"\\u7b2c\\u4e8c\\u5929\"},\"sign_num\":{\"type\":\"input\",\"value\":\"20\"}}', 1553780292, 99, 1);
INSERT INTO `eb_system_group_data` VALUES (149, 55, '{\"day\":{\"type\":\"input\",\"value\":\"\\u7b2c\\u4e09\\u5929\"},\"sign_num\":{\"type\":\"input\",\"value\":\"30\"}}', 1553780303, 90, 1);
INSERT INTO `eb_system_group_data` VALUES (150, 55, '{\"day\":{\"type\":\"input\",\"value\":\"\\u7b2c\\u56db\\u5929\"},\"sign_num\":{\"type\":\"input\",\"value\":\"40\"}}', 1553780334, 60, 1);
INSERT INTO `eb_system_group_data` VALUES (151, 55, '{\"day\":{\"type\":\"input\",\"value\":\"\\u7b2c\\u4e94\\u5929\"},\"sign_num\":{\"type\":\"input\",\"value\":\"50\"}}', 1553780351, 50, 1);
INSERT INTO `eb_system_group_data` VALUES (152, 55, '{\"day\":{\"type\":\"input\",\"value\":\"\\u7b2c\\u516d\\u5929\"},\"sign_num\":{\"type\":\"input\",\"value\":\"60\"}}', 1553780364, 40, 1);
INSERT INTO `eb_system_group_data` VALUES (153, 55, '{\"day\":{\"type\":\"input\",\"value\":\"\\u5956\\u52b1\"},\"sign_num\":{\"type\":\"input\",\"value\":\"110\"}}', 1553780389, 10, 1);
INSERT INTO `eb_system_group_data` VALUES (154, 57, '{\"img\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/6db83202004250915485157.jpg\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u5de2\\u4e2d\\u597d\\u72691\"}}', 1553780856, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (155, 58, '{\"img\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/f656b202004250919289976.jpg\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u65b0\\u54c1\\u5c1d\\u9c9c\"},\"link\":{\"type\":\"input\",\"value\":\"#\"},\"wap_link\":{\"type\":\"input\",\"value\":\"#\"}}', 1553780869, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (156, 59, '{\"img\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/d484d202004250954246867.jpg\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u65f6\\u4ee4\\u63a8\\u8350\"},\"link\":{\"type\":\"input\",\"value\":\"#\"},\"wap_link\":{\"type\":\"input\",\"value\":\"#\"}}', 1553780883, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (158, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u62fc\\u56e2\\u5171\\u8d2d\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/49597202004250405242603.gif\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/activity\\/goods_combination\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/activity\\/group\"}}', 1553849878, 3, 1);
INSERT INTO `eb_system_group_data` VALUES (159, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u5b9a\\u65f6\\u79d2\\u6740\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/39b93202004250406089120.gif\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/activity\\/goods_seckill\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/activity\\/goods_seckill\"}}', 1553849905, 2, 1);
INSERT INTO `eb_system_group_data` VALUES (160, 47, '{\"name\":{\"type\":\"input\",\"value\":\"\\u534f\\u529b\\u780d\\u4ef7\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/c6ffb202004250406587394.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/activity\\/goods_bargain\\/index\"},\"show\":{\"type\":\"radio\",\"value\":\"2\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/activity\\/bargain\"}}', 1553850093, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (161, 60, '{\"title\":{\"type\":\"input\",\"value\":\"\\u5206\\u4eab\\u6d77\\u62a5-\\u60a8\\u597d2019\"},\"pic\":{\"type\":\"upload\",\"value\":\"http:\\/\\/kaifa.crmeb.net\\/uploads\\/attach\\/2019\\/08\\/20190810\\/887960975abc9a89e410db82e0089680.jpg\"}}', 1553866489, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (167, 60, '{\"title\":{\"type\":\"input\",\"value\":\"\\u5206\\u4eab\\u6d77\\u62a5-\\u9080\\u8bf7\\u597d\\u53cb\\u8d5a\\u5927\\u94b1\"},\"pic\":{\"type\":\"upload\",\"value\":\"http:\\/\\/kaifa.crmeb.net\\/uploads\\/attach\\/2019\\/08\\/20190810\\/623a4c225738606e4c65f93217050c86.jpg\"}}', 1555063900, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (168, 60, '{\"title\":{\"type\":\"input\",\"value\":\"\\u5206\\u4eab\\u6d77\\u62a5-\\u5206\\u4eab\\u5c31\\u8d5a\\u94b1\"},\"pic\":{\"type\":\"upload\",\"value\":\"http:\\/\\/kaifa.crmeb.net\\/uploads\\/attach\\/2019\\/08\\/20190810\\/93669bff568cf8eb967670d9cd3ca78c.jpg\"}}', 1555067377, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (169, 57, '{\"img\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/372ad202004251014538878.jpg\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u5de2\\u4e2d\\u597d\\u72692\"}}', 1560149769, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (170, 37, '{\"img\":{\"type\":\"upload\",\"value\":\"http:\\/\\/www.crmeb3.net\\/uploads\\/config\\/image\\/20190712\\/9a79a97de87d099f4e3a07ddff11a229.png\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u79d2\\u6740\\u5217\\u8868\\u9876\\u90e8baaner\"}}', 1562900433, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (171, 37, '{\"img\":{\"type\":\"upload\",\"value\":\"http:\\/\\/www.crmeb3.net\\/uploads\\/config\\/image\\/20190712\\/9a79a97de87d099f4e3a07ddff11a229.png\"},\"comment\":{\"type\":\"input\",\"value\":\"\\u780d\\u4ef7\\u5217\\u8868\\u9876\\u90e8baaner\"}}', 1562900852, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (172, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u8054\\u7cfb\\u5ba2\\u670d\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/03634202004252022151171.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/service\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/customer\\/list\"}}', 1564482010, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (173, 61, '{\"fast_info\":{\"type\":\"input\",\"value\":\"\\u5065\\u5eb7\\u751f\\u6d3b\\u5feb\\u5f00\\u542f\"},\"bast_info\":{\"type\":\"input\",\"value\":\"\\u53e3\\u7891\\u597d\\u7269\\u8bda\\u610f\\u8350\"},\"first_info\":{\"type\":\"input\",\"value\":\"\\u611f\\u53d7\\u9c9c\\u6d3b\\u597d\\u65f6\\u8282\"},\"sales_info\":{\"type\":\"input\",\"value\":\"\\u4e34\\u671f\\u7279\\u60e0\\u5c11\\u6d6a\\u8d39\"}}', 1565146071, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (174, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u7edf\\u8ba1\\u7ba1\\u7406\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/dee6c202004252022156432.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/admin\\/order\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/customer\\/index\"}}', 1565259184, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (175, 53, '{\"order_status\":{\"type\":\"select\",\"value\":\"9\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/c67b3202004250415173509.gif\"}}', 1565317740, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (176, 54, '{\"name\":{\"type\":\"input\",\"value\":\"\\u8ba2\\u5355\\u6838\\u9500\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/653ea202004252022154125.png\"},\"url\":{\"type\":\"select\",\"value\":\"\\/pages\\/admin\\/order_cancellation\\/index\"},\"wap_url\":{\"type\":\"select\",\"value\":\"\\/order\\/order_cancellation\"}}', 1569382895, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (178, 62, '{\"price\":{\"type\":\"input\",\"value\":\"500\"},\"give_money\":{\"type\":\"input\",\"value\":\"0\"}}', 1578884760, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (182, 48, '{\"name\":{\"type\":\"input\",\"value\":\"banner-2\"},\"url\":{\"type\":\"input\",\"value\":\"pages\\/news_list\\/index\"},\"pic\":{\"type\":\"upload\",\"value\":\"https:\\/\\/oss.foodtrust.cn\\/\\/7739c202004250337006643.jpg\"},\"wap_url\":{\"type\":\"input\",\"value\":\"\\/news_list\"}}', 1587757482, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (183, 62, '{\"price\":{\"type\":\"input\",\"value\":\"1000\"},\"give_money\":{\"type\":\"input\",\"value\":\"0\"}}', 1587779206, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (184, 56, '{\"title\":{\"type\":\"input\",\"value\":\"\\u76ca\\u751f\\u83cc\"}}', 1587912592, 1, 1);
INSERT INTO `eb_system_group_data` VALUES (185, 56, '{\"title\":{\"type\":\"input\",\"value\":\"\\u5927\\u7c73\\u5957\\u9910\"}}', 1587912614, 1, 1);

-- ----------------------------
-- Table structure for eb_system_log
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_log`;
CREATE TABLE `eb_system_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员操作记录ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员id',
  `admin_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '管理员姓名',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '链接',
  `page` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '行为',
  `method` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '访问类型',
  `ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录IP',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型',
  `add_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作时间',
  `merchant_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员操作记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_log
-- ----------------------------
INSERT INTO `eb_system_log` VALUES (101, 1, 'crmeb', 'admin/store.storeproductreply/index/', '未知', 'admin', '113.111.181.76', 'system', 1588606021, 0);
INSERT INTO `eb_system_log` VALUES (102, 1, 'crmeb', 'admin/store.storeproductreply/get_product_reply_list/', '未知', 'admin', '113.111.181.76', 'system', 1588606022, 0);
INSERT INTO `eb_system_log` VALUES (103, 1, 'crmeb', 'admin/order.storeorder/index/', '未知', 'admin', '113.111.181.76', 'system', 1588606023, 0);
INSERT INTO `eb_system_log` VALUES (104, 1, 'crmeb', 'admin/order.storeorder/order_list/', '未知', 'admin', '113.111.181.76', 'system', 1588606023, 0);
INSERT INTO `eb_system_log` VALUES (105, 1, 'crmeb', 'admin/order.storeorder/getbadge/', '未知', 'admin', '113.111.181.76', 'system', 1588606023, 0);
INSERT INTO `eb_system_log` VALUES (106, 1, 'crmeb', 'admin/user.userlevel/index/', '未知', 'admin', '113.111.181.76', 'system', 1588606025, 0);
INSERT INTO `eb_system_log` VALUES (107, 1, 'crmeb', 'admin/user.userlevel/get_system_vip_list/', '未知', 'admin', '113.111.181.76', 'system', 1588606026, 0);
INSERT INTO `eb_system_log` VALUES (108, 1, 'crmeb', 'admin/user.usergroup/index/', '未知', 'admin', '113.111.181.76', 'system', 1588606026, 0);
INSERT INTO `eb_system_log` VALUES (109, 1, 'crmeb', 'admin/user.usergroup/grouplist/', '未知', 'admin', '113.111.181.76', 'system', 1588606026, 0);

-- ----------------------------
-- Table structure for eb_system_menus
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_menus`;
CREATE TABLE `eb_system_menus`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `pid` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级id',
  `icon` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '按钮名',
  `module` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '模块名',
  `controller` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '控制器',
  `action` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '方法名',
  `params` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '[]' COMMENT '参数',
  `sort` tinyint(3) NOT NULL DEFAULT 1 COMMENT '排序',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否显示',
  `access` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '子管理员是否可用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `is_show`(`is_show`) USING BTREE,
  INDEX `access`(`access`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 497 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_menus
-- ----------------------------
INSERT INTO `eb_system_menus` VALUES (1, 289, '', '系统设置', 'admin', 'setting.systemConfig', 'index', '[]', 127, 1, 1);
INSERT INTO `eb_system_menus` VALUES (2, 153, '', '权限规则', 'admin', 'setting.systemMenus', 'index', '[]', 7, 1, 1);
INSERT INTO `eb_system_menus` VALUES (4, 153, '', '管理员列表', 'admin', 'setting.systemAdmin', 'index', '[]', 9, 1, 1);
INSERT INTO `eb_system_menus` VALUES (7, 467, '', '配置分类', 'admin', 'setting.systemConfigTab', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (8, 153, '', '身份管理', 'admin', 'setting.systemRole', 'index', '[]', 10, 1, 1);
INSERT INTO `eb_system_menus` VALUES (9, 467, '', '组合数据', 'admin', 'setting.systemGroup', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (11, 0, 'wechat', '公众号', 'admin', 'wechat', 'index', '[]', 91, 1, 1);
INSERT INTO `eb_system_menus` VALUES (12, 354, '', '微信关注回复', 'admin', 'wechat.reply', 'index', '{\"key\":\"subscribe\",\"title\":\"\\u7f16\\u8f91\\u65e0\\u914d\\u7f6e\\u9ed8\\u8ba4\\u56de\\u590d\"}', 86, 1, 1);
INSERT INTO `eb_system_menus` VALUES (17, 360, '', '微信菜单', 'admin', 'wechat.menus', 'index', '[]', 95, 1, 1);
INSERT INTO `eb_system_menus` VALUES (19, 11, '', '图文管理', 'admin', 'wechat.wechatNewsCategory', 'index', '[]', 60, 1, 1);
INSERT INTO `eb_system_menus` VALUES (21, 0, 'magic', '维护', 'admin', 'system', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (23, 0, 'laptop', '商品', 'admin', 'store', 'index', '[]', 110, 1, 1);
INSERT INTO `eb_system_menus` VALUES (24, 23, '', '商品管理', 'admin', 'store.storeProduct', 'index', '{\"type\":\"1\"}', 100, 1, 1);
INSERT INTO `eb_system_menus` VALUES (25, 23, '', '商品分类', 'admin', 'store.storeCategory', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (26, 285, '', '订单管理', 'admin', 'order.storeOrder', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (30, 354, '', '关键字回复', 'admin', 'wechat.reply', 'keyword', '[]', 85, 1, 1);
INSERT INTO `eb_system_menus` VALUES (31, 354, '', '无效关键词回复', 'admin', 'wechat.reply', 'index', '{\"key\":\"default\",\"title\":\"\\u7f16\\u8f91\\u65e0\\u6548\\u5173\\u952e\\u5b57\\u9ed8\\u8ba4\\u56de\\u590d\"}', 84, 1, 1);
INSERT INTO `eb_system_menus` VALUES (33, 284, '', '附加权限', 'admin', 'article.articleCategory', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (34, 33, '', '添加文章分类', 'admin', 'article.articleCategory', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (35, 33, '', '编辑文章分类', 'admin', 'article.articleCategory', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (36, 33, '', '删除文章分类', 'admin', 'article.articleCategory', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (37, 31, '', '附加权限', 'admin', 'wechat.reply', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (38, 283, '', '附加权限', 'admin', 'article.article', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (39, 38, '', '添加文章', 'admin', 'article. article', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (40, 38, '', '编辑文章', 'admin', 'article. article', 'add_new', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (41, 38, '', '删除文章', 'admin', 'article. article', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (42, 19, '', '附加权限', 'admin', 'wechat.wechatNewsCategory', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (43, 42, '', '添加图文消息', 'admin', 'wechat.wechatNewsCategory', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (44, 42, '', '编辑图文消息', 'admin', 'wechat.wechatNewsCategory', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (45, 42, '', '删除图文消息', 'admin', 'wechat.wechatNewsCategory', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (46, 7, '', '配置分类附加权限', 'admin', 'setting.systemConfigTab', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (47, 46, '', '添加配置分类', 'admin', 'setting.systemConfigTab', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (48, 117, '', '添加配置', 'admin', 'setting.systemConfig', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (49, 46, '', '编辑配置分类', 'admin', 'setting.systemConfigTab', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (50, 46, '', '删除配置分类', 'admin', 'setting.systemConfigTab', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (51, 46, '', '查看子字段', 'admin', 'system.systemConfigTab', 'sonConfigTab', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (52, 9, '', '组合数据附加权限', 'admin', 'setting.systemGroup', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (53, 468, '', '添加数据', 'admin', 'setting.system_droup_data', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (54, 468, '', '编辑数据', 'admin', 'setting.system_droup_data', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (55, 468, '', '删除数据', 'admin', 'setting.system_droup_data', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (56, 468, '', '数据列表', 'admin', 'setting.system_droup_data', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (57, 52, '', '添加数据组', 'admin', 'setting.systemGroup', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (58, 52, '', '删除数据组', 'admin', 'setting.systemGroup', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (59, 4, '', '管理员列表附加权限', 'admin', 'setting.systemAdmin', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (60, 59, '', '添加管理员', 'admin', 'setting.systemAdmin', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (61, 59, '', '编辑管理员', 'admin', 'setting.systemAdmin', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (62, 59, '', '删除管理员', 'admin', 'setting.systemAdmin', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (63, 8, '', '身份管理附加权限', 'admin', 'setting.systemRole', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (64, 63, '', '添加身份', 'admin', 'setting.systemRole', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (65, 63, '', '修改身份', 'admin', 'setting.systemRole', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (66, 63, '', '删除身份', 'admin', 'setting.systemRole', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (67, 8, '', '身份管理展示页', 'admin', 'setting.systemRole', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (68, 4, '', '管理员列表展示页', 'admin', 'setting.systemAdmin', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (69, 7, '', '配置分类展示页', 'admin', 'setting.systemConfigTab', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (70, 9, '', '组合数据展示页', 'admin', 'setting.systemGroup', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (71, 284, '', '文章分类管理展示页', 'admin', 'article.articleCategory', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (72, 283, '', '文章管理展示页', 'admin', 'article.article', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (73, 19, '', '图文消息展示页', 'admin', 'wechat.wechatNewsCategory', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (74, 2, '', '菜单管理附加权限', 'admin', 'setting.systemMenus', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (75, 74, '', '添加菜单', 'admin', 'setting.systemMenus', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (76, 74, '', '编辑菜单', 'admin', 'setting.systemMenus', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (77, 74, '', '删除菜单', 'admin', 'setting.systemMenus', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (78, 2, '', '菜单管理展示页', 'admin', 'setting.systemMenus', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (80, 0, 'leanpub', '内容', 'admin', 'article', 'index', '[]', 90, 1, 1);
INSERT INTO `eb_system_menus` VALUES (82, 11, '', '微信用户管理', 'admin', 'user', 'list', '[]', 5, 1, 1);
INSERT INTO `eb_system_menus` VALUES (84, 82, '', '用户标签', 'admin', 'wechat.wechatUser', 'tag', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (89, 30, '', '关键字回复附加权限', 'admin', 'wechat.reply', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (90, 89, '', '添加关键字', 'admin', 'wechat.reply', 'add_keyword', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (91, 89, '', '修改关键字', 'admin', 'wechat.reply', 'info_keyword', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (92, 89, '', '删除关键字', 'admin', 'wechat.reply', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (93, 30, '', '关键字回复展示页', 'admin', 'wechat.reply', 'keyword', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (94, 31, '', '无效关键词回复展示页', 'admin', 'wechat.reply', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (95, 31, '', '无效关键词回复附加权限', 'admin', 'wechat.reply', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (96, 95, '', '无效关键词回复提交按钮', 'admin', 'wechat.reply', 'save', '{\"key\":\"default\",\"title\":\"编辑无效关键字默认回复\"}', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (97, 12, '', '微信关注回复展示页', 'admin', 'wechat.reply', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (98, 12, '', '微信关注回复附加权限', 'admin', 'wechat.reply', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (99, 98, '', '微信关注回复提交按钮', 'admin', 'wechat.reply', 'save', '{\"key\":\"subscribe\",\"title\":\"编辑无配置默认回复\"}', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (100, 74, '', '添加提交菜单', 'admin', 'setting.systemMenus', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (101, 74, '', '编辑提交菜单', 'admin', 'setting.systemMenus', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (102, 59, '', '提交添加管理员', 'admin', 'setting.systemAdmin', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (103, 59, '', '提交修改管理员', 'admin', 'setting.systemAdmin', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (104, 63, '', '提交添加身份', 'admin', 'setting.systemRole', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (105, 63, '', '提交修改身份', 'admin', 'setting.systemRole', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (106, 46, '', '提交添加配置分类', 'admin', 'setting.systemConfigTab', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (107, 46, '', '提交修改配置分类', 'admin', 'setting.systemConfigTab', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (108, 117, '', '提交添加配置列表', 'admin', 'setting.systemConfig', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (109, 52, '', '提交添加数据组', 'admin', 'setting.systemGroup', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (110, 52, '', '提交修改数据组', 'admin', 'setting.systemGroup', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (111, 468, '', '提交添加数据', 'admin', 'setting.system_droup_data', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (112, 468, '', '提交修改数据', 'admin', 'setting.system_droup_data', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (113, 33, '', '提交添加文章分类', 'admin', 'article.articleCategory', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (114, 33, '', '提交添加文章分类', 'admin', 'article.articleCategory', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (115, 42, '', '提交添加图文消息', 'admin', 'wechat.wechatNewsCategory', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (116, 42, '', '提交编辑图文消息', 'admin', 'wechat.wechatNewsCategory', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (117, 1, '', '配置列表附加权限', 'admin', 'setting.systemConfig', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (118, 1, '', '配置列表展示页', 'admin', 'setting.systemConfig', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (119, 117, '', '提交保存配置列表', 'admin', 'setting.systemConfig', 'save_basics', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (123, 89, '', '提交添加关键字', 'admin', 'wechat.reply', 'save_keyword', '{\"dis\":\"1\"}', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (124, 89, '', '提交修改关键字', 'admin', 'wechat.reply', 'save_keyword', '{\"dis\":\"2\"}', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (126, 17, '', '微信菜单展示页', 'admin', 'wechat.menus', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (127, 17, '', '微信菜单附加权限', 'admin', 'wechat.menus', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (128, 127, '', '提交微信菜单按钮', 'admin', 'wechat.menus', 'save', '{\"dis\":\"1\"}', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (129, 82, '', '用户行为纪录', 'admin', 'wechat.wechatMessage', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (130, 469, '', '系统日志', 'admin', 'system.systemLog', 'index', '[]', 5, 1, 1);
INSERT INTO `eb_system_menus` VALUES (131, 130, '', '管理员操作记录展示页', 'admin', 'system.systemLog', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (132, 129, '', '微信用户行为纪录展示页', 'admin', 'wechat.wechatMessage', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (133, 82, '', '微信用户', 'admin', 'wechat.wechatUser', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (134, 133, '', '微信用户展示页', 'admin', 'wechat.wechatUser', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (137, 135, '', '添加通知模板', 'admin', 'system.systemNotice', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (138, 135, '', '编辑通知模板', 'admin', 'system.systemNotice', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (139, 135, '', '删除辑通知模板', 'admin', 'system.systemNotice', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (140, 135, '', '提交编辑辑通知模板', 'admin', 'system.systemNotice', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (141, 135, '', '提交添加辑通知模板', 'admin', 'system.systemNotice', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (142, 25, '', '商品分类展示页', 'admin', 'store.storeCategory', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (143, 25, '', '商品分类附加权限', 'admin', 'store.storeCategory', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (144, 117, '', '获取配置列表上传文件的名称', 'admin', 'setting.systemConfig', 'getimagename', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (145, 117, '', '配置列表上传文件', 'admin', 'setting.systemConfig', 'view_upload', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (146, 24, '', '商品管理展示页', 'admin', 'store.storeProduct', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (147, 24, '', '商品管理附加权限', 'admin', 'store.storeProduct', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (148, 286, '', '优惠券', '', '', '', '[]', 10, 1, 1);
INSERT INTO `eb_system_menus` VALUES (149, 148, '', '优惠券模板', 'admin', 'ump.storeCoupon', 'index', '[]', 5, 1, 1);
INSERT INTO `eb_system_menus` VALUES (150, 148, '', '会员领取记录', 'admin', 'ump.storeCouponUser', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (151, 0, 'user', '会员', 'admin', 'user', 'index', '[]', 107, 1, 1);
INSERT INTO `eb_system_menus` VALUES (153, 289, '', '管理权限', 'admin', 'setting.systemAdmin', '', '[]', 50, 1, 1);
INSERT INTO `eb_system_menus` VALUES (155, 154, '', '商户商品展示页', 'admin', 'store.storeMerchant', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (156, 154, '', '商户商品附加权限', 'admin', 'store.storeMerchant', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (158, 157, '', '商户文章管理展示页', 'admin', 'wechat.wechatNews', 'merchantIndex', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (159, 157, '', '商户文章管理附加权限', 'admin', 'wechat.wechatNews', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (173, 469, '', '文件校验', 'admin', 'system.systemFile', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (174, 360, '', '微信模板消息', 'admin', 'wechat.wechatTemplate', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (175, 289, '', '客服管理', 'admin', 'wechat.storeService', 'index', '[]', 70, 1, 1);
INSERT INTO `eb_system_menus` VALUES (177, 151, '', '会员管理', 'admin', 'user.user', 'index', '[]', 10, 1, 1);
INSERT INTO `eb_system_menus` VALUES (179, 307, '', '充值记录', 'admin', 'finance.userRecharge', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (190, 26, '', '订单管理展示页', 'admin', 'order.storeOrder', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (191, 26, '', '订单管理附加权限', 'admin', 'order.storeOrder', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (192, 191, '', '订单管理去发货', 'admin', 'order.storeOrder', 'deliver_goods', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (193, 191, '', '订单管理备注', 'admin', 'order.storeOrder', 'remark', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (194, 191, '', '订单管理去送货', 'admin', 'order.storeOrder', 'delivery', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (195, 191, '', '订单管理已收货', 'admin', 'order.storeOrder', 'take_delivery', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (196, 191, '', '订单管理退款', 'admin', 'order.storeOrder', 'refund_y', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (197, 191, '', '订单管理修改订单', 'admin', 'order.storeOrder', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (198, 191, '', '订单管理修改订单提交', 'admin', 'order.storeOrder', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (199, 191, '', '订单管理退积分', 'admin', 'order.storeOrder', 'integral_back', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (200, 191, '', '订单管理退积分提交', 'admin', 'order.storeOrder', 'updateIntegralBack', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (201, 191, '', '订单管理立即支付', 'admin', 'order.storeOrder', 'offline', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (202, 191, '', '订单管理退款原因', 'admin', 'order.storeOrder', 'refund_n', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (203, 191, '', '订单管理退款原因提交', 'admin', 'order.storeOrder', 'updateRefundN', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (204, 191, '', '订单管理修改配送信息', 'admin', 'order.storeOrder', 'distribution', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (205, 191, '', '订单管理修改配送信息提交', 'admin', 'order.storeOrder', 'updateDistribution', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (206, 191, '', '订单管理退款提交', 'admin', 'order.storeOrder', 'updateRefundY', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (207, 191, '', '订单管理去发货提交', 'admin', 'order.storeOrder', 'updateDeliveryGoods', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (208, 191, '', '订单管理去送货提交', 'admin', 'order.storeOrder', 'updateDelivery', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (209, 175, '', '客服管理展示页', 'admin', 'store.storeService', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (210, 175, '', '客服管理附加权限', 'admin', 'store.storeService', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (211, 210, '', '客服管理添加', 'admin', 'store.storeService', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (212, 210, '', '客服管理添加提交', 'admin', 'store.storeService', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (213, 210, '', '客服管理编辑', 'admin', 'store.storeService', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (214, 210, '', '客服管理编辑提交', 'admin', 'store.storeService', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (215, 210, '', '客服管理删除', 'admin', 'store.storeService', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (216, 179, '', '用户充值记录展示页', 'admin', 'user.userRecharge', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (217, 179, '', '用户充值记录附加权限', 'admin', 'user.userRecharge', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (218, 217, '', '用户充值记录退款', 'admin', 'user.userRecharge', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (219, 217, '', '用户充值记录退款提交', 'admin', 'user.userRecharge', 'updaterefundy', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (220, 180, '', '预售卡管理批量修改预售卡金额', 'admin', 'presell.presellCard', 'batch_price', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (221, 180, '', '预售卡管理批量修改预售卡金额提交', 'admin', 'presell.presellCard', 'savebatch', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (222, 210, '', '客服管理聊天记录查询', 'admin', 'store.storeService', 'chat_user', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (223, 210, '', '客服管理聊天记录查询详情', 'admin', 'store.storeService', 'chat_list', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (229, 149, '', '优惠券管理展示页', 'admin', 'store.storeCoupon', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (230, 149, '', '优惠券管理附加权限', 'admin', 'store.storeCoupon', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (231, 230, '', '优惠券管理添加', 'admin', 'store.storeCoupon', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (232, 230, '', '优惠券管理添加提交', 'admin', 'store.storeCoupon', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (233, 230, '', '优惠券管理删除', 'admin', 'store.storeCoupon', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (234, 230, '', '优惠券管理立即失效', 'admin', 'store.storeCoupon', 'status', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (235, 148, '', '优惠券列表', 'admin', 'ump.storeCouponIssue', 'index', '[]', 3, 1, 1);
INSERT INTO `eb_system_menus` VALUES (236, 82, '', '用户分组', 'admin', 'wechat.wechatUser', 'group', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (237, 21, '', '刷新缓存', 'admin', 'system.clear', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (238, 272, '', '拼团商品', 'admin', 'ump.storeCombination', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (239, 306, '', '提现申请', 'admin', 'finance.user_extract', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (241, 273, '', '秒杀商品', 'admin', 'ump.storeSeckill', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (244, 294, '', '财务报表', 'admin', 'record.storeStatistics', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (246, 295, '', '用户统计', 'admin', 'user.user', 'user_analysis', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (247, 153, '', '个人资料', 'admin', 'setting.systemAdmin', 'admininfo', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (248, 247, '', '个人资料附加权限', 'admin', 'setting.systemAdmin', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (249, 248, '', '个人资料提交保存', 'admin', 'system.systemAdmin', 'setAdminInfo', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (250, 247, '', '个人资料展示页', 'admin', 'setting.systemAdmin', 'admininfo', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (252, 21, '', '在线更新', 'admin', 'system.systemUpgradeclient', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (254, 271, '', '砍价商品', 'admin', 'ump.storeBargain', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (255, 289, '', '后台通知', 'admin', 'setting.systemNotice', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (261, 147, '', '编辑商品', 'admin', 'store.storeproduct', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (262, 147, '', '添加商品', 'admin', 'store.storeproduct', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (263, 147, '', '编辑商品详情', 'admin', 'store.storeproduct', 'edit_content', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (264, 147, '', '开启秒杀', 'admin', 'store.storeproduct', 'seckill', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (265, 147, '', '开启秒杀', 'admin', 'store.store_product', 'bargain', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (266, 147, '', '商品编辑属性', 'admin', 'store.storeproduct', 'attr', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (269, 0, 'cubes', '小程序', 'admin', 'routine', 'index', '[]', 92, 1, 1);
INSERT INTO `eb_system_menus` VALUES (271, 286, '', '砍价管理', 'admin', '', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (272, 286, '', '拼团管理', 'admin', '', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (273, 286, '', '秒杀管理', 'admin', '', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (276, 469, '', '附件管理', 'admin', 'widget.images', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (278, 469, '', '清除数据', 'admin', 'system.systemCleardata', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (283, 80, '', '文章管理', 'admin', 'article.article', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (284, 80, '', '文章分类', 'admin', 'article.article_category', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (285, 0, 'building-o', '订单', 'admin', 'order', 'index', '[]', 109, 1, 1);
INSERT INTO `eb_system_menus` VALUES (286, 0, 'paper-plane', '营销', 'admin', 'ump', 'index', '[]', 105, 1, 1);
INSERT INTO `eb_system_menus` VALUES (287, 0, 'money', '财务', 'admin', 'finance', 'index', '[]', 103, 1, 1);
INSERT INTO `eb_system_menus` VALUES (288, 0, 'line-chart', '数据', 'admin', 'record', 'index', '[]', 100, 1, 1);
INSERT INTO `eb_system_menus` VALUES (289, 0, 'gear', '设置', 'admin', 'setting', 'index', '[]', 90, 1, 1);
INSERT INTO `eb_system_menus` VALUES (293, 288, '', '交易数据', 'admin', '', '', '[]', 100, 1, 1);
INSERT INTO `eb_system_menus` VALUES (294, 288, '', '财务数据', 'admin', '', '', '[]', 80, 1, 1);
INSERT INTO `eb_system_menus` VALUES (295, 288, '', '会员数据', 'admin', '', '', '[]', 70, 1, 1);
INSERT INTO `eb_system_menus` VALUES (296, 288, '', '营销数据', 'admin', '', '', '[]', 90, 1, 1);
INSERT INTO `eb_system_menus` VALUES (297, 288, '', '排行榜', 'admin', '', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (300, 294, '', '提现统计', 'admin', 'record.record', 'chart_cash', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (301, 294, '', '充值统计', 'admin', 'record.record', 'chart_recharge', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (302, 294, '', '返佣统计', 'admin', 'record.record', 'chart_rebate', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (303, 295, '', '会员增长', 'admin', 'record.record', 'user_chart', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (304, 295, '', '会员业务', 'admin', 'record.record', 'user_business_chart', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (305, 295, '', '会员属性', 'admin', 'record.record', 'user_attr', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (306, 287, '', '财务操作', 'admin', '', '', '[]', 100, 1, 1);
INSERT INTO `eb_system_menus` VALUES (307, 287, '', '财务记录', 'admin', '', '', '[]', 50, 1, 1);
INSERT INTO `eb_system_menus` VALUES (308, 287, '', '佣金记录', 'admin', '', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (312, 307, '', '资金监控', 'admin', 'finance.finance', 'bill', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (313, 308, '', '佣金记录', 'admin', 'finance.finance', 'commission_list', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (314, 296, '', '积分统计', 'admin', 'record.record', 'chart_score', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (315, 296, '', '优惠券统计', 'admin', 'record.record', 'chart_coupon', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (316, 296, '', '拼团统计', 'admin', 'record.record', 'chart_combination', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (317, 296, '', '秒杀统计', 'admin', 'record.record', 'chart_seckill', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (318, 296, '', '砍价统计', 'admin', 'record.record', 'chart_bargain', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (319, 297, '', '商品销售排行', 'admin', 'record.record', 'ranking_saleslists', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (320, 297, '', '返佣排行', 'admin', 'record.record', 'ranking_commission', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (321, 297, '', '积分排行', 'admin', 'record.record', 'ranking_point', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (329, 285, '', '营销订单', 'admin', 'user', 'user', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (333, 272, '', '拼团列表', 'admin', 'ump.storeCombination', 'combina_list', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (334, 329, '', '秒杀订单', 'admin', 'user', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (335, 329, '', '积分兑换', 'admin', 'user', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (337, 0, 'users', '分销', 'admin', 'agent', 'index', '[]', 106, 1, 1);
INSERT INTO `eb_system_menus` VALUES (340, 293, '', '订单统计', 'admin', 'record.record', 'chart_order', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (341, 293, '', '商品统计', 'admin', 'record.record', 'chart_product', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (349, 286, '', '积分', 'admin', 'userPoint', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (350, 349, '', '积分配置', 'admin', 'setting.systemConfig', 'index', '{\"type\":\"3\",\"tab_id\":\"11\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (351, 349, '', '积分日志', 'admin', 'ump.userPoint', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (353, 337, '', '分销配置', 'admin', 'setting.systemConfig', 'index', '{\"type\":\"3\",\"tab_id\":\"9\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (354, 11, '', '自动回复', '', '', '', '[]', 80, 1, 1);
INSERT INTO `eb_system_menus` VALUES (360, 11, '', '公众号配置', '', '', '', '[]', 100, 1, 1);
INSERT INTO `eb_system_menus` VALUES (362, 276, '', '附加权限', 'admin', 'widget.images', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (363, 362, '', '上传图片', 'admin', 'widget.images', 'upload', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (364, 362, '', '删除图片', 'admin', 'widget.images', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (365, 362, '', '附件管理', 'admin', 'widget.images', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (366, 254, '', '其它权限管理', '', '', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (367, 366, '', '编辑砍价', 'admin', 'ump.storeBargain', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (368, 366, '', '砍价商品更新', 'admin', 'ump.storeBargain', 'update', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (369, 143, '', '添加商品分类', 'admin', 'store.storeCategory', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (370, 143, '', '编辑商品分类', 'admin', 'store.storeCategory', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (371, 337, '', '分销员管理', 'admin', 'agent.agentManage', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (372, 462, '', '首页幻灯片', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"48\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (373, 462, '', '首页导航按钮', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"47\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (374, 295, '', '分销会员业务', 'admin', 'record.record', 'user_distribution_chart', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (376, 269, '', '小程序订阅消息', 'admin', 'routine.routineTemplate', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (377, 469, '', '数据备份', 'admin', 'system.systemDatabackup', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (378, 489, '', '物流公司', 'admin', 'system.express', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (379, 469, '', '文件管理', 'admin', 'system.systemFile', 'opendir', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (380, 379, '', '权限规则', 'admin', 'system.systemFile', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (381, 380, '', '打开文件', 'admin', 'system.systemFile', 'openfile', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (382, 380, '', '编辑文件', 'admin', 'system.systemFile', 'savefile', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (386, 362, '', '移动图片分类展示', 'admin', 'widget.images', 'moveimg', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (387, 362, '', '编辑分类', 'admin', 'widget.images', 'updatecate', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (388, 362, '', '添加分类', 'admin', 'widget.images', 'savecate', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (389, 362, '', '移动图片分类', 'admin', 'widget.images', 'moveimgcecate', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (390, 362, '', '编辑分类展示', 'admin', 'widget.images', 'editcate', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (392, 362, '', '删除分类', 'admin', 'widget.images', 'deletecate', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (393, 362, '', '添加分类展示', 'admin', 'widget.images', 'addcate', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (394, 191, '', '订单获取列表', 'admin', 'order.storeOrder', 'order_list', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (395, 82, '', '微信用户附加权限', 'admin', 'wechat.wechatUser', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (396, 395, '', '推送消息', 'admin', 'wechat.wechat_news_category', 'push', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (397, 395, '', '推送优惠券', 'admin', 'ump.storeCouponUser', 'grant', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (398, 177, '', '会员列表页', 'admin', 'user.user', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (399, 177, '', '会员附加权限', '', 'user.user', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (400, 399, '', '修改用户状态', '', 'user.user', 'set_status', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (401, 399, '', '编辑用户', 'admin', 'user.user', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (402, 399, '', '更新用户', 'admin', 'user.user', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (403, 399, '', '查看用户', 'admin', 'user.user', 'see', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (405, 399, '', '发优惠券', 'admin', 'ump.storeCouponUser', 'grant', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (406, 399, '', '推送图文', 'admin', 'wechat.wechatNewsCategory', 'push', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (407, 399, '', '发站内信', 'admin', 'user.userNotice', 'notice', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (415, 371, '', '分销管理附加权限', 'admin', 'agent.agentManage', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (416, 174, '', '微信模版消息附加权限', 'admin', 'wechat.wechatTemplate', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (417, 416, '', '添加模版消息', 'admin', 'wechat.wechatTemplate', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (418, 416, '', '添加模版消息展示', 'admin', 'wechat.wechatTemplate', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (419, 416, '', '编辑模版消息展示', 'admin', 'wechat.wechatTemplate', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (420, 416, '', '更新模版消息展示', 'admin', 'wechat.wechatTemplate', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (421, 416, '', '删除模版消息展示', 'admin', 'wechat.wechatTemplate', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (422, 376, '', '小程序模版消息附加权限', 'admin', 'routine.routineTemplate', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (423, 422, '', '添加模版消息展示', 'admin', 'routine.routineTemplate', 'create', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (424, 422, '', '添加模版消息', 'admin', 'routine.routineTemplate', 'save', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (425, 422, '', '编辑模版消息展示', 'admin', 'routine.routineTemplate', 'edit', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (426, 422, '', '编辑模版消息', 'admin', 'routine.routineTemplate', 'update', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (427, 422, '', '删除模版消息', 'admin', 'routine.routineTemplate', 'delete', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (439, 377, '', '数据库备份附加权限', 'admin', 'system.systemDatabackup', '', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (440, 439, '', '查看表结构', 'admin', 'system.systemDatabackup', 'seetable', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (441, 439, '', '优化表', 'admin', 'system.systemDatabackup', 'optimize', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (442, 439, '', '修复表', 'admin', 'system.systemDatabackup', 'repair', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (443, 439, '', '备份表', 'admin', 'system.systemDatabackup', 'backup', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (444, 439, '', '删除备份', 'admin', 'system.systemDatabackup', 'delFile', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (445, 439, '', '恢复备份', 'admin', 'system.systemDatabackup', 'import', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (446, 439, '', '下载备份', 'admin', 'system.systemDatabackup', 'downloadFile', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (447, 377, '', '数据备份展示页', 'admin', 'system.systemDatabackup', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (448, 379, '', '文件管理展示页', 'admin', 'system.systemFile', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (450, 371, '', '分销管理列表页', 'admin', 'agent.agentManage', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (451, 376, '', '小程序模版消息列表页', 'admin', 'routine.routineTemplate', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (452, 174, '', '微信模版消息列表页', 'admin', 'wechat.wechatTemplate', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (453, 276, '', '附件管理展示页', 'admin', 'widget.images', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (456, 151, '', '会员等级', 'admin', 'user.user_level', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (458, 462, '', '签到天数配置', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"55\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (459, 462, '', '订单详情动态图', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"53\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (460, 462, '', '个人中心菜单', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"54\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (461, 462, '', '小程序首页滚动新闻', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"50\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (462, 289, '', '数据配置', 'admin', '', '', '[]', 100, 1, 1);
INSERT INTO `eb_system_menus` VALUES (463, 462, '', '热门榜单推荐banner', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"57\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (464, 462, '', '首发新品推荐banner', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"58\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (465, 462, '', '促销单品推荐banner', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"59\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (466, 462, '', '个人中心分销海报', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"60\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (467, 21, '', '开发配置', 'admin', 'system', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (468, 1, '', '配置组合数据附加权限', 'admin', 'setting.system_droup_data', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (469, 21, '', '安全维护', 'admin', 'system', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (470, 1, '', '配置组合数据展示页', 'admin', 'setting.systemGroup', 'index', '[]', 0, 0, 1);
INSERT INTO `eb_system_menus` VALUES (471, 462, '', '小程序精品推荐', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"52\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (472, 462, '', '首页活动区域图片', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"51\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (473, 273, '', '秒杀配置', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"49\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (474, 289, '', '短信设置', 'admin', 'sms', 'index', '[]', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (475, 474, '', '短信模板', 'admin', 'sms.smsTemplateApply', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (477, 474, '', '短信购买', 'admin', 'sms.smsPay', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (478, 474, '', '短信配置', 'admin', 'sms.smsConfig', 'index', '{\"type\":\"4\",\"tab_id\":\"18\"}', 1, 1, 1);
INSERT INTO `eb_system_menus` VALUES (480, 289, '', '门店设置', 'admin', 'system.system_store', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (481, 462, '', '首页配置', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"61\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (482, 462, '', '充值金额设置', 'admin', 'setting.system_group_data', 'index', '{\"gid\":\"62\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (485, 480, '', '门店列表', 'admin', 'system.system_store', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (486, 480, '', '店员管理', 'admin', 'system.system_store_staff', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (487, 480, '', '核销订单', 'admin', 'system.system_verify_order', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (488, 23, '', '商品规格', 'admin', 'store.store_product_rule', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (489, 289, '', '物流设置', 'admin', 'setting', '', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (490, 23, '', '商品评价', 'admin', 'store.store_product_reply', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (492, 474, '', '短信记录', 'admin', 'sms.SmsRecord', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (493, 489, '', '物流配置', 'admin', 'setting.systemConfig', 'index', '{\"tab_id\":\"10\",\"type\":\"3\"}', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (494, 489, '', '城市数据', 'admin', 'setting.systemCity', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (495, 489, '', '运费模板', 'admin', 'setting.shippingTemplates', 'index', '[]', 0, 1, 1);
INSERT INTO `eb_system_menus` VALUES (496, 151, '', '会员分组', 'admin', 'user.user_group', 'index', '[]', 0, 1, 1);

-- ----------------------------
-- Table structure for eb_system_notice
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_notice`;
CREATE TABLE `eb_system_notice`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '通知模板id',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知标题',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知类型',
  `icon` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '链接',
  `table_title` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知数据',
  `template` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知模板',
  `push_admin` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知管理员id',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知模板表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_system_notice_admin
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_notice_admin`;
CREATE TABLE `eb_system_notice_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '通知记录ID',
  `notice_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知类型',
  `admin_id` smallint(5) UNSIGNED NOT NULL COMMENT '通知的管理员',
  `link_id` int(10) UNSIGNED NOT NULL COMMENT '关联ID',
  `table_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知的数据',
  `is_click` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击次数',
  `is_visit` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访问次数',
  `visit_time` int(11) NOT NULL COMMENT '访问时间',
  `add_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '通知时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`, `notice_type`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `is_visit`(`is_visit`) USING BTREE,
  INDEX `is_click`(`is_click`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_system_role
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_role`;
CREATE TABLE `eb_system_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '身份管理id',
  `role_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份管理名称',
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份管理权限(menus_id)',
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '身份管理表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_role
-- ----------------------------
INSERT INTO `eb_system_role` VALUES (1, '超级管理员', '23,24,146,147,264,265,266,263,261,262,25,142,143,369,370,285,26,190,191,394,208,207,206,198,199,200,201,202,203,204,205,197,196,192,193,194,195,329,334,335,290,170,224,225,226,227,228,151,177,398,399,407,406,400,401,402,403,405,176,449,408,409,410,411,412,413,456,337,353,371,450,415,286,148,149,229,230,231,232,233,234,235,150,352,271,254,366,368,367,272,333,238,273,473,241,349,351,350,287,306,239,307,179,217,219,218,216,312,308,313,288,293,341,340,296,318,317,316,315,314,294,300,301,302,244,295,305,304,303,374,246,297,319,321,320,269,376,451,422,423,424,425,426,427,11,360,17,127,128,126,174,452,416,421,420,417,418,419,355,356,357,358,359,354,12,97,98,99,30,93,89,124,92,91,90,123,31,94,95,96,37,19,73,42,115,116,43,44,45,82,133,134,395,396,397,84,236,129,132,289,1,470,468,112,111,53,54,55,56,117,119,108,48,144,145,118,361,270,462,471,472,466,458,459,460,461,463,464,465,372,373,153,8,63,104,105,64,65,66,67,4,68,59,102,103,62,61,60,2,74,100,75,76,77,101,78,247,248,249,250,474,478,475,476,477,479,378,255,80,283,72,38,41,39,40,284,71,33,113,114,34,35,36,175,209,210,222,223,211,212,213,214,215,21,469,130,131,173,276,362,365,364,363,386,387,388,389,390,392,393,453,278,377,447,439,444,445,446,443,442,441,440,379,448,380,382,381,467,9,52,109,110,57,58,70,7,46,106,107,47,49,50,51,69,252,237,408,481,,0', 0, 1);

-- ----------------------------
-- Table structure for eb_system_store
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_store`;
CREATE TABLE `eb_system_store`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '门店名称',
  `introduction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '简介',
  `phone` char(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省市区',
  `detailed_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '详细地址',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '门店logo',
  `latitude` char(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '纬度',
  `longitude` char(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '经度',
  `valid_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '核销有效日期',
  `day_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '每日营业开关时间',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  `is_show` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否显示',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店自提' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_store
-- ----------------------------
INSERT INTO `eb_system_store` VALUES (1, '补拍或自提', '补拍专用', '18998382701', '广东,广州,番禺区', '汉溪村汉溪路6号201', 'https://oss.foodtrust.cn//de625202004251154513069.png', '38.6518', '104.07642', '1588103410', '00:00:00 - 23:59:59', 0, 1, 0);

-- ----------------------------
-- Table structure for eb_system_store_staff
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_store_staff`;
CREATE TABLE `eb_system_store_staff`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL COMMENT '微信用户id',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '店员头像',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `staff_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '店员名称',
  `phone` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `verify_status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '核销开关',
  `status` tinyint(2) NULL DEFAULT 1 COMMENT '状态',
  `add_time` int(10) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店店员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_system_user_level
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_user_level`;
CREATE TABLE `eb_system_user_level`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mer_id` int(11) NOT NULL DEFAULT 0 COMMENT '商户id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '会员名称',
  `money` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '购买金额',
  `valid_date` int(11) NOT NULL DEFAULT 0 COMMENT '有效时间',
  `is_forever` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为永久会员',
  `is_pay` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否购买,1=购买,0=不购买',
  `is_show` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否显示 1=显示,0=隐藏',
  `grade` int(11) NOT NULL DEFAULT 0 COMMENT '会员等级',
  `discount` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '享受折扣',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '会员卡背景',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '会员图标',
  `explain` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '说明',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除.1=删除,0=未删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设置用户等级表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_user_level
-- ----------------------------
INSERT INTO `eb_system_user_level` VALUES (1, 0, '百花蜜', 0.00, 0, 1, 0, 0, 1, 100.00, 'https://oss.foodtrust.cn//90a66202004260851036750.jpg', 'https://oss.foodtrust.cn//6c351202004260851036868.png', '百花蜜', 1587862352, 0);
INSERT INTO `eb_system_user_level` VALUES (2, 0, '椴树蜜', 0.00, 0, 1, 0, 1, 2, 99.00, 'https://oss.foodtrust.cn//20e46202004260851037850.jpg', 'https://oss.foodtrust.cn//ff943202004260851033674.png', '椴树蜜', 1587862352, 0);
INSERT INTO `eb_system_user_level` VALUES (3, 0, '藿香蜜', 0.00, 0, 1, 0, 1, 3, 98.00, 'https://oss.foodtrust.cn//a25b4202004260851031057.jpg', 'https://oss.foodtrust.cn//13487202004260851032870.png', '藿香蜜', 1587862393, 0);
INSERT INTO `eb_system_user_level` VALUES (4, 0, '党参蜜', 0.00, 0, 1, 0, 1, 4, 97.00, 'https://oss.foodtrust.cn//d234e202004260851033806.jpg', 'https://oss.foodtrust.cn//01d2620200426085103895.png', '党参蜜', 1587862435, 0);
INSERT INTO `eb_system_user_level` VALUES (5, 0, '藏岩蜜', 0.00, 0, 1, 0, 1, 5, 96.00, 'https://oss.foodtrust.cn//37646202004260851038520.jpg', 'https://oss.foodtrust.cn//4f09a20200426085103126.png', '藏岩蜜', 1587862502, 0);
INSERT INTO `eb_system_user_level` VALUES (6, 0, '生活家', 0.00, 0, 1, 0, 1, 6, 95.00, 'https://oss.foodtrust.cn//849ba202004260851036015.jpg', 'https://oss.foodtrust.cn//2b9d7202004260851033406.png', '生活家', 1587862562, 0);
INSERT INTO `eb_system_user_level` VALUES (7, 0, '小伙伴', 0.00, 0, 1, 0, 0, 8, 92.00, 'https://oss.foodtrust.cn//849ba202004260851036015.jpg', 'https://oss.foodtrust.cn//de625202004251154513069.png', '小伙伴', 1587862670, 0);
INSERT INTO `eb_system_user_level` VALUES (8, 0, '在职工', 0.00, 0, 1, 0, 0, 15, 85.00, 'https://oss.foodtrust.cn//849ba202004260851036015.jpg', 'https://oss.foodtrust.cn//06322202004252022151781.png', '正式入职后人工设定，离职后等级调整为小伙伴等级', 1587862788, 0);

-- ----------------------------
-- Table structure for eb_system_user_task
-- ----------------------------
DROP TABLE IF EXISTS `eb_system_user_task`;
CREATE TABLE `eb_system_user_task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置原名',
  `task_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务类型',
  `number` int(11) NOT NULL DEFAULT 0 COMMENT '限定数',
  `level_id` int(11) NOT NULL DEFAULT 0 COMMENT '等级id',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `is_show` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否显示',
  `is_must` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否务必达成任务,1务必达成,0=满足其一',
  `illustrate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务说明',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '等级任务设置' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_system_user_task
-- ----------------------------
INSERT INTO `eb_system_user_task` VALUES (1, '满足积分199分', '积分数', 'SatisfactionIntegral', 199, 1, 0, 1, 0, '积分满199', 1587970726);
INSERT INTO `eb_system_user_task` VALUES (2, '消费满199元', '消费金额', 'ConsumptionAmount', 199, 1, 0, 1, 0, '消费满199', 1587971634);
INSERT INTO `eb_system_user_task` VALUES (3, '满足积分599分', '积分数', 'SatisfactionIntegral', 599, 2, 0, 1, 0, '积分满599', 1587971871);
INSERT INTO `eb_system_user_task` VALUES (4, '消费满599元', '消费金额', 'ConsumptionAmount', 599, 2, 0, 1, 0, '消费满599', 1587971889);
INSERT INTO `eb_system_user_task` VALUES (5, '满足积分1799分', '积分数', 'SatisfactionIntegral', 1799, 3, 0, 1, 0, '积分满1799', 1587970726);
INSERT INTO `eb_system_user_task` VALUES (6, '消费满1799元', '消费金额', 'ConsumptionAmount', 1799, 3, 0, 1, 0, '消费满1799', 1587971634);
INSERT INTO `eb_system_user_task` VALUES (7, '满足积分3599分', '积分数', 'SatisfactionIntegral', 3599, 4, 0, 1, 0, '积分满3599', 1587971871);
INSERT INTO `eb_system_user_task` VALUES (8, '消费满3599元', '消费金额', 'ConsumptionAmount', 3599, 4, 0, 1, 0, '消费满3599', 1587971889);
INSERT INTO `eb_system_user_task` VALUES (9, '满足积分4799分', '积分数', 'SatisfactionIntegral', 4799, 5, 0, 1, 0, '积分满4799', 1587970726);
INSERT INTO `eb_system_user_task` VALUES (10, '消费满4799元', '消费金额', 'ConsumptionAmount', 4799, 5, 0, 1, 0, '消费满4799', 1587971634);
INSERT INTO `eb_system_user_task` VALUES (11, '满足积分5999分', '积分数', 'SatisfactionIntegral', 5999, 6, 0, 1, 0, '积分满5999', 1587970726);
INSERT INTO `eb_system_user_task` VALUES (12, '消费满5999元', '消费金额', 'ConsumptionAmount', 5999, 6, 0, 1, 0, '消费满5999', 1587971634);

-- ----------------------------
-- Table structure for eb_template_message
-- ----------------------------
DROP TABLE IF EXISTS `eb_template_message`;
CREATE TABLE `eb_template_message`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '模板id',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=订阅消息,1=微信模板消息',
  `tempkey` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板编号',
  `name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板名',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '回复内容',
  `tempid` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板ID',
  `add_time` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '添加时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信模板' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of eb_template_message
-- ----------------------------
INSERT INTO `eb_template_message` VALUES (1, 0, '1128', '订单配送通知', '商品信息{{thing8.DATA}}\n订单编号{{character_string1.DATA}}\n配送人{{name4.DATA}}\n配送员电话{{phone_number10.DATA}}', '4wN7p3nF1IPiPNIPZnoOY3nZlrVP3dzM-Km0OLcpW48', '1575364233', 1);
INSERT INTO `eb_template_message` VALUES (2, 0, '1470', '提现结果通知', '提现状态{{thing1.DATA}}\n提现金额{{amount2.DATA}}\n提现账号{{thing3.DATA}}\n提现时间{{date4.DATA}}', 'xtBEkHdxyFSIQfiNe_CRga2mrmQizfArgSk7zC3hnbs', '1575364292', 1);
INSERT INTO `eb_template_message` VALUES (3, 0, '1481', '收货结果通知', '订单类型{{thing1.DATA}}\n订单商品{{thing2.DATA}}\n收货时间{{date5.DATA}}', 'AVmUHvKandN9a9ms_-5QsP9_PAzDoJ_VBB0vqQI1Eo0', '1575364327', 1);
INSERT INTO `eb_template_message` VALUES (4, 0, '1134', '订单取消通知', '取消原因{{thing1.DATA}}\n订单号{{number7.DATA}}\n取消时间{{date2.DATA}}\n订单类型{{thing5.DATA}}', 'xBilsNHAH527HBqrMgNoIA_biTfQ7A_bCbMxMx1uMM0', '1575364399', 1);
INSERT INTO `eb_template_message` VALUES (5, 0, '1458', '发货通知', '快递单号{{character_string2.DATA}}\n快递公司{{thing1.DATA}}\n发货时间{{time3.DATA}}\n订单商品{{thing5.DATA}}', 'vBrJgvoj4CgBOUIVQcRfsUkYun4orcllCfQ11SSs4wk', '1575364437', 1);
INSERT INTO `eb_template_message` VALUES (6, 0, '3098', '拼团成功通知', '活动名称{{thing1.DATA}}\n团长{{name3.DATA}}\n开团时间{{date5.DATA}}\n成团人数{{number2.DATA}}', 'V9fd7ssFZr5_twdgf--RfAExR4N08zU9Hk9auWDAI8g', '1575364508', 1);
INSERT INTO `eb_template_message` VALUES (7, 0, '2727', '砍价成功通知', '商品名称{{thing1.DATA}}\n底价{{amount2.DATA}}\n备注{{thing3.DATA}}', 'ehNGy-NRBJIENTdlwT8nBddGW2B4dPo6eKv3x1H6fOg', '1575364579', 1);
INSERT INTO `eb_template_message` VALUES (8, 0, '3116', ' 核销成功通知', '商品名称{{thing2.DATA}}\n订单号{{character_string3.DATA}}\n核销时间{{time4.DATA}}', '5wiR0TK43wguWdGzexocKvn9-nhELiJtoBKeqptsf84', '1575364738', 1);
INSERT INTO `eb_template_message` VALUES (9, 0, '1476', ' 新订单提醒', '订单商品{{thing2.DATA}}\n订单金额{{amount3.DATA}}\n订单编号{{character_string4.DATA}}\n订单时间{{date6.DATA}}\n订单类型{{thing1.DATA}}', 'F7ju2FdKqFQ8rXXzkB34HSYKa5_kOzJrpF9EZQc1pJ8', '1575364792', 1);
INSERT INTO `eb_template_message` VALUES (10, 0, '1451', ' 退款通知', '退款状态{{thing1.DATA}}\n退款商品{{thing2.DATA}}\n退款金额{{amount3.DATA}}\n退款单号{{character_string6.DATA}}', 'aqp6PzdU9vCUOUCHsuGFWvkZgp_cGQ_RKW7XCe9118I', '1575364895', 1);
INSERT INTO `eb_template_message` VALUES (11, 0, '755', ' 充值成功通知', '交易单号{{character_string1.DATA}}\n充值金额{{amount3.DATA}}\n账户余额{{amount4.DATA}}\n充值时间{{date5.DATA}}', '_0KAysps9Yj0SM3nacaF_9xw77w1NQYjOpnl4TQAp7k', '1575365017', 1);
INSERT INTO `eb_template_message` VALUES (12, 0, '1927', '付款成功通知', '付款单号{{character_string1.DATA}}\n付款金额{{amount2.DATA}}\n付款时间{{date3.DATA}}', 'jY2vT0Fge2srW9Izc-3wEE6WII-FQBvEi2J_duiAAck', '1575365111', 1);
INSERT INTO `eb_template_message` VALUES (13, 0, '1468', '申请退款通知', '订单编号{{character_string4.DATA}}\n申请时间{{date5.DATA}}\n订单金额{{amount2.DATA}}\n退款状态{{phrase7.DATA}}\n备注{{thing8.DATA}}', 'NOfT3qoOS3hkSzwt2LJg_LnU0NBzwSHXkSwKdx6QDwc', '1575440940', 1);
INSERT INTO `eb_template_message` VALUES (14, 0, '335', '积分到账提醒', '订单编号{{character_string2.DATA}}\n商品名称{{thing3.DATA}}\n支付金额{{amount4.DATA}}\n获得积分{{number5.DATA}}\n累计积分{{number6.DATA}}', 'TtdbifwMN-6D3hNld8jTc97A8Ohlqg4FtgmIgB28JPc', '1575516565', 1);
INSERT INTO `eb_template_message` VALUES (15, 0, '3353', '拼团状态通知', '商品名称{{thing2.DATA}}\n拼团人数{{thing1.DATA}}\n备注{{thing3.DATA}}', 'LkYDDYO-HQKT7NydGjrN7AJ1OUCf3mgZf3otVruhxOo', '1575516605', 1);
INSERT INTO `eb_template_message` VALUES (16, 1, 'OPENTM200565259', '订单发货提醒', '{{first.DATA}}\n订单编号：{{keyword1.DATA}}\n物流公司：{{keyword2.DATA}}\n物流单号：{{keyword3.DATA}}\n{{remark.DATA}}', 'KusKZOFc_4CrRU_gzuXMdMMTfFeR-OLVVuDiMyR5PiM', '1515052638', 1);
INSERT INTO `eb_template_message` VALUES (17, 1, 'OPENTM413386489', '订单收货通知', '{{first.DATA}}\n订单编号：{{keyword1.DATA}}\n订单状态：{{keyword2.DATA}}\n收货时间：{{keyword3.DATA}}\n商品详情：{{keyword4.DATA}}\n{{remark.DATA}}', 'UNyz81kgsn1WZHSqmwPiF9fUkcdZghfTZvN6qtDuu54', '1515052765', 1);
INSERT INTO `eb_template_message` VALUES (18, 1, 'OPENTM410119152', '退款进度通知', '{{first.DATA}}\n订单编号：{{keyword1.DATA}}\n订单金额：{{keyword2.DATA}}\n下单时间：{{keyword3.DATA}}\n{{remark.DATA}}', 'xrXtApBFv0L3-YXKkl9WYB89hJxFGfQo3jSsk2WpAwI', '1515053049', 1);
INSERT INTO `eb_template_message` VALUES (19, 1, 'OPENTM405847076', '帐户资金变动提醒', '{{first.DATA}}\n变动类型：{{keyword1.DATA}}\n变动时间：{{keyword2.DATA}}\n变动金额：{{keyword3.DATA}}\n{{remark.DATA}}', 'Bk3XLd1Nwk9aNF1NIPBlyTDhrgNbzJW4H23OwVQdE-s', '1515053127', 1);
INSERT INTO `eb_template_message` VALUES (20, 1, 'OPENTM207707249', '订单发货提醒', '\n{{first.DATA}}\n商品明细：{{keyword1.DATA}}\n下单时间：{{keyword2.DATA}}\n配送地址：{{keyword3.DATA}}\n配送人：{{keyword4.DATA}}\n联系电话：{{keyword5.DATA}}\n{{remark.DATA}}', 'KusKZOFc_4CrRU_gzuXMdMMTfFeR-OLVVuDiMyR5PiM', '1515053313', 1);
INSERT INTO `eb_template_message` VALUES (21, 1, 'OPENTM408237350', '服务进度提醒', '{{first.DATA}}\n服务类型：{{keyword1.DATA}}\n服务状态：{{keyword2.DATA}}\n服务时间：{{keyword3.DATA}}\n{{remark.DATA}}', 'ul2g_y0oxqEhtWoSJBbLzmnPrUwtLnIAe30MTBRL7rw', '1515483915', 1);
INSERT INTO `eb_template_message` VALUES (22, 1, 'OPENTM204431262', '客服通知提醒', '{{first.DATA}}\n客户名称：{{keyword1.DATA}}\n客服类型：{{keyword2.DATA}}\n提醒内容：{{keyword3.DATA}}\n通知时间：{{keyword4.DATA}}\n{{remark.DATA}}', 'j51mawxEmTuCCtMrXwSTnRfXH93qutoOebs5RG4MyHY', '1515484354', 1);
INSERT INTO `eb_template_message` VALUES (23, 1, 'OPENTM407456411', '拼团成功通知', '{{first.DATA}}\n订单编号：{{keyword1.DATA}}\n团购商品：{{keyword2.DATA}}\n{{remark.DATA}}', 'CNvCAz9GIoQri-ogSCODVRANCBUQjZIxWzWvizbHVoQ', '1520063823', 1);
INSERT INTO `eb_template_message` VALUES (24, 1, 'OPENTM401113750', '拼团失败通知', '{{first.DATA}}\n拼团商品：{{keyword1.DATA}}\n商品金额：{{keyword2.DATA}}\n退款金额：{{keyword3.DATA}}\n{{remark.DATA}}', 'mSg4ZexW1qaQH3FCrFLe746EYMlTFsZhfTB6VI_ElYg', '1520064059', 1);
INSERT INTO `eb_template_message` VALUES (25, 1, 'OPENTM205213550', '订单生成通知', '{{first.DATA}}\n时间：{{keyword1.DATA}}\n商品名称：{{keyword2.DATA}}\n订单号：{{keyword3.DATA}}\n{{remark.DATA}}', 'HYD99ERso6_PcA3hAT6pzH1RmO88H6IIe8crAVaXPRE', '1528966701', 1);
INSERT INTO `eb_template_message` VALUES (26, 1, 'OPENTM207791277', '订单支付成功通知', '{{first.DATA}}\n订单编号：{{keyword1.DATA}}\n支付金额：{{keyword2.DATA}}\n{{remark.DATA}}', 'hJV1d1OwWB_lbPrSaRHi9RGr5CFAF4PJcZdYeg73Mtg', '1528966759', 1);
INSERT INTO `eb_template_message` VALUES (27, 1, 'OPENTM410292733', '砍价成功提醒', '{{first.DATA}}\n商品名称：{{keyword1.DATA}}\n底价：{{keyword2.DATA}}\n{{remark.DATA}}', 'SxBvid65JxK6PWOhlC2sgCG_mlopY1uKekEnEvAALp4', '1564566678', 1);
INSERT INTO `eb_template_message` VALUES (28, 1, 'OPENTM414349441', '开团成功通知', '{{first.DATA}}\n拼团名称：{{keyword1.DATA}}\n团购价格：{{keyword2.DATA}}\n拼团人数：{{keyword3.DATA}}\n{{remark.DATA}}', 'VDTU6X1UiK438tu-qcHKc_I76CtsEWVx-_Pbf1voiws', '1564567037', 1);

-- ----------------------------
-- Table structure for eb_user
-- ----------------------------
DROP TABLE IF EXISTS `eb_user`;
CREATE TABLE `eb_user`  (
  `uid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `account` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `pwd` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `real_name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `birthday` int(11) NOT NULL DEFAULT 0 COMMENT '生日',
  `card_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '身份证号码',
  `mark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户备注',
  `partner_id` int(11) NOT NULL DEFAULT 0 COMMENT '合伙人id',
  `group_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户分组id',
  `nickname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户头像',
  `phone` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `add_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `add_ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '添加ip',
  `last_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后一次登录时间',
  `last_ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后一次登录ip',
  `now_money` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '用户余额',
  `brokerage_price` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '佣金金额',
  `integral` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '用户剩余积分',
  `sign_num` int(11) NOT NULL DEFAULT 0 COMMENT '连续签到天数',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1为正常，0为禁止',
  `level` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '等级',
  `spread_uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '推广元id',
  `spread_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '推广员关联时间',
  `user_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户类型',
  `is_promoter` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为推广员',
  `pay_count` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '用户购买次数',
  `spread_count` int(11) NULL DEFAULT 0 COMMENT '下级人数',
  `clean_time` int(11) NULL DEFAULT 0 COMMENT '清理会员时间',
  `addres` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '详细地址',
  `adminid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '管理员编号 ',
  `login_type` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户登陆类型，h5,wechat,routine',
  `pospal_number` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '银豹系统商品代码，只用于迁移数据',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `account`(`account`) USING BTREE,
  INDEX `spreaduid`(`spread_uid`) USING BTREE,
  INDEX `level`(`level`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `is_promoter`(`is_promoter`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_address
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_address`;
CREATE TABLE `eb_user_address`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户地址id',
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `real_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人电话',
  `province` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人所在省',
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人所在市',
  `city_id` int(11) NOT NULL DEFAULT 0 COMMENT '城市id',
  `district` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人所在区',
  `detail` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人详细地址',
  `post_code` int(10) UNSIGNED NOT NULL COMMENT '邮编',
  `longitude` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '经度',
  `latitude` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '纬度',
  `is_default` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否默认',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除',
  `add_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `is_default`(`is_default`) USING BTREE,
  INDEX `is_del`(`is_del`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户地址表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_bill
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_bill`;
CREATE TABLE `eb_user_bill`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户账单id',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户uid',
  `link_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '关联id',
  `pm` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = 支出 1 = 获得',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '账单标题',
  `category` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '明细种类',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '明细类型',
  `number` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '明细数字',
  `balance` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '剩余',
  `mark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `add_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = 带确定 1 = 有效 -1 = 无效',
  `take` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = 未收货 1 = 已收货',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `openid`(`uid`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `pm`(`pm`) USING BTREE,
  INDEX `type`(`category`, `type`, `link_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户账单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_enter
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_enter`;
CREATE TABLE `eb_user_enter`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商户申请ID',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `province` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户所在省',
  `city` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户所在市',
  `district` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户所在区',
  `address` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户详细地址',
  `merchant_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户名称',
  `link_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `link_tel` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户电话',
  `charter` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户证书',
  `add_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `apply_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '审核时间',
  `success_time` int(11) NOT NULL COMMENT '通过时间',
  `fail_message` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '未通过原因',
  `fail_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '未通过时间',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '-1 审核未通过 0未审核 1审核通过',
  `is_lock` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = 开启 1= 关闭',
  `is_del` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uid`(`uid`) USING BTREE,
  INDEX `province`(`province`, `city`, `district`) USING BTREE,
  INDEX `is_lock`(`is_lock`) USING BTREE,
  INDEX `is_del`(`is_del`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商户申请表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_extract
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_extract`;
CREATE TABLE `eb_user_extract`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NULL DEFAULT NULL,
  `real_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `extract_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'bank' COMMENT 'bank = 银行卡 alipay = 支付宝wx=微信',
  `bank_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '银行卡',
  `bank_address` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '开户地址',
  `alipay_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '支付宝账号',
  `extract_price` decimal(8, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '提现金额',
  `mark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `balance` decimal(8, 2) UNSIGNED NULL DEFAULT 0.00,
  `fail_msg` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '无效原因',
  `fail_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `add_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `status` tinyint(2) NULL DEFAULT 0 COMMENT '-1 未通过 0 审核中 1 已提现',
  `wechat` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `extract_type`(`extract_type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `openid`(`uid`) USING BTREE,
  INDEX `fail_time`(`fail_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户提现表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_group
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_group`;
CREATE TABLE `eb_user_group`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户分组名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户分组表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_level
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_level`;
CREATE TABLE `eb_user_level`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT '用户uid',
  `level_id` int(11) NOT NULL DEFAULT 0 COMMENT '等级vip',
  `grade` int(11) NOT NULL DEFAULT 0 COMMENT '会员等级',
  `valid_time` int(11) NOT NULL DEFAULT 0 COMMENT '过期时间',
  `is_forever` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否永久',
  `mer_id` int(11) NOT NULL DEFAULT 0 COMMENT '商户id',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0:禁止,1:正常',
  `mark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `remind` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已通知',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除,0=未删除,1=删除',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  `discount` int(11) NOT NULL DEFAULT 0 COMMENT '享受折扣',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户等级记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_notice
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_notice`;
CREATE TABLE `eb_user_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接收消息的用户id（类型：json数据）',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '消息通知类型（1：系统消息；2：用户通知）',
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '发送人',
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知消息的标题信息',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知消息的内容',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '通知消息发送的时间',
  `is_send` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否发送（0：未发送；1：已发送）',
  `send_time` int(11) NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户通知表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_notice_see
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_notice_see`;
CREATE TABLE `eb_user_notice_see`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nid` int(11) NOT NULL DEFAULT 0 COMMENT '查看的通知id',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT '查看通知的用户id',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '查看通知的时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户通知发送记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_recharge
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_recharge`;
CREATE TABLE `eb_user_recharge`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) NULL DEFAULT NULL COMMENT '充值用户UID',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `price` decimal(8, 2) NULL DEFAULT NULL COMMENT '充值金额',
  `give_price` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '购买赠送金额',
  `recharge_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '充值类型',
  `paid` tinyint(1) NULL DEFAULT NULL COMMENT '是否充值',
  `pay_time` int(10) NULL DEFAULT NULL COMMENT '充值支付时间',
  `add_time` int(12) NULL DEFAULT NULL COMMENT '充值时间',
  `refund_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '退款金额',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `recharge_type`(`recharge_type`) USING BTREE,
  INDEX `paid`(`paid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户充值表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_sign
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_sign`;
CREATE TABLE `eb_user_sign`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT '用户uid',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '签到说明',
  `number` int(11) NOT NULL DEFAULT 0 COMMENT '获得积分',
  `balance` int(11) NOT NULL DEFAULT 0 COMMENT '剩余积分',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '签到记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_task_finish
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_task_finish`;
CREATE TABLE `eb_user_task_finish`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL DEFAULT 0 COMMENT '任务id',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT '用户id',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否有效',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户任务完成记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_user_token
-- ----------------------------
DROP TABLE IF EXISTS `eb_user_token`;
CREATE TABLE `eb_user_token`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户 id',
  `token` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'token',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `expires_time` datetime(0) NOT NULL COMMENT '到期事件',
  `login_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录ip',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_wechat_media
-- ----------------------------
DROP TABLE IF EXISTS `eb_wechat_media`;
CREATE TABLE `eb_wechat_media`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '微信视频音频id',
  `type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '回复类型',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件路径',
  `media_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '微信服务器返回的id',
  `url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '地址',
  `temporary` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否永久或者临时 0永久1临时',
  `add_time` int(10) UNSIGNED NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`, `media_id`) USING BTREE,
  INDEX `type_2`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信回复表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_wechat_message
-- ----------------------------
DROP TABLE IF EXISTS `eb_wechat_message`;
CREATE TABLE `eb_wechat_message`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户行为记录id',
  `openid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户openid',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作类型',
  `result` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作详细记录',
  `add_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `openid`(`openid`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户行为记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_wechat_news_category
-- ----------------------------
DROP TABLE IF EXISTS `eb_wechat_news_category`;
CREATE TABLE `eb_wechat_news_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '图文消息管理ID',
  `cate_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图文名称',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态',
  `new_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文章id',
  `add_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图文消息管理表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_wechat_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `eb_wechat_qrcode`;
CREATE TABLE `eb_wechat_qrcode`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '微信二维码ID',
  `third_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '二维码类型',
  `third_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
  `ticket` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '二维码参数',
  `expire_seconds` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '二维码有效时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态',
  `add_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '添加时间',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '微信访问url',
  `qrcode_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '微信二维码url',
  `scan` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '被扫的次数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `third_type`(`third_type`, `third_id`) USING BTREE,
  INDEX `ticket`(`ticket`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信二维码管理表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_wechat_reply
-- ----------------------------
DROP TABLE IF EXISTS `eb_wechat_reply`;
CREATE TABLE `eb_wechat_reply`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '微信关键字回复id',
  `key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '回复类型',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '回复数据',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0=不可用  1 =可用',
  `hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `key`(`key`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `hide`(`hide`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信关键字回复表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eb_wechat_user
-- ----------------------------
DROP TABLE IF EXISTS `eb_wechat_user`;
CREATE TABLE `eb_wechat_user`  (
  `uid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '微信用户id',
  `unionid` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段',
  `openid` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户的标识，对当前公众号唯一',
  `routine_openid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小程序唯一身份ID',
  `nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的昵称',
  `headimgurl` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户头像',
  `sex` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户所在城市',
  `language` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的语言，简体中文为zh_CN',
  `province` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户所在省份',
  `country` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户所在国家',
  `remark` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注',
  `groupid` smallint(5) UNSIGNED NULL DEFAULT 0 COMMENT '用户所在的分组ID（兼容旧的用户分组接口）',
  `tagid_list` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户被打上的标签ID列表',
  `subscribe` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '用户是否订阅该公众号标识',
  `subscribe_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '关注公众号时间',
  `add_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `stair` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '一级推荐人',
  `second` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '二级推荐人',
  `order_stair` int(11) NULL DEFAULT NULL COMMENT '一级推荐人订单',
  `order_second` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '二级推荐人订单',
  `now_money` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '佣金',
  `session_key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小程序用户会话密匙',
  `user_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'wechat' COMMENT '用户类型',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `groupid`(`groupid`) USING BTREE,
  INDEX `subscribe_time`(`subscribe_time`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `subscribe`(`subscribe`) USING BTREE,
  INDEX `unionid`(`unionid`) USING BTREE,
  INDEX `openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信用户表' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
