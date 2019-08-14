/*
Navicat MySQL Data Transfer

Source Server         : localhost_mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : scm_new

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-05-09 17:18:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '水果', null);
INSERT INTO `category` VALUES ('2', '服装', null);
INSERT INTO `category` VALUES ('3', '箱包', null);
INSERT INTO `category` VALUES ('4', '护肤', null);
INSERT INTO `category` VALUES ('5', '母婴', null);

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
-- Table structure for `payrecord`
-- ----------------------------
DROP TABLE IF EXISTS `payrecord`;
CREATE TABLE `payrecord` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_time` varchar(32) DEFAULT NULL,
  `pay_price` decimal(12,2) DEFAULT NULL,
  `account` varchar(32) DEFAULT NULL,
  `ordercode` varchar(32) DEFAULT NULL,
  `pay_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payrecord
-- ----------------------------
INSERT INTO `payrecord` VALUES ('1', '2019-05-09 14:58:09', '7900.00', 'lisi', '20190509132825', '2');
INSERT INTO `payrecord` VALUES ('2', '2019-05-09 14:58:12', '100.00', 'lisi', '20190509132907', '4');
INSERT INTO `payrecord` VALUES ('3', '2019-05-09 14:59:40', '5500.00', 'lisi', '20190509132745', '2');
INSERT INTO `payrecord` VALUES ('4', '2019-05-09 14:59:43', '1300.00', 'lisi', '20190509132907', '2');
INSERT INTO `payrecord` VALUES ('5', '2019-05-09 16:51:35', '600.00', 'lisi', '20190509161238', '2');
INSERT INTO `payrecord` VALUES ('6', '2019-05-09 16:51:41', '30.00', 'lisi', '20190509163001', '4');
INSERT INTO `payrecord` VALUES ('7', '2019-05-09 16:53:13', '370.00', 'lisi', '20190509161757', '2');
INSERT INTO `payrecord` VALUES ('8', '2019-05-09 16:53:16', '110.00', 'lisi', '20190509163001', '2');

-- ----------------------------
-- Table structure for `poitem`
-- ----------------------------
DROP TABLE IF EXISTS `poitem`;
CREATE TABLE `poitem` (
  `POID` decimal(14,0) NOT NULL,
  `ProductCode` varchar(20) NOT NULL,
  `UnitPrice` float NOT NULL,
  `Num` int(11) NOT NULL,
  `UnitName` varchar(5) NOT NULL,
  `ItemPrice` float NOT NULL,
  PRIMARY KEY (`POID`,`ProductCode`),
  KEY `FK_P_P` (`ProductCode`),
  CONSTRAINT `FK_PD_PM` FOREIGN KEY (`POID`) REFERENCES `pomain` (`POID`),
  CONSTRAINT `FK_P_P` FOREIGN KEY (`ProductCode`) REFERENCES `product` (`ProductCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poitem
-- ----------------------------
INSERT INTO `poitem` VALUES ('20190509132745', '1001', '5', '100', '斤', '500');
INSERT INTO `poitem` VALUES ('20190509132745', '1008', '50', '100', '双', '5000');
INSERT INTO `poitem` VALUES ('20190509132825', '1001', '3', '100', '斤', '300');
INSERT INTO `poitem` VALUES ('20190509132825', '1004', '20', '100', '件', '2000');
INSERT INTO `poitem` VALUES ('20190509132825', '1007', '50', '100', '件', '5000');
INSERT INTO `poitem` VALUES ('20190509132825', '1012', '6', '100', '斤', '600');
INSERT INTO `poitem` VALUES ('20190509132907', '1009', '10', '100', '件', '1000');
INSERT INTO `poitem` VALUES ('20190509132907', '1013', '2', '100', '斤', '200');
INSERT INTO `poitem` VALUES ('20190509161238', '1002', '12', '10', '斤', '120');
INSERT INTO `poitem` VALUES ('20190509161238', '1004', '24', '10', '件', '240');
INSERT INTO `poitem` VALUES ('20190509161238', '1011', '12', '10', '斤', '120');
INSERT INTO `poitem` VALUES ('20190509161238', '1012', '12', '10', '斤', '120');
INSERT INTO `poitem` VALUES ('20190509161757', '1010', '25', '10', '斤', '250');
INSERT INTO `poitem` VALUES ('20190509161757', '1013', '12', '10', '斤', '120');
INSERT INTO `poitem` VALUES ('20190509163001', '1006', '120', '1', '件', '120');
INSERT INTO `poitem` VALUES ('20190509163001', '1012', '10', '1', '斤', '10');

-- ----------------------------
-- Table structure for `pomain`
-- ----------------------------
DROP TABLE IF EXISTS `pomain`;
CREATE TABLE `pomain` (
  `POID` decimal(14,0) NOT NULL,
  `VenderCode` varchar(20) DEFAULT NULL,
  `Account` varchar(20) DEFAULT NULL,
  `CreateTime` varchar(20) NOT NULL,
  `TipFee` float NOT NULL,
  `ProductTotal` float NOT NULL,
  `POTotal` float NOT NULL,
  `PayType` int(11) NOT NULL,
  `PrePayFee` float NOT NULL,
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
INSERT INTO `pomain` VALUES ('20190509132745', '1001', 'lisi', '2019-05-09 13:27:45', '0', '5500', '5500', '1', '0', '4', '', '2019-05-09 14:59:30', 'lisi', '2019-05-09 14:59:40', 'lisi', null, null, '2019-05-09 15:00:53', 'lisi');
INSERT INTO `pomain` VALUES ('20190509132825', '1003', 'lisi', '2019-05-09 13:28:25', '0', '7900', '7900', '2', '0', '4', '', '2019-05-09 14:59:23', 'lisi', '2019-05-09 14:58:09', 'lisi', null, null, '2019-05-09 15:00:56', 'lisi');
INSERT INTO `pomain` VALUES ('20190509132907', '1004', 'lisi', '2019-05-09 13:29:07', '200', '1200', '1400', '3', '100', '4', '', '2019-05-09 14:59:27', 'lisi', '2019-05-09 14:59:43', 'lisi', '2019-05-09 14:58:12', 'lisi', '2019-05-09 15:00:59', 'lisi');
INSERT INTO `pomain` VALUES ('20190509161238', '1003', 'lisi', '2019-05-09 16:12:38', '0', '600', '600', '2', '0', '4', '', '2019-05-09 16:52:59', 'lisi', '2019-05-09 16:51:35', 'lisi', null, null, '2019-05-09 16:53:31', 'lisi');
INSERT INTO `pomain` VALUES ('20190509161757', '1003', 'lisi', '2019-05-09 16:17:57', '0', '370', '370', '1', '0', '4', '', '2019-05-09 16:53:01', 'lisi', '2019-05-09 16:53:13', 'lisi', null, null, '2019-05-09 16:53:33', 'lisi');
INSERT INTO `pomain` VALUES ('20190509163001', '1001', 'lisi', '2019-05-09 16:30:01', '10', '130', '140', '3', '30', '4', '', '2019-05-09 16:52:56', 'lisi', '2019-05-09 16:53:16', 'lisi', '2019-05-09 16:51:41', 'lisi', '2019-05-09 16:53:36', 'lisi');

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ProductCode` varchar(20) NOT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `Name` varchar(50) NOT NULL,
  `UnitName` varchar(5) NOT NULL,
  `Price` float NOT NULL,
  `CreateDate` varchar(20) NOT NULL,
  `Remark` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `PONum` int(11) NOT NULL,
  `SONum` int(11) NOT NULL,
  PRIMARY KEY (`ProductCode`),
  KEY `FK_P_C` (`CategoryID`),
  CONSTRAINT `FK_P_C` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1001', '1', '苹果', '斤', '6.88', '2019-01-02', null, '200', '0', '0');
INSERT INTO `product` VALUES ('1002', '1', '香蕉', '斤', '4.58', '2019-01-03', null, '10', '0', '0');
INSERT INTO `product` VALUES ('1003', '1', '海南蜜宝红心火龙果', '斤', '15.88', '2018-03-09', null, '0', '0', '0');
INSERT INTO `product` VALUES ('1004', '2', '小猪佩奇T恤', '件', '89', '2018-02-09', null, '110', '0', '0');
INSERT INTO `product` VALUES ('1005', '5', '婴幼儿奶粉', '桶', '320', '2019-01-01', null, '0', '0', '0');
INSERT INTO `product` VALUES ('1006', '5', '贝亲奶瓶', '件', '120', '2019-01-01', null, '1', '0', '0');
INSERT INTO `product` VALUES ('1007', '5', '纸尿裤', '件', '120', '2019-01-01', null, '100', '0', '0');
INSERT INTO `product` VALUES ('1008', '5', '学步鞋', '双', '180', '2019-01-01', null, '100', '0', '0');
INSERT INTO `product` VALUES ('1009', '5', '小猪佩奇玩具', '件', '120', '2019-01-01', null, '100', '0', '0');
INSERT INTO `product` VALUES ('1010', '1', '西瓜', '斤', '5.99', '2019-01-01', null, '10', '0', '0');
INSERT INTO `product` VALUES ('1011', '1', '荔枝', '斤', '19.9', '2019-01-01', null, '10', '0', '0');
INSERT INTO `product` VALUES ('1012', '1', '阿克苏苹果', '斤', '8.99', '2019-01-01', null, '111', '0', '0');
INSERT INTO `product` VALUES ('1013', '1', '海南香水菠萝', '斤', '3.99', '2019-01-01', null, '110', '0', '0');
INSERT INTO `product` VALUES ('1014', '1', '橘子', '斤', '8.99', '2019-05-09', null, '0', '0', '0');

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
INSERT INTO `scmuser` VALUES ('lisi', '12345', '李四', '2018-10-01', '0');
INSERT INTO `scmuser` VALUES ('wangwu', '555', '王五', '2016-11-09', '0');
INSERT INTO `scmuser` VALUES ('wangwu1', '1212', '121', '2019-05-09 12:54:41', '0');

-- ----------------------------
-- Table structure for `soitem`
-- ----------------------------
DROP TABLE IF EXISTS `soitem`;
CREATE TABLE `soitem` (
  `SOID` decimal(14,0) NOT NULL,
  `ProductCode` varchar(20) NOT NULL,
  `UnitPrice` float NOT NULL,
  `Num` int(11) NOT NULL,
  `UnitName` varchar(5) NOT NULL,
  `ItemPrice` float NOT NULL,
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
  `SOID` decimal(14,0) NOT NULL,
  `CustomerCode` varchar(20) DEFAULT NULL,
  `Account` varchar(20) DEFAULT NULL,
  `CreateTime` varchar(20) NOT NULL,
  `TipFee` float NOT NULL,
  `ProductTotal` float NOT NULL,
  `POTotal` float NOT NULL,
  `PayType` int(11) NOT NULL,
  `PrePayFee` float NOT NULL,
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
  `ProductCode` varchar(20) DEFAULT NULL,
  `OrderCode` varchar(20) DEFAULT NULL,
  `StockNum` int(11) NOT NULL,
  `StockType` int(11) NOT NULL,
  `StockTime` varchar(20) NOT NULL,
  `CreateUser` varchar(10) NOT NULL,
  PRIMARY KEY (`StockID`),
  KEY `FK_O_P` (`ProductCode`),
  CONSTRAINT `FK_O_P` FOREIGN KEY (`ProductCode`) REFERENCES `product` (`ProductCode`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockrecord
-- ----------------------------
INSERT INTO `stockrecord` VALUES ('1', '1001', '20190509132825', '100', '1', '2019-05-09 14:59:24', 'lisi');
INSERT INTO `stockrecord` VALUES ('2', '1004', '20190509132825', '100', '1', '2019-05-09 14:59:24', 'lisi');
INSERT INTO `stockrecord` VALUES ('3', '1007', '20190509132825', '100', '1', '2019-05-09 14:59:24', 'lisi');
INSERT INTO `stockrecord` VALUES ('4', '1012', '20190509132825', '100', '1', '2019-05-09 14:59:24', 'lisi');
INSERT INTO `stockrecord` VALUES ('5', '1009', '20190509132907', '100', '1', '2019-05-09 14:59:27', 'lisi');
INSERT INTO `stockrecord` VALUES ('6', '1013', '20190509132907', '100', '1', '2019-05-09 14:59:27', 'lisi');
INSERT INTO `stockrecord` VALUES ('7', '1001', '20190509132745', '100', '1', '2019-05-09 14:59:30', 'lisi');
INSERT INTO `stockrecord` VALUES ('8', '1008', '20190509132745', '100', '1', '2019-05-09 14:59:30', 'lisi');
INSERT INTO `stockrecord` VALUES ('9', '1006', '20190509163001', '1', '1', '2019-05-09 16:52:56', 'lisi');
INSERT INTO `stockrecord` VALUES ('10', '1012', '20190509163001', '1', '1', '2019-05-09 16:52:56', 'lisi');
INSERT INTO `stockrecord` VALUES ('11', '1002', '20190509161238', '10', '1', '2019-05-09 16:52:59', 'lisi');
INSERT INTO `stockrecord` VALUES ('12', '1004', '20190509161238', '10', '1', '2019-05-09 16:52:59', 'lisi');
INSERT INTO `stockrecord` VALUES ('13', '1011', '20190509161238', '10', '1', '2019-05-09 16:52:59', 'lisi');
INSERT INTO `stockrecord` VALUES ('14', '1012', '20190509161238', '10', '1', '2019-05-09 16:52:59', 'lisi');
INSERT INTO `stockrecord` VALUES ('15', '1010', '20190509161757', '10', '1', '2019-05-09 16:53:01', 'lisi');
INSERT INTO `stockrecord` VALUES ('16', '1013', '20190509161757', '10', '1', '2019-05-09 16:53:01', 'lisi');

-- ----------------------------
-- Table structure for `systemmodel`
-- ----------------------------
DROP TABLE IF EXISTS `systemmodel`;
CREATE TABLE `systemmodel` (
  `ModelCode` int(11) NOT NULL AUTO_INCREMENT,
  `ModelName` varchar(20) NOT NULL,
  `ModelUri` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ModelCode`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of systemmodel
-- ----------------------------
INSERT INTO `systemmodel` VALUES ('1', '采购管理', '/main/pomain');
INSERT INTO `systemmodel` VALUES ('2', '销售管理', '/main/somain');
INSERT INTO `systemmodel` VALUES ('3', '系统管理', '/main/system');
INSERT INTO `systemmodel` VALUES ('4', '财务管理', '/main/finance');
INSERT INTO `systemmodel` VALUES ('5', '仓库管理', '/main/stock');
INSERT INTO `systemmodel` VALUES ('6', '业务报表', '/main/report');

-- ----------------------------
-- Table structure for `usermodel`
-- ----------------------------
DROP TABLE IF EXISTS `usermodel`;
CREATE TABLE `usermodel` (
  `Account` varchar(20) NOT NULL,
  `ModelCode` int(11) NOT NULL,
  PRIMARY KEY (`Account`,`ModelCode`),
  KEY `FK_UM_SM` (`ModelCode`),
  CONSTRAINT `FK_UM_SM` FOREIGN KEY (`ModelCode`) REFERENCES `systemmodel` (`ModelCode`),
  CONSTRAINT `FK_UM_U` FOREIGN KEY (`Account`) REFERENCES `scmuser` (`Account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usermodel
-- ----------------------------
INSERT INTO `usermodel` VALUES ('lisi', '1');
INSERT INTO `usermodel` VALUES ('wangwu', '1');
INSERT INTO `usermodel` VALUES ('wangwu1', '1');
INSERT INTO `usermodel` VALUES ('lisi', '2');
INSERT INTO `usermodel` VALUES ('wangwu1', '2');
INSERT INTO `usermodel` VALUES ('lisi', '3');
INSERT INTO `usermodel` VALUES ('wangwu1', '3');
INSERT INTO `usermodel` VALUES ('lisi', '4');
INSERT INTO `usermodel` VALUES ('lisi', '5');
INSERT INTO `usermodel` VALUES ('lisi', '6');

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
INSERT INTO `vender` VALUES ('1001', '水果店', '123', '张三', '杭州', '1', '122', '11', '2019-01-02');
INSERT INTO `vender` VALUES ('1002', '服装店', '1', '王五', '上海', '1', '1', '1', '2008-09-01');
INSERT INTO `vender` VALUES ('1003', '箱包店', '1', '王大强', '苏州', '1', '1', '1', '2009-09-09');
INSERT INTO `vender` VALUES ('1004', '化妆品店', '1', '张晓红', '南京', '1', '1', '1', '2009-09-08');
