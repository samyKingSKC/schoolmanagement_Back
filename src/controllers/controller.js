import DB from "../config/db.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
const db = DB();
const GROQ_API_KEY =
  process.env.GROQ_API_KEY;
const GROQ_API_URL = "https://api.groq.com/openai/v1/chat/completions";



// Use the fast, FREE Llama model
const MODEL = "llama-3.3-70b-versatile";

// ---------- Helpers ----------
const requireFields = (fields = {}, res) => {
  const missing = Object.entries(fields)
    .filter(([, v]) => v === undefined || v === null || v === "")
    .map(([k]) => k);

  if (missing.length) {
    res
      .status(400)
      .json({ error: "All fields are required", missingFields: missing });
    return false;
  }
  return true;
};

// ---------- Admin Registration ----------
export const registerAdmin = async (req, res) => {
  try {
    const {
      schoolName,
      directorFirstname,
      directorLastname,
      email,
      phone,
      password,
    } = req.body;

    if (
      !requireFields(
        {
          schoolName,
          directorFirstname,
          directorLastname,
          email,
          phone,
          password,
        },
        res,
      )
    )
      return;

    const hashedPassword = await bcrypt.hash(password, 10);

    await db.query(
      `INSERT INTO admins (school, firstname, lastname, email, phone, password)
       VALUES (?, ?, ?, ?, ?, ?)
    `,
      [
        schoolName,
        directorFirstname,
        directorLastname,
        email,
        phone,
        hashedPassword,
      ],
    );

    return res.status(201).json({ message: "Admin registered successfully" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

// ---------- Login ----------
export const loginUser = async (req, res) => {
  try {
    const { email, password, role } = req.body;

    if (!requireFields({ email, password, role }, res)) return;
    let user;
    let userData;
    console.log(role);
    if (role === "Admin") {
      const [rows] = await db.query(
        `SELECT id, firstname, lastname, school, password, status,email
       FROM admins WHERE email = ?`,
        [email],
      );
      if (!rows.length) {
        return res
          .status(200)
          .json({ error: "Login failed. Please check your credentials." });
      }
      user = rows?.[0];
      userData = {
        id: user.id,
        firstname: user.firstname,
        lastname: user.lastname,
        schoolID: user.id,
        status: user.status,
        email: user.email,
      };
    }
    if (role === "Teacher") {
      const [rows] = await db.query(
        `SELECT id, firstname, lastname,password,status,email ,schoolID,classID
       FROM teachers WHERE email = ?`,
        [email],
      );
      if (!rows.length) {
        return res
          .status(200)
          .json({ error: "Login failed. Please check your credentials." });
      }
      user = rows?.[0];

      userData = {
        id: user.id,
        firstname: user.firstname,
        lastname: user.lastname,
        schoolID: user.schoolID,
        classID: user.classID,
        status: user.status,
        email: user.email,
      };
    }
    if (role === "Parent") {
      const [rows] = await db.query(
        `SELECT id, firstname, lastname,password,status,parentphone,schoolID,classID
       FROM students WHERE parentphone = ?`,
        [email],
      );
      if (!rows.length) {
        return res
          .status(200)
          .json({ error: "Login failed. Please check your credentials." });
      }
      user = rows?.[0];

      const [children] = await db.query(
        "SELECT * FROM students WHERE parentphone = ?",
        [email],
      );

      userData = {
        id: user.id,
        firstname: user.firstname,
        lastname: user.lastname,
        schoolID: user.schoolID,
        classID: user.classID,
        status: user.status,
        email: user.email,
        children,
      };
    }

    console.log(password, user.password);
    if (!(await bcrypt.compare(password, user.password))) {
      return res.status(400).json({ error: "Invalid email or password" });
    }

    const access_token = jwt.sign(
      { id: user.id, role },
      process.env.JWT_SECRET || "authlogin",
      { expiresIn: "1d" },
    );

    return res.status(200).json({
      message: "Login successful",
      data: { access_token, role, user: userData },
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

// ---------- Fetch Students ----------
export const fetchStudents = async (req, res) => {
  try {
    const { schoolID } = req.params;

    if (!schoolID) {
      return res.status(400).json({ error: "schoolID is required" });
    }

    const [result] = await db.query(
      "SELECT * FROM students WHERE schoolID = ?",
      [schoolID],
    );

    if (!result.length) {
      return res.status(200).json({ message: "No students found", data: [] });
    }

    return res.status(200).json({
      message: "Students fetched successfully",
      data: result,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

// ---------- Register Student ----------
export const registerStudent = async (req, res) => {
  try {
    const { firstname, lastname, classID, status, schoolID, parentphone } =
      req.body;

    console.log(parentphone);
    if (
      !requireFields(
        { firstname, lastname, classID, status, schoolID, parentphone },
        res,
      )
    )
      return;
    const password = await bcrypt.hash("1234567", 10);

    await db.query(
      `INSERT INTO students (firstname, lastname, classID, status, schoolID, parentphone,password)
       VALUES (?, ?, ?, ?, ?, ?,?)`,
      [firstname, lastname, classID, status, schoolID, parentphone, password],
    );

    const [result] = await db.query(
      `SELECT id, firstname, lastname, classID, schoolID, parentphone, status
       FROM students WHERE parentphone = ? ORDER BY id DESC LIMIT 1`,
      [parentphone],
    );

    return res.status(201).json({
      message: "Student registered successfully",
      data: result[0],
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

// ---------- Fetch Teachers ----------
export const fetchTeachers = async (req, res) => {
  try {
    const { schoolID } = req.params;

    if (!schoolID)
      return res.status(400).json({ error: "schoolID is required" });

    const [result] = await db.query(
      "SELECT id, firstname, lastname, phone, email, status, schoolID, createdAT, updatedAT FROM teachers WHERE schoolID = ?",
      [schoolID],
    );

    if (!result.length)
      return res.status(200).json({ message: "No teachers found", data: [] });

    res
      .status(200)
      .json({ message: "Teachers fetched successfully", data: result });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};

// ---------- Register Teacher ----------
export const registerTeacher = async (req, res) => {
  try {
    const { firstname, lastname, classID, phone, email, status, schoolID } =
      req.body;

    if (!requireFields({ firstname, lastname, email, status, schoolID }, res))
      return;

    // Check if a teacher is already assigned to this class
    const [existing] = await db.query(
      "SELECT id FROM teachers WHERE classID = ? AND schoolID = ?",
      [classID, schoolID],
    );

    if (existing.length) {
      return res
        .status(400)
        .json({ message: "A teacher is already assigned to this class." });
    }
    const password = await bcrypt.hash("1234567", 10);

    // Insert new teacher
    const [insertResult] = await db.query(
      `INSERT INTO teachers 
        (firstname,lastname, classID, phone, email, status, schoolID, createdAT, updatedAT,password)
       VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW(),?)`,
      [
        firstname,
        lastname,
        classID,
        phone || null,
        email,
        status,
        schoolID,
        password,
      ],
    );

    // Fetch the inserted teacher
    const [teacher] = await db.query(
      "SELECT id, firstname, lastname, classID, phone, email, status, schoolID, createdAT, updatedAT FROM teachers WHERE id = ?",
      [insertResult.insertId],
    );

    res.status(201).json({
      message: "Teacher registered successfully",
      teacher: teacher[0],
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error", err });
  }
};

// ---------- Delete Teacher ----------
export const deleteTeacher = async (req, res) => {
  try {
    const { id } = req.params;

    if (!id) return res.status(400).json({ error: "Teacher id is required" });

    const [result] = await db.query("DELETE FROM teachers WHERE id = ?", [id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Teacher not found" });
    }

    res.status(200).json({ message: "Teacher deleted successfully" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};

// ---------- Store Class ----------
export const storeClass = async (req, res) => {
  try {
    const { name, teacher_id, schoolID } = req.body;

    if (!requireFields({ name, schoolID }, res)) return;

    const [result] = await db.query(
      `INSERT INTO classes (name, schoolID, createdAT, updatedAT)
       VALUES (?, ?, NOW(), NOW())`,
      [name, schoolID],
    );

    const classID = result.insertId;

    // Assign teacher if provided
    if (teacher_id) {
      await db.query(
        `UPDATE teachers
         SET classID = ?
         WHERE id = ? AND schoolID = ?`,
        [classID, teacher_id, schoolID],
      );
    }

    const [classes] = await db.query(
      `SELECT id, name, schoolID, createdAT, updatedAT
       FROM classes
       WHERE schoolID = ?
       ORDER BY id DESC`,
      [schoolID],
    );

    return res.status(201).json({
      message: "Class created successfully",
      classes,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

// ---------- Fetch Classes ----------
export const fetchClasses = async (req, res) => {
  try {
    const { schoolID } = req.params;

    if (!schoolID) {
      return res.status(400).json({ error: "schoolID is required" });
    }

    const [classes] = await db.query(
      `SELECT id, name, schoolID, createdAT, updatedAT
       FROM classes
       WHERE schoolID = ?
       ORDER BY id DESC`,
      [schoolID],
    );

    return res.status(200).json({
      message: "Classes fetched successfully",
      classes,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};
// ---------- Delete Class ----------
export const deleteClass = async (req, res) => {
  try {
    const { id } = req.params;

    if (!id) return res.status(400).json({ error: "Class ID is required" });

    // Unassign teachers first (avoid FK issues)
    await db.query(`UPDATE teachers SET classID = NULL WHERE classID = ?`, [
      id,
    ]);

    // Unassign students
    await db.query(`UPDATE students SET classID = NULL WHERE classID = ?`, [
      id,
    ]);

    const [result] = await db.query(`DELETE FROM classes WHERE id = ?`, [id]);

    if (!result.affectedRows) {
      return res.status(404).json({ message: "Class not found" });
    }

    return res.status(200).json({ message: "Class deleted successfully" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};
// ---------- Add Student To Class ----------
export const addStudentToClass = async (req, res) => {
  try {
    const { studentID, classID, schoolID } = req.body;

    if (!studentID || !classID || !schoolID) {
      return res.status(400).json({
        error: "studentID, classID and schoolID are required",
      });
    }

    // Ensure student belongs to the school
    const [student] = await db.query(
      `SELECT id FROM students WHERE id = ? AND schoolID = ?`,
      [studentID, schoolID],
    );

    if (!student.length) {
      return res.status(404).json({ error: "Student not found" });
    }

    // Assign class
    await db.query(`UPDATE students SET classID = ? WHERE id = ?`, [
      classID,
      studentID,
    ]);

    const [students] = await db.query(
      "SELECT * FROM students WHERE schoolID = ?",
      [schoolID],
    );
    return res.status(200).json({
      message: "Student assigned to class successfully",
      data: students,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};
// ---------- Assign Teacher To Class ----------
export const assignTeacherToClass = async (req, res) => {
  try {
    const { teacherID, classID, schoolID, subjectID } = req.body;

    if (!teacherID || !classID || !schoolID || !subjectID) {
      return res.status(400).json({
        error: "teacherID, classID, and schoolID are required",
      });
    }

    // Ensure teacher belongs to this school
    const [teacher] = await db.query(
      `SELECT id FROM teachers WHERE id = ? AND schoolID = ?`,
      [teacherID, schoolID],
    );

    if (!teacher.length) {
      return res.status(404).json({ error: "Teacher not found" });
    }

    // Ensure class belongs to this school
    const [cls] = await db.query(
      `SELECT id FROM classes WHERE id = ? AND schoolID = ?`,
      [classID, schoolID],
    );

    if (!cls.length) {
      return res.status(404).json({ error: "Class not found" });
    }

    // Assign teacher
    await db.query(`UPDATE subjects SET teacherID = ? WHERE id = ?`, [
      teacherID,
      subjectID,
    ]);

    const [teachers] = await db.query(
      "SELECT * FROM teachers WHERE schoolID = ?",
      [schoolID],
    );

    return res.status(200).json({
      message: "Teacher assigned to class successfully",
      data: teachers,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

// ---------- Fetch Books ----------
export const fetchBooks = async (req, res) => {
  try {
    const { schoolID } = req.params;

    const [books] = await db.query(
      `SELECT * FROM books WHERE schoolID = ? ORDER BY id DESC`,
      [schoolID],
    );

    res.status(200).json({ message: "Books fetched", data: books });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};
// ---------- Add Book To Class ----------
export const addBookToClass = async (req, res) => {
  try {
    const { classID } = req.params;
    const { title, schoolID, price, author } = req.body;

    if (!requireFields({ title, schoolID }, res)) return;

    await db.query(
      `INSERT INTO books (title, classID, schoolID, createdAT,price,author)
       VALUES (?, ?, ?, NOW(),?,?)`,
      [title, classID, schoolID, price, author],
    );

    

    const [books] = await db.query(
      `SELECT * FROM books WHERE schoolID = ? ORDER BY id DESC`,
      [schoolID],
    );

    res.status(201).json({ message: "Book added successfully", data: books });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};
// ---------- Delete Book ----------
export const deleteBook = async (req, res) => {
  try {
    const { bookID, schoolID } = req.params;

    const [result] = await db.query(
      `DELETE FROM books WHERE id = ? AND schoolID = ?`,
      [bookID, schoolID],
    );

    if (!result.affectedRows) {
      return res.status(404).json({ message: "Book not found" });
    }
    const [books] = await db.query(
      `SELECT * FROM books WHERE schoolID = ? ORDER BY id DESC`,
      [schoolID],
    );
    res.status(200).json({ message: "Book deleted successfully", data: books });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};
// ---------- Fetch Timetable ----------
export const fetchTimetable = async (req, res) => {
  try {
    const { schoolID } = req.params;

    const [rows] = await db.query(
      `SELECT * FROM timetable WHERE schoolID = ?`,
      [schoolID],
    );

    res.status(200).json({ data: rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};
// ---------- Store Timetable ----------
export const storeTimetable = async (req, res) => {
  try {
    const { classID, subjectID, time, schoolID, day } = req.body;

    if (!requireFields({ classID, subjectID, time, schoolID }, res)) return;

    await db.query(
      `INSERT INTO timetable (classID, subjectID, time, schoolID ,day)
       VALUES (?, ?, ?, ?,?)`,
      [classID, subjectID, time, schoolID, day],
    );

    const [timetable] = await db.query(
      "SELECT * FROM timetable where schoolID = ?",
      [schoolID],
    );

    res.status(201).json({ message: "Timetable saved", timetable });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};

export const updateTimetable = async (req, res) => {
  try {
    const { classID, subject, time, schoolID, day } = req.body;
    const oldday = day;
    const oldtime = time;

    if (!requireFields({ classID, subject, time, schoolID }, res)) return;

    await db.query(
      `UPDATE timetable SET subject = ?, time = ?, day = ? WHERE classID = ? AND schoolID = ? AND day = ? AND time = ?`,
      [subject, time, day, classID, schoolID, oldday, oldtime],
    );

    const [timetable] = await db.query(
      "SELECT * FROM timetable where schoolID = ?",
      [schoolID],
    );

    res.status(201).json({ message: "Timetable updated", timetable });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};

// ---------- Fetch Payments ----------
export const fetchPayments = async (req, res) => {
  try {
    const { schoolID } = req.params;

    if (!schoolID) {
      return res.status(400).json({ error: "schoolID is required" });
    }

    const [payments] = await db.query(
      `SELECT * FROM payments WHERE schoolID = ? ORDER BY createdAt DESC`,
      [schoolID],
    );

    res.status(200).json({
      success: true,
      data: payments,
    });
  } catch (err) {
    console.error("Error fetching payments:", err);
    res.status(500).json({
      success: false,
      error: "Server error",
    });
  }
};

// ---------- Add Payment ----------
export const addPayment = async (req, res) => {
  try {
    const { title, classID, amount, session, schoolID, referenceNo, term } =
      req.body;

    if (
      !requireFields(
        { title, classID, amount, session, schoolID, referenceNo, term },
        res,
      )
    )
      return;

    // Insert new payment
    await db.query(
      `INSERT INTO payments (title, classID, amount, session, schoolID, status, createdAt,referenceNo,term) 
       VALUES (?, ?, ?, ?, ?, 'Unpaid', NOW(),?,?)`,
      [title, classID, amount, session, schoolID, referenceNo, term],
    );

    // Fetch all payments after insertion
    const [payments] = await db.query(
      `SELECT * FROM payments WHERE schoolID = ? ORDER BY createdAt DESC`,
      [schoolID],
    );

    res.status(201).json({
      success: true,
      message: "Payment added successfully",
      data: payments,
    });
  } catch (err) {
    console.error("Error adding payment:", err);
    res.status(500).json({
      success: false,
      error: "Server error",
    });
  }
};

// Search Payment by Reference or Student ID
export const searchPayment = async (req, res) => {
  try {
    const { searchType, value } = req.query;

    // Validation
    if (!searchType || !value) {
      return res.status(400).json({
        error: "searchType and value are required",
        success: false,
      });
    }

    if (searchType === "ref") {
      // Search by reference number - returns single payment
      const [payment] = await db.query(
        'SELECT * FROM payments WHERE referenceNo = ? AND status = "Paid"',
        [value],
      );

      if (!payment.length) {
        return res.status(404).json({
          error: "Payment not found",
          success: false,
        });
      }

      return res.status(200).json({
        success: true,
        data: payment[0],
      });
    } else if (searchType === "id") {
      // Search by student ID - returns array of payments
      const [payments] = await db.query(
        'SELECT * FROM payments WHERE studentID = ? AND status = "Paid" ORDER BY createdAt DESC',
        [value],
      );

      if (!payments.length) {
        return res.status(404).json({
          error: "No payments found for this student",
          success: false,
          data: [],
        });
      }

      return res.status(200).json({
        success: true,
        data: payments,
      });
    } else {
      return res.status(400).json({
        error: 'Invalid searchType. Must be "ref" or "id"',
        success: false,
      });
    }
  } catch (err) {
    console.error("Search Payment Error:", err);
    res.status(500).json({
      error: "Server error",
      success: false,
    });
  }
};

// Process Payment (Receive Payment)
export const processPayment = async (req, res) => {
  try {
    const {
      studentID,
      paymentID,
      amount,
      referenceNo,
      schoolID,
      session,
      classID,
      bookid
    } = req.body;

    // Validation
    if (
      !requireFields(
        { studentID, paymentID, amount, referenceNo, schoolID, session },
        res,
      )
    ) {
      return;
    }

    // Get original payment details
    const [originalPayment] = await db.query(
      "SELECT * FROM payments WHERE id = ?",
      [paymentID],
    );

    if (!originalPayment.length && bookid) {
        await db.query(
          `INSERT INTO payments (title, classID, amount, session, schoolID, status, studentID, referenceNo, createdAt,bookid)
       VALUES (?, ?, ?, ?, ?, 'Paid', ?, ?, NOW(),?)`,
          [
            originalPayment[0].title,
            classID,
            amount,
            session,
            schoolID,
            studentID,
            referenceNo,
            bookid,
          ],
        );
    }

    // Check if student already paid this payment
    const [existingPayment] = await db.query(
      'SELECT id FROM payments WHERE studentID = ? AND title = ? AND classID = ? AND session = ? AND status = "Paid"',
      [studentID, originalPayment[0].title, classID, session],
    );

    if (existingPayment.length) {
      return res.status(400).json({
        error: "Student has already paid for this payment",
        success: false,
      });
    }

    
        await db.query(
          `INSERT INTO payments (title, classID, amount, session, schoolID, status, studentID, referenceNo, createdAt)
       VALUES (?, ?, ?, ?, ?, 'Paid', ?, ?, NOW())`,
          [
            originalPayment[0].title,
            classID,
            amount,
            session,
            schoolID,
            studentID,
            referenceNo,
          ],
        );

     
  

    // Fetch updated payments
    const [payments] = await db.query(
      "SELECT * FROM payments WHERE schoolID = ? ORDER BY createdAt DESC",
      [schoolID],
    );

    res.status(201).json({
      success: true,
      message: "Payment processed successfully",
      data: payments,
      referenceNo: referenceNo,
    });
  } catch (err) {
    console.error("Process Payment Error:", err);
    res.status(500).json({
      error: "Server error",
      success: false,
    });
  }
};

// ---------- Update Payment ----------
export const updatePayment = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, classID, amount } = req.body;

    if (!requireFields({ title, classID, amount }, res)) return;

    // Check if payment exists and get schoolID
    const [existing] = await db.query(
      `SELECT schoolID FROM payments WHERE id = ?`,
      [id],
    );

    if (existing.length === 0) {
      return res.status(404).json({
        success: false,
        error: "Payment not found",
      });
    }

    // Update payment
    await db.query(
      `UPDATE payments SET title = ?, classID = ?, amount = ?, updatedAt = NOW() WHERE id = ?`,
      [title, classID, amount, id],
    );

    // Fetch all payments after update
    const [payments] = await db.query(
      `SELECT * FROM payments WHERE schoolID = ? ORDER BY createdAt DESC`,
      [existing[0].schoolID],
    );

    res.status(200).json({
      success: true,
      message: "Payment updated successfully",
      data: payments,
    });
  } catch (err) {
    console.error("Error updating payment:", err);
    res.status(500).json({
      success: false,
      error: "Server error",
    });
  }
};

// ---------- Delete Payment ----------
export const deletePayment = async (req, res) => {
  try {
    const { id } = req.params;

    // Check if payment exists and get schoolID
    const [existing] = await db.query(
      `SELECT schoolID FROM payments WHERE id = ?`,
      [id],
    );

    if (existing.length === 0) {
      return res.status(404).json({
        success: false,
        error: "Payment not found",
      });
    }

    // Delete payment
    await db.query(`DELETE FROM payments WHERE id = ?`, [id]);

    // Fetch all payments after deletion
    const [payments] = await db.query(
      `SELECT * FROM payments WHERE schoolID = ? ORDER BY createdAt DESC`,
      [existing[0].schoolID],
    );

    res.status(200).json({
      success: true,
      message: "Payment deleted successfully",
      data: payments,
    });
  } catch (err) {
    console.error("Error deleting payment:", err);
    res.status(500).json({
      success: false,
      error: "Server error",
    });
  }
};

export const getEventsBySchool = async (req, res) => {
  try {
    const { schoolID } = req.params;

    const [rows] = await db.query(
      `SELECT 
        id,
        title,
        description,
        DATE_FORMAT(date, '%Y-%m-%d') AS date,
        assignedTo
       FROM events
       WHERE schoolID = ?
       ORDER BY date DESC`,
      [schoolID],
    );

    return res.json({ success: true, data: rows });
  } catch (err) {
    console.error("Fetch events error:", err);
    return res.status(500).json({ success: false, message: "Server error" });
  }
};

/**
 * CREATE EVENT
 */
export const createEvent = async (req, res) => {
  try {
    const { title, date, description, assignedTo, school_id } = req.body;

    if (!title || !date || !school_id) {
      return res
        .status(400)
        .json({ success: false, message: "Missing required fields" });
    }

    await db.query(
      `INSERT INTO events (title, description, date, assignedTo, schoolID)
       VALUES (?, ?, ?, ?, ?)`,
      [title, description || "", date, assignedTo || "All Classes", school_id],
    );

    // Return updated list
    const [rows] = await db.query(
      `SELECT 
        id,
        title,
        description,
        DATE_FORMAT(date, '%Y-%m-%d') AS date,
        assignedTo
       FROM events
       WHERE schoolID = ?
       ORDER BY date ASC`,
      [school_id],
    );

    return res.json({ success: true, data: rows });
  } catch (err) {
    console.error("Create event error:", err);
    return res.status(500).json({ success: false, message: "Server error" });
  }
};

/**
 * DELETE EVENT
 */
export const deleteEvent = async (req, res) => {
  try {
    const { id } = req.params;

    await db.query(`DELETE FROM events WHERE id = ?`, [id]);

    return res.json({ success: true });
  } catch (err) {
    console.error("Delete event error:", err);
    return res.status(500).json({ success: false, message: "Server error" });
  }
};

/**
 * GET all bookings for a school (ADMIN)
 */
export const getBookingsBySchool = async (req, res) => {
  try {
    const { schoolID } = req.params;

    console.log("📥 Fetching bookings for school ID:", schoolID);

    const query = `
      SELECT 
        id,
        name,
        email,
        date,
        reason,
        status,
        createdAt
      FROM bookings
      WHERE schoolID = ?
      ORDER BY createdAt DESC
    `;

   const [rows, fields] = await db.query(query, [schoolID]);
   return res.json({ success: true, data: rows, count: rows.length });
        
      

      console.log(`✅ Found ${results.length} booking(s)`);

      res.json({
        success: true,
        data: rows,
        count: rows.length,
      });
  } catch (error) {
    console.error("❌ Server error:", error);
    res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message,
    });
  }
};

/* ===============================
   UPDATE BOOKING STATUS (ADMIN)
   PUT /booking/update-status
=============================== */
export const updateBookingStatus = async (req, res) => {
  try {
    const { bookingId, status } = req.body;

    console.log("📤 Update booking status request:", {
      bookingId,
      status,
      timestamp: new Date().toISOString(),
    });

    // Validation
    if (!bookingId) {
      console.log("❌ Missing booking ID");
      return res.status(400).json({
        success: false,
        message: "Booking ID is required",
      });
    }

    if (!status) {
      console.log("❌ Missing status");
      return res.status(400).json({
        success: false,
        message: "Status is required",
      });
    }

    // Validate status value
    const validStatuses = ["Pending", "Approved", "Declined"];
    if (!validStatuses.includes(status)) {
      console.log("❌ Invalid status value:", status);
      return res.status(400).json({
        success: false,
        message: `Invalid status. Must be one of: ${validStatuses.join(", ")}`,
      });
    }

    // Check if booking exists
    const checkQuery = "SELECT * FROM bookings WHERE id = ?";

    const [checkResults] = await db.query(checkQuery, [bookingId]);
    if (checkResults.length === 0) { 
      console.log("❌ Booking not found:", bookingId);
      return res.status(404).json({
        success: false,
        message: "Booking not found",
      });
    }

    const oldBooking = checkResults[0];
    console.log("📋 Current booking status:", {
      id: oldBooking.id,
      name: oldBooking.name,
      oldStatus: oldBooking.status,
      newStatus: status,
    });

    // Update the status
    const updateQuery = `
      UPDATE bookings 
      SET status = ? 
      WHERE id = ?
    `;

    await db.query(updateQuery, [status, bookingId]);

    console.log("✅ Booking status updated successfully:", {
      bookingId,
      newStatus: status,
    });

    res.json({
      success: true,
      message: "Booking status updated successfully",
      updatedBooking: { ...oldBooking, status },
    });
  } catch (error) {
    console.error("❌ Server error:", error);
    res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message,
    });
  }
};

/* ===============================
   DELETE BOOKING (ADMIN)
   DELETE /booking/:id
=============================== */
export const deleteBooking = async (req, res) => {
  try {
    const { id } = req.params;

    console.log("🗑️ Delete booking request:", {
      bookingId: id,
      timestamp: new Date().toISOString(),
    });

    if (!id) {
      console.log("❌ Missing booking ID");
      return res.status(400).json({
        success: false,
        message: "Booking ID is required",
      });
    }

    // Check if booking exists first
    const checkQuery = "SELECT * FROM bookings WHERE id = ?";
    const [checkResults] = await db.query(checkQuery, [id]);
    if (checkResults.length === 0) {
      console.log("❌ Booking not found:", id);
      return res.status(404).json({
        success: false,
        message: "Booking not found",
      });
    }

    const booking = checkResults[0];
    console.log("📋 Booking to delete:", {
      id: booking.id,
      name: booking.name,
      date: booking.date,
      status: booking.status,
    });

    // Delete the booking
    const deleteQuery = "DELETE FROM bookings WHERE id = ?";

    await db.query(deleteQuery, [id]);

    console.log("✅ Booking deleted successfully:", {
      bookingId: id,
    });

    res.json({
      success: true,
      message: "Booking deleted successfully",
      deletedBooking: booking,
    });



  } catch (error) {
    console.error("❌ Server error:", error);
    res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message,
    });
  }
};

/* ===============================
   CREATE BOOKING (PUBLIC)
   POST /booking
=============================== */
export const createBooking = async (req, res) => {
  try {
    const { name, email, date, reason, schoolID } = req.body;

    console.log("📤 Create booking request:", {
      name,
      email,
      date,
      reason,
      schoolID,
      timestamp: new Date().toISOString(),
    });

    // Validation
    if (!name || !date || !reason || !schoolID) {
      console.log("❌ Missing required fields");
      return res.status(400).json({
        success: false,
        message: "Name, date, reason, and schoolID are required",
        received: { name, email, date, reason, schoolID },
      });
    }

    // Validate date format
    const bookingDate = new Date(date);
    if (isNaN(bookingDate.getTime())) {
      console.log("❌ Invalid date format:", date);
      return res.status(400).json({
        success: false,
        message: "Invalid date format",
      });
    }

    // Check if date is in the past
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    bookingDate.setHours(0, 0, 0, 0);

    if (bookingDate < today) {
      console.log("❌ Date is in the past:", date);
      return res.status(400).json({
        success: false,
        message: "Booking date cannot be in the past",
      });
    }

    // Insert booking
    const insertQuery = `
      INSERT INTO bookings (name, email, date, reason, status, schoolID, createdAt)
      VALUES (?, ?, ?, ?, 'Pending', ?, NOW())
    `;

    const values = [name, email || null, date, reason, schoolID];

    db.query(insertQuery, values, (err, results) => {
      if (err) {
        console.error("❌ Database error:", err);
        return res.status(500).json({
          success: false,
          message: "Failed to create booking",
          error: err.message,
        });
      }

      const newBookingId = results.insertId;

      console.log("✅ Booking created successfully:", {
        bookingId: newBookingId,
        name,
        date,
      });

      // Fetch the created booking
      const fetchQuery = "SELECT * FROM bookings WHERE id = ?";

      db.query(fetchQuery, [newBookingId], (fetchErr, fetchResults) => {
        if (fetchErr) {
          console.error("❌ Failed to fetch created booking:", fetchErr);
          // Still return success
          return res.status(201).json({
            success: true,
            message: "Booking created successfully",
            data: {
              id: newBookingId,
              name,
              email,
              date,
              reason,
              status: "Pending",
              schoolID,
            },
          });
        }

        res.status(201).json({
          success: true,
          message: "Booking created successfully",
          data: fetchResults[0],
        });
      });
    });
  } catch (error) {
    console.error("❌ Server error:", error);
    res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message,
    });
  }
};


export const getGrades = async (req, res) => {
  try {
    const { schoolID } = req.params;

    const [grades] = await db.query(`SELECT * FROM grades WHERE schoolID = ?`, [
      schoolID,
    ]);

    res.status(200).json({
      success: true,
      data: grades,
    });
  } catch (error) {
    console.error("Error fetching grades:", error);
    res.status(500).json({
      success: false,
      message: "Failed to fetch grades",
      error: error.message,
    });
  }
};

// @desc    Get grades for a specific student
// @route   GET /api/grades/student/:studentID
// @access  Private
export const getStudentGrades = async (req, res) => {
  try {
    const { studentID } = req.params;

    const grades = await db.query(
      `SELECT g.*, 
              t.subject,
              c.name as className
       FROM grades g
       LEFT JOIN timetable t ON g.subjectID = t.id
       LEFT JOIN classes c ON g.classID = c.id
       WHERE g.studentID = ?
       ORDER BY t.subject`,
      [studentID],
    );

    res.status(200).json({
      success: true,
      data: grades,
    });
  } catch (error) {
    console.error("Error fetching student grades:", error);
    res.status(500).json({
      success: false,
      message: "Failed to fetch student grades",
      error: error.message,
    });
  }
};

// @desc    Get grades for a specific class
// @route   GET /api/grades/class/:classID
// @access  Private
export const getClassGrades = async (req, res) => {
  try {
    const { classID } = req.params;
    const { subjectID } = req.query;

    let query = `
      SELECT g.*, 
             s.firstname, s.lastname,
             t.subject
      FROM grades g
      LEFT JOIN students s ON g.studentID = s.id
      LEFT JOIN timetable t ON g.subjectID = t.id
      WHERE g.classID = ?
    `;

    const params = [classID];

    if (subjectID) {
      query += ` AND g.subjectID = ?`;
      params.push(subjectID);
    }

    query += ` ORDER BY s.lastname, s.firstname`;

    const grades = await db.query(query, params);

    res.status(200).json({
      success: true,
      data: grades,
    });
  } catch (error) {
    console.error("Error fetching class grades:", error);
    res.status(500).json({
      success: false,
      message: "Failed to fetch class grades",
      error: error.message,
    });
  }
};

// @desc    Create or update a grade
// @route   POST /api/grades
// @access  Private
export const createGrade = async (req, res) => {
  try {
    const {
      studentID,
      classID,
      subjectID,
      schoolID,
      test1,
      test2,
      exam,
      term,
      session,
    } = req.body;

    // Validate required fields
    if (!studentID || !classID || !subjectID || !schoolID || !session) {
      return res.status(400).json({
        success: false,
        message: "Missing required fields",
      });
    }

    // Check if grade already exists
    const [existingGrade] = await db.query(
      `SELECT id FROM grades 
       WHERE studentID = ? AND schoolID = ? AND classID = ? AND subjectID = ? AND session = ? AND term = ?`,
      [studentID, schoolID, classID, subjectID, session, term],
    );

    if (existingGrade.length > 0) {
      // Update existing grade
      await db.query(
        `UPDATE grades 
         SET test1 = ?, test2 = ?, exam = ?, updatedAt = NOW()
         WHERE id = ?`,
        [test1 || 0, test2 || 0, exam || 0, existingGrade[0].id],
      );

      // Fetch updated grade
      const updatedGrade = await db.query(
        `select * from grades WHERE schoolID = ?`,
        [schoolID],
      );

      return res.status(200).json({
        success: true,
        message: "Grade updated successfully",
        data: updatedGrade[0],
      });
    }

    // Create new grade
    const result = await db.query(
      `INSERT INTO grades 
       (studentID, classID, subjectID, schoolID, test1, test2, exam, session, term, createdAt, updatedAt)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
      [
        studentID,
        classID,
        subjectID,
        schoolID,
        test1 || 0,
        test2 || 0,
        exam || 0,
        session,
        term,
      ],
    );

    // Fetch created grade
    const [newGrade] = await db.query(
      `select * from grades WHERE schoolID = ?`,
      [schoolID],
    );

    res.status(201).json({
      success: true,
      message: "Grade created successfully",
      data: newGrade,
    });
  } catch (error) {
    console.error("Error creating grade:", error);
    res.status(500).json({
      success: false,
      message: "Failed to create grade",
      error: error.message,
    });
  }
};

// @desc    Update a grade
// @route   PUT /api/grades/:id
// @access  Private
export const updateGrade = async (req, res) => {
  try {
    const { id } = req.params;
    const { test1, test2, classwork, exam } = req.body;

    // Check if grade exists
    const existingGrade = await db.query("SELECT id FROM grades WHERE id = ?", [
      id,
    ]);

    if (existingGrade.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Grade not found",
      });
    }

    // Update grade
    await db.query(
      `UPDATE grades 
       SET test1 = ?, test2 = ?, classwork = ?, exam = ?, updatedAt = NOW()
       WHERE id = ?`,
      [test1, test2, classwork, exam, id],
    );

    // Fetch updated grade
    const updatedGrade = await db.query(
      `SELECT g.*, 
              s.firstname, s.lastname,
              t.subject
       FROM grades g
       LEFT JOIN students s ON g.studentID = s.id
       LEFT JOIN timetable t ON g.subjectID = t.id
       WHERE g.id = ?`,
      [id],
    );

    res.status(200).json({
      success: true,
      message: "Grade updated successfully",
      data: updatedGrade[0],
    });
  } catch (error) {
    console.error("Error updating grade:", error);
    res.status(500).json({
      success: false,
      message: "Failed to update grade",
      error: error.message,
    });
  }
};

// @desc    Bulk update grades for a class/subject
// @route   POST /api/grades/bulk
// @access  Private
export const bulkUpdateGrades = async (req, res) => {
  try {
    const { grades, classID, subjectID, schoolID, session } = req.body;

    if (!grades || !Array.isArray(grades) || grades.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Grades array is required",
      });
    }

    // Start transaction
    await db.query("START TRANSACTION");

    try {
      for (const grade of grades) {
        const { studentID, test1, test2, classwork, exam } = grade;

        // Check if grade exists
        const existing = await db.query(
          `SELECT id FROM grades 
           WHERE studentID = ? AND classID = ? AND subjectID = ? AND session = ?`,
          [studentID, classID, subjectID, session],
        );

        if (existing.length > 0) {
          // Update existing
          await db.query(
            `UPDATE grades 
             SET test1 = ?, test2 = ?, classwork = ?, exam = ?, updatedAt = NOW()
             WHERE id = ?`,
            [test1 || 0, test2 || 0, classwork || 0, exam || 0, existing[0].id],
          );
        } else {
          // Create new
          await db.query(
            `INSERT INTO grades 
             (studentID, classID, subjectID, schoolID, test1, test2, classwork, exam, session, createdAt, updatedAt)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
            [
              studentID,
              classID,
              subjectID,
              schoolID,
              test1 || 0,
              test2 || 0,
              classwork || 0,
              exam || 0,
              session,
            ],
          );
        }
      }

      // Commit transaction
      await db.query("COMMIT");

      // Fetch updated grades
      const updatedGrades = await db.query(
        `SELECT g.*, 
                s.firstname, s.lastname,
                t.subject
         FROM grades g
         LEFT JOIN students s ON g.studentID = s.id
         LEFT JOIN timetable t ON g.subjectID = t.id
         WHERE g.classID = ? AND g.subjectID = ? AND g.session = ?
         ORDER BY s.lastname, s.firstname`,
        [classID, subjectID, session],
      );

      res.status(200).json({
        success: true,
        message: "Grades updated successfully",
        data: updatedGrades,
      });
    } catch (error) {
      // Rollback on error
      await db.query("ROLLBACK");
      throw error;
    }
  } catch (error) {
    console.error("Error bulk updating grades:", error);
    res.status(500).json({
      success: false,
      message: "Failed to update grades",
      error: error.message,
    });
  }
};

// @desc    Delete a grade
// @route   DELETE /api/grades/:id
// @access  Private
export const deleteGrade = async (req, res) => {
  try {
    const { id } = req.params;

    // Check if grade exists
    const existingGrade = await db.query("SELECT id FROM grades WHERE id = ?", [
      id,
    ]);

    if (existingGrade.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Grade not found",
      });
    }

    // Delete grade
    await db.query("DELETE FROM grades WHERE id = ?", [id]);

    res.status(200).json({
      success: true,
      message: "Grade deleted successfully",
    });
  } catch (error) {
    console.error("Error deleting grade:", error);
    res.status(500).json({
      success: false,
      message: "Failed to delete grade",
      error: error.message,
    });
  }
};

// @desc    Get grade statistics for a class
// @route   GET /api/grades/stats/:classID
// @access  Private
export const getClassStatistics = async (req, res) => {
  try {
    const { classID } = req.params;
    const { subjectID, session } = req.query;

    let query = `
      SELECT 
        AVG((test1 + test2 + classwork + exam) / 4) as classAverage,
        MAX((test1 + test2 + classwork + exam) / 4) as highestScore,
        MIN((test1 + test2 + classwork + exam) / 4) as lowestScore,
        COUNT(DISTINCT studentID) as totalStudents,
        SUM(CASE WHEN (test1 + test2 + classwork + exam) / 4 >= 70 THEN 1 ELSE 0 END) as passingStudents,
        SUM(CASE WHEN (test1 + test2 + classwork + exam) / 4 < 70 THEN 1 ELSE 0 END) as failingStudents
      FROM grades
      WHERE classID = ?
    `;

    const params = [classID];

    if (subjectID) {
      query += ` AND subjectID = ?`;
      params.push(subjectID);
    }

    if (session) {
      query += ` AND session = ?`;
      params.push(session);
    }

    const stats = await db.query(query, params);

    res.status(200).json({
      success: true,
      data: stats[0],
    });
  } catch (error) {
    console.error("Error fetching class statistics:", error);
    res.status(500).json({
      success: false,
      message: "Failed to fetch class statistics",
      error: error.message,
    });
  }
};

export const fetchSubjects = async (req, res) => {
  try {
    const { schoolID } = req.params;

    if (!schoolID)
      return res.status(400).json({ error: "schoolID is required" });
    const [subjects] = await db.query(
      `SELECT * FROM subjects WHERE schoolID = ? ORDER BY name ASC`,
      [schoolID],
    );

    res.status(200).json({
      success: true,
      data: subjects,
    });

    if (!subjects.length) {
      return res.status(404).json({
        success: false,
        error: "No subjects found for this school",
      });
    }
  } catch (err) {
    console.error(err);
  }
};

export const createSubject = async (req, res) => {
  try {
    const { schoolID, classID, name } = req.body;

    const [subject] = await db.query(
      "SELECT * FROM subjects WHERE name = ? AND schoolID = ? AND classID = ?",
      [name, schoolID, classID],
    );
    if (subject.length) {
      return res.status(200).json({ error: `Subject ${name} already exists` });
    }

    await db.query(
      "INSERT INTO subjects (name,schoolID,classID) VALUES (?,?,?)",
      [name, schoolID, classID],
    );
    return res.status(200).json({ message: "Subject created succesfull" });
  } catch (err) {
    console.error(err);
  }
};

export const deleteSubject = async (req, res) => {
  try {
    const { subjectID, schoolID } = req.params;
    await db.query("DELETE FROM subjects WHERE id = ?", [subjectID]);

    const [subjects] = await db.query(
      "SELECT * FROM subjects WHERE schoolID = ? ",
      [schoolID],
    );

    if (subjects.length) {
      return res
        .status(200)
        .json({ message: "Subject Deleted", subjects: subjects[0] });
    } else {
      return;
    }
  } catch (err) {
    console.error(err);
  }
};

export const notification = async (req, res) => {
  try {
    const { title, type, content, sendTo, schoolID } = req.body;
    if (!title || !type || !content || !sendTo || !schoolID) {
      console.log(title,type,content,sendTo,schoolID)
      return res.status(302).json({ error: "All Fields Are Required" });
      
    }
    if (type === "sms") {
      if (sendTo === "teacher") {
        console.log(sendTo);

        const [phones] = await db.query(
          "SELECT phone FROM teachers WHERE schoolID = ?",
          [schoolID],
        );
      } else if (sendTo === "parent") {
        const [phones] = await db.query(
          "SELECT parentphone FROM students WHERE schoolID = ?",
          [schoolID],
        );

        const phoneNumbers = [];
        phones.forEach((row) => {
          if (row.parentphone) {
            if (!phoneNumbers.includes(row.parentphone)) {
              phoneNumbers.push(`+234${row.parentphone}`);
            }
          }
        });

        console.log(phoneNumbers);
      }
    }

    await db.query(
      "INSERT INTO notify (schoolID,sendto,title,content,type) VALUES (?,?,?,?,?)",
      [schoolID, sendTo, title, content, type],
    );

    const [notification] = await db.query(
      "SELECT * FROM notify WHERE schoolID = ? ORDER BY id DESC",
      [schoolID],
    );

    if (notification.length) {
      return res
        .status(200)
        .json({ message: "notification sent", data: notification });
    }
  } catch (err) {
    console.error(err);
  }
};

export const getnotification = async (req, res) => {
  try {
    const { schoolID } = req.params;
    const [messages] = await db.query(
      "SELECT * FROM notify WHERE schoolID = ? ORDER BY id DESC",
      [schoolID],
    );
    if (messages.length) {
      return res
        .status(200)
        .json({ message: "notification receaved", data: messages });
    } else {
      return res.status(200).json({ error: "No notification receaved" });
    }
  } catch (err) {
    console.error(err);
  }
};

export const deletenotification = async (req, res) => {
  try {
    const { id, schoolID } = req.params;
    await db.query("DELETE FROM notify WHERE id = ?", [id]);
    const [messages] = await db.query(
      "SELECT * FROM notify WHERE schoolID = ? ORDER BY id DESC",
      [schoolID],
    );
    if (messages.length) {
      return res
        .status(200)
        .json({ message: "notification receaved", data: messages });
    } else {
      return res.status(200).json({ error: "No notification receaved" });
    }
  } catch (err) {
    console.error(err);
  }
};

export const getSMSBalance = async (req, res) => {
  try {
    const { schoolID } = req.params;
    const [credits] = await db.query("SELECT credit FROM admins WHERE id = ?", [
      schoolID,
    ]);
    if (credits.length) {
      return res.status(200).json({ credits: credits[0].credits });
    } else {
      return res.status(200).json({ credits: 0 });
    }
  } catch (err) {
    console.error("Error fetching SMS balance:", err);
  }
};

export const topupSMSBalance = async (req, res) => {
  try {
    const { schoolID, amount } = req.body;
    const [credits] = await db.query("SELECT credit FROM admins WHERE id = ?", [
      schoolID,
    ]);
    const currentCredit = credits.length ? credits[0].credit + amount : 0;
    await db.query("UPDATE admins SET credit = ? WHERE id = ?", [
      currentCredit,
      schoolID,
    ]);
    return res
      .status(200)
      .json({ message: "SMS balance topped up successfully" });
  } catch (err) {
    console.error("Error topping up SMS balance:", err);
  }
};

export const updateemail = async (req, res) => {
  try {
    const { initialemail, newemail, id, role } = req.body;
    if (role === "Admin") {
      await db.query("UPDATE admins SET email = ? where email = ?", [
        newemail,
        initialemail,
      ]);
    }
    if (role === "Teacher") {
      await db.query("UPDATE teachers SET email = ? where email = ?", [
        newemail,
        initialemail,
      ]);
    }
    if (role === "Parent") {
      await db.query("UPDATE students SET parentphone = ? where email = ?", [
        newemail,
        initialemail,
      ]);
    }

    return res.status(200).json({ message: "User updated" });
  } catch (err) {
    console.log(err);
  }
};
export const updatepassword = async (req, res) => {
  try {
    const { newpassword, password, id, role } = req.body;

    if (role === "Admin") {
      const [pass] = await db.query(
        "SELECT password FROM admins WHERE id = ?",
        [id],
      );
      if (!pass.length || !(await bcrypt.compare(password, pass[0].password))) {
        return res.status(200).json({ error: "Incorect Password" });
      }
      const newPass = await bcrypt.hash(newpassword, 10);
      await db.query("UPDATE admins SET password = ? where id = ?", [
        newPass,
        id,
      ]);
    }
    if (role === "Teacher") {
      const [pass] = await db.query(
        "SELECT password FROM teachers WHERE id = ?",
        [id],
      );
      if (!pass.length || !(await bcrypt.compare(password, pass[0].password))) {
        return res.status(200).json({ error: "Incorect Password" });
      }
      const newPass = await bcrypt.hash(newpassword, 10);
      await db.query("UPDATE teachers SET password = ? where id = ?", [
        newPass,
        id,
      ]);
    }
    if (role === "Parent") {
      const [pass] = await db.query(
        "SELECT password FROM students WHERE id = ?",
        [id],
      );
      if (!pass.length || !(await bcrypt.compare(password, pass[0].password))) {
        return res.status(200).json({ error: "Incorect Password" });
      }
      const newPass = await bcrypt.hash(newpassword, 10);
      await db.query("UPDATE students SET password = ? where id = ?", [
        newPass,
        id,
      ]);
    }

    return res
      .status(200)
      .json({ message: "Your password has been successfully updated!" });
  } catch (err) {
    console.log(err);
  }
};

export const deleteStudent = async (req, res) => {
  try {
    const { id } = req.params;
    await db.query("DELETE FROM students WHERE id = ?", [id]);
    return res.status(200).json({ message: "student deleted" });
  } catch (error) {
    console.log(error);
  }
};

////////////////////////////

// ==================== IMPROVED LESSON NOTE GENERATION ====================
// This generates a complete, professional teacher's lesson note following
// Nigerian educational standards and ready for administrative review
// ========================================================================
// ==================== IMPROVED LESSON NOTE GENERATION ====================
// This generates a complete, professional teacher's lesson note following
// Nigerian educational standards and ready for administrative review
// ========================================================================
// ==================== LESSON NOTE GENERATOR CONTROLLER ====================
// This controller handles AI-powered lesson note generation from teacher-defined topics



// ==================== GENERATE LESSON NOTE ====================
export const generateLessonNoteAsync = async (req, res) => {
  try {
    const {
      subject,
      className,
      term,
      week,
      topic,
      objectives,
    } = req.body;

    // Validation
    if (!subject || !className || !topic) {
      return res.status(400).json({
        error: "Missing required fields: subject, className, topic",
      });
    }

    if (!objectives || !Array.isArray(objectives) || objectives.length === 0) {
      return res.status(400).json({
        error: "At least one learning objective is required",
      });
    }

    console.log(
      `Generating lesson note for ${subject} - Week ${week}: ${topic}`,
    );

    // Format objectives
    const objectivesList = objectives
      .map((obj, i) => `${i + 1}. ${obj}`)
      .join("\n");

    // ✅ COMPLETE LESSON NOTE PROMPT
    const prompt = `You are writing a COMPLETE, READY-TO-USE lesson note for a Nigerian secondary school teacher. This note will be inspected by school administrators and should contain EVERYTHING needed to teach the lesson - not instructions on how to teach, but the actual content, examples, questions, and explanations that will be used.

**LESSON DETAILS:**
Subject: ${subject}
Class: ${className}
Term: ${term || "Current Term"}
Week: ${week || "N/A"}
Topic: ${topic}

**TEACHER-DEFINED OBJECTIVES:**
${objectivesList}

---

**CRITICAL REQUIREMENTS:**

1. Write ACTUAL CONTENT, not instructions. For example:
   ❌ WRONG: "Teacher will explain the concept"
   ✅ RIGHT: "A noun is a word that names a person, place, thing, or idea. For example: teacher, school, book, happiness."

2. Include SPECIFIC EXAMPLES, DEFINITIONS, and EXPLANATIONS that will be written on the board and taught

3. Write ACTUAL QUESTIONS with their ANSWERS

4. Include REAL student activities with clear instructions

5. This should be a COMPLETE teaching guide - if a substitute teacher reads this, they should know exactly what to teach

6. Align with NERDC curriculum standards for Nigerian secondary education and Abia State guidelines

---

**JSON FORMAT (CRITICAL - NO APOSTROPHES):**

{
  "metadata": {
    "previousKnowledge": "Students have already learned about [related topic]. They can identify [previous concept] and understand [foundation knowledge].",
    "referenceMaterials": "New Concept English Book 2, Nigerian Curriculum Guide, NERDC approved syllabus, [specific textbook used in Abia State]"
  },
  "objectives": [
    "${objectives[0] || 'Define key concepts and give examples'}",
    "${objectives[1] || 'Identify and classify items into correct categories'}",
    "${objectives[2] || 'Apply knowledge to solve real-world problems'}"
  ],
  "instructionalMaterials": [
    "Textbook - [recommend specific textbook used in Abia State with page numbers]",
    "Whiteboard and markers",
    "Charts/diagrams illustrating ${topic}",
    "Real-life examples and materials",
    "Exercise books for students"
  ],
  "setInduction": "GREETING: Good morning class. I hope you all had a wonderful weekend.\\n\\nREVIEW: Last week we learned about [previous topic]. Can anyone tell me what [question from last lesson]? [Expected: Students will raise hands and answer]. Excellent!\\n\\nMOTIVATION: Today I brought something interesting [show item/picture]. Look at this carefully. What do you notice about it? [Allow students to observe and respond]. This connects to what we will learn today.\\n\\nTOPIC INTRODUCTION: Today we are going to learn about ${topic}. By the end of this lesson, you will be able to [state main objective]. This is important because [real-world relevance].",
  "presentation": {
    "step1_introduction": "DEFINITION AND EXPLANATION:\\n\\n[Write on board]: ${topic}\\n\\n[Explain]: [Complete definition with elaboration - 3-4 sentences explaining the concept clearly].\\n\\nKEY POINTS (write on board):\\n1. [First major point with full explanation]\\n2. [Second major point with full explanation]\\n3. [Third major point with full explanation]\\n\\nQUESTION: Who can explain this in their own words? [Select 2-3 students to respond]\\n\\nEXAMPLE 1: [Provide complete worked example with step-by-step solution]\\nEXAMPLE 2: [Provide second complete example]\\n\\n[Write these examples on the board and explain each step thoroughly]",
    "step2_explanation": "DETAILED CONTENT:\\n\\n[Write complete notes on board - this is what students will copy]:\\n\\nTOPIC: ${topic}\\n\\n[Full paragraph 1 explaining core concept - be specific and detailed]\\n\\n[Full paragraph 2 with supporting information and context]\\n\\nTYPES/CATEGORIES/COMPONENTS:\\na) [First type/category] - [Complete explanation with example]\\n   Example: [Specific example with details]\\n\\nb) [Second type/category] - [Complete explanation with example]\\n   Example: [Specific example with details]\\n\\nc) [Third type/category] - [Complete explanation with example]\\n   Example: [Specific example with details]\\n\\nCHARACTERISTICS/FEATURES:\\n• [First characteristic with explanation]\\n• [Second characteristic with explanation]\\n• [Third characteristic with explanation]\\n\\nPRACTICAL EXAMPLES FROM DAILY LIFE:\\n1. [Real-world example 1 with full explanation]\\n2. [Real-world example 2 with full explanation]\\n3. [Real-world example 3 with full explanation]\\n\\n[Show chart/visual aid and explain each part]\\n\\nCLASS ACTIVITY: Students, look at the examples on the board. In pairs, discuss [specific discussion question]. You have 3 minutes. [Monitor and guide students]",
    "step3_application": "GUIDED PRACTICE:\\n\\nActivity 1: BOARD WORK\\nI will write 5 items on the board. You will identify/classify/solve them.\\n\\n1. [Complete exercise item 1] - Answer: [Full answer with explanation]\\n2. [Complete exercise item 2] - Answer: [Full answer with explanation]\\n3. [Complete exercise item 3] - Answer: [Full answer with explanation]\\n4. [Complete exercise item 4] - Answer: [Full answer with explanation]\\n5. [Complete exercise item 5] - Answer: [Full answer with explanation]\\n\\n[Call students to solve on board, then discuss each solution]\\n\\nActivity 2: GROUP WORK\\nClass, form groups of 4. Each group should [specific task with clear instructions]. Use your notebooks. You have 5 minutes.\\n\\nTask: [Complete detailed task description]\\n\\n[Walk around, observe groups, provide guidance, select groups to present]\\n\\nActivity 3: INDIVIDUAL PRACTICE\\nNow, in your exercise books, complete these on your own:\\n1. [Exercise question 1]\\n2. [Exercise question 2]\\n3. [Exercise question 3]\\n\\n[Give students 3 minutes, then review answers together]",
    "step4_summary": "LESSON RECAP:\\n\\nClass, let us summarize what we have learned today.\\n\\nQUESTION: What is ${topic}? [Select student] Answer: [Expected complete answer]\\n\\nQUESTION: What are the main types/categories we discussed? [Select student] Answer: [Expected answer listing all types]\\n\\nQUESTION: Can you give me an example? [Select student] Answer: [Expected example]\\n\\nKEY POINTS TO REMEMBER (write on board):\\n1. [Summary point 1 - complete sentence]\\n2. [Summary point 2 - complete sentence]\\n3. [Summary point 3 - complete sentence]\\n4. [Summary point 4 - complete sentence]\\n\\n[Point to chart] Remember, we use this when [application]. You will see this in [real-world context].\\n\\nAny questions? [Address any student questions]"
  },
  "evaluation": {
    "questions": [
      "What is ${topic}? (Expected Answer: [Complete definition])",
      "List and explain three [types/examples/characteristics]. (Expected Answer: [Full answer with explanations])",
      "Give two examples of [concept] from your daily life. (Expected Answer: [Sample student responses])",
      "How would you [apply concept] in [specific situation]? (Expected Answer: [Detailed expected response])",
      "What is the difference between [concept A] and [concept B]? (Expected Answer: [Clear comparison])"
    ],
    "assessmentMethod": "Oral questioning (questions above), written responses in exercise books, board work observation, group presentation assessment",
    "successCriteria": "Students can correctly define ${topic}, provide accurate examples, classify items appropriately, and apply knowledge to new situations with 80% accuracy"
  },
  "conclusion": "CLOSING REMARKS:\\n\\nExcellent work today, class! You have all shown good understanding of ${topic}.\\n\\nREVIEW: Remember, [key takeaway 1], [key takeaway 2], and [key takeaway 3].\\n\\nREAL-WORLD CONNECTION: When you go home today, try to identify [practical task related to lesson]. This will help you understand better.\\n\\nNEXT LESSON PREVIEW: In our next class, we will learn about [next topic], which builds on what we learned today about ${topic}.\\n\\nPlease copy the notes from the board into your notebooks if you have not finished. Make sure your notes are neat and complete.",
  "assignment": {
    "task": "HOMEWORK - Due next class\\n\\n1. Define ${topic} in your own words and give 5 examples.\\n2. [Specific question related to lesson content with clear parameters]\\n3. Draw and label [relevant diagram/illustration]\\n4. Write a short paragraph (5 sentences) about [application topic]\\n5. Review your notes and prepare questions for next class",
    "instructions": "1. Use your exercise book, write clearly and neatly\\n2. Draw a margin and write the date\\n3. Copy each question before answering\\n4. Show all your work and explanations\\n5. Examples must be different from class examples\\n6. If you need help, review your class notes from today\\n7. Submit at the beginning of next class",
    "purpose": "This assignment reinforces understanding of ${topic}, allows students to practice independently, develops critical thinking by applying concepts to new situations, and prepares students for the next lesson",
    "expectedOutcome": "Students should demonstrate clear understanding through accurate definitions, appropriate examples, correct application of concepts, neat presentation, and ability to explain their reasoning",
    "dueDate": "Next class - [Specify date based on class schedule]"
  },
  "teacherRemarks": "[To be filled after lesson delivery]\\n\\nLesson Effectiveness: ____/10\\nStudent Participation: ____/10\\nObjectives Achieved: Yes / Partially / No\\n\\nWhat worked well:\\n______________________________\\n\\nChallenges encountered:\\n______________________________\\n\\nAdjustments needed:\\n______________________________\\n\\nFollow-up required:\\n______________________________"
}

===== ABSOLUTE REQUIREMENTS =====
1. Your ENTIRE response must be ONLY the JSON object
2. Do NOT include ANY text before the opening brace {
3. Do NOT include ANY text after the closing brace }
4. Do NOT wrap in markdown code blocks 
5. Do NOT add explanations, notes, or comments
6. Start with { and end with }
7. NOTHING ELSE
8. Replace ALL apostrophes with alternate phrasing to avoid JSON errors
9. Use proper escaping for newlines (\\n) and quotes

If you add ANY text outside the JSON, the response will FAIL.

BEGIN YOUR RESPONSE WITH { AND END WITH }`;

    const aiResponse = await callGroqAPI(
      [{ role: "user", content: prompt }],
      8000,
    );

    // Parse response
    const note = parseJSONResponse(aiResponse, "object");

    if (!note || typeof note !== "object") {
      throw new Error("AI did not return a valid note object");
    }

    // Validate the structure
    if (!note.metadata || !note.objectives || !note.presentation) {
      throw new Error("AI response missing required sections");
    }

    console.log("✅ Successfully generated professional lesson note");

    res.json({
      success: true,
      note: note,
      message: "Professional lesson note generated successfully",
    });
  } catch (error) {
    console.error("Generate Note Error:", error);
    res.status(500).json({
      error: error.message || "Failed to generate lesson note",
    });
  }
};

// ==================== HELPER: CALL GROQ API ====================
const callGroqAPI = async (messages, maxTokens = 4000) => {
  try {
    const response = await fetch(GROQ_API_URL, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${GROQ_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: MODEL,
        messages: messages,
        temperature: 0.3,
        max_tokens: maxTokens,
        top_p: 1,
        stream: false,
      }),
    });
    
    if (!response.ok) {
      const error = await response.json().catch(() => ({}));
      throw new Error(error.error?.message || `Groq API error: ${response.status}`);
    }
    
    const data = await response.json();
    
    if (!data.choices || !data.choices[0] || !data.choices[0].message) {
      throw new Error('Invalid response from Groq API');
    }
    
    return data.choices[0].message.content;
  } catch (error) {
    console.error('Groq API Error:', error);
    throw error;
  }
};

// ==================== HELPER: PARSE JSON RESPONSE ====================
const parseJSONResponse = (text, type = 'object') => {
  try {
    let cleanText = text.trim();
    
    // Remove markdown code blocks
    cleanText = cleanText.replace(/```json\n?/gi, '');
    cleanText = cleanText.replace(/```javascript\n?/gi, '');
    cleanText = cleanText.replace(/```\n?/g, '');
    
    // Find JSON boundaries
    let jsonStart = -1;
    let jsonEnd = -1;
    
    if (type === 'array') {
      jsonStart = cleanText.indexOf('[');
      if (jsonStart !== -1) {
        let bracketCount = 0;
        for (let i = jsonStart; i < cleanText.length; i++) {
          if (cleanText[i] === '[') bracketCount++;
          if (cleanText[i] === ']') bracketCount--;
          if (bracketCount === 0) {
            jsonEnd = i;
            break;
          }
        }
      }
    } else {
      jsonStart = cleanText.indexOf('{');
      if (jsonStart !== -1) {
        let braceCount = 0;
        for (let i = jsonStart; i < cleanText.length; i++) {
          if (cleanText[i] === '{') braceCount++;
          if (cleanText[i] === '}') braceCount--;
          if (braceCount === 0) {
            jsonEnd = i;
            break;
          }
        }
      }
    }
    
    // Extract JSON
    if (jsonStart !== -1 && jsonEnd !== -1) {
      cleanText = cleanText.substring(jsonStart, jsonEnd + 1);
    } else {
      throw new Error('Could not find valid JSON boundaries in response');
    }
    
    // Parse
    try {
      const parsed = JSON.parse(cleanText);
      console.log('✅ Successfully parsed JSON response');
      return parsed;
    } catch (parseError) {
      // Enhanced error logging
      const errorMatch = parseError.message.match(/position (\d+)/);
      if (errorMatch) {
        const pos = parseInt(errorMatch[1]);
        const start = Math.max(0, pos - 150);
        const end = Math.min(cleanText.length, pos + 150);
        const snippet = cleanText.substring(start, end);
        const markerPos = Math.min(150, pos - start);
        const marker = ' '.repeat(markerPos) + '^ ERROR HERE';
        
        console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        console.error('JSON PARSE ERROR AT POSITION', pos);
        console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        console.error('Error:', parseError.message);
        console.error('\nContext:');
        console.error(snippet);
        console.error(marker);
        console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      }
      
      throw parseError;
    }
  } catch (error) {
    console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.error('FINAL PARSE FAILURE');
    console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.error('Original AI Response (first 2000 chars):');
    console.error(text.substring(0, 2000));
    console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    throw new Error(`Failed to parse AI response: ${error.message}`);
  }
};
