import mysql from "mysql2/promise";
import "dotenv/config";
let pool;

const DB = () => {
  try {
    if (!pool) {
     pool = mysql.createPool({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
        port: process.env.PORT || 3306,
        connectionLimit: 10,
      }); 
       console.log(" mysql connection");

    } 

    return pool;
  } catch (err) {
    console.log(err);
  }
};

export default DB;
