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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_c_contractexecute` */

insert  into `t_c_contractexecute`(`contractexecuteid`,`contractid`,`monthamount`,`year`,`month`,`remark`,`priority`,`isdisabled`,`operuser`,`operdate`) values (1,1,376.18,2019,2,NULL,1,'0','admin','2019-03-13 17:11:22'),(2,1,234.98,2019,1,NULL,1,'0','admin','2019-03-13 17:16:10'),(3,2,121.52,2019,1,NULL,1,'0','admin','2019-03-13 17:16:49'),(4,2,458.31,2019,2,NULL,1,'0','admin','2019-03-13 17:19:52'),(5,7,87654,2019,6,'DSS',0,'0','admin','2019-05-07 10:28:08');

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
  `begindate` date DEFAULT NULL COMMENT '开工时间',
  `planfinishdate` date DEFAULT NULL COMMENT '计划完工时间',
  `workload` varchar(50) DEFAULT NULL COMMENT '设计工程总量',
  `changeworkload` varchar(50) DEFAULT NULL COMMENT '总变更工程量',
  `accumulatedcompletion` varchar(50) DEFAULT NULL COMMENT '总累计完成量',
  `accumulationcompletionrate` varchar(50) DEFAULT NULL COMMENT '总累计完成率',
  PRIMARY KEY (`maintenanceid`)
) ENGINE=InnoDB AUTO_INCREMENT=99697914 DEFAULT CHARSET=utf8;

/*Data for the table `t_f_maintenance` */

insert  into `t_f_maintenance`(`maintenanceid`,`priority`,`entnyname`,`grade`,`perentid`,`index`,`codeno`,`unit`,`begindate`,`planfinishdate`,`workload`,`changeworkload`,`accumulatedcompletion`,`accumulationcompletionrate`) values (1,'1','大理分局',1,0,1,'001000000000000000','',NULL,NULL,NULL,NULL,'0',NULL),(2,'1.1','大理1段',2,1,1,'001001000000000000',NULL,NULL,NULL,NULL,NULL,'0',NULL),(3,'1.2.1','大理1段施工1标',3,2,1,'001002001000000000',NULL,NULL,NULL,NULL,NULL,'0',NULL),(4,'2','丽江分局',1,0,2,'002000000000000000',NULL,NULL,NULL,NULL,NULL,'0',NULL),(5,'2.1','丽江1段',2,4,1,'002001000000000000',NULL,NULL,NULL,NULL,NULL,'0',NULL),(6,'2.1.1','大理1段施工1标',3,5,1,'002001001000000000',NULL,NULL,NULL,NULL,NULL,'0',NULL),(7,'2.1.1.1','香炉山1#支洞工作面',4,6,1,'002001001001000000',NULL,NULL,NULL,NULL,NULL,'0',NULL),(8,'2.1.1.1.1','上游主洞段洞挖及支护',5,7,1,'002001001001001000','m','2019-04-21','2019-04-30','1000','13.0','10','0.009871668311944718'),(9,'2.1.1.1.2','上游主洞段衬砌及灌浆',5,7,2,'002001001001002000','m','2019-04-21','2019-04-30','1000','12.0','10','0.009881422924901186'),(10,'3','玉溪分局',1,0,3,'003000000000000000','',NULL,NULL,NULL,NULL,'0',NULL),(11,'4','楚雄分局',1,0,4,'004000000000000000','',NULL,NULL,NULL,NULL,NULL,NULL),(12,'5','昆明分局',1,0,5,'005000000000000000','',NULL,NULL,NULL,NULL,NULL,NULL),(13,'6','红河分局',1,0,6,'006000000000000000','',NULL,NULL,NULL,NULL,NULL,NULL),(14,'5.1','昆明1段',2,12,1,'005001000000000000','',NULL,NULL,NULL,NULL,NULL,NULL),(15,'3.1','sd',2,10,1,'003001000000000000','',NULL,NULL,NULL,NULL,'0',NULL),(16,'3.1.1','hhh',3,15,1,'003001001000000000','',NULL,NULL,NULL,NULL,'0',NULL),(17,'3.1.1.1','aaa',4,16,1,'003001001001000000','',NULL,NULL,NULL,NULL,'0',NULL),(18,'3.1.1.1.1','qqq',5,17,1,'003001001001001000','m',NULL,NULL,NULL,NULL,'0',NULL),(19,'3.1.1.1.2','www',5,17,2,'003001001001002000','cm',NULL,NULL,NULL,NULL,'0',NULL),(20,'3.1.1.1.2.1','qwqw',6,19,1,'003001001001002001','km','2019-05-15','2019-05-30','1000.0',NULL,'0',NULL);

/*Table structure for table `t_m_user_authority` */

DROP TABLE IF EXISTS `t_m_user_authority`;

CREATE TABLE `t_m_user_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authority` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT '0为可修改1为可查看',
  `uid` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT '用户id',
  `mid` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT '工程id',
  `depid` int(11) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `t_m_user_authority` */

insert  into `t_m_user_authority`(`id`,`authority`,`uid`,`mid`,`depid`) values (17,'0','10','1',NULL),(19,'0','1','1',NULL),(20,'0','14','1',NULL),(21,'0','13','1',NULL),(22,'0','15','1',NULL),(24,'0','1','4',NULL),(25,'0','1','10',NULL);

/*Table structure for table `t_month_schedule` */

DROP TABLE IF EXISTS `t_month_schedule`;

CREATE TABLE `t_month_schedule` (
  `mid` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `changequantity` varchar(50) DEFAULT NULL COMMENT '变更工程量',
  `plannedvolume` varchar(50) DEFAULT NULL COMMENT '本月计划完成量',
  `accumulationcumulant` varchar(50) DEFAULT NULL COMMENT '本月累计完成量',
  `completionrate` varchar(50) DEFAULT NULL COMMENT '本月完成率',
  `date` varchar(10) NOT NULL COMMENT '日期',
  `backups` varchar(100) DEFAULT NULL COMMENT '备注',
  `fid` varchar(50) NOT NULL,
  UNIQUE KEY `mid` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

/*Data for the table `t_month_schedule` */

insert  into `t_month_schedule`(`mid`,`unit`,`changequantity`,`plannedvolume`,`accumulationcumulant`,`completionrate`,`date`,`backups`,`fid`) values (117,NULL,'','','0',NULL,'2019-05','','1'),(118,NULL,'','','0',NULL,'2019-05','','2'),(119,NULL,'','','0',NULL,'2019-05','','3'),(120,NULL,'','','0',NULL,'2019-05','','4'),(121,NULL,'','','0',NULL,'2019-05','','5'),(122,NULL,'','','0',NULL,'2019-05','','6'),(123,NULL,'','','0',NULL,'2019-05','','7'),(124,NULL,'','100','10','10','2019-05','呵呵','8'),(125,NULL,'','100','10','10','2019-05','','9'),(126,NULL,'','','0',NULL,'2019-05','','10'),(127,NULL,'','','0',NULL,'2019-05','','15'),(128,NULL,'','','0',NULL,'2019-05','','16'),(129,NULL,'','','0',NULL,'2019-05','','17'),(130,NULL,'','','0',NULL,'2019-05','','18'),(131,NULL,'','','0',NULL,'2019-05','','19'),(132,NULL,'','','0',NULL,'2019-05','','20'),(133,NULL,'','','','','2019-04','','1'),(134,NULL,'','','','','2019-04','','2'),(135,NULL,'','','','','2019-04','','3'),(136,NULL,'','','','','2019-04','','4'),(137,NULL,'','','','','2019-04','','5'),(138,NULL,'','','','','2019-04','','6'),(139,NULL,'','','','','2019-04','','7'),(140,NULL,'','','','','2019-04','呵呵','8'),(141,NULL,'','','','','2019-04','','9'),(142,NULL,'','','','','2019-04','','10'),(143,NULL,'','','','','2019-04','','15'),(144,NULL,'','','','','2019-04','','16'),(145,NULL,'','','','','2019-04','','17'),(146,NULL,'','','','','2019-04','','18'),(147,NULL,'','','','','2019-04','','19');

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
  `todayaccomplish` double DEFAULT NULL COMMENT '本日完成量',
  `day` int(2) NOT NULL COMMENT '日',
  `describe` varchar(2000) DEFAULT NULL COMMENT '施工形象描述',
  PRIMARY KEY (`dayScheduid`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

/*Data for the table `t_s_daystatement` */

insert  into `t_s_daystatement`(`dayScheduid`,`monthscheduleid`,`todayaccomplish`,`day`,`describe`) values (117,117,0,30,''),(118,118,0,30,''),(119,119,0,30,''),(120,120,0,30,''),(121,121,0,30,''),(122,122,0,30,''),(123,123,0,30,''),(124,124,10,30,'开始施工！'),(125,125,10,30,''),(126,126,0,30,''),(127,127,0,30,''),(128,128,0,30,''),(129,129,0,30,''),(130,130,0,30,''),(131,131,0,30,''),(132,132,0,30,'');

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
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`subofficeid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `t_s_suboffice` */

insert  into `t_s_suboffice`(`subofficeid`,`subofficename`,`remark`,`priority`,`isonlysubo`,`isdisabled`,`operuser`,`operdate`,`pid`) values (1,'丽江分局',NULL,1,'1','0','1',NULL,0),(2,'大理分局',NULL,2,'1','0','1',NULL,0),(3,'楚雄分局',NULL,3,'1','0','1',NULL,0),(4,'昆明分局',NULL,4,'1','0','1',NULL,0),(5,'玉溪分局',NULL,5,'1','0','1',NULL,0),(6,'红河分局',NULL,6,'1','0','1',NULL,0),(7,'财务处',NULL,7,'0','0','1',NULL,0),(8,'特别行动小组','',0,'0','1','1','2019-05-01 10:23:33',0),(9,'大理一段','',0,'0','0','1','2019-05-05 15:00:58',2),(10,'丽江一段','',0,'','','','2019-05-05 15:51:38',1),(11,'楚楚流香shei','',0,'','1','','2019-05-05 19:36:20',3),(12,'坤哥lb','',0,'','1','','2019-05-05 20:28:45',4),(13,'大理一段yimiao','',0,'','','','2019-05-06 09:51:35',9),(14,'大理一段一标','',0,'','','','2019-05-09 17:54:48',13),(15,'香炉山1#支洞工作面','',0,'','','','2019-05-09 17:57:16',14),(16,'上游主洞段洞挖及支护','',0,'','','','2019-05-09 18:08:35',15),(17,'上游主洞段衬砌及灌浆','',0,'','','','2019-05-09 18:12:27',15);

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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

/*Data for the table `t_s_subofficewrite` */

insert  into `t_s_subofficewrite`(`subofficewriteid`,`contractid`,`subofficeid`,`constructioncontent`,`begindate`,`planfinishdate`,`budgetinvest`,`finishinvest`,`surplusinvest`,`yearplaninvest`,`monthplaninvest`,`yearrealityinvest`,`monthrealityinvest`,`tendayrealityinvest`,`earthwork`,`stonework`,`beton`,`overallimageprogress`,`nextmonthplaninvest`,`remark`,`year`,`month`,`priority`,`status`,`type`,`tendaytype`,`isdisabled`,`operuser`,`operdate`) values (1,2,4,'龙泉倒虹吸始发井围护结构和主体结构施工，接收井围护结构和主体结构施工','2017-11-30 00:00:00','2020-06-30 00:00:00',9787,7367.76,1926.18,1662.61,115.08,152.08,36.76,10.35,2.11,0.48,1.33,'龙泉倒虹吸始发井本旬进行基坑开挖及钢支撑安装施工，始发井基坑开挖共计19155.5m³，本旬完成610m³，累计完成9776m³，占比51%，剩余9379.5m³，分三区开挖，西侧第一区（1号井）已开挖至基底，深度17.5m，中部第二区（2号井西侧）已开挖至第三道砼支撑，深度13m，东侧第三区（2号井东侧）已开挖至第二道钢支撑，深度8m。第二道钢支撑本旬完成1榀直撑安装，已累计完成2榀角撑、2榀斜撑及7榀直撑安装，第三道钢支撑本旬完成2榀直撑安装，已累计完成2榀角撑、2榀斜撑、5榀直撑安装。\r\n龙泉倒虹吸接收井本旬进行降水井施工及冠梁基础面清理施工，降水井共计632m，本旬完成155m，累计完成365m，完成率57.7%，剩余267m。',183.06,'',2019,2,0,3,2,NULL,'0','admin','2019-03-14 15:17:12'),(2,8,4,'路基土石方开挖、防护工程、路基路面等','2018-08-20 00:00:00','2019-12-31 00:00:00',6085.51,3731.64,1535.38,2348.47,420.28,813.09,265.21,NULL,8.31,46.02,0.5,'进场道路总长11.419公里，累计完成毛路开挖9.695公里，占84.90%，其中路基开挖完成8.289公里，占72.58%。',654.58,'',2019,2,0,4,2,NULL,'0','1','2019-05-07 10:23:02'),(3,9,4,'路基土石方开挖、防护工程、路基路面等','2019-01-07 00:00:00','2019-12-31 00:00:00',7250,873.41,3361.54,160,3584.95,223.41,23.41,NULL,2.16,8.64,2.9,'进场道路完成松林1#支洞和龙庆1#支洞进场道路复测放线，龙庆1#支洞毛路开挖完成1.5公里，土方开挖完成2.16万方，石方开挖完成8.64万方。',180,'',2019,2,0,1,2,NULL,'0','1','2019-05-07 10:23:02'),(4,3,2,'55','2019-02-24 00:00:00','2019-03-02 00:00:00',43,33,33,23,333,33,33,NULL,3,3,3,'333334',3,'',2019,3,0,1,2,2,'0','1','2019-04-03 16:09:44'),(23,2,4,'施工内容','2019-03-19 00:00:00','2019-03-19 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(24,9,4,'施工ssss','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,3,0,1,2,NULL,'1','15','2019-03-19 16:31:53'),(25,1,2,'33333','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(26,9,4,'2标施工','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,2,0,1,2,NULL,'0','1','2019-05-07 10:23:02'),(27,3,2,'施工监理','2017-11-30 00:00:00','2020-06-30 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(28,10,1,'丽江建设','2018-02-01 00:00:00','1970-01-01 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,3,0,1,2,1,'0','1','2019-04-03 16:09:44'),(29,8,4,'建设内容上旬','2019-01-01 00:00:00','2020-08-13 00:00:00',0,35.32,0,0,0,35.32,12.98,12.98,0,0,0,'',0,'',2019,3,0,1,1,1,'0','1','2019-05-07 10:22:02'),(30,8,4,'建设内容中旬','2019-01-01 00:00:00','2020-08-13 00:00:00',0,0,0,0,0,0,0,22.34,0,0,0,'',0,'',2019,3,0,1,1,2,'0','1','2019-04-09 09:54:18'),(43,1,2,'dd','2019-04-04 00:00:00','2019-04-06 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,4,0,1,1,1,'0','1','2019-05-06 17:24:44'),(44,6,5,'嘿嘿嘿嘿，陈紫嫣陈紫嫣陈紫嫣陈紫嫣，你咋又被人拴住了','2019-04-03 00:00:00','2019-04-06 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,4,0,1,1,2,'0','1','2019-04-03 19:37:43'),(45,8,4,'','1970-01-01 00:00:00','1970-01-01 00:00:00',0,33.34,0,0,0,33.34,33.34,11,0,0,0,'',0,'',2019,3,0,1,1,3,'0','1','2019-04-09 09:54:18'),(46,7,6,'沙雕！！','2018-12-20 00:00:00','2018-12-31 00:00:00',0,12,0,0,0,12,12,12,0,0,0,'',0,'',2018,12,0,1,1,3,'0','1','2019-04-10 16:17:15'),(47,10,1,'','1970-01-01 00:00:00','1970-01-01 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,4,0,1,1,1,'1','1','2019-05-06 17:24:44'),(48,0,2,'','1970-01-01 00:00:00','1970-01-01 00:00:00',0,0,0,0,0,0,0,0,0,0,0,'',0,'',2019,3,0,1,1,1,'0','1','2019-05-07 10:22:02'),(49,0,1,'','1970-01-01 00:00:00','1970-01-01 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,2,0,1,2,NULL,'0','1','2019-05-07 10:23:02'),(50,11,1,'GFDS','2019-05-07 00:00:00','2019-05-21 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,5,0,2,2,NULL,'0','1','2019-05-07 10:24:58'),(51,10,1,'','2019-05-01 00:00:00','2019-05-04 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,5,0,2,2,NULL,'0','1','2019-05-07 10:30:51'),(52,0,1,'','1970-01-01 00:00:00','1970-01-01 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,5,0,2,2,NULL,'0','1','2019-05-08 14:42:39'),(53,0,1,'','2019-05-11 00:00:00','2019-05-16 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,5,0,2,2,NULL,'0','1','2019-05-08 14:43:21'),(54,11,1,'','2019-04-30 00:00:00','2019-05-24 00:00:00',0,0,0,0,0,0,0,NULL,0,0,0,'',0,'',2019,5,0,2,2,NULL,'0','1','2019-05-08 14:43:35'),(55,11,1,'uuuuu','2019-04-28 00:00:00','2019-04-29 00:00:00',1e17,0,0,0,10000000,0,1000000,NULL,0,0,0,'',99999,'',2019,5,0,1,2,NULL,'0','1','2019-05-09 11:42:50');

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_menu` */

insert  into `t_sys_menu`(`id`,`menuname`,`url`,`ismenu`,`pid`,`createdate`,`remark`,`priority`,`status`,`isdisabled`,`operuser`,`operdate`) values (1,'分局填报','',1,0,'2019-03-14 21:20:12',NULL,1,1,'0','1','2019-03-14 21:20:35'),(2,'月填报','subofficewrite/subofficewriteMonthList.web',0,1,'2019-03-14 21:21:18',NULL,3,1,'0','1','2019-03-14 21:21:28'),(3,'财务管理','',1,0,'2019-03-14 21:22:05',NULL,4,1,'0','1','2019-03-14 21:22:15'),(4,'合同管理',NULL,1,0,'2019-03-14 21:23:43',NULL,7,1,'0','1','2019-03-14 21:23:35'),(5,'合同签订','contract/contractSignedList.web',0,4,'2019-03-14 21:24:55',NULL,8,1,'0','1','2019-03-14 21:25:00'),(6,'合同执行','contract/contractExecuteList.web',0,4,'2019-03-14 21:42:11',NULL,9,1,'0','1','2019-03-14 21:42:08'),(10,'系统管理','',1,0,'2019-03-15 11:00:48','',14,1,'0','1','2019-03-15 11:00:48'),(11,'用户管理','user/userList.web',0,10,'2019-03-15 11:02:50','',15,1,'0','1','2019-03-15 11:02:50'),(12,'角色管理','role/roleList.web',0,10,'2019-03-15 11:03:14','',16,1,'0','1','2019-03-15 11:03:14'),(13,'菜单管理','menu/menuList.web',0,10,'2019-03-15 11:03:38','',17,1,'0','1','2019-03-15 11:03:38'),(14,'统计报表','',1,0,'2019-03-18 14:00:19','',10,1,'0','1','2019-03-18 14:00:19'),(15,'合同执行月统计','contract/contractExecuteMonthTotalList.web',0,14,'2019-03-18 14:01:03','',11,1,'0','1','2019-03-18 14:01:03'),(16,'财务数据统计','financing/financingReport.web',0,14,'2019-03-18 14:01:24','',12,1,'0','1','2019-03-18 14:01:24'),(17,'审批管理','',1,0,'2019-03-19 09:51:39','',18,1,'0','1','2019-03-19 09:51:39'),(18,'分局填报审批','subofficewrite/subofficewriteApproveList.web',0,17,'2019-03-19 09:52:00','',19,1,'0','1','2019-03-19 09:52:00'),(19,'财务填报审批','',0,17,'2019-03-19 09:52:18','',20,1,'1','1','2019-03-19 09:52:18'),(20,'旬填报','subofficewrite/subofficewriteTenDayList.web',0,1,'2019-03-20 10:09:08','',2,1,'0','1','2019-03-20 10:09:08'),(21,'工程投资完成汇总月统计','financing/financingReportTwo.web',0,14,'2019-03-20 14:59:22','',13,1,'0','1','2019-03-20 14:59:22'),(22,'财务填报','financing/financingList.web',0,3,'2019-03-20 14:59:58','',5,1,'0','1','2019-03-20 14:59:58'),(23,'工程投资完成汇总数据补录','financing/financingRepair.web',0,3,'2019-03-20 15:00:27','',6,1,'0','1','2019-03-20 15:00:27'),(28,'部门管理','suboffice/subofficeList.web',0,10,'2019-03-21 15:37:50','',17,1,'0','1','2019-03-21 15:37:50'),(29,'进度反馈','',1,0,'2019-04-12 09:52:22',NULL,21,1,'0','1','2019-04-12 09:52:22'),(30,'工程总进度','project/maintenanceList.web',0,29,'2019-04-12 09:52:22',NULL,22,1,'0','1','2019-04-12 09:52:22'),(31,'工程月进度','project/monthscheduleList.web',0,29,'2019-04-12 09:52:22',NULL,23,1,'0','1','2019-04-12 09:52:22'),(32,'工程日进度','project/DayScheduLeist.web',0,29,'2019-04-12 09:52:22',NULL,24,1,'0','1','2019-04-12 09:52:22'),(33,'查看工作面','project/workingfaveList.web',0,29,'2019-04-19 14:30:38',NULL,25,1,'0','1','2019-04-19 14:30:38');

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
) ENGINE=InnoDB AUTO_INCREMENT=389 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_role_menu` */

insert  into `t_sys_role_menu`(`id`,`roleid`,`menuid`) values (93,10,17),(94,10,18),(95,10,19),(110,2,20),(111,2,1),(112,2,2),(364,1,1),(365,1,20),(366,1,2),(367,1,3),(368,1,22),(369,1,23),(370,1,4),(371,1,5),(372,1,6),(373,1,14),(374,1,15),(375,1,16),(376,1,21),(377,1,10),(378,1,11),(379,1,12),(380,1,13),(381,1,28),(382,1,17),(383,1,18),(384,1,29),(385,1,30),(386,1,31),(387,1,32),(388,1,33);

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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user_role` */

insert  into `t_sys_user_role`(`id`,`userid`,`roleid`) values (45,12,2),(47,13,2),(48,17,2),(49,16,2),(50,15,2),(51,14,2),(52,10,10),(76,1,1),(77,11,1),(78,12,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
