-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: lms_fiu_fb
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Temporary view structure for view `studentsincourses`
--

DROP TABLE IF EXISTS `studentsincourses`;
/*!50001 DROP VIEW IF EXISTS `studentsincourses`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `studentsincourses` AS SELECT 
 1 AS `student_id`,
 1 AS `email`,
 1 AS `f_name`,
 1 AS `l_name`,
 1 AS `course_id`,
 1 AS `name`,
 1 AS `description`,
 1 AS `seats`,
 1 AS `start_date`,
 1 AS `end_date`,
 1 AS `enrollment_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `modulesincourse`
--

DROP TABLE IF EXISTS `modulesincourse`;
/*!50001 DROP VIEW IF EXISTS `modulesincourse`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `modulesincourse` AS SELECT 
 1 AS `course_id`,
 1 AS `course_name`,
 1 AS `module_number`,
 1 AS `module_title`,
 1 AS `lockedUntil`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `studentsincourses`
--

/*!50001 DROP VIEW IF EXISTS `studentsincourses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentsincourses` AS select `students`.`id` AS `student_id`,`students`.`email` AS `email`,`students`.`f_name` AS `f_name`,`students`.`l_name` AS `l_name`,`courses`.`id` AS `course_id`,`courses`.`name` AS `name`,`courses`.`description` AS `description`,`courses`.`seats` AS `seats`,`courses`.`start_date` AS `start_date`,`courses`.`end_date` AS `end_date`,`students_courses`.`enrollment_status` AS `enrollment_status` from ((`students` join `students_courses` on((`students`.`id` = `students_courses`.`student_id`))) join `courses` on((`courses`.`id` = `students_courses`.`course_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `modulesincourse`
--

/*!50001 DROP VIEW IF EXISTS `modulesincourse`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `modulesincourse` AS select `courses`.`id` AS `course_id`,`courses`.`name` AS `course_name`,`modules`.`number` AS `module_number`,`modules`.`title` AS `module_title`,`modules`.`lockedUntil` AS `lockedUntil` from ((`courses` join `courses_modules` on((`courses`.`id` = `courses_modules`.`course_id`))) join `modules` on((`courses_modules`.`module_id` = `modules`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'lms_fiu_fb'
--

--
-- Dumping routines for database 'lms_fiu_fb'
--
/*!50003 DROP PROCEDURE IF EXISTS `selectStudentByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectStudentByEmail`(IN inEmail varchar(255))
BEGIN
	DECLARE C INT;
    
    SELECT COUNT(email) INTO C
    FROM students
    WHERE email = inEmail;

	-- check if email exists
    IF(C < 1) THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'email not found in students table';
	END IF;
    
    SELECT * FROM students WHERE email = inEmail;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-04 16:49:20
