/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : scm

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-06-23 10:19:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CategoryID` int(6) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '水果', null);
INSERT INTO `category` VALUES ('2', '零食', null);
INSERT INTO `category` VALUES ('3', '服装', null);
INSERT INTO `category` VALUES ('4', '化妆品', null);
INSERT INTO `category` VALUES ('5', '家居用品', null);

-- ----------------------------
-- Table structure for `checkstock`
-- ----------------------------
DROP TABLE IF EXISTS `checkstock`;
CREATE TABLE `checkstock` (
  `StockID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductCode` varchar(20) DEFAULT NULL,
  `OriginNum` int(11) DEFAULT NULL,
  `RealNum` int(11) DEFAULT NULL,
  `StockTime` varchar(20) DEFAULT NULL,
  `CreateUser` varchar(10) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`StockID`),
  KEY `FK_C_S` (`ProductCode`),
  CONSTRAINT `FK_C_S` FOREIGN KEY (`ProductCode`) REFERENCES `product` (`ProductCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of checkstock
-- ----------------------------

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `CustomerCode` varchar(20) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Contactor` varchar(10) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `Postcode` varchar(8) DEFAULT NULL,
  `Tel` varchar(20) NOT NULL,
  `Fax` varchar(20) DEFAULT NULL,
  `CreateDate` varchar(20) NOT NULL,
  PRIMARY KEY (`CustomerCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------

-- ----------------------------
-- Table structure for `poitem`
-- ----------------------------
DROP TABLE IF EXISTS `poitem`;
CREATE TABLE `poitem` (
  `POID` decimal(14,0) NOT NULL,
  `ProductCode` varchar(20) NOT NULL,
  `UnitPrice` decimal(12,2) NOT NULL,
  `Num` int(11) NOT NULL,
  `UnitName` varchar(5) NOT NULL,
  `ItemPrice` decimal(12,2) NOT NULL,
  PRIMARY KEY (`POID`,`ProductCode`),
  KEY `FK_P_P` (`ProductCode`),
  CONSTRAINT `FK_P_P` FOREIGN KEY (`ProductCode`) REFERENCES `product` (`ProductCode`),
  CONSTRAINT `poitem_ibfk_1` FOREIGN KEY (`POID`) REFERENCES `pomain` (`POID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poitem
-- ----------------------------
INSERT INTO `poitem` VALUES ('20170615162953', '1', '1.00', '1', '斤', '1.00');
INSERT INTO `poitem` VALUES ('20170615162953', '2', '2.00', '1', '斤', '2.00');
INSERT INTO `poitem` VALUES ('20170620141955', '3', '36.00', '19', '盒', '684.00');
INSERT INTO `poitem` VALUES ('20170620141955', '6', '12.00', '10', '桶', '120.00');
INSERT INTO `poitem` VALUES ('20170620145050', '1', '1.00', '1', '斤', '1.00');
INSERT INTO `poitem` VALUES ('20170620145111', '6', '59.00', '1', '桶', '59.00');
INSERT INTO `poitem` VALUES ('20170621142653', '1', '3.00', '1', '斤', '3.00');
INSERT INTO `poitem` VALUES ('20170621142653', '3', '3.00', '1', '盒', '3.00');
INSERT INTO `poitem` VALUES ('20170621142653', '6', '3.00', '1', '桶', '3.00');
INSERT INTO `poitem` VALUES ('20170621142718', '5', '68.00', '1', '件', '68.00');
INSERT INTO `poitem` VALUES ('20170621142801', '3', '56.00', '1', '盒', '56.00');
INSERT INTO `poitem` VALUES ('20170621142801', '6', '3.00', '1', '桶', '3.00');
INSERT INTO `poitem` VALUES ('20170622142425', '4', '6.00', '10', '件', '60.00');

-- ----------------------------
-- Table structure for `pomain`
-- ----------------------------
DROP TABLE IF EXISTS `pomain`;
CREATE TABLE `pomain` (
  `POID` decimal(14,0) NOT NULL,
  `VenderCode` varchar(20) DEFAULT NULL,
  `Account` varchar(20) DEFAULT NULL,
  `CreateTime` varchar(20) NOT NULL,
  `TipFee` decimal(12,2) NOT NULL,
  `ProductTotal` decimal(12,2) NOT NULL,
  `POTotal` decimal(12,2) NOT NULL,
  `PayType` varchar(12) NOT NULL,
  `PrePayFee` decimal(12,2) NOT NULL,
  `Status` int(11) NOT NULL,
  `Remark` varchar(255) DEFAULT NULL,
  `StockTime` varchar(20) DEFAULT NULL,
  `StockUser` varchar(20) DEFAULT NULL,
  `PayTime` varchar(20) DEFAULT NULL,
  `PayUser` varchar(20) DEFAULT NULL,
  `PrePayTime` varchar(20) DEFAULT NULL,
  `PrePayUser` varchar(20) DEFAULT NULL,
  `EndTime` varchar(20) DEFAULT NULL,
  `EndUser` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`POID`),
  KEY `FK_P_V` (`VenderCode`),
  KEY `FK_P_S` (`Account`),
  CONSTRAINT `FK_P_S` FOREIGN KEY (`Account`) REFERENCES `scmuser` (`Account`),
  CONSTRAINT `FK_P_V` FOREIGN KEY (`VenderCode`) REFERENCES `vender` (`VenderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pomain
-- ----------------------------
INSERT INTO `pomain` VALUES ('20170615162953', '1001', 'lisi', '2017-06-15 16:29:53', '0.00', '3.00', '3.00', '货到付款', '0.00', '4', '', '2017-06-15 16:30:24', 'lisi', '2017-06-20 14:50:37', 'lisi', null, null, '2017-06-21 14:26:38', 'lisi');
INSERT INTO `pomain` VALUES ('20170620141955', '1002', 'lisi', '2017-06-20 14:19:55', '0.00', '804.00', '804.00', '货到付款', '0.00', '4', '', '2017-06-20 14:20:39', 'lisi', '2017-06-20 14:50:40', 'lisi', null, null, '2017-06-22 15:50:44', 'lisi');
INSERT INTO `pomain` VALUES ('20170620145050', '1002', 'lisi', '2017-06-20 14:50:50', '0.00', '1.00', '1.00', '款到发货', '0.00', '4', '', '2017-06-20 15:18:57', 'lisi', '2017-06-20 14:51:52', 'lisi', null, null, '2017-06-22 15:50:47', 'lisi');
INSERT INTO `pomain` VALUES ('20170620145111', '1002', 'lisi', '2017-06-20 14:51:11', '0.00', '59.00', '59.00', '预付款到发货', '2.00', '3', '', '2017-06-20 15:19:01', 'lisi', '2017-06-20 15:19:11', 'lisi', '2017-06-20 15:18:36', 'lisi', null, null);
INSERT INTO `pomain` VALUES ('20170621142653', '1002', 'lisi', '2017-06-21 14:26:53', '0.00', '9.00', '9.00', '货到付款', '0.00', '1', '', null, null, null, null, null, null, null, null);
INSERT INTO `pomain` VALUES ('20170621142718', '1002', 'lisi', '2017-06-21 14:27:18', '0.00', '68.00', '68.00', '款到发货', '0.00', '3', '', null, null, '2017-06-22 14:35:16', 'lisi', null, null, null, null);
INSERT INTO `pomain` VALUES ('20170621142801', '1001', 'lisi', '2017-06-21 14:28:01', '0.00', '59.00', '59.00', '预付款到发货', '6.00', '3', '', '2017-06-22 14:36:13', 'lisi', '2017-06-22 14:36:21', 'lisi', '2017-06-22 14:29:45', 'lisi', null, null);
INSERT INTO `pomain` VALUES ('20170622142425', '1002', 'lisi', '2017-06-22 14:24:25', '12.00', '60.00', '72.00', '货到付款', '0.00', '1', '', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ProductCode` varchar(20) NOT NULL,
  `CategoryID` int(8) DEFAULT NULL,
  `Name` varchar(50) NOT NULL,
  `UnitName` varchar(5) NOT NULL,
  `Price` decimal(12,2) NOT NULL,
  `CreateDate` varchar(20) NOT NULL,
  `Remark` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT '0',
  `PONum` int(11) NOT NULL,
  `SONum` int(11) NOT NULL,
  PRIMARY KEY (`ProductCode`),
  UNIQUE KEY `Name` (`Name`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '1', '进口蛇果', '斤', '13.50', '2017-02-01', '', '2', '1', '0');
INSERT INTO `product` VALUES ('2', '1', '泰国芒果', '斤', '10.30', '2016-01-03', null, '1', '0', '0');
INSERT INTO `product` VALUES ('3', '2', '三只松鼠大礼包', '盒', '89.50', '2016-09-08', null, '20', '1', '0');
INSERT INTO `product` VALUES ('4', '3', '短袖T恤 男装', '件', '130.00', '2015-10-09', null, '0', '10', '0');
INSERT INTO `product` VALUES ('5', '4', '玉兰油 套装', '件', '450.00', '2015-09-06', null, '0', '1', '0');
INSERT INTO `product` VALUES ('6', '5', '蓝月亮洗衣液 2.5L', '桶', '38.00', '2017-01-21', null, '12', '1', '0');

-- ----------------------------
-- Table structure for `scmuser`
-- ----------------------------
DROP TABLE IF EXISTS `scmuser`;
CREATE TABLE `scmuser` (
  `Account` varchar(20) NOT NULL,
  `Password` varchar(20) DEFAULT NULL,
  `Name` varchar(20) DEFAULT NULL,
  `CreateDate` varchar(20) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`Account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scmuser
-- ----------------------------
INSERT INTO `scmuser` VALUES ('fsdf', 'fdfdf', '地方斯蒂芬', '2017-06-12 17:20:25', '0');
INSERT INTO `scmuser` VALUES ('lisi', '123456', '李四1', '2017-06-02 17:24:35', '0');
INSERT INTO `scmuser` VALUES ('lucy', '1234', '露西', '2017-06-05 10:43:41', '0');
INSERT INTO `scmuser` VALUES ('wanger', 'sdsds', '王二', '2017-06-02 17:26:33', '0');
INSERT INTO `scmuser` VALUES ('wangwu', 'qqqq', '王五', '2017-06-02 17:25:44', '0');
INSERT INTO `scmuser` VALUES ('xiaoliu', '121212', '小刘', '2017-06-02 17:26:06', '0');

-- ----------------------------
-- Table structure for `soitem`
-- ----------------------------
DROP TABLE IF EXISTS `soitem`;
CREATE TABLE `soitem` (
  `SOID` decimal(12,0) NOT NULL,
  `ProductCode` varchar(20) NOT NULL,
  `UnitPrice` decimal(12,2) NOT NULL,
  `Num` int(11) NOT NULL,
  `UnitName` varchar(5) NOT NULL,
  `ItemPrice` decimal(12,2) NOT NULL,
  PRIMARY KEY (`SOID`,`ProductCode`),
  KEY `FK_S_P` (`ProductCode`),
  CONSTRAINT `FK_S_P` FOREIGN KEY (`ProductCode`) REFERENCES `product` (`ProductCode`),
  CONSTRAINT `FK_S_S` FOREIGN KEY (`SOID`) REFERENCES `somain` (`SOID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of soitem
-- ----------------------------

-- ----------------------------
-- Table structure for `somain`
-- ----------------------------
DROP TABLE IF EXISTS `somain`;
CREATE TABLE `somain` (
  `SOID` decimal(12,0) NOT NULL,
  `CustomerCode` varchar(20) DEFAULT NULL,
  `Account` varchar(20) DEFAULT NULL,
  `CreateTime` varchar(20) NOT NULL,
  `TipFee` decimal(12,2) NOT NULL,
  `ProductTotal` decimal(12,2) NOT NULL,
  `POTotal` decimal(12,2) NOT NULL,
  `PayType` varchar(12) NOT NULL,
  `PrePayFee` decimal(12,2) NOT NULL,
  `Status` int(11) NOT NULL,
  `Remark` varchar(255) DEFAULT NULL,
  `StockTime` varchar(20) DEFAULT NULL,
  `StockUser` varchar(20) DEFAULT NULL,
  `PayTime` varchar(20) DEFAULT NULL,
  `PayUser` varchar(20) DEFAULT NULL,
  `PrePayTime` varchar(20) DEFAULT NULL,
  `PrePayUser` varchar(20) DEFAULT NULL,
  `EndTime` varchar(20) DEFAULT NULL,
  `EndUser` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SOID`),
  KEY `FK_S_C` (`CustomerCode`),
  KEY `FK_S_U` (`Account`),
  CONSTRAINT `FK_S_C` FOREIGN KEY (`CustomerCode`) REFERENCES `customer` (`CustomerCode`),
  CONSTRAINT `FK_S_U` FOREIGN KEY (`Account`) REFERENCES `scmuser` (`Account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of somain
-- ----------------------------

-- ----------------------------
-- Table structure for `stockrecord`
-- ----------------------------
DROP TABLE IF EXISTS `stockrecord`;
CREATE TABLE `stockrecord` (
  `StockID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductCode` varchar(20) NOT NULL,
  `OrderCode` varchar(20) DEFAULT NULL,
  `StockNum` int(11) NOT NULL,
  `StockType` int(11) NOT NULL,
  `StockTime` varchar(20) NOT NULL,
  `CreateUser` varchar(10) NOT NULL,
  PRIMARY KEY (`StockID`),
  KEY `FK_I_P` (`ProductCode`),
  CONSTRAINT `FK_I_P` FOREIGN KEY (`ProductCode`) REFERENCES `product` (`ProductCode`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockrecord
-- ----------------------------
INSERT INTO `stockrecord` VALUES ('13', '1', '20170615162953', '1', '1', '2017-06-15 16:30:24', 'lisi');
INSERT INTO `stockrecord` VALUES ('14', '2', '20170615162953', '1', '1', '2017-06-15 16:30:24', 'lisi');
INSERT INTO `stockrecord` VALUES ('15', '3', '20170620141955', '19', '1', '2017-06-20 14:20:39', 'lisi');
INSERT INTO `stockrecord` VALUES ('16', '6', '20170620141955', '10', '1', '2017-06-20 14:20:39', 'lisi');
INSERT INTO `stockrecord` VALUES ('17', '1', '20170620145050', '1', '1', '2017-06-20 15:18:57', 'lisi');
INSERT INTO `stockrecord` VALUES ('18', '6', '20170620145111', '1', '1', '2017-06-20 15:19:01', 'lisi');
INSERT INTO `stockrecord` VALUES ('19', '3', '20170621142801', '1', '1', '2017-06-22 14:36:13', 'lisi');
INSERT INTO `stockrecord` VALUES ('20', '6', '20170621142801', '1', '1', '2017-06-22 14:36:13', 'lisi');

-- ----------------------------
-- Table structure for `systemmodel`
-- ----------------------------
DROP TABLE IF EXISTS `systemmodel`;
CREATE TABLE `systemmodel` (
  `ModelCode` int(11) NOT NULL AUTO_INCREMENT,
  `ModelName` varchar(20) NOT NULL,
  `ModelUri` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ModelCode`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of systemmodel
-- ----------------------------
INSERT INTO `systemmodel` VALUES ('1', '系统管理', '/main/system');
INSERT INTO `systemmodel` VALUES ('2', '采购管理', '/main/pomain');
INSERT INTO `systemmodel` VALUES ('3', '仓储管理', '/main/stock');
INSERT INTO `systemmodel` VALUES ('4', '财务收支', '/main/finance');
INSERT INTO `systemmodel` VALUES ('5', '销售管理', '/main/somain');
INSERT INTO `systemmodel` VALUES ('6', '业务报表', '/main/report');
INSERT INTO `systemmodel` VALUES ('7', '网上销售', '/main/online');

-- ----------------------------
-- Table structure for `usermodel`
-- ----------------------------
DROP TABLE IF EXISTS `usermodel`;
CREATE TABLE `usermodel` (
  `Account` varchar(20) NOT NULL,
  `ModelCode` int(11) NOT NULL,
  PRIMARY KEY (`Account`,`ModelCode`),
  CONSTRAINT `FK_UM_U` FOREIGN KEY (`Account`) REFERENCES `scmuser` (`Account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usermodel
-- ----------------------------
INSERT INTO `usermodel` VALUES ('fsdf', '4');
INSERT INTO `usermodel` VALUES ('fsdf', '5');
INSERT INTO `usermodel` VALUES ('lisi', '1');
INSERT INTO `usermodel` VALUES ('lisi', '2');
INSERT INTO `usermodel` VALUES ('lisi', '3');
INSERT INTO `usermodel` VALUES ('lisi', '4');
INSERT INTO `usermodel` VALUES ('lisi', '5');
INSERT INTO `usermodel` VALUES ('lisi', '6');
INSERT INTO `usermodel` VALUES ('lucy', '1');
INSERT INTO `usermodel` VALUES ('lucy', '5');
INSERT INTO `usermodel` VALUES ('lucy', '6');
INSERT INTO `usermodel` VALUES ('wanger', '1');
INSERT INTO `usermodel` VALUES ('wanger', '2');
INSERT INTO `usermodel` VALUES ('wangwu', '1');
INSERT INTO `usermodel` VALUES ('wangwu', '3');
INSERT INTO `usermodel` VALUES ('wangwu', '4');
INSERT INTO `usermodel` VALUES ('xiaoliu', '1');
INSERT INTO `usermodel` VALUES ('xiaoliu', '5');

-- ----------------------------
-- Table structure for `vender`
-- ----------------------------
DROP TABLE IF EXISTS `vender`;
CREATE TABLE `vender` (
  `VenderCode` varchar(20) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Contactor` varchar(10) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `Postcode` varchar(8) DEFAULT NULL,
  `Tel` varchar(20) NOT NULL,
  `Fax` varchar(20) DEFAULT NULL,
  `CreateDate` varchar(20) NOT NULL,
  PRIMARY KEY (`VenderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vender
-- ----------------------------
INSERT INTO `vender` VALUES ('1001', '阿里巴巴', '123', '马云', '杭州未来科技城', '', '1381234567', '', '2017-01-01');
INSERT INTO `vender` VALUES ('1002', '京东商城', '234', '刘强东', '南京', null, '18678990987', null, '2017-02-01');
