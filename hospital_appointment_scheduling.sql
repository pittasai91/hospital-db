DROP DATABASE IF EXISTS `Hospital_Appointment_Scheduling`;
CREATE DATABASE `Hospital_Appointment_Scheduling`;
USE `Hospital_Appointment_Scheduling`;

-- ====================================
-- HOSPITAL APPOINTMENT SCHEDULING DATASET
-- ====================================
-- Goal for students:
-- Use this dataset to build an appointment schedule for doctors using SQL.
-- Students should avoid doctor clashes, room clashes, and duplicate slot bookings.

CREATE TABLE departments (
  department_id INT NOT NULL,
  department_name VARCHAR(50) NOT NULL,
  floor_no INT,
  head_doctor_id INT,
  room_id INT,
  PRIMARY KEY (department_id)
);

CREATE TABLE doctors (
  doctor_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender VARCHAR(10),
  experience_years INT,
  PRIMARY KEY (doctor_id)
);

CREATE TABLE specializations (
  specialization_id INT NOT NULL,
  specialization_name VARCHAR(50) NOT NULL,
  specialization_code VARCHAR(20) NOT NULL,
  weekly_sessions INT NOT NULL,
  PRIMARY KEY (specialization_id)
);

CREATE TABLE patients (
  patient_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  department_id INT NOT NULL,
  patient_no INT NOT NULL,
  gender VARCHAR(10),
  PRIMARY KEY (patient_id)
);

CREATE TABLE rooms (
  room_id INT NOT NULL,
  room_name VARCHAR(30) NOT NULL,
  room_type VARCHAR(30),
  capacity INT,
  PRIMARY KEY (room_id)
);

CREATE TABLE week_days (
  day_id INT NOT NULL,
  day_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (day_id)
);

CREATE TABLE time_slots (
  slot_id INT NOT NULL,
  slot_number INT NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  slot_type VARCHAR(20) DEFAULT 'Consultation',
  PRIMARY KEY (slot_id)
);

CREATE TABLE doctor_specialization_department (
  mapping_id INT NOT NULL,
  doctor_id INT NOT NULL,
  specialization_id INT NOT NULL,
  department_id INT NOT NULL,
  PRIMARY KEY (mapping_id)
);

-- Students can fill this table by writing INSERT queries
-- after deciding the appointment schedule.
CREATE TABLE appointment_schedule (
  schedule_id INT NOT NULL AUTO_INCREMENT,
  department_id INT NOT NULL,
  doctor_id INT NOT NULL,
  specialization_id INT NOT NULL,
  room_id INT NOT NULL,
  day_id INT NOT NULL,
  slot_id INT NOT NULL,
  PRIMARY KEY (schedule_id)
);

INSERT INTO doctors (doctor_id, first_name, last_name, gender, experience_years)
VALUES
(1, 'Arjun', 'Reddy', 'Male', 8),
(2, 'Priya', 'Sharma', 'Female', 6),
(3, 'Rahul', 'Verma', 'Male', 10),
(4, 'Sneha', 'Iyer', 'Female', 5),
(5, 'Kiran', 'Kumar', 'Male', 7),
(6, 'Anjali', 'Mehta', 'Female', 9),
(7, 'Vikram', 'Singh', 'Male', 4),
(8, 'Meera', 'Nair', 'Female', 11),
(9, 'Suresh', 'Patel', 'Male', 12),
(10, 'Divya', 'Rao', 'Female', 3);

INSERT INTO rooms (room_id, room_name, room_type, capacity)
VALUES
(1, 'Room 101', 'Consultation', 2),
(2, 'Room 102', 'Consultation', 2),
(3, 'Room 103', 'Consultation', 2),
(4, 'Diagnostic Lab', 'Lab', 5),
(5, 'Radiology Suite', 'Lab', 4),
(6, 'Physiotherapy Hall', 'Therapy Room', 10),
(7, 'Minor OT', 'Operation Theatre', 6);

INSERT INTO departments (department_id, department_name, floor_no, head_doctor_id, room_id)
VALUES
(1, 'Cardiology', 1, 2, 1),
(2, 'Orthopedics', 1, 4, 2),
(3, 'Pediatrics', 2, 1, 3),
(4, 'Dermatology', 2, 6, 1),
(5, 'Neurology', 3, 3, 2);

INSERT INTO specializations (specialization_id, specialization_name, specialization_code, weekly_sessions)
VALUES
(1, 'General Consultation', 'GEN', 5),
(2, 'Follow-up Review', 'FUP', 5),
(3, 'Diagnostic Imaging', 'DIA', 4),
(4, 'Minor Procedure', 'PROC', 4),
(5, 'Physiotherapy Session', 'PHY', 3),
(6, 'Vaccination', 'VAC', 3),
(7, 'Health Screening', 'SCR', 2),
(8, 'Counseling', 'CNS', 1);

INSERT INTO week_days (day_id, day_name)
VALUES
(1, 'Monday'),
(2, 'Tuesday'),
(3, 'Wednesday'),
(4, 'Thursday'),
(5, 'Friday');

INSERT INTO time_slots (slot_id, slot_number, start_time, end_time, slot_type)
VALUES
(1, 1, '09:00:00', '09:45:00', 'Consultation'),
(2, 2, '09:45:00', '10:30:00', 'Consultation'),
(3, 3, '10:30:00', '11:15:00', 'Consultation'),
(4, 4, '11:15:00', '12:00:00', 'Consultation'),
(5, 5, '12:00:00', '12:30:00', 'Break'),
(6, 6, '12:30:00', '01:15:00', 'Consultation'),
(7, 7, '01:15:00', '02:00:00', 'Consultation'),
(8, 8, '02:00:00', '02:45:00', 'Consultation');

INSERT INTO doctor_specialization_department (mapping_id, doctor_id, specialization_id, department_id)
VALUES
-- Cardiology
(1, 2, 1, 1),
(2, 4, 2, 1),
(3, 8, 3, 1),
(4, 5, 4, 1),
(5, 10, 5, 1),
(6, 6, 6, 1),
(7, 7, 7, 1),
(8, 9, 8, 1),

-- Orthopedics
(9, 4, 1, 2),
(10, 2, 2, 2),
(11, 8, 3, 2),
(12, 5, 4, 2),
(13, 10, 5, 2),
(14, 6, 6, 2),
(15, 7, 7, 2),
(16, 9, 8, 2),

-- Pediatrics
(17, 1, 1, 3),
(18, 4, 2, 3),
(19, 3, 3, 3),
(20, 5, 4, 3),
(21, 10, 5, 3),
(22, 6, 6, 3),
(23, 7, 7, 3),
(24, 9, 8, 3),

-- Dermatology
(25, 3, 1, 4),
(26, 2, 2, 4),
(27, 8, 3, 4),
(28, 5, 4, 4),
(29, 10, 5, 4),
(30, 6, 6, 4),
(31, 7, 7, 4),
(32, 9, 8, 4),

-- Neurology
(33, 3, 1, 5),
(34, 2, 2, 5),
(35, 8, 3, 5),
(36, 1, 4, 5),
(37, 10, 5, 5),
(38, 6, 6, 5),
(39, 7, 7, 5),
(40, 9, 8, 5);

INSERT INTO patients (patient_id, first_name, last_name, department_id, patient_no, gender)
VALUES
(1, 'Aarav', 'Kumar', 1, 1, 'Male'),
(2, 'Ishita', 'Rao', 1, 2, 'Female'),
(3, 'Rohan', 'Mehta', 1, 3, 'Male'),
(4, 'Saanvi', 'Sharma', 1, 4, 'Female'),
(5, 'Kabir', 'Patel', 1, 5, 'Male'),

(6, 'Anaya', 'Reddy', 2, 1, 'Female'),
(7, 'Vihaan', 'Singh', 2, 2, 'Male'),
(8, 'Myra', 'Nair', 2, 3, 'Female'),
(9, 'Aditya', 'Verma', 2, 4, 'Male'),
(10, 'Diya', 'Iyer', 2, 5, 'Female'),

(11, 'Krish', 'Rao', 3, 1, 'Male'),
(12, 'Avni', 'Patel', 3, 2, 'Female'),
(13, 'Yash', 'Kumar', 3, 3, 'Male'),
(14, 'Nisha', 'Mehta', 3, 4, 'Female'),
(15, 'Aryan', 'Sharma', 3, 5, 'Male'),

(16, 'Tanvi', 'Reddy', 4, 1, 'Female'),
(17, 'Dev', 'Singh', 4, 2, 'Male'),
(18, 'Kiara', 'Nair', 4, 3, 'Female'),
(19, 'Manav', 'Verma', 4, 4, 'Male'),
(20, 'Riya', 'Iyer', 4, 5, 'Female'),

(21, 'Harsh', 'Rao', 5, 1, 'Male'),
(22, 'Aditi', 'Patel', 5, 2, 'Female'),
(23, 'Neil', 'Kumar', 5, 3, 'Male'),
(24, 'Sara', 'Mehta', 5, 4, 'Female'),
(25, 'Om', 'Sharma', 5, 5, 'Male');

-- ====================================
-- OPTIONAL SAMPLE APPOINTMENT SCHEDULE
-- ====================================
-- This is a partial sample only.
-- Students can delete this and create their own complete schedule.

INSERT INTO appointment_schedule (department_id, doctor_id, specialization_id, room_id, day_id, slot_id)
VALUES
(1, 2, 1, 1, 1, 1),
(1, 4, 2, 1, 1, 2),
(1, 8, 3, 4, 1, 3),
(1, 5, 4, 1, 1, 4),
(1, 10, 5, 5, 1, 6),
(1, 6, 6, 1, 1, 7),
(1, 7, 7, 7, 1, 8),

(2, 4, 1, 2, 1, 1),
(2, 2, 2, 2, 1, 2),
(2, 8, 3, 4, 1, 4),
(2, 5, 4, 2, 1, 6),
(2, 10, 5, 5, 1, 7),
(2, 6, 6, 2, 1, 8),

(3, 1, 1, 3, 1, 1),
(3, 4, 2, 3, 1, 3),
(3, 3, 3, 4, 1, 4),
(3, 5, 4, 3, 1, 6),
(3, 10, 5, 5, 1, 8);


-- ====================================
-- USEFUL STUDENT TASK QUERIES
-- ====================================
-- 1. View Appointment Schedule in Readable Format
SELECT
    dpt.department_name,
    wd.day_name,
    ts.slot_number,
    ts.start_time,
    ts.end_time,
    sp.specialization_name,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    r.room_name
FROM appointment_schedule aps
JOIN departments dpt
    ON aps.department_id = dpt.department_id
JOIN week_days wd
    ON aps.day_id = wd.day_id
JOIN time_slots ts
    ON aps.slot_id = ts.slot_id
JOIN specializations sp
    ON aps.specialization_id = sp.specialization_id
JOIN doctors d
    ON aps.doctor_id = d.doctor_id
JOIN rooms r
    ON aps.room_id = r.room_id
ORDER BY dpt.department_id, wd.day_id, ts.slot_number;

-- 2. Find Doctor Clashes
SELECT
    doctor_id,
    day_id,
    slot_id,
    COUNT(*) AS clash_count
FROM appointment_schedule
GROUP BY doctor_id, day_id, slot_id
HAVING COUNT(*) > 1;

-- 3. Find Room Clashes
SELECT
    room_id,
    day_id,
    slot_id,
    COUNT(*) AS room_clash_count
FROM appointment_schedule
GROUP BY room_id, day_id, slot_id
HAVING COUNT(*) > 1;

-- 4. Check Specialization Weekly Session Count by Department
SELECT
    dpt.department_name,
    sp.specialization_name,
    sp.weekly_sessions AS required_sessions,
    COUNT(aps.schedule_id) AS assigned_sessions
FROM departments dpt
JOIN specializations sp
LEFT JOIN appointment_schedule aps
    ON dpt.department_id = aps.department_id
    AND sp.specialization_id = aps.specialization_id
GROUP BY dpt.department_id, sp.specialization_id
ORDER BY dpt.department_id, sp.specialization_id;

-- 5. Check Invalid Doctor-Specialization-Department Assignments
SELECT aps.*
FROM appointment_schedule aps
LEFT JOIN doctor_specialization_department dsd
    ON aps.doctor_id = dsd.doctor_id
    AND aps.specialization_id = dsd.specialization_id
    AND aps.department_id = dsd.department_id
WHERE dsd.mapping_id IS NULL;
