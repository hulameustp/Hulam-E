@echo off
echo Connecting to Railway MySQL...
echo.
echo Please copy and paste the following commands one by one into the MySQL shell:
echo.
echo 1. First command:
echo CREATE DATABASE IF NOT EXISTS hulame_db;
echo.
echo 2. Second command:
echo USE hulame_db;
echo.
echo 3. Third command:
echo SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
echo.
echo 4. Fourth command:
echo START TRANSACTION;
echo.
echo 5. Fifth command:
echo SET time_zone = "+00:00";
echo.
echo After entering these commands, you can copy and paste the entire content of back/railway-mysql-setup.sql
echo.
echo To connect to MySQL, run:
echo railway connect MySQL
echo.
pause 