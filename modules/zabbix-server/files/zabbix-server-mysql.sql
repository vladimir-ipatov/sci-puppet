-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: zabbix
-- ------------------------------------------------------
-- Server version	5.5.31-0+wheezy1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acknowledges`
--

DROP TABLE IF EXISTS `acknowledges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acknowledges` (
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`acknowledgeid`),
  KEY `acknowledges_1` (`userid`),
  KEY `acknowledges_2` (`eventid`),
  KEY `acknowledges_3` (`clock`),
  CONSTRAINT `c_acknowledges_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_acknowledges_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledges`
--

LOCK TABLES `acknowledges` WRITE;
/*!40000 ALTER TABLE `acknowledges` DISABLE KEYS */;
/*!40000 ALTER TABLE `acknowledges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `actionid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `eventsource` int(11) NOT NULL DEFAULT '0',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `esc_period` int(11) NOT NULL DEFAULT '0',
  `def_shortdata` varchar(255) NOT NULL DEFAULT '',
  `def_longdata` text NOT NULL,
  `recovery_msg` int(11) NOT NULL DEFAULT '0',
  `r_shortdata` varchar(255) NOT NULL DEFAULT '',
  `r_longdata` text NOT NULL,
  PRIMARY KEY (`actionid`),
  KEY `actions_1` (`eventsource`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (2,'Auto discovery. Linux servers.',1,0,1,0,'','',0,'',''),(3,'Report problems to Zabbix administrators',0,0,0,3600,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}',1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}'),(4,'auto registration',2,0,0,0,'Auto registration: {HOST.HOST}','Host name: {HOST.HOST}\r\nHost IP: {HOST.IP}\r\nAgent port: {HOST.PORT}',0,'','');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `alertid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  `sendto` varchar(100) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `error` varchar(128) NOT NULL DEFAULT '',
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `alerttype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`alertid`),
  KEY `alerts_1` (`actionid`),
  KEY `alerts_2` (`clock`),
  KEY `alerts_3` (`eventid`),
  KEY `alerts_4` (`status`,`retries`),
  KEY `alerts_5` (`mediatypeid`),
  KEY `alerts_6` (`userid`),
  CONSTRAINT `c_alerts_4` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `applicationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `applications_2` (`hostid`,`name`),
  KEY `applications_1` (`templateid`),
  CONSTRAINT `c_applications_2` FOREIGN KEY (`templateid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_applications_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (1,10001,'OS',NULL),(5,10001,'Filesystems',NULL),(7,10001,'Network interfaces',NULL),(9,10001,'Processes',NULL),(13,10001,'CPU',NULL),(15,10001,'Memory',NULL),(17,10001,'Performance',NULL),(21,10001,'General',NULL),(23,10001,'Security',NULL),(179,10047,'Zabbix server',NULL),(206,10050,'Zabbix agent',NULL),(207,10001,'Zabbix agent',206),(214,10056,'Services',NULL),(227,10060,'Interfaces',NULL),(228,10065,'General',NULL),(229,10066,'General',228),(230,10066,'Interfaces',227),(231,10067,'General',228),(232,10067,'Interfaces',227),(234,10068,'Disk partitions',NULL),(235,10067,'Disk partitions',234),(236,10069,'Disk partitions',234),(237,10069,'General',228),(238,10069,'Interfaces',227),(240,10070,'Processors',NULL),(241,10069,'Processors',240),(242,10067,'Processors',240),(245,10071,'Voltage',NULL),(246,10071,'Temperature',NULL),(247,10071,'Fans',NULL),(248,10072,'Voltage',NULL),(249,10072,'Temperature',NULL),(250,10072,'Fans',NULL),(251,10073,'MySQL',NULL),(252,10074,'Zabbix agent',206),(253,10074,'CPU',NULL),(254,10074,'Filesystems',NULL),(255,10074,'General',NULL),(256,10074,'Memory',NULL),(257,10074,'Network interfaces',NULL),(258,10074,'OS',NULL),(259,10074,'Performance',NULL),(260,10074,'Processes',NULL),(261,10074,'Security',NULL),(262,10075,'Zabbix agent',206),(263,10075,'CPU',NULL),(264,10075,'Filesystems',NULL),(265,10075,'General',NULL),(266,10075,'Memory',NULL),(267,10075,'Network interfaces',NULL),(268,10075,'OS',NULL),(269,10075,'Performance',NULL),(270,10075,'Processes',NULL),(271,10075,'Security',NULL),(272,10076,'Zabbix agent',206),(273,10076,'CPU',NULL),(274,10076,'Filesystems',NULL),(275,10076,'General',NULL),(276,10076,'Memory',NULL),(277,10076,'Network interfaces',NULL),(278,10076,'OS',NULL),(279,10076,'Performance',NULL),(280,10076,'Processes',NULL),(281,10076,'Security',NULL),(282,10077,'Zabbix agent',206),(283,10077,'CPU',NULL),(284,10077,'Filesystems',NULL),(285,10077,'General',NULL),(286,10077,'Memory',NULL),(287,10077,'Network interfaces',NULL),(288,10077,'OS',NULL),(289,10077,'Performance',NULL),(290,10077,'Processes',NULL),(291,10077,'Security',NULL),(292,10078,'Zabbix agent',206),(293,10078,'CPU',NULL),(294,10078,'Filesystems',NULL),(295,10078,'General',NULL),(296,10078,'Memory',NULL),(297,10078,'Network interfaces',NULL),(298,10078,'OS',NULL),(299,10078,'Performance',NULL),(300,10078,'Processes',NULL),(301,10078,'Security',NULL),(302,10079,'Zabbix agent',206),(303,10079,'CPU',NULL),(304,10079,'Filesystems',NULL),(305,10079,'General',NULL),(306,10079,'Memory',NULL),(307,10079,'Network interfaces',NULL),(308,10079,'OS',NULL),(309,10079,'Performance',NULL),(310,10079,'Processes',NULL),(311,10079,'Security',NULL),(319,10081,'General',NULL),(320,10081,'Performance',NULL),(322,10081,'Filesystems',NULL),(323,10081,'OS',NULL),(324,10081,'Processes',NULL),(325,10081,'CPU',NULL),(328,10081,'Memory',NULL),(329,10081,'Zabbix agent',206),(330,10081,'Network interfaces',NULL),(331,10076,'Logical partitions',NULL),(332,10082,'Classes',NULL),(333,10082,'Compilation',NULL),(334,10082,'Garbage Collector',NULL),(335,10082,'Memory',NULL),(336,10082,'Memory Pool',NULL),(337,10082,'Operating System',NULL),(338,10082,'Runtime',NULL),(339,10082,'Threads',NULL),(340,10083,'http-8080',NULL),(341,10083,'http-8443',NULL),(342,10083,'jk-8009',NULL),(343,10083,'Sessions',NULL),(344,10083,'Tomcat',NULL),(345,10084,'Zabbix server',179),(346,10084,'CPU',13),(347,10084,'Filesystems',5),(348,10084,'General',21),(349,10084,'Memory',15),(350,10084,'Network interfaces',7),(351,10084,'OS',1),(352,10084,'Performance',17),(353,10084,'Processes',9),(354,10084,'Security',23),(355,10084,'Zabbix agent',207),(356,10085,'Memory',NULL),(357,10085,'CPU',NULL),(358,10086,'CPU',357),(359,10086,'Memory',356),(360,10086,'IO',NULL),(361,10087,'CPU',357),(362,10087,'Memory',356),(363,10088,'Net_0',NULL),(364,10089,'Info_Host_Basic',NULL),(365,10090,'Agent_Check',NULL),(366,10091,'Apache Scoreboard',NULL),(367,10091,'Apache Counters',NULL),(368,10092,'Daemons',NULL),(369,10093,'Exim',NULL),(370,10094,'Filesystem',NULL),(371,10095,'Filesystem_Ext',NULL),(372,10096,'Filesystem',370),(373,10097,'Filesystem_Ext',371),(374,10098,'Filesystem',370),(375,10099,'Filesystem_Ext',371),(376,10100,'Agent_Check',365),(377,10100,'Filesystem',372),(378,10100,'Info_Host_Basic',364),(379,10100,'Net_0',363),(380,10100,'CPU',361),(381,10100,'Memory',362),(382,10101,'Info_Host',NULL),(383,10102,'Agent_Check',365),(384,10102,'Filesystem',372),(385,10102,'Info_Host_Basic',364),(386,10102,'Net_0',363),(387,10102,'CPU',358),(388,10102,'IO',360),(389,10102,'Memory',359),(390,10103,'Memory FreeBSD',NULL),(391,10104,'MSExchange',NULL),(392,10105,'MySQL',NULL),(393,10106,'Net_1',NULL),(394,10107,'Net_lo',NULL),(395,10108,'Disk_IO',NULL),(396,10109,'CPU',357),(397,10109,'Memory',356),(398,10110,'Ping',NULL),(399,10111,'Services_Inet',NULL),(400,10112,'Agent_Check',365),(401,10112,'Info_Host_Basic',364),(402,10112,'CPU',396),(403,10112,'Memory',397),(404,10112,'Filesystem',374),(405,10113,'Windows_Demo',NULL);
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `auditid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `details` varchar(128) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resourcename` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`auditid`),
  KEY `auditlog_1` (`userid`,`clock`),
  KEY `auditlog_2` (`clock`),
  CONSTRAINT `c_auditlog_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
INSERT INTO `auditlog` VALUES (1,1,1370851711,3,0,'0','10.0.2.2',1,''),(2,1,1370856817,0,13,'0','10.0.2.2',13517,'Processor load is too high on {HOSTNAME}'),(3,1,1370856817,0,13,'0','10.0.2.2',13518,'Too much data swapped out {HOSTNAME}'),(4,1,1370856818,0,13,'0','10.0.2.2',13519,'Processor load is too high on {HOSTNAME}'),(5,1,1370856818,0,13,'0','10.0.2.2',13520,'Too much data swapped out {HOSTNAME}'),(6,1,1370856818,0,13,'0','10.0.2.2',13521,'Wait on I/O is too high on {HOSTNAME}'),(7,1,1370856818,0,13,'0','10.0.2.2',13522,'Lack of free memory on server {HOSTNAME}'),(8,1,1370856818,0,13,'0','10.0.2.2',13523,'Swap activity is too high on {HOSTNAME}'),(9,1,1370856819,0,13,'0','10.0.2.2',13524,'Processor load is too high on {HOSTNAME}'),(10,1,1370856819,0,13,'0','10.0.2.2',13525,'Too much data swapped out {HOSTNAME}'),(11,1,1370856819,0,13,'0','10.0.2.2',13526,'{HOSTNAME} has just been restarted'),(12,1,1370856820,0,13,'0','10.0.2.2',13527,'Active agent on {HOSTNAME} not sending data'),(13,1,1370856820,0,13,'0','10.0.2.2',13528,'Agent version too old on {HOSTNAME}'),(14,1,1370856820,0,13,'0','10.0.2.2',13529,'Apache is not running on {HOSTNAME}'),(15,1,1370856820,0,13,'0','10.0.2.2',13530,'Inetd is not running on {HOSTNAME}'),(16,1,1370856820,0,13,'0','10.0.2.2',13531,'Mysql is not running on {HOSTNAME}'),(17,1,1370856820,0,13,'0','10.0.2.2',13532,'Sshd is not running on {HOSTNAME}'),(18,1,1370856821,0,13,'0','10.0.2.2',13533,'Syslogd is not running on {HOSTNAME}'),(19,1,1370856821,0,13,'0','10.0.2.2',13534,'Exim data collect error on {HOSTNAME}'),(20,1,1370856821,0,13,'0','10.0.2.2',13535,'Exim is not running on {HOSTNAME}'),(21,1,1370856821,0,13,'0','10.0.2.2',13536,'Volume {$VOL_0} near full'),(22,1,1370856822,0,13,'0','10.0.2.2',13537,'Volume {$VOL_1} near full'),(23,1,1370856822,0,13,'0','10.0.2.2',13538,'Volume {$VOL_2} near full'),(24,1,1370856822,0,13,'0','10.0.2.2',13539,'Volume {$VOL_3} near full'),(25,1,1370856822,0,13,'0','10.0.2.2',13540,'Volume {$VOL_4} near full'),(26,1,1370856822,0,13,'0','10.0.2.2',13541,'Volume {$VOL_0} near full'),(27,1,1370856822,0,13,'0','10.0.2.2',13542,'Volume {$VOL_0} inodes near full'),(28,1,1370856822,0,13,'0','10.0.2.2',13543,'Volume {$VOL_0} is readonly'),(29,1,1370856822,0,13,'0','10.0.2.2',13544,'Volume {$VOL_1} near full'),(30,1,1370856823,0,13,'0','10.0.2.2',13545,'Volume {$VOL_2} near full'),(31,1,1370856823,0,13,'0','10.0.2.2',13546,'Volume {$VOL_3} near full'),(32,1,1370856823,0,13,'0','10.0.2.2',13547,'Volume {$VOL_4} near full'),(33,1,1370856824,0,13,'0','10.0.2.2',13548,'Volume {$VOL_1} inodes near full'),(34,1,1370856824,0,13,'0','10.0.2.2',13549,'Volume {$VOL_2} inodes near full'),(35,1,1370856824,0,13,'0','10.0.2.2',13550,'Volume {$VOL_3} inodes near full'),(36,1,1370856824,0,13,'0','10.0.2.2',13551,'Volume {$VOL_4} inodes near full'),(37,1,1370856824,0,13,'0','10.0.2.2',13552,'Volume $1 is readonly'),(38,1,1370856824,0,13,'0','10.0.2.2',13553,'Volume $1 is readonly'),(39,1,1370856824,0,13,'0','10.0.2.2',13554,'Volume $1 is readonly'),(40,1,1370856824,0,13,'0','10.0.2.2',13555,'Volume $1 is readonly'),(41,1,1370856824,0,13,'0','10.0.2.2',13556,'Volume {$VOL_0} near full'),(42,1,1370856825,0,13,'0','10.0.2.2',13557,'Volume {$VOL_1} near full'),(43,1,1370856825,0,13,'0','10.0.2.2',13558,'Volume {$VOL_2} near full'),(44,1,1370856825,0,13,'0','10.0.2.2',13559,'Volume {$VOL_3} near full'),(45,1,1370856825,0,13,'0','10.0.2.2',13560,'Volume {$VOL_4} near full'),(46,1,1370856826,0,13,'0','10.0.2.2',13561,'Active agent on {HOSTNAME} not sending data'),(47,1,1370856826,0,13,'0','10.0.2.2',13562,'Agent version too old on {HOSTNAME}'),(48,1,1370856826,0,13,'0','10.0.2.2',13563,'Volume {$VOL_0} inodes near full'),(49,1,1370856826,0,13,'0','10.0.2.2',13564,'Volume {$VOL_0} near full'),(50,1,1370856826,0,13,'0','10.0.2.2',13565,'Volume {$VOL_0} is readonly'),(51,1,1370856826,0,13,'0','10.0.2.2',13566,'{HOSTNAME} has just been restarted'),(52,1,1370856826,0,13,'0','10.0.2.2',13567,'Processor load is too high on {HOSTNAME}'),(53,1,1370856826,0,13,'0','10.0.2.2',13568,'Too much data swapped out {HOSTNAME}'),(54,1,1370856828,0,13,'0','10.0.2.2',13569,'Active agent on {HOSTNAME} not sending data'),(55,1,1370856828,0,13,'0','10.0.2.2',13570,'Agent version too old on {HOSTNAME}'),(56,1,1370856828,0,13,'0','10.0.2.2',13571,'Volume {$VOL_0} inodes near full'),(57,1,1370856829,0,13,'0','10.0.2.2',13572,'Volume {$VOL_0} near full'),(58,1,1370856829,0,13,'0','10.0.2.2',13573,'Volume {$VOL_0} is readonly'),(59,1,1370856829,0,13,'0','10.0.2.2',13574,'{HOSTNAME} has just been restarted'),(60,1,1370856829,0,13,'0','10.0.2.2',13575,'Processor load is too high on {HOSTNAME}'),(61,1,1370856829,0,13,'0','10.0.2.2',13576,'Wait on I/O is too high on {HOSTNAME}'),(62,1,1370856829,0,13,'0','10.0.2.2',13577,'Too much data swapped out {HOSTNAME}'),(63,1,1370856829,0,13,'0','10.0.2.2',13578,'Lack of free memory on server {HOSTNAME}'),(64,1,1370856829,0,13,'0','10.0.2.2',13579,'Swap activity is too high on {HOSTNAME}'),(65,1,1370856831,0,13,'0','10.0.2.2',13580,'Lack of free memory on server {HOSTNAME}'),(66,1,1370856832,0,13,'0','10.0.2.2',13581,'EXNG: Service State - IMAP4'),(67,1,1370856832,0,13,'0','10.0.2.2',13582,'EXNG: Service State - Event'),(68,1,1370856832,0,13,'0','10.0.2.2',13583,'EXNG: Service State - Information Store'),(69,1,1370856832,0,13,'0','10.0.2.2',13584,'EXNG: Service State - Management'),(70,1,1370856832,0,13,'0','10.0.2.2',13585,'EXNG: Service State - MTA Stacks'),(71,1,1370856832,0,13,'0','10.0.2.2',13586,'EXNG: Service State - System Attendant'),(72,1,1370856832,0,13,'0','10.0.2.2',13587,'EXNG: Service State - Site Replication Service'),(73,1,1370856832,0,13,'0','10.0.2.2',13588,'EXNG: Service State - Network News Transfer Protocol (NNTP)'),(74,1,1370856832,0,13,'0','10.0.2.2',13589,'EXNG: Service State - POP3'),(75,1,1370856832,0,13,'0','10.0.2.2',13590,'EXNG: Service State - Routing Engine'),(76,1,1370856832,0,13,'0','10.0.2.2',13591,'EXNG: Service State - Simple Mail Transfer Protocol (SMTP)'),(77,1,1370856833,0,13,'0','10.0.2.2',13592,'Processor load is too high on {HOSTNAME}'),(78,1,1370856833,0,13,'0','10.0.2.2',13593,'Too much data swapped out {HOSTNAME}'),(79,1,1370856833,0,13,'0','10.0.2.2',13594,'Lack of free memory on server {HOSTNAME}'),(80,1,1370856834,0,13,'0','10.0.2.2',13595,'{HOSTNAME} not responding to Ping'),(81,1,1370856834,0,13,'0','10.0.2.2',13596,'FTP server is down on {HOSTNAME}'),(82,1,1370856834,0,13,'0','10.0.2.2',13597,'WEB (HTTP) server is down on {HOSTNAME}'),(83,1,1370856834,0,13,'0','10.0.2.2',13598,'IMAP server is down on {HOSTNAME}'),(84,1,1370856834,0,13,'0','10.0.2.2',13599,'News (NNTP) server is down on {HOSTNAME}'),(85,1,1370856834,0,13,'0','10.0.2.2',13600,'POP3 server is down on {HOSTNAME}'),(86,1,1370856834,0,13,'0','10.0.2.2',13601,'Email (SMTP) server is down on {HOSTNAME}'),(87,1,1370856834,0,13,'0','10.0.2.2',13602,'SSH server is down on {HOSTNAME}'),(88,1,1370856834,0,13,'0','10.0.2.2',13603,'Active agent on {HOSTNAME} not sending data'),(89,1,1370856834,0,13,'0','10.0.2.2',13604,'Agent version too old on {HOSTNAME}'),(90,1,1370856835,0,13,'0','10.0.2.2',13605,'{HOSTNAME} has just been restarted'),(91,1,1370856835,0,13,'0','10.0.2.2',13606,'Processor load is too high on {HOSTNAME}'),(92,1,1370856835,0,13,'0','10.0.2.2',13607,'Too much data swapped out {HOSTNAME}'),(93,1,1370856835,0,13,'0','10.0.2.2',13608,'Lack of free memory on server {HOSTNAME}'),(94,1,1370856835,0,13,'0','10.0.2.2',13609,'Volume {$VOL_0} near full'),(95,1,1370856837,0,13,'0','10.0.2.2',13610,'Apache is not running on {HOSTNAME}'),(96,1,1370856837,0,13,'0','10.0.2.2',13611,'c:\\autoexec.bat has been changed on server {HOSTNAME}'),(97,1,1371306293,1,5,' Actions [3] enabled','10.0.2.2',0,''),(98,1,1371306849,0,14,'0','10.0.2.2',6,'autoreg'),(99,1,1371306967,0,5,'Name: auto registration','10.0.2.2',0,'');
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog_details`
--

DROP TABLE IF EXISTS `auditlog_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog_details` (
  `auditdetailid` bigint(20) unsigned NOT NULL,
  `auditid` bigint(20) unsigned NOT NULL,
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `field_name` varchar(64) NOT NULL DEFAULT '',
  `oldvalue` text NOT NULL,
  `newvalue` text NOT NULL,
  PRIMARY KEY (`auditdetailid`),
  KEY `auditlog_details_1` (`auditid`),
  CONSTRAINT `c_auditlog_details_1` FOREIGN KEY (`auditid`) REFERENCES `auditlog` (`auditid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog_details`
--

LOCK TABLES `auditlog_details` WRITE;
/*!40000 ALTER TABLE `auditlog_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoreg_host`
--

DROP TABLE IF EXISTS `autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoreg_host` (
  `autoreg_hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`autoreg_hostid`),
  KEY `autoreg_host_1` (`proxy_hostid`,`host`),
  CONSTRAINT `c_autoreg_host_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoreg_host`
--

LOCK TABLES `autoreg_host` WRITE;
/*!40000 ALTER TABLE `autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `conditionid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`conditionid`),
  KEY `conditions_1` (`actionid`),
  CONSTRAINT `c_conditions_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
INSERT INTO `conditions` VALUES (2,2,10,0,'0'),(3,2,8,0,'9'),(4,2,12,2,'Linux'),(5,3,16,7,''),(6,3,5,0,'1');
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `configid` bigint(20) unsigned NOT NULL,
  `alert_history` int(11) NOT NULL DEFAULT '0',
  `event_history` int(11) NOT NULL DEFAULT '0',
  `refresh_unsupported` int(11) NOT NULL DEFAULT '0',
  `work_period` varchar(100) NOT NULL DEFAULT '1-5,00:00-24:00',
  `alert_usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `event_ack_enable` int(11) NOT NULL DEFAULT '1',
  `event_expire` int(11) NOT NULL DEFAULT '7',
  `event_show_max` int(11) NOT NULL DEFAULT '100',
  `default_theme` varchar(128) NOT NULL DEFAULT 'originalblue',
  `authentication_type` int(11) NOT NULL DEFAULT '0',
  `ldap_host` varchar(255) NOT NULL DEFAULT '',
  `ldap_port` int(11) NOT NULL DEFAULT '389',
  `ldap_base_dn` varchar(255) NOT NULL DEFAULT '',
  `ldap_bind_dn` varchar(255) NOT NULL DEFAULT '',
  `ldap_bind_password` varchar(128) NOT NULL DEFAULT '',
  `ldap_search_attribute` varchar(128) NOT NULL DEFAULT '',
  `dropdown_first_entry` int(11) NOT NULL DEFAULT '1',
  `dropdown_first_remember` int(11) NOT NULL DEFAULT '1',
  `discovery_groupid` bigint(20) unsigned NOT NULL,
  `max_in_table` int(11) NOT NULL DEFAULT '50',
  `search_limit` int(11) NOT NULL DEFAULT '1000',
  `severity_color_0` varchar(6) NOT NULL DEFAULT 'DBDBDB',
  `severity_color_1` varchar(6) NOT NULL DEFAULT 'D6F6FF',
  `severity_color_2` varchar(6) NOT NULL DEFAULT 'FFF6A5',
  `severity_color_3` varchar(6) NOT NULL DEFAULT 'FFB689',
  `severity_color_4` varchar(6) NOT NULL DEFAULT 'FF9999',
  `severity_color_5` varchar(6) NOT NULL DEFAULT 'FF3838',
  `severity_name_0` varchar(32) NOT NULL DEFAULT 'Not classified',
  `severity_name_1` varchar(32) NOT NULL DEFAULT 'Information',
  `severity_name_2` varchar(32) NOT NULL DEFAULT 'Warning',
  `severity_name_3` varchar(32) NOT NULL DEFAULT 'Average',
  `severity_name_4` varchar(32) NOT NULL DEFAULT 'High',
  `severity_name_5` varchar(32) NOT NULL DEFAULT 'Disaster',
  `ok_period` int(11) NOT NULL DEFAULT '1800',
  `blink_period` int(11) NOT NULL DEFAULT '1800',
  `problem_unack_color` varchar(6) NOT NULL DEFAULT 'DC0000',
  `problem_ack_color` varchar(6) NOT NULL DEFAULT 'DC0000',
  `ok_unack_color` varchar(6) NOT NULL DEFAULT '00AA00',
  `ok_ack_color` varchar(6) NOT NULL DEFAULT '00AA00',
  `problem_unack_style` int(11) NOT NULL DEFAULT '1',
  `problem_ack_style` int(11) NOT NULL DEFAULT '1',
  `ok_unack_style` int(11) NOT NULL DEFAULT '1',
  `ok_ack_style` int(11) NOT NULL DEFAULT '1',
  `snmptrap_logging` int(11) NOT NULL DEFAULT '1',
  `server_check_interval` int(11) NOT NULL DEFAULT '10',
  PRIMARY KEY (`configid`),
  KEY `c_config_1` (`alert_usrgrpid`),
  KEY `c_config_2` (`discovery_groupid`),
  CONSTRAINT `c_config_2` FOREIGN KEY (`discovery_groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_config_1` FOREIGN KEY (`alert_usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,365,365,600,'1-5,09:00-18:00;',7,1,7,100,'originalblue',0,'',389,'','','','',1,1,5,50,1000,'DBDBDB','D6F6FF','FFF6A5','FFB689','FF9999','FF3838','Not classified','Information','Warning','Average','High','Disaster',1800,1800,'DC0000','DC0000','00AA00','00AA00',1,1,1,1,1,10);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dchecks`
--

DROP TABLE IF EXISTS `dchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dchecks` (
  `dcheckid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `snmp_community` varchar(255) NOT NULL DEFAULT '',
  `ports` varchar(255) NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `uniq` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dcheckid`),
  KEY `dchecks_1` (`druleid`),
  CONSTRAINT `c_dchecks_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dchecks`
--

LOCK TABLES `dchecks` WRITE;
/*!40000 ALTER TABLE `dchecks` DISABLE KEYS */;
INSERT INTO `dchecks` VALUES (2,2,9,'system.uname','','10050','',0,'','',0);
/*!40000 ALTER TABLE `dchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhosts`
--

DROP TABLE IF EXISTS `dhosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhosts` (
  `dhostid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dhostid`),
  KEY `dhosts_1` (`druleid`),
  CONSTRAINT `c_dhosts_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhosts`
--

LOCK TABLES `dhosts` WRITE;
/*!40000 ALTER TABLE `dhosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drules`
--

DROP TABLE IF EXISTS `drules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drules` (
  `druleid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `iprange` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '3600',
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`druleid`),
  KEY `c_drules_1` (`proxy_hostid`),
  CONSTRAINT `c_drules_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drules`
--

LOCK TABLES `drules` WRITE;
/*!40000 ALTER TABLE `drules` DISABLE KEYS */;
INSERT INTO `drules` VALUES (2,NULL,'Local network','192.168.1.1-255',3600,0,1);
/*!40000 ALTER TABLE `drules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dservices`
--

DROP TABLE IF EXISTS `dservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dservices` (
  `dserviceid` bigint(20) unsigned NOT NULL,
  `dhostid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) NOT NULL DEFAULT '',
  `dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`dserviceid`),
  UNIQUE KEY `dservices_1` (`dcheckid`,`type`,`key_`,`ip`,`port`),
  KEY `dservices_2` (`dhostid`),
  CONSTRAINT `c_dservices_2` FOREIGN KEY (`dcheckid`) REFERENCES `dchecks` (`dcheckid`) ON DELETE CASCADE,
  CONSTRAINT `c_dservices_1` FOREIGN KEY (`dhostid`) REFERENCES `dhosts` (`dhostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dservices`
--

LOCK TABLES `dservices` WRITE;
/*!40000 ALTER TABLE `dservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escalations`
--

DROP TABLE IF EXISTS `escalations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escalations` (
  `escalationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `eventid` bigint(20) unsigned DEFAULT NULL,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`escalationid`),
  KEY `escalations_1` (`actionid`,`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escalations`
--

LOCK TABLES `escalations` WRITE;
/*!40000 ALTER TABLE `escalations` DISABLE KEYS */;
/*!40000 ALTER TABLE `escalations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `value_changed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `events_1` (`object`,`objectid`,`eventid`),
  KEY `events_2` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,0,0,13517,1370856817,2,0,0,0),(2,0,0,13518,1370856817,2,0,0,0),(3,0,0,13519,1370856817,2,0,0,0),(4,0,0,13520,1370856818,2,0,0,0),(5,0,0,13521,1370856818,2,0,0,0),(6,0,0,13522,1370856818,2,0,0,0),(7,0,0,13523,1370856818,2,0,0,0),(8,0,0,13524,1370856819,2,0,0,0),(9,0,0,13525,1370856819,2,0,0,0),(10,0,0,13526,1370856819,2,0,0,0),(11,0,0,13527,1370856820,2,0,0,0),(12,0,0,13528,1370856820,2,0,0,0),(13,0,0,13529,1370856820,2,0,0,0),(14,0,0,13530,1370856820,2,0,0,0),(15,0,0,13531,1370856820,2,0,0,0),(16,0,0,13532,1370856820,2,0,0,0),(17,0,0,13533,1370856820,2,0,0,0),(18,0,0,13534,1370856821,2,0,0,0),(19,0,0,13535,1370856821,2,0,0,0),(20,0,0,13536,1370856821,2,0,0,0),(21,0,0,13537,1370856822,2,0,0,0),(22,0,0,13538,1370856822,2,0,0,0),(23,0,0,13539,1370856822,2,0,0,0),(24,0,0,13540,1370856822,2,0,0,0),(25,0,0,13541,1370856822,2,0,0,0),(26,0,0,13542,1370856822,2,0,0,0),(27,0,0,13543,1370856822,2,0,0,0),(28,0,0,13544,1370856822,2,0,0,0),(29,0,0,13545,1370856823,2,0,0,0),(30,0,0,13546,1370856823,2,0,0,0),(31,0,0,13547,1370856823,2,0,0,0),(32,0,0,13548,1370856823,2,0,0,0),(33,0,0,13549,1370856824,2,0,0,0),(34,0,0,13550,1370856824,2,0,0,0),(35,0,0,13551,1370856824,2,0,0,0),(36,0,0,13552,1370856824,2,0,0,0),(37,0,0,13553,1370856824,2,0,0,0),(38,0,0,13554,1370856824,2,0,0,0),(39,0,0,13555,1370856824,2,0,0,0),(40,0,0,13556,1370856824,2,0,0,0),(41,0,0,13557,1370856825,2,0,0,0),(42,0,0,13558,1370856825,2,0,0,0),(43,0,0,13559,1370856825,2,0,0,0),(44,0,0,13560,1370856825,2,0,0,0),(45,0,0,13561,1370856826,2,0,0,0),(46,0,0,13562,1370856826,2,0,0,0),(47,0,0,13563,1370856826,2,0,0,0),(48,0,0,13564,1370856826,2,0,0,0),(49,0,0,13565,1370856826,2,0,0,0),(50,0,0,13566,1370856826,2,0,0,0),(51,0,0,13567,1370856826,2,0,0,0),(52,0,0,13568,1370856826,2,0,0,0),(53,0,0,13569,1370856828,2,0,0,0),(54,0,0,13570,1370856828,2,0,0,0),(55,0,0,13571,1370856828,2,0,0,0),(56,0,0,13572,1370856828,2,0,0,0),(57,0,0,13573,1370856829,2,0,0,0),(58,0,0,13574,1370856829,2,0,0,0),(59,0,0,13575,1370856829,2,0,0,0),(60,0,0,13576,1370856829,2,0,0,0),(61,0,0,13577,1370856829,2,0,0,0),(62,0,0,13578,1370856829,2,0,0,0),(63,0,0,13579,1370856829,2,0,0,0),(64,0,0,13580,1370856831,2,0,0,0),(65,0,0,13581,1370856832,2,0,0,0),(66,0,0,13582,1370856832,2,0,0,0),(67,0,0,13583,1370856832,2,0,0,0),(68,0,0,13584,1370856832,2,0,0,0),(69,0,0,13585,1370856832,2,0,0,0),(70,0,0,13586,1370856832,2,0,0,0),(71,0,0,13587,1370856832,2,0,0,0),(72,0,0,13588,1370856832,2,0,0,0),(73,0,0,13589,1370856832,2,0,0,0),(74,0,0,13590,1370856832,2,0,0,0),(75,0,0,13591,1370856832,2,0,0,0),(76,0,0,13592,1370856833,2,0,0,0),(77,0,0,13593,1370856833,2,0,0,0),(78,0,0,13594,1370856833,2,0,0,0),(79,0,0,13595,1370856834,2,0,0,0),(80,0,0,13596,1370856834,2,0,0,0),(81,0,0,13597,1370856834,2,0,0,0),(82,0,0,13598,1370856834,2,0,0,0),(83,0,0,13599,1370856834,2,0,0,0),(84,0,0,13600,1370856834,2,0,0,0),(85,0,0,13601,1370856834,2,0,0,0),(86,0,0,13602,1370856834,2,0,0,0),(87,0,0,13603,1370856834,2,0,0,0),(88,0,0,13604,1370856834,2,0,0,0),(89,0,0,13605,1370856835,2,0,0,0),(90,0,0,13606,1370856835,2,0,0,0),(91,0,0,13607,1370856835,2,0,0,0),(92,0,0,13608,1370856835,2,0,0,0),(93,0,0,13609,1370856835,2,0,0,0),(94,0,0,13610,1370856837,2,0,0,0),(95,0,0,13611,1370856837,2,0,0,0);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressions`
--

DROP TABLE IF EXISTS `expressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expressions` (
  `expressionid` bigint(20) unsigned NOT NULL,
  `regexpid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) NOT NULL DEFAULT '',
  `expression_type` int(11) NOT NULL DEFAULT '0',
  `exp_delimiter` varchar(1) NOT NULL DEFAULT '',
  `case_sensitive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`expressionid`),
  KEY `expressions_1` (`regexpid`),
  CONSTRAINT `c_expressions_1` FOREIGN KEY (`regexpid`) REFERENCES `regexps` (`regexpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressions`
--

LOCK TABLES `expressions` WRITE;
/*!40000 ALTER TABLE `expressions` DISABLE KEYS */;
INSERT INTO `expressions` VALUES (1,1,'^(btrfs|ext2|ext3|ext4|jfs|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|ntfs|fat32)$',3,',',0),(2,2,'^lo$',4,',',1),(3,3,'^(Physical memory|Virtual memory|Memory buffers|Cached memory|Swap space)$',4,',',1),(4,2,'^Software Loopback Interface',4,',',1);
/*!40000 ALTER TABLE `expressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functions` (
  `functionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `function` varchar(12) NOT NULL DEFAULT '',
  `parameter` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`functionid`),
  KEY `functions_1` (`triggerid`),
  KEY `functions_2` (`itemid`,`function`,`parameter`),
  CONSTRAINT `c_functions_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_functions_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
INSERT INTO `functions` VALUES (10199,10019,10016,'diff','0'),(10204,10055,10041,'last','0'),(10207,10058,10044,'diff','0'),(10208,10057,10043,'diff','0'),(10233,10009,10190,'last','0'),(12144,22181,13000,'last','0'),(12333,22550,13134,'last','0'),(12334,22549,13135,'last','0'),(12335,22551,13136,'last','0'),(12336,22552,13137,'last','0'),(12345,22553,13138,'last','0'),(12549,22232,13025,'nodata','5m'),(12550,10020,10047,'nodata','5m'),(12553,10056,10042,'last','0'),(12555,10013,10011,'last','0'),(12580,17350,10012,'last','0'),(12583,10025,10021,'change','0'),(12586,10010,10010,'last','0'),(12589,17362,13243,'last','0'),(12592,22686,13266,'last','0'),(12598,22454,13272,'last','0'),(12605,22399,13091,'min','600'),(12607,22426,13094,'min','600'),(12609,22420,13092,'min','600'),(12611,22404,13095,'min','600'),(12613,22400,13096,'min','600'),(12615,22414,13093,'min','600'),(12617,22428,13090,'min','600'),(12619,22416,13089,'min','600'),(12621,22418,13088,'min','600'),(12623,22402,13087,'min','600'),(12627,22406,13085,'min','600'),(12629,22422,13084,'min','600'),(12631,22430,13083,'min','600'),(12635,22410,13082,'min','600'),(12637,22412,13081,'min','600'),(12639,22424,13080,'min','600'),(12641,22189,13015,'min','600'),(12645,22183,13073,'min','600'),(12647,22689,13275,'min','600'),(12649,22185,13019,'min','600'),(12651,22396,13017,'min','600'),(12653,22219,13023,'min','600'),(12655,22408,13086,'min','1800'),(12657,22554,13139,'last','0'),(12659,22696,13277,'last','0'),(12661,22691,13133,'last','0'),(12663,22694,13279,'last','0'),(12665,22692,13281,'last','0'),(12667,22548,13283,'last','0'),(12669,22698,13285,'last','0'),(12671,22704,13287,'diff','0'),(12672,22726,13288,'diff','0'),(12673,22741,13289,'diff','0'),(12675,22757,13291,'last','0'),(12676,22756,13291,'last','0'),(12677,22766,13292,'last','0'),(12678,22764,13292,'last','0'),(12679,22773,13293,'last','0'),(12680,22771,13293,'last','0'),(12681,22785,13294,'diff','0'),(12682,22808,13295,'last','0'),(12683,22808,13296,'last','0'),(12684,22809,13297,'last','0'),(12685,22809,13298,'last','0'),(12686,22810,13299,'last','0'),(12687,22810,13300,'last','0'),(12688,22811,13301,'last','0'),(12689,22811,13302,'last','0'),(12690,22800,13303,'last','0'),(12691,22800,13304,'last','0'),(12692,22801,13305,'last','0'),(12693,22812,13306,'last','0'),(12694,22801,13307,'last','0'),(12695,22812,13308,'last','0'),(12696,22802,13309,'last','0'),(12697,22813,13310,'last','0'),(12698,22802,13311,'last','0'),(12699,22813,13312,'last','0'),(12700,22814,13313,'last','0'),(12701,22803,13314,'last','0'),(12702,22814,13315,'last','0'),(12703,22803,13316,'last','0'),(12704,22804,13317,'last','0'),(12705,22804,13318,'last','0'),(12706,22815,13319,'last','0'),(12707,22815,13320,'last','0'),(12708,22816,13321,'last','0'),(12709,22805,13322,'last','0'),(12710,22817,13323,'last','0'),(12711,22817,13324,'last','0'),(12712,22818,13325,'last','0'),(12713,22818,13326,'last','0'),(12714,22819,13327,'last','0'),(12715,22833,13328,'nodata','5m'),(12717,22835,13330,'last','0'),(12718,22836,13331,'last','0'),(12719,22837,13332,'last','0'),(12720,22838,13333,'last','0'),(12721,22842,13334,'last','0'),(12723,22853,13336,'diff','0'),(12724,22856,13337,'last','0'),(12725,22858,13338,'diff','0'),(12726,22859,13339,'change','0'),(12727,22861,13340,'diff','0'),(12728,22862,13341,'last','0'),(12729,22869,13342,'last','0'),(12730,22872,13343,'last','0'),(12731,22873,13344,'nodata','5m'),(12733,22875,13346,'last','0'),(12734,22876,13347,'last','0'),(12735,22877,13348,'last','0'),(12736,22878,13349,'last','0'),(12737,22882,13350,'last','0'),(12739,22893,13352,'diff','0'),(12740,22896,13353,'last','0'),(12741,22898,13354,'diff','0'),(12742,22899,13355,'change','0'),(12743,22901,13356,'diff','0'),(12744,22902,13357,'last','0'),(12745,22909,13358,'last','0'),(12746,22912,13359,'last','0'),(12747,22913,13360,'nodata','5m'),(12751,22917,13364,'last','0'),(12752,22918,13365,'last','0'),(12753,22922,13366,'last','0'),(12755,22933,13368,'diff','0'),(12757,22938,13370,'diff','0'),(12758,22939,13371,'change','0'),(12759,22941,13372,'diff','0'),(12760,22942,13373,'last','0'),(12761,22949,13374,'last','0'),(12762,22952,13375,'last','0'),(12763,22953,13376,'nodata','5m'),(12769,22962,13382,'last','0'),(12771,22973,13384,'diff','0'),(12773,22978,13386,'diff','0'),(12775,22981,13388,'diff','0'),(12776,22982,13389,'last','0'),(12777,22989,13390,'last','0'),(12778,22992,13391,'last','0'),(12779,22993,13392,'nodata','5m'),(12782,22996,13395,'last','0'),(12783,22997,13396,'last','0'),(12784,22998,13397,'last','0'),(12785,23002,13398,'last','0'),(12786,23007,13399,'last','0'),(12787,23013,13400,'diff','0'),(12788,23016,13401,'last','0'),(12789,23018,13402,'diff','0'),(12790,23019,13403,'change','0'),(12791,23021,13404,'diff','0'),(12792,23022,13405,'last','0'),(12793,23029,13406,'last','0'),(12794,23032,13407,'last','0'),(12795,23033,13408,'nodata','5m'),(12797,23035,13410,'last','0'),(12798,23036,13411,'last','0'),(12801,23042,13414,'last','0'),(12803,23053,13416,'diff','0'),(12805,23058,13418,'diff','0'),(12806,23059,13419,'change','0'),(12807,23061,13420,'diff','0'),(12808,23062,13421,'last','0'),(12809,23069,13422,'last','0'),(12810,23072,13423,'last','0'),(12812,23149,13425,'diff','0'),(12815,23150,13428,'last','0'),(12817,23140,13430,'last','0'),(12818,23147,13431,'last','0'),(12820,23158,13433,'last','0'),(12822,23143,13435,'last','0'),(12824,23160,13437,'nodata','5m'),(12826,23165,13439,'last','0'),(12828,23115,13367,'last','0'),(12829,23171,13441,'min','600'),(12830,23226,13442,'last','0'),(12831,23227,13442,'last','0'),(12832,23235,13443,'last','0'),(12833,23236,13443,'last','0'),(12834,23243,13444,'last','0'),(12835,23244,13444,'last','0'),(12836,23193,13445,'last','0'),(12837,23192,13445,'last','0'),(12838,23196,13446,'last','0'),(12839,23195,13446,'last','0'),(12840,23199,13447,'last','0'),(12841,23198,13447,'last','0'),(12842,23202,13448,'last','0'),(12843,23201,13448,'last','0'),(12844,23205,13449,'last','0'),(12845,23204,13449,'last','0'),(12846,23208,13450,'last','0'),(12847,23207,13450,'last','0'),(12848,23211,13451,'last','0'),(12849,23210,13451,'last','0'),(12850,23214,13452,'last','0'),(12851,23213,13452,'last','0'),(12852,23183,13453,'last','0'),(12853,23177,13453,'last','0'),(12854,23179,13454,'last','0'),(12855,23181,13454,'last','0'),(12856,23186,13455,'last','0'),(12857,23187,13455,'last','0'),(12858,23222,13456,'str','off'),(12859,23231,13457,'str','off'),(12860,23191,13458,'last','0'),(12861,23192,13458,'last','0'),(12862,23194,13459,'last','0'),(12863,23195,13459,'last','0'),(12864,23197,13460,'last','0'),(12865,23198,13460,'last','0'),(12866,23200,13461,'last','0'),(12867,23201,13461,'last','0'),(12868,23203,13462,'last','0'),(12869,23204,13462,'last','0'),(12870,23206,13463,'last','0'),(12871,23207,13463,'last','0'),(12872,23209,13464,'last','0'),(12873,23210,13464,'last','0'),(12874,23188,13465,'nodata','60'),(12875,23212,13466,'str','Server'),(12876,23252,13467,'min','600'),(12877,23253,13468,'min','600'),(12878,23254,13469,'min','600'),(12879,23255,13470,'min','600'),(12880,23256,13471,'min','600'),(12881,23257,13472,'min','600'),(12882,23258,13473,'min','1800'),(12883,23259,13474,'min','600'),(12884,23260,13475,'min','600'),(12885,23261,13476,'min','600'),(12886,23262,13477,'min','600'),(12887,23263,13478,'min','600'),(12888,23264,13479,'min','600'),(12889,23265,13480,'min','600'),(12890,23266,13481,'min','600'),(12891,23267,13482,'min','600'),(12892,23268,13483,'min','600'),(12893,23269,13484,'min','600'),(12894,23270,13485,'min','600'),(12895,23271,13486,'min','600'),(12896,23273,13487,'min','600'),(12897,23274,13488,'min','600'),(12898,23275,13489,'min','600'),(12899,23276,13490,'min','600'),(12900,23287,13491,'nodata','5m'),(12902,23289,13493,'last','0'),(12903,23290,13494,'last','0'),(12904,23291,13495,'last','0'),(12905,23292,13496,'last','0'),(12906,23296,13497,'last','0'),(12907,23301,13498,'last','0'),(12908,23307,13499,'diff','0'),(12909,23310,13500,'last','0'),(12910,23312,13501,'diff','0'),(12911,23313,13502,'change','0'),(12912,23315,13503,'diff','0'),(12913,23316,13504,'last','0'),(12914,23282,13505,'last','0'),(12915,23284,13506,'last','0'),(12926,22231,13026,'diff','0'),(12927,10059,10045,'diff','0'),(12928,23288,13492,'diff','0'),(12929,22834,13329,'diff','0'),(12930,22874,13345,'diff','0'),(12931,22914,13361,'diff','0'),(12932,22954,13377,'diff','0'),(12933,22994,13393,'diff','0'),(12934,23034,13409,'diff','0'),(12935,23161,13438,'diff','0'),(12936,23318,13507,'diff','0'),(12937,23319,13508,'diff','0'),(12938,23327,13509,'diff','0'),(12939,23320,13510,'diff','0'),(12940,23321,13511,'diff','0'),(12941,23322,13512,'diff','0'),(12942,23323,13513,'diff','0'),(12943,23324,13514,'diff','0'),(12944,23325,13515,'diff','0'),(12945,23326,13516,'diff','0'),(12946,23330,13517,'sum','{$WARN_TIME}'),(12947,23331,13517,'last','0'),(12948,23333,13518,'last','0'),(12949,23335,13518,'last','0'),(12950,23337,13519,'sum','{$WARN_TIME}'),(12951,23339,13519,'last','0'),(12952,23341,13520,'last','0'),(12953,23343,13520,'last','0'),(12954,23348,13521,'min','{$WARN_TIME}'),(12955,23342,13522,'last','0'),(12956,23354,13522,'last','0'),(12957,23355,13522,'last','0'),(12958,23358,13523,'min','{$WARN_TIME}'),(12959,23359,13523,'min','{$CPUWARN_TIME}'),(12960,23361,13524,'sum','{$WARN_TIME}'),(12961,23363,13524,'last','0'),(12962,23365,13525,'last','0'),(12963,23367,13525,'last','0'),(12964,23376,13526,'last','0'),(12965,23377,13527,'nodata','{$ACTIVE_NODATA_MAX}'),(12966,23378,13528,'regexp','\"^1\\.8\\..*\"'),(12967,23396,13529,'last','0'),(12968,23397,13530,'last','0'),(12969,23398,13531,'last','0'),(12970,23399,13532,'last','0'),(12971,23400,13533,'last','0'),(12972,23401,13534,'str','OK'),(12973,23416,13535,'last','0'),(12974,23417,13536,'last','0'),(12975,23418,13536,'last','0'),(12976,23420,13537,'last','0'),(12977,23421,13537,'last','0'),(12978,23423,13538,'last','0'),(12979,23424,13538,'last','0'),(12980,23426,13539,'last','0'),(12981,23427,13539,'last','0'),(12982,23429,13540,'last','0'),(12983,23430,13540,'last','0'),(12984,23432,13541,'last','0'),(12985,23433,13541,'last','0'),(12986,23436,13542,'last','0'),(12987,23435,13542,'last','0'),(12988,23437,13543,'str','\"ro\"'),(12989,23438,13544,'last','0'),(12990,23439,13544,'last','0'),(12991,23441,13545,'last','0'),(12992,23442,13545,'last','0'),(12993,23444,13546,'last','0'),(12994,23445,13546,'last','0'),(12995,23447,13547,'last','0'),(12996,23448,13547,'last','0'),(12997,23451,13548,'last','0'),(12998,23450,13548,'last','0'),(12999,23453,13549,'last','0'),(13000,23452,13549,'last','0'),(13001,23455,13550,'last','0'),(13002,23454,13550,'last','0'),(13003,23457,13551,'last','0'),(13004,23456,13551,'last','0'),(13005,23458,13552,'str','\"ro\"'),(13006,23459,13553,'str','\"ro\"'),(13007,23460,13554,'str','\"ro\"'),(13008,23461,13555,'str','\"ro\"'),(13009,23462,13556,'last','0'),(13010,23463,13556,'last','0'),(13011,23465,13557,'last','0'),(13012,23466,13557,'last','0'),(13013,23468,13558,'last','0'),(13014,23469,13558,'last','0'),(13015,23471,13559,'last','0'),(13016,23472,13559,'last','0'),(13017,23474,13560,'last','0'),(13018,23475,13560,'last','0'),(13019,23477,13561,'nodata','{$ACTIVE_NODATA_MAX}'),(13020,23478,13562,'regexp','\"^1\\.8\\..*\"'),(13021,23480,13563,'last','0'),(13022,23479,13563,'last','0'),(13023,23481,13564,'last','0'),(13024,23482,13564,'last','0'),(13025,23484,13565,'str','\"ro\"'),(13026,23485,13566,'last','0'),(13027,23491,13567,'sum','{$WARN_TIME}'),(13028,23493,13567,'last','0'),(13029,23498,13568,'last','0'),(13030,23501,13568,'last','0'),(13031,23505,13569,'nodata','{$ACTIVE_NODATA_MAX}'),(13032,23506,13570,'regexp','\"^1\\.8\\..*\"'),(13033,23508,13571,'last','0'),(13034,23507,13571,'last','0'),(13035,23509,13572,'last','0'),(13036,23510,13572,'last','0'),(13037,23512,13573,'str','\"ro\"'),(13038,23513,13574,'last','0'),(13039,23519,13575,'sum','{$WARN_TIME}'),(13040,23521,13575,'last','0'),(13041,23524,13576,'min','{$WARN_TIME}'),(13042,23531,13577,'last','0'),(13043,23535,13577,'last','0'),(13044,23534,13578,'last','0'),(13045,23532,13578,'last','0'),(13046,23533,13578,'last','0'),(13047,23538,13579,'min','{$WARN_TIME}'),(13048,23539,13579,'min','{$CPUWARN_TIME}'),(13049,23542,13580,'last','0'),(13050,23543,13580,'last','0'),(13051,23541,13580,'last','0'),(13052,23552,13581,'last','0'),(13053,23553,13582,'last','0'),(13054,23554,13583,'last','0'),(13055,23555,13584,'last','0'),(13056,23556,13585,'last','0'),(13057,23557,13586,'last','0'),(13058,23558,13587,'last','0'),(13059,23559,13588,'last','0'),(13060,23560,13589,'last','0'),(13061,23561,13590,'last','0'),(13062,23562,13591,'last','0'),(13063,23581,13592,'sum','{$WARN_TIME}'),(13064,23583,13592,'last','0'),(13065,23585,13593,'last','0'),(13066,23587,13593,'last','0'),(13067,23586,13594,'last','0'),(13068,23590,13594,'last','0'),(13069,23591,13595,'sum','#3'),(13070,23592,13596,'last','0'),(13071,23593,13597,'last','0'),(13072,23594,13598,'last','0'),(13073,23595,13599,'last','0'),(13074,23596,13600,'last','0'),(13075,23597,13601,'last','0'),(13076,23598,13602,'last','0'),(13077,23599,13603,'nodata','{$ACTIVE_NODATA_MAX}'),(13078,23600,13604,'regexp','\"^1\\.8\\..*\"'),(13079,23601,13605,'last','0'),(13080,23604,13606,'sum','{$WARN_TIME}'),(13081,23606,13606,'last','0'),(13082,23608,13607,'last','0'),(13083,23612,13607,'last','0'),(13084,23611,13608,'last','0'),(13085,23610,13608,'last','0'),(13086,23613,13609,'last','0'),(13087,23614,13609,'last','0'),(13088,23616,13610,'last','0'),(13089,23618,13611,'diff','0');
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalmacro`
--

DROP TABLE IF EXISTS `globalmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalmacro` (
  `globalmacroid` bigint(20) unsigned NOT NULL,
  `macro` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`globalmacroid`),
  KEY `globalmacro_1` (`macro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalmacro`
--

LOCK TABLES `globalmacro` WRITE;
/*!40000 ALTER TABLE `globalmacro` DISABLE KEYS */;
INSERT INTO `globalmacro` VALUES (2,'{$SNMP_COMMUNITY}','public');
/*!40000 ALTER TABLE `globalmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalvars` (
  `globalvarid` bigint(20) unsigned NOT NULL,
  `snmp_lastsize` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`globalvarid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_discovery`
--

DROP TABLE IF EXISTS `graph_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_discovery` (
  `graphdiscoveryid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `parent_graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`graphdiscoveryid`),
  UNIQUE KEY `graph_discovery_1` (`graphid`,`parent_graphid`),
  KEY `c_graph_discovery_2` (`parent_graphid`),
  CONSTRAINT `c_graph_discovery_2` FOREIGN KEY (`parent_graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graph_discovery_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_discovery`
--

LOCK TABLES `graph_discovery` WRITE;
/*!40000 ALTER TABLE `graph_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_theme`
--

DROP TABLE IF EXISTS `graph_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_theme` (
  `graphthemeid` bigint(20) unsigned NOT NULL,
  `description` varchar(64) NOT NULL DEFAULT '',
  `theme` varchar(64) NOT NULL DEFAULT '',
  `backgroundcolor` varchar(6) NOT NULL DEFAULT 'F0F0F0',
  `graphcolor` varchar(6) NOT NULL DEFAULT 'FFFFFF',
  `graphbordercolor` varchar(6) NOT NULL DEFAULT '222222',
  `gridcolor` varchar(6) NOT NULL DEFAULT 'CCCCCC',
  `maingridcolor` varchar(6) NOT NULL DEFAULT 'AAAAAA',
  `gridbordercolor` varchar(6) NOT NULL DEFAULT '000000',
  `textcolor` varchar(6) NOT NULL DEFAULT '202020',
  `highlightcolor` varchar(6) NOT NULL DEFAULT 'AA4444',
  `leftpercentilecolor` varchar(6) NOT NULL DEFAULT '11CC11',
  `rightpercentilecolor` varchar(6) NOT NULL DEFAULT 'CC1111',
  `nonworktimecolor` varchar(6) NOT NULL DEFAULT 'CCCCCC',
  `gridview` int(11) NOT NULL DEFAULT '1',
  `legendview` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`graphthemeid`),
  KEY `graph_theme_1` (`description`),
  KEY `graph_theme_2` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_theme`
--

LOCK TABLES `graph_theme` WRITE;
/*!40000 ALTER TABLE `graph_theme` DISABLE KEYS */;
INSERT INTO `graph_theme` VALUES (1,'Original Blue','originalblue','F0F0F0','FFFFFF','333333','CCCCCC','AAAAAA','000000','222222','AA4444','11CC11','CC1111','E0E0E0',1,1),(2,'Black & Blue','darkblue','333333','0A0A0A','888888','222222','4F4F4F','EFEFEF','0088FF','CC4444','1111FF','FF1111','1F1F1F',1,1),(3,'Dark orange','darkorange','333333','0A0A0A','888888','222222','4F4F4F','EFEFEF','DFDFDF','FF5500','FF5500','FF1111','1F1F1F',1,1),(4,'Classic','classic','F0F0F0','FFFFFF','333333','CCCCCC','AAAAAA','000000','222222','AA4444','11CC11','CC1111','E0E0E0',1,1),(5,'Dark orange','darkorange','333333','0A0A0A','888888','222222','4F4F4F','EFEFEF','DFDFDF','FF5500','FF5500','FF1111','1F1F1F',1,1),(6,'Classic','classic','F0F0F0','FFFFFF','333333','CCCCCC','AAAAAA','000000','222222','AA4444','11CC11','CC1111','E0E0E0',1,1);
/*!40000 ALTER TABLE `graph_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs` (
  `graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '0',
  `height` int(11) NOT NULL DEFAULT '0',
  `yaxismin` double(16,4) NOT NULL DEFAULT '0.0000',
  `yaxismax` double(16,4) NOT NULL DEFAULT '0.0000',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `show_work_period` int(11) NOT NULL DEFAULT '1',
  `show_triggers` int(11) NOT NULL DEFAULT '1',
  `graphtype` int(11) NOT NULL DEFAULT '0',
  `show_legend` int(11) NOT NULL DEFAULT '1',
  `show_3d` int(11) NOT NULL DEFAULT '0',
  `percent_left` double(16,4) NOT NULL DEFAULT '0.0000',
  `percent_right` double(16,4) NOT NULL DEFAULT '0.0000',
  `ymin_type` int(11) NOT NULL DEFAULT '0',
  `ymax_type` int(11) NOT NULL DEFAULT '0',
  `ymin_itemid` bigint(20) unsigned DEFAULT NULL,
  `ymax_itemid` bigint(20) unsigned DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`graphid`),
  KEY `graphs_graphs_1` (`name`),
  KEY `c_graphs_1` (`templateid`),
  KEY `c_graphs_2` (`ymin_itemid`),
  KEY `c_graphs_3` (`ymax_itemid`),
  CONSTRAINT `c_graphs_3` FOREIGN KEY (`ymax_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_graphs_1` FOREIGN KEY (`templateid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_2` FOREIGN KEY (`ymin_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs`
--

LOCK TABLES `graphs` WRITE;
/*!40000 ALTER TABLE `graphs` DISABLE KEYS */;
INSERT INTO `graphs` VALUES (387,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(392,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(404,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(406,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(410,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(420,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(433,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(436,'Swap usage',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(439,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(442,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(445,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(446,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,445,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(447,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,445,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(449,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,445,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(450,'Fan speed and ambient temperature',900,200,15.0000,50.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(451,'Fan speed and temperature',900,200,15.0000,50.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(452,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(453,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(454,'MySQL operations',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(455,'MySQL bandwidth',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(456,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(457,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(458,'Swap usage',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(459,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(461,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(462,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(463,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(464,'Swap usage',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(465,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(467,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(469,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(471,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(472,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(473,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(474,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(475,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(478,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(479,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(480,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(481,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(482,'Swap usage',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(483,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(484,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(485,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(487,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(491,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(492,'Network traffic on em0',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(493,'Network traffic on vic0',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(494,'Network traffic on en0',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(495,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(496,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(497,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(498,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(499,'Class Loader',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(500,'File Descriptors',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(501,'Garbage Collector collections per second',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(502,'http-8080 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(503,'http-8443 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(504,'jk-8009 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(505,'Memory Pool CMS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(506,'Memory Pool CMS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(507,'Memory Pool Code Cache',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(508,'Memory Pool Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(509,'Memory Pool PS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(510,'Memory Pool PS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(511,'Memory Pool Tenured Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(512,'sessions /',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(513,'Tthreads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(514,'Disk space usage {#SNMPVALUE}',600,340,0.0000,0.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(515,'Disk space usage {#SNMPVALUE}',600,340,0.0000,0.0000,514,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(516,'Disk space usage {#SNMPVALUE}',600,340,0.0000,0.0000,514,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(517,'Zabbix internal process busy %',900,200,0.0000,100.0000,406,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(518,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,404,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(519,'Zabbix server performance',900,200,0.0000,100.0000,392,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(520,'Zabbix cache usage, % free',900,200,0.0000,100.0000,410,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(521,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,420,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(522,'Disk space usage {#FSNAME}',600,340,0.0000,0.0000,442,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(523,'CPU jumps',900,200,0.0000,100.0000,439,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(524,'CPU load',900,200,0.0000,100.0000,433,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(525,'CPU utilization',900,200,0.0000,100.0000,387,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(526,'Swap usage',600,340,0.0000,0.0000,436,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(527,'CPU Loads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(528,'CPU Loads',900,200,0.0000,100.0000,527,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(529,'CPU Utilization',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(530,'Memory',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(531,'System IO',900,200,0.0000,100.0000,NULL,0,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(532,'CPU Loads',900,200,0.0000,100.0000,527,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(533,'CPU Utilization',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(534,'Memory',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(535,'Network 0 utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(536,'Apache Thread Scoreboard',900,200,0.0000,100.0000,NULL,0,0,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(537,'Exim errors',900,200,0.0000,100.0000,NULL,0,0,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(538,'Exim delivery',900,200,0.0000,100.0000,NULL,0,0,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(539,'Exim queue',900,200,0.0000,100.0000,NULL,0,0,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(540,'Exim rejects',900,200,0.0000,100.0000,NULL,0,0,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(541,'Exim submit',900,200,0.0000,100.0000,NULL,0,0,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(542,'Volume {$VOL_0}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(543,'Volume {$VOL_1}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(544,'Volume {$VOL_2}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(545,'Volume {$VOL_3}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(546,'Volume {$VOL_4}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(547,'Volume {$VOL_0}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(548,'Volume {$VOL_1}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(549,'Volume {$VOL_2}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(550,'Volume {$VOL_3}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(551,'Volume {$VOL_4}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(552,'Volume {$VOL_0}',900,200,0.0000,100.0000,542,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(553,'Network 0 utilization',900,200,0.0000,100.0000,535,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(554,'CPU Loads',900,200,0.0000,100.0000,532,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(555,'CPU Utilization',900,200,0.0000,100.0000,533,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(556,'Memory',900,200,0.0000,100.0000,534,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(557,'Volume {$VOL_0}',900,200,0.0000,100.0000,542,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(558,'Network 0 utilization',900,200,0.0000,100.0000,535,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(559,'CPU Utilization',900,200,0.0000,100.0000,529,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(560,'CPU Loads',900,200,0.0000,100.0000,528,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(561,'Memory',900,200,0.0000,100.0000,530,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(562,'System IO',900,200,0.0000,100.0000,531,0,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(563,'Memory FreeBSD',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(564,'Network 1 utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(565,'File Throughput',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(566,'IOPS',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(567,'IO Throughput',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(568,'CPU Loads',900,200,0.0000,100.0000,527,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(569,'Memory',900,200,0.0000,100.0000,NULL,0,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(570,'CPU Loads',900,200,0.0000,100.0000,568,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(571,'Memory',900,200,0.0000,100.0000,569,0,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(572,'Volume {$VOL_0}',900,200,0.0000,100.0000,547,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0);
/*!40000 ALTER TABLE `graphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs_items`
--

DROP TABLE IF EXISTS `graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs_items` (
  `gitemid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '009600',
  `yaxisside` int(11) NOT NULL DEFAULT '1',
  `calc_fnc` int(11) NOT NULL DEFAULT '2',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gitemid`),
  KEY `graphs_items_1` (`itemid`),
  KEY `graphs_items_2` (`graphid`),
  CONSTRAINT `c_graphs_items_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_items_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs_items`
--

LOCK TABLES `graphs_items` WRITE;
/*!40000 ALTER TABLE `graphs_items` DISABLE KEYS */;
INSERT INTO `graphs_items` VALUES (1242,387,22665,1,1,'FF5555',0,2,0),(1243,387,22668,1,2,'55FF55',0,2,0),(1244,387,22671,1,3,'009999',0,2,0),(1245,387,17358,1,4,'990099',0,2,0),(1246,387,17362,1,5,'999900',0,2,0),(1247,387,17360,1,6,'990000',0,2,0),(1248,387,17356,1,7,'000099',0,2,0),(1249,387,17354,1,8,'009900',0,2,0),(1290,439,22680,0,1,'009900',0,2,0),(1291,439,22683,0,2,'000099',0,2,0),(1296,433,10010,0,0,'009900',0,2,0),(1297,433,22674,0,1,'000099',0,2,0),(1298,433,22677,0,2,'990000',0,2,0),(1323,436,10030,0,0,'AA0000',0,2,2),(1324,436,10014,0,1,'00AA00',0,2,0),(1353,420,22446,5,0,'00AA00',0,2,0),(1354,420,22448,5,1,'3333FF',0,2,0),(1411,406,22426,0,0,'00EE00',0,2,0),(1412,406,22428,0,1,'007777',0,2,0),(1413,406,22422,0,2,'0000EE',0,2,0),(1414,406,22408,0,3,'FFAA00',0,2,0),(1415,406,22424,0,4,'00EEEE',0,2,0),(1416,406,22412,0,5,'990099',0,2,0),(1417,406,22410,0,6,'666600',0,2,0),(1418,406,22406,0,7,'EE0000',0,2,0),(1419,406,22414,0,8,'FF66FF',0,2,0),(1429,410,22185,0,0,'009900',0,2,0),(1430,410,22189,0,1,'DD0000',0,2,0),(1431,410,22396,0,2,'00DDDD',0,2,0),(1432,410,22183,0,3,'3333FF',0,2,0),(1441,392,22187,5,0,'00C800',0,2,0),(1442,392,23251,5,1,'C80000',1,2,0),(1451,445,22701,5,0,'00AA00',0,2,0),(1452,445,22702,5,1,'3333FF',0,2,0),(1453,446,22725,5,0,'00AA00',0,2,0),(1454,446,22728,5,1,'3333FF',0,2,0),(1455,447,22740,5,0,'00AA00',0,2,0),(1456,447,22743,5,1,'3333FF',0,2,0),(1457,449,22784,5,0,'00AA00',0,2,0),(1458,449,22787,5,1,'3333FF',0,2,0),(1459,442,22456,0,0,'C80000',0,2,2),(1460,442,22452,0,1,'00C800',0,2,0),(1461,450,22804,5,0,'EE0000',0,2,0),(1462,450,22807,0,1,'000000',1,2,0),(1463,451,22808,2,1,'EE00EE',0,2,0),(1464,451,22815,2,0,'EE0000',0,2,0),(1465,451,22818,4,3,'000000',1,2,0),(1466,451,22817,0,2,'000000',1,2,0),(1467,452,22803,0,4,'3333FF',0,2,0),(1468,452,22800,0,1,'009900',0,2,0),(1469,452,22801,0,2,'00CCCC',0,2,0),(1470,452,22802,0,3,'000000',0,2,0),(1471,452,22805,2,0,'880000',0,2,0),(1472,452,22806,0,5,'777700',0,2,0),(1473,453,22809,0,1,'009900',0,2,0),(1474,453,22816,2,0,'880000',0,2,0),(1475,453,22813,0,3,'000000',0,2,0),(1476,453,22814,0,4,'3333FF',0,2,0),(1477,453,22812,0,2,'00CCCC',0,2,0),(1478,454,22827,0,0,'C8C800',0,2,0),(1479,454,22826,0,1,'006400',0,2,0),(1480,454,22828,0,2,'C80000',0,2,0),(1481,454,22822,0,3,'0000EE',0,2,0),(1482,454,22825,0,4,'640000',0,2,0),(1483,454,22823,0,5,'00C800',0,2,0),(1484,454,22824,0,6,'C800C8',0,2,0),(1487,455,22830,5,0,'00AA00',0,2,0),(1488,455,22829,5,1,'3333FF',0,2,0),(1491,456,22846,1,3,'009999',0,2,0),(1492,456,22848,1,4,'990099',0,2,0),(1494,456,22851,1,6,'990000',0,2,0),(1495,456,22852,1,7,'000099',0,2,0),(1496,456,22845,1,8,'009900',0,2,0),(1497,457,22842,0,0,'009900',0,2,0),(1498,457,22843,0,1,'000099',0,2,0),(1499,457,22841,0,2,'990000',0,2,0),(1500,458,22857,0,0,'AA0000',0,2,2),(1501,458,22855,0,1,'00AA00',0,2,0),(1502,459,22844,0,1,'009900',0,2,0),(1503,459,22840,0,2,'000099',0,2,0),(1506,461,22870,0,0,'C80000',0,2,2),(1507,461,22868,0,1,'00C800',0,2,0),(1510,462,22886,1,3,'009999',0,2,0),(1511,462,22888,1,4,'990099',0,2,0),(1513,462,22891,1,6,'990000',0,2,0),(1514,462,22892,1,7,'000099',0,2,0),(1515,462,22885,1,8,'009900',0,2,0),(1516,463,22882,0,0,'009900',0,2,0),(1517,463,22883,0,1,'000099',0,2,0),(1518,463,22881,0,2,'990000',0,2,0),(1519,464,22897,0,0,'AA0000',0,2,2),(1520,464,22895,0,1,'00AA00',0,2,0),(1521,465,22884,0,1,'009900',0,2,0),(1522,465,22880,0,2,'000099',0,2,0),(1525,467,22910,0,0,'C80000',0,2,2),(1526,467,22908,0,1,'00C800',0,2,0),(1535,469,22922,0,0,'009900',0,2,0),(1536,469,22923,0,1,'000099',0,2,0),(1537,469,22921,0,2,'990000',0,2,0),(1540,471,22924,0,1,'009900',0,2,0),(1541,471,22920,0,2,'000099',0,2,0),(1542,472,22945,5,0,'00AA00',0,2,0),(1543,472,22946,5,1,'3333FF',0,2,0),(1544,473,22950,0,0,'C80000',0,2,2),(1545,473,22948,0,1,'00C800',0,2,0),(1549,474,22968,1,4,'990099',0,2,0),(1551,474,22971,1,6,'990000',0,2,0),(1552,474,22972,1,7,'000099',0,2,0),(1553,474,22965,1,8,'009900',0,2,0),(1554,475,22962,0,0,'009900',0,2,0),(1555,475,22963,0,1,'000099',0,2,0),(1556,475,22961,0,2,'990000',0,2,0),(1561,478,22985,5,0,'00AA00',0,2,0),(1562,478,22986,5,1,'3333FF',0,2,0),(1563,479,22990,0,0,'C80000',0,2,2),(1564,479,22988,0,1,'00C800',0,2,0),(1569,480,23007,1,5,'999900',0,2,0),(1570,480,23011,1,6,'990000',0,2,0),(1571,480,23012,1,7,'000099',0,2,0),(1572,480,23005,1,8,'009900',0,2,0),(1573,481,23002,0,0,'009900',0,2,0),(1574,481,23003,0,1,'000099',0,2,0),(1575,481,23001,0,2,'990000',0,2,0),(1576,482,23017,0,0,'AA0000',0,2,2),(1577,482,23015,0,1,'00AA00',0,2,0),(1578,483,23004,0,1,'009900',0,2,0),(1579,483,23000,0,2,'000099',0,2,0),(1580,484,23025,5,0,'00AA00',0,2,0),(1581,484,23026,5,1,'3333FF',0,2,0),(1582,485,23030,0,0,'C80000',0,2,2),(1583,485,23028,0,1,'00C800',0,2,0),(1592,487,23042,0,0,'009900',0,2,0),(1593,487,23043,0,1,'000099',0,2,0),(1594,487,23041,0,2,'990000',0,2,0),(1601,491,23070,0,0,'C80000',0,2,2),(1602,491,23068,0,1,'00C800',0,2,0),(1603,492,23073,5,0,'00AA00',0,2,0),(1604,492,23074,5,1,'3333FF',0,2,0),(1607,493,23075,5,0,'00AA00',0,2,0),(1608,493,23076,5,1,'3333FF',0,2,0),(1611,494,23077,5,0,'00AA00',0,2,0),(1612,494,23078,5,1,'3333FF',0,2,0),(1613,495,23143,0,0,'009900',0,2,0),(1614,495,23145,0,1,'000099',0,2,0),(1615,495,23144,0,2,'990000',0,2,0),(1616,496,23167,0,0,'C80000',0,2,2),(1617,496,23164,0,1,'00C800',0,2,0),(1618,497,23169,5,0,'00AA00',0,2,0),(1619,497,23170,5,1,'3333FF',0,2,0),(1620,498,23109,0,0,'009999',0,2,0),(1621,498,23112,0,1,'990099',0,2,0),(1622,498,23115,0,2,'999900',0,2,0),(1623,498,23113,0,3,'990000',0,2,0),(1624,498,23114,0,4,'000099',0,2,0),(1625,498,23110,0,5,'009900',0,2,0),(1626,404,22404,0,0,'990099',0,2,0),(1627,404,22399,0,1,'990000',0,2,0),(1628,404,22416,0,2,'0000EE',0,2,0),(1629,404,22430,0,3,'FF33FF',0,2,0),(1630,404,22418,0,4,'00EE00',0,2,0),(1631,404,22402,0,5,'003300',0,2,0),(1632,404,22420,0,6,'CCCC00',0,2,0),(1633,404,22400,0,7,'33FFFF',0,2,0),(1634,404,22689,0,8,'DD0000',0,2,0),(1635,404,23171,0,9,'000099',0,7,0),(1636,499,23174,0,0,'C80000',0,2,0),(1637,499,23175,0,1,'00C800',0,2,0),(1638,499,23173,0,2,'0000C8',0,2,0),(1639,500,23213,0,0,'C80000',0,2,0),(1640,500,23214,0,1,'00C800',0,2,0),(1641,501,23186,0,0,'C80000',0,2,0),(1642,501,23177,0,1,'00C800',0,2,0),(1643,501,23179,0,2,'0000C8',0,2,0),(1644,501,23181,0,3,'C8C800',0,2,0),(1645,501,23187,0,4,'00C8C9',0,2,0),(1646,501,23183,0,5,'C800C8',0,2,0),(1647,502,23227,0,0,'C80000',0,2,0),(1648,502,23226,0,1,'00C800',0,2,0),(1649,502,23225,0,2,'0000C8',0,2,0),(1650,503,23236,0,0,'C80000',0,2,0),(1651,503,23235,0,1,'00C800',0,2,0),(1652,503,23234,0,2,'0000C8',0,2,0),(1653,504,23244,0,0,'C80000',0,2,0),(1654,504,23243,0,1,'00C800',0,2,0),(1655,504,23242,0,2,'0000C8',0,2,0),(1656,505,23191,0,0,'C80000',0,2,0),(1657,505,23192,0,1,'00C800',0,2,0),(1658,505,23193,0,2,'0000C8',0,2,0),(1659,506,23194,0,0,'C80000',0,2,0),(1660,506,23195,0,1,'00C800',0,2,0),(1661,506,23196,0,2,'0000C8',0,2,0),(1662,507,23197,0,0,'C80000',0,2,0),(1663,507,23198,0,1,'00C800',0,2,0),(1664,507,23199,0,2,'0000C8',0,2,0),(1665,508,23200,0,0,'C80000',0,2,0),(1666,508,23201,0,1,'00C800',0,2,0),(1667,508,23202,0,2,'0000C8',0,2,0),(1668,509,23203,0,0,'C80000',0,2,0),(1669,509,23204,0,1,'00C800',0,2,0),(1670,509,23205,0,2,'0000C8',0,2,0),(1671,510,23206,0,0,'0000C8',0,2,0),(1672,510,23207,0,1,'C80000',0,2,0),(1673,510,23208,0,2,'00C800',0,2,0),(1674,511,23209,0,0,'C80000',0,2,0),(1675,511,23210,0,1,'00C800',0,2,0),(1676,511,23211,0,2,'0000C8',0,2,0),(1677,512,23248,0,0,'C80000',0,2,0),(1678,512,23246,0,1,'00C800',0,2,0),(1679,512,23249,0,2,'0000C8',0,2,0),(1680,513,23216,0,0,'C80000',0,2,0),(1681,513,23215,0,1,'00C800',0,2,0),(1682,513,23217,0,2,'0000C8',0,2,0),(1683,514,22758,0,0,'00C800',0,2,2),(1684,514,22759,0,1,'C80000',0,2,0),(1685,515,22763,0,0,'00C800',0,2,2),(1686,515,22765,0,1,'C80000',0,2,0),(1687,516,22770,0,0,'00C800',0,2,2),(1688,516,22772,0,1,'C80000',0,2,0),(1689,517,23268,0,0,'00EE00',0,2,0),(1690,517,23263,0,1,'007777',0,2,0),(1691,517,23256,0,2,'0000EE',0,2,0),(1692,517,23258,0,3,'FFAA00',0,2,0),(1693,517,23252,0,4,'00EEEE',0,2,0),(1694,517,23253,0,5,'990099',0,2,0),(1695,517,23254,0,6,'666600',0,2,0),(1696,517,23257,0,7,'EE0000',0,2,0),(1697,517,23266,0,8,'FF66FF',0,2,0),(1698,518,23269,0,0,'990099',0,2,0),(1699,518,23264,0,1,'990000',0,2,0),(1700,518,23261,0,2,'0000EE',0,2,0),(1701,518,23255,0,3,'FF33FF',0,2,0),(1702,518,23260,0,4,'00EE00',0,2,0),(1703,518,23259,0,5,'003300',0,2,0),(1704,518,23265,0,6,'CCCC00',0,2,0),(1705,518,23270,0,7,'33FFFF',0,2,0),(1706,518,23262,0,8,'DD0000',0,2,0),(1707,518,23267,0,9,'000099',0,7,0),(1708,519,23277,5,0,'00C800',0,2,0),(1709,519,23272,5,1,'C80000',1,2,0),(1710,520,23276,0,0,'009900',0,2,0),(1711,520,23273,0,1,'DD0000',0,2,0),(1712,520,23275,0,2,'00DDDD',0,2,0),(1713,520,23274,0,3,'3333FF',0,2,0),(1714,521,23280,5,0,'00AA00',0,2,0),(1715,521,23281,5,1,'3333FF',0,2,0),(1716,522,23285,0,0,'C80000',0,2,2),(1717,522,23283,0,1,'00C800',0,2,0),(1718,523,23298,0,1,'009900',0,2,0),(1719,523,23294,0,2,'000099',0,2,0),(1720,524,23296,0,0,'009900',0,2,0),(1721,524,23297,0,1,'000099',0,2,0),(1722,524,23295,0,2,'990000',0,2,0),(1723,525,23304,1,1,'FF5555',0,2,0),(1724,525,23303,1,2,'55FF55',0,2,0),(1725,525,23300,1,3,'009999',0,2,0),(1726,525,23302,1,4,'990099',0,2,0),(1727,525,23301,1,5,'999900',0,2,0),(1728,525,23305,1,6,'990000',0,2,0),(1729,525,23306,1,7,'000099',0,2,0),(1730,525,23299,1,8,'009900',0,2,0),(1731,526,23311,0,0,'AA0000',0,2,2),(1732,526,23309,0,1,'00AA00',0,2,0),(1733,527,23329,5,0,'990000',1,2,0),(1734,527,23330,5,2,'00BB00',1,2,0),(1737,529,23337,1,0,'888888',0,2,0),(1738,529,23349,1,1,'DD00DD',1,2,0),(1739,529,23348,1,2,'0000DD',1,2,0),(1740,529,23353,1,3,'BBBB00',1,2,0),(1741,529,23352,1,4,'BB0000',1,2,0),(1742,530,23355,1,0,'009999',1,2,0),(1743,530,23354,1,1,'0000CC',1,2,0),(1744,530,23342,1,2,'009900',1,2,0),(1745,530,23341,1,3,'BBBB00',1,2,0),(1746,531,23356,2,0,'009900',1,2,0),(1747,531,23357,2,1,'000099',1,2,0),(1748,531,23358,5,2,'BB00BB',1,2,0),(1749,531,23359,5,3,'BBBB00',1,2,0),(1750,528,23338,5,0,'990000',1,2,0),(1751,528,23337,5,2,'00BB00',1,2,0),(1754,533,23371,1,4,'990000',1,2,0),(1755,533,23372,1,3,'999900',1,2,0),(1756,534,23366,1,2,'009900',1,2,0),(1757,534,23373,1,0,'009999',1,2,0),(1758,532,23362,5,0,'990000',1,2,0),(1759,532,23361,5,2,'00BB00',1,2,0),(1760,535,23374,0,0,'009900',1,2,0),(1761,535,23375,0,1,'000099',1,2,0),(1762,536,23395,1,1,'00EE00',0,2,0),(1763,536,23390,1,6,'FF9999',0,2,0),(1764,536,23392,1,2,'0000EE',0,2,0),(1765,536,23379,1,0,'009900',0,2,0),(1766,536,23388,1,7,'00DDDD',0,2,0),(1767,536,23384,1,3,'888888',0,2,0),(1768,536,23389,1,9,'CC3232',0,2,0),(1769,536,23385,1,4,'BB00BB',0,2,0),(1770,536,23386,1,5,'000000',0,2,0),(1771,536,23382,1,8,'777700',0,2,0),(1772,537,23402,1,0,'009999',0,2,0),(1773,537,23403,1,1,'BBBB00',0,2,0),(1774,538,23404,1,0,'009900',0,2,0),(1775,538,23407,1,1,'CCCC00',0,2,0),(1776,538,23406,1,2,'0000CC',0,2,0),(1777,538,23405,1,3,'999999',0,2,0),(1778,539,23408,0,0,'DD00DD',0,2,0),(1779,540,23409,1,0,'999999',0,2,0),(1780,540,23411,1,1,'CC0000',0,2,0),(1781,540,23410,1,2,'0000CC',0,2,0),(1782,541,23412,1,1,'990000',0,2,0),(1783,541,23415,1,2,'0000CC',0,2,0),(1784,541,23414,1,3,'999999',0,2,0),(1785,541,23413,1,4,'009900',0,2,0),(1786,542,23432,1,0,'009900',1,2,0),(1787,542,23435,2,1,'990099',0,2,0),(1788,543,23438,1,0,'009900',1,2,0),(1789,543,23450,2,1,'CC00CC',0,2,0),(1790,544,23441,1,0,'009900',1,2,0),(1791,544,23454,2,1,'CC00CC',0,2,0),(1792,545,23444,1,0,'009900',1,2,0),(1793,545,23454,2,1,'CC00CC',0,2,0),(1794,546,23448,1,0,'009900',1,2,0),(1795,546,23456,2,1,'CC00CC',0,2,0),(1796,547,23462,1,0,'009900',1,2,0),(1797,548,23465,1,0,'009900',1,2,0),(1798,549,23468,1,0,'009900',1,2,0),(1799,550,23471,1,0,'009900',1,2,0),(1800,551,23475,1,0,'009900',1,2,0),(1811,553,23486,0,0,'009900',1,2,0),(1812,553,23487,0,1,'000099',1,2,0),(1813,554,23492,5,0,'990000',1,2,0),(1814,554,23491,5,2,'00BB00',1,2,0),(1815,555,23495,1,4,'990000',1,2,0),(1816,555,23496,1,3,'999900',1,2,0),(1817,552,23481,1,0,'009900',1,2,0),(1818,552,23479,2,1,'990099',0,2,0),(1819,556,23500,1,2,'009900',1,2,0),(1820,556,23499,1,0,'009999',1,2,0),(1840,558,23514,0,0,'009900',1,2,0),(1841,558,23515,0,1,'000099',1,2,0),(1842,560,23520,5,0,'990000',1,2,0),(1843,560,23519,5,2,'00BB00',1,2,0),(1844,559,23519,1,0,'888888',0,2,0),(1845,559,23525,1,1,'DD00DD',1,2,0),(1846,559,23524,1,2,'0000DD',1,2,0),(1847,559,23529,1,3,'BBBB00',1,2,0),(1848,559,23528,1,4,'BB0000',1,2,0),(1849,561,23533,1,0,'009999',1,2,0),(1850,561,23532,1,1,'0000CC',1,2,0),(1851,561,23534,1,2,'009900',1,2,0),(1852,561,23531,1,3,'BBBB00',1,2,0),(1853,557,23509,1,0,'009900',1,2,0),(1854,557,23507,2,1,'990099',0,2,0),(1855,562,23536,2,0,'009900',1,2,0),(1856,562,23537,2,1,'000099',1,2,0),(1857,562,23538,5,2,'BB00BB',1,2,0),(1858,562,23539,5,3,'BBBB00',1,2,0),(1859,563,23542,1,0,'009900',0,2,0),(1860,563,23543,1,1,'AAAAAA',0,2,0),(1861,563,23541,1,2,'009999',0,2,0),(1862,564,23569,0,0,'009900',1,2,0),(1863,564,23570,0,1,'000099',1,2,0),(1864,565,23573,1,0,'00DDDD',0,4,0),(1865,565,23574,1,1,'0000CC',0,4,0),(1866,566,23576,1,0,'00DDDD',0,4,0),(1867,566,23577,1,1,'0000CC',0,4,0),(1868,566,23575,1,2,'CCCCCC',1,4,0),(1869,567,23578,1,0,'00DDDD',0,4,0),(1870,567,23579,1,1,'0000CC',0,4,0),(1873,569,23586,1,0,'009900',0,2,0),(1874,569,23590,1,1,'00DDDD',0,2,0),(1875,568,23582,5,0,'990000',1,2,0),(1876,568,23581,5,2,'00BB00',1,2,0),(1882,570,23605,5,0,'990000',1,2,0),(1883,570,23604,5,2,'00BB00',1,2,0),(1884,572,23613,1,0,'009900',1,2,0),(1885,571,23611,1,0,'009900',0,2,0),(1886,571,23610,1,1,'00DDDD',0,2,0);
/*!40000 ALTER TABLE `graphs_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `internal` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `groups_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Templates',0),(2,'Linux servers',0),(4,'Zabbix servers',0),(5,'Discovered hosts',1),(6,'autoreg',0);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_items`
--

DROP TABLE IF EXISTS `help_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_items` (
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemtype`,`key_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_items`
--

LOCK TABLES `help_items` WRITE;
/*!40000 ALTER TABLE `help_items` DISABLE KEYS */;
INSERT INTO `help_items` VALUES (0,'agent.ping','Check the agent usability. Always return 1. Can be used as a TCP ping.'),(0,'agent.version','Version of zabbix_agent(d) running on monitored host. String value. Example of returned value: 1.1'),(0,'kernel.maxfiles','Maximum number of opened files supported by OS.'),(0,'kernel.maxproc','Maximum number of processes supported by OS.'),(0,'net.dns.record[&lt;ip&gt;,zone,&lt;type&gt;,&lt;timeout&gt;,&lt;count&gt;]','Performs a DNS query. On success returns a character string with the required type of information.'),(0,'net.dns[&lt;ip&gt;,zone,&lt;type&gt;,&lt;timeout&gt;,&lt;count&gt;]','Checks if DNS service is up. 0 - DNS is down (server did not respond or DNS resolution failed), 1 - DNS is up.'),(0,'net.if.collisions[if]','Out-of-window collision. Collisions count.'),(0,'net.if.in[if,&lt;mode&gt;]','Network interface input statistic. Integer value. If mode is missing bytes is used.'),(0,'net.if.list','List of network interfaces. Text value.'),(0,'net.if.out[if,&lt;mode&gt;]','Network interface output statistic. Integer value. If mode is missing bytes is used.'),(0,'net.if.total[if,&lt;mode&gt;]','Sum of network interface incoming and outgoing statistics. Integer value. Mode - one of bytes (default), packets, errors or dropped'),(0,'net.tcp.listen[port]','Checks if this port is in LISTEN state. 0 - it is not, 1 - it is in LISTEN state.'),(0,'net.tcp.port[&lt;ip&gt;,port]','Check, if it is possible to make TCP connection to the port number. 0 - cannot connect, 1 - can connect. IP address is optional. If ip is missing, 127.0.0.1 is used. Example: net.tcp.port[,80]'),(0,'net.tcp.service.perf[service,&lt;ip&gt;,&lt;port&gt;]','Check performance of service &quot;service&quot;. 0 - service is down, sec - number of seconds spent on connection to the service. If ip is missing 127.0.0.1 is used.  If port number is missing, default service port is used.'),(0,'net.tcp.service[service,&lt;ip&gt;,&lt;port&gt;]','Check if service is available. 0 - service is down, 1 - service is running. If ip is missing 127.0.0.1 is used. If port number is missing, default service port is used. Example: net.tcp.service[ftp,,45].'),(0,'perf_counter[counter,&lt;interval&gt;]','Value of any performance counter, where \"counter\" parameter is the counter path and \"interval\" parameter is a number of last seconds, for which the agent returns an average value.'),(0,'proc.mem[&lt;name&gt;,&lt;user&gt;,&lt;mode&gt;,&lt;cmdline&gt;]','Memory used by process with name name running under user user. Memory used by processes. Process name, user and mode is optional. If name or user is missing all processes will be calculated. If mode is missing sum is used. Example: proc.mem[,root]'),(0,'proc.num[&lt;name&gt;,&lt;user&gt;,&lt;state&gt;,&lt;cmdline&gt;]','Number of processes with name name running under user user having state state. Process name, user and state are optional. Examples: proc.num[,mysql]; proc.num[apache2,www-data]; proc.num[,oracle,sleep,oracleZABBIX]'),(0,'proc_info[&lt;process&gt;,&lt;attribute&gt;,&lt;type&gt;]','Different information about specific process(es)'),(0,'service_state[service]','State of service. 0 - running, 1 - paused, 2 - start pending, 3 - pause pending, 4 - continue pending, 5 - stop pending, 6 - stopped, 7 - unknown, 255 - no such service'),(0,'system.boottime','Timestamp of system boot.'),(0,'system.cpu.intr','Device interrupts.'),(0,'system.cpu.load[&lt;cpu&gt;,&lt;mode&gt;]','CPU(s) load. Processor load. The cpu and mode are optional. If cpu is missing all is used. If mode is missing avg1 is used. Note that this is not percentage.'),(0,'system.cpu.num','Number of available proccessors.'),(0,'system.cpu.switches','Context switches.'),(0,'system.cpu.util[&lt;cpu&gt;,&lt;type&gt;,&lt;mode&gt;]','CPU(s) utilisation. Processor load in percents. The cpu, type and mode are optional. If cpu is missing all is used.  If type is missing user is used. If mode is missing avg1 is used.'),(0,'system.hostname[&lt;type&gt;]','Returns hostname (or NetBIOS name (by default) on Windows). String value. Example of returned value: www.zabbix.com'),(0,'system.hw.chassis[&lt;info&gt;]','Chassis info - returns full info by default'),(0,'system.hw.cpu[&lt;cpu&gt;,&lt;info&gt;]','CPU info - lists full info for all CPUs by default'),(0,'system.hw.devices[&lt;type&gt;]','Device list - lists PCI devices by default'),(0,'system.hw.macaddr[&lt;interface&gt;,&lt;format&gt;]','MAC address - lists all MAC addresses with interface names by default'),(0,'system.localtime','System local time. Time in seconds.'),(0,'system.run[command,&lt;mode&gt;]','Run specified command on the host.'),(0,'system.stat[resource,&lt;type&gt;]','Virtual memory statistics.'),(0,'system.sw.arch','Software architecture'),(0,'system.sw.os[&lt;info&gt;]','Current OS - returns full info by default'),(0,'system.sw.packages[&lt;package&gt;,&lt;manager&gt;,&lt;format&gt;]','Software package list - lists all packages for all supported package managers by default'),(0,'system.swap.in[&lt;swap&gt;,&lt;type&gt;]','Swap in. If type is count - swapins is returned. If type is pages - pages swapped in is returned. If swap is missing all is used.'),(0,'system.swap.out[&lt;swap&gt;,&lt;type&gt;]','Swap out. If type is count - swapouts is returned. If type is pages - pages swapped in is returned. If swap is missing all is used.'),(0,'system.swap.size[&lt;swap&gt;,&lt;mode&gt;]','Swap space. Number of bytes. If swap is missing all is used. If mode is missing free is used.'),(0,'system.uname','Returns detailed host information. String value'),(0,'system.uptime','System uptime in seconds.'),(0,'system.users.num','Number of users connected. Command who is used on agent side.'),(0,'vfs.dev.read[device,&lt;type&gt;,&lt;mode&gt;]','Device read statistics.'),(0,'vfs.dev.write[device,&lt;type&gt;,&lt;mode&gt;]','Device write statistics.'),(0,'vfs.file.cksum[file]','Calculate check sum of a given file. Check sum of the file calculate by standard algorithm used by UNIX utility cksum. Example: vfs.file.cksum[/etc/passwd]'),(0,'vfs.file.contents[file,&lt;encoding&gt;]','Get contents of a given file.'),(0,'vfs.file.exists[file]','Check if file exists. 0 - file does not exist, 1 - file exists'),(0,'vfs.file.md5sum[file]','Calculate MD5 check sum of a given file. String MD5 hash of the file. Can be used for files less than 64MB, unsupported otherwise. Example: vfs.file.md5sum[/etc/zabbix_agentd.conf]'),(0,'vfs.file.regexp[file,regexp,&lt;encoding&gt;]','Find string in a file. Matched string'),(0,'vfs.file.regmatch[file,regexp,&lt;encoding&gt;]','Find string in a file. 0 - expression not found, 1 - found'),(0,'vfs.file.size[file]','Size of a given file. Size in bytes. File must have read permissions for user zabbix. Example: vfs.file.size[/var/log/syslog]'),(0,'vfs.file.time[file,&lt;mode&gt;]','File time information. Number of seconds.The mode is optional. If mode is missing modify is used.'),(0,'vfs.fs.inode[fs,&lt;mode&gt;]','Number of inodes for a given volume. If mode is missing total is used.'),(0,'vfs.fs.size[fs,&lt;mode&gt;]','Calculate disk space for a given volume. Disk space in KB. If mode is missing total is used.  In case of mounted volume, unused disk space for local file system is returned. Example: vfs.fs.size[/tmp,free].'),(0,'vm.memory.size[&lt;mode&gt;]','Amount of memory size in bytes. If mode is missing total is used.'),(0,'web.page.get[host,&lt;path&gt;,&lt;port&gt;]','Get content of WEB page. Default path is /'),(0,'web.page.perf[host,&lt;path&gt;,&lt;port&gt;]','Get timing of loading full WEB page. Default path is /'),(0,'web.page.regexp[host,&lt;path&gt;,&lt;port&gt;,&lt;regexp&gt;,&lt;length&gt;]','Get first occurence of regexp in WEB page. Default path is /'),(3,'icmppingloss[&lt;target&gt;,&lt;packets&gt;,&lt;interval&gt;,&lt;size&gt;,&lt;timeout&gt;]','Returns percentage of lost ICMP ping packets.'),(3,'icmppingsec[&lt;target&gt;,&lt;packets&gt;,&lt;interval&gt;,&lt;size&gt;,&lt;timeout&gt;,&lt;mode&gt;]','Returns ICMP ping response time in seconds. Example: 0.02'),(3,'icmpping[&lt;target&gt;,&lt;packets&gt;,&lt;interval&gt;,&lt;size&gt;,&lt;timeout&gt;]','Checks if server is accessible by ICMP ping. 0 - ICMP ping fails. 1 - ICMP ping successful. One of zabbix_server processes performs ICMP pings once per PingerFrequency seconds.'),(3,'net.tcp.service.perf[service,&lt;ip&gt;,&lt;port&gt;]','Check performance of service. 0 - service is down, sec - number of seconds spent on connection to the service. If &lt;ip&gt; is missing, IP or DNS name is taken from host definition. If &lt;port&gt; is missing, default service port is used.'),(3,'net.tcp.service[service,&lt;ip&gt;,&lt;port&gt;]','Check if service is available. 0 - service is down, 1 - service is running. If &lt;ip&gt; is missing, IP or DNS name is taken from host definition. If &lt;port&gt; is missing, default service port is used.'),(5,'zabbix[boottime]','Startup time of Zabbix server, Unix timestamp.'),(5,'zabbix[history]','Number of values stored in table HISTORY.'),(5,'zabbix[history_log]','Number of values stored in table HISTORY_LOG.'),(5,'zabbix[history_str]','Number of values stored in table HISTORY_STR.'),(5,'zabbix[history_text]','Number of values stored in table HISTORY_TEXT.'),(5,'zabbix[history_uint]','Number of values stored in table HISTORY_UINT.'),(5,'zabbix[host,&lt;type&gt;,available]','Returns availability of a particular type of checks on the host. Value of this item corresponds to availability icons in the host list. Valid types are: agent, snmp, ipmi, jmx.'),(5,'zabbix[items]','Number of items in Zabbix database.'),(5,'zabbix[items_unsupported]','Number of unsupported items in Zabbix database.'),(5,'zabbix[java,,&lt;param&gt;]','Returns information associated with Zabbix Java gateway. Valid params are: ping, version.'),(5,'zabbix[process,&lt;type&gt;,&lt;num&gt;,&lt;state&gt;]','Time a particular Zabbix process or a group of processes (identified by &lt;type&gt; and &lt;num&gt;) spent in &lt;state&gt; in percentage.'),(5,'zabbix[proxy,&lt;name&gt;,&lt;param&gt;]','Time of proxy last access. Name - proxy name. Param - lastaccess. Unix timestamp.'),(5,'zabbix[queue,&lt;from&gt;,&lt;to&gt;]','Number of items in the queue which are delayed by from to to seconds, inclusive.'),(5,'zabbix[rcache,&lt;cache&gt;,&lt;mode&gt;]','Configuration cache statistics. Cache - buffer (modes: pfree, total, used, free).'),(5,'zabbix[requiredperformance]','Required performance of the Zabbix server, in new values per second expected.'),(5,'zabbix[trends]','Number of values stored in table TRENDS.'),(5,'zabbix[trends_uint]','Number of values stored in table TRENDS_UINT.'),(5,'zabbix[triggers]','Number of triggers in Zabbix database.'),(5,'zabbix[uptime]','Uptime of Zabbix server process in seconds.'),(5,'zabbix[wcache,&lt;cache&gt;,&lt;mode&gt;]','Data cache statistics. Cache - one of values (modes: all, float, uint, str, log, text), history (modes: pfree, total, used, free), trend (modes: pfree, total, used, free), text (modes: pfree, total, used, free).'),(7,'agent.ping','Check the agent usability. Always return 1. Can be used as a TCP ping.'),(7,'agent.version','Version of zabbix_agent(d) running on monitored host. String value. Example of returned value: 1.1'),(7,'eventlog[logtype,&lt;pattern&gt;,&lt;severity&gt;,&lt;source&gt;,&lt;eventid&gt;,&lt;maxlines&gt;,&lt;mode&gt;]','Monitoring of Windows event logs. pattern, severity, eventid - regular expressions'),(7,'kernel.maxfiles','Maximum number of opened files supported by OS.'),(7,'kernel.maxproc','Maximum number of processes supported by OS.'),(7,'logrt[file_format,&lt;pattern&gt;,&lt;encoding&gt;,&lt;maxlines&gt;,&lt;mode&gt;]','Monitoring of log file with rotation. fileformat - [path][regexp], pattern - regular expression'),(7,'log[file,&lt;pattern&gt;,&lt;encoding&gt;,&lt;maxlines&gt;,&lt;mode&gt;]','Monitoring of log file. pattern - regular expression'),(7,'net.dns.record[&lt;ip&gt;,zone,&lt;type&gt;,&lt;timeout&gt;,&lt;count&gt;]','Performs a DNS query. On success returns a character string with the required type of information.'),(7,'net.dns[&lt;ip&gt;,zone,&lt;type&gt;,&lt;timeout&gt;,&lt;count&gt;]','Checks if DNS service is up. 0 - DNS is down (server did not respond or DNS resolution failed), 1 - DNS is up.'),(7,'net.if.collisions[if]','Out-of-window collision. Collisions count.'),(7,'net.if.in[if,&lt;mode&gt;]','Network interface input statistic. Integer value. If mode is missing bytes is used.'),(7,'net.if.list','List of network interfaces. Text value.'),(7,'net.if.out[if,&lt;mode&gt;]','Network interface output statistic. Integer value. If mode is missing bytes is used.'),(7,'net.if.total[if,&lt;mode&gt;]','Sum of network interface incoming and outgoing statistics. Integer value. Mode - one of bytes (default), packets, errors or dropped'),(7,'net.tcp.listen[port]','Checks if this port is in LISTEN state. 0 - it is not, 1 - it is in LISTEN state.'),(7,'net.tcp.port[&lt;ip&gt;,port]','Check, if it is possible to make TCP connection to the port number. 0 - cannot connect, 1 - can connect. IP address is optional. If ip is missing, 127.0.0.1 is used. Example: net.tcp.port[,80]'),(7,'net.tcp.service.perf[service,&lt;ip&gt;,&lt;port&gt;]','Check performance of service &quot;service&quot;. 0 - service is down, sec - number of seconds spent on connection to the service. If ip is missing 127.0.0.1 is used.  If port number is missing, default service port is used.'),(7,'net.tcp.service[service,&lt;ip&gt;,&lt;port&gt;]','Check if service is available. 0 - service is down, 1 - service is running. If ip is missing 127.0.0.1 is used. If port number is missing, default service port is used. Example: net.tcp.service[ftp,,45].'),(7,'perf_counter[counter,&lt;interval&gt;]','Value of any performance counter, where \"counter\" parameter is the counter path and \"interval\" parameter is a number of last seconds, for which the agent returns an average value.'),(7,'proc.mem[&lt;name&gt;,&lt;user&gt;,&lt;mode&gt;,&lt;cmdline&gt;]','Memory used by process with name name running under user user. Memory used by processes. Process name, user and mode is optional. If name or user is missing all processes will be calculated. If mode is missing sum is used. Example: proc.mem[,root]'),(7,'proc.num[&lt;name&gt;,&lt;user&gt;,&lt;state&gt;,&lt;cmdline&gt;]','Number of processes with name name running under user user having state state. Process name, user and state are optional. Examples: proc.num[,mysql]; proc.num[apache2,www-data]; proc.num[,oracle,sleep,oracleZABBIX]'),(7,'proc_info[&lt;process&gt;,&lt;attribute&gt;,&lt;type&gt;]','Different information about specific process(es)'),(7,'service_state[service]','State of service. 0 - running, 1 - paused, 2 - start pending, 3 - pause pending, 4 - continue pending, 5 - stop pending, 6 - stopped, 7 - unknown, 255 - no such service'),(7,'system.boottime','Timestamp of system boot.'),(7,'system.cpu.intr','Device interrupts.'),(7,'system.cpu.load[&lt;cpu&gt;,&lt;mode&gt;]','CPU(s) load. Processor load. The cpu and mode are optional. If cpu is missing all is used. If mode is missing avg1 is used. Note that this is not percentage.'),(7,'system.cpu.num','Number of available proccessors.'),(7,'system.cpu.switches','Context switches.'),(7,'system.cpu.util[&lt;cpu&gt;,&lt;type&gt;,&lt;mode&gt;]','CPU(s) utilisation. Processor load in percents. The cpu, type and mode are optional. If cpu is missing all is used.  If type is missing user is used. If mode is missing avg1 is used.'),(7,'system.hostname[&lt;type&gt;]','Returns hostname (or NetBIOS name (by default) on Windows). String value. Example of returned value: www.zabbix.com'),(7,'system.hw.chassis[&lt;info&gt;]','Chassis info - returns full info by default'),(7,'system.hw.cpu[&lt;cpu&gt;,&lt;info&gt;]','CPU info - lists full info for all CPUs by default'),(7,'system.hw.devices[&lt;type&gt;]','Device list - lists PCI devices by default'),(7,'system.hw.macaddr[&lt;interface&gt;,&lt;format&gt;]','MAC address - lists all MAC addresses with interface names by default'),(7,'system.localtime','System local time. Time in seconds.'),(7,'system.run[command,&lt;mode&gt;]','Run specified command on the host.'),(7,'system.stat[resource,&lt;type&gt;]','Virtual memory statistics.'),(7,'system.sw.arch','Software architecture'),(7,'system.sw.os[&lt;info&gt;]','Current OS - returns full info by default'),(7,'system.sw.packages[&lt;package&gt;,&lt;manager&gt;,&lt;format&gt;]','Software package list - lists all packages for all supported package managers by default'),(7,'system.swap.in[&lt;swap&gt;,&lt;type&gt;]','Swap in. If type is count - swapins is returned. If type is pages - pages swapped in is returned. If swap is missing all is used.'),(7,'system.swap.out[&lt;swap&gt;,&lt;type&gt;]','Swap out. If type is count - swapouts is returned. If type is pages - pages swapped in is returned. If swap is missing all is used.'),(7,'system.swap.size[&lt;swap&gt;,&lt;mode&gt;]','Swap space. Number of bytes. If swap is missing all is used. If mode is missing free is used.'),(7,'system.uname','Returns detailed host information. String value'),(7,'system.uptime','System uptime in seconds.'),(7,'system.users.num','Number of users connected. Command who is used on agent side.'),(7,'vfs.dev.read[device,&lt;type&gt;,&lt;mode&gt;]','Device read statistics.'),(7,'vfs.dev.write[device,&lt;type&gt;,&lt;mode&gt;]','Device write statistics.'),(7,'vfs.file.cksum[file]','Calculate check sum of a given file. Check sum of the file calculate by standard algorithm used by UNIX utility cksum. Example: vfs.file.cksum[/etc/passwd]'),(7,'vfs.file.contents[file,&lt;encoding&gt;]','Get contents of a given file.'),(7,'vfs.file.exists[file]','Check if file exists. 0 - file does not exist, 1 - file exists'),(7,'vfs.file.md5sum[file]','Calculate MD5 check sum of a given file. String MD5 hash of the file. Can be used for files less than 64MB, unsupported otherwise. Example: vfs.file.md5sum[/etc/zabbix_agentd.conf]'),(7,'vfs.file.regexp[file,regexp,&lt;encoding&gt;]','Find string in a file. Matched string'),(7,'vfs.file.regmatch[file,regexp,&lt;encoding&gt;]','Find string in a file. 0 - expression not found, 1 - found'),(7,'vfs.file.size[file]','Size of a given file. Size in bytes. File must have read permissions for user zabbix. Example: vfs.file.size[/var/log/syslog]'),(7,'vfs.file.time[file,&lt;mode&gt;]','File time information. Number of seconds.The mode is optional. If mode is missing modify is used.'),(7,'vfs.fs.inode[fs,&lt;mode&gt;]','Number of inodes for a given volume. If mode is missing total is used.'),(7,'vfs.fs.size[fs,&lt;mode&gt;]','Calculate disk space for a given volume. Disk space in KB. If mode is missing total is used.  In case of mounted volume, unused disk space for local file system is returned. Example: vfs.fs.size[/tmp,free].'),(7,'vm.memory.size[&lt;mode&gt;]','Amount of memory size in bytes. If mode is missing total is used.'),(7,'web.page.get[host,&lt;path&gt;,&lt;port&gt;]','Get content of WEB page. Default path is /'),(7,'web.page.perf[host,&lt;path&gt;,&lt;port&gt;]','Get timing of loading full WEB page. Default path is /'),(7,'web.page.regexp[host,&lt;path&gt;,&lt;port&gt;,&lt;regexp&gt;,&lt;length&gt;]','Get first occurence of regexp in WEB page. Default path is /'),(8,'grpfunc[&lt;group&gt;,&lt;key&gt;,&lt;func&gt;,&lt;param&gt;]','Aggregate checks do not require any agent running on a host being monitored. Zabbix server collects aggregate information by doing direct database queries. See Zabbix Manual.'),(17,'snmptrap.fallback','Catches all SNMP traps from a corresponding address that were not catched by any of the snmptrap[] items for that interface.'),(17,'snmptrap[&lt;regex&gt;]','Catches all SNMP traps from a corresponding address that match regex. Default regex is an empty string.');
/*!40000 ALTER TABLE `help_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_log`
--

DROP TABLE IF EXISTS `history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_log` (
  `id` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `history_log_2` (`itemid`,`id`),
  KEY `history_log_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log`
--

LOCK TABLES `history_log` WRITE;
/*!40000 ALTER TABLE `history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str`
--

DROP TABLE IF EXISTS `history_str`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_str_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str`
--

LOCK TABLES `history_str` WRITE;
/*!40000 ALTER TABLE `history_str` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str_sync`
--

DROP TABLE IF EXISTS `history_str_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str_sync` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `history_str_sync_1` (`nodeid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str_sync`
--

LOCK TABLES `history_str_sync` WRITE;
/*!40000 ALTER TABLE `history_str_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_sync`
--

DROP TABLE IF EXISTS `history_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_sync` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `history_sync_1` (`nodeid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_sync`
--

LOCK TABLES `history_sync` WRITE;
/*!40000 ALTER TABLE `history_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_text`
--

DROP TABLE IF EXISTS `history_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_text` (
  `id` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `history_text_2` (`itemid`,`id`),
  KEY `history_text_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_text`
--

LOCK TABLES `history_text` WRITE;
/*!40000 ALTER TABLE `history_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint`
--

DROP TABLE IF EXISTS `history_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_uint_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint`
--

LOCK TABLES `history_uint` WRITE;
/*!40000 ALTER TABLE `history_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint_sync`
--

DROP TABLE IF EXISTS `history_uint_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint_sync` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `history_uint_sync_1` (`nodeid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint_sync`
--

LOCK TABLES `history_uint_sync` WRITE;
/*!40000 ALTER TABLE `history_uint_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_inventory`
--

DROP TABLE IF EXISTS `host_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_inventory` (
  `hostid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  `type` varchar(64) NOT NULL DEFAULT '',
  `type_full` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `alias` varchar(64) NOT NULL DEFAULT '',
  `os` varchar(64) NOT NULL DEFAULT '',
  `os_full` varchar(255) NOT NULL DEFAULT '',
  `os_short` varchar(64) NOT NULL DEFAULT '',
  `serialno_a` varchar(64) NOT NULL DEFAULT '',
  `serialno_b` varchar(64) NOT NULL DEFAULT '',
  `tag` varchar(64) NOT NULL DEFAULT '',
  `asset_tag` varchar(64) NOT NULL DEFAULT '',
  `macaddress_a` varchar(64) NOT NULL DEFAULT '',
  `macaddress_b` varchar(64) NOT NULL DEFAULT '',
  `hardware` varchar(255) NOT NULL DEFAULT '',
  `hardware_full` text NOT NULL,
  `software` varchar(255) NOT NULL DEFAULT '',
  `software_full` text NOT NULL,
  `software_app_a` varchar(64) NOT NULL DEFAULT '',
  `software_app_b` varchar(64) NOT NULL DEFAULT '',
  `software_app_c` varchar(64) NOT NULL DEFAULT '',
  `software_app_d` varchar(64) NOT NULL DEFAULT '',
  `software_app_e` varchar(64) NOT NULL DEFAULT '',
  `contact` text NOT NULL,
  `location` text NOT NULL,
  `location_lat` varchar(16) NOT NULL DEFAULT '',
  `location_lon` varchar(16) NOT NULL DEFAULT '',
  `notes` text NOT NULL,
  `chassis` varchar(64) NOT NULL DEFAULT '',
  `model` varchar(64) NOT NULL DEFAULT '',
  `hw_arch` varchar(32) NOT NULL DEFAULT '',
  `vendor` varchar(64) NOT NULL DEFAULT '',
  `contract_number` varchar(64) NOT NULL DEFAULT '',
  `installer_name` varchar(64) NOT NULL DEFAULT '',
  `deployment_status` varchar(64) NOT NULL DEFAULT '',
  `url_a` varchar(255) NOT NULL DEFAULT '',
  `url_b` varchar(255) NOT NULL DEFAULT '',
  `url_c` varchar(255) NOT NULL DEFAULT '',
  `host_networks` text NOT NULL,
  `host_netmask` varchar(39) NOT NULL DEFAULT '',
  `host_router` varchar(39) NOT NULL DEFAULT '',
  `oob_ip` varchar(39) NOT NULL DEFAULT '',
  `oob_netmask` varchar(39) NOT NULL DEFAULT '',
  `oob_router` varchar(39) NOT NULL DEFAULT '',
  `date_hw_purchase` varchar(64) NOT NULL DEFAULT '',
  `date_hw_install` varchar(64) NOT NULL DEFAULT '',
  `date_hw_expiry` varchar(64) NOT NULL DEFAULT '',
  `date_hw_decomm` varchar(64) NOT NULL DEFAULT '',
  `site_address_a` varchar(128) NOT NULL DEFAULT '',
  `site_address_b` varchar(128) NOT NULL DEFAULT '',
  `site_address_c` varchar(128) NOT NULL DEFAULT '',
  `site_city` varchar(128) NOT NULL DEFAULT '',
  `site_state` varchar(64) NOT NULL DEFAULT '',
  `site_country` varchar(64) NOT NULL DEFAULT '',
  `site_zip` varchar(64) NOT NULL DEFAULT '',
  `site_rack` varchar(128) NOT NULL DEFAULT '',
  `site_notes` text NOT NULL,
  `poc_1_name` varchar(128) NOT NULL DEFAULT '',
  `poc_1_email` varchar(128) NOT NULL DEFAULT '',
  `poc_1_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_1_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_1_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_1_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_1_notes` text NOT NULL,
  `poc_2_name` varchar(128) NOT NULL DEFAULT '',
  `poc_2_email` varchar(128) NOT NULL DEFAULT '',
  `poc_2_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_2_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_2_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_2_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_2_notes` text NOT NULL,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_inventory_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_inventory`
--

LOCK TABLES `host_inventory` WRITE;
/*!40000 ALTER TABLE `host_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostmacro`
--

DROP TABLE IF EXISTS `hostmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostmacro` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `macro` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`hostmacroid`),
  UNIQUE KEY `hostmacro_1` (`hostid`,`macro`),
  CONSTRAINT `c_hostmacro_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro`
--

LOCK TABLES `hostmacro` WRITE;
/*!40000 ALTER TABLE `hostmacro` DISABLE KEYS */;
INSERT INTO `hostmacro` VALUES (1,10085,'{$LOADAVG15_MAX}','14'),(2,10085,'{$SWAP_OF_MEM}','1'),(3,10085,'{$WARN_TIME}','1h'),(4,10086,'{$MEMFREE_MIN}','20M'),(5,10086,'{$IOWAIT_MAX}','25'),(6,10086,'{$SWAPIO_MAX}','1'),(7,10087,'{$IOWAIT_MAX}','0.25'),(8,10087,'{$MEMFREE_MIN}','20M'),(9,10090,'{$ACTIVE_NODATA_MAX}','3600'),(10,10093,'{$MTA_NAME}','exim4'),(11,10094,'{$VOL0_FREE_MIN}','20M'),(12,10095,'{$VOL1_FREE_MIN}','20M'),(13,10095,'{$VOL2_FREE_MIN}','20M'),(14,10095,'{$VOL3_FREE_MIN}','20M'),(15,10095,'{$VOL4_FREE_MIN}','20M'),(16,10096,'{$VOL0_INODE_MIN}','50'),(17,10096,'{$VOL_0}','/'),(18,10097,'{$VOL_1}','/var'),(19,10097,'{$VOL_2}','/home'),(20,10097,'{$VOL_3}','/usr'),(21,10097,'{$VOL_4}','/tmp'),(22,10098,'{$VOL_0}','c:'),(23,10099,'{$VOL_1}','d:'),(24,10099,'{$VOL_2}','e:'),(25,10099,'{$VOL_3}','f:'),(26,10099,'{$VOL_4}','g:'),(27,10100,'{$IF0}','em0'),(28,10102,'{$IF0}','eth0'),(29,10103,'{$PAGE_SIZE}','4K'),(30,10103,'{$MEMFREE_MIN}','20M'),(31,10109,'{$MEMFREE_MIN}','20M');
/*!40000 ALTER TABLE `hostmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `disable_until` int(11) NOT NULL DEFAULT '0',
  `error` varchar(128) NOT NULL DEFAULT '',
  `available` int(11) NOT NULL DEFAULT '0',
  `errors_from` int(11) NOT NULL DEFAULT '0',
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `ipmi_authtype` int(11) NOT NULL DEFAULT '0',
  `ipmi_privilege` int(11) NOT NULL DEFAULT '2',
  `ipmi_username` varchar(16) NOT NULL DEFAULT '',
  `ipmi_password` varchar(20) NOT NULL DEFAULT '',
  `ipmi_disable_until` int(11) NOT NULL DEFAULT '0',
  `ipmi_available` int(11) NOT NULL DEFAULT '0',
  `snmp_disable_until` int(11) NOT NULL DEFAULT '0',
  `snmp_available` int(11) NOT NULL DEFAULT '0',
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `maintenance_status` int(11) NOT NULL DEFAULT '0',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `maintenance_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_errors_from` int(11) NOT NULL DEFAULT '0',
  `snmp_errors_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_error` varchar(128) NOT NULL DEFAULT '',
  `snmp_error` varchar(128) NOT NULL DEFAULT '',
  `jmx_disable_until` int(11) NOT NULL DEFAULT '0',
  `jmx_available` int(11) NOT NULL DEFAULT '0',
  `jmx_errors_from` int(11) NOT NULL DEFAULT '0',
  `jmx_error` varchar(128) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`hostid`),
  KEY `hosts_1` (`host`),
  KEY `hosts_2` (`status`),
  KEY `hosts_3` (`proxy_hostid`),
  KEY `hosts_4` (`name`),
  KEY `c_hosts_2` (`maintenanceid`),
  CONSTRAINT `c_hosts_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`),
  CONSTRAINT `c_hosts_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (10001,NULL,'Template OS Linux',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux'),(10047,NULL,'Template App Zabbix Server',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Server'),(10050,NULL,'Template App Zabbix Agent',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Agent'),(10056,NULL,'Template App Agentless',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Agentless'),(10060,NULL,'Template SNMP Interfaces',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Interfaces'),(10065,NULL,'Template SNMP Generic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Generic'),(10066,NULL,'Template SNMP Device',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Device'),(10067,NULL,'Template SNMP OS Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP OS Windows'),(10068,NULL,'Template SNMP Disks',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Disks'),(10069,NULL,'Template SNMP OS Linux',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP OS Linux'),(10070,NULL,'Template SNMP Processors',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Processors'),(10071,NULL,'Template IPMI Intel SR1530',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template IPMI Intel SR1530'),(10072,NULL,'Template IPMI Intel SR1630',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template IPMI Intel SR1630'),(10073,NULL,'Template App MySQL',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App MySQL'),(10074,NULL,'Template OS OpenBSD',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS OpenBSD'),(10075,NULL,'Template OS FreeBSD',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS FreeBSD'),(10076,NULL,'Template OS AIX',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS AIX'),(10077,NULL,'Template OS HP-UX',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS HP-UX'),(10078,NULL,'Template OS Solaris',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Solaris'),(10079,NULL,'Template OS Mac OS X',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Mac OS X'),(10081,NULL,'Template OS Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Windows'),(10082,NULL,'Template JMX Generic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template JMX Generic'),(10083,NULL,'Template JMX Tomcat',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template JMX Tomcat'),(10084,NULL,'Zabbix server',1,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Zabbix server'),(10085,NULL,'Perf_Basic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Perf_Basic'),(10086,NULL,'Perf_Linux',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Perf_Linux'),(10087,NULL,'Perf_FreeBSD',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Perf_FreeBSD'),(10088,NULL,'Net_0_Unix',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Net_0_Unix'),(10089,NULL,'Info_Host_Basic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Info_Host_Basic'),(10090,NULL,'Agent_Check',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Agent_Check'),(10091,NULL,'Apache_Stats',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Apache_Stats'),(10092,NULL,'Daemons_Linux',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Daemons_Linux'),(10093,NULL,'Exim',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Exim'),(10094,NULL,'Filesystem',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Filesystem'),(10095,NULL,'Filesystem_Ext',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Filesystem_Ext'),(10096,NULL,'Filesystem_Unix',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Filesystem_Unix'),(10097,NULL,'Filesystem_Unix_Ext',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Filesystem_Unix_Ext'),(10098,NULL,'Filesystem_Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Filesystem_Windows'),(10099,NULL,'Filesystem_Windows_Ext',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Filesystem_Windows_Ext'),(10100,NULL,'FreeBSD_Basic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','FreeBSD_Basic'),(10101,NULL,'Info_Host',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Info_Host'),(10102,NULL,'Linux_Basic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Linux_Basic'),(10103,NULL,'Memory_FreeBSD',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Memory_FreeBSD'),(10104,NULL,'Microsoft_Exchange_2003',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Microsoft_Exchange_2003'),(10105,NULL,'MySQL',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','MySQL'),(10106,NULL,'Net_1_Unix',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Net_1_Unix'),(10107,NULL,'Net_lo_Unix',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Net_lo_Unix'),(10108,NULL,'Perf_IO_Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Perf_IO_Windows'),(10109,NULL,'Perf_Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Perf_Windows'),(10110,NULL,'Ping',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Ping'),(10111,NULL,'Services_Inet',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Services_Inet'),(10112,NULL,'Windows_Basic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Windows_Basic'),(10113,NULL,'Windows_Demo',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Windows_Demo');
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_groups`
--

DROP TABLE IF EXISTS `hosts_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_groups` (
  `hostgroupid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostgroupid`),
  UNIQUE KEY `hosts_groups_1` (`hostid`,`groupid`),
  KEY `hosts_groups_2` (`groupid`),
  CONSTRAINT `c_hosts_groups_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_groups_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_groups`
--

LOCK TABLES `hosts_groups` WRITE;
/*!40000 ALTER TABLE `hosts_groups` DISABLE KEYS */;
INSERT INTO `hosts_groups` VALUES (1,10001,1),(47,10047,1),(50,10050,1),(56,10056,1),(70,10060,1),(73,10065,1),(74,10066,1),(75,10067,1),(76,10068,1),(77,10069,1),(78,10070,1),(79,10071,1),(80,10072,1),(81,10073,1),(82,10074,1),(83,10075,1),(84,10076,1),(85,10077,1),(86,10078,1),(87,10079,1),(89,10081,1),(90,10082,1),(91,10083,1),(92,10084,4),(93,10085,1),(94,10086,1),(95,10087,1),(96,10088,1),(97,10089,1),(98,10090,1),(99,10091,1),(100,10092,1),(101,10093,1),(102,10094,1),(103,10095,1),(104,10096,1),(105,10097,1),(106,10098,1),(107,10099,1),(108,10100,1),(109,10101,1),(110,10102,1),(111,10103,1),(112,10104,1),(113,10105,1),(114,10106,1),(115,10107,1),(116,10108,1),(117,10109,1),(118,10110,1),(119,10111,1),(120,10112,1),(121,10113,1);
/*!40000 ALTER TABLE `hosts_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_templates`
--

DROP TABLE IF EXISTS `hosts_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_templates` (
  `hosttemplateid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hosttemplateid`),
  UNIQUE KEY `hosts_templates_1` (`hostid`,`templateid`),
  KEY `hosts_templates_2` (`templateid`),
  CONSTRAINT `c_hosts_templates_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_templates_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_templates`
--

LOCK TABLES `hosts_templates` WRITE;
/*!40000 ALTER TABLE `hosts_templates` DISABLE KEYS */;
INSERT INTO `hosts_templates` VALUES (4,10001,10050),(22,10066,10060),(21,10066,10065),(24,10067,10060),(23,10067,10065),(25,10067,10068),(30,10067,10070),(28,10069,10060),(27,10069,10065),(26,10069,10068),(29,10069,10070),(31,10074,10050),(32,10075,10050),(33,10076,10050),(34,10077,10050),(35,10078,10050),(36,10079,10050),(37,10081,10050),(39,10084,10001),(38,10084,10047),(40,10086,10085),(41,10087,10085),(42,10096,10094),(43,10097,10095),(44,10098,10094),(45,10099,10095),(50,10100,10087),(49,10100,10088),(48,10100,10089),(46,10100,10090),(47,10100,10096),(55,10102,10086),(54,10102,10088),(53,10102,10089),(51,10102,10090),(52,10102,10096),(56,10109,10085),(58,10112,10089),(57,10112,10090),(60,10112,10098),(59,10112,10109);
/*!40000 ALTER TABLE `hosts_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeper`
--

DROP TABLE IF EXISTS `housekeeper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `housekeeper` (
  `housekeeperid` bigint(20) unsigned NOT NULL,
  `tablename` varchar(64) NOT NULL DEFAULT '',
  `field` varchar(64) NOT NULL DEFAULT '',
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`housekeeperid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeper`
--

LOCK TABLES `housekeeper` WRITE;
/*!40000 ALTER TABLE `housekeeper` DISABLE KEYS */;
/*!40000 ALTER TABLE `housekeeper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep`
--

DROP TABLE IF EXISTS `httpstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep` (
  `httpstepid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `no` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `timeout` int(11) NOT NULL DEFAULT '30',
  `posts` text NOT NULL,
  `required` varchar(255) NOT NULL DEFAULT '',
  `status_codes` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`httpstepid`),
  KEY `httpstep_httpstep_1` (`httptestid`),
  CONSTRAINT `c_httpstep_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep`
--

LOCK TABLES `httpstep` WRITE;
/*!40000 ALTER TABLE `httpstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstepitem`
--

DROP TABLE IF EXISTS `httpstepitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstepitem` (
  `httpstepitemid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepitemid`),
  UNIQUE KEY `httpstepitem_httpstepitem_1` (`httpstepid`,`itemid`),
  KEY `c_httpstepitem_2` (`itemid`),
  CONSTRAINT `c_httpstepitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_httpstepitem_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstepitem`
--

LOCK TABLES `httpstepitem` WRITE;
/*!40000 ALTER TABLE `httpstepitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstepitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest`
--

DROP TABLE IF EXISTS `httptest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest` (
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `applicationid` bigint(20) unsigned NOT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `delay` int(11) NOT NULL DEFAULT '60',
  `status` int(11) NOT NULL DEFAULT '0',
  `macros` text NOT NULL,
  `agent` varchar(255) NOT NULL DEFAULT '',
  `authentication` int(11) NOT NULL DEFAULT '0',
  `http_user` varchar(64) NOT NULL DEFAULT '',
  `http_password` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`httptestid`),
  KEY `httptest_httptest_1` (`applicationid`),
  KEY `httptest_2` (`name`),
  KEY `httptest_3` (`status`),
  CONSTRAINT `c_httptest_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest`
--

LOCK TABLES `httptest` WRITE;
/*!40000 ALTER TABLE `httptest` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptestitem`
--

DROP TABLE IF EXISTS `httptestitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptestitem` (
  `httptestitemid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestitemid`),
  UNIQUE KEY `httptestitem_httptestitem_1` (`httptestid`,`itemid`),
  KEY `c_httptestitem_2` (`itemid`),
  CONSTRAINT `c_httptestitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptestitem_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptestitem`
--

LOCK TABLES `httptestitem` WRITE;
/*!40000 ALTER TABLE `httptestitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptestitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_map`
--

DROP TABLE IF EXISTS `icon_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_map` (
  `iconmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `default_iconid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`iconmapid`),
  KEY `icon_map_1` (`name`),
  KEY `c_icon_map_1` (`default_iconid`),
  CONSTRAINT `c_icon_map_1` FOREIGN KEY (`default_iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_map`
--

LOCK TABLES `icon_map` WRITE;
/*!40000 ALTER TABLE `icon_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_mapping`
--

DROP TABLE IF EXISTS `icon_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_mapping` (
  `iconmappingid` bigint(20) unsigned NOT NULL,
  `iconmapid` bigint(20) unsigned NOT NULL,
  `iconid` bigint(20) unsigned NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `expression` varchar(64) NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iconmappingid`),
  KEY `icon_mapping_1` (`iconmapid`),
  KEY `c_icon_mapping_2` (`iconid`),
  CONSTRAINT `c_icon_mapping_2` FOREIGN KEY (`iconid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_icon_mapping_1` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_mapping`
--

LOCK TABLES `icon_mapping` WRITE;
/*!40000 ALTER TABLE `icon_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `nodeid` int(11) NOT NULL,
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `field_name` varchar(64) NOT NULL DEFAULT '',
  `nextid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`nodeid`,`table_name`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
INSERT INTO `ids` VALUES (0,'actions','actionid',4),(0,'applications','applicationid',405),(0,'auditlog','auditid',99),(0,'events','eventid',95),(0,'functions','functionid',13089),(0,'graphs','graphid',572),(0,'graphs_items','gitemid',1886),(0,'groups','groupid',6),(0,'hostmacro','hostmacroid',31),(0,'hosts','hostid',10113),(0,'hosts_groups','hostgroupid',121),(0,'hosts_templates','hosttemplateid',60),(0,'items','itemid',23620),(0,'items_applications','itemappid',5816),(0,'operations','operationid',6),(0,'opgroup','opgroupid',3),(0,'optemplate','optemplateid',2),(0,'profiles','profileid',17),(0,'triggers','triggerid',13611),(0,'user_history','userhistoryid',1);
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `imageid` bigint(20) unsigned NOT NULL,
  `imagetype` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '0',
  `image` longblob NOT NULL,
  PRIMARY KEY (`imageid`),
  KEY `images_1` (`imagetype`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `useip` int(11) NOT NULL DEFAULT '1',
  `ip` varchar(39) NOT NULL DEFAULT '127.0.0.1',
  `dns` varchar(64) NOT NULL DEFAULT '',
  `port` varchar(64) NOT NULL DEFAULT '10050',
  PRIMARY KEY (`interfaceid`),
  KEY `interface_1` (`hostid`,`type`),
  KEY `interface_2` (`ip`,`dns`),
  CONSTRAINT `c_interface_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES (1,10084,1,1,1,'127.0.0.1','','10050');
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_discovery`
--

DROP TABLE IF EXISTS `item_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_discovery` (
  `itemdiscoveryid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `parent_itemid` bigint(20) unsigned NOT NULL,
  `key_` varchar(255) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemdiscoveryid`),
  UNIQUE KEY `item_discovery_1` (`itemid`,`parent_itemid`),
  KEY `c_item_discovery_2` (`parent_itemid`),
  CONSTRAINT `c_item_discovery_2` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_discovery`
--

LOCK TABLES `item_discovery` WRITE;
/*!40000 ALTER TABLE `item_discovery` DISABLE KEYS */;
INSERT INTO `item_discovery` VALUES (1,22446,22444,'',0,0),(3,22448,22444,'',0,0),(5,22452,22450,'',0,0),(7,22454,22450,'',0,0),(9,22456,22450,'',0,0),(11,22458,22450,'',0,0),(65,22686,22450,'',0,0),(68,22701,22700,'',0,0),(69,22702,22700,'',0,0),(70,22703,22700,'',0,0),(71,22704,22700,'',0,0),(72,22705,22700,'',0,0),(73,22706,22700,'',0,0),(74,22707,22700,'',0,0),(75,22708,22700,'',0,0),(76,22721,22720,'',0,0),(77,22722,22720,'',0,0),(78,22723,22720,'',0,0),(79,22724,22720,'',0,0),(80,22725,22720,'',0,0),(81,22726,22720,'',0,0),(82,22727,22720,'',0,0),(83,22728,22720,'',0,0),(84,22736,22735,'',0,0),(85,22737,22735,'',0,0),(86,22738,22735,'',0,0),(87,22739,22735,'',0,0),(88,22740,22735,'',0,0),(89,22741,22735,'',0,0),(90,22742,22735,'',0,0),(91,22743,22735,'',0,0),(94,22749,22746,'',0,0),(100,22755,22746,'',0,0),(101,22756,22746,'',0,0),(102,22757,22746,'',0,0),(103,22758,22746,'',0,0),(104,22759,22746,'',0,0),(105,22761,22760,'',0,0),(106,22762,22760,'',0,0),(107,22763,22760,'',0,0),(108,22764,22760,'',0,0),(109,22765,22760,'',0,0),(110,22766,22760,'',0,0),(111,22768,22767,'',0,0),(112,22769,22767,'',0,0),(113,22770,22767,'',0,0),(114,22771,22767,'',0,0),(115,22772,22767,'',0,0),(116,22773,22767,'',0,0),(117,22780,22779,'',0,0),(118,22781,22779,'',0,0),(119,22782,22779,'',0,0),(120,22783,22779,'',0,0),(121,22784,22779,'',0,0),(122,22785,22779,'',0,0),(123,22786,22779,'',0,0),(124,22787,22779,'',0,0),(128,22793,22789,'',0,0),(131,22797,22796,'',0,0),(132,22799,22798,'',0,0),(135,22868,22867,'',0,0),(136,22869,22867,'',0,0),(137,22870,22867,'',0,0),(138,22871,22867,'',0,0),(139,22872,22867,'',0,0),(142,22908,22907,'',0,0),(143,22909,22907,'',0,0),(144,22910,22907,'',0,0),(145,22911,22907,'',0,0),(146,22912,22907,'',0,0),(147,22945,22944,'',0,0),(148,22946,22944,'',0,0),(149,22948,22947,'',0,0),(150,22949,22947,'',0,0),(151,22950,22947,'',0,0),(152,22951,22947,'',0,0),(153,22952,22947,'',0,0),(154,22985,22984,'',0,0),(155,22986,22984,'',0,0),(156,22988,22987,'',0,0),(157,22989,22987,'',0,0),(158,22990,22987,'',0,0),(159,22991,22987,'',0,0),(160,22992,22987,'',0,0),(161,23025,23024,'',0,0),(162,23026,23024,'',0,0),(163,23028,23027,'',0,0),(164,23029,23027,'',0,0),(165,23030,23027,'',0,0),(166,23031,23027,'',0,0),(167,23032,23027,'',0,0),(170,23068,23067,'',0,0),(171,23069,23067,'',0,0),(172,23070,23067,'',0,0),(173,23071,23067,'',0,0),(174,23072,23067,'',0,0),(175,23164,23162,'',0,0),(176,23165,23162,'',0,0),(178,23167,23162,'',0,0),(179,23168,23162,'',0,0),(180,23169,23163,'',0,0),(181,23170,23163,'',0,0),(182,23280,23278,'',0,0),(183,23281,23278,'',0,0),(184,23282,23279,'',0,0),(185,23283,23279,'',0,0),(186,23284,23279,'',0,0),(187,23285,23279,'',0,0),(188,23286,23279,'',0,0);
/*!40000 ALTER TABLE `item_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `snmp_community` varchar(64) NOT NULL DEFAULT '',
  `snmp_oid` varchar(255) NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '0',
  `history` int(11) NOT NULL DEFAULT '90',
  `trends` int(11) NOT NULL DEFAULT '365',
  `lastvalue` varchar(255) DEFAULT NULL,
  `lastclock` int(11) DEFAULT NULL,
  `prevvalue` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `value_type` int(11) NOT NULL DEFAULT '0',
  `trapper_hosts` varchar(255) NOT NULL DEFAULT '',
  `units` varchar(255) NOT NULL DEFAULT '',
  `multiplier` int(11) NOT NULL DEFAULT '0',
  `delta` int(11) NOT NULL DEFAULT '0',
  `prevorgvalue` varchar(255) DEFAULT NULL,
  `snmpv3_securityname` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `formula` varchar(255) NOT NULL DEFAULT '1',
  `error` varchar(128) NOT NULL DEFAULT '',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `logtimefmt` varchar(64) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `valuemapid` bigint(20) unsigned DEFAULT NULL,
  `delay_flex` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `ipmi_sensor` varchar(128) NOT NULL DEFAULT '',
  `data_type` int(11) NOT NULL DEFAULT '0',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `lastns` int(11) DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  `filter` varchar(255) NOT NULL DEFAULT '',
  `interfaceid` bigint(20) unsigned DEFAULT NULL,
  `port` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `lifetime` varchar(64) NOT NULL DEFAULT '30',
  PRIMARY KEY (`itemid`),
  UNIQUE KEY `items_1` (`hostid`,`key_`),
  KEY `items_3` (`status`),
  KEY `items_4` (`templateid`),
  KEY `items_5` (`valuemapid`),
  KEY `c_items_4` (`interfaceid`),
  CONSTRAINT `c_items_4` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`),
  CONSTRAINT `c_items_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_2` FOREIGN KEY (`templateid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_3` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (10009,0,'','',10001,'Number of processes','proc.num[]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Total number of processes in any state.',0,'0'),(10010,0,'','',10001,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'0'),(10013,0,'','',10001,'Number of running processes','proc.num[,,run]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of processes in running state.',0,'0'),(10014,0,'','',10001,'Free swap space','system.swap.size[,free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(10016,0,'','',10001,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of users who are currently logged in.',0,'0'),(10019,0,'','',10001,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(10020,0,'','',10001,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(10025,0,'','',10001,'System uptime','system.uptime',600,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(10026,0,'','',10001,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(10030,0,'','',10001,'Total swap space','system.swap.size[,total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(10055,0,'','',10001,'Maximum number of processes','kernel.maxproc',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0'),(10056,0,'','',10001,'Maximum number of opened files','kernel.maxfiles',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0'),(10057,0,'','',10001,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','System host name.',3,'0'),(10058,0,'','',10001,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'0'),(10059,0,'','',10001,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(17318,0,'','',10001,'Host boot time','system.boottime',600,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(17350,0,'','',10001,'Free swap space in %','system.swap.size[,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(17352,0,'','',10001,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(17354,0,'','',10001,'CPU $2 time','system.cpu.util[,idle]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'0'),(17356,0,'','',10001,'CPU $2 time','system.cpu.util[,user]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'0'),(17358,0,'','',10001,'CPU $2 time','system.cpu.util[,nice]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' proccess that have been niced.',0,'0'),(17360,0,'','',10001,'CPU $2 time','system.cpu.util[,system]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'0'),(17362,0,'','',10001,'CPU $2 time','system.cpu.util[,iowait]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Amount of time the CPU has been waiting for I/O to complete.',0,'0'),(22181,0,'','',10001,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'0'),(22183,5,'','',10047,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22185,5,'','',10047,'Zabbix $2 write cache, % free','zabbix[wcache,trend,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22187,5,'','',10047,'Values processed by Zabbix server per second','zabbix[wcache,values]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22189,5,'','',10047,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22219,5,'','',10047,'Zabbix queue over $2','zabbix[queue,10m]',600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22231,0,'','',10050,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22232,0,'','',10050,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(22396,5,'','',10047,'Zabbix $2 write cache, % free','zabbix[wcache,text,pfree]',60,7,365,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22399,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'localhost','%',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22400,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22402,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22404,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22406,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22408,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22410,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,db watchdog,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22412,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22414,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22416,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22418,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22420,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,proxy poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22422,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,escalator,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22424,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,alerter,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22426,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,timer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22428,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,node watcher,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22430,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'localhost','%',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22444,0,'','',10001,'Network interface discovery','net.if.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30'),(22446,0,'','',10001,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22448,0,'','',10001,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22450,0,'','',10001,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(22452,0,'','',10001,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22454,0,'','',10001,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22456,0,'','',10001,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22458,0,'','',10001,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22548,3,'','',10056,'SMTP service is running','net.tcp.service[smtp]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22549,3,'','',10056,'POP3 service is running','net.tcp.service[pop]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22550,3,'','',10056,'IMAP service is running','net.tcp.service[imap]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22551,3,'','',10056,'HTTP service is running','net.tcp.service[http]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22552,3,'','',10056,'FTP service is running','net.tcp.service[ftp]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22553,3,'','',10056,'NNTP service is running','net.tcp.service[nntp]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22554,3,'','',10056,'ICMP ping response time','icmppingsec',60,7,365,NULL,NULL,NULL,0,0,'','s',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22665,0,'','',10001,'CPU $2 time','system.cpu.util[,steal]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The amount of CPU \'stolen\' from this virtual machine by the hypervisor for other tasks (such as running another virtual machine).',0,'0'),(22668,0,'','',10001,'CPU $2 time','system.cpu.util[,softirq]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The amount of time the CPU has been servicing software interrupts.',0,'0'),(22671,0,'','',10001,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The amount of time the CPU has been servicing hardware interrupts.',0,'0'),(22674,0,'','',10001,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'0'),(22677,0,'','',10001,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'0'),(22680,0,'','',10001,'Context switches per second','system.cpu.switches',60,7,365,NULL,NULL,NULL,0,3,'','sps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22683,0,'','',10001,'Interrupts per second','system.cpu.intr',60,7,365,NULL,NULL,NULL,0,3,'','ips',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22686,0,'','',10001,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22689,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22691,3,'','',10056,'SSH service is running','net.tcp.service[ssh]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22692,3,'','',10056,'NTP service is running','net.tcp.service[ntp]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22694,3,'','',10056,'LDAP service is running','net.tcp.service[ldap]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22696,3,'','',10056,'HTTPS service is running','net.tcp.service[https]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22698,3,'','',10056,'Telnet service is running','net.tcp.service[telnet]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22700,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10060,'Network interfaces','ifDescr',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22701,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10060,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0'),(22702,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10060,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0'),(22703,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10060,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0'),(22704,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10060,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,8,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The current operational state of the interface.',0,'0'),(22705,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10060,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,11,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The desired state of the interface.',0,'0'),(22706,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10060,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0'),(22707,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10060,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0'),(22708,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10060,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22709,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10060,'Number of network interfaces','ifNumber',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0'),(22710,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10065,'Device description','sysDescr',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0'),(22711,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10065,'Device name','sysName',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0'),(22712,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10065,'Device location','sysLocation',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0'),(22713,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10065,'Device contact details','sysContact',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0'),(22714,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10065,'Device uptime','sysUpTime',60,7,365,NULL,NULL,NULL,0,3,'','uptime',1,0,NULL,'',0,'','','0.01','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0'),(22715,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10066,'Device contact details','sysContact',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22713,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0'),(22716,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10066,'Device description','sysDescr',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22710,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0'),(22717,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10066,'Device location','sysLocation',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22712,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0'),(22718,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10066,'Device name','sysName',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22711,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0'),(22719,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10066,'Device uptime','sysUpTime',60,7,365,NULL,NULL,NULL,0,3,'','uptime',1,0,NULL,'',0,'','','0.01','',0,'',22714,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0'),(22720,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10066,'Network interfaces','ifDescr',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22700,NULL,'','','',0,0,'','','','',0,NULL,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22721,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10066,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22705,11,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The desired state of the interface.',0,'0'),(22722,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10066,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22708,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22723,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10066,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22703,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0'),(22724,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10066,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',22706,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0'),(22725,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10066,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22701,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0'),(22726,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10066,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22704,8,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The current operational state of the interface.',0,'0'),(22727,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10066,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',22707,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0'),(22728,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10066,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22702,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0'),(22729,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10066,'Number of network interfaces','ifNumber',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22709,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0'),(22730,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10067,'Device contact details','sysContact',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22713,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0'),(22731,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10067,'Device description','sysDescr',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22710,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0'),(22732,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10067,'Device location','sysLocation',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22712,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0'),(22733,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10067,'Device name','sysName',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22711,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0'),(22734,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10067,'Device uptime','sysUpTime',60,7,365,NULL,NULL,NULL,0,3,'','uptime',1,0,NULL,'',0,'','','0.01','',0,'',22714,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0'),(22735,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10067,'Network interfaces','ifDescr',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22700,NULL,'','','',0,0,'','','','',0,NULL,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22736,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10067,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22705,11,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The desired state of the interface.',0,'0'),(22737,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10067,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22708,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22738,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10067,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22703,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0'),(22739,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10067,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',22706,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0'),(22740,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10067,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22701,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0'),(22741,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10067,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22704,8,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The current operational state of the interface.',0,'0'),(22742,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10067,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',22707,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0'),(22743,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10067,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22702,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0'),(22744,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10067,'Number of network interfaces','ifNumber',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22709,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0'),(22746,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr',10068,'Disk partitions','hrStorageDescr',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#SNMPVALUE}:@Storage devices for SNMP discovery',NULL,'','The rule will discover all dis partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22749,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10068,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','A description of the type and instance of the storage described by this entry.',0,'0'),(22755,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10068,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'0'),(22756,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10068,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','units',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'0'),(22757,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10068,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','units',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'0'),(22758,15,'','',10068,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,NULL,2,'',NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'0'),(22759,15,'','',10068,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,NULL,2,'',NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'0'),(22760,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr',10067,'Disk partitions','hrStorageDescr',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22746,NULL,'','','',0,0,'','','','',0,NULL,1,'{#SNMPVALUE}:@Storage devices for SNMP discovery',NULL,'','The rule will discover all dis partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22761,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10067,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22755,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'0'),(22762,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10067,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22749,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','A description of the type and instance of the storage described by this entry.',0,'0'),(22763,15,'','',10067,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22758,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,NULL,2,'',NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'0'),(22764,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10067,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','units',0,0,NULL,'',0,'','','1','',0,'',22756,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'0'),(22765,15,'','',10067,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22759,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,NULL,2,'',NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'0'),(22766,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10067,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','units',0,0,NULL,'',0,'','','1','',0,'',22757,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'0'),(22767,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr',10069,'Disk partitions','hrStorageDescr',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22746,NULL,'','','',0,0,'','','','',0,NULL,1,'{#SNMPVALUE}:@Storage devices for SNMP discovery',NULL,'','The rule will discover all dis partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22768,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10069,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22755,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'0'),(22769,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10069,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22749,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','A description of the type and instance of the storage described by this entry.',0,'0'),(22770,15,'','',10069,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22758,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,NULL,2,'',NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'0'),(22771,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10069,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,3,'','units',0,0,NULL,'',0,'','','1','',0,'',22756,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'0'),(22772,15,'','',10069,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22759,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,NULL,2,'',NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'0'),(22773,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10069,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','units',0,0,NULL,'',0,'','','1','',0,'',22757,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'0'),(22774,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10069,'Device contact details','sysContact',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22713,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0'),(22775,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10069,'Device description','sysDescr',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22710,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0'),(22776,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10069,'Device location','sysLocation',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22712,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0'),(22777,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10069,'Device name','sysName',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22711,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0'),(22778,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10069,'Device uptime','sysUpTime',60,7,365,NULL,NULL,NULL,0,3,'','uptime',1,0,NULL,'',0,'','','0.01','',0,'',22714,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0'),(22779,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10069,'Network interfaces','ifDescr',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22700,NULL,'','','',0,0,'','','','',0,NULL,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22780,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10069,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22705,11,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The desired state of the interface.',0,'0'),(22781,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10069,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22708,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22782,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10069,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22703,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0'),(22783,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10069,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',22706,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0'),(22784,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10069,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22701,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0'),(22785,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10069,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22704,8,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The current operational state of the interface.',0,'0'),(22786,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10069,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','',0,1,NULL,'',0,'','','1','',0,'',22707,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0'),(22787,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10069,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22702,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0'),(22788,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10069,'Number of network interfaces','ifNumber',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22709,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0'),(22789,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad',10070,'Processors','hrProcessorLoad',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,':',NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22793,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10070,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,NULL,NULL,NULL,0,3,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'0'),(22796,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad',10069,'Processors','hrProcessorLoad',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22789,NULL,'','','',0,0,'','','','',0,NULL,1,':',NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22797,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10069,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,NULL,NULL,NULL,0,3,'','%',0,0,NULL,'',0,'','','1','',0,'',22793,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'0'),(22798,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad',10067,'Processors','hrProcessorLoad',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22789,NULL,'','','',0,0,'','','','',0,NULL,1,':',NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30'),(22799,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10067,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,NULL,NULL,NULL,0,3,'','%',0,0,NULL,'',0,'','','1','',0,'',22793,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'0'),(22800,12,'','',10071,'BB +1.8V SM','bb_1.8v_sm',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.8V SM',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22801,12,'','',10071,'BB +3.3V','bb_3.3v',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22802,12,'','',10071,'BB +3.3V STBY','bb_3.3v_stby',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V STBY',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22803,12,'','',10071,'BB +5.0V','bb_5.0v',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +5.0V',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22804,12,'','',10071,'BB Ambient Temp','bb_ambient_temp',60,7,365,NULL,NULL,NULL,0,0,'','C',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB Ambient Temp',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22805,12,'','',10071,'Power','power',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','power',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22806,12,'','',10071,'Processor Vcc','processor_vcc',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','Processor Vcc',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22807,12,'','',10071,'System Fan 3','system_fan_3',60,7,365,NULL,NULL,NULL,0,0,'','RPM',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 3',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22808,12,'','',10072,'Baseboard Temp','baseboard_temp',60,7,365,NULL,NULL,NULL,0,0,'','C',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','Baseboard Temp',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22809,12,'','',10072,'BB +1.05V PCH','bb_1.05v_pch',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.05V PCH',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22810,12,'','',10072,'BB +1.1V P1 Vccp','bb_1.1v_p1_vccp',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.1V P1 Vccp',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22811,12,'','',10072,'BB +1.5V P1 DDR3','bb_1.5v_p1_ddr3',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.5V P1 DDR3',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22812,12,'','',10072,'BB +3.3V','bb_3.3v',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22813,12,'','',10072,'BB +3.3V STBY','bb_3.3v_stby',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V STBY',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22814,12,'','',10072,'BB +5.0V','bb_5.0v',60,7,365,NULL,NULL,NULL,0,0,'','V',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','BB +5.0V',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22815,12,'','',10072,'Front Panel Temp','front_panel_temp',60,7,365,NULL,NULL,NULL,0,0,'','C',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','Front Panel Temp',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22816,12,'','',10072,'Power','power',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','power',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22817,12,'','',10072,'System Fan 2','system_fan_2',60,7,365,NULL,NULL,NULL,0,0,'','RPM',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 2',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22818,12,'','',10072,'System Fan 3','system_fan_3',60,7,365,NULL,NULL,NULL,0,0,'','RPM',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 3',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22819,0,'','',10073,'MySQL status','mysql.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.ping, which is defined in userparameter_mysql.conf\r\n\r\n0 - MySQL server is down\r\n1 - MySQL server is up',0,'30'),(22820,0,'','',10073,'MySQL uptime','mysql.status[Uptime]',60,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status, which is defined in userparameter_mysql.conf.',0,'30'),(22821,0,'','',10073,'MySQL version','mysql.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.uptime, which is defined in userparameter_mysql.conf.',0,'30'),(22822,0,'','',10073,'MySQL insert operations per second','mysql.status[Com_insert]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22823,0,'','',10073,'MySQL select operations per second','mysql.status[Com_select]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22824,0,'','',10073,'MySQL update operations per second','mysql.status[Com_update]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22825,0,'','',10073,'MySQL rollback operations per second','mysql.status[Com_rollback]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22826,0,'','',10073,'MySQL commit operations per second','mysql.status[Com_commit]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22827,0,'','',10073,'MySQL begin operations per second','mysql.status[Com_begin]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22828,0,'','',10073,'MySQL delete operations per second','mysql.status[Com_delete]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22829,0,'','',10073,'MySQL bytes sent per second','mysql.status[Bytes_sent]',60,7,365,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The number of bytes sent to all clients.\r\n\r\nIt requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22830,0,'','',10073,'MySQL bytes received per second','mysql.status[Bytes_received]',60,7,365,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The number of bytes received from all clients. \r\n\r\nIt requires user parameter mysql.status[*], which is defined in \r\nuserparameter_mysql.conf.',0,'30'),(22831,0,'','',10073,'MySQL queries per second','mysql.status[Questions]',60,7,365,NULL,NULL,NULL,0,0,'','qps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22832,0,'','',10073,'MySQL slow queries','mysql.status[Slow_queries]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30'),(22833,0,'','',10074,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(22834,0,'','',10074,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22835,0,'','',10074,'Maximum number of opened files','kernel.maxfiles',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30'),(22836,0,'','',10074,'Maximum number of processes','kernel.maxproc',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30'),(22837,0,'','',10074,'Number of running processes','proc.num[,,run]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of processes in running state.',0,'30'),(22838,0,'','',10074,'Number of processes','proc.num[]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Total number of processes in any state.',0,'30'),(22839,0,'','',10074,'Host boot time','system.boottime',600,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22840,0,'','',10074,'Interrupts per second','system.cpu.intr',60,7,365,NULL,NULL,NULL,0,3,'','ips',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22841,0,'','',10074,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22842,0,'','',10074,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22843,0,'','',10074,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22844,0,'','',10074,'Context switches per second','system.cpu.switches',60,7,365,NULL,NULL,NULL,0,3,'','sps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22845,0,'','',10074,'CPU $2 time','system.cpu.util[,idle]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30'),(22846,0,'','',10074,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The amount of time the CPU has been servicing hardware interrupts.',0,'30'),(22848,0,'','',10074,'CPU $2 time','system.cpu.util[,nice]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' proccess that have been niced.',0,'30'),(22851,0,'','',10074,'CPU $2 time','system.cpu.util[,system]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30'),(22852,0,'','',10074,'CPU $2 time','system.cpu.util[,user]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30'),(22853,0,'','',10074,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','System host name.',3,'30'),(22854,0,'','',10074,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22855,0,'','',10074,'Free swap space','system.swap.size[,free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22856,0,'','',10074,'Free swap space in %','system.swap.size[,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22857,0,'','',10074,'Total swap space','system.swap.size[,total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22858,0,'','',10074,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30'),(22859,0,'','',10074,'System uptime','system.uptime',600,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22860,0,'','',10074,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of users who are currently logged in.',0,'30'),(22861,0,'','',10074,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22862,0,'','',10074,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30'),(22863,0,'','',10074,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22867,0,'','',10074,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(22868,0,'','',10074,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22869,0,'','',10074,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22870,0,'','',10074,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22871,0,'','',10074,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22872,0,'','',10074,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22873,0,'','',10075,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(22874,0,'','',10075,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22875,0,'','',10075,'Maximum number of opened files','kernel.maxfiles',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30'),(22876,0,'','',10075,'Maximum number of processes','kernel.maxproc',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30'),(22877,0,'','',10075,'Number of running processes','proc.num[,,run]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of processes in running state.',0,'30'),(22878,0,'','',10075,'Number of processes','proc.num[]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Total number of processes in any state.',0,'30'),(22879,0,'','',10075,'Host boot time','system.boottime',600,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22880,0,'','',10075,'Interrupts per second','system.cpu.intr',60,7,365,NULL,NULL,NULL,0,3,'','ips',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22881,0,'','',10075,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22882,0,'','',10075,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22883,0,'','',10075,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22884,0,'','',10075,'Context switches per second','system.cpu.switches',60,7,365,NULL,NULL,NULL,0,3,'','sps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22885,0,'','',10075,'CPU $2 time','system.cpu.util[,idle]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30'),(22886,0,'','',10075,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The amount of time the CPU has been servicing hardware interrupts.',0,'30'),(22888,0,'','',10075,'CPU $2 time','system.cpu.util[,nice]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' proccess that have been niced.',0,'30'),(22891,0,'','',10075,'CPU $2 time','system.cpu.util[,system]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30'),(22892,0,'','',10075,'CPU $2 time','system.cpu.util[,user]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30'),(22893,0,'','',10075,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','System host name.',3,'30'),(22894,0,'','',10075,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22895,0,'','',10075,'Free swap space','system.swap.size[,free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22896,0,'','',10075,'Free swap space in %','system.swap.size[,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22897,0,'','',10075,'Total swap space','system.swap.size[,total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22898,0,'','',10075,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30'),(22899,0,'','',10075,'System uptime','system.uptime',600,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22900,0,'','',10075,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of users who are currently logged in.',0,'30'),(22901,0,'','',10075,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22902,0,'','',10075,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30'),(22903,0,'','',10075,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22907,0,'','',10075,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(22908,0,'','',10075,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22909,0,'','',10075,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22910,0,'','',10075,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22911,0,'','',10075,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22912,0,'','',10075,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22913,0,'','',10076,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(22914,0,'','',10076,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22917,0,'','',10076,'Number of running processes','proc.num[,,run]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of processes in running state.',0,'30'),(22918,0,'','',10076,'Number of processes','proc.num[]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Total number of processes in any state.',0,'30'),(22920,0,'','',10076,'Interrupts per second','system.cpu.intr',60,7,365,NULL,NULL,NULL,0,3,'','ips',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22921,0,'','',10076,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22922,0,'','',10076,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22923,0,'','',10076,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22924,0,'','',10076,'Context switches per second','system.cpu.switches',60,7,365,NULL,NULL,NULL,0,3,'','sps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22933,0,'','',10076,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','System host name.',3,'30'),(22934,0,'','',10076,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22938,0,'','',10076,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30'),(22939,0,'','',10076,'System uptime','system.uptime',600,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22940,0,'','',10076,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of users who are currently logged in.',0,'30'),(22941,0,'','',10076,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22942,0,'','',10076,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30'),(22943,0,'','',10076,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22944,0,'','',10076,'Network interface discovery','net.if.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30'),(22945,0,'','',10076,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22946,0,'','',10076,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22947,0,'','',10076,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(22948,0,'','',10076,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22949,0,'','',10076,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22950,0,'','',10076,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22951,0,'','',10076,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22952,0,'','',10076,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22953,0,'','',10077,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(22954,0,'','',10077,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22961,0,'','',10077,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22962,0,'','',10077,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22963,0,'','',10077,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(22965,0,'','',10077,'CPU $2 time','system.cpu.util[,idle]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30'),(22968,0,'','',10077,'CPU $2 time','system.cpu.util[,nice]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' proccess that have been niced.',0,'30'),(22971,0,'','',10077,'CPU $2 time','system.cpu.util[,system]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30'),(22972,0,'','',10077,'CPU $2 time','system.cpu.util[,user]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30'),(22973,0,'','',10077,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','System host name.',3,'30'),(22974,0,'','',10077,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22978,0,'','',10077,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30'),(22980,0,'','',10077,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of users who are currently logged in.',0,'30'),(22981,0,'','',10077,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22982,0,'','',10077,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30'),(22983,0,'','',10077,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(22984,0,'','',10077,'Network interface discovery','net.if.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30'),(22985,0,'','',10077,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22986,0,'','',10077,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22987,0,'','',10077,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(22988,0,'','',10077,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22989,0,'','',10077,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22990,0,'','',10077,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22991,0,'','',10077,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22992,0,'','',10077,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(22993,0,'','',10078,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(22994,0,'','',10078,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(22996,0,'','',10078,'Maximum number of processes','kernel.maxproc',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30'),(22997,0,'','',10078,'Number of running processes','proc.num[,,run]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of processes in running state.',0,'30'),(22998,0,'','',10078,'Number of processes','proc.num[]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Total number of processes in any state.',0,'30'),(22999,0,'','',10078,'Host boot time','system.boottime',600,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23000,0,'','',10078,'Interrupts per second','system.cpu.intr',60,7,365,NULL,NULL,NULL,0,3,'','ips',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23001,0,'','',10078,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(23002,0,'','',10078,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(23003,0,'','',10078,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(23004,0,'','',10078,'Context switches per second','system.cpu.switches',60,7,365,NULL,NULL,NULL,0,3,'','sps',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23005,0,'','',10078,'CPU $2 time','system.cpu.util[,idle]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30'),(23007,0,'','',10078,'CPU $2 time','system.cpu.util[,iowait]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Amount of time the CPU has been waiting for I/O to complete.',0,'30'),(23011,0,'','',10078,'CPU $2 time','system.cpu.util[,system]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30'),(23012,0,'','',10078,'CPU $2 time','system.cpu.util[,user]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30'),(23013,0,'','',10078,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','System host name.',3,'30'),(23014,0,'','',10078,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23015,0,'','',10078,'Free swap space','system.swap.size[,free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23016,0,'','',10078,'Free swap space in %','system.swap.size[,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23017,0,'','',10078,'Total swap space','system.swap.size[,total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23018,0,'','',10078,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30'),(23019,0,'','',10078,'System uptime','system.uptime',600,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23020,0,'','',10078,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of users who are currently logged in.',0,'30'),(23021,0,'','',10078,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23022,0,'','',10078,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30'),(23023,0,'','',10078,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23024,0,'','',10078,'Network interface discovery','net.if.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30'),(23025,0,'','',10078,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23026,0,'','',10078,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23027,0,'','',10078,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(23028,0,'','',10078,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23029,0,'','',10078,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23030,0,'','',10078,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23031,0,'','',10078,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23032,0,'','',10078,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23033,0,'','',10079,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(23034,0,'','',10079,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23035,0,'','',10079,'Maximum number of opened files','kernel.maxfiles',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30'),(23036,0,'','',10079,'Maximum number of processes','kernel.maxproc',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30'),(23039,0,'','',10079,'Host boot time','system.boottime',600,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23041,0,'','',10079,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(23042,0,'','',10079,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(23043,0,'','',10079,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'30'),(23053,0,'','',10079,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','System host name.',3,'30'),(23054,0,'','',10079,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23058,0,'','',10079,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30'),(23059,0,'','',10079,'System uptime','system.uptime',600,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23060,0,'','',10079,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Number of users who are currently logged in.',0,'30'),(23061,0,'','',10079,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23062,0,'','',10079,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30'),(23063,0,'','',10079,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23067,0,'','',10079,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(23068,0,'','',10079,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23069,0,'','',10079,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23070,0,'','',10079,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23071,0,'','',10079,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23072,0,'','',10079,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'0'),(23073,0,'','',10075,'Incoming network traffic on $1','net.if.in[em0]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23074,0,'','',10075,'Outgoing network traffic on $1','net.if.out[em0]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23075,0,'','',10074,'Incoming network traffic on $1','net.if.in[vic0]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23076,0,'','',10074,'Outgoing network traffic on $1','net.if.out[vic0]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23077,0,'','',10079,'Incoming network traffic on $1','net.if.in[en0]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23078,0,'','',10079,'Outgoing network traffic on $1','net.if.out[en0]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23108,0,'','',10076,'CPU available physical processors in the shared pool','system.stat[cpu,app]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23109,0,'','',10076,'CPU entitled capacity consumed','system.stat[cpu,ec]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23110,0,'','',10076,'CPU idle time','system.stat[cpu,id]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23111,0,'','',10076,'CPU logical processor utilization','system.stat[cpu,lbusy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23112,0,'','',10076,'CPU number of physical processors consumed','system.stat[cpu,pc]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23113,0,'','',10076,'CPU system time','system.stat[cpu,sy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23114,0,'','',10076,'CPU user time','system.stat[cpu,us]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23115,0,'','',10076,'CPU iowait time','system.stat[cpu,wa]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23116,0,'','',10076,'Amount of data transferred','system.stat[disk,bps]',60,7,365,NULL,NULL,NULL,0,0,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23117,0,'','',10076,'Number of transfers','system.stat[disk,tps]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23118,0,'','',10076,'Processor units is entitled to receive','system.stat[ent]',3600,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23119,0,'','',10076,'Kernel thread context switches','system.stat[faults,cs]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23120,0,'','',10076,'Device interrupts','system.stat[faults,in]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23121,0,'','',10076,'System calls','system.stat[faults,sy]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23122,0,'','',10076,'Length of the swap queue','system.stat[kthr,b]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23123,0,'','',10076,'Length of the run queue','system.stat[kthr,r]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23124,0,'','',10076,'Active virtual pages','system.stat[memory,avm]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23125,0,'','',10076,'Free real memory','system.stat[memory,fre]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23126,0,'','',10076,'File page-ins per second','system.stat[page,fi]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23127,0,'','',10076,'File page-outs per second','system.stat[page,fo]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23128,0,'','',10076,'Pages freed (page replacement)','system.stat[page,fr]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23129,0,'','',10076,'Pages paged in from paging space','system.stat[page,pi]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23130,0,'','',10076,'Pages paged out to paging space','system.stat[page,po]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23131,0,'','',10076,'Pages scanned by page-replacement algorithm','system.stat[page,sr]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23134,0,'','',10081,'Average disk read queue length','perf_counter[\\234(_Total)\\1402]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Full counter name: \\PhysicalDisk(_Total)\\Avg. Disk Read Queue Length',0,'30'),(23135,0,'','',10081,'Average disk write queue length','perf_counter[\\234(_Total)\\1404]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Full counter name: \\PhysicalDisk(_Total)\\Avg. Disk Write Queue Length',0,'30'),(23136,0,'','',10081,'File read bytes per second','perf_counter[\\2\\16]',60,7,365,NULL,NULL,NULL,0,0,'','Bps',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Full counter name: \\System\\File Read Bytes/sec',0,'30'),(23137,0,'','',10081,'File write bytes per second','perf_counter[\\2\\18]',60,7,365,NULL,NULL,NULL,0,0,'','Bps',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Full counter name: \\System\\File Write Bytes/sec',0,'30'),(23138,0,'','',10081,'Number of threads','perf_counter[\\2\\250]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','Full counter name: \\System\\Threads',0,'30'),(23140,0,'','',10081,'Number of processes','proc.num[]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23143,0,'','',10081,'Processor load (1 min average)','system.cpu.load[,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23144,0,'','',10081,'Processor load (15 min average)','system.cpu.load[,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23145,0,'','',10081,'Processor load (5 min average)','system.cpu.load[,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23147,0,'','',10081,'Free swap space','system.swap.size[,free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23148,0,'','',10081,'Total swap space','system.swap.size[,total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23149,0,'','',10081,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',5,'30'),(23150,0,'','',10081,'System uptime','system.uptime',60,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23158,0,'','',10081,'Free memory','vm.memory.size[free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23159,0,'','',10081,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23160,0,'','',10081,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(23161,0,'','',10081,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23162,0,'','',10081,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(23163,0,'','',10081,'Network interface discovery','net.if.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30'),(23164,0,'','',10081,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'30'),(23165,0,'','',10081,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'30'),(23167,0,'','',10081,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'30'),(23168,0,'','',10081,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'30'),(23169,0,'','',10081,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'30'),(23170,0,'','',10081,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,2,'',NULL,'','',0,'30'),(23171,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23172,16,'','',10082,'Accumulated time spent in compilation','jmx[\"java.lang:type=Compilation\",TotalCompilationTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.0001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23173,16,'','',10082,'cl Loaded Class Count','jmx[\"java.lang:type=ClassLoading\",LoadedClassCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23174,16,'','',10082,'cl Total Loaded Class Count','jmx[\"java.lang:type=ClassLoading\",TotalLoadedClassCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23175,16,'','',10082,'cl Unloaded Class Count','jmx[\"java.lang:type=ClassLoading\",UnloadedClassCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23176,16,'','',10082,'gc ConcurrentMarkSweep accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=ConcurrentMarkSweep\",CollectionTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23177,16,'','',10082,'gc ConcurrentMarkSweep number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=ConcurrentMarkSweep\",CollectionCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23178,16,'','',10082,'gc Copy accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=Copy\",CollectionTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23179,16,'','',10082,'gc Copy number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=Copy\",CollectionCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23180,16,'','',10082,'gc MarkSweepCompact accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=MarkSweepCompact\",CollectionTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23181,16,'','',10082,'gc MarkSweepCompact number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=MarkSweepCompact\",CollectionCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23182,16,'','',10082,'gc ParNew accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=ParNew\",CollectionTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23183,16,'','',10082,'gc ParNew number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=ParNew\",CollectionCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23184,16,'','',10082,'gc PS MarkSweep accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=PS MarkSweep\",CollectionTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23185,16,'','',10082,'gc PS Scavenge accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=PS Scavenge\",CollectionTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23186,16,'','',10082,'gc PS Scavenge number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=PS Scavenge\",CollectionCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23187,16,'','',10082,'gs PS MarkSweep number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=PS MarkSweep\",CollectionCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23188,16,'','',10082,'jvm Uptime','jmx[\"java.lang:type=Runtime\",Uptime]',60,7,365,NULL,NULL,NULL,0,0,'','uptime',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23189,16,'','',10082,'jvm Version','jmx[\"java.lang:type=Runtime\",VmVersion]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23190,16,'','',10082,'mem Object Pending Finalization Count','jmx[\"java.lang:type=Memory\",ObjectPendingFinalizationCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23191,16,'','',10082,'mp CMS Old Gen committed','jmx[\"java.lang:type=MemoryPool,name=CMS Old Gen\",Usage.committed]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23192,16,'','',10082,'mp CMS Old Gen max','jmx[\"java.lang:type=MemoryPool,name=CMS Old Gen\",Usage.max]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23193,16,'','',10082,'mp CMS Old Gen used','jmx[\"java.lang:type=MemoryPool,name=CMS Old Gen\",Usage.used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23194,16,'','',10082,'mp CMS Perm Gen committed','jmx[\"java.lang:type=MemoryPool,name=CMS Perm Gen\",Usage.committed]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23195,16,'','',10082,'mp CMS Perm Gen max','jmx[\"java.lang:type=MemoryPool,name=CMS Perm Gen\",Usage.max]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23196,16,'','',10082,'mp CMS Perm Gen used','jmx[\"java.lang:type=MemoryPool,name=CMS Perm Gen\",Usage.used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23197,16,'','',10082,'mp Code Cache committed','jmx[\"java.lang:type=MemoryPool,name=Code Cache\",Usage.committed]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23198,16,'','',10082,'mp Code Cache max','jmx[\"java.lang:type=MemoryPool,name=Code Cache\",Usage.max]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23199,16,'','',10082,'mp Code Cache used','jmx[\"java.lang:type=MemoryPool,name=Code Cache\",Usage.used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23200,16,'','',10082,'mp Perm Gen committed','jmx[\"java.lang:type=MemoryPool,name=Perm Gen\",Usage.committed]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23201,16,'','',10082,'mp Perm Gen max','jmx[\"java.lang:type=MemoryPool,name=Perm Gen\",Usage.max]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23202,16,'','',10082,'mp Perm Gen used','jmx[\"java.lang:type=MemoryPool,name=Perm Gen\",Usage.used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23203,16,'','',10082,'mp PS Old Gen committed','jmx[\"java.lang:type=MemoryPool,name=PS Old Gen\",Usage.committed]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23204,16,'','',10082,'mp PS Old Gen max','jmx[\"java.lang:type=MemoryPool,name=PS Old Gen\",Usage.max]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23205,16,'','',10082,'mp PS Old Gen used','jmx[\"java.lang:type=MemoryPool,name=PS Old Gen\",Usage.used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23206,16,'','',10082,'mp PS Perm Gen committed','jmx[\"java.lang:type=MemoryPool,name=PS Perm Gen\",Usage.committed]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23207,16,'','',10082,'mp PS Perm Gen max','jmx[\"java.lang:type=MemoryPool,name=PS Perm Gen\",Usage.max]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23208,16,'','',10082,'mp PS Perm Gen used','jmx[\"java.lang:type=MemoryPool,name=PS Perm Gen\",Usage.used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23209,16,'','',10082,'mp Tenured Gen committed','jmx[\"java.lang:type=MemoryPool,name=Tenured Gen\",Usage.committed]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23210,16,'','',10082,'mp Tenured Gen max','jmx[\"java.lang:type=MemoryPool,name=Tenured Gen\",Usage.max]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23211,16,'','',10082,'mpTenured Gen used','jmx[\"java.lang:type=MemoryPool,name=Tenured Gen\",Usage.used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23212,16,'','',10082,'Name of the current compiler','jmx[\"java.lang:type=Compilation\",Name]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23213,16,'','',10082,'os Max File Descriptor Count','jmx[\"java.lang:type=OperatingSystem\",MaxFileDescriptorCount]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23214,16,'','',10082,'os Open File Descriptor Count','jmx[\"java.lang:type=OperatingSystem\",OpenFileDescriptorCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23215,16,'','',10082,'th Daemon Thread Count','jmx[\"java.lang:type=Threading\",DaemonThreadCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23216,16,'','',10082,'th Peak Thread Count','jmx[\"java.lang:type=Threading\",PeakThreadCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23217,16,'','',10082,'th Thread Count','jmx[\"java.lang:type=Threading\",ThreadCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23218,16,'','',10082,'th Total Started Thread Count','jmx[\"java.lang:type=Threading\",TotalStartedThreadCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23219,16,'','',10083,'http-8080 bytes received per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",bytesReceived]',60,7,365,NULL,NULL,NULL,0,0,'','B',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23220,16,'','',10083,'http-8080 bytes sent per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",bytesSent]',60,7,365,NULL,NULL,NULL,0,0,'','B',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23221,16,'','',10083,'http-8080 errors per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",errorCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23222,16,'','',10083,'http-8080 gzip compression','jmx[\"Catalina:type=ProtocolHandler,port=8080\",compression]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23223,16,'','',10083,'http-8080 request processing time','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",processingTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23224,16,'','',10083,'http-8080 requests per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",requestCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23225,16,'','',10083,'http-8080 threads allocated','jmx[\"Catalina:type=ThreadPool,name=http-8080\",currentThreadCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23226,16,'','',10083,'http-8080 threads busy','jmx[\"Catalina:type=ThreadPool,name=http-8080\",currentThreadsBusy]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23227,16,'','',10083,'http-8080 threads max','jmx[\"Catalina:type=ThreadPool,name=http-8080\",maxThreads]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23228,16,'','',10083,'http-8443 bytes received per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",bytesReceived]',60,7,365,NULL,NULL,NULL,0,0,'','B',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23229,16,'','',10083,'http-8443 bytes sent per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\", bytesSent]',60,7,365,NULL,NULL,NULL,0,0,'','B',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23230,16,'','',10083,'http-8443 errors per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",errorCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23231,16,'','',10083,'http-8443 gzip compression','jmx[\"Catalina:type=ProtocolHandler,port=8443\",compression]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23232,16,'','',10083,'http-8443 request processing time','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",processingTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23233,16,'','',10083,'http-8443 requests per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",requestCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23234,16,'','',10083,'http-8443 threads allocated','jmx[\"Catalina:type=ThreadPool,name=http-8443\",currentThreadCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23235,16,'','',10083,'http-8443 threads busy','jmx[\"Catalina:type=ThreadPool,name=http-8443\",currentThreadsBusy]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23236,16,'','',10083,'http-8443 threads max','jmx[\"Catalina:type=ThreadPool,name=http-8443\",maxThreads]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23237,16,'','',10083,'jk-8009 bytes received per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\", bytesReceived]',60,7,365,NULL,NULL,NULL,0,0,'','B',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23238,16,'','',10083,'jk-8009 bytes sent per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",bytesSent]',60,7,365,NULL,NULL,NULL,0,0,'','B',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23239,16,'','',10083,'jk-8009 errors per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",errorCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23240,16,'','',10083,'jk-8009 request processing time','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",processingTime]',60,7,365,NULL,NULL,NULL,0,0,'','s',1,0,NULL,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23241,16,'','',10083,'jk-8009 requests per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",requestCount]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23242,16,'','',10083,'jk-8009 threads allocated','jmx[\"Catalina:type=ThreadPool,name=jk-8009\",currentThreadCount]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23243,16,'','',10083,'jk-8009 threads busy','jmx[\"Catalina:type=ThreadPool,name=jk-8009\",currentThreadsBusy]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23244,16,'','',10083,'jk-8009 threads max','jmx[\"Catalina:type=ThreadPool,name=jk-8009\",maxThreads]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23245,16,'','',10083,'Maximum number of active sessions so far','jmx[\"Catalina:type=Manager,path=/,host=localhost\",maxActive]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23246,16,'','',10083,'Number of active sessions at this moment','jmx[\"Catalina:type=Manager,path=/,host=localhost\",activeSessions]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23247,16,'','',10083,'Number of sessions created by this manager per second','jmx[\"Catalina:type=Manager,path=/,host=localhost\",sessionCounter]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23248,16,'','',10083,'Number of sessions we rejected due to maxActive beeing reached','jmx[\"Catalina:type=Manager,path=/,host=localhost\",rejectedSessions]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23249,16,'','',10083,'The maximum number of active Sessions allowed, or -1 for no limit','jmx[\"Catalina:type=Manager,path=/,host=localhost\",maxActiveSessions]',3600,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23250,16,'','',10083,'Tomcat version','jmx[\"Catalina:type=Server\",serverInfo]',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23251,5,'','',10047,'Zabbix queue','zabbix[queue]',600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23252,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,alerter,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22424,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23253,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22412,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23254,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,db watchdog,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22410,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23255,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'localhost','%',0,0,NULL,'',0,'','','0','',0,'',22430,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23256,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,escalator,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22422,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23257,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22406,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23258,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22408,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23259,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22402,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23260,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22418,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23261,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22416,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23262,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22689,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23263,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,node watcher,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22428,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23264,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'localhost','%',0,0,NULL,'',0,'','','0','',0,'',22399,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23265,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,proxy poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22420,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23266,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22414,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23267,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',23171,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23268,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,timer,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22426,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23269,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22404,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23270,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22400,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23271,5,'','',10084,'Zabbix queue over $2','zabbix[queue,10m]',600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',22219,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23272,5,'','',10084,'Zabbix queue','zabbix[queue]',600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',23251,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23273,5,'','',10084,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',22189,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23274,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',22183,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23275,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,text,pfree]',60,7,365,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',22396,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23276,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,trend,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',22185,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23277,5,'','',10084,'Values processed by Zabbix server per second','zabbix[wcache,values]',60,7,365,NULL,NULL,NULL,0,0,'','',0,1,NULL,'',0,'','','1','',0,'',22187,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'0'),(23278,0,'','',10084,'Network interface discovery','net.if.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22444,NULL,'','','',0,0,'','','','',0,NULL,1,'{#IFNAME}:@Network interfaces for discovery',1,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30'),(23279,0,'','',10084,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,NULL,NULL,NULL,0,4,'','',0,0,NULL,'',0,'','','1','',0,'',22450,NULL,'','','',0,0,'','','','',0,NULL,1,'{#FSTYPE}:@File systems for discovery',1,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30'),(23280,0,'','',10084,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22446,NULL,'','','',0,0,'','','','',0,NULL,2,'',1,'','',0,'0'),(23281,0,'','',10084,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,NULL,NULL,NULL,0,3,'','bps',1,1,NULL,'',0,'','','8','',0,'',22448,NULL,'','','',0,0,'','','','',0,NULL,2,'',1,'','',0,'0'),(23282,0,'','',10084,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22454,NULL,'','','',0,0,'','','','',0,NULL,2,'',1,'','',0,'0'),(23283,0,'','',10084,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22452,NULL,'','','',0,0,'','','','',0,NULL,2,'',1,'','',0,'0'),(23284,0,'','',10084,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22686,NULL,'','','',0,0,'','','','',0,NULL,2,'',1,'','',0,'0'),(23285,0,'','',10084,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22456,NULL,'','','',0,0,'','','','',0,NULL,2,'',1,'','',0,'0'),(23286,0,'','',10084,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22458,NULL,'','','',0,0,'','','','',0,NULL,2,'',1,'','',0,'0'),(23287,0,'','',10084,'Agent ping','agent.ping',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',10020,10,'','','',0,0,'','','','',0,NULL,0,'',1,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0'),(23288,0,'','',10084,'Version of zabbix_agent(d) running','agent.version',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',10059,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23289,0,'','',10084,'Maximum number of opened files','kernel.maxfiles',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',10056,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0'),(23290,0,'','',10084,'Maximum number of processes','kernel.maxproc',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',10055,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0'),(23291,0,'','',10084,'Number of running processes','proc.num[,,run]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',10013,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','Number of processes in running state.',0,'0'),(23292,0,'','',10084,'Number of processes','proc.num[]',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',10009,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','Total number of processes in any state.',0,'0'),(23293,0,'','',10084,'Host boot time','system.boottime',600,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',17318,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23294,0,'','',10084,'Interrupts per second','system.cpu.intr',60,7,365,NULL,NULL,NULL,0,3,'','ips',0,1,NULL,'',0,'','','1','',0,'',22683,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23295,0,'','',10084,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',22677,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'0'),(23296,0,'','',10084,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',10010,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'0'),(23297,0,'','',10084,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',22674,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The processor load is calculates as system CPU load divided by number of CPU cores.',0,'0'),(23298,0,'','',10084,'Context switches per second','system.cpu.switches',60,7,365,NULL,NULL,NULL,0,3,'','sps',0,1,NULL,'',0,'','','1','',0,'',22680,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23299,0,'','',10084,'CPU $2 time','system.cpu.util[,idle]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',17354,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The time the CPU has spent doing nothing.',0,'0'),(23300,0,'','',10084,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22671,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The amount of time the CPU has been servicing hardware interrupts.',0,'0'),(23301,0,'','',10084,'CPU $2 time','system.cpu.util[,iowait]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',17362,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','Amount of time the CPU has been waiting for I/O to complete.',0,'0'),(23302,0,'','',10084,'CPU $2 time','system.cpu.util[,nice]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',17358,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The time the CPU has spent running users\' proccess that have been niced.',0,'0'),(23303,0,'','',10084,'CPU $2 time','system.cpu.util[,softirq]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22668,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The amount of time the CPU has been servicing software interrupts.',0,'0'),(23304,0,'','',10084,'CPU $2 time','system.cpu.util[,steal]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',22665,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The amount of CPU \'stolen\' from this virtual machine by the hypervisor for other tasks (such as running another virtual machine).',0,'0'),(23305,0,'','',10084,'CPU $2 time','system.cpu.util[,system]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',17360,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The time the CPU has spent running the kernel and its processes.',0,'0'),(23306,0,'','',10084,'CPU $2 time','system.cpu.util[,user]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',17356,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The time the CPU has spent running users\' processes that are not niced.',0,'0'),(23307,0,'','',10084,'Host name','system.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',10057,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','System host name.',3,'0'),(23308,0,'','',10084,'Host local time','system.localtime',60,7,365,NULL,NULL,NULL,0,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',17352,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23309,0,'','',10084,'Free swap space','system.swap.size[,free]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',10014,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23310,0,'','',10084,'Free swap space in %','system.swap.size[,pfree]',60,7,365,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',17350,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23311,0,'','',10084,'Total swap space','system.swap.size[,total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',10030,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23312,0,'','',10084,'System information','system.uname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',10058,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','The information as normally returned by \'uname -a\'.',5,'0'),(23313,0,'','',10084,'System uptime','system.uptime',600,7,365,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','1','',0,'',10025,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23314,0,'','',10084,'Number of logged in users','system.users.num',60,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',10016,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','Number of users who are currently logged in.',0,'0'),(23315,0,'','',10084,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',10019,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23316,0,'','',10084,'Available memory','vm.memory.size[available]',60,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','1','',0,'',22181,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','Available memory is defined as free+cached+buffers memory.',0,'0'),(23317,0,'','',10084,'Total memory','vm.memory.size[total]',3600,7,365,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',10026,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'0'),(23318,0,'','',10050,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23319,0,'','',10001,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23320,0,'','',10074,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23321,0,'','',10075,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23322,0,'','',10076,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23323,0,'','',10077,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23324,0,'','',10078,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23325,0,'','',10079,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23326,0,'','',10081,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23327,0,'','',10084,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',23319,NULL,'','','',0,0,'','','','',0,NULL,0,'',1,'','',0,'30'),(23328,7,'','',10085,'Processes current','proc.num[]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23329,7,'','',10085,'Processor load avg1','system.cpu.load[,avg1]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23330,7,'','',10085,'Processor load avg15','system.cpu.load[,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23331,7,'','',10085,'Processor count','system.cpu.num',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23332,7,'','',10085,'Swap total','system.swap.size[,total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23333,7,'','',10085,'Swap used','system.swap.size[,used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23334,7,'','',10085,'Memory free','vm.memory.size[free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23335,7,'','',10085,'Memory total','vm.memory.size[total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23336,7,'','',10086,'Processes current','proc.num[]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23328,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23337,7,'','',10086,'Processor load avg15','system.cpu.load[,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',23330,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23338,7,'','',10086,'Processor load avg1','system.cpu.load[,avg1]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23329,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23339,7,'','',10086,'Processor count','system.cpu.num',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23331,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23340,7,'','',10086,'Swap total','system.swap.size[,total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23332,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23341,7,'','',10086,'Swap used','system.swap.size[,used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23333,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23342,7,'','',10086,'Memory free','vm.memory.size[free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23334,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23343,7,'','',10086,'Memory total','vm.memory.size[total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23335,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23344,7,'','',10086,'Processes maximum','kernel.maxproc',3600,1,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23345,7,'','',10086,'Processes running','proc.num[,,run]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23346,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,idle,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23347,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,interrupt,avg15]',300,15,90,NULL,NULL,NULL,1,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23348,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,iowait,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23349,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,nice,avg15]',300,15,90,NULL,NULL,NULL,1,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23350,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,softirq,avg15]',300,15,90,NULL,NULL,NULL,1,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23351,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,steal,avg15]',300,15,90,NULL,NULL,NULL,1,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23352,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,system,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23353,7,'','',10086,'CPU $2 time ($3)','system.cpu.util[,user,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23354,7,'','',10086,'Memory $1','vm.memory.size[buffers]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23355,7,'','',10086,'Memory $1','vm.memory.size[cached]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23356,7,'','',10086,'Block In','zbr.vmstat.bi',300,15,90,NULL,NULL,NULL,0,0,'localhost','blocks/s',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23357,7,'','',10086,'Block Out','zbr.vmstat.bo',300,15,90,NULL,NULL,NULL,0,0,'localhost','blocks/s',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23358,7,'','',10086,'Swap In','zbr.vmstat.si',300,15,90,NULL,NULL,NULL,0,0,'localhost','pages/s',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23359,7,'','',10086,'Swap Out','zbr.vmstat.so',300,15,90,NULL,NULL,NULL,0,0,'localhost','pages/s',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23360,7,'','',10087,'Processes current','proc.num[]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23328,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23361,7,'','',10087,'Processor load avg15','system.cpu.load[,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',23330,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23362,7,'','',10087,'Processor load avg1','system.cpu.load[,avg1]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23329,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23363,7,'','',10087,'Processor count','system.cpu.num',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23331,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23364,7,'','',10087,'Swap total','system.swap.size[,total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23332,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23365,7,'','',10087,'Swap used','system.swap.size[,used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23333,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23366,7,'','',10087,'Memory free','vm.memory.size[free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23334,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23367,7,'','',10087,'Memory total','vm.memory.size[total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23335,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23368,7,'','',10087,'Processes maximum','kernel.maxproc',3600,1,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23369,7,'','',10087,'Processes running','proc.num[,,run]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23370,7,'','',10087,'CPU $2 time ($3)','system.cpu.util[,idle,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23371,7,'','',10087,'CPU $2 time ($3)','system.cpu.util[,system,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23372,7,'','',10087,'CPU $2 time ($3)','system.cpu.util[,user,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23373,7,'','',10087,'Memory $1','vm.memory.size[cached]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23374,7,'','',10088,'Incoming traffic on interface $1','net.if.in[{$IF0},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23375,7,'','',10088,'Outgoing traffic on interface $1','net.if.out[{$IF0},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23376,7,'','',10089,'Host uptime (in sec)','system.uptime',300,15,90,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23377,7,'','',10090,'Agent ping','agent.ping',300,15,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23378,7,'','',10090,'Version of zabbix_agent(d) running','agent.version',86400,90,90,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23379,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Waiting for Connection','query_apachestats.py[80 _]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23380,10,'','',10091,'Apache Stats - Busy Workers','query_apachestats.py[80 BusyWorkers]',300,15,90,NULL,NULL,NULL,1,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23381,10,'','',10091,'Apache Stats - BytesPerSec','query_apachestats.py[80 BytesPerSec]',300,15,90,NULL,NULL,NULL,1,0,'localhost','byte(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23382,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Closing Connection','query_apachestats.py[80 C]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23383,10,'','',10091,'Apache Stats - CPU Load','query_apachestats.py[80 CPULoad]',300,15,90,NULL,NULL,NULL,1,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23384,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - DNS Lookup','query_apachestats.py[80 D]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23385,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Gracefully finishing','query_apachestats.py[80 G]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23386,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Idle cleanup of worker','query_apachestats.py[80 I]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23387,10,'','',10091,'Apache Stats - Idle Workers','query_apachestats.py[80 IdleWorkers]',300,15,90,NULL,NULL,NULL,1,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23388,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Keepalive (read)','query_apachestats.py[80 K]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23389,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Logging','query_apachestats.py[80 L]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23390,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Reading Request','query_apachestats.py[80 R]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23391,10,'','',10091,'Apache Stats - ReqPerSec','query_apachestats.py[80 ReqPerSec]',300,15,90,NULL,NULL,NULL,1,0,'localhost','request(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23392,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Starting Up','query_apachestats.py[80 S]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23393,10,'','',10091,'Apache Stats - Total Accesses','query_apachestats.py[80 TotalAccesses]',300,15,90,NULL,NULL,NULL,1,3,'localhost','request(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23394,10,'','',10091,'Apache Stats - Total kBytes','query_apachestats.py[80 TotalkBytes]',300,15,90,NULL,NULL,NULL,1,3,'localhost','kbyte(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23395,10,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10091,'Apache Stats - Sending Reply','query_apachestats.py[80 W]',300,15,90,NULL,NULL,NULL,1,3,'','request(s)',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23396,7,'','',10092,'Number of running processes apache','proc.num[httpd]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23397,7,'','',10092,'Number of running processes inetd','proc.num[inetd]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23398,7,'','',10092,'Number of running processes mysqld','proc.num[mysqld]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23399,7,'','',10092,'Number of running processes sshd','proc.num[sshd]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23400,7,'','',10092,'Number of running processes syslogd','proc.num[syslogd]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23401,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim check','exim.check',900,15,0,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23402,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim delivery error defer','exim.delivery.error.defer',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23403,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim delivery error failure','exim.delivery.error.failure',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23404,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim delivery to local','exim.delivery.to.local',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23405,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim delivery to other','exim.delivery.to.other',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23406,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim delivery to relay','exim.delivery.to.relay',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23407,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim delivery to unknown','exim.delivery.to.unknown',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23408,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim queue','exim.queue',900,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23409,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim reject other','exim.reject.other',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23410,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim reject relay','exim.reject.relay',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23411,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim reject unrouteable','exim.reject.unrouteable',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23412,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim submit from error','exim.submit.from.error',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23413,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim submit from local','exim.submit.from.local',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23414,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim submit from other','exim.submit.from.other',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23415,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Exim submit from relay','exim.submit.from.relay',900,15,90,NULL,NULL,NULL,0,3,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23416,7,'public','interfaces.ifTable.ifEntry.ifInOctets.1',10093,'Number of processes $1','proc.num[{$MTA_NAME}]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23417,7,'','',10094,'Volume $1 space free','vfs.fs.size[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23418,7,'','',10094,'Volume $1 space total','vfs.fs.size[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23419,7,'','',10094,'Volume $1 space used','vfs.fs.size[{$VOL_0},used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23420,7,'','',10095,'Volume $1 space free','vfs.fs.size[{$VOL_1},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23421,7,'','',10095,'Volume $1 space total','vfs.fs.size[{$VOL_1},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23422,7,'','',10095,'Volume $1 space used','vfs.fs.size[{$VOL_1},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23423,7,'','',10095,'Volume $1 space free','vfs.fs.size[{$VOL_2},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23424,7,'','',10095,'Volume $1 space total','vfs.fs.size[{$VOL_2},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23425,7,'','',10095,'Volume $1 space used','vfs.fs.size[{$VOL_2},used]',300,15,90,NULL,NULL,NULL,1,0,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23426,7,'','',10095,'Volume $1 space free','vfs.fs.size[{$VOL_3},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23427,7,'','',10095,'Volume $1 space total','vfs.fs.size[{$VOL_3},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23428,7,'','',10095,'Volume $1 space used','vfs.fs.size[{$VOL_3},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23429,7,'','',10095,'Volume $1 space free','vfs.fs.size[{$VOL_4},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23430,7,'','',10095,'Volume $1 space total','vfs.fs.size[{$VOL_4},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23431,7,'','',10095,'Volume $1 space used','vfs.fs.size[{$VOL_4},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23432,7,'','',10096,'Volume $1 space free','vfs.fs.size[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23417,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23433,7,'','',10096,'Volume $1 space total','vfs.fs.size[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23418,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23434,7,'','',10096,'Volume $1 space used','vfs.fs.size[{$VOL_0},used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23419,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23435,7,'','',10096,'Volume $1 inodes free','vfs.fs.inode[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23436,7,'','',10096,'Volume $1 inodes total','vfs.fs.inode[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23437,7,'','',10096,'Volume $1 readwrite','zbr.vfs.rw[{$VOL_0}]',300,15,0,NULL,NULL,NULL,0,1,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23438,7,'','',10097,'Volume $1 space free','vfs.fs.size[{$VOL_1},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23420,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23439,7,'','',10097,'Volume $1 space total','vfs.fs.size[{$VOL_1},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23421,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23440,7,'','',10097,'Volume $1 space used','vfs.fs.size[{$VOL_1},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23422,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23441,7,'','',10097,'Volume $1 space free','vfs.fs.size[{$VOL_2},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23423,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23442,7,'','',10097,'Volume $1 space total','vfs.fs.size[{$VOL_2},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','1','',0,'',23424,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23443,7,'','',10097,'Volume $1 space used','vfs.fs.size[{$VOL_2},used]',300,15,90,NULL,NULL,NULL,1,0,'','B',0,0,NULL,'',0,'','','','',0,'',23425,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23444,7,'','',10097,'Volume $1 space free','vfs.fs.size[{$VOL_3},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23426,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23445,7,'','',10097,'Volume $1 space total','vfs.fs.size[{$VOL_3},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23427,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23446,7,'','',10097,'Volume $1 space used','vfs.fs.size[{$VOL_3},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23428,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23447,7,'','',10097,'Volume $1 space free','vfs.fs.size[{$VOL_4},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23429,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23448,7,'','',10097,'Volume $1 space total','vfs.fs.size[{$VOL_4},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23430,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23449,7,'','',10097,'Volume $1 space used','vfs.fs.size[{$VOL_4},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23431,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23450,7,'','',10097,'Volume $1 inodes free','vfs.fs.inode[{$VOL_1},free]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23451,7,'','',10097,'Volume $1 inodes total','vfs.fs.inode[{$VOL_1},total]',3600,1,0,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23452,7,'','',10097,'Volume $1 inodes free','vfs.fs.inode[{$VOL_2},free]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23453,7,'','',10097,'Volume $1 inodes total','vfs.fs.inode[{$VOL_2},total]',3600,1,0,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23454,7,'','',10097,'Volume $1 inodes free','vfs.fs.inode[{$VOL_3},free]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23455,7,'','',10097,'Volume $1 inodes total','vfs.fs.inode[{$VOL_3},total]',3600,1,0,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23456,7,'','',10097,'Volume $1 inodes free','vfs.fs.inode[{$VOL_4},free]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23457,7,'','',10097,'Volume $1 inodes total','vfs.fs.inode[{$VOL_4},total]',3600,1,0,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23458,7,'','',10097,'Volume $1 is readonly','zbr.vfs.rw[{$VOL_1}]',300,15,0,NULL,NULL,NULL,1,1,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23459,7,'','',10097,'Volume $1 is readonly','zbr.vfs.rw[{$VOL_2}]',300,15,0,NULL,NULL,NULL,1,1,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23460,7,'','',10097,'Volume $1 is readonly','zbr.vfs.rw[{$VOL_3}]',300,15,0,NULL,NULL,NULL,1,1,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23461,7,'','',10097,'Volume $1 is readonly','zbr.vfs.rw[{$VOL_4}]',300,15,0,NULL,NULL,NULL,1,1,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23462,7,'','',10098,'Volume $1 space free','vfs.fs.size[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23417,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23463,7,'','',10098,'Volume $1 space total','vfs.fs.size[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23418,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23464,7,'','',10098,'Volume $1 space used','vfs.fs.size[{$VOL_0},used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23419,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23465,7,'','',10099,'Volume $1 space free','vfs.fs.size[{$VOL_1},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23420,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23466,7,'','',10099,'Volume $1 space total','vfs.fs.size[{$VOL_1},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23421,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23467,7,'','',10099,'Volume $1 space used','vfs.fs.size[{$VOL_1},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23422,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23468,7,'','',10099,'Volume $1 space free','vfs.fs.size[{$VOL_2},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23423,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23469,7,'','',10099,'Volume $1 space total','vfs.fs.size[{$VOL_2},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','1','',0,'',23424,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23470,7,'','',10099,'Volume $1 space used','vfs.fs.size[{$VOL_2},used]',300,15,90,NULL,NULL,NULL,1,0,'','B',0,0,NULL,'',0,'','','','',0,'',23425,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23471,7,'','',10099,'Volume $1 space free','vfs.fs.size[{$VOL_3},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23426,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23472,7,'','',10099,'Volume $1 space total','vfs.fs.size[{$VOL_3},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23427,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23473,7,'','',10099,'Volume $1 space used','vfs.fs.size[{$VOL_3},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23428,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23474,7,'','',10099,'Volume $1 space free','vfs.fs.size[{$VOL_4},free]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23429,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23475,7,'','',10099,'Volume $1 space total','vfs.fs.size[{$VOL_4},total]',3600,1,0,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23430,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23476,7,'','',10099,'Volume $1 space used','vfs.fs.size[{$VOL_4},used]',300,15,90,NULL,NULL,NULL,1,3,'','B',0,0,NULL,'',0,'','','','',0,'',23431,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23477,7,'','',10100,'Agent ping','agent.ping',300,15,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23377,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23478,7,'','',10100,'Version of zabbix_agent(d) running','agent.version',86400,90,90,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','0','',0,'',23378,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23479,7,'','',10100,'Volume $1 inodes free','vfs.fs.inode[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23435,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23480,7,'','',10100,'Volume $1 inodes total','vfs.fs.inode[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23436,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23481,7,'','',10100,'Volume $1 space free','vfs.fs.size[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23432,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23482,7,'','',10100,'Volume $1 space total','vfs.fs.size[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23433,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23483,7,'','',10100,'Volume $1 space used','vfs.fs.size[{$VOL_0},used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23434,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23484,7,'','',10100,'Volume $1 readwrite','zbr.vfs.rw[{$VOL_0}]',300,15,0,NULL,NULL,NULL,0,1,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23437,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23485,7,'','',10100,'Host uptime (in sec)','system.uptime',300,15,90,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','0','',0,'',23376,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23486,7,'','',10100,'Incoming traffic on interface $1','net.if.in[{$IF0},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',23374,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23487,7,'','',10100,'Outgoing traffic on interface $1','net.if.out[{$IF0},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',23375,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23488,7,'','',10100,'Processes maximum','kernel.maxproc',3600,1,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23368,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23489,7,'','',10100,'Processes running','proc.num[,,run]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23369,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23490,7,'','',10100,'Processes current','proc.num[]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23360,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23491,7,'','',10100,'Processor load avg15','system.cpu.load[,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',23361,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23492,7,'','',10100,'Processor load avg1','system.cpu.load[,avg1]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23362,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23493,7,'','',10100,'Processor count','system.cpu.num',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23363,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23494,7,'','',10100,'CPU $2 time ($3)','system.cpu.util[,idle,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',23370,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23495,7,'','',10100,'CPU $2 time ($3)','system.cpu.util[,system,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',23371,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23496,7,'','',10100,'CPU $2 time ($3)','system.cpu.util[,user,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',23372,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23497,7,'','',10100,'Swap total','system.swap.size[,total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23364,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23498,7,'','',10100,'Swap used','system.swap.size[,used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23365,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23499,7,'','',10100,'Memory $1','vm.memory.size[cached]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23373,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23500,7,'','',10100,'Memory free','vm.memory.size[free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23366,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23501,7,'','',10100,'Memory total','vm.memory.size[total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23367,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23502,7,'','',10101,'Host name','system.hostname',86400,7,90,NULL,NULL,NULL,1,1,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23503,7,'','',10101,'Host local time','system.localtime',300,15,0,NULL,NULL,NULL,1,3,'','unixtime',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23504,7,'','',10101,'Host information','system.uname',86400,7,90,NULL,NULL,NULL,1,1,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23505,7,'','',10102,'Agent ping','agent.ping',300,15,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23377,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23506,7,'','',10102,'Version of zabbix_agent(d) running','agent.version',86400,90,90,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','0','',0,'',23378,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23507,7,'','',10102,'Volume $1 inodes free','vfs.fs.inode[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23435,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23508,7,'','',10102,'Volume $1 inodes total','vfs.fs.inode[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23436,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23509,7,'','',10102,'Volume $1 space free','vfs.fs.size[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23432,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23510,7,'','',10102,'Volume $1 space total','vfs.fs.size[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23433,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23511,7,'','',10102,'Volume $1 space used','vfs.fs.size[{$VOL_0},used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23434,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23512,7,'','',10102,'Volume $1 readwrite','zbr.vfs.rw[{$VOL_0}]',300,15,0,NULL,NULL,NULL,0,1,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23437,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23513,7,'','',10102,'Host uptime (in sec)','system.uptime',300,15,90,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','0','',0,'',23376,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23514,7,'','',10102,'Incoming traffic on interface $1','net.if.in[{$IF0},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',23374,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23515,7,'','',10102,'Outgoing traffic on interface $1','net.if.out[{$IF0},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',23375,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23516,7,'','',10102,'Processes maximum','kernel.maxproc',3600,1,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23344,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23517,7,'','',10102,'Processes running','proc.num[,,run]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23345,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23518,7,'','',10102,'Processes current','proc.num[]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23336,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23519,7,'','',10102,'Processor load avg15','system.cpu.load[,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',23337,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23520,7,'','',10102,'Processor load avg1','system.cpu.load[,avg1]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23338,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23521,7,'','',10102,'Processor count','system.cpu.num',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23339,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23522,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,idle,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',23346,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23523,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,interrupt,avg15]',300,15,90,NULL,NULL,NULL,1,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23347,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23524,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,iowait,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',23348,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23525,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,nice,avg15]',300,15,90,NULL,NULL,NULL,1,0,'','',0,0,NULL,'',0,'','','1','',0,'',23349,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23526,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,softirq,avg15]',300,15,90,NULL,NULL,NULL,1,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23350,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23527,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,steal,avg15]',300,15,90,NULL,NULL,NULL,1,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23351,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23528,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,system,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',23352,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23529,7,'','',10102,'CPU $2 time ($3)','system.cpu.util[,user,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',23353,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23530,7,'','',10102,'Swap total','system.swap.size[,total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23340,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23531,7,'','',10102,'Swap used','system.swap.size[,used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23341,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23532,7,'','',10102,'Memory $1','vm.memory.size[buffers]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23354,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23533,7,'','',10102,'Memory $1','vm.memory.size[cached]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23355,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23534,7,'','',10102,'Memory free','vm.memory.size[free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23342,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23535,7,'','',10102,'Memory total','vm.memory.size[total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23343,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23536,7,'','',10102,'Block In','zbr.vmstat.bi',300,15,90,NULL,NULL,NULL,0,0,'localhost','blocks/s',0,1,NULL,'',0,'','','0','',0,'',23356,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23537,7,'','',10102,'Block Out','zbr.vmstat.bo',300,15,90,NULL,NULL,NULL,0,0,'localhost','blocks/s',0,1,NULL,'',0,'','','0','',0,'',23357,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23538,7,'','',10102,'Swap In','zbr.vmstat.si',300,15,90,NULL,NULL,NULL,0,0,'localhost','pages/s',0,1,NULL,'',0,'','','0','',0,'',23358,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23539,7,'','',10102,'Swap Out','zbr.vmstat.so',300,15,90,NULL,NULL,NULL,0,0,'localhost','pages/s',0,1,NULL,'',0,'','','0','',0,'',23359,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23540,7,'','',10103,'Memory Active Pages','zbr.vm.v_active_count',300,15,90,NULL,NULL,NULL,0,3,'localhost','page(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23541,7,'','',10103,'Memory Cache Pages','zbr.vm.v_cache_count',300,15,90,NULL,NULL,NULL,0,3,'localhost','page(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23542,7,'','',10103,'Memory Free Pages','zbr.vm.v_free_count',300,15,90,NULL,NULL,NULL,0,3,'localhost','page(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23543,7,'','',10103,'Memory Inactive Pages','zbr.vm.v_inactive_count',300,15,90,NULL,NULL,NULL,0,3,'localhost','page(s)',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23544,7,'','',10104,'EXNG: MSExchangeMTA Submits','perf_counter[\\MSExchangeTransport Store Driver(_Total)\\Store/MSExchangeMTA Submits]',300,15,90,NULL,NULL,NULL,0,0,'','',0,2,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23545,7,'','',10104,'EXNG: Inbound Connections Current','perf_counter[\\SMTP Server(_Total)\\Inbound Connections Current]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23546,7,'','',10104,'EXNG: Local Queue Length','perf_counter[\\SMTP Server(_Total)\\Local Queue Length]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23547,7,'','',10104,'EXNG: Local Retry Queue Length','perf_counter[\\SMTP Server(_Total)\\Local Retry Queue Length]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23548,7,'','',10104,'EXNG: Messages Received/sec','perf_counter[\\SMTP Server(_Total)\\Messages Received/sec]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23549,7,'','',10104,'EXNG: Pickup Directory Messages Retrieved/sec','perf_counter[\\SMTP Server(_Total)\\Pickup Directory Messages Retrieved/sec]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23550,7,'','',10104,'EXNG: Remote Queue Length','perf_counter[\\SMTP Server(_Total)\\Remote Queue Length]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23551,7,'','',10104,'EXNG: Remote Retry Queue Length','perf_counter[\\SMTP Server(_Total)\\Remote Retry Queue Length]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23552,7,'','',10104,'EXNG: Service State - IMAP4','service_state[IMAP4Svc]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23553,7,'','',10104,'EXNG: Service State - Event','service_state[MSExchangeES]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23554,7,'','',10104,'EXNG: Service State - Information Store','service_state[MSExchangeIS]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23555,7,'','',10104,'EXNG: Service State - Management','service_state[MSExchangeMGMT]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23556,7,'','',10104,'EXNG: Service State - MTA Stacks','service_state[MSExchangeMTA]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23557,7,'','',10104,'EXNG: Service State - System Attendant','service_state[MSExchangeSA]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23558,7,'','',10104,'EXNG: Service State - Site Replication Service','service_state[MSExchangeSRS]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23559,7,'','',10104,'EXNG: Service State - Network News Transfer Protocol (NNTP)','service_state[NntpSvc]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23560,7,'','',10104,'EXNG: Service State - POP3','service_state[POP3Svc]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23561,7,'','',10104,'EXNG: Service State - Routing Engine','service_state[RESvc]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23562,7,'','',10104,'EXNG: Service State - Simple Mail Transfer Protocol (SMTP)','service_state[SMTPSVC]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23563,7,'','',10105,'MySQL is alive','mysql.ping',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23564,7,'','',10105,'MySQL queries per second','mysql.qps',300,15,90,NULL,NULL,NULL,0,0,'','qps',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23565,7,'','',10105,'MySQL number of slow queries','mysql.slowqueries',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23566,7,'','',10105,'MySQL number of threads','mysql.threads',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23567,7,'','',10105,'MySQL uptime','mysql.uptime',300,15,90,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23568,7,'','',10105,'MySQL version','mysql.version',86400,7,90,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23569,7,'','',10106,'Incoming traffic on interface $1','net.if.in[{$IF1},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23570,7,'','',10106,'Outgoing traffic on interface $1','net.if.out[{$IF1},bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23571,7,'','',10107,'Incoming traffic on interface $1','net.if.in[lo,bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23572,7,'','',10107,'Outgoing traffic on interface $1','net.if.out[lo,bytes]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,1,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23573,7,'','',10108,'File read bytes/sec','perf_counter[\\2\\16]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23574,7,'','',10108,'File write bytes/sec','perf_counter[\\2\\18]',300,15,90,NULL,NULL,NULL,0,0,'','Bps',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23575,7,'','',10108,'Split IO/sec','perf_counter[\\234(_Total)\\1484]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23576,7,'','',10108,'Disk Reads/sec','perf_counter[\\234(_Total)\\214]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23577,7,'','',10108,'Disk Writes/sec','perf_counter[\\234(_Total)\\216]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23578,7,'','',10108,'Disk Read Bytes/sec','perf_counter[\\234(_Total)\\220]',300,15,90,NULL,NULL,NULL,0,0,'localhost','Bps',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23579,7,'','',10108,'Disk Write Bytes/sec','perf_counter[\\234(_Total)\\222]',300,15,90,NULL,NULL,NULL,0,0,'localhost','Bps',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23580,7,'','',10109,'Processes current','proc.num[]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23328,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23581,7,'','',10109,'Processor load avg15','system.cpu.load[,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',23330,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23582,7,'','',10109,'Processor load avg1','system.cpu.load[,avg1]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23329,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23583,7,'','',10109,'Processor count','system.cpu.num',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23331,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23584,7,'','',10109,'Swap total','system.swap.size[,total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23332,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23585,7,'','',10109,'Swap used','system.swap.size[,used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23333,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23586,7,'','',10109,'Memory free','vm.memory.size[free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23334,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23587,7,'','',10109,'Memory total','vm.memory.size[total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23335,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23588,7,'','',10109,'Paging File Usage','perf_counter[\\700(_Total)\\702]',300,15,90,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23589,7,'','',10109,'Number of running processes','system[procrunning]',300,15,90,NULL,NULL,NULL,1,0,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23590,7,'','',10109,'Memory cached','vm.memory.size[cached]',300,15,90,NULL,NULL,NULL,0,3,'localhost','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23591,3,'','',10110,'ICMP ping','icmpping',300,15,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23592,0,'','',10111,'FTP server is running','net.tcp.service[ftp]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23593,0,'','',10111,'WEB (HTTP) server is running','net.tcp.service[http]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23594,0,'','',10111,'IMAP server is running','net.tcp.service[imap]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23595,0,'','',10111,'News (NNTP) server is running','net.tcp.service[nntp]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23596,0,'','',10111,'POP3 server is running','net.tcp.service[pop]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23597,0,'','',10111,'Email (SMTP) server is running','net.tcp.service[smtp]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23598,0,'','',10111,'SSH server is running','net.tcp.service[ssh]',300,15,90,NULL,NULL,NULL,1,3,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23599,7,'','',10112,'Agent ping','agent.ping',300,15,0,NULL,NULL,NULL,0,3,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23377,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23600,7,'','',10112,'Version of zabbix_agent(d) running','agent.version',86400,90,90,NULL,NULL,NULL,0,1,'','',0,0,NULL,'',0,'','','0','',0,'',23378,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23601,7,'','',10112,'Host uptime (in sec)','system.uptime',300,15,90,NULL,NULL,NULL,0,3,'','uptime',0,0,NULL,'',0,'','','0','',0,'',23376,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23602,7,'','',10112,'Paging File Usage','perf_counter[\\700(_Total)\\702]',300,15,90,NULL,NULL,NULL,0,0,'','%',0,0,NULL,'',0,'','','1','',0,'',23588,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23603,7,'','',10112,'Processes current','proc.num[]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23580,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23604,7,'','',10112,'Processor load avg15','system.cpu.load[,avg15]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',23581,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23605,7,'','',10112,'Processor load avg1','system.cpu.load[,avg1]',300,15,90,NULL,NULL,NULL,0,0,'localhost','',0,0,NULL,'',0,'','','0','',0,'',23582,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23606,7,'','',10112,'Processor count','system.cpu.num',3600,1,0,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','0','',0,'',23583,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23607,7,'','',10112,'Swap total','system.swap.size[,total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23584,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23608,7,'','',10112,'Swap used','system.swap.size[,used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23585,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23609,7,'','',10112,'Number of running processes','system[procrunning]',300,15,90,NULL,NULL,NULL,1,0,'','',0,0,NULL,'',0,'','','0','',0,'',23589,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23610,7,'','',10112,'Memory cached','vm.memory.size[cached]',300,15,90,NULL,NULL,NULL,0,3,'localhost','B',0,0,NULL,'',0,'','','0','',0,'',23590,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23611,7,'','',10112,'Memory free','vm.memory.size[free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23586,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23612,7,'','',10112,'Memory total','vm.memory.size[total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',23587,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23613,7,'','',10112,'Volume $1 space free','vfs.fs.size[{$VOL_0},free]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23462,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23614,7,'','',10112,'Volume $1 space total','vfs.fs.size[{$VOL_0},total]',3600,1,0,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23463,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23615,7,'','',10112,'Volume $1 space used','vfs.fs.size[{$VOL_0},used]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','','',0,'',23464,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23616,7,'','',10113,'Number of running processes apache','proc_cnt[httpd]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23617,7,'','',10113,'Service state of DHCP client ($1)','service_state[Dhcp]',300,15,90,NULL,NULL,NULL,0,3,'','',0,0,NULL,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23618,7,'','',10113,'Checksum of $1','vfs.file.cksum[c:\\autoexec.bat]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23619,7,'','',10113,'Checksum of $1','vfs.file.cksum[c:\\config.sys]',300,15,90,NULL,NULL,NULL,0,0,'','',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30'),(23620,7,'','',10113,'Size of $1','vfs.file.size[c:\\msdos.sys]',300,15,90,NULL,NULL,NULL,0,3,'','B',0,0,NULL,'',0,'','','0','',0,'',NULL,NULL,'','','',0,0,'','','','',0,NULL,0,'',NULL,'','',0,'30');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_applications`
--

DROP TABLE IF EXISTS `items_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_applications` (
  `itemappid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`itemappid`),
  UNIQUE KEY `items_applications_1` (`applicationid`,`itemid`),
  KEY `items_applications_2` (`itemid`),
  CONSTRAINT `c_items_applications_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_applications_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_applications`
--

LOCK TABLES `items_applications` WRITE;
/*!40000 ALTER TABLE `items_applications` DISABLE KEYS */;
INSERT INTO `items_applications` VALUES (4653,1,10016),(694,1,10025),(636,1,10055),(634,1,10056),(448,1,10057),(444,1,10058),(646,1,17318),(642,1,17352),(4462,5,22452),(4464,5,22454),(4466,5,22456),(4468,5,22458),(4704,5,22686),(4458,7,22446),(4460,7,22448),(600,9,10009),(804,9,10013),(587,13,10010),(689,13,17354),(671,13,17356),(675,13,17358),(679,13,17360),(683,13,17362),(4659,13,22665),(4665,13,22668),(4671,13,22671),(4677,13,22674),(4683,13,22677),(4692,13,22680),(4698,13,22683),(4587,15,10014),(4593,15,10026),(4595,15,10030),(4589,15,17350),(4583,15,22181),(588,17,10010),(690,17,17354),(672,17,17356),(676,17,17358),(680,17,17360),(684,17,17362),(4660,17,22665),(4666,17,22668),(4672,17,22671),(4678,17,22674),(4684,17,22677),(4693,17,22680),(4699,17,22683),(693,21,10025),(447,21,10057),(443,21,10058),(645,21,17318),(641,21,17352),(4654,23,10016),(654,23,10019),(4447,179,22183),(4443,179,22185),(4441,179,22187),(4097,179,22189),(4451,179,22219),(4445,179,22396),(4398,179,22399),(4400,179,22400),(4402,179,22402),(4404,179,22404),(4406,179,22406),(4408,179,22408),(4410,179,22410),(4412,179,22412),(4414,179,22414),(4416,179,22416),(4418,179,22418),(4420,179,22420),(4422,179,22422),(4424,179,22424),(4426,179,22426),(4428,179,22428),(4430,179,22430),(4707,179,22689),(5341,179,23171),(5421,179,23251),(4548,206,22231),(4544,206,22232),(5514,206,23318),(4545,207,10020),(4549,207,10059),(5515,207,23319),(4564,214,22548),(4563,214,22549),(4562,214,22550),(4565,214,22551),(4566,214,22552),(4568,214,22553),(4569,214,22554),(4709,214,22691),(4711,214,22692),(4713,214,22694),(4715,214,22696),(4717,214,22698),(4719,227,22701),(4720,227,22702),(4721,227,22703),(4722,227,22704),(4723,227,22705),(4724,227,22706),(4725,227,22707),(4726,227,22708),(4762,227,22709),(4727,228,22710),(4728,228,22711),(4729,228,22712),(4730,228,22713),(4731,228,22714),(4732,229,22715),(4733,229,22716),(4734,229,22717),(4735,229,22718),(4736,229,22719),(4737,230,22721),(4738,230,22722),(4739,230,22723),(4740,230,22724),(4741,230,22725),(4742,230,22726),(4743,230,22727),(4744,230,22728),(4763,230,22729),(4745,231,22730),(4746,231,22731),(4747,231,22732),(4748,231,22733),(4749,231,22734),(4750,232,22736),(4751,232,22737),(4752,232,22738),(4753,232,22739),(4754,232,22740),(4755,232,22741),(4756,232,22742),(4757,232,22743),(4764,232,22744),(4758,234,22749),(4759,234,22755),(4760,234,22756),(4761,234,22757),(4765,234,22758),(4766,234,22759),(4767,235,22761),(4768,235,22762),(4769,235,22763),(4770,235,22764),(4771,235,22765),(4772,235,22766),(4773,236,22768),(4774,236,22769),(4775,236,22770),(4776,236,22771),(4777,236,22772),(4778,236,22773),(4779,237,22774),(4780,237,22775),(4781,237,22776),(4782,237,22777),(4783,237,22778),(4784,238,22780),(4785,238,22781),(4786,238,22782),(4787,238,22783),(4788,238,22784),(4789,238,22785),(4790,238,22786),(4791,238,22787),(4792,238,22788),(4793,240,22793),(4794,241,22797),(4795,242,22799),(4817,245,22800),(4818,245,22801),(4819,245,22802),(4820,245,22803),(4821,245,22805),(4823,245,22806),(4822,246,22804),(4824,247,22807),(4825,248,22809),(4826,248,22810),(4827,248,22811),(4828,248,22812),(4829,248,22813),(4830,248,22814),(4831,248,22816),(4832,249,22808),(4833,249,22815),(4834,250,22817),(4835,250,22818),(4836,251,22819),(4837,251,22820),(4838,251,22821),(4839,251,22822),(4840,251,22823),(4841,251,22824),(4842,251,22825),(4843,251,22826),(4844,251,22827),(4845,251,22828),(4846,251,22829),(4847,251,22830),(4848,251,22831),(4849,251,22832),(4850,252,22833),(4851,252,22834),(5516,252,23320),(4858,253,22840),(4860,253,22841),(4862,253,22842),(4864,253,22843),(4866,253,22844),(4868,253,22845),(4870,253,22846),(4874,253,22848),(4880,253,22851),(4882,253,22852),(5276,254,22868),(5278,254,22869),(5279,254,22870),(5280,254,22871),(5277,254,22872),(4857,255,22839),(4885,255,22853),(4887,255,22854),(4892,255,22858),(4894,255,22859),(4888,256,22855),(4889,256,22856),(4890,256,22857),(4898,256,22862),(4899,256,22863),(5152,257,23075),(5153,257,23076),(4852,258,22835),(4853,258,22836),(4856,258,22839),(4884,258,22853),(4886,258,22854),(4891,258,22858),(4893,258,22859),(4895,258,22860),(4859,259,22840),(4861,259,22841),(4863,259,22842),(4865,259,22843),(4867,259,22844),(4869,259,22845),(4871,259,22846),(4875,259,22848),(4881,259,22851),(4883,259,22852),(4854,260,22837),(4855,260,22838),(4896,261,22860),(4897,261,22861),(4900,262,22873),(4901,262,22874),(5517,262,23321),(4908,263,22880),(4910,263,22881),(4912,263,22882),(4914,263,22883),(4916,263,22884),(4918,263,22885),(4920,263,22886),(4924,263,22888),(4930,263,22891),(4932,263,22892),(5256,264,22908),(5258,264,22909),(5259,264,22910),(5260,264,22911),(5257,264,22912),(4907,265,22879),(4935,265,22893),(4937,265,22894),(4942,265,22898),(4944,265,22899),(4938,266,22895),(4939,266,22896),(4940,266,22897),(4948,266,22902),(4949,266,22903),(5150,267,23073),(5151,267,23074),(4902,268,22875),(4903,268,22876),(4906,268,22879),(4934,268,22893),(4936,268,22894),(4941,268,22898),(4943,268,22899),(4945,268,22900),(4909,269,22880),(4911,269,22881),(4913,269,22882),(4915,269,22883),(4917,269,22884),(4919,269,22885),(4921,269,22886),(4925,269,22888),(4931,269,22891),(4933,269,22892),(4904,270,22877),(4905,270,22878),(4946,271,22900),(4947,271,22901),(4950,272,22913),(4951,272,22914),(5518,272,23322),(4958,273,22920),(4960,273,22921),(4962,273,22922),(4964,273,22923),(4966,273,22924),(5310,273,23108),(5307,273,23109),(5290,273,23110),(5313,273,23111),(5304,273,23112),(5296,273,23113),(5292,273,23114),(5294,273,23115),(5330,273,23118),(5332,273,23119),(5334,273,23120),(5336,273,23121),(5328,273,23123),(5248,274,22948),(5250,274,22949),(5251,274,22950),(5252,274,22951),(5249,274,22952),(5323,274,23116),(5326,274,23117),(5512,275,22933),(4987,275,22934),(4992,275,22938),(4994,275,22939),(4998,276,22942),(4999,276,22943),(5340,276,23122),(5193,276,23124),(5194,276,23125),(5319,276,23126),(5321,276,23127),(5322,276,23128),(5316,276,23129),(5317,276,23130),(5325,276,23131),(5254,277,22945),(5255,277,22946),(5513,278,22933),(4986,278,22934),(4991,278,22938),(4993,278,22939),(4995,278,22940),(4959,279,22920),(4961,279,22921),(4963,279,22922),(4965,279,22923),(4967,279,22924),(5312,279,23108),(5309,279,23109),(5291,279,23110),(5315,279,23111),(5305,279,23112),(5297,279,23113),(5293,279,23114),(5295,279,23115),(5324,279,23116),(5327,279,23117),(5333,279,23119),(5335,279,23120),(5337,279,23121),(4954,280,22917),(4955,280,22918),(4996,281,22940),(4997,281,22941),(5000,282,22953),(5001,282,22954),(5519,282,23323),(5010,283,22961),(5012,283,22962),(5014,283,22963),(5018,283,22965),(5024,283,22968),(5030,283,22971),(5032,283,22972),(5262,284,22988),(5264,284,22989),(5265,284,22990),(5267,284,22991),(5263,284,22992),(5035,285,22973),(5037,285,22974),(5042,285,22978),(5048,286,22982),(5049,286,22983),(5268,287,22985),(5269,287,22986),(5034,288,22973),(5036,288,22974),(5041,288,22978),(5045,288,22980),(5011,289,22961),(5013,289,22962),(5015,289,22963),(5019,289,22965),(5025,289,22968),(5031,289,22971),(5033,289,22972),(5046,291,22980),(5047,291,22981),(5050,292,22993),(5051,292,22994),(5520,292,23324),(5058,293,23000),(5060,293,23001),(5062,293,23002),(5064,293,23003),(5066,293,23004),(5068,293,23005),(5072,293,23007),(5080,293,23011),(5082,293,23012),(5281,294,23028),(5284,294,23029),(5285,294,23030),(5286,294,23031),(5283,294,23032),(5057,295,22999),(5085,295,23013),(5087,295,23014),(5092,295,23018),(5094,295,23019),(5088,296,23015),(5089,296,23016),(5090,296,23017),(5098,296,23022),(5099,296,23023),(5287,297,23025),(5288,297,23026),(5053,298,22996),(5056,298,22999),(5084,298,23013),(5086,298,23014),(5091,298,23018),(5093,298,23019),(5095,298,23020),(5059,299,23000),(5061,299,23001),(5063,299,23002),(5065,299,23003),(5067,299,23004),(5069,299,23005),(5073,299,23007),(5081,299,23011),(5083,299,23012),(5054,300,22997),(5055,300,22998),(5096,301,23020),(5097,301,23021),(5100,302,23033),(5101,302,23034),(5521,302,23325),(5110,303,23041),(5112,303,23042),(5114,303,23043),(5271,304,23068),(5273,304,23069),(5274,304,23070),(5275,304,23071),(5272,304,23072),(5107,305,23039),(5135,305,23053),(5137,305,23054),(5142,305,23058),(5144,305,23059),(5148,306,23062),(5149,306,23063),(5154,307,23077),(5155,307,23078),(5102,308,23035),(5103,308,23036),(5106,308,23039),(5134,308,23053),(5136,308,23054),(5141,308,23058),(5143,308,23059),(5145,308,23060),(5111,309,23041),(5113,309,23042),(5115,309,23043),(5146,311,23060),(5147,311,23061),(5510,319,23149),(5217,319,23150),(5229,320,23134),(5231,320,23135),(5424,320,23136),(5426,320,23137),(5233,320,23143),(5246,320,23144),(5244,320,23145),(5228,322,23134),(5230,322,23135),(5423,322,23136),(5425,322,23137),(5240,322,23159),(5247,322,23164),(5253,322,23165),(5266,322,23167),(5270,322,23168),(5204,323,23138),(5511,323,23149),(5206,324,23140),(5232,325,23143),(5245,325,23144),(5243,325,23145),(5234,328,23147),(5235,328,23148),(5226,328,23158),(5241,329,23160),(5242,329,23161),(5522,329,23326),(5282,330,23169),(5289,330,23170),(5311,331,23108),(5308,331,23109),(5314,331,23111),(5306,331,23112),(5331,331,23118),(5343,332,23173),(5344,332,23174),(5345,332,23175),(5342,333,23172),(5382,333,23212),(5346,334,23176),(5347,334,23177),(5348,334,23178),(5349,334,23179),(5350,334,23180),(5351,334,23181),(5352,334,23182),(5353,334,23183),(5354,334,23184),(5355,334,23185),(5356,334,23186),(5357,334,23187),(5360,335,23190),(5361,336,23191),(5362,336,23192),(5363,336,23193),(5364,336,23194),(5365,336,23195),(5366,336,23196),(5367,336,23197),(5368,336,23198),(5369,336,23199),(5370,336,23200),(5371,336,23201),(5372,336,23202),(5373,336,23203),(5374,336,23204),(5375,336,23205),(5376,336,23206),(5377,336,23207),(5378,336,23208),(5379,336,23209),(5380,336,23210),(5381,336,23211),(5383,337,23213),(5384,337,23214),(5358,338,23188),(5359,338,23189),(5385,339,23215),(5386,339,23216),(5387,339,23217),(5388,339,23218),(5389,340,23219),(5390,340,23220),(5391,340,23221),(5392,340,23222),(5393,340,23223),(5394,340,23224),(5395,340,23225),(5396,340,23226),(5397,340,23227),(5398,341,23228),(5399,341,23229),(5400,341,23230),(5401,341,23231),(5402,341,23232),(5403,341,23233),(5404,341,23234),(5405,341,23235),(5406,341,23236),(5407,342,23237),(5408,342,23238),(5409,342,23239),(5410,342,23240),(5411,342,23241),(5412,342,23242),(5413,342,23243),(5414,342,23244),(5415,343,23245),(5416,343,23246),(5417,343,23247),(5418,343,23248),(5419,343,23249),(5420,344,23250),(5427,345,23252),(5428,345,23253),(5429,345,23254),(5430,345,23255),(5431,345,23256),(5432,345,23257),(5433,345,23258),(5434,345,23259),(5435,345,23260),(5436,345,23261),(5437,345,23262),(5438,345,23263),(5439,345,23264),(5440,345,23265),(5441,345,23266),(5442,345,23267),(5443,345,23268),(5444,345,23269),(5445,345,23270),(5446,345,23271),(5447,345,23272),(5448,345,23273),(5449,345,23274),(5450,345,23275),(5451,345,23276),(5452,345,23277),(5468,346,23294),(5470,346,23295),(5472,346,23296),(5474,346,23297),(5476,346,23298),(5478,346,23299),(5480,346,23300),(5482,346,23301),(5484,346,23302),(5486,346,23303),(5488,346,23304),(5490,346,23305),(5492,346,23306),(5455,347,23282),(5456,347,23283),(5457,347,23284),(5458,347,23285),(5459,347,23286),(5467,348,23293),(5495,348,23307),(5497,348,23308),(5502,348,23312),(5504,348,23313),(5498,349,23309),(5499,349,23310),(5500,349,23311),(5508,349,23316),(5509,349,23317),(5453,350,23280),(5454,350,23281),(5462,351,23289),(5463,351,23290),(5466,351,23293),(5494,351,23307),(5496,351,23308),(5501,351,23312),(5503,351,23313),(5505,351,23314),(5469,352,23294),(5471,352,23295),(5473,352,23296),(5475,352,23297),(5477,352,23298),(5479,352,23299),(5481,352,23300),(5483,352,23301),(5485,352,23302),(5487,352,23303),(5489,352,23304),(5491,352,23305),(5493,352,23306),(5464,353,23291),(5465,353,23292),(5506,354,23314),(5507,354,23315),(5460,355,23287),(5461,355,23288),(5523,355,23327),(5524,356,23328),(5528,356,23332),(5529,356,23333),(5530,356,23334),(5531,356,23335),(5525,357,23329),(5526,357,23330),(5527,357,23331),(5533,358,23337),(5534,358,23338),(5535,358,23339),(5541,358,23345),(5542,358,23346),(5543,358,23347),(5544,358,23348),(5545,358,23349),(5546,358,23350),(5547,358,23351),(5548,358,23352),(5549,358,23353),(5532,359,23336),(5536,359,23340),(5537,359,23341),(5538,359,23342),(5539,359,23343),(5540,359,23344),(5550,359,23354),(5551,359,23355),(5552,360,23356),(5553,360,23357),(5554,360,23358),(5555,360,23359),(5557,361,23361),(5558,361,23362),(5559,361,23363),(5565,361,23369),(5566,361,23370),(5567,361,23371),(5568,361,23372),(5556,362,23360),(5560,362,23364),(5561,362,23365),(5562,362,23366),(5563,362,23367),(5564,362,23368),(5569,362,23373),(5570,363,23374),(5571,363,23375),(5572,364,23376),(5573,365,23377),(5574,365,23378),(5575,366,23379),(5578,366,23382),(5580,366,23384),(5581,366,23385),(5582,366,23386),(5584,366,23388),(5585,366,23389),(5586,366,23390),(5588,366,23392),(5591,366,23395),(5576,367,23380),(5577,367,23381),(5579,367,23383),(5583,367,23387),(5587,367,23391),(5589,367,23393),(5590,367,23394),(5592,368,23396),(5593,368,23397),(5594,368,23398),(5595,368,23399),(5596,368,23400),(5597,369,23401),(5598,369,23402),(5599,369,23403),(5600,369,23404),(5601,369,23405),(5602,369,23406),(5603,369,23407),(5604,369,23408),(5605,369,23409),(5606,369,23410),(5607,369,23411),(5608,369,23412),(5609,369,23413),(5610,369,23414),(5611,369,23415),(5612,369,23416),(5613,370,23417),(5614,370,23418),(5615,370,23419),(5616,371,23420),(5617,371,23421),(5618,371,23422),(5619,371,23423),(5620,371,23424),(5621,371,23425),(5622,371,23426),(5623,371,23427),(5624,371,23428),(5625,371,23429),(5626,371,23430),(5627,371,23431),(5628,372,23432),(5629,372,23433),(5630,372,23434),(5631,372,23435),(5632,372,23436),(5633,372,23437),(5634,373,23438),(5635,373,23439),(5636,373,23440),(5637,373,23441),(5638,373,23442),(5639,373,23443),(5640,373,23444),(5641,373,23445),(5642,373,23446),(5643,373,23447),(5644,373,23448),(5645,373,23449),(5646,373,23450),(5647,373,23451),(5648,373,23452),(5649,373,23453),(5650,373,23454),(5651,373,23455),(5652,373,23456),(5653,373,23457),(5654,373,23458),(5655,373,23459),(5656,373,23460),(5657,373,23461),(5658,374,23462),(5659,374,23463),(5660,374,23464),(5661,375,23465),(5662,375,23466),(5663,375,23467),(5664,375,23468),(5665,375,23469),(5666,375,23470),(5667,375,23471),(5668,375,23472),(5669,375,23473),(5670,375,23474),(5671,375,23475),(5672,375,23476),(5673,376,23477),(5674,376,23478),(5675,377,23479),(5676,377,23480),(5677,377,23481),(5678,377,23482),(5679,377,23483),(5680,377,23484),(5681,378,23485),(5682,379,23486),(5683,379,23487),(5685,380,23489),(5687,380,23491),(5688,380,23492),(5689,380,23493),(5690,380,23494),(5691,380,23495),(5692,380,23496),(5684,381,23488),(5686,381,23490),(5693,381,23497),(5694,381,23498),(5695,381,23499),(5696,381,23500),(5697,381,23501),(5698,382,23502),(5699,382,23503),(5700,382,23504),(5701,383,23505),(5702,383,23506),(5703,384,23507),(5704,384,23508),(5705,384,23509),(5706,384,23510),(5707,384,23511),(5708,384,23512),(5709,385,23513),(5710,386,23514),(5711,386,23515),(5713,387,23517),(5715,387,23519),(5716,387,23520),(5717,387,23521),(5718,387,23522),(5719,387,23523),(5720,387,23524),(5721,387,23525),(5722,387,23526),(5723,387,23527),(5724,387,23528),(5725,387,23529),(5732,388,23536),(5733,388,23537),(5734,388,23538),(5735,388,23539),(5712,389,23516),(5714,389,23518),(5726,389,23530),(5727,389,23531),(5728,389,23532),(5729,389,23533),(5730,389,23534),(5731,389,23535),(5736,390,23540),(5737,390,23541),(5738,390,23542),(5739,390,23543),(5740,391,23544),(5741,391,23545),(5742,391,23546),(5743,391,23547),(5744,391,23548),(5745,391,23549),(5746,391,23550),(5747,391,23551),(5748,391,23552),(5749,391,23553),(5750,391,23554),(5751,391,23555),(5752,391,23556),(5753,391,23557),(5754,391,23558),(5755,391,23559),(5756,391,23560),(5757,391,23561),(5758,391,23562),(5759,392,23563),(5760,392,23564),(5761,392,23565),(5762,392,23566),(5763,392,23567),(5764,392,23568),(5765,393,23569),(5766,393,23570),(5767,394,23571),(5768,394,23572),(5769,395,23573),(5770,395,23574),(5771,395,23575),(5772,395,23576),(5773,395,23577),(5774,395,23578),(5775,395,23579),(5777,396,23581),(5778,396,23582),(5779,396,23583),(5785,396,23589),(5776,397,23580),(5780,397,23584),(5781,397,23585),(5782,397,23586),(5783,397,23587),(5784,397,23588),(5786,397,23590),(5787,398,23591),(5788,399,23592),(5789,399,23593),(5790,399,23594),(5791,399,23595),(5792,399,23596),(5793,399,23597),(5794,399,23598),(5795,400,23599),(5796,400,23600),(5797,401,23601),(5800,402,23604),(5801,402,23605),(5802,402,23606),(5805,402,23609),(5798,403,23602),(5799,403,23603),(5803,403,23607),(5804,403,23608),(5806,403,23610),(5807,403,23611),(5808,403,23612),(5809,404,23613),(5810,404,23614),(5811,404,23615),(5812,405,23616),(5813,405,23617),(5814,405,23618),(5815,405,23619),(5816,405,23620);
/*!40000 ALTER TABLE `items_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances` (
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `active_since` int(11) NOT NULL DEFAULT '0',
  `active_till` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maintenanceid`),
  KEY `maintenances_1` (`active_since`,`active_till`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_groups`
--

DROP TABLE IF EXISTS `maintenances_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_groups` (
  `maintenance_groupid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_groupid`),
  UNIQUE KEY `maintenances_groups_1` (`maintenanceid`,`groupid`),
  KEY `c_maintenances_groups_2` (`groupid`),
  CONSTRAINT `c_maintenances_groups_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_groups_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_groups`
--

LOCK TABLES `maintenances_groups` WRITE;
/*!40000 ALTER TABLE `maintenances_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_hosts`
--

DROP TABLE IF EXISTS `maintenances_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_hosts` (
  `maintenance_hostid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_hostid`),
  UNIQUE KEY `maintenances_hosts_1` (`maintenanceid`,`hostid`),
  KEY `c_maintenances_hosts_2` (`hostid`),
  CONSTRAINT `c_maintenances_hosts_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_hosts_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_hosts`
--

LOCK TABLES `maintenances_hosts` WRITE;
/*!40000 ALTER TABLE `maintenances_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_windows`
--

DROP TABLE IF EXISTS `maintenances_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_windows` (
  `maintenance_timeperiodid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `timeperiodid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_timeperiodid`),
  UNIQUE KEY `maintenances_windows_1` (`maintenanceid`,`timeperiodid`),
  KEY `c_maintenances_windows_2` (`timeperiodid`),
  CONSTRAINT `c_maintenances_windows_2` FOREIGN KEY (`timeperiodid`) REFERENCES `timeperiods` (`timeperiodid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_windows_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_windows`
--

LOCK TABLES `maintenances_windows` WRITE;
/*!40000 ALTER TABLE `maintenances_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mappings`
--

DROP TABLE IF EXISTS `mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mappings` (
  `mappingid` bigint(20) unsigned NOT NULL,
  `valuemapid` bigint(20) unsigned NOT NULL,
  `value` varchar(64) NOT NULL DEFAULT '',
  `newvalue` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`mappingid`),
  KEY `mappings_1` (`valuemapid`),
  CONSTRAINT `c_mappings_1` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mappings`
--

LOCK TABLES `mappings` WRITE;
/*!40000 ALTER TABLE `mappings` DISABLE KEYS */;
INSERT INTO `mappings` VALUES (1,1,'0','Down'),(2,1,'1','Up'),(3,2,'0','Up'),(4,2,'2','Unreachable'),(13,6,'1','Other'),(14,6,'2','OK'),(15,6,'3','Degraded'),(17,7,'1','Other'),(18,7,'2','Unknown'),(19,7,'3','OK'),(20,7,'4','NonCritical'),(21,7,'5','Critical'),(22,7,'6','NonRecoverable'),(23,5,'1','unknown'),(24,5,'2','batteryNormal'),(25,5,'3','batteryLow'),(26,4,'1','unknown'),(27,4,'2','notInstalled'),(28,4,'3','ok'),(29,4,'4','failed'),(30,4,'5','highTemperature'),(31,4,'6','replaceImmediately'),(32,4,'7','lowCapacity'),(33,3,'0','Running'),(34,3,'1','Paused'),(35,3,'3','Pause pending'),(36,3,'4','Continue pending'),(37,3,'5','Stop pending'),(38,3,'6','Stopped'),(39,3,'7','Unknown'),(40,3,'255','No such service'),(41,3,'2','Start pending'),(49,9,'1','unknown'),(50,9,'2','running'),(51,9,'3','warning'),(52,9,'4','testing'),(53,9,'5','down'),(61,8,'1','up'),(62,8,'2','down'),(63,8,'3','testing'),(64,8,'4','unknown'),(65,8,'5','dormant'),(66,8,'6','notPresent'),(67,8,'7','lowerLayerDown'),(68,10,'1','Up'),(69,11,'1','up'),(70,11,'2','down'),(71,11,'3','testing');
/*!40000 ALTER TABLE `mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `sendto` varchar(100) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '63',
  `period` varchar(100) NOT NULL DEFAULT '1-7,00:00-24:00',
  PRIMARY KEY (`mediaid`),
  KEY `media_1` (`userid`),
  KEY `media_2` (`mediatypeid`),
  CONSTRAINT `c_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_type` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(100) NOT NULL DEFAULT '',
  `smtp_server` varchar(255) NOT NULL DEFAULT '',
  `smtp_helo` varchar(255) NOT NULL DEFAULT '',
  `smtp_email` varchar(255) NOT NULL DEFAULT '',
  `exec_path` varchar(255) NOT NULL DEFAULT '',
  `gsm_modem` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `passwd` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mediatypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
INSERT INTO `media_type` VALUES (1,0,'Email','mail.company.com','company.com','zabbix@company.com','','','','',0),(2,3,'Jabber','','','','','','jabber@company.com','zabbix',0),(3,2,'SMS','','','','','/dev/ttyS0','','',0);
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_cksum`
--

DROP TABLE IF EXISTS `node_cksum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_cksum` (
  `nodeid` int(11) NOT NULL,
  `tablename` varchar(64) NOT NULL DEFAULT '',
  `recordid` bigint(20) unsigned NOT NULL,
  `cksumtype` int(11) NOT NULL DEFAULT '0',
  `cksum` text NOT NULL,
  `sync` char(128) NOT NULL DEFAULT '',
  KEY `node_cksum_1` (`nodeid`,`cksumtype`,`tablename`,`recordid`),
  CONSTRAINT `c_node_cksum_1` FOREIGN KEY (`nodeid`) REFERENCES `nodes` (`nodeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_cksum`
--

LOCK TABLES `node_cksum` WRITE;
/*!40000 ALTER TABLE `node_cksum` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_cksum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nodes`
--

DROP TABLE IF EXISTS `nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodes` (
  `nodeid` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '10051',
  `nodetype` int(11) NOT NULL DEFAULT '0',
  `masterid` int(11) DEFAULT NULL,
  PRIMARY KEY (`nodeid`),
  KEY `c_nodes_1` (`masterid`),
  CONSTRAINT `c_nodes_1` FOREIGN KEY (`masterid`) REFERENCES `nodes` (`nodeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nodes`
--

LOCK TABLES `nodes` WRITE;
/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand`
--

DROP TABLE IF EXISTS `opcommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand` (
  `operationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `scriptid` bigint(20) unsigned DEFAULT NULL,
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` varchar(64) NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `command` text NOT NULL,
  PRIMARY KEY (`operationid`),
  KEY `c_opcommand_2` (`scriptid`),
  CONSTRAINT `c_opcommand_2` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`),
  CONSTRAINT `c_opcommand_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand`
--

LOCK TABLES `opcommand` WRITE;
/*!40000 ALTER TABLE `opcommand` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_grp`
--

DROP TABLE IF EXISTS `opcommand_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_grp` (
  `opcommand_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opcommand_grpid`),
  KEY `opcommand_grp_1` (`operationid`),
  KEY `c_opcommand_grp_2` (`groupid`),
  CONSTRAINT `c_opcommand_grp_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_opcommand_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_grp`
--

LOCK TABLES `opcommand_grp` WRITE;
/*!40000 ALTER TABLE `opcommand_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_hst`
--

DROP TABLE IF EXISTS `opcommand_hst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_hst` (
  `opcommand_hstid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`opcommand_hstid`),
  KEY `opcommand_hst_1` (`operationid`),
  KEY `c_opcommand_hst_2` (`hostid`),
  CONSTRAINT `c_opcommand_hst_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_opcommand_hst_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_hst`
--

LOCK TABLES `opcommand_hst` WRITE;
/*!40000 ALTER TABLE `opcommand_hst` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_hst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opconditions`
--

DROP TABLE IF EXISTS `opconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opconditions` (
  `opconditionid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`opconditionid`),
  KEY `opconditions_1` (`operationid`),
  CONSTRAINT `c_opconditions_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opconditions`
--

LOCK TABLES `opconditions` WRITE;
/*!40000 ALTER TABLE `opconditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `opconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `operationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `operationtype` int(11) NOT NULL DEFAULT '0',
  `esc_period` int(11) NOT NULL DEFAULT '0',
  `esc_step_from` int(11) NOT NULL DEFAULT '1',
  `esc_step_to` int(11) NOT NULL DEFAULT '1',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  KEY `operations_1` (`actionid`),
  CONSTRAINT `c_operations_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (1,2,6,0,1,1,0),(2,2,4,0,1,1,0),(3,3,0,0,1,1,0),(4,4,2,0,1,1,0),(5,4,4,0,1,1,0),(6,4,6,0,1,1,0);
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opgroup` (
  `opgroupid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opgroupid`),
  UNIQUE KEY `opgroup_1` (`operationid`,`groupid`),
  KEY `c_opgroup_2` (`groupid`),
  CONSTRAINT `c_opgroup_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_opgroup_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
INSERT INTO `opgroup` VALUES (1,2,2),(3,5,2),(2,5,6);
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage`
--

DROP TABLE IF EXISTS `opmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage` (
  `operationid` bigint(20) unsigned NOT NULL,
  `default_msg` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`operationid`),
  KEY `c_opmessage_2` (`mediatypeid`),
  CONSTRAINT `c_opmessage_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`),
  CONSTRAINT `c_opmessage_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage`
--

LOCK TABLES `opmessage` WRITE;
/*!40000 ALTER TABLE `opmessage` DISABLE KEYS */;
INSERT INTO `opmessage` VALUES (3,1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}',NULL);
/*!40000 ALTER TABLE `opmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_grp`
--

DROP TABLE IF EXISTS `opmessage_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_grp` (
  `opmessage_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_grpid`),
  UNIQUE KEY `opmessage_grp_1` (`operationid`,`usrgrpid`),
  KEY `c_opmessage_grp_2` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_grp`
--

LOCK TABLES `opmessage_grp` WRITE;
/*!40000 ALTER TABLE `opmessage_grp` DISABLE KEYS */;
INSERT INTO `opmessage_grp` VALUES (1,3,7);
/*!40000 ALTER TABLE `opmessage_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_usr`
--

DROP TABLE IF EXISTS `opmessage_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_usr` (
  `opmessage_usrid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_usrid`),
  UNIQUE KEY `opmessage_usr_1` (`operationid`,`userid`),
  KEY `c_opmessage_usr_2` (`userid`),
  CONSTRAINT `c_opmessage_usr_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `c_opmessage_usr_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_usr`
--

LOCK TABLES `opmessage_usr` WRITE;
/*!40000 ALTER TABLE `opmessage_usr` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optemplate`
--

DROP TABLE IF EXISTS `optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `optemplate` (
  `optemplateid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`optemplateid`),
  UNIQUE KEY `optemplate_1` (`operationid`,`templateid`),
  KEY `c_optemplate_2` (`templateid`),
  CONSTRAINT `c_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_optemplate_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optemplate`
--

LOCK TABLES `optemplate` WRITE;
/*!40000 ALTER TABLE `optemplate` DISABLE KEYS */;
INSERT INTO `optemplate` VALUES (1,1,10001),(2,6,10102);
/*!40000 ALTER TABLE `optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `profileid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `idx` varchar(96) NOT NULL DEFAULT '',
  `idx2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) NOT NULL DEFAULT '',
  `source` varchar(96) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profileid`),
  KEY `profiles_1` (`userid`,`idx`,`idx2`),
  KEY `profiles_2` (`userid`,`profileid`),
  CONSTRAINT `c_profiles_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,'web.login.attempt.failed',0,0,0,'','',2),(2,1,'web.login.attempt.ip',0,0,0,'10.0.2.2','',3),(3,1,'web.login.attempt.clock',0,0,1370851694,'','',2),(4,1,'web.menu.view.last',0,0,0,'dashboard.php','',3),(5,1,'web.paging.lastpage',0,0,0,'actionconf.php','',3),(6,1,'web.menu.config.last',0,0,0,'actionconf.php','',3),(7,1,'web.templates.php.sort',0,0,0,'name','',3),(8,1,'web.templates.php.sortorder',0,0,0,'ASC','',3),(9,1,'web.templates.php.groupid',0,0,0,'','',1),(10,1,'web.latest.groupid',0,1,0,'','',1),(11,1,'web.paging.page',0,0,1,'','',2),(12,1,'web.actionconf.php.sort',0,0,0,'name','',3),(13,1,'web.actionconf.php.sortorder',0,0,0,'ASC','',3),(14,1,'web.actionconf.eventsource',0,0,2,'','',2),(15,1,'web.hostgroups.php.sort',0,0,0,'name','',3),(16,1,'web.hostgroups.php.sortorder',0,0,0,'ASC','',3),(17,1,'web.reports.groupid',0,1,0,'','',1);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_autoreg_host`
--

DROP TABLE IF EXISTS `proxy_autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_autoreg_host` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `host` varchar(64) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `proxy_autoreg_host_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_autoreg_host`
--

LOCK TABLES `proxy_autoreg_host` WRITE;
/*!40000 ALTER TABLE `proxy_autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_dhistory`
--

DROP TABLE IF EXISTS `proxy_dhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_dhistory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned DEFAULT NULL,
  `dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `proxy_dhistory_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_dhistory`
--

LOCK TABLES `proxy_dhistory` WRITE;
/*!40000 ALTER TABLE `proxy_dhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_dhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_history`
--

DROP TABLE IF EXISTS `proxy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` longtext NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `proxy_history_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_history`
--

LOCK TABLES `proxy_history` WRITE;
/*!40000 ALTER TABLE `proxy_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regexps`
--

DROP TABLE IF EXISTS `regexps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regexps` (
  `regexpid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `test_string` text NOT NULL,
  PRIMARY KEY (`regexpid`),
  KEY `regexps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regexps`
--

LOCK TABLES `regexps` WRITE;
/*!40000 ALTER TABLE `regexps` DISABLE KEYS */;
INSERT INTO `regexps` VALUES (1,'File systems for discovery','ext3'),(2,'Network interfaces for discovery','eth0'),(3,'Storage devices for SNMP discovery','/boot');
/*!40000 ALTER TABLE `regexps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `rightid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '0',
  `id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`rightid`),
  KEY `rights_1` (`groupid`),
  KEY `rights_2` (`id`),
  CONSTRAINT `c_rights_2` FOREIGN KEY (`id`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_rights_1` FOREIGN KEY (`groupid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens` (
  `screenid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `hsize` int(11) NOT NULL DEFAULT '1',
  `vsize` int(11) NOT NULL DEFAULT '1',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`screenid`),
  KEY `c_screens_1` (`templateid`),
  CONSTRAINT `c_screens_1` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens`
--

LOCK TABLES `screens` WRITE;
/*!40000 ALTER TABLE `screens` DISABLE KEYS */;
INSERT INTO `screens` VALUES (3,'System performance',2,2,10001),(4,'Zabbix server health',2,2,10047),(5,'System performance',2,1,10076),(6,'System performance',2,1,10077),(7,'System performance',2,1,10075),(9,'System performance',2,2,10074),(10,'System performance',2,1,10078),(15,'MySQL performance',2,1,10073),(16,'Zabbix server',2,2,NULL);
/*!40000 ALTER TABLE `screens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens_items`
--

DROP TABLE IF EXISTS `screens_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens_items` (
  `screenitemid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '320',
  `height` int(11) NOT NULL DEFAULT '200',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `colspan` int(11) NOT NULL DEFAULT '0',
  `rowspan` int(11) NOT NULL DEFAULT '0',
  `elements` int(11) NOT NULL DEFAULT '25',
  `valign` int(11) NOT NULL DEFAULT '0',
  `halign` int(11) NOT NULL DEFAULT '0',
  `style` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `dynamic` int(11) NOT NULL DEFAULT '0',
  `sort_triggers` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`screenitemid`),
  KEY `c_screens_items_1` (`screenid`),
  CONSTRAINT `c_screens_items_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens_items`
--

LOCK TABLES `screens_items` WRITE;
/*!40000 ALTER TABLE `screens_items` DISABLE KEYS */;
INSERT INTO `screens_items` VALUES (20,3,0,433,500,120,0,0,1,1,0,1,0,0,'',0,0),(21,3,0,387,500,100,0,1,1,1,0,1,0,0,'',0,0),(22,3,1,10013,500,148,1,0,1,1,0,1,0,0,'',0,0),(23,3,1,22181,500,184,1,1,1,1,0,1,0,0,'',0,0),(24,4,0,392,500,212,0,0,1,1,0,1,0,0,'',0,0),(25,4,0,404,500,100,1,0,1,1,0,1,0,0,'',0,0),(26,4,0,406,500,100,0,1,1,1,0,1,0,0,'',0,0),(27,4,0,410,500,128,1,1,1,1,0,1,0,0,'',0,0),(28,5,0,469,500,148,0,0,1,1,0,1,0,0,'',0,0),(30,6,0,475,500,114,0,0,1,1,0,1,0,0,'',0,0),(31,6,0,474,500,100,1,0,1,1,0,1,0,0,'',0,0),(32,7,0,463,500,120,0,0,1,1,0,1,0,0,'',0,0),(33,7,0,462,500,106,1,0,1,1,0,1,0,0,'',0,0),(36,9,0,457,500,120,0,0,1,1,0,1,0,0,'',0,0),(37,9,0,456,500,106,1,0,1,1,0,1,0,0,'',0,0),(38,9,0,493,500,100,0,1,1,1,0,1,0,0,'',0,0),(39,9,0,458,615,276,1,1,1,1,0,1,0,0,'',0,0),(40,10,0,481,500,114,0,0,1,1,0,1,0,0,'',0,0),(41,10,0,480,500,100,1,0,1,1,0,1,0,0,'',0,0),(42,15,0,454,500,200,0,0,1,1,0,1,0,0,'',0,0),(43,15,0,455,500,270,1,0,1,1,0,1,0,0,'',0,0),(44,16,2,1,500,100,0,0,2,0,0,0,0,0,'',0,0),(45,16,0,524,400,156,0,1,1,1,0,0,0,0,'',0,0),(46,16,0,525,400,100,1,1,1,1,0,0,0,0,'',0,0);
/*!40000 ALTER TABLE `screens_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `command` varchar(255) NOT NULL DEFAULT '',
  `host_access` int(11) NOT NULL DEFAULT '2',
  `usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `description` text NOT NULL,
  `confirmation` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`scriptid`),
  KEY `c_scripts_1` (`usrgrpid`),
  KEY `c_scripts_2` (`groupid`),
  CONSTRAINT `c_scripts_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_scripts_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
INSERT INTO `scripts` VALUES (1,'Ping','/bin/ping -c 3 {HOST.CONN} 2>&1',2,NULL,NULL,'','',0,1),(2,'Traceroute','/usr/bin/traceroute {HOST.CONN} 2>&1',2,NULL,NULL,'','',0,1),(3,'Detect operating system','sudo /usr/bin/nmap -O {HOST.CONN} 2>&1',2,7,NULL,'','',0,1);
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_alarms`
--

DROP TABLE IF EXISTS `service_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_alarms` (
  `servicealarmid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicealarmid`),
  KEY `service_alarms_1` (`serviceid`,`clock`),
  KEY `service_alarms_2` (`clock`),
  CONSTRAINT `c_service_alarms_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_alarms`
--

LOCK TABLES `service_alarms` WRITE;
/*!40000 ALTER TABLE `service_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serviceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `algorithm` int(11) NOT NULL DEFAULT '0',
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `showsla` int(11) NOT NULL DEFAULT '0',
  `goodsla` double(16,4) NOT NULL DEFAULT '99.9000',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceid`),
  KEY `services_1` (`triggerid`),
  CONSTRAINT `c_services_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_links`
--

DROP TABLE IF EXISTS `services_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `serviceupid` bigint(20) unsigned NOT NULL,
  `servicedownid` bigint(20) unsigned NOT NULL,
  `soft` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `services_links_links_2` (`serviceupid`,`servicedownid`),
  KEY `services_links_links_1` (`servicedownid`),
  CONSTRAINT `c_services_links_2` FOREIGN KEY (`servicedownid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_services_links_1` FOREIGN KEY (`serviceupid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_links`
--

LOCK TABLES `services_links` WRITE;
/*!40000 ALTER TABLE `services_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_times`
--

DROP TABLE IF EXISTS `services_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_times` (
  `timeid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ts_from` int(11) NOT NULL DEFAULT '0',
  `ts_to` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`timeid`),
  KEY `services_times_times_1` (`serviceid`,`type`,`ts_from`,`ts_to`),
  CONSTRAINT `c_services_times_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_times`
--

LOCK TABLES `services_times` WRITE;
/*!40000 ALTER TABLE `services_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sessionid` varchar(32) NOT NULL DEFAULT '',
  `userid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sessionid`),
  KEY `sessions_1` (`userid`,`status`),
  CONSTRAINT `c_sessions_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('2225b3f700651caa4e589f5375cb714f',2,1370851592,0),('2830b5b5b1e4c86f82c9b1ba797d4b9c',2,1370851587,0),('3257d5bebdca54cae198c0fbc50a52fd',2,1371306983,0),('4560f0bebe8cd669edc5217c2e0b8469',1,1371306983,1),('908dcf4ae315f08f77b5f103c0dead23',2,1370851598,0);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slides`
--

DROP TABLE IF EXISTS `slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slides` (
  `slideid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `delay` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideid`),
  KEY `slides_slides_1` (`slideshowid`),
  KEY `c_slides_2` (`screenid`),
  CONSTRAINT `c_slides_2` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_slides_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slides`
--

LOCK TABLES `slides` WRITE;
/*!40000 ALTER TABLE `slides` DISABLE KEYS */;
/*!40000 ALTER TABLE `slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshows`
--

DROP TABLE IF EXISTS `slideshows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshows` (
  `slideshowid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideshowid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshows`
--

LOCK TABLES `slideshows` WRITE;
/*!40000 ALTER TABLE `slideshows` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_url`
--

DROP TABLE IF EXISTS `sysmap_element_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_url` (
  `sysmapelementurlid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`sysmapelementurlid`),
  UNIQUE KEY `sysmap_element_url_1` (`selementid`,`name`),
  CONSTRAINT `c_sysmap_element_url_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_url`
--

LOCK TABLES `sysmap_element_url` WRITE;
/*!40000 ALTER TABLE `sysmap_element_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_url`
--

DROP TABLE IF EXISTS `sysmap_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_url` (
  `sysmapurlid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapurlid`),
  UNIQUE KEY `sysmap_url_1` (`sysmapid`,`name`),
  CONSTRAINT `c_sysmap_url_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_url`
--

LOCK TABLES `sysmap_url` WRITE;
/*!40000 ALTER TABLE `sysmap_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps`
--

DROP TABLE IF EXISTS `sysmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps` (
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '600',
  `height` int(11) NOT NULL DEFAULT '400',
  `backgroundid` bigint(20) unsigned DEFAULT NULL,
  `label_type` int(11) NOT NULL DEFAULT '2',
  `label_location` int(11) NOT NULL DEFAULT '3',
  `highlight` int(11) NOT NULL DEFAULT '1',
  `expandproblem` int(11) NOT NULL DEFAULT '1',
  `markelements` int(11) NOT NULL DEFAULT '0',
  `show_unack` int(11) NOT NULL DEFAULT '0',
  `grid_size` int(11) NOT NULL DEFAULT '50',
  `grid_show` int(11) NOT NULL DEFAULT '1',
  `grid_align` int(11) NOT NULL DEFAULT '1',
  `label_format` int(11) NOT NULL DEFAULT '0',
  `label_type_host` int(11) NOT NULL DEFAULT '2',
  `label_type_hostgroup` int(11) NOT NULL DEFAULT '2',
  `label_type_trigger` int(11) NOT NULL DEFAULT '2',
  `label_type_map` int(11) NOT NULL DEFAULT '2',
  `label_type_image` int(11) NOT NULL DEFAULT '2',
  `label_string_host` varchar(255) NOT NULL DEFAULT '',
  `label_string_hostgroup` varchar(255) NOT NULL DEFAULT '',
  `label_string_trigger` varchar(255) NOT NULL DEFAULT '',
  `label_string_map` varchar(255) NOT NULL DEFAULT '',
  `label_string_image` varchar(255) NOT NULL DEFAULT '',
  `iconmapid` bigint(20) unsigned DEFAULT NULL,
  `expand_macros` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapid`),
  KEY `sysmaps_1` (`name`),
  KEY `c_sysmaps_1` (`backgroundid`),
  KEY `c_sysmaps_2` (`iconmapid`),
  CONSTRAINT `c_sysmaps_2` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`),
  CONSTRAINT `c_sysmaps_1` FOREIGN KEY (`backgroundid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps`
--

LOCK TABLES `sysmaps` WRITE;
/*!40000 ALTER TABLE `sysmaps` DISABLE KEYS */;
INSERT INTO `sysmaps` VALUES (1,'Local network',680,200,NULL,0,0,1,1,1,0,50,1,1,0,2,2,2,2,2,'','','','','',NULL,1);
/*!40000 ALTER TABLE `sysmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_elements`
--

DROP TABLE IF EXISTS `sysmaps_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_elements` (
  `selementid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `elementid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  `iconid_off` bigint(20) unsigned DEFAULT NULL,
  `iconid_on` bigint(20) unsigned DEFAULT NULL,
  `label` varchar(255) NOT NULL DEFAULT '',
  `label_location` int(11) DEFAULT NULL,
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `iconid_disabled` bigint(20) unsigned DEFAULT NULL,
  `iconid_maintenance` bigint(20) unsigned DEFAULT NULL,
  `elementsubtype` int(11) NOT NULL DEFAULT '0',
  `areatype` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `viewtype` int(11) NOT NULL DEFAULT '0',
  `use_iconmap` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`selementid`),
  KEY `c_sysmaps_elements_1` (`sysmapid`),
  KEY `c_sysmaps_elements_2` (`iconid_off`),
  KEY `c_sysmaps_elements_3` (`iconid_on`),
  KEY `c_sysmaps_elements_4` (`iconid_disabled`),
  KEY `c_sysmaps_elements_5` (`iconid_maintenance`),
  CONSTRAINT `c_sysmaps_elements_5` FOREIGN KEY (`iconid_maintenance`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_elements_2` FOREIGN KEY (`iconid_off`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_3` FOREIGN KEY (`iconid_on`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_4` FOREIGN KEY (`iconid_disabled`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_elements`
--

LOCK TABLES `sysmaps_elements` WRITE;
/*!40000 ALTER TABLE `sysmaps_elements` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_link_triggers`
--

DROP TABLE IF EXISTS `sysmaps_link_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_link_triggers` (
  `linktriggerid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`linktriggerid`),
  UNIQUE KEY `sysmaps_link_triggers_1` (`linkid`,`triggerid`),
  KEY `c_sysmaps_link_triggers_2` (`triggerid`),
  CONSTRAINT `c_sysmaps_link_triggers_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_link_triggers_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_link_triggers`
--

LOCK TABLES `sysmaps_link_triggers` WRITE;
/*!40000 ALTER TABLE `sysmaps_link_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_link_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_links`
--

DROP TABLE IF EXISTS `sysmaps_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `selementid1` bigint(20) unsigned NOT NULL,
  `selementid2` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  `label` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`linkid`),
  KEY `c_sysmaps_links_1` (`sysmapid`),
  KEY `c_sysmaps_links_2` (`selementid1`),
  KEY `c_sysmaps_links_3` (`selementid2`),
  CONSTRAINT `c_sysmaps_links_3` FOREIGN KEY (`selementid2`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_2` FOREIGN KEY (`selementid1`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_links`
--

LOCK TABLES `sysmaps_links` WRITE;
/*!40000 ALTER TABLE `sysmaps_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeperiods`
--

DROP TABLE IF EXISTS `timeperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeperiods` (
  `timeperiodid` bigint(20) unsigned NOT NULL,
  `timeperiod_type` int(11) NOT NULL DEFAULT '0',
  `every` int(11) NOT NULL DEFAULT '0',
  `month` int(11) NOT NULL DEFAULT '0',
  `dayofweek` int(11) NOT NULL DEFAULT '0',
  `day` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `start_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`timeperiodid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeperiods`
--

LOCK TABLES `timeperiods` WRITE;
/*!40000 ALTER TABLE `timeperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends`
--

DROP TABLE IF EXISTS `trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_avg` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_max` double(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends`
--

LOCK TABLES `trends` WRITE;
/*!40000 ALTER TABLE `trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends_uint`
--

DROP TABLE IF EXISTS `trends_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_avg` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends_uint`
--

LOCK TABLES `trends_uint` WRITE;
/*!40000 ALTER TABLE `trends_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_depends`
--

DROP TABLE IF EXISTS `trigger_depends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_depends` (
  `triggerdepid` bigint(20) unsigned NOT NULL,
  `triggerid_down` bigint(20) unsigned NOT NULL,
  `triggerid_up` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerdepid`),
  UNIQUE KEY `trigger_depends_1` (`triggerid_down`,`triggerid_up`),
  KEY `trigger_depends_2` (`triggerid_up`),
  CONSTRAINT `c_trigger_depends_2` FOREIGN KEY (`triggerid_up`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_depends_1` FOREIGN KEY (`triggerid_down`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_depends`
--

LOCK TABLES `trigger_depends` WRITE;
/*!40000 ALTER TABLE `trigger_depends` DISABLE KEYS */;
INSERT INTO `trigger_depends` VALUES (1,13295,13321),(3,13296,13295),(2,13296,13321),(4,13297,13321),(5,13298,13297),(6,13298,13321),(7,13299,13321),(9,13300,13299),(8,13300,13321),(10,13301,13321),(12,13302,13301),(11,13302,13321),(13,13303,13322),(14,13304,13303),(15,13304,13322),(16,13305,13322),(17,13306,13321),(18,13307,13305),(19,13307,13322),(20,13308,13306),(21,13308,13321),(22,13311,13309),(23,13312,13310),(24,13313,13321),(25,13314,13322),(26,13315,13313),(27,13315,13321),(28,13316,13314),(29,13316,13322),(30,13318,13317),(31,13319,13321),(32,13320,13319),(33,13320,13321),(34,13323,13321),(35,13324,13321),(36,13324,13323),(37,13325,13321),(38,13326,13321),(39,13326,13325);
/*!40000 ALTER TABLE `trigger_depends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_discovery`
--

DROP TABLE IF EXISTS `trigger_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_discovery` (
  `triggerdiscoveryid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `parent_triggerid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`triggerdiscoveryid`),
  UNIQUE KEY `trigger_discovery_1` (`triggerid`,`parent_triggerid`),
  KEY `c_trigger_discovery_2` (`parent_triggerid`),
  CONSTRAINT `c_trigger_discovery_2` FOREIGN KEY (`parent_triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_discovery_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_discovery`
--

LOCK TABLES `trigger_discovery` WRITE;
/*!40000 ALTER TABLE `trigger_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `lastchange` int(11) NOT NULL DEFAULT '0',
  `comments` text NOT NULL,
  `error` varchar(128) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `value_flags` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`triggerid`),
  KEY `triggers_1` (`status`),
  KEY `triggers_2` (`value`),
  KEY `c_triggers_1` (`templateid`),
  CONSTRAINT `c_triggers_1` FOREIGN KEY (`templateid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggers`
--

LOCK TABLES `triggers` WRITE;
/*!40000 ALTER TABLE `triggers` DISABLE KEYS */;
INSERT INTO `triggers` VALUES (10010,'{12586}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(10011,'{12555}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(10012,'{12580}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(10016,'{10199}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(10021,'{12583}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(10041,'{10204}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10042,'{12553}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10043,'{10208}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10044,'{10207}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10045,'{12927}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(10047,'{12550}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(10190,'{10233}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13000,'{12144}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13015,'{12641}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0),(13017,'{12651}<25','Less than 25% free in the text history cache','',0,0,3,0,'','',NULL,0,0,0),(13019,'{12649}<25','Less than 25% free in the trends cache','',0,0,3,0,'','',NULL,0,0,0),(13023,'{12653}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0),(13025,'{12549}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',NULL,0,0,0),(13026,'{12926}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13073,'{12645}<25','Less than 25% free in the history cache','',0,0,3,0,'','',NULL,0,0,0),(13080,'{12639}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13081,'{12637}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13082,'{12635}>75','Zabbix db watchdog processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13083,'{12631}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13084,'{12629}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13085,'{12627}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13086,'{12655}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13087,'{12623}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13088,'{12621}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13089,'{12619}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13090,'{12617}>75','Zabbix node watcher processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13091,'{12605}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13092,'{12609}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13093,'{12615}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13094,'{12607}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'Timer processes usually are busy because they have to process time based trigger functions','',NULL,0,0,0),(13095,'{12611}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13096,'{12613}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13133,'{12661}=0','SSH service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13134,'{12333}=0','IMAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13135,'{12334}=0','POP3 service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13136,'{12335}=0','HTTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13137,'{12336}=0','FTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13138,'{12345}=0','NNTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13139,'{12657}>1','ICMP ping response too slow from {HOST.NAME}','',0,0,2,0,'Host reponses to ICMP ping but too slowly. Might be CPU load on host or network traffic causing this.','',NULL,0,0,0),(13243,'{12589}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0),(13266,'{12592}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13272,'{12598}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13275,'{12647}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13277,'{12659}=0','HTTPS service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13279,'{12663}=0','LDAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13281,'{12665}=0','NTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13283,'{12667}=0','SMTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13285,'{12669}=0','Telnet service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13287,'{12671}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',NULL,0,0,2),(13288,'{12672}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',13287,0,0,2),(13289,'{12673}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',13287,0,0,2),(13291,'{12675} / {12676} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',NULL,0,0,2),(13292,'{12677} / {12678} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',13291,0,0,2),(13293,'{12679} / {12680} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',13291,0,0,2),(13294,'{12681}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',13287,0,0,2),(13295,'{12682}<5 | {12682}>90','Baseboard Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13296,'{12683}<10 | {12683}>83','Baseboard Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13297,'{12684}<0.953 | {12684}>1.149','BB +1.05V PCH Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13298,'{12685}<0.985 | {12685}>1.117','BB +1.05V PCH Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13299,'{12686}<0.683 | {12686}>1.543','BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13300,'{12687}<0.708 | {12687}>1.501','BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13301,'{12688}<1.362 | {12688}>1.635','BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13302,'{12689}<1.401 | {12689}>1.589','BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13303,'{12690}<1.597 | {12690}>2.019','BB +1.8V SM Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13304,'{12691}<1.646 | {12691}>1.960','BB +1.8V SM Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13305,'{12692}<2.876 | {12692}>3.729','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13306,'{12693}<2.982 | {12693}>3.625','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13307,'{12694}<2.970 | {12694}>3.618','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13308,'{12695}<3.067 | {12695}>3.525','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13309,'{12696}<2.876 | {12696}>3.729','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13310,'{12697}<2.982 | {12697}>3.625','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13311,'{12698}<2.970 | {12698}>3.618','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13312,'{12699}<3.067 | {12699}>3.525','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13313,'{12700}<4.471 | {12700}>5.538','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13314,'{12701}<4.362 | {12701}>5.663','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13315,'{12702}<4.630 | {12702}>5.380','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13316,'{12703}<4.483 | {12703}>5.495','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13317,'{12704}<5 | {12704}>66','BB Ambient Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13318,'{12705}<10 | {12705}>61','BB Ambient Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13319,'{12706}<0 | {12706}>48','Front Panel Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13320,'{12707}<5 | {12707}>44','Front Panel Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13321,'{12708}=0','Power','',0,0,2,0,'','',NULL,0,0,0),(13322,'{12709}=0','Power','',0,0,2,0,'','',NULL,0,0,0),(13323,'{12710}<324','System Fan 2 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13324,'{12711}<378','System Fan 2 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13325,'{12712}<324','System Fan 3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13326,'{12713}<378','System Fan 3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13327,'{12714}=0','MySQL is down','',0,0,2,0,'','',NULL,0,0,0),(13328,'{12715}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13329,'{12929}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13330,'{12717}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13331,'{12718}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13332,'{12719}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13333,'{12720}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13334,'{12721}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13336,'{12723}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13337,'{12724}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(13338,'{12725}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13339,'{12726}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13340,'{12727}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13341,'{12728}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13342,'{12729}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13343,'{12730}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13344,'{12731}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13345,'{12930}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13346,'{12733}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13347,'{12734}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13348,'{12735}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13349,'{12736}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13350,'{12737}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13352,'{12739}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13353,'{12740}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(13354,'{12741}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13355,'{12742}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13356,'{12743}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13357,'{12744}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13358,'{12745}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13359,'{12746}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13360,'{12747}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13361,'{12931}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13364,'{12751}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13365,'{12752}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13366,'{12753}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13367,'{12828}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0),(13368,'{12755}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13370,'{12757}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13371,'{12758}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13372,'{12759}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13373,'{12760}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13374,'{12761}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13375,'{12762}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13376,'{12763}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13377,'{12932}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13382,'{12769}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13384,'{12771}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13386,'{12773}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13388,'{12775}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13389,'{12776}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13390,'{12777}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13391,'{12778}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13392,'{12779}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13393,'{12933}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13395,'{12782}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13396,'{12783}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13397,'{12784}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13398,'{12785}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13399,'{12786}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0),(13400,'{12787}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13401,'{12788}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(13402,'{12789}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13403,'{12790}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13404,'{12791}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13405,'{12792}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13406,'{12793}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13407,'{12794}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13408,'{12795}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13409,'{12934}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13410,'{12797}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13411,'{12798}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13414,'{12801}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13416,'{12803}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13418,'{12805}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13419,'{12806}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13420,'{12807}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13421,'{12808}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13422,'{12809}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13423,'{12810}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13425,'{12812}>0','Host information was changed on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13428,'{12815}<600','{HOST.NAME} has just been restarted','',0,0,3,0,'','',NULL,0,0,0),(13430,'{12817}>300','Too many processes on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13431,'{12818}<100000','Lack of free swap space on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13433,'{12820}<10000','Lack of free memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13435,'{12822}>5','Processor load is too high on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13437,'{12824}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13438,'{12935}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13439,'{12826}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13441,'{12829}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13442,'{12830} > ({12831} * 0.7)','70% http-8080 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13443,'{12832} > ({12833} * 0.7)','70% http-8443 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13444,'{12834} > ({12835}  *0.7)','70% jk-8009 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13445,'{12836}>({12837}*0.7)','70% mp CMS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13446,'{12838}>({12839}*0.7)','70% mp CMS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13447,'{12840}>({12841}*0.7)','70% mp Code Cache used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13448,'{12842}>({12843}*0.7)','70% mp Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13449,'{12844}>({12845}*0.7)','70% mp PS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13450,'{12846}>({12847}*0.7)','70% mp PS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13451,'{12848}>({12849}*0.7)','70% mp Tenured Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13452,'{12850}>({12851}*0.7)','70% os Opened File Descriptor Count used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13453,'{12852}<{12853}','gc Concurrent Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13454,'{12854}<{12855}','gc Mark Sweep Compact in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13455,'{12856}<{12857}','gc PS Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13456,'{12858} = 1','gzip compression is off for connector http-8080 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13457,'{12859} = 1','gzip compression is off for connector http-8443 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13458,'{12860}={12861}','mp CMS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13459,'{12862}={12863}','mp CMS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13460,'{12864}={12865}','mp Code Cache fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13461,'{12866}={12867}','mp Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13462,'{12868}={12869}','mp PS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13463,'{12870}={12871}','mp PS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13464,'{12872}={12873}','mp Tenured Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13465,'{12874}=1','{HOST.NAME} is not reachable','',0,0,3,0,'','',NULL,0,0,0),(13466,'{12875}#1','{HOST.NAME} uses suboptimal jit compiler','',0,0,1,0,'','',NULL,0,0,0),(13467,'{12876}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',13080,0,0,0),(13468,'{12877}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',13081,0,0,0),(13469,'{12878}>75','Zabbix db watchdog processes more than 75% busy','',0,0,3,0,'','',13082,0,0,0),(13470,'{12879}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',13083,0,0,0),(13471,'{12880}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',13084,0,0,0),(13472,'{12881}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',13085,0,0,0),(13473,'{12882}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',13086,0,0,0),(13474,'{12883}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',13087,0,0,0),(13475,'{12884}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',13088,0,0,0),(13476,'{12885}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',13089,0,0,0),(13477,'{12886}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',13275,0,0,0),(13478,'{12887}>75','Zabbix node watcher processes more than 75% busy','',0,0,3,0,'','',13090,0,0,0),(13479,'{12888}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',13091,0,0,0),(13480,'{12889}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',13092,0,0,0),(13481,'{12890}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',13093,0,0,0),(13482,'{12891}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',13441,0,0,0),(13483,'{12892}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'Timer processes usually are busy because they have to process time based trigger functions','',13094,0,0,0),(13484,'{12893}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',13095,0,0,0),(13485,'{12894}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',13096,0,0,0),(13486,'{12895}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',13023,0,0,0),(13487,'{12896}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',13015,0,0,0),(13488,'{12897}<25','Less than 25% free in the history cache','',0,0,3,0,'','',13073,0,0,0),(13489,'{12898}<25','Less than 25% free in the text history cache','',0,0,3,0,'','',13017,0,0,0),(13490,'{12899}<25','Less than 25% free in the trends cache','',0,0,3,0,'','',13019,0,0,0),(13491,'{12900}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',10047,0,0,0),(13492,'{12928}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',10045,0,0,0),(13493,'{12902}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',10042,0,0,0),(13494,'{12903}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',10041,0,0,0),(13495,'{12904}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',10011,0,0,0),(13496,'{12905}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',10190,0,0,0),(13497,'{12906}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',10010,0,0,0),(13498,'{12907}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',13243,0,0,0),(13499,'{12908}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',10043,0,0,0),(13500,'{12909}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',10012,0,0,0),(13501,'{12910}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',10044,0,0,0),(13502,'{12911}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',10021,0,0,0),(13503,'{12912}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',10016,0,0,0),(13504,'{12913}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',13000,0,0,0),(13505,'{12914}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13272,0,0,2),(13506,'{12915}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13266,0,0,2),(13507,'{12936}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13508,'{12937}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13509,'{12938}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13508,0,0,0),(13510,'{12939}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13511,'{12940}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13512,'{12941}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13513,'{12942}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13514,'{12943}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13515,'{12944}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13516,'{12945}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13517,'{12946}/{12947}>{$LOADAVG15_MAX}','Processor load is too high on {HOSTNAME}','',0,0,3,1370856817,'','Trigger just added. No status update so far.',NULL,0,1,0),(13518,'{12948}>{$SWAP_OF_MEM}*{12949}','Too much data swapped out {HOSTNAME}','',0,0,2,1370856817,'','Trigger just added. No status update so far.',NULL,0,1,0),(13519,'{12950}/{12951}>{$LOADAVG15_MAX}','Processor load is too high on {HOSTNAME}','',0,0,3,1370856817,'','Trigger just added. No status update so far.',13517,0,1,0),(13520,'{12952}>{$SWAP_OF_MEM}*{12953}','Too much data swapped out {HOSTNAME}','',0,0,2,1370856817,'','Trigger just added. No status update so far.',13518,0,1,0),(13521,'{12954}>{$IOWAIT_MAX}','Wait on I/O is too high on {HOSTNAME}','',0,0,3,1370856818,'','Trigger just added. No status update so far.',NULL,0,1,0),(13522,'({12955}+{12956}+{12957})<{$MEMFREE_MIN}','Lack of free memory on server {HOSTNAME}','',0,0,3,1370856818,'','Trigger just added. No status update so far.',NULL,0,1,0),(13523,'{12958}+{12959}>{$SWAPIO_MAX}','Swap activity is too high on {HOSTNAME}','',0,0,3,1370856818,'testing mode. need level choice reasons.','Trigger just added. No status update so far.',NULL,0,1,0),(13524,'{12960}/{12961}>{$LOADAVG15_MAX}','Processor load is too high on {HOSTNAME}','',0,0,3,1370856817,'','Trigger just added. No status update so far.',13517,0,1,0),(13525,'{12962}>{$SWAP_OF_MEM}*{12963}','Too much data swapped out {HOSTNAME}','',0,0,2,1370856817,'','Trigger just added. No status update so far.',13518,0,1,0),(13526,'{12964}<600','{HOSTNAME} has just been restarted','',0,0,1,1370856819,'','Trigger just added. No status update so far.',NULL,0,1,0),(13527,'{12965}>0','Active agent on {HOSTNAME} not sending data','',0,0,4,1370856820,'','Trigger just added. No status update so far.',NULL,0,1,0),(13528,'{12966}=0','Agent version too old on {HOSTNAME}','',0,0,4,1370856820,'Customer is responsible for all the risks.\r\nThe Servise does not offer any support for possible problems.','Trigger just added. No status update so far.',NULL,0,1,0),(13529,'{12967}<1','Apache is not running on {HOSTNAME}','',1,0,3,1370856820,'','Trigger just added. No status update so far.',NULL,0,1,0),(13530,'{12968}<1','Inetd is not running on {HOSTNAME}','',1,0,3,1370856820,'','Trigger just added. No status update so far.',NULL,0,1,0),(13531,'{12969}<1','Mysql is not running on {HOSTNAME}','',1,0,3,1370856820,'','Trigger just added. No status update so far.',NULL,0,1,0),(13532,'{12970}<1','Sshd is not running on {HOSTNAME}','',1,0,3,1370856820,'','Trigger just added. No status update so far.',NULL,0,1,0),(13533,'{12971}<1','Syslogd is not running on {HOSTNAME}','',1,0,3,1370856820,'','Trigger just added. No status update so far.',NULL,0,1,0),(13534,'{12972}=0','Exim data collect error on {HOSTNAME}','',0,0,4,1370856821,'','Trigger just added. No status update so far.',NULL,0,1,0),(13535,'{12973}<1','Exim is not running on {HOSTNAME}','',0,0,5,1370856821,'','Trigger just added. No status update so far.',NULL,0,1,0),(13536,'({12974}<{$VOL0_FREE_MIN})&({12975}>4*{$VOL0_FREE_MIN})','Volume {$VOL_0} near full','',0,0,4,1370856821,'','Trigger just added. No status update so far.',NULL,0,1,0),(13537,'({12976}<{$VOL1_FREE_MIN})&({12977}>4*{$VOL1_FREE_MIN})','Volume {$VOL_1} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',NULL,0,1,0),(13538,'({12978}<{$VOL2_FREE_MIN})&({12979}>4*{$VOL2_FREE_MIN})','Volume {$VOL_2} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',NULL,0,1,0),(13539,'({12980}<{$VOL3_FREE_MIN})&({12981}>4*{$VOL3_FREE_MIN})','Volume {$VOL_3} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',NULL,0,1,0),(13540,'({12982}<{$VOL4_FREE_MIN})&({12983}>4*{$VOL4_FREE_MIN})','Volume {$VOL_4} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',NULL,0,1,0),(13541,'({12984}<{$VOL0_FREE_MIN})&({12985}>4*{$VOL0_FREE_MIN})','Volume {$VOL_0} near full','',0,0,4,1370856821,'','Trigger just added. No status update so far.',13536,0,1,0),(13542,'({12986}>4*{$VOL0_INODE_MIN})&({12987}<{$VOL0_INODE_MIN})','Volume {$VOL_0} inodes near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',NULL,0,1,0),(13543,'{12988}=1','Volume {$VOL_0} is readonly','',0,0,4,1370856822,'','Trigger just added. No status update so far.',NULL,0,1,0),(13544,'({12989}<{$VOL1_FREE_MIN})&({12990}>4*{$VOL1_FREE_MIN})','Volume {$VOL_1} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13537,0,1,0),(13545,'({12991}<{$VOL2_FREE_MIN})&({12992}>4*{$VOL2_FREE_MIN})','Volume {$VOL_2} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13538,0,1,0),(13546,'({12993}<{$VOL3_FREE_MIN})&({12994}>4*{$VOL3_FREE_MIN})','Volume {$VOL_3} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13539,0,1,0),(13547,'({12995}<{$VOL4_FREE_MIN})&({12996}>4*{$VOL4_FREE_MIN})','Volume {$VOL_4} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13540,0,1,0),(13548,'({12997}>4*{$VOL1_INODE_MIN})&({12998}<{$VOL1_INODE_MIN})','Volume {$VOL_1} inodes near full','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13549,'({12999}>4*{$VOL2_INODE_MIN})&({13000}<{$VOL2_INODE_MIN})','Volume {$VOL_2} inodes near full','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13550,'({13001}>4*{$VOL3_INODE_MIN})&({13002}<{$VOL3_INODE_MIN})','Volume {$VOL_3} inodes near full','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13551,'({13003}>4*{$VOL4_INODE_MIN})&({13004}<{$VOL4_INODE_MIN})','Volume {$VOL_4} inodes near full','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13552,'{13005}=1','Volume $1 is readonly','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13553,'{13006}=1','Volume $1 is readonly','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13554,'{13007}=1','Volume $1 is readonly','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13555,'{13008}=1','Volume $1 is readonly','',0,0,4,1370856823,'','Trigger just added. No status update so far.',NULL,0,1,0),(13556,'({13009}<{$VOL0_FREE_MIN})&({13010}>4*{$VOL0_FREE_MIN})','Volume {$VOL_0} near full','',0,0,4,1370856821,'','Trigger just added. No status update so far.',13536,0,1,0),(13557,'({13011}<{$VOL1_FREE_MIN})&({13012}>4*{$VOL1_FREE_MIN})','Volume {$VOL_1} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13537,0,1,0),(13558,'({13013}<{$VOL2_FREE_MIN})&({13014}>4*{$VOL2_FREE_MIN})','Volume {$VOL_2} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13538,0,1,0),(13559,'({13015}<{$VOL3_FREE_MIN})&({13016}>4*{$VOL3_FREE_MIN})','Volume {$VOL_3} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13539,0,1,0),(13560,'({13017}<{$VOL4_FREE_MIN})&({13018}>4*{$VOL4_FREE_MIN})','Volume {$VOL_4} near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13540,0,1,0),(13561,'{13019}>0','Active agent on {HOSTNAME} not sending data','',0,0,4,1370856820,'','Trigger just added. No status update so far.',13527,0,1,0),(13562,'{13020}=0','Agent version too old on {HOSTNAME}','',0,0,4,1370856820,'Customer is responsible for all the risks.\r\nThe Servise does not offer any support for possible problems.','Trigger just added. No status update so far.',13528,0,1,0),(13563,'({13021}>4*{$VOL0_INODE_MIN})&({13022}<{$VOL0_INODE_MIN})','Volume {$VOL_0} inodes near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13542,0,1,0),(13564,'({13023}<{$VOL0_FREE_MIN})&({13024}>4*{$VOL0_FREE_MIN})','Volume {$VOL_0} near full','',0,0,4,1370856821,'','Trigger just added. No status update so far.',13541,0,1,0),(13565,'{13025}=1','Volume {$VOL_0} is readonly','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13543,0,1,0),(13566,'{13026}<600','{HOSTNAME} has just been restarted','',0,0,1,1370856819,'','Trigger just added. No status update so far.',13526,0,1,0),(13567,'{13027}/{13028}>{$LOADAVG15_MAX}','Processor load is too high on {HOSTNAME}','',0,0,3,1370856817,'','Trigger just added. No status update so far.',13524,0,1,0),(13568,'{13029}>{$SWAP_OF_MEM}*{13030}','Too much data swapped out {HOSTNAME}','',0,0,2,1370856817,'','Trigger just added. No status update so far.',13525,0,1,0),(13569,'{13031}>0','Active agent on {HOSTNAME} not sending data','',0,0,4,1370856820,'','Trigger just added. No status update so far.',13527,0,1,0),(13570,'{13032}=0','Agent version too old on {HOSTNAME}','',0,0,4,1370856820,'Customer is responsible for all the risks.\r\nThe Servise does not offer any support for possible problems.','Trigger just added. No status update so far.',13528,0,1,0),(13571,'({13033}>4*{$VOL0_INODE_MIN})&({13034}<{$VOL0_INODE_MIN})','Volume {$VOL_0} inodes near full','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13542,0,1,0),(13572,'({13035}<{$VOL0_FREE_MIN})&({13036}>4*{$VOL0_FREE_MIN})','Volume {$VOL_0} near full','',0,0,4,1370856821,'','Trigger just added. No status update so far.',13541,0,1,0),(13573,'{13037}=1','Volume {$VOL_0} is readonly','',0,0,4,1370856822,'','Trigger just added. No status update so far.',13543,0,1,0),(13574,'{13038}<600','{HOSTNAME} has just been restarted','',0,0,1,1370856819,'','Trigger just added. No status update so far.',13526,0,1,0),(13575,'{13039}/{13040}>{$LOADAVG15_MAX}','Processor load is too high on {HOSTNAME}','',0,0,3,1370856817,'','Trigger just added. No status update so far.',13519,0,1,0),(13576,'{13041}>{$IOWAIT_MAX}','Wait on I/O is too high on {HOSTNAME}','',0,0,3,1370856818,'','Trigger just added. No status update so far.',13521,0,1,0),(13577,'{13042}>{$SWAP_OF_MEM}*{13043}','Too much data swapped out {HOSTNAME}','',0,0,2,1370856817,'','Trigger just added. No status update so far.',13520,0,1,0),(13578,'({13044}+{13045}+{13046})<{$MEMFREE_MIN}','Lack of free memory on server {HOSTNAME}','',0,0,3,1370856818,'','Trigger just added. No status update so far.',13522,0,1,0),(13579,'{13047}+{13048}>{$SWAPIO_MAX}','Swap activity is too high on {HOSTNAME}','',0,0,3,1370856818,'testing mode. need level choice reasons.','Trigger just added. No status update so far.',13523,0,1,0),(13580,'({13049}+{13050}+{13051})<{$MEMFREE_MIN}/{$PAGE_SIZE}','Lack of free memory on server {HOSTNAME}','',0,0,4,1370856831,'NOTE: the buffers doesn\'t counted.','Trigger just added. No status update so far.',NULL,0,1,0),(13581,'{13052}#0','EXNG: Service State - IMAP4','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13582,'{13053}#0','EXNG: Service State - Event','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13583,'{13054}#0','EXNG: Service State - Information Store','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13584,'{13055}#0','EXNG: Service State - Management','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13585,'{13056}#0','EXNG: Service State - MTA Stacks','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13586,'{13057}#0','EXNG: Service State - System Attendant','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13587,'{13058}#0','EXNG: Service State - Site Replication Service','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13588,'{13059}#0','EXNG: Service State - Network News Transfer Protocol (NNTP)','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13589,'{13060}#0','EXNG: Service State - POP3','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13590,'{13061}#0','EXNG: Service State - Routing Engine','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13591,'{13062}#0','EXNG: Service State - Simple Mail Transfer Protocol (SMTP)','',0,0,4,1370856832,'','Trigger just added. No status update so far.',NULL,0,1,0),(13592,'{13063}/{13064}>{$LOADAVG15_MAX}','Processor load is too high on {HOSTNAME}','',0,0,3,1370856817,'','Trigger just added. No status update so far.',13517,0,1,0),(13593,'{13065}>{$SWAP_OF_MEM}*{13066}','Too much data swapped out {HOSTNAME}','',0,0,2,1370856817,'','Trigger just added. No status update so far.',13518,0,1,0),(13594,'({13067}+{13068})<{$MEMFREE_MIN}','Lack of free memory on server {HOSTNAME}','',0,0,3,1370856833,'','Trigger just added. No status update so far.',NULL,0,1,0),(13595,'{13069}=0','{HOSTNAME} not responding to Ping','',0,0,4,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13596,'{13070}=0','FTP server is down on {HOSTNAME}','',0,0,3,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13597,'{13071}=0','WEB (HTTP) server is down on {HOSTNAME}','',0,0,3,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13598,'{13072}=0','IMAP server is down on {HOSTNAME}','',0,0,3,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13599,'{13073}=0','News (NNTP) server is down on {HOSTNAME}','',0,0,3,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13600,'{13074}=0','POP3 server is down on {HOSTNAME}','',0,0,3,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13601,'{13075}=0','Email (SMTP) server is down on {HOSTNAME}','',0,0,3,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13602,'{13076}=0','SSH server is down on {HOSTNAME}','',0,0,3,1370856834,'','Trigger just added. No status update so far.',NULL,0,1,0),(13603,'{13077}>0','Active agent on {HOSTNAME} not sending data','',0,0,4,1370856820,'','Trigger just added. No status update so far.',13527,0,1,0),(13604,'{13078}=0','Agent version too old on {HOSTNAME}','',0,0,4,1370856820,'Customer is responsible for all the risks.\r\nThe Servise does not offer any support for possible problems.','Trigger just added. No status update so far.',13528,0,1,0),(13605,'{13079}<600','{HOSTNAME} has just been restarted','',0,0,1,1370856819,'','Trigger just added. No status update so far.',13526,0,1,0),(13606,'{13080}/{13081}>{$LOADAVG15_MAX}','Processor load is too high on {HOSTNAME}','',0,0,3,1370856817,'','Trigger just added. No status update so far.',13592,0,1,0),(13607,'{13082}>{$SWAP_OF_MEM}*{13083}','Too much data swapped out {HOSTNAME}','',0,0,2,1370856817,'','Trigger just added. No status update so far.',13593,0,1,0),(13608,'({13084}+{13085})<{$MEMFREE_MIN}','Lack of free memory on server {HOSTNAME}','',0,0,3,1370856833,'','Trigger just added. No status update so far.',13594,0,1,0),(13609,'({13086}<{$VOL0_FREE_MIN})&({13087}>4*{$VOL0_FREE_MIN})','Volume {$VOL_0} near full','',0,0,4,1370856821,'','Trigger just added. No status update so far.',13556,0,1,0),(13610,'{13088}<1','Apache is not running on {HOSTNAME}','',0,0,3,1370856837,'','Trigger just added. No status update so far.',NULL,0,1,0),(13611,'{13089}>0','c:\\autoexec.bat has been changed on server {HOSTNAME}','',0,0,3,1370856837,'','Trigger just added. No status update so far.',NULL,0,1,0);
/*!40000 ALTER TABLE `triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_history`
--

DROP TABLE IF EXISTS `user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_history` (
  `userhistoryid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `title1` varchar(255) NOT NULL DEFAULT '',
  `url1` varchar(255) NOT NULL DEFAULT '',
  `title2` varchar(255) NOT NULL DEFAULT '',
  `url2` varchar(255) NOT NULL DEFAULT '',
  `title3` varchar(255) NOT NULL DEFAULT '',
  `url3` varchar(255) NOT NULL DEFAULT '',
  `title4` varchar(255) NOT NULL DEFAULT '',
  `url4` varchar(255) NOT NULL DEFAULT '',
  `title5` varchar(255) NOT NULL DEFAULT '',
  `url5` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`userhistoryid`),
  UNIQUE KEY `user_history_1` (`userid`),
  CONSTRAINT `c_user_history_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_history`
--

LOCK TABLES `user_history` WRITE;
/*!40000 ALTER TABLE `user_history` DISABLE KEYS */;
INSERT INTO `user_history` VALUES (1,1,'Configuration of templates','templates.php?groupid=0','Dashboard','dashboard.php','Configuration of actions','actionconf.php','Configuration of host groups','hostgroups.php','Configuration of actions','actionconf.php');
/*!40000 ALTER TABLE `user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` bigint(20) unsigned NOT NULL,
  `alias` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `surname` varchar(100) NOT NULL DEFAULT '',
  `passwd` char(32) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `autologin` int(11) NOT NULL DEFAULT '0',
  `autologout` int(11) NOT NULL DEFAULT '900',
  `lang` varchar(5) NOT NULL DEFAULT 'en_GB',
  `refresh` int(11) NOT NULL DEFAULT '30',
  `type` int(11) NOT NULL DEFAULT '0',
  `theme` varchar(128) NOT NULL DEFAULT 'default',
  `attempt_failed` int(11) NOT NULL DEFAULT '0',
  `attempt_ip` varchar(39) NOT NULL DEFAULT '',
  `attempt_clock` int(11) NOT NULL DEFAULT '0',
  `rows_per_page` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`userid`),
  KEY `users_1` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','Zabbix','Administrator','5fce1b3e34b520afeffb37ce08c7cd66','',1,0,'en_GB',30,3,'default',0,'10.0.2.2',1370851694,50),(2,'guest','Default','User','d41d8cd98f00b204e9800998ecf8427e','',0,900,'en_GB',30,1,'default',0,'',0,50);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_1` (`usrgrpid`,`userid`),
  KEY `c_users_groups_2` (`userid`),
  CONSTRAINT `c_users_groups_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_groups_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (4,7,1),(2,8,2);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usrgrp`
--

DROP TABLE IF EXISTS `usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usrgrp` (
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `gui_access` int(11) NOT NULL DEFAULT '0',
  `users_status` int(11) NOT NULL DEFAULT '0',
  `debug_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usrgrpid`),
  KEY `usrgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usrgrp`
--

LOCK TABLES `usrgrp` WRITE;
/*!40000 ALTER TABLE `usrgrp` DISABLE KEYS */;
INSERT INTO `usrgrp` VALUES (7,'Zabbix administrators',0,0,0),(8,'Guests',0,0,0),(9,'Disabled',0,1,0),(11,'Enabled debug mode',0,0,1),(12,'No access to the frontend',2,0,0);
/*!40000 ALTER TABLE `usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemaps`
--

DROP TABLE IF EXISTS `valuemaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valuemaps` (
  `valuemapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`valuemapid`),
  KEY `valuemaps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemaps`
--

LOCK TABLES `valuemaps` WRITE;
/*!40000 ALTER TABLE `valuemaps` DISABLE KEYS */;
INSERT INTO `valuemaps` VALUES (4,'APC Battery Replacement Status'),(5,'APC Battery Status'),(7,'Dell Open Manage System Status'),(2,'Host status'),(6,'HP Insight System Status'),(1,'Service state'),(9,'SNMP device status (hrDeviceStatus)'),(11,'SNMP interface status (ifAdminStatus)'),(8,'SNMP interface status (ifOperStatus)'),(3,'Windows service state'),(10,'Zabbix agent ping status');
/*!40000 ALTER TABLE `valuemaps` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-15 18:37:54