-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: scan2
-- ------------------------------------------------------
-- Server version	8.4.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `device_deep_profile`
--

DROP TABLE IF EXISTS `device_deep_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_deep_profile` (
  `id` char(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `hosts` varchar(200) DEFAULT NULL COMMENT 'Danh sách mục tiêu, ngăn cách bởi dấu ,',
  `ports` varchar(255) DEFAULT NULL COMMENT 'Danh sách cổng',
  `exclude_hosts` varchar(500) DEFAULT NULL,
  `alive_test` varchar(20) DEFAULT NULL,
  `scan_config` varchar(100) DEFAULT NULL,
  `scanner` varchar(100) DEFAULT NULL,
  `max_hosts` int DEFAULT NULL,
  `max_checks` int DEFAULT NULL,
  `created` datetime DEFAULT NULL COMMENT 'Ngày tạo',
  `status` int DEFAULT NULL COMMENT 'Trạng thái thực hiện',
  `scheduleid` char(36) DEFAULT NULL COMMENT 'Lập lịch',
  `last_scanid` char(36) DEFAULT NULL COMMENT 'lần chạy cuối',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Lệnh quét chuyên sâu thiết bị';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_deep_profile`
--

LOCK TABLES `device_deep_profile` WRITE;
/*!40000 ALTER TABLE `device_deep_profile` DISABLE KEYS */;
INSERT INTO `device_deep_profile` VALUES ('396a18da-4412-4ed0-bc66-10f8f3e7ae3c','deep 1','192.168.1.0/24','80,443','192.168.1.1','ICMP_z',NULL,NULL,NULL,NULL,NULL,2,NULL,'f894db85-3b59-4b8d-bbc7-dbb16f71fe24');
/*!40000 ALTER TABLE `device_deep_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_deep_scan`
--

DROP TABLE IF EXISTS `device_deep_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_deep_scan` (
  `id` char(36) NOT NULL,
  `profileid` char(36) DEFAULT NULL COMMENT 'profile nào',
  `created` datetime DEFAULT NULL,
  `status` int DEFAULT NULL,
  `started` datetime DEFAULT NULL,
  `ended` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mỗi lần chạy của profile sẽ ra 1 dòng';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_deep_scan`
--

LOCK TABLES `device_deep_scan` WRITE;
/*!40000 ALTER TABLE `device_deep_scan` DISABLE KEYS */;
INSERT INTO `device_deep_scan` VALUES ('f894db85-3b59-4b8d-bbc7-dbb16f71fe24','396a18da-4412-4ed0-bc66-10f8f3e7ae3c',NULL,2,NULL,'2025-03-17 21:45:44');
/*!40000 ALTER TABLE `device_deep_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_deep_task`
--

DROP TABLE IF EXISTS `device_deep_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_deep_task` (
  `id` char(36) NOT NULL,
  `scanid` char(36) DEFAULT NULL COMMENT 'lệnh quét nào',
  `target` varchar(250) DEFAULT NULL COMMENT 'địa chỉ mục tiêu',
  `status` int NOT NULL DEFAULT '0' COMMENT 'trạng thái thực hiện',
  `started` datetime DEFAULT NULL,
  `ended` datetime DEFAULT NULL,
  `error` varchar(500) DEFAULT NULL COMMENT 'Lỗi xảy ra khi quét, gặp lỗi sẽ không có _result',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Chia danh sách mục tiêu thành từng lệnh quét để chạy song song cho nhanh';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_deep_task`
--

LOCK TABLES `device_deep_task` WRITE;
/*!40000 ALTER TABLE `device_deep_task` DISABLE KEYS */;
INSERT INTO `device_deep_task` VALUES ('358f5727-6e7f-4543-a713-7984536cfe65','f894db85-3b59-4b8d-bbc7-dbb16f71fe24','192.168.1.0/24',2,'2025-03-17 21:23:07','2025-03-17 22:09:31',NULL);
/*!40000 ALTER TABLE `device_deep_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_deep_task_result`
--

DROP TABLE IF EXISTS `device_deep_task_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_deep_task_result` (
  `id` char(36) NOT NULL,
  `taskid` char(36) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `protocol` varchar(100) DEFAULT NULL,
  `cve` varchar(255) DEFAULT NULL,
  `description` text,
  `severity` decimal(5,1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='kết quả quét của từng mục tiêu - thống kê theo lệnh/lượt quét';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_deep_task_result`
--

LOCK TABLES `device_deep_task_result` WRITE;
/*!40000 ALTER TABLE `device_deep_task_result` DISABLE KEYS */;
INSERT INTO `device_deep_task_result` VALUES ('00e350e9-1f89-4088-a6cd-ef854f559a6b','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',445,'tcp',NULL,'Detected SMB workgroup: WORKGROUP\nDetected SMB server: Windows Server 2008 R2 Standard 6.1\nDetected OS: Windows Server 2008 R2 Standard 7601 Service Pack 1',0.0),('01877ad6-9b03-4b7a-bd10-c2c70c5f0896','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',445,'tcp',NULL,'A CIFS server is running on this port',0.0),('01f87915-7c03-48a2-ade0-0261d248dc99','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',80,'tcp',NULL,'The host returns a 30x (e.g. 301) error code when a non-existent file is requested. Some HTTP-related checks have been disabled.',0.0),('02be5a65-da46-4b03-bc8d-574dc45a8673','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',3000,'tcp',NULL,'A web server is running on this port',0.0),('04374dfa-2e5f-487c-9087-1149cef56128','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',443,'tcp',NULL,'A TLScustom server answered on this port',0.0),('04babd5e-065f-4e59-8a29-584804b789a2','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2023-48795','The remote SSH server supports the following possible affected client-to-server encryption algorithm(s):\n\nchacha20-poly1305@openssh.com\n\nThe remote SSH server supports the following possible affected server-to-client encryption algorithm(s):\n\nchacha20-poly1305@openssh.com',5.4),('0759122c-d55c-4d29-adb8-961bc4faa7a6','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.24',0,'CPE-T',NULL,'10.16.208.24|cpe:/o:freebsd:freebsd',0.0),('09613dec-4501-4ffd-b69c-d0f2b1e84069','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',5989,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner    | Enumeration technique\n-----------------------------------------------------------------------------------\nServer: sfcHttpd | Invalid HTTP 00.5 GET request (non-existent HTTP version) to \'/\'',0.0),('0a13ba50-6cb2-4b2e-8715-a17348a04303','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2020-15778','Installed version: 7.2p2\nFixed version:     None\nInstallation\npath / port:       22/tcp',6.8),('10261fd1-712b-47a6-b3b4-ad71b700114e','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',3000,'tcp',NULL,'The service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nHá» thá»ng Quáº£n lÃ½ vÃ  PhÃ¢n Phá»i Bot\n-----',0.0),('13b682ab-e494-4794-a4ac-6c8e08314d29','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.2\nInstallation\npath / port:       22/tcp',5.0),('1698b2b6-b1a7-41dd-bfa8-0dddd4d93e22','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',0,'tcp',NULL,'Best matching OS:\n\nOS:           VMware ESX / ESXi\nCPE:          cpe:/o:vmware:esxi:6.0.0\nFound by VT:  1.3.6.1.4.1.25623.1.0.103418 (VMware ESX / ESXi Detection (HTTP))\nConcluded from HTTP Login Page / API on port 443/tcp\nSetting key \"Host/runs_unixoide\" based on this information',0.0),('1b26b2e0-0b50-4663-93c5-c6d96e25f567','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',80,'tcp',NULL,'The Hostname/IP \"192.168.1.152\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.152/\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards',0.0),('230e765d-4457-40c5-97cb-e78f0e21a3d2','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp',NULL,'Remote SSH server banner: SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10\nRemote SSH supported authentication: password,publickey\nRemote SSH text/login banner: (not available)\n\nThis is probably:\n\n- OpenSSH\n\nConcluded from remote connection attempt with credentials:\n\nLogin:    OpenVASVT\nPassword: OpenVASVT',0.0),('26f7025a-6c61-467a-b892-1b9051bc65f2','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',3030,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be NOT able to host PHP scripts.\n\nThis service seems to be NOT able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:3030/\nhttp://192.168.1.139:3030/#\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following directories were excluded from CGI scanning because the \"Regex pattern to exclude directories from CGI scanning\" setting of the VT \"Global variable settings\" (OID: 1.3.6.1.4.1.25623.1.0.12288) for this scan was: \"/(index\\.php|image|img|css|js$|js/|javascript|style|theme|icon|jquery|graphic|grafik|picture|bilder|thumbnail|media/|skins?/)\"\n\nhttp://192.168.1.139:3030/stylesheets',0.0),('2a3f32ae-7b13-4bdc-ac03-235dd3a02dc3','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',5601,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nElastic\n-----\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:5601/\nhttp://192.168.1.139:5601/ui\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards',0.0),('2ac57bcb-2c07-4c8a-99e6-126fdced3aa4','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',0,'tcp',NULL,'Best matching OS:\n\nOS:           Ubuntu 16.04\nVersion:      16.04\nCPE:          cpe:/o:canonical:ubuntu_linux:16.04\nFound by VT:  1.3.6.1.4.1.25623.1.0.105586 (Operating System (OS) Detection (SSH Banner))\nConcluded from SSH banner on port 22/tcp: SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10\nSetting key \"Host/runs_unixoide\" based on this information',0.0),('2b3ef529-dbff-48c5-8633-c5a00d4b30e1','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2021-41617','Installed version: 7.2p2\nFixed version:     8.8\nInstallation\npath / port:       22/tcp',4.4),('2d7c0199-05de-4e1d-89e9-54e572d41e67','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',0,'CPE-T',NULL,'10.16.208.23|cpe:/o:microsoft:windows_server_2008:r2:sp1',0.0),('2e333a6a-fec1-469d-a1e8-e872c83ff333','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',443,'tcp',NULL,'The Hostname/IP \"192.168.1.152\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following files/directories require authentication and are tested (if enabled) by the script \"HTTP Brute Force Logins with default Credentials (OID: 1.3.6.1.4.1.25623.1.0.108041)\":\n\nhttps://192.168.1.152/cgi-bin\nhttps://192.168.1.152/folder\n\nThe following directories were used for CGI scanning:\n\nhttps://192.168.1.152/\nhttps://192.168.1.152/#\nhttps://192.168.1.152/client\nhttps://192.168.1.152/downloads\nhttps://192.168.1.152/en\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following CGIs were discovered:\n\nSyntax : cginame (arguments [default value])\n\nhttps://192.168.1.152/folder (dcPath [ha-datacenter] )',0.0),('359f0bea-b27d-471e-b813-43cbaf1c96d3','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',139,'tcp',NULL,'A SMB server is running on this port',0.0),('35c6cb92-89aa-4cac-8954-f03031b00d91','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',5989,'tcp',NULL,'A web server is running on this port through SSL',0.0),('369c2c80-0ac3-4aee-a9e2-43a41e2027ef','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',1515,'tcp',NULL,'A TLScustom server answered on this port',0.0),('39b091fc-ec77-43f4-86df-df0ee168a44f','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.3\nInstallation\npath / port:       22/tcp',5.0),('3b521dde-ba85-4316-a0b0-da3ee7aa4d8c','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',0,'icmp',NULL,'Here is the route recorded between 172.17.0.2 and 192.168.1.152 :\n192.168.1.115.\n192.168.1.152.\n172.17.0.1.',0.0),('3f4b54db-55ca-4f69-9dd1-6c8c8f658634','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',445,'tcp',NULL,'A CIFS server is running on this port',0.0),('4d435543-36c8-48dd-9878-e00a50c010ef','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2002-20001, CVE-2022-40735','The remote SSH server supports the following DHE KEX algorithm(s):\n\ndiffie-hellman-group14-sha1\ndiffie-hellman-group-exchange-sha256',5.0),('53464c65-367f-4eb5-a1a3-7ca777572a58','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.1\nInstallation\npath / port:       22/tcp',4.0),('55fee48b-771d-4bbb-bbe3-3c6e7ed14c25','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',8080,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner | Enumeration technique\n--------------------------------------------------------------------------------\nServer: dsiem | Invalid HTTP 00.5 GET request (non-existent HTTP version) to \'/\'',0.0),('581a77a3-0f22-4110-b0fd-183fcafff719','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',8080,'tcp',NULL,'A web server is running on this port',0.0),('5bd0167b-200a-4a2a-a407-a5636013f6b6','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2023-48795, CVE-2023-51384, CVE-2023-51385','Installed version: 7.2p2\nFixed version:     9.6\nInstallation\npath / port:       22/tcp',6.4),('5f0e8072-d300-4ee9-828f-9361149bd774','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',1515,'tcp',NULL,'An ossec-authd service seems to be running on this port.',0.0),('620caac1-45c8-4714-8913-047b2153c5ac','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',5601,'tcp',NULL,'The service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nElastic\n-----',0.0),('64abca38-70ea-47a9-bf7c-d3301ed470e8','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',0,'CPE-T',NULL,'192.168.1.139|cpe:/a:elastic:kibana:7.17.6\n192.168.1.139|cpe:/a:elastic:x-pack:7.17.6\n192.168.1.139|cpe:/a:openbsd:openssh:7.2p2\n192.168.1.139|cpe:/o:canonical:ubuntu_linux:16.04',0.0),('666ccb20-61f2-422f-8643-5c18015b4936','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',5989,'tcp','CVE-2016-0800, CVE-2014-3566','In addition to TLSv1.0+ the service is also providing the deprecated SSLv3 protocol and supports one or more ciphers. Those supported ciphers can be found in the \'SSL/TLS: Report Supported Cipher Suites\' (OID: 1.3.6.1.4.1.25623.1.0.802067) VT.',4.3),('68ae89f0-8d08-4b38-a283-eb3efc0e6e2e','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638',10.0),('6ac9147e-4198-43ed-95b9-4eae4937b7b9','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2023-38408','Installed version: 7.2p2\nFixed version:     9.3p2\nInstallation\npath / port:       22/tcp',10.0),('6fd3d886-4041-43b2-811c-ec77b423b415','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',0,'icmp','CVE-1999-0524','The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0',2.1),('7067206d-a825-44dc-87b3-bc02d4e3b196','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638',10.0),('74c62c24-2906-4e5b-99f9-0eda5bc1d4c4','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2018-20685, CVE-2019-6109, CVE-2019-6110, CVE-2019-6111','Installed version: 7.2p2\nFixed version:     8.0\nInstallation\npath / port:       22/tcp',5.8),('75313b94-9917-42f3-b51a-4a82e4749622','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',3030,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner         | Enumeration technique\n-------------------------------------------------------------------\nX-Powered-By: Express | Valid HTTP 0.9 GET request to \'/index.html\'',0.0),('768c848c-44a4-4505-8a7a-a9a4afd86b64','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',5989,'tcp',NULL,'The remote HTTP Server banner is:\n\nServer: sfcHttpd',0.0),('7faddb29-c129-49fa-a0ee-268e0845fcab','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',0,'tcp',NULL,'The \"VMWare ESX / ESXi\" Operating System on the remote host has reached the end of life.\n\nCPE:               cpe:/o:vmware:esxi:6.0.0\nInstalled version,\nbuild or SP:       6.0.0\nEOL version:       6.0\nEOL date:          2020-03-12\nEOL info:          https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/support/product-lifecycle-matrix.pdf',10.0),('81236c32-03b2-4564-a561-5dc94d5704c1','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',135,'tcp',NULL,'A DCE endpoint resolution service seems to be running on this port.',0.0),('86691f7f-0203-44bb-b3f1-9db5581f89cf','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp',NULL,'The remote SSH Server supports the following SSH Protocol Versions:\n1.99\n2.0\n\nSSHv2 Fingerprint(s):\necdsa-sha2-nistp256: 6b:1b:5b:c3:50:18:03:d1:1e:49:dd:9c:00:7a:96:c6\nssh-rsa: a4:b4:eb:82:f4:46:cd:10:19:4a:1d:4b:7a:19:64:67',0.0),('89988d11-ce3c-4ce9-b0d3-f8a3a6d4ce1f','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',8080,'tcp',NULL,'The remote HTTP Server banner is:\n\nServer: dsiem',0.0),('8ac3f443-29a3-4abe-88fc-499d052e08a3','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',0,'tcp',NULL,'Best matching OS:\n\nOS:           Windows Server 2008 R2 Standard 7601 Service Pack 1\nCPE:          cpe:/o:microsoft:windows_server_2008:r2:sp1\nFound by VT:  1.3.6.1.4.1.25623.1.0.102011 (SMB NativeLanMan)\nConcluded from SMB/Samba banner on port 445/tcp: \nOS String:  Windows Server 2008 R2 Standard 7601 Service Pack 1\nSMB String: Windows Server 2008 R2 Standard 6.1\nSetting key \"Host/runs_windows\" based on this information\n\nOther OS detections (in order of reliability):\n\nOS:           Microsoft Windows\nCPE:          cpe:/o:microsoft:windows\nFound by VT:  1.3.6.1.4.1.25623.1.0.108044 (DCE/RPC and MSRPC Services Enumeration)\nConcluded from DCE/RPC and MSRPC Services Enumeration on port 135/tcp',0.0),('8ba5e776-8a39-4db5-96c7-d8bcf5c2c13e','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638',10.0),('8d511183-5c45-4f6e-9db8-2a9c35473007','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',3030,'tcp',NULL,'A web server is running on this port',0.0),('8d51c2c9-5936-4c06-b962-d7193d2dc480','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',445,'tcp',NULL,'SMBv1 is enabled for the SMB Server',0.0),('8ddf4489-b6ad-468a-8f88-1ba94e18c523','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',139,'tcp',NULL,'A SMB server is running on this port',0.0),('8e5136e2-b207-4242-81e7-636d238707be','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638',10.0),('9394ed09-6488-4d24-af8d-3962868a10c0','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',3000,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner         | Enumeration technique\n-------------------------------------------------------------------\nX-Powered-By: Express | Valid HTTP 0.9 GET request to \'/index.html\'',0.0),('9f6769d8-f00c-4909-a637-7ab005170b82','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',5989,'tcp','CVE-2011-3389, CVE-2015-0204','In addition to TLSv1.2+ the service is also providing the deprecated TLSv1.0 and TLSv1.1 protocols and supports one or more ciphers. Those supported ciphers can be found in the \'SSL/TLS: Report Supported Cipher Suites\' (OID: 1.3.6.1.4.1.25623.1.0.802067) VT.',4.3),('a4bb0935-48cd-4ad9-809e-b62a837f133b','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',0,'icmp','CVE-1999-0524','The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0',2.1),('a64a2fc7-b620-46e1-9058-c5eeec03331e','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',80,'tcp',NULL,'A web server is running on this port',0.0),('a6efbc96-0b84-4f09-9c06-7097897b2905','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',443,'tcp','CVE-2011-3389, CVE-2015-0204','In addition to TLSv1.2+ the service is also providing the deprecated TLSv1.0 and TLSv1.1 protocols and supports one or more ciphers. Those supported ciphers can be found in the \'SSL/TLS: Report Supported Cipher Suites\' (OID: 1.3.6.1.4.1.25623.1.0.802067) VT.',4.3),('a80a00a2-e186-43f4-b4eb-3af1633d9727','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',8000,'tcp',NULL,'The service closed the connection after 10 seconds without sending any data\nIt might be protected by some TCP wrapper',0.0),('a998fbd5-c890-428a-aaf3-776fd975e5a6','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',3000,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nHá» thá»ng Quáº£n lÃ½ vÃ  PhÃ¢n Phá»i Bot\n-----\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be NOT able to host PHP scripts.\n\nThis service seems to be NOT able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:3000/\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following directories were excluded from CGI scanning because the \"Regex pattern to exclude directories from CGI scanning\" setting of the VT \"Global variable settings\" (OID: 1.3.6.1.4.1.25623.1.0.12288) for this scan was: \"/(index\\.php|image|img|css|js$|js/|javascript|style|theme|icon|jquery|graphic|grafik|picture|bilder|thumbnail|media/|skins?/)\"\n\nhttp://192.168.1.139:3000/static/js',0.0),('aa5821ba-ca1a-4380-8735-522b08a6545d','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',5989,'tcp',NULL,'The Hostname/IP \"192.168.1.152\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttps://192.168.1.152:5989/\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards',0.0),('ae720620-59ee-4295-90e4-ec500ef18c15','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',0,'tcp',NULL,'Best matching OS:\n\nOS:           FreeBSD\nCPE:          cpe:/o:freebsd:freebsd\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint\nSetting key \"Host/runs_unixoide\" based on this information',0.0),('af07eb8b-01f5-4d19-acd3-adc777acbba2','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',445,'tcp',NULL,'SMBv1 and SMBv2 are enabled on remote target',0.0),('b0278cc4-614c-45e5-a197-32b92dbc4f70','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',443,'tcp',NULL,'A web server is running on this port through SSL',0.0),('b2be4ee3-6f2e-45d5-b172-8f588e9c1384','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',5601,'tcp',NULL,'A web server is running on this port',0.0),('b3fc7ff2-95c9-467d-aa92-ccb55b662827','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',0,'CPE-T',NULL,'10.16.208.26|cpe:/o:microsoft:windows',0.0),('b48475f4-946b-434c-b1bc-dac86a43c549','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',0,'icmp','CVE-1999-0524','The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0',2.1),('b7e0e466-73d8-4842-ad4f-bbb20b8c7ce9','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',445,'tcp',NULL,'SMBv1, SMBv2 and SMBv3 are enabled on remote target',0.0),('be4e2134-32b1-4bd8-8d8b-c62f780db67f','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',8080,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:8080/\nhttp://192.168.1.139:8080/config\nhttp://192.168.1.139:8080/ui\nhttp://192.168.1.139:8080/ui/assets\nhttp://192.168.1.139:8080/ui/assets/config\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following directories were excluded from CGI scanning because the \"Regex pattern to exclude directories from CGI scanning\" setting of the VT \"Global variable settings\" (OID: 1.3.6.1.4.1.25623.1.0.12288) for this scan was: \"/(index\\.php|image|img|css|js$|js/|javascript|style|theme|icon|jquery|graphic|grafik|picture|bilder|thumbnail|media/|skins?/)\"\n\nhttp://192.168.1.139:8080/ui/assets/img\nhttp://192.168.1.139:8080/ui/assets/img/brand',0.0),('c45437be-b1d1-49fd-9373-989940df1943','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',0,'tcp',NULL,'Detected OpenSSH Server\n\nVersion:       7.2p2\nLocation:      22/tcp\nCPE:           cpe:/a:openbsd:openssh:7.2p2\n\nConcluded from version/product identification result:\nSSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10',0.0),('c875ceb9-0616-4e43-b541-94ca685cf744','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',445,'tcp',NULL,'SMBv1 is enabled for the SMB Server',0.0),('c922e78f-5d64-4a46-a42b-3e9e617fe5cf','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.24',0,'tcp',NULL,'Best matching OS:\n\nOS:           FreeBSD\nCPE:          cpe:/o:freebsd:freebsd\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint\nSetting key \"Host/runs_unixoide\" based on this information\n\nOther OS detections (in order of reliability):\n\nOS:           Apple Mac OS X\nCPE:          cpe:/o:apple:mac_os_x\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint\n\nOS:           Linux Kernel\nCPE:          cpe:/o:linux:kernel\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint',0.0),('d6f6d6b7-86ff-4300-8efe-995aa46fe795','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',5989,'tcp',NULL,'A TLScustom server answered on this port',0.0),('dbf65e5c-b679-4a5f-8eda-4197a5cf9905','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',8000,'tcp',NULL,'The service closed the connection after 11 seconds without sending any data\nIt might be protected by some TCP wrapper',0.0),('dbfbd91d-8994-4e05-9a68-abb28f94c830','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp','CVE-2020-14145','Installed version: 7.2p2\nFixed version:     8.5\nInstallation\npath / port:       22/tcp',4.3),('e10bd682-329f-4f80-b367-25070d087c69','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',135,'tcp',NULL,'A DCE endpoint resolution service seems to be running on this port.',0.0),('e18d9f5c-7226-44d1-b02c-56dfac3641a6','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',0,'CPE-T',NULL,'192.168.1.152|cpe:/o:vmware:esxi:6.0.0',0.0),('e29ead85-4859-4345-b1b9-dcf1503a57dc','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.24',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638',10.0),('eea211ab-965d-4311-acb6-b61de0e46788','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp',NULL,'An ssh server is running on this port',0.0),('f0877055-1f39-4e0b-9507-960f4ca49efd','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.23',0,'icmp','CVE-1999-0524','The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0',2.1),('f5ac4ee6-2a68-4b94-a005-e2dc6341dd19','358f5727-6e7f-4543-a713-7984536cfe65','10.16.208.26',0,'tcp',NULL,'Best matching OS:\n\nOS:           Microsoft Windows\nCPE:          cpe:/o:microsoft:windows\nFound by VT:  1.3.6.1.4.1.25623.1.0.108044 (DCE/RPC and MSRPC Services Enumeration)\nConcluded from DCE/RPC and MSRPC Services Enumeration on port 135/tcp\nSetting key \"Host/runs_windows\" based on this information',0.0),('f63da976-9116-498d-87c2-b9272667c7f0','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',22,'tcp',NULL,'The following options are supported by the remote SSH service:\n\nkex_algorithms:\ncurve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1\n\nserver_host_key_algorithms:\nssh-rsa,rsa-sha2-512,rsa-sha2-256,ecdsa-sha2-nistp256,ssh-ed25519\n\nencryption_algorithms_client_to_server:\nchacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com\n\nencryption_algorithms_server_to_client:\nchacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com\n\nmac_algorithms_client_to_server:\numac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1\n\nmac_algorithms_server_to_client:\numac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1\n\ncompression_algorithms_client_to_server:\nnone,zlib@openssh.com\n\ncompression_algorithms_server_to_client:\nnone,zlib@openssh.com',0.0),('f750a7a0-944b-47c6-9888-651eb6bd3e07','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.152',902,'tcp',NULL,'A VMWare authentication daemon is running on this port:\n220 VMware Authentication Daemon Version 1.10: SSL Required, ServerDaemonProtocol:SOAP, MKSDisplayProtocol:VNC , VMXARGS supported, NFCSSL supported/t',0.0),('fa8a5992-34db-40c7-a91a-03966ac2ae39','358f5727-6e7f-4543-a713-7984536cfe65','192.168.1.139',5601,'tcp',NULL,'Detected Elastic Kibana\n\nVersion:       7.17.6\nLocation:      /\nCPE:           cpe:/a:elastic:kibana:7.17.6\n\nConcluded from version/product identification result:\nversion&quot;:&quot;7.17.6\n\nConcluded from version/product identification location:\nhttp://192.168.1.139:5601/login?next=%2Fapp%2Fkibana\n\nDetected Elastic X-Pack\n\nVersion:       7.17.6\nLocation:      /\nCPE:           cpe:/a:elastic:x-pack:7.17.6\n\nConcluded from version/product identification result:\nversion&quot;:&quot;7.17.6\n\nConcluded from version/product identification location:\nhttp://192.168.1.139:5601/login?next=%2Fapp%2Fkibana\n\nExtra information:\nNote: The X-Pack version is always matching the Kibana version',0.0);
/*!40000 ALTER TABLE `device_deep_task_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_wide_profile`
--

DROP TABLE IF EXISTS `device_wide_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_wide_profile` (
  `id` char(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `ports` varchar(255) DEFAULT NULL COMMENT 'Danh sách cổng',
  `rate` int DEFAULT NULL,
  `banners` tinyint(1) DEFAULT NULL,
  `exclude` varchar(500) DEFAULT NULL,
  `open_only` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL COMMENT 'Ngày tạo',
  `status` int DEFAULT NULL COMMENT 'Trạng thái thực hiện',
  `scheduleid` char(36) DEFAULT NULL COMMENT 'Lập lịch',
  `last_scanid` char(36) DEFAULT NULL COMMENT 'lần chạy cuối',
  `targets` text COMMENT 'Danh sách mục tiêu, ngăn cách bởi dấu ,',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Lệnh quét thiết bị diện rộng - Mục tiêu UI';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_wide_profile`
--

LOCK TABLES `device_wide_profile` WRITE;
/*!40000 ALTER TABLE `device_wide_profile` DISABLE KEYS */;
INSERT INTO `device_wide_profile` VALUES ('4be79c58-3962-4094-91a9-ad2b05a0fb6e','test1','80,443',NULL,NULL,NULL,NULL,NULL,2,NULL,'b5e095ff-b03a-4aea-a43d-3806f999c0c9',NULL);
/*!40000 ALTER TABLE `device_wide_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_wide_scan`
--

DROP TABLE IF EXISTS `device_wide_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_wide_scan` (
  `id` char(36) NOT NULL,
  `profileid` char(36) DEFAULT NULL COMMENT 'profile nào',
  `created` datetime DEFAULT NULL,
  `status` int DEFAULT NULL,
  `started` datetime DEFAULT NULL,
  `ended` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mỗi lần chạy của profile sẽ ra 1 dòng - UI là menu Tách vụ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_wide_scan`
--

LOCK TABLES `device_wide_scan` WRITE;
/*!40000 ALTER TABLE `device_wide_scan` DISABLE KEYS */;
INSERT INTO `device_wide_scan` VALUES ('b5e095ff-b03a-4aea-a43d-3806f999c0c9','4be79c58-3962-4094-91a9-ad2b05a0fb6e',NULL,2,NULL,'2025-03-16 23:04:45');
/*!40000 ALTER TABLE `device_wide_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_wide_task`
--

DROP TABLE IF EXISTS `device_wide_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_wide_task` (
  `id` char(36) NOT NULL,
  `scanid` char(36) DEFAULT NULL COMMENT 'lệnh quét nào',
  `target` varchar(250) DEFAULT NULL COMMENT 'địa chỉ mục tiêu',
  `status` int NOT NULL DEFAULT '0' COMMENT 'trạng thái thực hiện',
  `started` datetime DEFAULT NULL,
  `ended` datetime DEFAULT NULL,
  `error` varchar(500) DEFAULT NULL COMMENT 'Lỗi xảy ra khi quét, gặp lỗi sẽ không có _result',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Chia danh sách mục tiêu thành từng lệnh quét để chạy song song cho nhanh';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_wide_task`
--

LOCK TABLES `device_wide_task` WRITE;
/*!40000 ALTER TABLE `device_wide_task` DISABLE KEYS */;
INSERT INTO `device_wide_task` VALUES ('ecb573fa-1812-49a9-9f52-e3d4281e1dbf','b5e095ff-b03a-4aea-a43d-3806f999c0c9','192.168.1.0/24',2,'2025-03-16 22:54:55','2025-03-16 23:05:39',NULL);
/*!40000 ALTER TABLE `device_wide_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_wide_task_result`
--

DROP TABLE IF EXISTS `device_wide_task_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_wide_task_result` (
  `id` char(36) NOT NULL,
  `taskid` char(36) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `protocol` varchar(100) DEFAULT NULL,
  `banner` text,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='kết quả quét của từng mục tiêu - thống kê theo lệnh/lượt quét';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_wide_task_result`
--

LOCK TABLES `device_wide_task_result` WRITE;
/*!40000 ALTER TABLE `device_wide_task_result` DISABLE KEYS */;
INSERT INTO `device_wide_task_result` VALUES ('0a12239e-5eda-43b0-8145-fcddbd30f866','ecb573fa-1812-49a9-9f52-e3d4281e1dbf',NULL,300,'tcp','xxx','open'),('2c6a332a-36ff-4dcc-97d1-07651d991c88','ecb573fa-1812-49a9-9f52-e3d4281e1dbf',NULL,443,'tcp','HTTP/1.1 200 OK\r\nServer: Apache','open'),('71311f7c-3733-4fa8-bd1a-aecd6a39c3e0','ecb573fa-1812-49a9-9f52-e3d4281e1dbf',NULL,80,'tcp','HTTP/1.1 200 OK\r\nServer: nginx','open');
/*!40000 ALTER TABLE `device_wide_task_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `id` char(36) NOT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `last_scanid` char(36) DEFAULT NULL COMMENT 'Lệnh quét cuối',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Thông tin thiết bị (ip)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES ('1a154780-e0d4-459d-bde1-3931fe498b94','192.168.1.1','2025-03-16 23:03:10',NULL),('34c59e67-3e43-4b00-bf90-290c9407fefe','192.168.1.139','2025-03-17 21:30:57',NULL),('360d0590-3481-4ed8-8e3d-19bac3572a96','10.16.208.23','2025-03-17 21:33:02',NULL),('9592ce8c-e299-4f2d-88e1-7de288f0d621','10.16.208.26','2025-03-17 21:33:02',NULL),('a9cd89e2-30b1-4c48-8e4f-b5fc82cfbc40','192.168.1.2','2025-03-16 23:03:43',NULL),('aeee68a6-0800-4c2f-9412-92e60ac36da6','10.16.208.24','2025-03-17 21:33:02',NULL),('be58e929-5b38-4e34-8424-2e9878c1c7d6','192.168.1.152','2025-03-17 21:33:00',NULL),('f0b6c452-b1ef-49ea-87ae-8ca94a310757',NULL,'2025-03-17 21:35:19',NULL);
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices_issues`
--

DROP TABLE IF EXISTS `devices_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices_issues` (
  `id` char(36) NOT NULL,
  `deviceid` char(36) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `protocol` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `banner` text,
  `created` datetime DEFAULT NULL,
  `cve` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Các lỗ hổng phát hiện của thiết bị - thống kê theo thiết bị';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices_issues`
--

LOCK TABLES `devices_issues` WRITE;
/*!40000 ALTER TABLE `devices_issues` DISABLE KEYS */;
INSERT INTO `devices_issues` VALUES ('00fcfbbd-3430-4bb2-89c9-8b2a1065680c','34c59e67-3e43-4b00-bf90-290c9407fefe',3030,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner         | Enumeration technique\n-------------------------------------------------------------------\nX-Powered-By: Express | Valid HTTP 0.9 GET request to \'/index.html\'','2025-03-17 22:09:31',NULL),('012c29cf-ce0f-4f0e-881a-aea431a9b7ef','9592ce8c-e299-4f2d-88e1-7de288f0d621',445,'tcp',NULL,'SMBv1, SMBv2 and SMBv3 are enabled on remote target','2025-03-17 22:09:32',NULL),('02d1e54d-c0bf-407d-9ee9-6b40c97921be','34c59e67-3e43-4b00-bf90-290c9407fefe',3000,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nHá» thá»ng Quáº£n lÃ½ vÃ  PhÃ¢n Phá»i Bot\n-----\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be NOT able to host PHP scripts.\n\nThis service seems to be NOT able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:3000/\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following directories were excluded from CGI scanning because the \"Regex pattern to exclude directories from CGI scanning\" setting of the VT \"Global variable settings\" (OID: 1.3.6.1.4.1.25623.1.0.12288) for this scan was: \"/(index\\.php|image|img|css|js$|js/|javascript|style|theme|icon|jquery|graphic|grafik|picture|bilder|thumbnail|media/|skins?/)\"\n\nhttp://192.168.1.139:3000/static/js','2025-03-17 22:09:31',NULL),('0c2956d4-39d3-4b25-ab08-27581b8fa778','34c59e67-3e43-4b00-bf90-290c9407fefe',0,'icmp',NULL,'The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0','2025-03-17 22:09:31','CVE-1999-0524'),('0d667607-651e-485c-b9b5-85eadce1995e','34c59e67-3e43-4b00-bf90-290c9407fefe',5601,'tcp',NULL,'A web server is running on this port','2025-03-17 22:09:31',NULL),('11ea6257-7da1-41e0-aadd-33fe4cdd2b27','360d0590-3481-4ed8-8e3d-19bac3572a96',445,'tcp',NULL,'SMBv1 and SMBv2 are enabled on remote target','2025-03-17 22:09:32',NULL),('1cbe90db-391d-4a57-bb50-8ac840fb6157','34c59e67-3e43-4b00-bf90-290c9407fefe',0,'CPE-T',NULL,'192.168.1.139|cpe:/a:elastic:kibana:7.17.6\n192.168.1.139|cpe:/a:elastic:x-pack:7.17.6\n192.168.1.139|cpe:/a:openbsd:openssh:7.2p2\n192.168.1.139|cpe:/o:canonical:ubuntu_linux:16.04','2025-03-17 22:09:31',NULL),('2056c0c5-635c-4277-aa2c-163dd7536a1d','be58e929-5b38-4e34-8424-2e9878c1c7d6',5989,'tcp',NULL,'The remote HTTP Server banner is:\n\nServer: sfcHttpd','2025-03-17 22:09:31',NULL),('20f4a84b-7f7a-425c-8a42-b8d5133da179','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     None\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31','CVE-2020-15778'),('2226ccbf-2305-48c6-b7f9-3c9871434134','34c59e67-3e43-4b00-bf90-290c9407fefe',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638','2025-03-17 22:09:31',NULL),('23377930-3403-4cf0-a90e-b97ce68f8268','be58e929-5b38-4e34-8424-2e9878c1c7d6',0,'icmp',NULL,'Here is the route recorded between 172.17.0.2 and 192.168.1.152 :\n192.168.1.115.\n192.168.1.152.\n172.17.0.1.','2025-03-17 22:09:31',NULL),('263cd2ab-886b-425a-8c84-c9c7daad90f1','360d0590-3481-4ed8-8e3d-19bac3572a96',139,'tcp',NULL,'A SMB server is running on this port','2025-03-17 22:09:32',NULL),('2697b1ba-fe2f-4ceb-a9c5-8fd5ff240cc8','360d0590-3481-4ed8-8e3d-19bac3572a96',445,'tcp',NULL,'A CIFS server is running on this port','2025-03-17 22:09:32',NULL),('2cd0367a-2e4c-4772-99d9-6f371d9c46e1','34c59e67-3e43-4b00-bf90-290c9407fefe',3000,'tcp',NULL,'A web server is running on this port','2025-03-17 22:09:31',NULL),('314f4af9-d76b-42f7-92e5-3c452443d906','360d0590-3481-4ed8-8e3d-19bac3572a96',0,'icmp',NULL,'The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0','2025-03-17 22:09:32','CVE-1999-0524'),('31e236d4-f6c7-42c7-bf94-338808258f0b','9592ce8c-e299-4f2d-88e1-7de288f0d621',0,'icmp',NULL,'The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0','2025-03-17 22:09:32','CVE-1999-0524'),('33174edf-0b39-4848-b577-71731d509ec6','9592ce8c-e299-4f2d-88e1-7de288f0d621',0,'tcp',NULL,'Best matching OS:\n\nOS:           Microsoft Windows\nCPE:          cpe:/o:microsoft:windows\nFound by VT:  1.3.6.1.4.1.25623.1.0.108044 (DCE/RPC and MSRPC Services Enumeration)\nConcluded from DCE/RPC and MSRPC Services Enumeration on port 135/tcp\nSetting key \"Host/runs_windows\" based on this information','2025-03-17 22:09:32',NULL),('386fd888-423f-4ba1-a947-efcf3df40328','34c59e67-3e43-4b00-bf90-290c9407fefe',8080,'tcp',NULL,'A web server is running on this port','2025-03-17 22:09:31',NULL),('38d8e3af-2921-4dff-b926-e7a2f212bec9','be58e929-5b38-4e34-8424-2e9878c1c7d6',902,'tcp',NULL,'A VMWare authentication daemon is running on this port:\n220 VMware Authentication Daemon Version 1.10: SSL Required, ServerDaemonProtocol:SOAP, MKSDisplayProtocol:VNC , VMXARGS supported, NFCSSL supported/t','2025-03-17 22:09:31',NULL),('392dadc3-d269-4afb-aae6-3852e1a5b88c','9592ce8c-e299-4f2d-88e1-7de288f0d621',135,'tcp',NULL,'A DCE endpoint resolution service seems to be running on this port.','2025-03-17 22:09:32',NULL),('396cc8c3-6066-4ddf-a44a-222140869900','360d0590-3481-4ed8-8e3d-19bac3572a96',0,'tcp',NULL,'Best matching OS:\n\nOS:           Windows Server 2008 R2 Standard 7601 Service Pack 1\nCPE:          cpe:/o:microsoft:windows_server_2008:r2:sp1\nFound by VT:  1.3.6.1.4.1.25623.1.0.102011 (SMB NativeLanMan)\nConcluded from SMB/Samba banner on port 445/tcp: \nOS String:  Windows Server 2008 R2 Standard 7601 Service Pack 1\nSMB String: Windows Server 2008 R2 Standard 6.1\nSetting key \"Host/runs_windows\" based on this information\n\nOther OS detections (in order of reliability):\n\nOS:           Microsoft Windows\nCPE:          cpe:/o:microsoft:windows\nFound by VT:  1.3.6.1.4.1.25623.1.0.108044 (DCE/RPC and MSRPC Services Enumeration)\nConcluded from DCE/RPC and MSRPC Services Enumeration on port 135/tcp','2025-03-17 22:09:32',NULL),('3b092869-b6a9-44a2-bb02-7e3a6d083918','be58e929-5b38-4e34-8424-2e9878c1c7d6',5989,'tcp',NULL,'In addition to TLSv1.0+ the service is also providing the deprecated SSLv3 protocol and supports one or more ciphers. Those supported ciphers can be found in the \'SSL/TLS: Report Supported Cipher Suites\' (OID: 1.3.6.1.4.1.25623.1.0.802067) VT.','2025-03-17 22:09:32','CVE-2016-0800, CVE-2014-3566'),('3cbbdacb-686c-465a-8cbb-8847c07e8a5e','be58e929-5b38-4e34-8424-2e9878c1c7d6',0,'tcp',NULL,'Best matching OS:\n\nOS:           VMware ESX / ESXi\nCPE:          cpe:/o:vmware:esxi:6.0.0\nFound by VT:  1.3.6.1.4.1.25623.1.0.103418 (VMware ESX / ESXi Detection (HTTP))\nConcluded from HTTP Login Page / API on port 443/tcp\nSetting key \"Host/runs_unixoide\" based on this information','2025-03-17 22:09:31',NULL),('424ecdec-b1d1-479f-b8f2-25e2c9421ddb','be58e929-5b38-4e34-8424-2e9878c1c7d6',8000,'tcp',NULL,'The service closed the connection after 10 seconds without sending any data\nIt might be protected by some TCP wrapper','2025-03-17 22:09:32',NULL),('5018bb2b-c0ac-4178-9aeb-03a127d9cd0b','360d0590-3481-4ed8-8e3d-19bac3572a96',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638','2025-03-17 22:09:32',NULL),('53a54328-b8bb-4ae8-af0a-a97c59c25506','360d0590-3481-4ed8-8e3d-19bac3572a96',445,'tcp',NULL,'Detected SMB workgroup: WORKGROUP\nDetected SMB server: Windows Server 2008 R2 Standard 6.1\nDetected OS: Windows Server 2008 R2 Standard 7601 Service Pack 1','2025-03-17 22:09:32',NULL),('54ce7b55-e11d-4ff2-be6b-91b59b51a74a','be58e929-5b38-4e34-8424-2e9878c1c7d6',80,'tcp',NULL,'The Hostname/IP \"192.168.1.152\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.152/\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards','2025-03-17 22:09:31',NULL),('57ab9f94-d773-4db2-b840-cc4e847fc678','34c59e67-3e43-4b00-bf90-290c9407fefe',8080,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:8080/\nhttp://192.168.1.139:8080/config\nhttp://192.168.1.139:8080/ui\nhttp://192.168.1.139:8080/ui/assets\nhttp://192.168.1.139:8080/ui/assets/config\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following directories were excluded from CGI scanning because the \"Regex pattern to exclude directories from CGI scanning\" setting of the VT \"Global variable settings\" (OID: 1.3.6.1.4.1.25623.1.0.12288) for this scan was: \"/(index\\.php|image|img|css|js$|js/|javascript|style|theme|icon|jquery|graphic|grafik|picture|bilder|thumbnail|media/|skins?/)\"\n\nhttp://192.168.1.139:8080/ui/assets/img\nhttp://192.168.1.139:8080/ui/assets/img/brand','2025-03-17 22:09:31',NULL),('58ad81fb-b798-4ad6-bff4-4fed181ef272','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.3\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31',NULL),('621ad956-1eca-443e-be5e-5fb30df9cdc9','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'The remote SSH Server supports the following SSH Protocol Versions:\n1.99\n2.0\n\nSSHv2 Fingerprint(s):\necdsa-sha2-nistp256: 6b:1b:5b:c3:50:18:03:d1:1e:49:dd:9c:00:7a:96:c6\nssh-rsa: a4:b4:eb:82:f4:46:cd:10:19:4a:1d:4b:7a:19:64:67','2025-03-17 22:09:31',NULL),('636502b3-db96-4693-b1ca-084d12cd8cac','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.6\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31','CVE-2023-48795, CVE-2023-51384, CVE-2023-51385'),('63cb6ad6-5b18-47d8-b112-3dd672a7f48a','360d0590-3481-4ed8-8e3d-19bac3572a96',445,'tcp',NULL,'SMBv1 is enabled for the SMB Server','2025-03-17 22:09:32',NULL),('689cdf2e-2b0f-4c89-9870-a67f021b3db8','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     8.5\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31','CVE-2020-14145'),('6b320611-eda2-4241-b0d2-0e41c8905296','be58e929-5b38-4e34-8424-2e9878c1c7d6',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638','2025-03-17 22:09:31',NULL),('6c21e05a-f25f-4c7d-8a74-7a73cceba4e3','34c59e67-3e43-4b00-bf90-290c9407fefe',0,'tcp',NULL,'Best matching OS:\n\nOS:           Ubuntu 16.04\nVersion:      16.04\nCPE:          cpe:/o:canonical:ubuntu_linux:16.04\nFound by VT:  1.3.6.1.4.1.25623.1.0.105586 (Operating System (OS) Detection (SSH Banner))\nConcluded from SSH banner on port 22/tcp: SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10\nSetting key \"Host/runs_unixoide\" based on this information','2025-03-17 22:09:31',NULL),('6df6cdac-6597-4adb-ab66-c1b4d34fb615','be58e929-5b38-4e34-8424-2e9878c1c7d6',443,'tcp',NULL,'In addition to TLSv1.2+ the service is also providing the deprecated TLSv1.0 and TLSv1.1 protocols and supports one or more ciphers. Those supported ciphers can be found in the \'SSL/TLS: Report Supported Cipher Suites\' (OID: 1.3.6.1.4.1.25623.1.0.802067) VT.','2025-03-17 22:09:32','CVE-2011-3389, CVE-2015-0204'),('7263930e-057c-433e-b2b4-5b150d9cb257','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'The following options are supported by the remote SSH service:\n\nkex_algorithms:\ncurve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1\n\nserver_host_key_algorithms:\nssh-rsa,rsa-sha2-512,rsa-sha2-256,ecdsa-sha2-nistp256,ssh-ed25519\n\nencryption_algorithms_client_to_server:\nchacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com\n\nencryption_algorithms_server_to_client:\nchacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com\n\nmac_algorithms_client_to_server:\numac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1\n\nmac_algorithms_server_to_client:\numac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1\n\ncompression_algorithms_client_to_server:\nnone,zlib@openssh.com\n\ncompression_algorithms_server_to_client:\nnone,zlib@openssh.com','2025-03-17 22:09:31',NULL),('75aa9f47-d959-4745-ba5d-56316c289c3b','34c59e67-3e43-4b00-bf90-290c9407fefe',3030,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be NOT able to host PHP scripts.\n\nThis service seems to be NOT able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:3030/\nhttp://192.168.1.139:3030/#\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following directories were excluded from CGI scanning because the \"Regex pattern to exclude directories from CGI scanning\" setting of the VT \"Global variable settings\" (OID: 1.3.6.1.4.1.25623.1.0.12288) for this scan was: \"/(index\\.php|image|img|css|js$|js/|javascript|style|theme|icon|jquery|graphic|grafik|picture|bilder|thumbnail|media/|skins?/)\"\n\nhttp://192.168.1.139:3030/stylesheets','2025-03-17 22:09:31',NULL),('75c1c60b-db2f-4add-97d7-2609795c6d47','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.3p2\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31','CVE-2023-38408'),('76156e05-e335-43ab-8074-7ee3c5a0490b','360d0590-3481-4ed8-8e3d-19bac3572a96',135,'tcp',NULL,'A DCE endpoint resolution service seems to be running on this port.','2025-03-17 22:09:32',NULL),('7dd1477d-a028-4a2a-ab86-1441f4da17b7','9592ce8c-e299-4f2d-88e1-7de288f0d621',0,'CPE-T',NULL,'10.16.208.26|cpe:/o:microsoft:windows','2025-03-17 22:09:32',NULL),('7e854bd7-05fa-4bd7-a5b3-db3a0cb7d9de','aeee68a6-0800-4c2f-9412-92e60ac36da6',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638','2025-03-17 22:09:32',NULL),('7e9cd7f1-cd9b-42b5-8432-0dd7bc898b9e','be58e929-5b38-4e34-8424-2e9878c1c7d6',0,'tcp',NULL,'The \"VMWare ESX / ESXi\" Operating System on the remote host has reached the end of life.\n\nCPE:               cpe:/o:vmware:esxi:6.0.0\nInstalled version,\nbuild or SP:       6.0.0\nEOL version:       6.0\nEOL date:          2020-03-12\nEOL info:          https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/support/product-lifecycle-matrix.pdf','2025-03-17 22:09:31',NULL),('8482f979-f1db-4c88-b7d8-9102ceb822c2','9592ce8c-e299-4f2d-88e1-7de288f0d621',0,'tcp',NULL,'Version of installed component:           9.0.3 (Installed component: openvas-libraries on OpenVAS <= 9, openvas-scanner on Greenbone Community Edition >= 10)\nLatest available openvas-scanner version: 22.7.3\nReference URL(s) for the latest available version: https://forum.greenbone.net/t/greenbone-community-edition-22-4-stable-initial-release-2022-07-25/12638','2025-03-17 22:09:32',NULL),('849aa9a5-9ac6-4848-941e-96da1c0631c4','be58e929-5b38-4e34-8424-2e9878c1c7d6',8000,'tcp',NULL,'The service closed the connection after 11 seconds without sending any data\nIt might be protected by some TCP wrapper','2025-03-17 22:09:32',NULL),('84c3ae3a-118d-4c56-9696-5702ed4fd961','be58e929-5b38-4e34-8424-2e9878c1c7d6',0,'icmp',NULL,'The following response / ICMP packet has been received:\n- ICMP Type: 14\n- ICMP Code: 0','2025-03-17 22:09:31','CVE-1999-0524'),('890eae4a-006f-4990-a290-99ce1c384891','9592ce8c-e299-4f2d-88e1-7de288f0d621',445,'tcp',NULL,'SMBv1 is enabled for the SMB Server','2025-03-17 22:09:32',NULL),('8b6d6234-bf6c-413a-8723-0211e5d17ddf','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     8.0\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31','CVE-2018-20685, CVE-2019-6109, CVE-2019-6110, CVE-2019-6111'),('91497b81-ccd8-4036-b658-89f1c2b58627','aeee68a6-0800-4c2f-9412-92e60ac36da6',0,'tcp',NULL,'Best matching OS:\n\nOS:           FreeBSD\nCPE:          cpe:/o:freebsd:freebsd\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint\nSetting key \"Host/runs_unixoide\" based on this information\n\nOther OS detections (in order of reliability):\n\nOS:           Apple Mac OS X\nCPE:          cpe:/o:apple:mac_os_x\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint\n\nOS:           Linux Kernel\nCPE:          cpe:/o:linux:kernel\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint','2025-03-17 22:09:32',NULL),('99ccb034-d0d6-423a-a4ee-00579542f07b','34c59e67-3e43-4b00-bf90-290c9407fefe',8080,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner | Enumeration technique\n--------------------------------------------------------------------------------\nServer: dsiem | Invalid HTTP 00.5 GET request (non-existent HTTP version) to \'/\'','2025-03-17 22:09:31',NULL),('9bf9f13d-2a3e-429f-a7df-35e6482aedae','be58e929-5b38-4e34-8424-2e9878c1c7d6',0,'tcp',NULL,'Best matching OS:\n\nOS:           FreeBSD\nCPE:          cpe:/o:freebsd:freebsd\nFound by VT:  1.3.6.1.4.1.25623.1.0.102002 (Operating System (OS) Detection (ICMP))\nConcluded from ICMP based OS fingerprint\nSetting key \"Host/runs_unixoide\" based on this information','2025-03-17 22:09:31',NULL),('9d9c1162-e123-4eaf-aa4e-fc19e9e76023','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'The remote SSH server supports the following DHE KEX algorithm(s):\n\ndiffie-hellman-group14-sha1\ndiffie-hellman-group-exchange-sha256','2025-03-17 22:09:31','CVE-2002-20001, CVE-2022-40735'),('a12b0fec-a907-43b7-af8d-71e5161f8ecb','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     8.8\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31','CVE-2021-41617'),('a37fdd5d-c1b6-422f-8a12-dd8a03cf165a','34c59e67-3e43-4b00-bf90-290c9407fefe',3000,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner         | Enumeration technique\n-------------------------------------------------------------------\nX-Powered-By: Express | Valid HTTP 0.9 GET request to \'/index.html\'','2025-03-17 22:09:31',NULL),('a3be40f3-22f4-482d-b9bb-34966159987a','be58e929-5b38-4e34-8424-2e9878c1c7d6',443,'tcp',NULL,'A web server is running on this port through SSL','2025-03-17 22:09:32',NULL),('a6e44b8a-6dc9-453b-87c8-1b4c1ef445c6','34c59e67-3e43-4b00-bf90-290c9407fefe',5601,'tcp',NULL,'Detected Elastic Kibana\n\nVersion:       7.17.6\nLocation:      /\nCPE:           cpe:/a:elastic:kibana:7.17.6\n\nConcluded from version/product identification result:\nversion&quot;:&quot;7.17.6\n\nConcluded from version/product identification location:\nhttp://192.168.1.139:5601/login?next=%2Fapp%2Fkibana\n\nDetected Elastic X-Pack\n\nVersion:       7.17.6\nLocation:      /\nCPE:           cpe:/a:elastic:x-pack:7.17.6\n\nConcluded from version/product identification result:\nversion&quot;:&quot;7.17.6\n\nConcluded from version/product identification location:\nhttp://192.168.1.139:5601/login?next=%2Fapp%2Fkibana\n\nExtra information:\nNote: The X-Pack version is always matching the Kibana version','2025-03-17 22:09:31',NULL),('b3d18959-11f0-43b9-9e2a-5e4dffab7abf','be58e929-5b38-4e34-8424-2e9878c1c7d6',5989,'tcp',NULL,'The Hostname/IP \"192.168.1.152\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttps://192.168.1.152:5989/\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards','2025-03-17 22:09:31',NULL),('b4137a3e-cba1-4682-9e6d-92244960f303','34c59e67-3e43-4b00-bf90-290c9407fefe',8080,'tcp',NULL,'The remote HTTP Server banner is:\n\nServer: dsiem','2025-03-17 22:09:31',NULL),('b6a2c14d-65a7-4426-8607-a5dd8ff1c994','aeee68a6-0800-4c2f-9412-92e60ac36da6',0,'CPE-T',NULL,'10.16.208.24|cpe:/o:freebsd:freebsd','2025-03-17 22:09:32',NULL),('b6c00f23-a215-4db4-be0f-3d94017545eb','360d0590-3481-4ed8-8e3d-19bac3572a96',0,'CPE-T',NULL,'10.16.208.23|cpe:/o:microsoft:windows_server_2008:r2:sp1','2025-03-17 22:09:32',NULL),('b8fc2560-bb8d-4a57-a1b3-564f42dbd812','be58e929-5b38-4e34-8424-2e9878c1c7d6',443,'tcp',NULL,'The Hostname/IP \"192.168.1.152\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following files/directories require authentication and are tested (if enabled) by the script \"HTTP Brute Force Logins with default Credentials (OID: 1.3.6.1.4.1.25623.1.0.108041)\":\n\nhttps://192.168.1.152/cgi-bin\nhttps://192.168.1.152/folder\n\nThe following directories were used for CGI scanning:\n\nhttps://192.168.1.152/\nhttps://192.168.1.152/#\nhttps://192.168.1.152/client\nhttps://192.168.1.152/downloads\nhttps://192.168.1.152/en\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards\n\nThe following CGIs were discovered:\n\nSyntax : cginame (arguments [default value])\n\nhttps://192.168.1.152/folder (dcPath [ha-datacenter] )','2025-03-17 22:09:31',NULL),('b963332c-fa15-4a33-9cc0-eda4bb94d18f','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Remote SSH server banner: SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10\nRemote SSH supported authentication: password,publickey\nRemote SSH text/login banner: (not available)\n\nThis is probably:\n\n- OpenSSH\n\nConcluded from remote connection attempt with credentials:\n\nLogin:    OpenVASVT\nPassword: OpenVASVT','2025-03-17 22:09:31',NULL),('ba1cd245-8678-49de-9093-deaf79756c26','9592ce8c-e299-4f2d-88e1-7de288f0d621',139,'tcp',NULL,'A SMB server is running on this port','2025-03-17 22:09:32',NULL),('ba35a281-de31-49a2-b4f0-6e6a70a62461','be58e929-5b38-4e34-8424-2e9878c1c7d6',5989,'tcp',NULL,'A TLScustom server answered on this port','2025-03-17 22:09:32',NULL),('bd681751-0a8d-462a-820f-d8f91792dfe9','34c59e67-3e43-4b00-bf90-290c9407fefe',5601,'tcp',NULL,'The Hostname/IP \"192.168.1.139\" was used to access the remote host.\n\nGeneric web application scanning is disabled for this host via the \"Enable generic web application scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nElastic\n-----\n\nRequests to this service are done via HTTP/1.1.\n\nThis service seems to be able to host PHP scripts.\n\nThis service seems to be able to host ASP scripts.\n\nThe User-Agent \"Mozilla/5.0 [en] (X11, U; OpenVAS-VT 9.0.3)\" was used to access the remote host.\n\nHistoric /scripts and /cgi-bin are not added to the directories used for CGI scanning. You can enable this again with the \"Add historic /scripts and /cgi-bin to directories for CGI scanning\" option within the \"Global variable settings\" of the scan config in use.\n\nThe following directories were used for CGI scanning:\n\nhttp://192.168.1.139:5601/\nhttp://192.168.1.139:5601/ui\n\nWhile this is not, in and of itself, a bug, you should manually inspect these directories to ensure that they are in compliance with company security standards','2025-03-17 22:09:31',NULL),('beba7667-2e0e-483a-8f02-fa3c18978f64','34c59e67-3e43-4b00-bf90-290c9407fefe',5601,'tcp',NULL,'The service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nElastic\n-----','2025-03-17 22:09:31',NULL),('c05da6d0-f3c4-4c04-9fe0-c088ca4e6f37','34c59e67-3e43-4b00-bf90-290c9407fefe',3030,'tcp',NULL,'A web server is running on this port','2025-03-17 22:09:31',NULL),('c297d28b-989f-4a47-b884-f176d21dd83f','be58e929-5b38-4e34-8424-2e9878c1c7d6',443,'tcp',NULL,'A TLScustom server answered on this port','2025-03-17 22:09:31',NULL),('c39f29cf-f271-44df-a4d3-82ba8fa540e3','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.2\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31',NULL),('c61b4591-412a-4105-abaa-d99f59ea4579','be58e929-5b38-4e34-8424-2e9878c1c7d6',0,'CPE-T',NULL,'192.168.1.152|cpe:/o:vmware:esxi:6.0.0','2025-03-17 22:09:31',NULL),('cc445de2-0122-443e-83be-40f4abdb2974','34c59e67-3e43-4b00-bf90-290c9407fefe',3000,'tcp',NULL,'The service is responding with a 200 HTTP status code to non-existent files/urls. The following pattern is used to work around possible false detections:\n-----\nHá» thá»ng Quáº£n lÃ½ vÃ  PhÃ¢n Phá»i Bot\n-----','2025-03-17 22:09:31',NULL),('d2d3a7bc-c00c-4d1c-b75b-9ff51ece4b2f','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'The remote SSH server supports the following possible affected client-to-server encryption algorithm(s):\n\nchacha20-poly1305@openssh.com\n\nThe remote SSH server supports the following possible affected server-to-client encryption algorithm(s):\n\nchacha20-poly1305@openssh.com','2025-03-17 22:09:31','CVE-2023-48795'),('e05b454e-a04e-4753-8c7b-051fcdf68711','be58e929-5b38-4e34-8424-2e9878c1c7d6',80,'tcp',NULL,'The host returns a 30x (e.g. 301) error code when a non-existent file is requested. Some HTTP-related checks have been disabled.','2025-03-17 22:09:31',NULL),('e403033c-7434-4aa6-8a4b-84471c51d23b','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'Installed version: 7.2p2\nFixed version:     9.1\nInstallation\npath / port:       22/tcp','2025-03-17 22:09:31',NULL),('ecb85d60-1e8c-4f6f-af0d-99c00f0d0cc0','34c59e67-3e43-4b00-bf90-290c9407fefe',0,'tcp',NULL,'Detected OpenSSH Server\n\nVersion:       7.2p2\nLocation:      22/tcp\nCPE:           cpe:/a:openbsd:openssh:7.2p2\n\nConcluded from version/product identification result:\nSSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10','2025-03-17 22:09:31',NULL),('ed47059a-79fc-447c-95a5-7c6205b5d536','34c59e67-3e43-4b00-bf90-290c9407fefe',1515,'tcp',NULL,'A TLScustom server answered on this port','2025-03-17 22:09:31',NULL),('f09d561c-f9da-4525-8144-23cdcaff29cb','be58e929-5b38-4e34-8424-2e9878c1c7d6',80,'tcp',NULL,'A web server is running on this port','2025-03-17 22:09:32',NULL),('f26f2cf3-0230-409b-b585-5e2b9df85bc2','be58e929-5b38-4e34-8424-2e9878c1c7d6',5989,'tcp',NULL,'It was possible to enumerate the following HTTP server banner(s):\n\nServer banner    | Enumeration technique\n-----------------------------------------------------------------------------------\nServer: sfcHttpd | Invalid HTTP 00.5 GET request (non-existent HTTP version) to \'/\'','2025-03-17 22:09:31',NULL),('f6c4e378-4bc6-4f26-832d-9c0c532cadd1','be58e929-5b38-4e34-8424-2e9878c1c7d6',5989,'tcp',NULL,'In addition to TLSv1.2+ the service is also providing the deprecated TLSv1.0 and TLSv1.1 protocols and supports one or more ciphers. Those supported ciphers can be found in the \'SSL/TLS: Report Supported Cipher Suites\' (OID: 1.3.6.1.4.1.25623.1.0.802067) VT.','2025-03-17 22:09:32','CVE-2011-3389, CVE-2015-0204'),('f7632a01-6b83-490c-b5f9-a732ca2ff4d1','9592ce8c-e299-4f2d-88e1-7de288f0d621',445,'tcp',NULL,'A CIFS server is running on this port','2025-03-17 22:09:32',NULL),('f7e52833-6ef9-40be-9f96-239a32d86e75','be58e929-5b38-4e34-8424-2e9878c1c7d6',5989,'tcp',NULL,'A web server is running on this port through SSL','2025-03-17 22:09:32',NULL),('fac358db-05d8-4869-bde7-65ddf5b6e979','34c59e67-3e43-4b00-bf90-290c9407fefe',1515,'tcp',NULL,'An ossec-authd service seems to be running on this port.','2025-03-17 22:09:31',NULL),('fecff228-bb14-42f8-b640-8658f5b6fcf8','34c59e67-3e43-4b00-bf90-290c9407fefe',22,'tcp',NULL,'An ssh server is running on this port','2025-03-17 22:09:31',NULL);
/*!40000 ALTER TABLE `devices_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issues` (
  `id` char(36) NOT NULL,
  `cve` varchar(100) DEFAULT NULL COMMENT 'mã cve',
  `description` varchar(500) DEFAULT NULL COMMENT 'Mô tả',
  `severity` int DEFAULT NULL COMMENT 'mức độ nghiêm trọng',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Danh mục lỗ hổng ATTT';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `id` char(36) NOT NULL,
  `roleid` char(36) DEFAULT NULL,
  `permission` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_role_roleid_idx` (`roleid`),
  CONSTRAINT `fk_role_permission_role_roleid` FOREIGN KEY (`roleid`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scan_engine`
--

DROP TABLE IF EXISTS `scan_engine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scan_engine` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` int NOT NULL DEFAULT '0' COMMENT 'Loại: Web 0, 1 thiết bị',
  `level` int NOT NULL DEFAULT '0' COMMENT 'Nhóm: Diện rộng 0, chuyên sâu 1',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `scan_config` varchar(1000) DEFAULT NULL COMMENT 'Cấu hình quét',
  `deploy_info` varchar(500) DEFAULT NULL COMMENT 'Cấu hình triển khai',
  `code` int DEFAULT NULL COMMENT 'Mã engine quét, enum EngineCode',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Thiết bị';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scan_engine`
--

LOCK TABLES `scan_engine` WRITE;
/*!40000 ALTER TABLE `scan_engine` DISABLE KEYS */;
INSERT INTO `scan_engine` VALUES ('766cc241-4570-4049-a8b6-8ca453bb2f0e','device_wide_2',0,0,0,'{\"QueueInput\":{\"Host\":\"localhost\",\"Port\":5672,\"VirtualHost\":\"app_host\",\"Username\":\"app\",\"Password\":\"123456\",\"Queue\":\"device_wide_pc2_input\",\"Durable\":false},\"QueueResult\":{\"Host\":\"localhost\",\"Port\":5672,\"VirtualHost\":\"app_host\",\"Username\":\"app\",\"Password\":\"123456\",\"Queue\":\"device_wide_pc2_result\",\"Durable\":false,\"ThreadLimit\":1},\"ProcessLimit\":10}','cloud',1),('e88edb16-1c89-4184-92f9-c503f7d7eb6b','device_wide_1',0,0,0,'{\"QueueInput\":{\"Host\":\"localhost\",\"Port\":5672,\"VirtualHost\":\"app_host\",\"Username\":\"app\",\"Password\":\"123456\",\"Queue\":\"device_wide_pc1_input\",\"Durable\":false},\"QueueResult\":{\"Host\":\"localhost\",\"Port\":5672,\"VirtualHost\":\"app_host\",\"Username\":\"app\",\"Password\":\"123456\",\"Queue\":\"device_wide_pc1_result\",\"Durable\":false,\"ThreadLimit\":1},\"ProcessLimit\":10}','Máy chủ nội bộ',1),('f2243fc3-d1d4-4a80-afff-037716978d4b','device_deep_1',0,0,0,'{\"QueueInput\":{\"Host\":\"localhost\",\"Port\":5672,\"VirtualHost\":\"app_host\",\"Username\":\"app\",\"Password\":\"123456\",\"Queue\":\"device_deep_pc1_input\",\"Durable\":false},\"QueueResult\":{\"Host\":\"localhost\",\"Port\":5672,\"VirtualHost\":\"app_host\",\"Username\":\"app\",\"Password\":\"123456\",\"Queue\":\"device_deep_pc1_result\",\"Durable\":false,\"ThreadLimit\":1},\"ProcessLimit\":10}','local',2);
/*!40000 ALTER TABLE `scan_engine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `id` char(36) NOT NULL,
  `code` varchar(150) DEFAULT NULL,
  `value` varchar(5000) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Bảng thiết lập dạng key-value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_log` (
  `id` char(36) NOT NULL,
  `userid` char(36) DEFAULT NULL,
  `action` int DEFAULT NULL COMMENT 'thao tác gì',
  `data` varchar(255) DEFAULT NULL COMMENT 'Thông tin hành động',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='nhật ký hoạt động của user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
INSERT INTO `user_log` VALUES ('07d556cb-2f91-4765-b81b-74d5f13adb73','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:17:46'),('088d3446-770b-46ae-bd95-57643f74387a','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:45:42'),('1dd2c79d-c251-4669-9e47-45b6d7d9f4c6','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:18:01'),('1e255920-4977-4823-8d90-2edde9b3e4fe','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:47:41'),('218f2142-cd3d-4963-b5a6-6e2c937042cc','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 21:59:31'),('3e2b7a0a-fbab-4e49-855c-068fe67a4cb2','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:14:50'),('3f7494bf-59cf-4d4f-8ffc-051e3ff8cd0e','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:13:03'),('47de9eb4-1a88-4700-b4c3-3f245d5b0135','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:45:34'),('63f0547d-823c-4d58-ac37-faaa0ed9c0fc','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:51:15'),('69b67ea7-4493-4a7b-b167-78cd37408f90','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:17:38'),('86625850-a4b3-4eab-b1ad-9606e1fa5e4e','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:21:48'),('9e65db67-d45f-4fad-ba6e-f9a7532108dd','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:17:45'),('a099bdae-342d-4aba-acdf-7407c30f488c','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:18:00'),('a774d454-73d7-46da-8146-a6b7dd5ec7fd','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:49:20'),('a9ebcc85-d694-4298-9bef-13de8244cab2','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:18:24'),('c709fcf7-4bc7-40ef-b451-445a6f9a8690','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:46:59'),('cbf1225d-dc92-4745-83e1-535a07e6cfe0','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:46:14'),('d0dcd336-98c5-40a4-a61b-d1f897a0642b','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 22:12:08'),('d7e4009c-abd6-4ebb-8293-3106243540b7','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:16:35'),('d9e23a88-06e4-4764-bf64-81e16c3a386a','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:40:30'),('dd95ec05-e9b9-4b17-8de0-a5d6fdd457c9','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:16:00'),('e03d6f61-df83-4e10-a1f4-d523f28c565d','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:46:33'),('e2121664-e185-403d-9742-747468dc9a01','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:14:43'),('eff23368-b993-4c1a-988e-08c7b92c2102','99c91895-62d8-4771-a75c-c9befb6e4b1f',0,'{\"username\":\"dev1\"}','2025-03-18 17:14:26');
/*!40000 ALTER TABLE `user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `role` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('99c91895-62d8-4771-a75c-c9befb6e4b1f','dev1','E10ADC3949BA59ABBE56E057F20F883E','dev 1',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_deep_profile`
--

DROP TABLE IF EXISTS `website_deep_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_deep_profile` (
  `id` char(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `engine` int DEFAULT NULL COMMENT 'Quét với engine nào',
  `engine_option` varchar(1000) DEFAULT NULL COMMENT 'Json cấu hình thông tin theo từng engine. Các trường chung không có sẽ lưu json vào đây',
  `targets` varchar(1000) DEFAULT NULL COMMENT 'Danh sách mục tiêu, ngăn cách dấu ,',
  `excludes` varchar(1000) DEFAULT NULL COMMENT 'Danh sách các đường dẫn loại trừ. Ngăn cách dấu ,',
  `header` varchar(1000) DEFAULT NULL COMMENT 'dictionary header {}',
  `cookie` varchar(1000) DEFAULT NULL COMMENT 'dictionary cookie {}',
  `login_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Loại login: basic, form-based, API-key...',
  `login_credentials` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Chi tiết thông tin login',
  `scan_config` varchar(100) DEFAULT NULL,
  `scanner` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL COMMENT 'Ngày tạo',
  `status` int DEFAULT NULL COMMENT 'Trạng thái thực hiện',
  `scheduleid` char(36) DEFAULT NULL COMMENT 'Lập lịch',
  `last_scanid` char(36) DEFAULT NULL COMMENT 'lần chạy cuối',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Lệnh quét chuyên sâu website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_deep_profile`
--

LOCK TABLES `website_deep_profile` WRITE;
/*!40000 ALTER TABLE `website_deep_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `website_deep_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_deep_scan`
--

DROP TABLE IF EXISTS `website_deep_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_deep_scan` (
  `id` char(36) NOT NULL,
  `profileid` char(36) DEFAULT NULL COMMENT 'profile nào',
  `created` datetime DEFAULT NULL,
  `status` int DEFAULT NULL,
  `started` datetime DEFAULT NULL,
  `ended` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mỗi lần chạy của profile sẽ ra 1 dòng';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_deep_scan`
--

LOCK TABLES `website_deep_scan` WRITE;
/*!40000 ALTER TABLE `website_deep_scan` DISABLE KEYS */;
/*!40000 ALTER TABLE `website_deep_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_deep_task`
--

DROP TABLE IF EXISTS `website_deep_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_deep_task` (
  `id` char(36) NOT NULL,
  `scanid` char(36) DEFAULT NULL COMMENT 'lệnh quét nào',
  `target` varchar(250) DEFAULT NULL COMMENT 'địa chỉ mục tiêu',
  `status` int NOT NULL DEFAULT '0' COMMENT 'trạng thái thực hiện',
  `started` datetime DEFAULT NULL,
  `ended` datetime DEFAULT NULL,
  `error` varchar(500) DEFAULT NULL COMMENT 'Lỗi xảy ra khi quét, gặp lỗi sẽ không có _result',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Chia danh sách mục tiêu thành từng lệnh quét để chạy song song cho nhanh';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_deep_task`
--

LOCK TABLES `website_deep_task` WRITE;
/*!40000 ALTER TABLE `website_deep_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `website_deep_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_deep_task_result`
--

DROP TABLE IF EXISTS `website_deep_task_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_deep_task_result` (
  `id` char(36) NOT NULL,
  `taskid` char(36) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL COMMENT 'Đường dẫn phát hiện',
  `type` varchar(100) DEFAULT NULL,
  `cve` varchar(255) DEFAULT NULL,
  `description` text,
  `severity` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='kết quả quét của từng mục tiêu - thống kê theo lệnh/lượt quét';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_deep_task_result`
--

LOCK TABLES `website_deep_task_result` WRITE;
/*!40000 ALTER TABLE `website_deep_task_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `website_deep_task_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `websites`
--

DROP TABLE IF EXISTS `websites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `websites` (
  `id` char(36) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `last_scanid` char(36) DEFAULT NULL COMMENT 'Lệnh quét cuối',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Thông tin website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `websites`
--

LOCK TABLES `websites` WRITE;
/*!40000 ALTER TABLE `websites` DISABLE KEYS */;
/*!40000 ALTER TABLE `websites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `websites_issues`
--

DROP TABLE IF EXISTS `websites_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `websites_issues` (
  `id` char(36) NOT NULL,
  `websiteid` char(36) DEFAULT NULL,
  `url` int DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `severity` varchar(10) DEFAULT NULL,
  `description` text,
  `created` datetime DEFAULT NULL,
  `cve` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Các lỗ hổng phát hiện';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `websites_issues`
--

LOCK TABLES `websites_issues` WRITE;
/*!40000 ALTER TABLE `websites_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `websites_issues` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-18 23:47:19
