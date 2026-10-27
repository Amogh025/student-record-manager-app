CREATE DATABASE IF NOT EXISTS student_records;
USE student_records;
CREATE TABLE IF NOT EXISTS students (
    student_id INT NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(254) NULL,
    course VARCHAR(120) NULL,
    phone VARCHAR(30) NULL,
    PRIMARY KEY (student_id),
    INDEX idx_students_name (full_name),
    INDEX idx_students_email (email)
) ENGINE=InnoDB;
