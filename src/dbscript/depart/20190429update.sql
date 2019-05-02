/*
SQLyog Ultimate v8.32 
MySQL - 5.5.49 : Database - echart
*********************************************************************
*/set global max_allowed_packet = 2*1024*1024*10;
/*执行上述语句后，重启mysql*/



-- ----------------------------
-- Table structure for `t_m_user_authority`
-- ----------------------------
alter table t_m_user_authority add depid int(11) default NULL;


-- ----------------------------
-- Records of t_m_user_authority
-- ----------------------------
alter table t_s_suboffice add pid int(11) default 0 not Null;

