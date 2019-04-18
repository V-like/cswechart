/*
SQLyog Ultimate v8.32 
MySQL - 5.5.49 : Database - echart
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`echart` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `echart`;

/*Table structure for table `t_c_contract` */

DROP TABLE IF EXISTS `t_c_contract`;

CREATE TABLE `t_c_contract` (
  `contractid` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `contractname` varchar(200) DEFAULT NULL COMMENT '合同名称',
  `contractnum` varchar(200) DEFAULT NULL COMMENT '合同编码',
  `amount` double DEFAULT NULL COMMENT '合同金额',
  `durationtime` varchar(20) DEFAULT NULL COMMENT '合同工期',
  `signtime` datetime DEFAULT NULL COMMENT '签订日期',
  `contractpartyb` varchar(200) DEFAULT NULL COMMENT '合同乙方',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `priority` int(11) DEFAULT '0' COMMENT '排序',
  `status` int(10) DEFAULT NULL COMMENT '状态',
  `isdisabled` varchar(20) DEFAULT '0' COMMENT '是否禁用',
  `operuser` varchar(20) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  `subofficeid` bigint(11) NOT NULL COMMENT '所属分局ID',
  PRIMARY KEY (`contractid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_c_contract` */

insert  into `t_c_contract`(`contractid`,`contractname`,`contractnum`,`amount`,`durationtime`,`signtime`,`contractpartyb`,`remark`,`priority`,`status`,`isdisabled`,`operuser`,`operdate`,`subofficeid`) values (1,'大理Ⅱ段进场道路施工3标','DZYS-DLⅡ-GCBF-SG-DL003',3271.069711,'365日历天','2019-02-22 00:00:00','中铁二十四局集团南昌铁路工程有限公司',NULL,1,9,'0','admin',NULL,2),(2,'云南省滇中引水工程施工准备工程龙泉倒虹吸始发井和接收井施工','DZYS-ZHBF-JSGL-FLFW-004',9293.94,'365日历天','2019-02-22 00:00:00','中铁二十四局集团南昌铁路工程有限公司',NULL,2,9,'0','admin',NULL,4),(3,'大理Ⅱ段进场道路3标施工监理','DZYS-DLⅡ-GCBF-JL-008',64.1487,'自合同签订之日起至缺陷责任期满止','2019-02-03 00:00:00','云南伟德工程监理有限公司','',0,9,'0','admin','2019-03-12 16:20:48',2),(4,'玉溪段进场道路施工1标','DZYS-YX-GCBF-SG-DL001',1177.761026,'180日历天','2019-02-15 00:00:00','云南昊滇建设工程集团有限公司','',0,9,'0','admin','2019-03-12 16:22:31',5),(5,'玉溪段进场道路施工2标','DZYS-YX-GCBF-SG-DL002',3182.822905,'300日历天','2019-02-15 00:00:00','云南恩途建设工程有限公司','',0,9,'0','admin','2019-03-12 16:52:18',5),(6,'玉溪段进场道路施工3标','DZYS-YX-GCBF-SG-DL003',7164.867295,'365日历天','2019-02-15 00:00:00','云南交通建设工程公司','',0,9,'0','admin','2019-03-12 16:53:00',5),(7,'红河段进场道路施工1标','DZYS-HH-GCBF-SG-DL001',6587.799056,'365日历天','2019-02-22 00:00:00','中铁十二局集团有限公司','',0,9,'0','admin','2019-03-12 16:53:49',6),(8,'云南省滇中引水工程施工准备工程昆明段进场道路施工1标','DZYS-KM-GCBF-SG-DL001',5267.02,'365日历天','2019-02-22 00:00:00','中铁二十四局集团南昌铁路工程有限公司','',0,9,'0','admin','2019-03-12 17:06:07',4),(9,'云南省滇中引水工程施工准备工程昆明段进场道路施工2标','DZYS-KM-GCBF-SG-DL002',4234.95,'365日历天','2019-02-22 00:00:00','中铁二十四局集团南昌铁路工程有限公司','',0,9,'0','admin','2019-03-12 17:07:01',4),(10,'滇中引水工程勘察试验性工程03标：香炉山隧洞2#施工支洞工程施工','DZYS-XL-SG-001',3913.25,'1365日历天','2015-09-09 00:00:00','.','',0,9,'0','admin','2019-03-18 12:23:34',1),(11,'滇中引水工程扩大勘察试验性工程水源及香炉山隧洞（丽江段）施工供电工程施工','DZYS-XL-YD-004',7486.66,'365日历天','2018-01-01 00:00:00','。','',0,9,'0','admin','2019-03-18 12:24:25',1);

/*Table structure for table `t_c_contractexecute` */

DROP TABLE IF EXISTS `t_c_contractexecute`;

CREATE TABLE `t_c_contractexecute` (
  `contractexecuteid` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `contractid` bigint(11) NOT NULL COMMENT '合同ID',
  `monthamount` double DEFAULT NULL COMMENT '当月结算',
  `year` int(4) DEFAULT NULL COMMENT '所属年份',
  `month` int(2) DEFAULT NULL COMMENT '所属月份',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `priority` int(11) DEFAULT '0' COMMENT '排序',
  `isdisabled` varchar(20) DEFAULT NULL,
  `operuser` varchar(20) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`contractexecuteid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `t_c_contractexecute` */

insert  into `t_c_contractexecute`(`contractexecuteid`,`contractid`,`monthamount`,`year`,`month`,`remark`,`priority`,`isdisabled`,`operuser`,`operdate`) values (1,1,376.18,2019,2,NULL,1,'0','admin','2019-03-13 17:11:22'),(2,1,234.98,2019,1,NULL,1,'0','admin','2019-03-13 17:16:10'),(3,2,121.52,2019,1,NULL,1,'0','admin','2019-03-13 17:16:49'),(4,2,458.31,2019,2,NULL,1,'0','admin','2019-03-13 17:19:52');

/*Table structure for table `t_f_financingrepair` */

DROP TABLE IF EXISTS `t_f_financingrepair`;

CREATE TABLE `t_f_financingrepair` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `year` int(4) DEFAULT NULL COMMENT '年份',
  `month` int(2) DEFAULT NULL COMMENT '月份',
  `ctype` varchar(2) DEFAULT NULL COMMENT '款项类型',
  `classes` varchar(2) DEFAULT NULL COMMENT '大类',
  `cmoney` double(19,6) DEFAULT NULL COMMENT '合同金额',
  `summoney` double(19,6) DEFAULT NULL COMMENT '累计金额',
  `tytmmoney` double(19,6) DEFAULT NULL COMMENT 'this year to month 本年至当月完成金额',
  `mmoney` double(19,6) DEFAULT NULL COMMENT '当月金额',
  `operdate` date DEFAULT NULL COMMENT '操作时间',
  `operuser` int(11) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_f_financingrepair` */

/*Table structure for table `t_f_financingwrite` */

DROP TABLE IF EXISTS `t_f_financingwrite`;

CREATE TABLE `t_f_financingwrite` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `payfordate` date DEFAULT NULL COMMENT '付款日期',
  `writeyear` int(4) DEFAULT NULL COMMENT '填报年',
  `writemonth` int(2) DEFAULT NULL COMMENT '填报月',
  `costtype` varchar(5) DEFAULT NULL COMMENT '费用类型',
  `maintype` varchar(2) DEFAULT NULL COMMENT '大类归类',
  `contractid` int(11) DEFAULT NULL COMMENT '所属合同',
  `subofficeid` int(11) DEFAULT NULL COMMENT '所属分局',
  `money` double(19,6) DEFAULT NULL COMMENT '金额',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  `operuser` int(11) DEFAULT NULL COMMENT '操作人',
  `cashierno` varchar(50) DEFAULT NULL COMMENT '出纳编号',
  `voucherno` varchar(50) DEFAULT NULL COMMENT '凭证编号',
  `isdisabled` varchar(1) DEFAULT '0' COMMENT '是否删除（1为删除,0为正常）',
  `payee` varchar(500) DEFAULT NULL COMMENT '收款方',
  `payeedescribe` longtext COMMENT '款项描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='财务填报';

/*Data for the table `t_f_financingwrite` */

insert  into `t_f_financingwrite`(`id`,`payfordate`,`writeyear`,`writemonth`,`costtype`,`maintype`,`contractid`,`subofficeid`,`money`,`operdate`,`operuser`,`cashierno`,`voucherno`,`isdisabled`,`payee`,`payeedescribe`) values (4,'2019-01-07',2019,1,'02','1',1,2,31122321.000000,'2019-03-20 10:42:55',NULL,'','','0','云南XXX公司','1'),(6,'2019-01-13',2019,1,'02','1',1,2,42211321.000000,'2019-03-20 10:42:55',NULL,'nnn','ccc','0','云南XXX公司','33'),(10,'2019-03-14',2019,3,'12','2',NULL,NULL,1111123.000000,'2019-03-14 17:30:51',NULL,'','','0','云南XXX公司','1'),(11,'2019-03-14',2019,3,'12','2',NULL,NULL,321.000000,'2019-03-14 17:30:51',NULL,'','','0','云南XXX公司','1'),(12,'2019-03-14',2019,3,'12','2',NULL,NULL,111.000000,'2019-03-14 17:23:53',NULL,'','','1','云南XXX公司','1'),(13,'2019-03-14',2019,3,'02','1',10,1,1230.000000,'2019-03-20 10:42:55',NULL,'','','0','云南XXX公司','4'),(14,'2019-03-06',2019,3,'01','1',3,2,0.000000,'2019-03-20 10:42:26',NULL,'22222','','0','云南2XX公司','2');

/*Table structure for table `t_f_maintenance` */

DROP TABLE IF EXISTS `t_f_maintenance`;

CREATE TABLE `t_f_maintenance` (
  `maintenanceid` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `priority` varchar(200) DEFAULT NULL COMMENT '序号',
  `entnyname` varchar(200) DEFAULT NULL COMMENT '项目名称',
  `grade` bigint(11) DEFAULT NULL COMMENT '分级',
  `perentid` bigint(11) DEFAULT NULL COMMENT '父ID',
  `index` bigint(11) DEFAULT NULL COMMENT '自己所在位置',
  `codeno` varchar(18) DEFAULT NULL COMMENT 'coed码',
  `unit` varchar(200) DEFAULT NULL COMMENT '单位',
  PRIMARY KEY (`maintenanceid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_f_maintenance` */

insert  into `t_f_maintenance`(`maintenanceid`,`priority`,`entnyname`,`grade`,`perentid`,`index`,`codeno`,`unit`) values (1,'1','大理分局',1,0,1,'001000000000000000','100cm'),(2,'1.1','大理1段',2,1,1,'001001000000000000',NULL),(3,'1.2.1','大理1段施工1标',3,2,1,'001002001000000000',NULL),(4,'2','丽江分局',1,0,2,'002000000000000000',NULL),(5,'2.1','丽江1段',2,4,1,'002001000000000000',NULL);

/*Table structure for table `t_month_schedule` */

DROP TABLE IF EXISTS `t_month_schedule`;

CREATE TABLE `t_month_schedule` (
  `mid` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `designquantity` varchar(50) NOT NULL COMMENT '设计工程量',
  `changequantity` varchar(50) NOT NULL COMMENT '变更工程量',
  `plannedvolume` int(50) DEFAULT NULL COMMENT '本月计划完成量',
  `accumulationcumulant` varchar(50) DEFAULT NULL COMMENT '本月累计完成量',
  `completionrate` varchar(50) DEFAULT NULL COMMENT '本月完成率',
  `accumulationcompletionrate` varchar(50) DEFAULT NULL COMMENT '积累完成率',
  `date` varchar(50) NOT NULL COMMENT '日期',
  `backups` varchar(100) DEFAULT NULL COMMENT '备注',
  `fid` varchar(50) NOT NULL,
  UNIQUE KEY `mid` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `t_month_schedule` */

insert  into `t_month_schedule`(`mid`,`unit`,`designquantity`,`changequantity`,`plannedvolume`,`accumulationcumulant`,`completionrate`,`accumulationcompletionrate`,`date`,`backups`,`fid`) values (1,NULL,'100','0',100,'0','0','0','2019-03',NULL,'1'),(2,NULL,'100','0',20,'8','8','8','2019-03',NULL,'2'),(3,NULL,'100','0',30,'7','7','7','2019-03',NULL,'3'),(4,NULL,'100','0',50,'5','5','5','2019-03',NULL,'4'),(5,NULL,'100','0',30,'2','2','2','2019-03',NULL,'5');

/*Table structure for table `t_p_monthtotal` */

DROP TABLE IF EXISTS `t_p_monthtotal`;

CREATE TABLE `t_p_monthtotal` (
  `id` int(11) NOT NULL COMMENT '主键',
  `depart` int(11) DEFAULT NULL COMMENT '所属分局',
  `year` int(4) DEFAULT NULL COMMENT '所属年份',
  `month` int(2) DEFAULT NULL COMMENT '所属月份',
  `contracttotal` double DEFAULT NULL COMMENT '合同总金额',
  `thisyearplan` double DEFAULT NULL COMMENT '本年计划完成投资',
  `thismonthinvest` double DEFAULT NULL COMMENT '当月完成投资',
  `thisytmtotal` double DEFAULT NULL COMMENT '本年至当月实际完成投资',
  `investtotal` double DEFAULT NULL COMMENT '开工以来累计完成投资',
  `balancetotal` double DEFAULT NULL COMMENT '累计结算工程款',
  `payfortotal` double DEFAULT NULL COMMENT '累计支付情况',
  `describe` varchar(2000) DEFAULT NULL COMMENT '工程形象进度描述',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注',
  `operuser` int(11) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_p_monthtotal` */

/*Table structure for table `t_s_code` */

DROP TABLE IF EXISTS `t_s_code`;

CREATE TABLE `t_s_code` (
  `codetype` varchar(50) DEFAULT NULL COMMENT '字典类型',
  `codedescribe` varchar(100) DEFAULT NULL COMMENT '字典描述备注',
  `key` varchar(5) DEFAULT NULL COMMENT '字典值',
  `value` varchar(200) DEFAULT NULL COMMENT '字典显示',
  `maintype` varchar(2) DEFAULT NULL COMMENT '大类归类',
  `maintypedescribe` varchar(50) DEFAULT NULL COMMENT '大类备注',
  `orderby` varchar(5) DEFAULT NULL COMMENT '排序列'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

/*Data for the table `t_s_code` */

insert  into `t_s_code`(`codetype`,`codedescribe`,`key`,`value`,`maintype`,`maintypedescribe`,`orderby`) values ('costtype','费用类型','01','工程款','1','合同款项','01'),('costtype','费用类型','02','监理费','1','合同款项','02'),('costtype','费用类型','03','施工供电费','1','合同款项','03'),('costtype','费用类型','04','勘察设计费','2','其他款项','04'),('costtype','费用类型','05','征地拆迁安置补偿','2','其他款项','05'),('costtype','费用类型','06','环境影响','2','其他款项','06'),('costtype','费用类型','07','耕地占用税','2','其他款项','07'),('costtype','费用类型','08','水土保持补偿费','2','其他款项','08'),('costtype','费用类型','09','金中公司清算费用','2','其他款项','09'),('costtype','费用类型','10','印花税','2','其他款项','10'),('costtype','费用类型','11','其他技术服务合同款','2','其他款项','11'),('costtype','费用类型','12','建设管理费','2','其他款项','12'),('costtype','费用类型','13','临时用地复垦保证金','2','其他款项','13'),('costtypesub','设计费用','01','主体工程设计费','1','设计费用','01'),('costtypesub','设计费用','02','二期工程设计费用','1','设计费用','02'),('costtypesub','设计费用','03','施工控制网设计及建网','1','设计费用','03'),('costtypesub','设计费用','04','其他咨询服务费用','1','设计费用','04'),('costtypejgf','建管费描述','01','六州市滇引办工作经费','1','建管费','01'),('costtypejgf','建管费描述','02','工程建设管理费','1','建管费','02'),('costtypejgf','建管费描述','03','建设管理调度中心建设费','1','建管费','03');

/*Table structure for table `t_s_daystatement` */

DROP TABLE IF EXISTS `t_s_daystatement`;

CREATE TABLE `t_s_daystatement` (
  `dayScheduid` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `monthscheduleid` int(10) NOT NULL COMMENT '工程月计划id',
  `todayaccomplish` int(20) DEFAULT NULL COMMENT '本日完成量',
  `day` int(2) NOT NULL COMMENT '日',
  `describe` varchar(2000) DEFAULT NULL COMMENT '施工形象描述',
  PRIMARY KEY (`dayScheduid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `t_s_daystatement` */

insert  into `t_s_daystatement`(`dayScheduid`,`monthscheduleid`,`todayaccomplish`,`day`,`describe`) values (1,1,2,1,'no'),(2,2,3,1,'透了'),(3,3,6,1,'没带'),(4,4,6,1,'男人嘛!!!'),(5,5,6,1,'我们是真爱'),(9,1,2,2,'hhhhhhhhhhhhh'),(10,2,2,2,'hhhhhhhhhhhhh'),(11,3,2,2,'hhhhhhhhhhh'),(12,4,2,2,'hhhhhhhhhhh'),(13,5,2,2,'hhhhhhhhhhhhhh'),(14,1,22,3,'hhh'),(15,2,22,3,'hhh'),(16,3,22,3,'hhh'),(17,4,22,3,'hhh'),(18,5,22,3,'hhh');

/*Table structure for table `t_s_dcdysqlid` */

DROP TABLE IF EXISTS `t_s_dcdysqlid`;

CREATE TABLE `t_s_dcdysqlid` (
  `dcdytype` varchar(30) NOT NULL COMMENT '导出打印类型',
  `sqlid` varchar(50) NOT NULL COMMENT '导出类型对应的sqlid',
  `sqltype` varchar(1) DEFAULT '' COMMENT '1为内容取值sql，2为表头填充取值',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导出打印对应的sqlid';

/*Data for the table `t_s_dcdysqlid` */

insert  into `t_s_dcdysqlid`(`dcdytype`,`sqlid`,`sqltype`,`comment`) values ('cwtbhzczlb','comle.financing.getfinancingListData','1','财务填报汇总操作列表'),('cwsjtj','comle.financing.getFinancingReportData','1','财务数据统计表列表');

/*Table structure for table `t_s_dcdysqlproperty` */

DROP TABLE IF EXISTS `t_s_dcdysqlproperty`;

CREATE TABLE `t_s_dcdysqlproperty` (
  `dcdytype` varchar(30) NOT NULL COMMENT '导出打印类型',
  `keyname` varchar(30) NOT NULL COMMENT '获取字段',
  `talign` varchar(10) NOT NULL COMMENT '对其方式',
  `formartstr` varchar(50) DEFAULT NULL COMMENT '格式化',
  `orderby` int(3) NOT NULL COMMENT '显示排序',
  `sepcial` varchar(5) DEFAULT NULL COMMENT '特殊处理保留字段',
  `protype` varchar(1) NOT NULL DEFAULT '' COMMENT '1为导出列表内容取值，2为表头内容对应属性',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导出打印对应sql的字段取值';

/*Data for the table `t_s_dcdysqlproperty` */

insert  into `t_s_dcdysqlproperty`(`dcdytype`,`keyname`,`talign`,`formartstr`,`orderby`,`sepcial`,`protype`,`comment`) values ('cwtbhzczlb','costTypeStr','left',NULL,1,NULL,'1','款项类型'),('cwtbhzczlb','mainTypeStr','center',NULL,2,NULL,'1','款项所属'),('cwtbhzczlb','year','center',NULL,3,NULL,'1','所属年份'),('cwtbhzczlb','total','right','vnd.ms-excel.numberformat:#,##0.00',4,NULL,'1','累计金额'),('cwsjtj','costTypeStr','left',NULL,2,NULL,'1','支付款项'),('cwsjtj','moneyyi','right','vnd.ms-excel.numberformat:#,##0.00',3,NULL,'1','金额1'),('cwsjtj','moneyer','right','vnd.ms-excel.numberformat:#,##0.00',4,NULL,'1','金额2'),('cwsjtj','moneysan','right','vnd.ms-excel.numberformat:#,##0.00',5,NULL,'1','金额3'),('cwsjtj','moneysi','right','vnd.ms-excel.numberformat:#,##0.00',6,NULL,'1','金额4'),('cwsjtj','moneys','right','vnd.ms-excel.numberformat:#,##0.00',7,NULL,'1','累计'),('cwsjtj','rnum','left',NULL,1,NULL,'1','序号');

/*Table structure for table `t_s_dcdytitles` */

DROP TABLE IF EXISTS `t_s_dcdytitles`;

CREATE TABLE `t_s_dcdytitles` (
  `dcdytype` varchar(30) NOT NULL COMMENT '导出打印类型',
  `tdid` varchar(30) DEFAULT NULL COMMENT '元素id',
  `showtitle` varchar(200) NOT NULL COMMENT '显示名称',
  `talign` varchar(10) DEFAULT NULL COMMENT 'title显示对其方式',
  `isdytype` varchar(1) NOT NULL DEFAULT '' COMMENT '是否为打印title，1为是',
  `isdctype` varchar(1) NOT NULL COMMENT '是否为导出title，1为是',
  `rowindex` int(2) NOT NULL COMMENT '行序号',
  `colindex` int(2) NOT NULL COMMENT '列序号',
  `mrowspan` int(2) NOT NULL COMMENT '跨行',
  `mcolspan` int(2) NOT NULL COMMENT '跨列',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='打印导出表头';

/*Data for the table `t_s_dcdytitles` */

insert  into `t_s_dcdytitles`(`dcdytype`,`tdid`,`showtitle`,`talign`,`isdytype`,`isdctype`,`rowindex`,`colindex`,`mrowspan`,`mcolspan`,`comment`) values ('cwtbhzczlb',NULL,'款项类型','center','1','1',2,1,1,1,NULL),('cwtbhzczlb',NULL,'款项所属','center','1','1',2,2,1,1,NULL),('cwtbhzczlb',NULL,'所属年份','center','1','1',2,3,1,1,NULL),('cwtbhzczlb',NULL,'累计金额','center','1','1',2,4,1,1,NULL),('cwtbhzczlb','filename','文件名称','center','1','1',1,1,1,4,NULL),('cwsjtj','filename','文件名称','center','1','1',1,1,1,7,NULL),('cwsjtj',NULL,'填报处室：计划财务处1','left','1','1',2,1,1,2,NULL),('cwsjtj',NULL,'填报截至日期','right','1','1',2,2,1,3,NULL),('cwsjtj','reportDaten','截至日期的值','left','1','1',2,3,1,2,NULL),('cwsjtj',NULL,'序号','center','1','1',3,1,2,1,NULL),('cwsjtj',NULL,'支付款项','center','1','1',3,2,2,1,NULL),('cwsjtj',NULL,'支付金额','center','1','1',3,3,1,5,NULL),('cwsjtj','year1n','年份1','center','1','1',4,1,1,1,NULL),('cwsjtj','year2n','年份2','center','1','1',4,2,1,1,NULL),('cwsjtj','monthn','当月','center','1','1',4,3,1,1,NULL),('cwsjtj','year3n','当年至当月','center','1','1',4,4,1,1,NULL),('cwsjtj',NULL,'累计','center','1','1',4,5,1,1,NULL);

/*Table structure for table `t_s_suboffice` */

DROP TABLE IF EXISTS `t_s_suboffice`;

CREATE TABLE `t_s_suboffice` (
  `subofficeid` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `subofficename` varchar(20) DEFAULT NULL COMMENT '分局名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `priority` int(11) DEFAULT NULL COMMENT '排序',
  `isonlysubo` varchar(1) DEFAULT NULL COMMENT '仅为分局标记',
  `isdisabled` varchar(20) DEFAULT NULL,
  `operuser` varchar(20) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`subofficeid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_s_suboffice` */

insert  into `t_s_suboffice`(`subofficeid`,`subofficename`,`remark`,`priority`,`isonlysubo`,`isdisabled`,`operuser`,`operdate`) values (1,'丽江分局',NULL,1,'1','0','1',NULL),(2,'大理分局',NULL,2,'1','0','1',NULL),(3,'楚雄分局',NULL,3,'1','0','1',NULL),(4,'昆明分局',NULL,4,'1','0','1',NULL),(5,'玉溪分局',NULL,5,'1','0','1',NULL),(6,'红河分局',NULL,6,'1','0','1',NULL),(7,'财务处',NULL,7,'0','0','1',NULL);

/*Table structure for table `t_s_subofficewrite` */

DROP TABLE IF EXISTS `t_s_subofficewrite`;

CREATE TABLE `t_s_subofficewrite` (
  `subofficewriteid` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `contractid` bigint(11) NOT NULL COMMENT '合同ID',
  `subofficeid` bigint(11) NOT NULL COMMENT '分局ID',
  `constructioncontent` longtext COMMENT '主要建设内容',
  `begindate` datetime DEFAULT NULL COMMENT '开工时间',
  `planfinishdate` datetime DEFAULT NULL COMMENT '计划完工时间',
  `budgetinvest` double DEFAULT NULL COMMENT '概算投资',
  `finishinvest` double DEFAULT NULL COMMENT '自开工以来累计完成投资',
  `surplusinvest` double DEFAULT NULL COMMENT '剩余投资',
  `yearplaninvest` double DEFAULT NULL COMMENT '本年度计划完成投资',
  `monthplaninvest` double DEFAULT NULL COMMENT '本月计划完成投资',
  `yearrealityinvest` double DEFAULT NULL COMMENT '本年度实际完成投资',
  `monthrealityinvest` double DEFAULT NULL COMMENT '本月实际完成投资',
  `tendayrealityinvest` double DEFAULT NULL COMMENT '本旬实际完成投资',
  `earthwork` double DEFAULT NULL COMMENT '土方',
  `stonework` double DEFAULT NULL COMMENT '石方',
  `beton` double DEFAULT NULL COMMENT '混凝土',
  `overallimageprogress` longtext COMMENT '总体形象进度',
  `nextmonthplaninvest` double DEFAULT NULL COMMENT '下一月度计划完成投资',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `year` int(4) DEFAULT NULL COMMENT '所属年份',
  `month` int(2) DEFAULT NULL COMMENT '所属月份',
  `priority` int(11) DEFAULT '0' COMMENT '排序',
  `status` int(10) DEFAULT NULL COMMENT '状态',
  `type` int(10) DEFAULT NULL COMMENT '状态 1旬报 2月报 ',
  `tendaytype` int(10) DEFAULT NULL COMMENT '旬状态 1上旬 2中旬 3下旬 ',
  `isdisabled` varchar(20) DEFAULT NULL,
  `operuser` varchar(20) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`subofficewriteid`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

/*Data for the table `t_s_subofficewrite` */

insert  into `t_s_subofficewrite`(`subofficewriteid`,`contractid`,`subofficeid`,`constructioncontent`,`begindate`,`planfinishdate`,`budgetinvest`,`finishinvest`,`surplusinvest`,`yearplaninvest`,`monthplaninvest`,`yearrealityinvest`,`monthrealityinvest`,`tendayrealityinvest`,`earthwork`,`stonework`,`beton`,`overallimageprogress`,`nextmonthplaninvest`,`remark`,`year`,`month`,`priority`,`status`,`type`,`tendaytype`,`isdisabled`,`operuser`,`operdate`) values (1,2,4,'龙泉倒虹吸始发井围护结构和主体结构施工，接收井围护结构和主体结构施工','2017-11-30 00:00:00','2020-06-30 00:00:00',9787,7367.76,1926.18,1662.61,115.08,152.08,36.76,10.35,2.11,0.48,1.33,'龙泉倒虹吸始发井本旬进行基坑开挖及钢支撑安装施工，始发井基坑开挖共计19155.5m³，本旬完成610m³，累计完成9776m³，占比51%，剩余9379.5m³，分三区开挖，西侧第一区（1号井）已开挖至基底，深度17.5m，中部第二区（2号井西侧）已开挖至第三道砼支撑，深度13m，东侧第三区（2号井东侧）已开挖至第二道钢支撑，深度8m。第二道钢支撑本旬完成1榀直撑安装，已累计完成2榀角撑、2榀斜撑及7榀直撑安装，第三道钢支撑本旬完成2榀直撑安装，已累计完成2榀角撑、2榀斜撑、5榀直撑安装。\r\n龙泉倒虹吸接收井本旬进行降水井施工及冠梁基础面清理施工，降水井共计632m，本旬完成155m，累计完成365m，完成率57.7%，剩余267m。',183.06,'',2019,2,0,3,2,NULL,'0','admin','2019-03-14 15:17:12'),(2,8,4,'路基土石方开挖、防护工程、路基路面等','2018-08-20 00:00:00','2019-12-31 00:00:00',6085.51,3731.64,1535.38,2348.47,420.28,813.09,265.21,105.07,8.31,46.02,0.5,'进场道路总长11.419公里，累计完成毛路开挖9.695公里，占84.90%，其中路基开挖完成8.289公里，占72.58%。',654.58,'',2019,2,0,4,2,NULL,'0','15','2019-03-19 16:31:53'),(3,9,4,'路基土石方开挖、防护工程、路基路面等','2019-01-07 00:00:00','2019-12-31 00:00:00',7250,873.41,3361.54,160,3584.95,223.41,23.41,0.41,2.16,8.64,2.9,'进场道路完成松林1#支洞和龙庆1#支洞进场道路复测放线，龙庆1#支洞毛路开挖完成1.5公里，土方开挖完成2.16万方，石方开挖完成8.64万方。',180,'',2019,2,0,1,2,NULL,'0','15','2019-03-19 16:31:53'),(4,3,2,'55','2019-02-24 00:00:00','2019-03-02 00:00:00',43,33,33,23,333,33,33,NULL,3,3,3,'333334',3,'',2019,3,0,1,2,2,'0','1','2019-04-03 16:09:44'),(23,2,4,'施工内容','2019-03-19 00:00:00','2019-03-19 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(24,9,4,'施工ssss','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,3,0,1,2,NULL,'1','15','2019-03-19 16:31:53'),(25,1,2,'33333','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(26,9,4,'2标施工','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,2,0,1,2,NULL,'0','15','2019-03-19 16:31:53'),(27,3,2,'施工监理','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(28,10,1,'丽江建设','2018-02-01 00:00:00','1970-01-01 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(29,8,4,'建设内容上旬','2019-01-01 00:00:00','2020-08-13 00:00:00',0,35.32,0,0,0,35.32,12.98,12.98,0,0,0,'',0,'',2019,3,0,1,1,1,'0','1','2019-04-09 09:15:52'),(30,8,4,'建设内容中旬','2019-01-01 00:00:00','2020-08-13 00:00:00',0,0,0,0,0,0,0,22.34,0,0,0,'',0,'',2019,3,0,1,1,2,'0','1','2019-04-09 09:54:18'),(43,1,2,'dd','2019-04-04 00:00:00','2019-04-06 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,4,0,1,1,1,'0','1','2019-04-16 14:45:44'),(44,6,5,'嘿嘿嘿嘿，陈紫嫣陈紫嫣陈紫嫣陈紫嫣，你咋又被人拴住了','2019-04-03 00:00:00','2019-04-06 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,4,0,1,1,2,'0','1','2019-04-03 19:37:43'),(45,8,4,'','1970-01-01 00:00:00','1970-01-01 00:00:00',0,33.34,0,0,0,33.34,33.34,11,0,0,0,'',0,'',2019,3,0,1,1,3,'0','1','2019-04-09 09:54:18'),(46,7,6,'沙雕！！','2018-12-20 00:00:00','2018-12-31 00:00:00',0,12,0,0,0,12,12,12,0,0,0,'',0,'',2018,12,0,1,1,3,'0','1','2019-04-10 16:17:15');

/*Table structure for table `t_sys_menu` */

DROP TABLE IF EXISTS `t_sys_menu`;

CREATE TABLE `t_sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menuname` varchar(200) NOT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '访问地址',
  `ismenu` int(10) DEFAULT NULL COMMENT '是否菜单',
  `pid` int(10) DEFAULT NULL COMMENT '上级菜单ID',
  `createdate` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `priority` int(11) DEFAULT NULL COMMENT '排序',
  `status` int(10) DEFAULT NULL COMMENT '状态',
  `isdisabled` varchar(20) DEFAULT NULL COMMENT '是否禁用',
  `operuser` varchar(20) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_menu` */

insert  into `t_sys_menu`(`id`,`menuname`,`url`,`ismenu`,`pid`,`createdate`,`remark`,`priority`,`status`,`isdisabled`,`operuser`,`operdate`) values (1,'分局填报','',1,0,'2019-03-14 21:20:12',NULL,1,1,'0','1','2019-03-14 21:20:35'),(2,'月填报','subofficewrite/subofficewriteMonthList.web',0,1,'2019-03-14 21:21:18',NULL,3,1,'0','1','2019-03-14 21:21:28'),(3,'财务管理','',1,0,'2019-03-14 21:22:05',NULL,4,1,'0','1','2019-03-14 21:22:15'),(4,'合同管理',NULL,1,0,'2019-03-14 21:23:43',NULL,7,1,'0','1','2019-03-14 21:23:35'),(5,'合同签订','contract/contractSignedList.web',0,4,'2019-03-14 21:24:55',NULL,8,1,'0','1','2019-03-14 21:25:00'),(6,'合同执行','contract/contractExecuteList.web',0,4,'2019-03-14 21:42:11',NULL,9,1,'0','1','2019-03-14 21:42:08'),(10,'系统管理','',1,0,'2019-03-15 11:00:48','',14,1,'0','1','2019-03-15 11:00:48'),(11,'用户管理','user/userList.web',0,10,'2019-03-15 11:02:50','',15,1,'0','1','2019-03-15 11:02:50'),(12,'角色管理','role/roleList.web',0,10,'2019-03-15 11:03:14','',16,1,'0','1','2019-03-15 11:03:14'),(13,'菜单管理','menu/menuList.web',0,10,'2019-03-15 11:03:38','',17,1,'0','1','2019-03-15 11:03:38'),(14,'统计报表','',1,0,'2019-03-18 14:00:19','',10,1,'0','1','2019-03-18 14:00:19'),(15,'合同执行月统计','contract/contractExecuteMonthTotalList.web',0,14,'2019-03-18 14:01:03','',11,1,'0','1','2019-03-18 14:01:03'),(16,'财务数据统计','financing/financingReport.web',0,14,'2019-03-18 14:01:24','',12,1,'0','1','2019-03-18 14:01:24'),(17,'审批管理','',1,0,'2019-03-19 09:51:39','',18,1,'0','1','2019-03-19 09:51:39'),(18,'分局填报审批','subofficewrite/subofficewriteApproveList.web',0,17,'2019-03-19 09:52:00','',19,1,'0','1','2019-03-19 09:52:00'),(19,'财务填报审批','',0,17,'2019-03-19 09:52:18','',20,1,'0','1','2019-03-19 09:52:18'),(20,'旬填报','subofficewrite/subofficewriteTenDayList.web',0,1,'2019-03-20 10:09:08','',2,1,'0','1','2019-03-20 10:09:08'),(21,'工程投资完成汇总月统计','financing/financingReportTwo.web',0,14,'2019-03-20 14:59:22','',13,1,'0','1','2019-03-20 14:59:22'),(22,'财务填报','financing/financingList.web',0,3,'2019-03-20 14:59:58','',5,1,'0','1','2019-03-20 14:59:58'),(23,'工程投资完成汇总数据补录','financing/financingRepair.web',0,3,'2019-03-20 15:00:27','',6,1,'0','1','2019-03-20 15:00:27'),(28,'部门管理','suboffice/subofficeList.web',0,10,'2019-03-21 15:37:50','',17,1,'0','1','2019-03-21 15:37:50'),(29,'进度反馈','',1,0,'2019-04-12 09:52:22',NULL,21,1,'0','1','2019-04-12 09:52:22'),(30,'工程维护','project/maintainList.web',0,29,'2019-04-12 09:52:22',NULL,22,1,'0','1','2019-04-12 09:52:22'),(31,'工程月进度','project/monthscheduleList.web',0,29,'2019-04-12 09:52:22',NULL,23,1,'0','1','2019-04-12 09:52:22'),(32,'工程日进度','project/DayScheduLeist.web',0,29,'2019-04-12 09:52:22',NULL,24,1,'0','1','2019-04-12 09:52:22');

/*Table structure for table `t_sys_role` */

DROP TABLE IF EXISTS `t_sys_role`;

CREATE TABLE `t_sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(200) NOT NULL COMMENT '角色名称',
  `createdate` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `priority` int(11) DEFAULT NULL COMMENT '排序',
  `status` int(10) DEFAULT NULL COMMENT '状态',
  `isdisabled` varchar(20) DEFAULT NULL COMMENT '是否禁用',
  `operuser` varchar(20) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_role` */

insert  into `t_sys_role`(`id`,`rolename`,`createdate`,`remark`,`priority`,`status`,`isdisabled`,`operuser`,`operdate`) values (1,'超级管理员','2019-03-14 17:12:45',NULL,0,1,'0','1','2019-03-14 17:13:02'),(2,'分局用户','2019-03-14 17:17:20',NULL,0,1,'0','1','2019-03-14 17:17:34'),(10,'审批用户','2019-03-15 10:28:52','',0,1,'0','1','2019-03-15 10:28:52');

/*Table structure for table `t_sys_role_menu` */

DROP TABLE IF EXISTS `t_sys_role_menu`;

CREATE TABLE `t_sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) NOT NULL COMMENT '角色ID',
  `menuid` int(11) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_role_menu` */

insert  into `t_sys_role_menu`(`id`,`roleid`,`menuid`) values (93,10,17),(94,10,18),(95,10,19),(110,2,20),(111,2,1),(112,2,2),(163,1,1),(164,1,20),(165,1,2),(166,1,3),(167,1,22),(168,1,23),(169,1,4),(170,1,5),(171,1,6),(172,1,14),(173,1,15),(174,1,16),(175,1,21),(176,1,10),(177,1,11),(178,1,12),(179,1,13),(180,1,28),(181,1,17),(182,1,18),(183,1,19),(184,1,29),(185,1,30),(186,1,31),(187,1,32);

/*Table structure for table `t_sys_user` */

DROP TABLE IF EXISTS `t_sys_user`;

CREATE TABLE `t_sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subofficeid` int(11) DEFAULT NULL COMMENT '所属分局',
  `username` varchar(200) NOT NULL COMMENT '用户名',
  `realname` varchar(200) DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(200) NOT NULL COMMENT '密码',
  `sex` varchar(20) NOT NULL COMMENT '性别',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `createdate` datetime NOT NULL COMMENT '创建时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `priority` int(11) DEFAULT NULL COMMENT '排序',
  `status` int(10) DEFAULT NULL COMMENT '状态',
  `isdisabled` varchar(20) DEFAULT NULL COMMENT '是否禁用',
  `operuser` varchar(20) DEFAULT NULL COMMENT '操作人',
  `operdate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user` */

insert  into `t_sys_user`(`id`,`subofficeid`,`username`,`realname`,`password`,`sex`,`email`,`createdate`,`remark`,`priority`,`status`,`isdisabled`,`operuser`,`operdate`) values (1,NULL,'admin','管理员','1','F','admin@admin.com','2019-03-14 17:12:01',NULL,0,1,'0','admin','2019-03-14 17:12:21'),(10,2,'approve','审批用户','1','F','','2019-03-15 10:28:31','',0,1,'0','1','2019-03-15 10:28:31'),(11,7,'caiwu','财务用户','1','F','chenhao@node.com','2019-03-15 10:51:31','',0,1,'0','1','2019-03-15 10:51:31'),(12,1,'lijiang','丽江分局用户','1','M','','2019-03-18 12:10:09','',0,1,'0','1','2019-03-18 12:10:09'),(13,2,'dali','大理分局用户','1','M','','2019-03-18 12:10:26','',0,1,'0','1','2019-03-18 12:10:26'),(14,3,'chuxiong','楚雄分局用户','1','M','','2019-03-18 12:10:41','',0,1,'0','1','2019-03-18 12:10:41'),(15,4,'kunming','昆明分局用户','1','M','','2019-03-18 12:10:56','',0,1,'0','1','2019-03-18 12:10:56'),(16,5,'yuxi','玉溪分局用户','1','M','','2019-03-18 12:11:09','',0,1,'0','1','2019-03-18 12:11:09'),(17,6,'honghe','红河分局用户','1','M','','2019-03-18 12:11:42','',0,1,'0','1','2019-03-18 12:11:42');

/*Table structure for table `t_sys_user_role` */

DROP TABLE IF EXISTS `t_sys_user_role`;

CREATE TABLE `t_sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `roleid` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user_role` */

insert  into `t_sys_user_role`(`id`,`userid`,`roleid`) values (45,12,2),(47,13,2),(48,17,2),(49,16,2),(50,15,2),(51,14,2),(52,10,10),(53,11,1),(54,1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
