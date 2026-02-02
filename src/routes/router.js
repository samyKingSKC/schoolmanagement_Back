import express from "express";
import {
  registerAdmin,
  loginUser,

  // classes
  fetchClasses,
  storeClass,
  deleteClass,
  addStudentToClass,

  // teachers
  fetchTeachers,
  registerTeacher,
  assignTeacherToClass,
  deleteTeacher,

  // students
  fetchStudents,
  registerStudent,

  // timetable
  fetchTimetable,
  storeTimetable,
  updateTimetable,

  // books
  fetchBooks,
  addBookToClass,
  deleteBook,

  // payments
  fetchPayments,
  addPayment,
  updatePayment,
  deletePayment,
  processPayment,
  searchPayment,
  getEventsBySchool,
  createEvent,
  deleteEvent,
  getBookingsBySchool,
  deleteBooking,
  createBooking,
  getGrades,
  getStudentGrades,
  getClassGrades,
  createGrade,
  updateGrade,
  bulkUpdateGrades,
  deleteGrade,
  getClassStatistics,
  fetchSubjects,
  createSubject,
  deleteSubject,
  getnotification,
  notification,
  deletenotification,
  getSMSBalance,
  topupSMSBalance,
  updateemail,
  updatepassword,
  deleteStudent,
  generateLessonNoteAsync,
  updateBookingStatus,
} from "../controllers/controller.js";

const router = express.Router();

/* ===== AUTH ===== */
router.post("/register", registerAdmin);
router.post("/login", loginUser);

/* ===== CLASSES ===== */
router.get("/classes/:schoolID", fetchClasses);
router.post("/classes/store", storeClass);
router.delete("/classes/:id", deleteClass);
router.post("/classes/addstudenttoclass", addStudentToClass);

/* ===== TEACHERS ===== */
router.get("/teachers/:schoolID", fetchTeachers);
router.post("/teachers", registerTeacher);
router.patch("/teachers/assign-teacher", assignTeacherToClass);
router.delete("/teachers/:id", deleteTeacher);

/* ===== STUDENTS ===== */
router.get("/students/:schoolID", fetchStudents);
router.post("/students", registerStudent);
router.delete("/students/:id", deleteStudent);

/* ===== TIMETABLE ===== */
router.get("/timetable/:schoolID", fetchTimetable);
router.post("/timetable/store", storeTimetable);
router.post("/timetable/update", updateTimetable);

/* ===== BOOKS ===== */
router.get("/books/:schoolID", fetchBooks);
router.post("/classes/:classID/books", addBookToClass);
router.delete("/books/:bookID/:schoolID", deleteBook);

/* ===== PAYMENTS ===== */
router.get("/payments/:schoolID", fetchPayments);
router.post("/payments", addPayment);
router.put("/payments/:id", updatePayment);
router.delete("/payments/:id", deletePayment);
router.post("/payments/process", processPayment);
router.get("/payments/search", searchPayment);




/**
 * GET EVENTS BY SCHOOL
 */
router.get("/event/:schoolID", getEventsBySchool);

/**
 * CREATE EVENT
 */
router.post("/storeevent", createEvent);

/**
 * DELETE EVENT
 */
router.delete("/event/:id", deleteEvent);



router.get("/bookings/:schoolID", getBookingsBySchool);
router.delete("/booking/:id", deleteBooking);

// 🌍 Public (you will use later)
router.post("/booking", createBooking);
// ✅ NEW ROUTE ADDED
router.put("/booking/update-status", updateBookingStatus);



// Get all grades for a school
router.get('/grades/:schoolID', getGrades);

// Get grades for a specific student
router.get("/grades/student/:studentID", getStudentGrades);

// Get grades for a specific class
router.get("/grades/class/:classID", getClassGrades);

// Get class statistics
router.get('/grades/stats/:classID', getClassStatistics);

// Create a new grade
router.post('/grades', createGrade);

// Bulk update grades
router.post('/grades/bulk', bulkUpdateGrades);

// Update a grade
router.put('/grades/:id', updateGrade);

// Delete a grade
router.delete('/grades/:id', deleteGrade);

router.get("/subjects/:schoolID",fetchSubjects);

router.post("/createsubject", createSubject);
router.delete("/subjects/:subjectID/:schoolID", deleteSubject);
router.post("/notify",notification);
router.get("/notify/:schoolID",getnotification);
router.delete("/notify/delete/:id/:schoolID", deletenotification);
router.get("/sms/balance/:schoolID", getSMSBalance);
router.post("/sms/topup", topupSMSBalance);
router.post("/email", updateemail);
router.post("/password", updatepassword);
router.post("/generate-note", generateLessonNoteAsync);
export default router;
