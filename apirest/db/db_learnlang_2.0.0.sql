/*
SQLyog Ultimate v9.02 
MySQL - 5.5.5-10.1.35-MariaDB : Database - db_learnlang
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_learnlang` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_learnlang`;

/*Table structure for table `_template` */

DROP TABLE IF EXISTS `_template`;

CREATE TABLE `_template` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `_template_array` */

DROP TABLE IF EXISTS `_template_array`;

CREATE TABLE `_template_array` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `id_tosave` varchar(25) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `order_by` int(5) NOT NULL DEFAULT '100',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_array` */

DROP TABLE IF EXISTS `app_array`;

CREATE TABLE `app_array` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT NULL,
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT NULL,
  `is_enabled` varchar(3) DEFAULT NULL,
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `module` varchar(25) DEFAULT NULL,
  `id_tosave` varchar(25) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `order_by` int(5) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `app_exam` */

DROP TABLE IF EXISTS `app_exam`;

CREATE TABLE `app_exam` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `is_notificable` tinyint(4) DEFAULT NULL COMMENT 'indica si se tomará en cuenta para examen',
  `is_shareable` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT 'solo esta disponible para el creador',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_exams_sentences` */

DROP TABLE IF EXISTS `app_exams_sentences`;

CREATE TABLE `app_exams_sentences` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sentence` int(11) NOT NULL,
  `id_exam` int(11) NOT NULL,
  `is_notificable` tinyint(4) DEFAULT '0' COMMENT 'si se notificara para examen',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_exams_users` */

DROP TABLE IF EXISTS `app_exams_users`;

CREATE TABLE `app_exams_users` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_exam` int(11) NOT NULL,
  `is_notificable` tinyint(4) DEFAULT '0' COMMENT 'si se notificara para examen',
  `is_owner` tinyint(4) DEFAULT '1' COMMENT 'si es propietario del texto',
  `is_read` tinyint(4) DEFAULT '1' COMMENT 'si puede leer',
  `is_write` tinyint(4) DEFAULT '1' COMMENT 'si puede cambiarlo',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_exams_users_evalh` */

DROP TABLE IF EXISTS `app_exams_users_evalh`;

CREATE TABLE `app_exams_users_evalh` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_exam_user` int(11) NOT NULL,
  `eval_date` varchar(14) DEFAULT NULL COMMENT 'fecha de la evaluacion',
  `is_finished` tinyint(4) DEFAULT '0',
  `is_timeup` tinyint(4) DEFAULT '0',
  `rate_percent` decimal(8,3) DEFAULT NULL COMMENT 'el porcentaje 10/20',
  `id_type` int(11) DEFAULT NULL COMMENT 'si es tipo prueba o cuenta para nota',
  `owner_notes` varchar(250) DEFAULT NULL COMMENT 'notas del profesor',
  `pupil_notes` varchar(250) DEFAULT NULL COMMENT 'notas del examinado',
  `owner_rate` decimal(8,3) DEFAULT NULL COMMENT 'la nota final que pone el profesor',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_exams_users_evall` */

DROP TABLE IF EXISTS `app_exams_users_evall`;

CREATE TABLE `app_exams_users_evall` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_evalh` int(11) NOT NULL,
  `id_sentence` int(11) NOT NULL,
  `id_langfrom` int(11) DEFAULT NULL COMMENT 'la frase en el idioma explicito',
  `id_langto` int(11) DEFAULT NULL COMMENT 'la frase en el idioma a evaluar',
  `is_write` tinyint(4) DEFAULT NULL COMMENT 'se evalua la escritura',
  `is_listen` tinyint(4) DEFAULT NULL COMMENT 'auditiva',
  `is_image` tinyint(4) DEFAULT NULL COMMENT 'visual',
  `is_spoken` tinyint(4) DEFAULT NULL COMMENT 'hablada - TO-DO machine learning',
  `i_result` tinyint(4) DEFAULT NULL COMMENT '0:fail,1:ok,null:not done',
  `i_time` int(11) DEFAULT NULL COMMENT 'tiempo en contestar, serviara para sugerir practicar',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_sentence` */

DROP TABLE IF EXISTS `app_sentence`;

CREATE TABLE `app_sentence` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `text_orig` varchar(500) DEFAULT NULL COMMENT 'texto original',
  `path_audio` varchar(500) DEFAULT NULL COMMENT 'ruta del audio asociado',
  `url_resource` varchar(500) DEFAULT NULL COMMENT 'url para el audio que no esta en el servidor',
  `id_language` int(11) DEFAULT NULL COMMENT 'base_language.id',
  `is_notificable` tinyint(4) DEFAULT NULL COMMENT 'indica si se tomará en cuenta para examen',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_sentence_images` */

DROP TABLE IF EXISTS `app_sentence_images`;

CREATE TABLE `app_sentence_images` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `id_sentence` int(11) NOT NULL COMMENT 'base_language.id',
  `path_local` varchar(500) DEFAULT NULL COMMENT 'si se ha guardado en el servidor',
  `url_resource` varchar(500) DEFAULT NULL COMMENT 'url para evitar de guardar en el servidor',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_sentence_tags` */

DROP TABLE IF EXISTS `app_sentence_tags`;

CREATE TABLE `app_sentence_tags` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT NULL,
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sentence` int(11) NOT NULL,
  `id_tag` int(11) NOT NULL,
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `app_sentence_times` */

DROP TABLE IF EXISTS `app_sentence_times`;

CREATE TABLE `app_sentence_times` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT NULL,
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sentence` int(11) NOT NULL,
  `date_checked` varchar(14) DEFAULT NULL COMMENT 'la última vez que se interactuó con el ',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `app_sentence_tr` */

DROP TABLE IF EXISTS `app_sentence_tr`;

CREATE TABLE `app_sentence_tr` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `text_tr` varchar(500) DEFAULT NULL COMMENT 'texto traducido',
  `id_language` int(11) DEFAULT NULL COMMENT 'base_language.id',
  `id_sentence` int(11) DEFAULT NULL COMMENT 'app_sentence.id',
  `code_cache` varchar(500) DEFAULT NULL COMMENT 'codigo hash en nosql',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_sentences_users` */

DROP TABLE IF EXISTS `app_sentences_users`;

CREATE TABLE `app_sentences_users` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_sentence` int(11) NOT NULL,
  `is_notificable` tinyint(4) DEFAULT '0' COMMENT 'si se notificara para examen',
  `is_owner` tinyint(4) DEFAULT '1' COMMENT 'si es propietario del texto',
  `is_read` tinyint(4) DEFAULT '1' COMMENT 'si puede leer',
  `is_write` tinyint(4) DEFAULT '1' COMMENT 'si puede cambiarlo',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `app_tag` */

DROP TABLE IF EXISTS `app_tag`;

CREATE TABLE `app_tag` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT NULL,
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_type` int(11) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL COMMENT 'la descripcion en slug',
  `order_by` int(5) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `base_language` */

DROP TABLE IF EXISTS `base_language`;

CREATE TABLE `base_language` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `id_tosave` varchar(25) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `code_iso` varchar(10) DEFAULT '-' COMMENT 'https://www.iso.org/iso-639-language-codes.html',
  `order_by` int(5) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Table structure for table `base_language_lang` */

DROP TABLE IF EXISTS `base_language_lang`;

CREATE TABLE `base_language_lang` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_source` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `order_by` int(5) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `base_user` */

DROP TABLE IF EXISTS `base_user`;

CREATE TABLE `base_user` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `bo_login` varchar(100) DEFAULT NULL,
  `bo_password` varchar(250) DEFAULT NULL,
  `md_login` varchar(100) DEFAULT NULL,
  `md_password` varchar(250) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_start_module` int(11) DEFAULT NULL,
  `path_picture` varchar(100) DEFAULT NULL,
  `id_profile` int(11) DEFAULT NULL,
  `code_type` varchar(25) DEFAULT NULL,
  `bo_tokenreset` varchar(250) DEFAULT NULL,
  `md_tokenreset` varchar(250) DEFAULT NULL,
  `log_attempts` int(5) DEFAULT '0',
  `rating` int(11) DEFAULT NULL COMMENT 'la puntuacion',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `base_user_array` */

DROP TABLE IF EXISTS `base_user_array`;

CREATE TABLE `base_user_array` (
  `processflag` varchar(5) DEFAULT NULL,
  `insert_platform` varchar(3) DEFAULT '1',
  `insert_user` varchar(15) DEFAULT NULL,
  `insert_date` varchar(14) DEFAULT NULL,
  `update_platform` varchar(3) DEFAULT NULL,
  `update_user` varchar(15) DEFAULT NULL,
  `update_date` varchar(14) DEFAULT NULL,
  `delete_platform` varchar(3) DEFAULT NULL,
  `delete_user` varchar(15) DEFAULT NULL,
  `delete_date` varchar(14) DEFAULT NULL,
  `cru_csvnote` varchar(500) DEFAULT NULL,
  `is_erpsent` varchar(3) DEFAULT '0',
  `is_enabled` varchar(3) DEFAULT '1',
  `i` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_erp` varchar(25) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `id_tosave` varchar(25) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `order_by` int(5) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `version_db` */

DROP TABLE IF EXISTS `version_db`;

CREATE TABLE `version_db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` char(14) DEFAULT NULL COMMENT 'mysql no permite funciones evaluadas por defcto se debe crear un trigger REPLACE(REPLACE(REPLACE(NOW(),''-'',''''),'':'',''''),'' '','''') mssql+1',
  `version` varchar(15) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/* Procedure structure for procedure `prc_clone_row` */

/*!50003 DROP PROCEDURE IF EXISTS  `prc_clone_row` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clone_row`(
    sTableName VARCHAR(25)
    ,sId VARCHAR(5)
    )
BEGIN
    SET @sSQL := CONCAT('SELECT (MAX(id)+1) AS idnew FROM ',sTableName,' INTO @sIdNew');
    PREPARE sExecute FROM @sSQL;
    EXECUTE sExecute;
    IF (@sIdNew IS NOT NULL) THEN
        SET @sSQL := CONCAT('CREATE TEMPORARY TABLE tempo_table SELECT * FROM ',sTableName,' WHERE id = ',sId,'; ');
        PREPARE sExecute FROM @sSQL;
        EXECUTE sExecute; 
           
        SET @sSQL := CONCAT('UPDATE tempo_table SET id=',@sIdNew,' WHERE id=',sId,'; ');
        PREPARE sExecute FROM @sSQL;
        EXECUTE sExecute;        
        
        SET @sSQL := CONCAT('INSERT INTO ',sTableName,' SELECT * FROM tempo_table WHERE id=',@sIdNew,'; ');
        PREPARE sExecute FROM @sSQL;
        EXECUTE sExecute; 
        SET @sSQL := CONCAT('SELECT * FROM ',sTableName,' ORDER BY id DESC;');
        PREPARE sExecute FROM @sSQL;
        EXECUTE sExecute;   
    ELSE
        SELECT CONCAT('TABLE ',sTableName,' IS EMPTY!!!') AS msg;
    END IF;
   
END */$$
DELIMITER ;

/* Procedure structure for procedure `prc_get_version` */

/*!50003 DROP PROCEDURE IF EXISTS  `prc_get_version` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_get_version`()
BEGIN
    SET @sDB := (SELECT DATABASE());
    SET @iTables :=(
        SELECT COUNT(*)
        FROM information_schema.TABLES
        WHERE (TABLE_SCHEMA = @sDB) 
        AND (TABLE_NAME = 'version_db')
    );
    IF (@iTables=1) THEN
        SELECT * FROM version_db ORDER BY id DESC LIMIT 1;
    ELSEIF (@iTables=0) THEN
        SELECT 'no version table' AS ver_schema;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `prc_table` */

/*!50003 DROP PROCEDURE IF EXISTS  `prc_table` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_table`(
    sTableName VARCHAR(25)
    ,sFieldName VARCHAR(50)
    )
BEGIN
    SET @sDB := (SELECT DATABASE());
    SET @sSQL = '
    SELECT table_name AS tablename 
    ,LOWER(column_name) AS fieldname 
    ,CASE COALESCE(pks.cn,\'\')
        WHEN \'\' THEN \'\'
        ELSE \'Y\'
    END AS ispk
    ,LOWER(DATA_TYPE) AS fieldtype
    ,CASE LOWER(DATA_TYPE) 
        WHEN \'datetime\' THEN 19 
        ELSE character_maximum_length 
    END AS fieldlen
    -- ,\'\' AS selectall
    FROM information_schema.columns
    LEFT JOIN
    (
        SELECT DISTINCT table_name AS tn,column_name AS cn
        FROM information_schema.key_column_usage
        WHERE table_schema = schema()   -- only look in the current db
        AND constraint_name = \'PRIMARY\' -- always PRIMARY for PRIMARY KEY constraints
    ) AS pks
    ON pks.tn = table_name AND pks.cn=column_name 
    WHERE 1=1 ';
    -- incluyo la bd
    SET @sSQL := CONCAT(@sSQL,'AND table_schema=\'',@sDB,'\''); 
    -- tabla
    IF(sTableName IS NOT NULL AND sTableName!='')THEN
        SET @sSQL := CONCAT(@sSQL,'AND table_name LIKE \'%',sTableName,'%\' ');    
    END IF;
    IF(sFieldName IS NOT NULL AND sFieldName!='')THEN
        SET @sSQL := CONCAT(@sSQL,'AND LOWER(column_name) LIKE \'%',sFieldName,'%\' ');    
    END IF;
    SET @sSQL := CONCAT(@sSQL,'ORDER BY tablename,ORDINAL_POSITION, fieldname ASC ');
    PREPARE sExecute FROM @sSQL;
    EXECUTE sExecute;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
