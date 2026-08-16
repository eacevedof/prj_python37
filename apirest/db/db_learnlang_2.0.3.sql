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

/*Data for the table `_template` */

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

/*Data for the table `_template_array` */

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
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `app_array` */

insert  into `app_array`(`processflag`,`insert_platform`,`insert_user`,`insert_date`,`update_platform`,`update_user`,`update_date`,`delete_platform`,`delete_user`,`delete_date`,`cru_csvnote`,`is_erpsent`,`is_enabled`,`i`,`id`,`code_erp`,`type`,`module`,`id_tosave`,`description`,`order_by`,`code_cache`) values (NULL,'1','3','20190503172713','3','3','20190503202200',NULL,NULL,NULL,'u',NULL,'1',NULL,1,NULL,'generic','global',NULL,'pepito perz',100,'ed4e1ad0-6db7-11e9-ba75-74e5f9c5ea17'),(NULL,'2','3','20190503194455','3','3','20190503202200',NULL,NULL,NULL,'u',NULL,'1',NULL,2,NULL,'generic','global',NULL,'pepito',100,'297648ba-6dcb-11e9-95fe-74e5f9c5ea17'),(NULL,'1','3','20190503195952','1','3','20190503200805',NULL,NULL,NULL,'u',NULL,'1',NULL,3,NULL,'generic','global',NULL,'oioipioip',100,'401d7cac-6dcd-11e9-84c2-74e5f9c5ea17'),(NULL,'3','3','20190503200128','3','3','20190503200817','2','3','20190503225933','u',NULL,'0',NULL,4,NULL,'tipo','global',NULL,'nuevo activo',100,'79b8f1a4-6dcd-11e9-a26b-74e5f9c5ea17'),(NULL,'4','3','20190503202004','3','3','20190503220539',NULL,NULL,NULL,'u',NULL,'1',NULL,6,NULL,'generic','global',NULL,'nnnnn',100,'12f11de6-6dd0-11e9-9b72-74e5f9c5ea17'),(NULL,'4','3','20190503202318',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,8,NULL,'generic','global',NULL,'desactivado?',100,'86882f6c-6dd0-11e9-960c-74e5f9c5ea17'),(NULL,'1','3','20190503202346',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,9,NULL,'generic','global',NULL,'tampoco desactivado',100,'9726a8f6-6dd0-11e9-8383-74e5f9c5ea17'),(NULL,'2','3','20190503202511',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,10,NULL,'generic','global',NULL,'picklist value',100,'c9d5e926-6dd0-11e9-b4ca-74e5f9c5ea17'),(NULL,'2','3','20190503202536',NULL,NULL,NULL,'4','3','20190503225759','i',NULL,'1',NULL,11,NULL,'generic','global',NULL,'borrame softly',100,'d85dbaca-6dd0-11e9-bec9-74e5f9c5ea17'),(NULL,'2','3','20190503202806',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,12,NULL,'generic','global',NULL,'con error?',100,'31d62b62-6dd1-11e9-9917-74e5f9c5ea17'),(NULL,'1','3','20190503202858',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,13,NULL,'generic','global',NULL,'10',100,'50ff7488-6dd1-11e9-afe2-74e5f9c5ea17'),(NULL,'1','3','20190503203117',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,14,NULL,'generic','global',NULL,'54546546',100,'a404ce0a-6dd1-11e9-956f-74e5f9c5ea17'),(NULL,'1','3','20190503203143','2','3','20190503214147',NULL,NULL,NULL,'u',NULL,'1',NULL,15,NULL,'generic','global',NULL,'65454646',100,'b322149a-6dd1-11e9-9ae5-74e5f9c5ea17'),(NULL,'4','3','20190503203251','2','3','20190503215508',NULL,NULL,NULL,'u',NULL,'1',NULL,16,NULL,'generic','global',NULL,'1111444',100,'dc0e1528-6dd1-11e9-b95d-74e5f9c5ea17'),(NULL,'4','3','20190503203413','2','3','20190503204105',NULL,NULL,NULL,'u',NULL,'1',NULL,17,NULL,'generic','global',NULL,'87878979',100,'0c6fb838-6dd2-11e9-bce9-74e5f9c5ea17'),(NULL,'4','3','20190503214927',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,18,NULL,'generic','global',NULL,'555',100,'8f4d747a-6ddc-11e9-b5f4-74e5f9c5ea17'),(NULL,'4','3','20190503215635',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,19,NULL,'generic','global',NULL,'4444',100,'8e4b70f4-6ddd-11e9-a631-74e5f9c5ea17'),(NULL,'1','3','20190503215731',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,20,NULL,'generic','global',NULL,'ññññ',100,'af8d140a-6ddd-11e9-ab74-74e5f9c5ea17'),(NULL,'4','3','20190503225309',NULL,NULL,NULL,NULL,NULL,NULL,'i',NULL,'1',NULL,21,NULL,'generic','global',NULL,'uuuu',100,'754fa7ca-6de5-11e9-9412-74e5f9c5ea17');

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
  `url_video` varchar(1000) DEFAULT NULL COMMENT 'video de la lección, lo ideal es hacer una tabla de lecciones por ahora lo dejo así',
  `url_document` varchar(1000) DEFAULT NULL COMMENT 'link de zip o ppt de la lección',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_exam` */

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

/*Data for the table `app_exams_sentences` */

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

/*Data for the table `app_exams_users` */

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

/*Data for the table `app_exams_users_evalh` */

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

/*Data for the table `app_exams_users_evall` */

/*Table structure for table `app_exams_users_schedule` */

DROP TABLE IF EXISTS `app_exams_users_schedule`;

CREATE TABLE `app_exams_users_schedule` (
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
  `id_exams_users` int(11) NOT NULL COMMENT 'app_exams_users.id',
  `id_level` int(11) DEFAULT NULL COMMENT 'app_array.type=10  niveles de memorizacion',
  `date_checked` varchar(14) DEFAULT NULL COMMENT 'la última vez que se interactuó con el ',
  `date_next` varchar(14) DEFAULT NULL COMMENT 'la fecha de la próxima vez',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `app_exams_users_schedule` */

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

/*Data for the table `app_sentence` */

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

/*Data for the table `app_sentence_images` */

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

/*Data for the table `app_sentence_tags` */

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

/*Data for the table `app_sentence_tr` */

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

/*Data for the table `app_sentences_users` */

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
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `app_tag` */

insert  into `app_tag`(`processflag`,`insert_platform`,`insert_user`,`insert_date`,`update_platform`,`update_user`,`update_date`,`delete_platform`,`delete_user`,`delete_date`,`cru_csvnote`,`is_erpsent`,`is_enabled`,`i`,`id`,`id_type`,`description`,`slug`,`order_by`,`code_cache`) values (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,1,1,'a','a',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,2,1,'about-us','about-us',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,3,1,'advertencia','advertencia',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,4,1,'b','b',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,5,1,'blog','blog',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,6,1,'c','c',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,7,1,'ceveza','cerveza',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,8,1,'cms','cms',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,9,1,'contacta','contacta',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,10,1,'contents','contents',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,11,1,'design','design',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,12,1,'giusi','giusi',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,13,1,'image','image',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,14,1,'la guinda','la-guinda',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,15,1,'mexico','mexico',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,16,1,'miguel angel','miguel-angel',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,17,1,'optimus prime','',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,18,1,'papiam','papiam',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,19,1,'personal','personal',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,20,1,'portafolio','portafolio',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,21,1,'primer atticulo','primer-atticulo',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,22,1,'prueba de cms','prueba-de-cms',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,23,1,'services','services',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,24,1,'servicos','servicos',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,25,1,'shop','shop',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,26,1,'tpv.pedidos minimos','tpv-pedidos-minimos',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,27,1,'transformers','transformers',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,28,1,'video','video',100,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1',NULL,29,1,'wordpress','wordpress',100,NULL);

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

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

/*Data for the table `auth_group_permissions` */

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

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add app array',7,'add_apparray'),(26,'Can change app array',7,'change_apparray'),(27,'Can delete app array',7,'delete_apparray'),(28,'Can view app array',7,'view_apparray'),(29,'Can add app exam',8,'add_appexam'),(30,'Can change app exam',8,'change_appexam'),(31,'Can delete app exam',8,'delete_appexam'),(32,'Can view app exam',8,'view_appexam'),(33,'Can add app exams sentences',9,'add_appexamssentences'),(34,'Can change app exams sentences',9,'change_appexamssentences'),(35,'Can delete app exams sentences',9,'delete_appexamssentences'),(36,'Can view app exams sentences',9,'view_appexamssentences'),(37,'Can add app exams users',10,'add_appexamsusers'),(38,'Can change app exams users',10,'change_appexamsusers'),(39,'Can delete app exams users',10,'delete_appexamsusers'),(40,'Can view app exams users',10,'view_appexamsusers'),(41,'Can add app exams users evalh',11,'add_appexamsusersevalh'),(42,'Can change app exams users evalh',11,'change_appexamsusersevalh'),(43,'Can delete app exams users evalh',11,'delete_appexamsusersevalh'),(44,'Can view app exams users evalh',11,'view_appexamsusersevalh'),(45,'Can add app exams users evall',12,'add_appexamsusersevall'),(46,'Can change app exams users evall',12,'change_appexamsusersevall'),(47,'Can delete app exams users evall',12,'delete_appexamsusersevall'),(48,'Can view app exams users evall',12,'view_appexamsusersevall'),(49,'Can add app sentence',13,'add_appsentence'),(50,'Can change app sentence',13,'change_appsentence'),(51,'Can delete app sentence',13,'delete_appsentence'),(52,'Can view app sentence',13,'view_appsentence'),(53,'Can add app sentence images',14,'add_appsentenceimages'),(54,'Can change app sentence images',14,'change_appsentenceimages'),(55,'Can delete app sentence images',14,'delete_appsentenceimages'),(56,'Can view app sentence images',14,'view_appsentenceimages'),(57,'Can add app sentences users',15,'add_appsentencesusers'),(58,'Can change app sentences users',15,'change_appsentencesusers'),(59,'Can delete app sentences users',15,'delete_appsentencesusers'),(60,'Can view app sentences users',15,'view_appsentencesusers'),(61,'Can add app sentence tags',16,'add_appsentencetags'),(62,'Can change app sentence tags',16,'change_appsentencetags'),(63,'Can delete app sentence tags',16,'delete_appsentencetags'),(64,'Can view app sentence tags',16,'view_appsentencetags'),(65,'Can add app sentence times',17,'add_appsentencetimes'),(66,'Can change app sentence times',17,'change_appsentencetimes'),(67,'Can delete app sentence times',17,'delete_appsentencetimes'),(68,'Can view app sentence times',17,'view_appsentencetimes'),(69,'Can add app sentence tr',18,'add_appsentencetr'),(70,'Can change app sentence tr',18,'change_appsentencetr'),(71,'Can delete app sentence tr',18,'delete_appsentencetr'),(72,'Can view app sentence tr',18,'view_appsentencetr'),(73,'Can add app tag',19,'add_apptag'),(74,'Can change app tag',19,'change_apptag'),(75,'Can delete app tag',19,'delete_apptag'),(76,'Can view app tag',19,'view_apptag'),(77,'Can add base language',20,'add_baselanguage'),(78,'Can change base language',20,'change_baselanguage'),(79,'Can delete base language',20,'delete_baselanguage'),(80,'Can view base language',20,'view_baselanguage'),(81,'Can add base language lang',21,'add_baselanguagelang'),(82,'Can change base language lang',21,'change_baselanguagelang'),(83,'Can delete base language lang',21,'delete_baselanguagelang'),(84,'Can view base language lang',21,'view_baselanguagelang'),(85,'Can add base user',22,'add_baseuser'),(86,'Can change base user',22,'change_baseuser'),(87,'Can delete base user',22,'delete_baseuser'),(88,'Can view base user',22,'view_baseuser'),(89,'Can add base user array',23,'add_baseuserarray'),(90,'Can change base user array',23,'change_baseuserarray'),(91,'Can delete base user array',23,'delete_baseuserarray'),(92,'Can view base user array',23,'view_baseuserarray'),(93,'Can add template',24,'add_template'),(94,'Can change template',24,'change_template'),(95,'Can delete template',24,'delete_template'),(96,'Can view template',24,'view_template'),(97,'Can add template array',25,'add_templatearray'),(98,'Can change template array',25,'change_templatearray'),(99,'Can delete template array',25,'delete_templatearray'),(100,'Can view template array',25,'view_templatearray'),(101,'Can add version db',26,'add_versiondb'),(102,'Can change version db',26,'change_versiondb'),(103,'Can delete version db',26,'delete_versiondb'),(104,'Can view version db',26,'view_versiondb');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (1,'pbkdf2_sha256$150000$kK228PsfZrvK$R4AJZ8eYfZaR6A/DInDuenmo60ruKhUh/PT4FqXo5Tw=','2019-05-05 10:52:42.735207',1,'sa','','','sa@theframework.es',1,1,'2019-04-20 22:13:58.619448'),(2,'pbkdf2_sha256$150000$aWLw4dA2SH9V$g3nWr7rsH3Oo7IpqZWiA0wUmLoVrp/xfWyXBTF0VbsE=',NULL,1,'sa2','','','sa2@tfw.es',1,1,'2019-04-28 13:59:16.096768'),(3,'pbkdf2_sha256$150000$U394Fhz3vsWm$hirfJR89ZoMW0DzTTLu0YGA5gko9TSbuhd4oFjcvErA=','2019-04-28 18:57:09.310258',1,'sa3','','','sa3@tfw.es',1,1,'2019-04-28 14:21:05.951416');

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

/*Data for the table `auth_user_groups` */

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

/*Data for the table `auth_user_user_permissions` */

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
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `base_language` */

insert  into `base_language`(`processflag`,`insert_platform`,`insert_user`,`insert_date`,`update_platform`,`update_user`,`update_date`,`delete_platform`,`delete_user`,`delete_date`,`cru_csvnote`,`is_erpsent`,`is_enabled`,`i`,`id`,`code_erp`,`id_tosave`,`description`,`code_iso`,`order_by`,`code_cache`) values (NULL,'1','1','20140825073501','1','1','20140825073501',NULL,NULL,NULL,NULL,'0','1',NULL,1,'english','english','ENGLISH','en',100,NULL),(NULL,'1','1','20140825073501','1','1','20140825073501',NULL,NULL,NULL,NULL,'0','1',NULL,2,'spanish','spanish','SPANISH','es',100,NULL),(NULL,'1','1','20140825073501','1','1','20140825073501',NULL,NULL,NULL,NULL,'0','1',NULL,3,'dutch','dutch','DUTCH','nl',100,NULL),(NULL,'1','1','20140825073501','3','1','20170114120045',NULL,NULL,NULL,NULL,'0','1',NULL,4,'papiaments','papiaments','PAPIAMENTS','pap',100,NULL);

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
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_language_lang` */

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
  `id_country` int(11) DEFAULT NULL COMMENT 'app_array.type=country',
  `id_language` int(11) DEFAULT NULL COMMENT 'su idioma de preferencia',
  `path_picture` varchar(100) DEFAULT NULL,
  `id_profile` int(11) DEFAULT NULL COMMENT 'app_array.type=profile: user,maintenaince,system',
  `tokenreset` varchar(250) DEFAULT NULL,
  `log_attempts` int(5) DEFAULT '0',
  `rating` int(11) DEFAULT NULL COMMENT 'la puntuacion',
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_user` */

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
  `code_cache` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_user_array` */

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
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (1,'2019-04-21 12:16:56.931203','3','AppArray object (3)',1,'[{\"added\": {}}]',7,1),(2,'2019-04-21 13:31:10.864223','4','AppArray object (4)',1,'[{\"added\": {}}]',7,1),(3,'2019-04-21 13:31:35.941650','4','AppArray object (4)',2,'[]',7,1),(4,'2019-04-21 14:27:29.654207','5','AppArray object (5)',1,'[{\"added\": {}}]',7,1),(5,'2019-04-21 14:35:55.294048','3','AppArray object (3)',3,'',7,1),(6,'2019-04-21 15:38:46.951009','11','AppArray object (11)',1,'[{\"added\": {}}]',7,1),(7,'2019-04-21 15:39:55.336796','12','AppArray object (12)',1,'[{\"added\": {}}]',7,1),(8,'2019-04-21 15:40:25.602301','13','AppArray object (13)',1,'[{\"added\": {}}]',7,1),(9,'2019-04-21 15:40:48.714448','14','AppArray object (14)',1,'[{\"added\": {}}]',7,1),(10,'2019-04-21 15:40:51.198738','15','AppArray object (15)',1,'[{\"added\": {}}]',7,1),(11,'2019-04-21 15:42:33.196306','16','AppArray object (16)',1,'[{\"added\": {}}]',7,1),(12,'2019-04-21 15:43:10.163156','17','AppArray object (17)',1,'[{\"added\": {}}]',7,1),(13,'2019-04-21 15:43:12.816046','18','AppArray object (18)',1,'[{\"added\": {}}]',7,1),(14,'2019-04-28 11:37:32.258253','3','AppArray object (3)',1,'[{\"added\": {}}]',7,1),(15,'2019-04-28 14:24:01.239546','5','AppArray object (5)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,1),(16,'2019-04-28 14:30:02.797792','6','AppArray object (6)',1,'[{\"added\": {}}]',7,1),(17,'2019-04-28 16:15:08.088934','7','AppArray object (7)',1,'[{\"added\": {}}]',7,1),(18,'2019-04-28 16:26:36.431281','5','AppArray object (5)',2,'[]',7,1),(19,'2019-04-28 16:31:58.243713','5','AppArray object (5)',2,'[]',7,1),(20,'2019-04-28 16:52:10.273238','4','AppArray object (4)',2,'[]',7,1),(21,'2019-04-28 16:55:16.859724','8','AppArray object (8)',1,'[{\"added\": {}}]',7,1),(22,'2019-04-28 16:57:38.619870','9','AppArray object (9)',1,'[{\"added\": {}}]',7,1),(23,'2019-04-28 16:57:45.512806','10','AppArray object (10)',1,'[{\"added\": {}}]',7,1),(24,'2019-04-28 16:58:06.995590','11','AppArray object (11)',1,'[{\"added\": {}}]',7,1),(25,'2019-04-28 16:59:12.286986','12','AppArray object (12)',1,'[{\"added\": {}}]',7,1),(26,'2019-04-28 17:00:15.749673','13','AppArray object (13)',1,'[{\"added\": {}}]',7,1),(27,'2019-04-28 17:01:11.313475','14','AppArray object (14)',1,'[{\"added\": {}}]',7,1),(28,'2019-04-28 17:01:38.048276','14','AppArray object (14)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,1),(29,'2019-04-28 17:02:21.882240','11','AppArray object (11)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,1),(30,'2019-04-28 17:04:11.232210','7','AppArray object (7)',2,'[{\"changed\": {\"fields\": [\"type\", \"description\"]}}]',7,1),(31,'2019-04-28 17:06:32.629583','1','AppArray object (1)',1,'[{\"added\": {}}]',7,1),(32,'2019-05-02 17:18:33.933193','1','bbb (1)',2,'[]',7,3),(33,'2019-05-02 17:18:38.657851','1','lkjkkjkl (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(34,'2019-05-02 17:18:43.113577','2','55kklñlkkñ (2)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(35,'2019-05-02 17:19:17.333303','1','jkdfsjal (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(36,'2019-05-02 17:19:23.580416','2','55kklñlkkñ (2)',2,'[{\"changed\": {\"fields\": [\"order_by\"]}}]',7,3),(37,'2019-05-02 17:19:49.061715','1','jkdfsjal11 (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(38,'2019-05-02 17:20:13.963053','1','jkdfsjal11222 (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(39,'2019-05-02 17:20:29.840820','2','5555 (2)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(40,'2019-05-02 17:20:34.063966','3','7878 (3)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(41,'2019-05-02 17:22:22.240330','1','jjdkjksfl (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(42,'2019-05-02 17:22:22.259279','2','jkjkljdfkl (2)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(43,'2019-05-02 17:22:22.278265','3','kjlkjkl (3)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(44,'2019-05-02 17:22:36.682385','1','jjdkjksfl (1)',2,'[{\"changed\": {\"fields\": [\"type\"]}}]',7,3),(45,'2019-05-02 17:24:09.995123','1','jjhhhh (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(46,'2019-05-02 17:24:14.666728','1','jjjjjjjjjj (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(47,'2019-05-02 17:25:11.217589','2','dsafjshdj (2)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(48,'2019-05-02 17:25:11.329023','3','kjklkjljkkjjkkjllkjñjkñkj (3)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(49,'2019-05-02 17:26:29.765337','2','dsafjshdj (2)',2,'[{\"changed\": {\"fields\": [\"type\"]}}]',7,3),(50,'2019-05-02 17:28:34.766625','1','jjjjjjjjjjjjjj787897 (1)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(51,'2019-05-02 17:30:09.787638','1','jjjjjjjjjjjjjj787897 (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(52,'2019-05-02 17:30:15.113888','1','jjjjjjjjjjjjjj787897 (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(53,'2019-05-02 17:30:15.221771','2','dsafjshdj (2)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(54,'2019-05-02 17:30:30.155829','2','dsafjshdj (2)',2,'[]',7,3),(55,'2019-05-02 17:32:35.634688','2','dsafjshdj (2)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(56,'2019-05-02 18:07:31.550083','3','kjklkjljkkjjkkjllkjñjkñkj (3)',2,'[]',7,3),(57,'2019-05-02 18:07:47.872632','1','jjjjjjjjjjjjjj787897 (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(58,'2019-05-02 18:07:48.007211','2','dsafjshdj (2)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(59,'2019-05-02 18:07:48.129009','3','kjklkjljkkjjkkjllkjñjkñkj (3)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(60,'2019-05-03 14:54:23.529177','1','some desc (1)',1,'[{\"added\": {}}]',7,3),(61,'2019-05-03 15:14:51.325762','1','1122333 (1)',1,'[{\"added\": {}}]',7,3),(62,'2019-05-03 15:27:13.938244','1','pepito perz (1)',1,'[{\"added\": {}}]',7,3),(63,'2019-05-03 15:48:32.135213','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(64,'2019-05-03 16:18:25.775684','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(65,'2019-05-03 16:22:10.052354','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(66,'2019-05-03 16:24:20.707739','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(67,'2019-05-03 16:25:06.441247','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(68,'2019-05-03 17:31:22.732908','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(69,'2019-05-03 17:42:07.066420','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(70,'2019-05-03 17:43:20.170744','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(71,'2019-05-03 17:44:55.301706','2','pepito (2)',1,'[{\"added\": {}}]',7,3),(72,'2019-05-03 17:45:46.094141','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(73,'2019-05-03 17:55:32.069018','1','pepito perz (1)',2,'[]',7,3),(74,'2019-05-03 17:58:52.893484','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(75,'2019-05-03 17:59:52.303767','3','oioipioip (3)',1,'[{\"added\": {}}]',7,3),(76,'2019-05-03 18:01:28.950737','4','nuevo activo (4)',1,'[{\"added\": {}}]',7,3),(77,'2019-05-03 18:03:13.653743','5','0000 (5)',1,'[{\"added\": {}}]',7,3),(78,'2019-05-03 18:04:33.122026','5','0000 (5)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(79,'2019-05-03 18:04:47.075173','5','00klklkñkñ (5)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(80,'2019-05-03 18:07:08.783708','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(81,'2019-05-03 18:07:18.567473','2','pepito (2)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(82,'2019-05-03 18:07:18.589330','3','oioipioip (3)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(83,'2019-05-03 18:08:05.281229','3','oioipioip (3)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(84,'2019-05-03 18:08:17.966874','4','nuevo activo (4)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(85,'2019-05-03 18:15:56.631821','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(86,'2019-05-03 18:16:33.999408','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(87,'2019-05-03 18:20:05.003733','6','bgt (6)',1,'[{\"added\": {}}]',7,3),(88,'2019-05-03 18:20:58.602777','7','no enabled (7)',1,'[{\"added\": {}}]',7,3),(89,'2019-05-03 18:21:13.488068','7','no enabled (7)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(90,'2019-05-03 18:22:00.491402','1','pepito perz (1)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(91,'2019-05-03 18:22:00.526301','2','pepito (2)',2,'[{\"changed\": {\"fields\": [\"is_enabled\"]}}]',7,3),(92,'2019-05-03 18:22:20.780705','5','00klklkñkñ (5)',3,'',7,3),(93,'2019-05-03 18:22:20.790729','7','no enabled (7)',3,'',7,3),(94,'2019-05-03 18:23:18.931762','8','desactivado? (8)',1,'[{\"added\": {}}]',7,3),(95,'2019-05-03 18:23:46.811923','9','tampoco desactivado (9)',1,'[{\"added\": {}}]',7,3),(96,'2019-05-03 18:25:11.846528','10','picklist value (10)',1,'[{\"added\": {}}]',7,3),(97,'2019-05-03 18:25:36.225434','11','borrame softly (11)',1,'[{\"added\": {}}]',7,3),(98,'2019-05-03 18:28:06.335256','12','con error? (12)',1,'[{\"added\": {}}]',7,3),(99,'2019-05-03 18:28:58.621206','13','10 (13)',1,'[{\"added\": {}}]',7,3),(100,'2019-05-03 18:31:17.901121','14','54546546 (14)',1,'[{\"added\": {}}]',7,3),(101,'2019-05-03 18:31:43.256137','15','65454646 (15)',1,'[{\"added\": {}}]',7,3),(102,'2019-05-03 18:32:12.135608','15','65454646 (15)',2,'[]',7,3),(103,'2019-05-03 18:32:51.915322','16','1111 (16)',1,'[{\"added\": {}}]',7,3),(104,'2019-05-03 18:34:13.098801','17','87878979 (17)',1,'[{\"added\": {}}]',7,3),(105,'2019-05-03 18:39:34.673573','17','87878979 (17)',2,'[]',7,3),(106,'2019-05-03 18:41:05.368401','17','87878979 (17)',2,'[]',7,3),(107,'2019-05-03 19:41:47.701128','15','65454646 (15)',2,'[]',7,3),(108,'2019-05-03 19:49:27.617126','18','555 (18)',1,'[{\"added\": {}}]',7,3),(109,'2019-05-03 19:55:08.100168','16','1111444 (16)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(110,'2019-05-03 19:56:35.413963','19','4444 (19)',1,'[{\"added\": {}}]',7,3),(111,'2019-05-03 19:57:31.208897','20','ññññ (20)',1,'[{\"added\": {}}]',7,3),(112,'2019-05-03 20:05:39.584030','6','nnnnn (6)',2,'[{\"changed\": {\"fields\": [\"description\"]}}]',7,3),(113,'2019-05-03 20:53:09.472375','21','uuuu (21)',1,'[{\"added\": {}}]',7,3);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'theapp','apparray'),(8,'theapp','appexam'),(9,'theapp','appexamssentences'),(10,'theapp','appexamsusers'),(11,'theapp','appexamsusersevalh'),(12,'theapp','appexamsusersevall'),(13,'theapp','appsentence'),(14,'theapp','appsentenceimages'),(15,'theapp','appsentencesusers'),(16,'theapp','appsentencetags'),(17,'theapp','appsentencetimes'),(18,'theapp','appsentencetr'),(19,'theapp','apptag'),(20,'theapp','baselanguage'),(21,'theapp','baselanguagelang'),(22,'theapp','baseuser'),(23,'theapp','baseuserarray'),(24,'theapp','template'),(25,'theapp','templatearray'),(26,'theapp','versiondb');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2019-04-20 20:37:05.587588'),(2,'auth','0001_initial','2019-04-20 20:37:05.756875'),(3,'admin','0001_initial','2019-04-20 20:37:06.204744'),(4,'admin','0002_logentry_remove_auto_add','2019-04-20 20:37:06.305296'),(5,'admin','0003_logentry_add_action_flag_choices','2019-04-20 20:37:06.320956'),(6,'contenttypes','0002_remove_content_type_name','2019-04-20 20:37:06.421538'),(7,'auth','0002_alter_permission_name_max_length','2019-04-20 20:37:06.474895'),(8,'auth','0003_alter_user_email_max_length','2019-04-20 20:37:06.543529'),(9,'auth','0004_alter_user_username_opts','2019-04-20 20:37:06.543529'),(10,'auth','0005_alter_user_last_login_null','2019-04-20 20:37:06.590489'),(11,'auth','0006_require_contenttypes_0002','2019-04-20 20:37:06.590489'),(12,'auth','0007_alter_validators_add_error_messages','2019-04-20 20:37:06.606053'),(13,'auth','0008_alter_user_username_max_length','2019-04-20 20:37:06.643853'),(14,'auth','0009_alter_user_last_name_max_length','2019-04-20 20:37:06.728465'),(15,'auth','0010_alter_group_name_max_length','2019-04-20 20:37:06.806829'),(16,'auth','0011_update_proxy_permissions','2019-04-20 20:37:06.806829'),(17,'sessions','0001_initial','2019-04-20 20:37:06.828507'),(18,'theapp','0001_initial','2019-04-20 20:37:06.875415');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('5bfn7ub2qj8vxxvrehz235q0zx4i8di8','ZWYwZjgxNDNmNDcyZGM5NzcwMTM3OWRiYjAxMTgyNjk0YjI0ODNkNDp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1MDFmOWI3YmYxN2M2OGExMTBhODQxMWU2NmU2MzgxNjM5NWRkMjg4In0=','2019-05-12 18:57:09.333293'),('ucu7f6e98otkflunmx78gu0wmfdvl3v8','ZGI3OGJjNGE2OWE4ZWE3MWIzY2U4YzFlNzY5YmQ0MTEwZjBjMWY3Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlYzk2YTUzYWJiNmFjOGRhYzhmMTVlMjUzYTVjZGExNGVlY2ExYzljIn0=','2019-05-05 12:08:18.407290'),('viu61onusln6rlgow3esgj3q1j93qanu','ZGI3OGJjNGE2OWE4ZWE3MWIzY2U4YzFlNzY5YmQ0MTEwZjBjMWY3Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlYzk2YTUzYWJiNmFjOGRhYzhmMTVlMjUzYTVjZGExNGVlY2ExYzljIn0=','2019-05-19 10:52:42.782353');

/*Table structure for table `version_db` */

DROP TABLE IF EXISTS `version_db`;

CREATE TABLE `version_db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` char(14) DEFAULT NULL COMMENT 'mysql no permite funciones evaluadas por defcto se debe crear un trigger REPLACE(REPLACE(REPLACE(NOW(),''-'',''''),'':'',''''),'' '','''') mssql+1',
  `version` varchar(15) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `version_db` */

insert  into `version_db`(`id`,`date`,`version`,`description`) values (1,'20190420162500','1.0.0','definicion'),(2,'20190409211700','1.0.1','cambio estructura de tablas');

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
