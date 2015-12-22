/*
Navicat MySQL Data Transfer

Source Server         : 12344
Source Server Version : 50022
Source Host           : 127.0.0.1:3306
Source Database       : learncommunity

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2015-12-22 14:53:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `teaid` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `root` int(11) default NULL,
  `stucnt` int(11) default NULL,
  `description` varchar(1000) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `course_userid` (`teaid`),
  KEY `course_coursetype` (`type`),
  CONSTRAINT `course_coursetype` FOREIGN KEY (`type`) REFERENCES `coursetype` (`name`),
  CONSTRAINT `course_userid` FOREIGN KEY (`teaid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for coursetype
-- ----------------------------
DROP TABLE IF EXISTS `coursetype`;
CREATE TABLE `coursetype` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for media
-- ----------------------------
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `uploaderid` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `time` datetime NOT NULL,
  `root` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `url` varchar(100) NOT NULL,
  `price` double default NULL,
  PRIMARY KEY  (`id`),
  KEY `m_userid` (`uploaderid`),
  KEY `m_classtype` (`type`),
  CONSTRAINT `m_classtype` FOREIGN KEY (`type`) REFERENCES `coursetype` (`name`),
  CONSTRAINT `m_userid` FOREIGN KEY (`uploaderid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL auto_increment,
  `topicid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `content` varchar(1000) NOT NULL,
  `root` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `r_userid` (`userid`),
  KEY `r_topicid` (`topicid`),
  CONSTRAINT `r_topicid` FOREIGN KEY (`topicid`) REFERENCES `topic` (`id`),
  CONSTRAINT `r_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `uploaderid` int(11) NOT NULL,
  `type` varchar(40) NOT NULL,
  `time` datetime NOT NULL,
  `root` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `url` varchar(100) NOT NULL,
  `price` double default NULL,
  PRIMARY KEY  (`id`),
  KEY `document_userid` (`uploaderid`),
  KEY `document_classtype` (`type`),
  CONSTRAINT `document_classtype` FOREIGN KEY (`type`) REFERENCES `coursetype` (`name`),
  CONSTRAINT `document_userid` FOREIGN KEY (`uploaderid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL auto_increment,
  `userid` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `time` datetime NOT NULL default '0000-00-00 00:00:00',
  `content` varchar(1000) NOT NULL,
  `lastreplytime` datetime NOT NULL,
  `replycnt` int(11) NOT NULL,
  `type` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `t_userid` (`userid`),
  KEY `t_coursetype` (`type`),
  CONSTRAINT `t_coursetype` FOREIGN KEY (`type`) REFERENCES `coursetype` (`name`),
  CONSTRAINT `t_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `phone` varchar(11) default NULL,
  `brithday` date default NULL,
  `address` varchar(40) default NULL,
  `description` varchar(1000) default NULL,
  `educationalbackground` varchar(100) default NULL,
  `goodat` varchar(100) default NULL,
  `photourl` varchar(40) default NULL,
  `classcnt` int(11) default NULL,
  `topiccnt` int(11) default NULL,
  `replycnt` int(11) default NULL,
  `root` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
