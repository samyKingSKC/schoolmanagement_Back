-- =========================================================
-- SCHOOL MANAGEMENT SYSTEM - COMPREHENSIVE SEED DATA
-- =========================================================
-- This file contains realistic seed data for a Nigerian school
-- Password for all users: password123
-- Hashed password: $2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry
-- =========================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- =========================================================
-- 1. ADMINS (School Administrators)
-- =========================================================

INSERT INTO `admins` (`id`, `firstname`, `lastname`, `school`, `email`, `phone`, `password`, `status`, `createdAt`, `updatedAt`, `credit`) VALUES
(1, 'Chinedu', 'Okafor', 'Graceland International School', 'admin@graceland.edu.ng', '08012345678', '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', 'Active', '2025-09-01 08:00:00', '2026-02-01 08:00:00', 5000),
(2, 'Amina', 'Bello', 'Heritage Academy Umuahia', 'principal@heritage.edu.ng', '08023456789', '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', 'Active', '2025-09-01 09:00:00', '2026-02-01 09:00:00', 8500),
(3, 'Emeka', 'Nwankwo', 'Divine Wisdom College', 'admin@divinewisdom.edu.ng', '08034567890', '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', 'Active', '2025-09-01 10:00:00', '2026-02-01 10:00:00', 3200),
(4, 'Fatima', 'Yusuf', 'Royal Crown Secondary School', 'admin@royalcrown.edu.ng', '08045678901', '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', 'Active', '2025-09-01 11:00:00', '2026-02-01 11:00:00', 6700),
(5, 'Ngozi', 'Eze', 'Betheal Kiddies International School', 'admin@betheal.edu.ng', '08056789012', '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', 'Active', '2025-09-01 12:00:00', '2026-02-01 12:00:00', 4100);

-- =========================================================
-- 2. CLASSES
-- =========================================================

-- School 1: Graceland International School
INSERT INTO `classes` (`id`, `name`, `schoolID`, `createdAt`, `updatedAt`) VALUES
(1, 'JSS 1A', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(2, 'JSS 1B', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(3, 'JSS 2A', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(4, 'JSS 2B', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(5, 'JSS 3A', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(6, 'SS 1A', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(7, 'SS 2A', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(8, 'SS 3A', 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),

-- School 2: Heritage Academy
(9, 'JSS 1', 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(10, 'JSS 2', 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(11, 'JSS 3', 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(12, 'SS 1', 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(13, 'SS 2', 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(14, 'SS 3', 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),

-- School 3: Divine Wisdom College
(15, 'JSS 1 Gold', 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(16, 'JSS 2 Gold', 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(17, 'JSS 3 Gold', 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(18, 'SS 1 Science', 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(19, 'SS 1 Arts', 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(20, 'SS 2 Science', 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(21, 'SS 3 Science', 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),

-- School 4: Royal Crown
(22, 'Junior 1', 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(23, 'Junior 2', 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(24, 'Junior 3', 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(25, 'Senior 1', 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(26, 'Senior 2', 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(27, 'Senior 3', 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),

-- School 5: Betheal Kiddies
(28, 'Basic 1', 5, '2025-09-01 12:00:00', '2025-09-01 12:00:00'),
(29, 'Basic 2', 5, '2025-09-01 12:00:00', '2025-09-01 12:00:00'),
(30, 'Basic 3', 5, '2025-09-01 12:00:00', '2025-09-01 12:00:00');

-- =========================================================
-- 3. TEACHERS
-- =========================================================

-- School 1: Graceland International School
INSERT INTO `teachers` (`id`, `firstname`, `lastname`, `phone`, `email`, `status`, `schoolID`, `classID`, `password`, `createdAt`, `updatedAt`) VALUES
(1, 'Obiageli', 'Okeke', '08067890123', 'obiageli.okeke@graceland.edu.ng', 'Active', 1, 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(2, 'Ibrahim', 'Suleiman', '08078901234', 'ibrahim.suleiman@graceland.edu.ng', 'Active', 1, 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(3, 'Grace', 'Adeyemi', '08089012345', 'grace.adeyemi@graceland.edu.ng', 'Active', 1, 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(4, 'Tunde', 'Ogunleye', '08090123456', 'tunde.ogunleye@graceland.edu.ng', 'Active', 1, 6, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(5, 'Blessing', 'Nnamdi', '08101234567', 'blessing.nnamdi@graceland.edu.ng', 'Active', 1, 7, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 08:00:00', '2025-09-01 08:00:00'),

-- School 2: Heritage Academy
(6, 'Adamu', 'Garba', '08112345678', 'adamu.garba@heritage.edu.ng', 'Active', 2, 9, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(7, 'Chioma', 'Obi', '08123456789', 'chioma.obi@heritage.edu.ng', 'Active', 2, 10, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(8, 'Michael', 'Udoh', '08134567890', 'michael.udoh@heritage.edu.ng', 'Active', 2, 11, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(9, 'Khadija', 'Mohammed', '08145678901', 'khadija.mohammed@heritage.edu.ng', 'Active', 2, 12, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 09:00:00', '2025-09-01 09:00:00'),

-- School 3: Divine Wisdom College
(10, 'Chukwudi', 'Igwe', '08156789012', 'chukwudi.igwe@divinewisdom.edu.ng', 'Active', 3, 15, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(11, 'Patience', 'Akpan', '08167890123', 'patience.akpan@divinewisdom.edu.ng', 'Active', 3, 16, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(12, 'Samuel', 'Eze', '08178901234', 'samuel.eze@divinewisdom.edu.ng', 'Active', 3, 18, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 10:00:00', '2025-09-01 10:00:00'),

-- School 4: Royal Crown
(13, 'Nneka', 'Chukwuma', '08189012345', 'nneka.chukwuma@royalcrown.edu.ng', 'Active', 4, 22, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(14, 'Yusuf', 'Abdullahi', '08190123456', 'yusuf.abdullahi@royalcrown.edu.ng', 'Active', 4, 23, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(15, 'Victoria', 'Bassey', '08101234567', 'victoria.bassey@royalcrown.edu.ng', 'Active', 4, 25, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 11:00:00', '2025-09-01 11:00:00'),

-- School 5: Betheal Kiddies
(16, 'Funmilayo', 'Oladele', '08112345678', 'funmilayo.oladele@betheal.edu.ng', 'Active', 5, 28, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 12:00:00', '2025-09-01 12:00:00'),
(17, 'Kingsley', 'Samuel', '08123456789', 'kingsley.samuel@betheal.edu.ng', 'Active', 5, 29, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 12:00:00', '2025-09-01 12:00:00'),
(18, 'Esther', 'Nwosu', '08134567890', 'esther.nwosu@betheal.edu.ng', 'Active', 5, 30, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-01 12:00:00', '2025-09-01 12:00:00');

-- =========================================================
-- 4. SUBJECTS
-- =========================================================

-- School 1: Graceland - JSS 1A
INSERT INTO `subjects` (`id`, `name`, `schoolID`, `teacherID`, `classID`, `createdAt`) VALUES
(1, 'English Language', 1, 1, 1, '2025-09-01 08:00:00'),
(2, 'Mathematics', 1, 2, 1, '2025-09-01 08:00:00'),
(3, 'Basic Science', 1, 3, 1, '2025-09-01 08:00:00'),
(4, 'Social Studies', 1, 1, 1, '2025-09-01 08:00:00'),
(5, 'Yoruba Language', 1, 4, 1, '2025-09-01 08:00:00'),
(6, 'Agricultural Science', 1, 5, 1, '2025-09-01 08:00:00'),
(7, 'Computer Studies', 1, 2, 1, '2025-09-01 08:00:00'),
(8, 'Christian Religious Studies', 1, 3, 1, '2025-09-01 08:00:00'),
(9, 'Home Economics', 1, 1, 1, '2025-09-01 08:00:00'),
(10, 'Physical Education', 1, 4, 1, '2025-09-01 08:00:00'),

-- School 1: Graceland - JSS 2A
(11, 'English Language', 1, 2, 3, '2025-09-01 08:00:00'),
(12, 'Mathematics', 1, 2, 3, '2025-09-01 08:00:00'),
(13, 'Basic Science', 1, 3, 3, '2025-09-01 08:00:00'),
(14, 'Social Studies', 1, 1, 3, '2025-09-01 08:00:00'),
(15, 'Business Studies', 1, 4, 3, '2025-09-01 08:00:00'),

-- School 1: Graceland - SS 1A
(16, 'English Language', 1, 3, 6, '2025-09-01 08:00:00'),
(17, 'Mathematics', 1, 2, 6, '2025-09-01 08:00:00'),
(18, 'Physics', 1, 3, 6, '2025-09-01 08:00:00'),
(19, 'Chemistry', 1, 4, 6, '2025-09-01 08:00:00'),
(20, 'Biology', 1, 5, 6, '2025-09-01 08:00:00'),
(21, 'Geography', 1, 1, 6, '2025-09-01 08:00:00'),
(22, 'Economics', 1, 2, 6, '2025-09-01 08:00:00'),

-- School 2: Heritage - JSS 1
(23, 'English Language', 2, 6, 9, '2025-09-01 09:00:00'),
(24, 'Mathematics', 2, 7, 9, '2025-09-01 09:00:00'),
(25, 'Basic Science', 2, 8, 9, '2025-09-01 09:00:00'),
(26, 'Igbo Language', 2, 6, 9, '2025-09-01 09:00:00'),
(27, 'Civic Education', 2, 9, 9, '2025-09-01 09:00:00'),
(28, 'Basic Technology', 2, 7, 9, '2025-09-01 09:00:00'),

-- School 2: Heritage - SS 2
(29, 'English Language', 2, 8, 13, '2025-09-01 09:00:00'),
(30, 'Mathematics', 2, 7, 13, '2025-09-01 09:00:00'),
(31, 'Physics', 2, 9, 13, '2025-09-01 09:00:00'),
(32, 'Chemistry', 2, 6, 13, '2025-09-01 09:00:00'),
(33, 'Biology', 2, 8, 13, '2025-09-01 09:00:00'),

-- School 3: Divine Wisdom - JSS 1 Gold
(34, 'English Language', 3, 10, 15, '2025-09-01 10:00:00'),
(35, 'Mathematics', 3, 11, 15, '2025-09-01 10:00:00'),
(36, 'Basic Science', 3, 12, 15, '2025-09-01 10:00:00'),
(37, 'Social Studies', 3, 10, 15, '2025-09-01 10:00:00'),
(38, 'French Language', 3, 11, 15, '2025-09-01 10:00:00'),

-- School 3: Divine Wisdom - SS 1 Science
(39, 'English Language', 3, 12, 18, '2025-09-01 10:00:00'),
(40, 'Mathematics', 3, 11, 18, '2025-09-01 10:00:00'),
(41, 'Physics', 3, 12, 18, '2025-09-01 10:00:00'),
(42, 'Chemistry', 3, 10, 18, '2025-09-01 10:00:00'),
(43, 'Further Mathematics', 3, 11, 18, '2025-09-01 10:00:00'),

-- School 4: Royal Crown - Junior 1
(44, 'English Language', 4, 13, 22, '2025-09-01 11:00:00'),
(45, 'Mathematics', 4, 14, 22, '2025-09-01 11:00:00'),
(46, 'Basic Science', 4, 15, 22, '2025-09-01 11:00:00'),
(47, 'History', 4, 13, 22, '2025-09-01 11:00:00'),

-- School 5: Betheal - Basic 1
(48, 'English Language', 5, 16, 28, '2025-09-01 12:00:00'),
(49, 'Mathematics', 5, 17, 28, '2025-09-01 12:00:00'),
(50, 'Basic Science', 5, 18, 28, '2025-09-01 12:00:00');

-- =========================================================
-- 5. STUDENTS
-- =========================================================

-- School 1: Graceland - JSS 1A (20 students)
INSERT INTO `students` (`id`, `firstname`, `lastname`, `classID`, `status`, `parentphone`, `schoolID`, `password`, `createdAt`, `updatedAt`) VALUES
(1, 'Ada', 'Okoro', 1, 'Active', '08012345671', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(2, 'Bola', 'Adewale', 1, 'Active', '08012345672', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(3, 'Chinwe', 'Nwosu', 1, 'Active', '08012345673', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(4, 'David', 'Oladipo', 1, 'Active', '08012345674', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(5, 'Ebuka', 'Ike', 1, 'Active', '08012345675', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(6, 'Faith', 'Emmanuel', 1, 'Active', '08012345676', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(7, 'Grace', 'Okonkwo', 1, 'Active', '08012345677', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(8, 'Hassan', 'Musa', 1, 'Active', '08012345678', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(9, 'Ifeoma', 'Eze', 1, 'Active', '08012345679', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(10, 'John', 'Okafor', 1, 'Active', '08012345680', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(11, 'Kemi', 'Adebayo', 1, 'Active', '08012345681', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(12, 'Lekan', 'Bello', 1, 'Active', '08012345682', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(13, 'Mary', 'Ogbu', 1, 'Active', '08012345683', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(14, 'Nkechi', 'Uche', 1, 'Active', '08012345684', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(15, 'Ola', 'Johnson', 1, 'Active', '08012345685', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(16, 'Paul', 'Igwe', 1, 'Active', '08012345686', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(17, 'Queen', 'Nnamdi', 1, 'Active', '08012345687', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(18, 'Rita', 'Chukwu', 1, 'Active', '08012345688', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(19, 'Samuel', 'Ojo', 1, 'Active', '08012345689', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),
(20, 'Tunde', 'Ajayi', 1, 'Active', '08012345690', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 08:00:00', '2025-09-05 08:00:00'),

-- School 1: Graceland - JSS 2A (15 students)
(21, 'Uche', 'Obi', 3, 'Active', '08012345691', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(22, 'Victor', 'Okafor', 3, 'Active', '08012345692', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(23, 'Wale', 'Adeyemi', 3, 'Active', '08012345693', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(24, 'Xavier', 'Nwankwo', 3, 'Active', '08012345694', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(25, 'Yemi', 'Ojo', 3, 'Active', '08012345695', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(26, 'Zainab', 'Garba', 3, 'Active', '08012345696', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(27, 'Abdul', 'Ibrahim', 3, 'Active', '08012345697', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(28, 'Beatrice', 'Okeke', 3, 'Active', '08012345698', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(29, 'Chidi', 'Eze', 3, 'Active', '08012345699', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(30, 'Daniel', 'Udoh', 3, 'Active', '08012345700', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(31, 'Esther', 'Bassey', 3, 'Active', '08012345701', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(32, 'Felix', 'Agu', 3, 'Active', '08012345702', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(33, 'Glory', 'Okoro', 3, 'Active', '08012345703', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(34, 'Henry', 'Chukwu', 3, 'Active', '08012345704', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),
(35, 'Irene', 'Nweke', 3, 'Active', '08012345705', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 09:00:00', '2025-09-05 09:00:00'),

-- School 1: Graceland - SS 1A (18 students)
(36, 'Joseph', 'Okafor', 6, 'Active', '08012345706', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(37, 'Kelechi', 'Nnamdi', 6, 'Active', '08012345707', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(38, 'Lucy', 'Igwe', 6, 'Active', '08012345708', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(39, 'Moses', 'Eze', 6, 'Active', '08012345709', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(40, 'Nancy', 'Okeke', 6, 'Active', '08012345710', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(41, 'Obinna', 'Chukwu', 6, 'Active', '08012345711', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(42, 'Peace', 'Udoh', 6, 'Active', '08012345712', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(43, 'Queensley', 'Ibe', 6, 'Active', '08012345713', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(44, 'Richard', 'Obi', 6, 'Active', '08012345714', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(45, 'Sarah', 'Nweke', 6, 'Active', '08012345715', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(46, 'Timothy', 'Okoro', 6, 'Active', '08012345716', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(47, 'Udoka', 'Eze', 6, 'Active', '08012345717', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(48, 'Victoria', 'Igwe', 6, 'Active', '08012345718', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(49, 'William', 'Nnamdi', 6, 'Active', '08012345719', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(50, 'Xavier', 'Chukwu', 6, 'Active', '08012345720', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(51, 'Yetunde', 'Okeke', 6, 'Active', '08012345721', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(52, 'Zara', 'Obi', 6, 'Active', '08012345722', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),
(53, 'Ahmed', 'Yusuf', 6, 'Active', '08012345723', 1, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 10:00:00', '2025-09-05 10:00:00'),

-- School 2: Heritage - JSS 1 (15 students)
(54, 'Amarachi', 'Okafor', 9, 'Active', '08023456781', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(55, 'Benjamin', 'Eze', 9, 'Active', '08023456782', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(56, 'Chidinma', 'Nwankwo', 9, 'Active', '08023456783', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(57, 'Divine', 'Okeke', 9, 'Active', '08023456784', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(58, 'Emmanuel', 'Igwe', 9, 'Active', '08023456785', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(59, 'Favour', 'Nnamdi', 9, 'Active', '08023456786', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(60, 'Godwin', 'Chukwu', 9, 'Active', '08023456787', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(61, 'Hope', 'Obi', 9, 'Active', '08023456788', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(62, 'Israel', 'Udoh', 9, 'Active', '08023456789', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(63, 'Joy', 'Bassey', 9, 'Active', '08023456790', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(64, 'Kingsley', 'Eze', 9, 'Active', '08023456791', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(65, 'Loveth', 'Okoro', 9, 'Active', '08023456792', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(66, 'Michael', 'Nweke', 9, 'Active', '08023456793', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(67, 'Ngozi', 'Igwe', 9, 'Active', '08023456794', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),
(68, 'Oluwa', 'Chukwu', 9, 'Active', '08023456795', 2, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 11:00:00', '2025-09-05 11:00:00'),

-- School 3: Divine Wisdom - JSS 1 Gold (12 students)
(69, 'Peter', 'Okeke', 15, 'Active', '08034567891', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(70, 'Quincy', 'Obi', 15, 'Active', '08034567892', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(71, 'Ruth', 'Eze', 15, 'Active', '08034567893', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(72, 'Stephen', 'Nnamdi', 15, 'Active', '08034567894', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(73, 'Theresa', 'Chukwu', 15, 'Active', '08034567895', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(74, 'Uchenna', 'Igwe', 15, 'Active', '08034567896', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(75, 'Veronica', 'Okoro', 15, 'Active', '08034567897', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(76, 'Wisdom', 'Okafor', 15, 'Active', '08034567898', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(77, 'Xavier', 'Udoh', 15, 'Active', '08034567899', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(78, 'Yinka', 'Bassey', 15, 'Active', '08034567900', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(79, 'Zion', 'Nweke', 15, 'Active', '08034567901', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),
(80, 'Angela', 'Eze', 15, 'Active', '08034567902', 3, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 12:00:00', '2025-09-05 12:00:00'),

-- School 4: Royal Crown - Junior 1 (10 students)
(81, 'Bright', 'Okeke', 22, 'Active', '08045678911', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(82, 'Chisom', 'Obi', 22, 'Active', '08045678912', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(83, 'Daniel', 'Igwe', 22, 'Active', '08045678913', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(84, 'Ebere', 'Nnamdi', 22, 'Active', '08045678914', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(85, 'Fortune', 'Chukwu', 22, 'Active', '08045678915', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(86, 'Gloria', 'Okoro', 22, 'Active', '08045678916', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(87, 'Helen', 'Eze', 22, 'Active', '08045678917', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(88, 'Isaac', 'Okafor', 22, 'Active', '08045678918', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(89, 'Janet', 'Udoh', 22, 'Active', '08045678919', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),
(90, 'Kevin', 'Bassey', 22, 'Active', '08045678920', 4, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 13:00:00', '2025-09-05 13:00:00'),

-- School 5: Betheal - Basic 1 (10 students)
(91, 'Linda', 'Okeke', 28, 'Active', '08056789021', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(92, 'Matthew', 'Obi', 28, 'Active', '08056789022', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(93, 'Nelly', 'Igwe', 28, 'Active', '08056789023', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(94, 'Oscar', 'Nnamdi', 28, 'Active', '08056789024', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(95, 'Patricia', 'Chukwu', 28, 'Active', '08056789025', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(96, 'Quincy', 'Okoro', 28, 'Active', '08056789026', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(97, 'Rachel', 'Eze', 28, 'Active', '08056789027', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(98, 'Solomon', 'Okafor', 28, 'Active', '08056789028', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(99, 'Tina', 'Udoh', 28, 'Active', '08056789029', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00'),
(100, 'Uzo', 'Bassey', 28, 'Active', '08056789030', 5, '$2b$10$nixqpGLyh5wllNVZVO4a0.vV0v92OLbG8wCniSkxCbBmfW215exry', '2025-09-05 14:00:00', '2025-09-05 14:00:00');

-- =========================================================
-- 6. GRADES (Student Assessment Records)
-- =========================================================

-- Grades for School 1 - JSS 1A - English (First Term 2025/2026)
INSERT INTO `grades` (`id`, `studentID`, `subjectID`, `session`, `test1`, `test2`, `exam`, `schoolID`, `classID`, `term`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, '2025/2026', 15.00, 14.50, 68.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(2, 2, 1, '2025/2026', 18.00, 17.00, 72.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(3, 3, 1, '2025/2026', 12.00, 13.50, 55.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(4, 4, 1, '2025/2026', 19.00, 18.50, 78.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(5, 5, 1, '2025/2026', 16.00, 15.00, 64.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(6, 6, 1, '2025/2026', 17.50, 16.50, 70.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(7, 7, 1, '2025/2026', 14.00, 15.50, 62.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(8, 8, 1, '2025/2026', 13.00, 12.50, 58.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(9, 9, 1, '2025/2026', 18.50, 19.00, 75.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(10, 10, 1, '2025/2026', 16.50, 17.00, 66.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),

-- Grades for School 1 - JSS 1A - Mathematics (First Term 2025/2026)
(11, 1, 2, '2025/2026', 16.00, 15.50, 70.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(12, 2, 2, '2025/2026', 19.00, 18.00, 76.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(13, 3, 2, '2025/2026', 11.00, 12.50, 52.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(14, 4, 2, '2025/2026', 20.00, 19.50, 82.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(15, 5, 2, '2025/2026', 15.00, 14.00, 62.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(16, 6, 2, '2025/2026', 17.00, 16.00, 68.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(17, 7, 2, '2025/2026', 13.00, 14.50, 60.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(18, 8, 2, '2025/2026', 12.00, 11.50, 54.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(19, 9, 2, '2025/2026', 19.50, 18.50, 78.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),
(20, 10, 2, '2025/2026', 15.50, 16.00, 64.00, 1, 1, 'First Term', '2025-12-01 10:00:00', '2025-12-01 10:00:00'),

-- Grades for School 2 - JSS 1 - English (First Term 2025/2026)
(21, 54, 23, '2025/2026', 17.00, 16.50, 72.00, 2, 9, 'First Term', '2025-12-01 11:00:00', '2025-12-01 11:00:00'),
(22, 55, 23, '2025/2026', 18.50, 17.50, 74.00, 2, 9, 'First Term', '2025-12-01 11:00:00', '2025-12-01 11:00:00'),
(23, 56, 23, '2025/2026', 14.00, 15.00, 60.00, 2, 9, 'First Term', '2025-12-01 11:00:00', '2025-12-01 11:00:00'),
(24, 57, 23, '2025/2026', 19.00, 18.00, 76.00, 2, 9, 'First Term', '2025-12-01 11:00:00', '2025-12-01 11:00:00'),
(25, 58, 23, '2025/2026', 16.50, 15.50, 66.00, 2, 9, 'First Term', '2025-12-01 11:00:00', '2025-12-01 11:00:00'),

-- Grades for School 3 - JSS 1 Gold - English (First Term 2025/2026)
(26, 69, 34, '2025/2026', 18.00, 17.00, 75.00, 3, 15, 'First Term', '2025-12-01 12:00:00', '2025-12-01 12:00:00'),
(27, 70, 34, '2025/2026', 16.00, 15.50, 68.00, 3, 15, 'First Term', '2025-12-01 12:00:00', '2025-12-01 12:00:00'),
(28, 71, 34, '2025/2026', 19.50, 18.50, 78.00, 3, 15, 'First Term', '2025-12-01 12:00:00', '2025-12-01 12:00:00'),
(29, 72, 34, '2025/2026', 15.00, 16.00, 64.00, 3, 15, 'First Term', '2025-12-01 12:00:00', '2025-12-01 12:00:00'),
(30, 73, 34, '2025/2026', 17.50, 16.50, 70.00, 3, 15, 'First Term', '2025-12-01 12:00:00', '2025-12-01 12:00:00');

-- =========================================================
-- 7. PAYMENTS (School Fees and Other Charges)
-- =========================================================

INSERT INTO `payments` (`id`, `title`, `classID`, `amount`, `session`, `term`, `status`, `studentID`, `referenceNo`, `description`, `dueDate`, `schoolID`, `createdAt`, `updatedAt`) VALUES
-- School 1 - JSS 1A - First Term Fees
(1, 'First Term School Fees', 1, 85000.00, '2025/2026', 'First Term', 'Paid', 1, 'PAY20250901001', 'Tuition, books, and other fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-20 10:00:00'),
(2, 'First Term School Fees', 1, 85000.00, '2025/2026', 'First Term', 'Paid', 2, 'PAY20250901002', 'Tuition, books, and other fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-18 09:00:00'),
(3, 'First Term School Fees', 1, 85000.00, '2025/2026', 'First Term', 'Unpaid', 3, NULL, 'Tuition, books, and other fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-15 08:00:00'),
(4, 'First Term School Fees', 1, 85000.00, '2025/2026', 'First Term', 'Paid', 4, 'PAY20250901004', 'Tuition, books, and other fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-22 11:00:00'),
(5, 'First Term School Fees', 1, 85000.00, '2025/2026', 'First Term', 'Pending', 5, NULL, 'Tuition, books, and other fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-15 08:00:00'),
(6, 'PTA Levy', 1, 5000.00, '2025/2026', 'First Term', 'Paid', 1, 'PAY20250901101', 'Parent-Teacher Association dues', '2025-10-15', 1, '2025-09-15 08:00:00', '2025-10-10 14:00:00'),
(7, 'Sports Fee', 1, 3000.00, '2025/2026', 'First Term', 'Paid', 2, 'PAY20250901102', 'Annual sports and games fee', '2025-10-15', 1, '2025-09-15 08:00:00', '2025-10-12 09:00:00'),
(8, 'Excursion Fee', 1, 7500.00, '2025/2026', 'First Term', 'Unpaid', 3, NULL, 'Educational tour to National Museum', '2025-11-01', 1, '2025-10-01 08:00:00', '2025-10-01 08:00:00'),

-- School 1 - SS 1A - First Term Fees
(9, 'First Term School Fees', 6, 95000.00, '2025/2026', 'First Term', 'Paid', 36, 'PAY20250901201', 'Senior class tuition and fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-19 10:00:00'),
(10, 'First Term School Fees', 6, 95000.00, '2025/2026', 'First Term', 'Paid', 37, 'PAY20250901202', 'Senior class tuition and fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-21 11:00:00'),
(11, 'First Term School Fees', 6, 95000.00, '2025/2026', 'First Term', 'Overdue', 38, NULL, 'Senior class tuition and fees', '2025-10-01', 1, '2025-09-15 08:00:00', '2025-09-15 08:00:00'),
(12, 'Laboratory Fee', 6, 12000.00, '2025/2026', 'First Term', 'Paid', 36, 'PAY20250901301', 'Science lab materials and equipment', '2025-10-15', 1, '2025-09-15 08:00:00', '2025-10-14 13:00:00'),

-- School 2 - JSS 1 - First Term Fees
(13, 'First Term Tuition', 9, 78000.00, '2025/2026', 'First Term', 'Paid', 54, 'PAY20250902001', 'Full term tuition', '2025-10-01', 2, '2025-09-15 09:00:00', '2025-09-20 10:00:00'),
(14, 'First Term Tuition', 9, 78000.00, '2025/2026', 'First Term', 'Paid', 55, 'PAY20250902002', 'Full term tuition', '2025-10-01', 2, '2025-09-15 09:00:00', '2025-09-18 09:00:00'),
(15, 'First Term Tuition', 9, 78000.00, '2025/2026', 'First Term', 'Unpaid', 56, NULL, 'Full term tuition', '2025-10-01', 2, '2025-09-15 09:00:00', '2025-09-15 09:00:00'),
(16, 'Computer Lab Fee', 9, 5000.00, '2025/2026', 'First Term', 'Paid', 54, 'PAY20250902101', 'ICT facility usage', '2025-10-15', 2, '2025-09-15 09:00:00', '2025-10-13 11:00:00'),

-- School 3 - JSS 1 Gold - First Term Fees
(17, 'Tuition Fee', 15, 120000.00, '2025/2026', 'First Term', 'Paid', 69, 'PAY20250903001', 'Premium class tuition', '2025-10-01', 3, '2025-09-15 10:00:00', '2025-09-19 14:00:00'),
(18, 'Tuition Fee', 15, 120000.00, '2025/2026', 'First Term', 'Paid', 70, 'PAY20250903002', 'Premium class tuition', '2025-10-01', 3, '2025-09-15 10:00:00', '2025-09-20 10:00:00'),
(19, 'Tuition Fee', 15, 120000.00, '2025/2026', 'First Term', 'Pending', 71, NULL, 'Premium class tuition', '2025-10-01', 3, '2025-09-15 10:00:00', '2025-09-15 10:00:00'),
(20, 'Development Levy', 15, 15000.00, '2025/2026', 'First Term', 'Paid', 69, 'PAY20250903101', 'School infrastructure development', '2025-10-15', 3, '2025-09-15 10:00:00', '2025-10-16 09:00:00'),

-- School 4 - Junior 1 - First Term Fees
(21, 'School Fees', 22, 65000.00, '2025/2026', 'First Term', 'Paid', 81, 'PAY20250904001', 'Complete term fees', '2025-10-01', 4, '2025-09-15 11:00:00', '2025-09-22 10:00:00'),
(22, 'School Fees', 22, 65000.00, '2025/2026', 'First Term', 'Unpaid', 82, NULL, 'Complete term fees', '2025-10-01', 4, '2025-09-15 11:00:00', '2025-09-15 11:00:00'),
(23, 'Uniform Fee', 22, 8000.00, '2025/2026', 'First Term', 'Paid', 81, 'PAY20250904101', 'School uniform set', '2025-10-15', 4, '2025-09-15 11:00:00', '2025-10-10 12:00:00'),

-- School 5 - Basic 1 - First Term Fees
(24, 'Tuition and Feeding', 28, 55000.00, '2025/2026', 'First Term', 'Paid', 91, 'PAY20250905001', 'Tuition plus lunch program', '2025-10-01', 5, '2025-09-15 12:00:00', '2025-09-20 11:00:00'),
(25, 'Tuition and Feeding', 28, 55000.00, '2025/2026', 'First Term', 'Paid', 92, 'PAY20250905002', 'Tuition plus lunch program', '2025-10-01', 5, '2025-09-15 12:00:00', '2025-09-19 10:00:00'),
(26, 'Tuition and Feeding', 28, 55000.00, '2025/2026', 'First Term', 'Pending', 93, NULL, 'Tuition plus lunch program', '2025-10-01', 5, '2025-09-15 12:00:00', '2025-09-15 12:00:00'),
(27, 'Learning Materials', 28, 12000.00, '2025/2026', 'First Term', 'Paid', 91, 'PAY20250905101', 'Books, crayons, and supplies', '2025-10-15', 5, '2025-09-15 12:00:00', '2025-10-12 14:00:00');

-- =========================================================
-- 8. EVENTS
-- =========================================================

INSERT INTO `events` (`id`, `title`, `description`, `date`, `assignedTo`, `schoolID`, `createdAt`) VALUES
-- School 1 Events
(1, 'Mid-Term Break', 'Two weeks mid-term holiday for all students', '2025-10-20', 'All Classes', 1, '2025-09-01 08:00:00'),
(2, 'Inter-House Sports Competition', 'Annual sports day featuring various athletic events', '2025-11-15', 'All Classes', 1, '2025-09-01 08:00:00'),
(3, 'Parent-Teacher Meeting', 'First term academic progress discussion', '2025-11-25', 'All Classes', 1, '2025-09-01 08:00:00'),
(4, 'Christmas Carol Service', 'End of term thanksgiving and carol service', '2025-12-15', 'All Classes', 1, '2025-09-01 08:00:00'),
(5, 'JSS 1 Orientation Day', 'Welcome program for new JSS 1 students', '2025-09-10', 'JSS 1A', 1, '2025-09-01 08:00:00'),
(6, 'Science Fair Exhibition', 'Students showcase science projects', '2025-11-08', 'SS 1A', 1, '2025-10-01 08:00:00'),

-- School 2 Events
(7, 'Cultural Day Celebration', 'Celebrating Nigerian diverse cultures', '2025-10-01', 'All Classes', 2, '2025-09-01 09:00:00'),
(8, 'Mathematics Quiz Competition', 'Inter-class math quiz', '2025-10-28', 'JSS 1', 2, '2025-09-15 09:00:00'),
(9, 'Founders Day Celebration', 'Annual commemoration of school founding', '2025-11-20', 'All Classes', 2, '2025-09-01 09:00:00'),
(10, 'End of Term Examination', 'First term final exams begin', '2025-12-01', 'All Classes', 2, '2025-09-01 09:00:00'),

-- School 3 Events
(11, 'Debate Competition Finals', 'Annual inter-school debate championship', '2025-10-18', 'SS 1 Science', 3, '2025-09-01 10:00:00'),
(12, 'Career Fair Day', 'Various professionals speak to students', '2025-11-05', 'SS 1 Science', 3, '2025-09-15 10:00:00'),
(13, 'Leadership Training Workshop', 'For prefects and class monitors', '2025-10-12', 'All Classes', 3, '2025-09-01 10:00:00'),
(14, 'Environmental Sanitation Exercise', 'School cleanup and beautification', '2025-11-02', 'All Classes', 3, '2025-10-01 10:00:00'),

-- School 4 Events
(15, 'Spelling Bee Competition', 'Junior school spelling contest', '2025-10-25', 'Junior 1', 4, '2025-09-15 11:00:00'),
(16, 'Harvest Thanksgiving Service', 'Annual harvest celebration', '2025-11-30', 'All Classes', 4, '2025-09-01 11:00:00'),
(17, 'Art Exhibition', 'Students display art and craft works', '2025-12-10', 'All Classes', 4, '2025-10-01 11:00:00'),

-- School 5 Events
(18, 'Childrens Day Celebration', 'Special program for young learners', '2025-05-27', 'All Classes', 5, '2025-09-01 12:00:00'),
(19, 'Storytelling Session', 'Professional storyteller visits', '2025-10-30', 'Basic 1', 5, '2025-10-01 12:00:00'),
(20, 'Christmas Party', 'Fun-filled end of year party', '2025-12-18', 'All Classes', 5, '2025-10-15 12:00:00');

-- =========================================================
-- 9. BOOKS (Library/Required Textbooks)
-- =========================================================


-- =========================================================
-- 9. BOOKS (CONTINUED)
-- =========================================================

INSERT INTO `books` (`id`, `title`, `author`, `price`, `classID`, `schoolID`, `createdAt`, `updatedAt`) VALUES
(1, 'New Concept English for JSS 1', 'Learn Africa Publishing', 2500.00, 1, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(2, 'Essential Mathematics JSS 1', 'A.J.S Oluwasanmi', 2800.00, 1, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(3, 'Basic Science and Technology JSS 1', 'J.O Otugalu', 2200.00, 1, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(4, 'Comprehensive Social Studies JSS 1', 'G.N Nkwocha', 2000.00, 1, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(5, 'Computer Studies Made Easy JSS 1', 'S.K Yusuf', 1800.00, 1, 1, '2025-09-01 08:00:00', '
2025-09-01 08:00:00'),
(6, 'Yoruba Language and Culture JSS 1', 'A. Bamgbose', 1500.00, 1, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(7, 'Agricultural Science for Junior Secondary', 'F.O Adeyemi', 2100.00, 1, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(8, 'Christian Religious Studies JSS 1', 'Rev. P.N Nwachukwu', 1700.00, 1, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),

-- School 1 - SS 1A Books
(9, 'Effective English Language SS 1-3', 'Evans Brothers Nigeria', 3500.00, 6, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(10, 'Further Mathematics SS 1', 'M.F Macrae et al', 3800.00, 6, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(11, 'New School Physics SS 1-3', 'M.W Anyakoha', 4200.00, 6, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(12, 'New School Chemistry SS 1-3', 'Osei Yaw Ababio', 4500.00, 6, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(13, 'College Biology', 'E. Idodo Umeh', 4000.00, 6, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),
(14, 'Comprehensive Economics SS 1-3', 'J.U Anyaele', 3600.00, 6, 1, '2025-09-01 08:00:00', '2025-09-01 08:00:00'),

-- School 2 - JSS 1 Books
(15, 'English Language Practice JSS 1', 'Longman Nigeria', 2600.00, 9, 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(16, 'Mathematics Today JSS 1', 'T.A Ademosu', 2700.00, 9, 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(17, 'Basic Science Textbook JSS 1', 'University Press PLC', 2300.00, 9, 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(18, 'Igbo Language Studies JSS 1', 'F.C Ogbalu', 1600.00, 9, 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),
(19, 'Civic Education JSS 1-3', 'Sola Akintan', 1900.00, 9, 2, '2025-09-01 09:00:00', '2025-09-01 09:00:00'),

-- School 3 - JSS 1 Gold Books
(20, 'Oxford English for JSS 1', 'Oxford University Press', 3200.00, 15, 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(21, 'Mastering Mathematics JSS 1', 'R.N Agarana', 3000.00, 15, 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(22, 'Integrated Science JSS 1', 'O.Y Oyedeji', 2800.00, 15, 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),
(23, 'French Language Course JSS 1', 'Alliance Française', 2500.00, 15, 3, '2025-09-01 10:00:00', '2025-09-01 10:00:00'),

-- School 4 - Junior 1 Books
(24, 'English Grammar Junior 1', 'Learn Africa', 2200.00, 22, 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(25, 'Basic Mathematics Junior 1', 'M.O Ogunlade', 2400.00, 22, 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),
(26, 'Science Explorers Junior 1', 'Macmillan Nigeria', 2000.00, 22, 4, '2025-09-01 11:00:00', '2025-09-01 11:00:00'),

-- School 5 - Basic 1 Books
(27, 'My First English Reader', 'Lantern Books', 1200.00, 28, 5, '2025-09-01 12:00:00', '2025-09-01 12:00:00'),
(28, 'Early Mathematics for Kids', 'Educational Books Ltd', 1100.00, 28, 5, '2025-09-01 12:00:00', '2025-09-01 12:00:00'),
(29, 'Fun with Science Basic 1', 'A. Adeleke', 950.00, 28, 5, '2025-09-01 12:00:00', '2025-09-01 12:00:00'),
(30, 'Picture Dictionary for Children', 'Sterling Publishers', 1500.00, 28, 5, '2025-09-01 12:00:00', '2025-09-01 12:00:00');

-- =========================================================
-- 10. BOOKINGS (Parent/Visitor Appointments)
-- =========================================================

INSERT INTO `bookings` (`id`, `name`, `email`, `date`, `reason`, `status`, `schoolID`, `createdAt`) VALUES
-- School 1 Bookings
(1, 'Mrs. Chioma Okoro', 'chioma.okoro@email.com', '2025-11-05', 'Discuss my daughters academic performance in Mathematics', 'Approved', 1, '2025-10-28 14:30:00'),
(2, 'Mr. Tunde Adewale', 'tunde.adewale@email.com', '2025-11-08', 'Enquiry about extracurricular activities and sports program', 'Approved', 1, '2025-11-01 10:15:00'),
(3, 'Mrs. Grace Oladipo', NULL, '2025-11-10', 'Request for meeting regarding school fees payment plan', 'Pending', 1, '2025-11-03 16:20:00'),
(4, 'Dr. Emeka Nwosu', 'emeka.nwosu@email.com', '2025-11-12', 'Discuss admission process for my younger child', 'Approved', 1, '2025-11-04 09:00:00'),
(5, 'Mr. Hassan Musa', 'hassan.musa@email.com', '2025-11-15', 'Concern about transportation service schedule', 'Declined', 1, '2025-11-06 11:45:00'),

-- School 2 Bookings
(6, 'Mrs. Blessing Okafor', 'blessing.okafor@email.com', '2025-11-06', 'Follow-up on child behavioral issues report', 'Approved', 2, '2025-10-30 13:00:00'),
(7, 'Mr. Adamu Garba', NULL, '2025-11-09', 'Discuss transfer certificate for my son', 'Pending', 2, '2025-11-02 15:30:00'),
(8, 'Mrs. Chidinma Igwe', 'chidinma.igwe@email.com', '2025-11-11', 'Career guidance counseling appointment', 'Approved', 2, '2025-11-05 10:00:00'),

-- School 3 Bookings
(9, 'Mr. Peter Okeke', 'peter.okeke@email.com', '2025-11-07', 'Meeting about scholarship opportunities', 'Approved', 3, '2025-11-01 08:30:00'),
(10, 'Mrs. Ruth Nnamdi', 'ruth.nnamdi@email.com', '2025-11-13', 'Discuss preparation for external examinations', 'Pending', 3, '2025-11-07 12:00:00'),

-- School 4 Bookings
(11, 'Dr. Gloria Chukwu', 'gloria.chukwu@email.com', '2025-11-14', 'Medical exemption for physical education class', 'Approved', 4, '2025-11-08 14:00:00'),
(12, 'Mr. Isaac Udoh', NULL, '2025-11-16', 'Complaint about school bus service', 'Pending', 4, '2025-11-09 09:30:00'),

-- School 5 Bookings
(13, 'Mrs. Linda Bassey', 'linda.bassey@email.com', '2025-11-17', 'Request for additional learning support for my child', 'Approved', 5, '2025-11-10 11:00:00'),
(14, 'Mr. Matthew Eze', 'matthew.eze@email.com', '2025-11-18', 'Enquiry about holiday programs and summer school', 'Pending', 5, '2025-11-11 13:15:00');

-- =========================================================
-- 11. TIMETABLE (Class Schedules)
-- =========================================================

INSERT INTO `timetable` (`id`, `classID`, `subjectID`, `day`, `time`, `schoolID`, `createdAt`) VALUES
-- School 1 - JSS 1A Monday
(1, 1, 1, 'Monday', '08:00 - 09:00', 1, '2025-09-01 08:00:00'),
(2, 1, 2, 'Monday', '09:00 - 10:00', 1, '2025-09-01 08:00:00'),
(3, 1, 3, 'Monday', '10:30 - 11:30', 1, '2025-09-01 08:00:00'),
(4, 1, 4, 'Monday', '11:30 - 12:30', 1, '2025-09-01 08:00:00'),

-- School 1 - JSS 1A Tuesday
(5, 1, 5, 'Tuesday', '08:00 - 09:00', 1, '2025-09-01 08:00:00'),
(6, 1, 6, 'Tuesday', '09:00 - 10:00', 1, '2025-09-01 08:00:00'),
(7, 1, 7, 'Tuesday', '10:30 - 11:30', 1, '2025-09-01 08:00:00'),
(8, 1, 8, 'Tuesday', '11:30 - 12:30', 1, '2025-09-01 08:00:00'),

-- School 1 - JSS 1A Wednesday
(9, 1, 1, 'Wednesday', '08:00 - 09:00', 1, '2025-09-01 08:00:00'),
(10, 1, 2, 'Wednesday', '09:00 - 10:00', 1, '2025-09-01 08:00:00'),
(11, 1, 9, 'Wednesday', '10:30 - 11:30', 1, '2025-09-01 08:00:00'),
(12, 1, 10, 'Wednesday', '11:30 - 12:30', 1, '2025-09-01 08:00:00'),

-- School 1 - JSS 1A Thursday
(13, 1, 3, 'Thursday', '08:00 - 09:00', 1, '2025-09-01 08:00:00'),
(14, 1, 4, 'Thursday', '09:00 - 10:00', 1, '2025-09-01 08:00:00'),
(15, 1, 1, 'Thursday', '10:30 - 11:30', 1, '2025-09-01 08:00:00'),
(16, 1, 2, 'Thursday', '11:30 - 12:30', 1, '2025-09-01 08:00:00'),

-- School 1 - JSS 1A Friday
(17, 1, 5, 'Friday', '08:00 - 09:00', 1, '2025-09-01 08:00:00'),
(18, 1, 6, 'Friday', '09:00 - 10:00', 1, '2025-09-01 08:00:00'),
(19, 1, 7, 'Friday', '10:30 - 11:30', 1, '2025-09-01 08:00:00'),
(20, 1, 10, 'Friday', '11:30 - 12:30', 1, '2025-09-01 08:00:00'),

-- School 1 - SS 1A Monday
(21, 6, 16, 'Monday', '08:00 - 09:00', 1, '2025-09-01 08:00:00'),
(22, 6, 17, 'Monday', '09:00 - 10:00', 1, '2025-09-01 08:00:00'),
(23, 6, 18, 'Monday', '10:30 - 11:30', 1, '2025-09-01 08:00:00'),
(24, 6, 19, 'Monday', '11:30 - 12:30', 1, '2025-09-01 08:00:00'),

-- School 1 - SS 1A Tuesday
(25, 6, 20, 'Tuesday', '08:00 - 09:00', 1, '2025-09-01 08:00:00'),
(26, 6, 21, 'Tuesday', '09:00 - 10:00', 1, '2025-09-01 08:00:00'),
(27, 6, 22, 'Tuesday', '10:30 - 11:30', 1, '2025-09-01 08:00:00'),
(28, 6, 16, 'Tuesday', '11:30 - 12:30', 1, '2025-09-01 08:00:00'),

-- School 2 - JSS 1 Monday
(29, 9, 23, 'Monday', '08:00 - 09:00', 2, '2025-09-01 09:00:00'),
(30, 9, 24, 'Monday', '09:00 - 10:00', 2, '2025-09-01 09:00:00'),
(31, 9, 25, 'Monday', '10:30 - 11:30', 2, '2025-09-01 09:00:00'),
(32, 9, 26, 'Monday', '11:30 - 12:30', 2, '2025-09-01 09:00:00'),

-- School 2 - JSS 1 Tuesday
(33, 9, 27, 'Tuesday', '08:00 - 09:00', 2, '2025-09-01 09:00:00'),
(34, 9, 28, 'Tuesday', '09:00 - 10:00', 2, '2025-09-01 09:00:00'),
(35, 9, 23, 'Tuesday', '10:30 - 11:30', 2, '2025-09-01 09:00:00'),
(36, 9, 24, 'Tuesday', '11:30 - 12:30', 2, '2025-09-01 09:00:00'),

-- School 3 - JSS 1 Gold Monday
(37, 15, 34, 'Monday', '08:00 - 09:00', 3, '2025-09-01 10:00:00'),
(38, 15, 35, 'Monday', '09:00 - 10:00', 3, '2025-09-01 10:00:00'),
(39, 15, 36, 'Monday', '10:30 - 11:30', 3, '2025-09-01 10:00:00'),
(40, 15, 37, 'Monday', '11:30 - 12:30', 3, '2025-09-01 10:00:00'),

-- School 3 - JSS 1 Gold Tuesday
(41, 15, 38, 'Tuesday', '08:00 - 09:00', 3, '2025-09-01 10:00:00'),
(42, 15, 34, 'Tuesday', '09:00 - 10:00', 3, '2025-09-01 10:00:00'),
(43, 15, 35, 'Tuesday', '10:30 - 11:30', 3, '2025-09-01 10:00:00'),
(44, 15, 36, 'Tuesday', '11:30 - 12:30', 3, '2025-09-01 10:00:00'),

-- School 4 - Junior 1 Monday
(45, 22, 44, 'Monday', '08:00 - 09:00', 4, '2025-09-01 11:00:00'),
(46, 22, 45, 'Monday', '09:00 - 10:00', 4, '2025-09-01 11:00:00'),
(47, 22, 46, 'Monday', '10:30 - 11:30', 4, '2025-09-01 11:00:00'),
(48, 22, 47, 'Monday', '11:30 - 12:30', 4, '2025-09-01 11:00:00'),

-- School 5 - Basic 1 Monday
(49, 28, 48, 'Monday', '08:00 - 09:00', 5, '2025-09-01 12:00:00'),
(50, 28, 49, 'Monday', '09:00 - 10:00', 5, '2025-09-01 12:00:00'),
(51, 28, 50, 'Monday', '10:30 - 11:30', 5, '2025-09-01 12:00:00'),
(52, 28, 48, 'Monday', '11:30 - 12:30', 5, '2025-09-01 12:00:00');

-- =========================================================
-- 12. ADDITIONAL NOTIFICATIONS
-- =========================================================

INSERT INTO `notify` (`id`, `schoolID`, `sendTo`, `title`, `content`, `type`, `createdAt`) VALUES
-- School 1 Notifications
(20, 1, 'general', 'Welcome Back - First Term 2025/2026', 'Welcome to the new academic session. Classes resume Monday, September 1st, 2025. Students should report by 7:30am.', 'notification', '2025-08-28 09:00:00'),
(21, 1, 'parent', 'School Fees Payment Deadline', 'Dear parents, the deadline for First Term school fees payment is October 1st, 2025. Late payment attracts a 5% penalty.', 'sms', '2025-09-10 10:00:00'),
(22, 1, 'teacher', 'Staff Meeting Alert', 'All teaching staff are required to attend the staff meeting on Friday, September 15th at 2:00pm. Agenda: Curriculum review and assessment strategies.', 'notification', '2025-09-12 14:00:00'),
(23, 1, 'general', 'Mid-Term Break Notice', 'School will be closed for mid-term break from October 20th to November 3rd, 2025. Classes resume November 4th.', 'notification', '2025-10-15 11:00:00'),
(24, 1, 'parent', 'Parent-Teacher Meeting Invitation', 'You are invited to our First Term PTA meeting on November 25th at 10:00am. Your attendance is important.', 'sms', '2025-11-18 09:00:00'),

-- School 2 Notifications
(25, 2, 'general', 'Cultural Day Preparation', 'Students are reminded to prepare for our Cultural Day celebration on October 1st. Traditional attire is required.', 'notification', '2025-09-25 08:00:00'),
(26, 2, 'teacher', 'Professional Development Workshop', 'Teachers are invited to a workshop on Modern Teaching Methods this Saturday at 9:00am. Certificate of attendance will be issued.', 'notification', '2025-10-10 15:00:00'),
(27, 2, 'parent', 'Examination Timetable Released', 'The First Term examination timetable has been released. Please check the school portal or visit the school office.', 'sms', '2025-11-20 10:00:00'),
(28, 2, 'general', 'Inter-School Competition', 'Congratulations! Our debate team won first place in the Abia State Inter-School Debate Competition.', 'notification', '2025-11-12 16:30:00'),

-- School 3 Notifications
(29, 3, 'general', 'Science Fair Announcement', 'The annual Science Fair will hold on November 8th. All science students are encouraged to participate.', 'notification', '2025-10-20 09:00:00'),
(30, 3, 'teacher', 'Curriculum Review Meeting', 'HODs are to submit their curriculum review reports by October 30th for the academic board meeting.', 'notification', '2025-10-15 11:00:00'),
(31, 3, 'parent', 'School Infrastructure Update', 'We are pleased to announce the completion of our new science laboratory. Thank you for your support through the development levy.', 'sms', '2025-11-05 14:00:00'),

-- School 4 Notifications
(32, 4, 'general', 'Spelling Bee Competition', 'The Junior School Spelling Bee Competition holds on October 25th. Interested students should register at the school office.', 'notification', '2025-10-12 10:00:00'),
(33, 4, 'parent', 'Uniform Compliance Notice', 'Parents are reminded that students must wear complete school uniform daily. No colored socks or sneakers allowed.', 'sms', '2025-09-18 08:00:00'),
(34, 4, 'teacher', 'Report Card Preparation', 'All teachers should submit their assessment records by November 28th for report card preparation.', 'notification', '2025-11-15 13:00:00'),

-- School 5 Notifications
(35, 5, 'general', 'Storytelling Session', 'A special storytelling session for all students will hold on October 30th. Parents are welcome to attend.', 'notification', '2025-10-25 09:00:00'),
(36, 5, 'parent', 'Lunch Menu Update', 'We have updated our school lunch menu to include more nutritious meals. Check the new menu on our website.', 'sms', '2025-10-01 10:00:00'),
(37, 5, 'teacher', 'Early Learning Workshop', 'Teachers are invited to a workshop on Early Childhood Education Methods on November 10th.', 'notification', '2025-11-03 14:00:00');

-- =========================================================
-- 13. AUTO INCREMENT RESET (For Proper ID Sequencing)
-- =========================================================

ALTER TABLE `admins` AUTO_INCREMENT = 6;
ALTER TABLE `classes` AUTO_INCREMENT = 31;
ALTER TABLE `teachers` AUTO_INCREMENT = 19;
ALTER TABLE `subjects` AUTO_INCREMENT = 51;
ALTER TABLE `students` AUTO_INCREMENT = 101;
ALTER TABLE `grades` AUTO_INCREMENT = 31;
ALTER TABLE `payments` AUTO_INCREMENT = 28;
ALTER TABLE `events` AUTO_INCREMENT = 21;
ALTER TABLE `books` AUTO_INCREMENT = 31;
ALTER TABLE `bookings` AUTO_INCREMENT = 15;
ALTER TABLE `timetable` AUTO_INCREMENT = 53;
ALTER TABLE `notify` AUTO_INCREMENT = 38;

-- =========================================================
-- SEED DATA SUMMARY
-- =========================================================
-- 
-- Total Records Created:
-- - 5 Schools (Admins)
-- - 30 Classes
-- - 18 Teachers
-- - 50 Subjects
-- - 100 Students
-- - 30 Grade Records
-- - 27 Payment Records
-- - 20 Events
-- - 30 Books
-- - 14 Bookings
-- - 52 Timetable Entries
-- - 37 Notifications
--
-- Total: 400+ records across all tables
--
-- =========================================================

COMMIT;

-- =========================================================
-- END OF SEED DATA
-- =========================================================