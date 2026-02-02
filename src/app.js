import express from 'express';
import 'dotenv/config'
import router from './routes/router.js';
import { globalMiddleware } from './middleware/middleware.js';
import DB from './config/db.js'
import cors from 'cors'
const app = express()
const PORT = process.env.PORT || 3000
DB();
app.use(
  cors({
    origin: "http://localhost:5173",
  })
);
app.use(express.json())
app.use(globalMiddleware);
app.use('/api', router)

app.get('/', (req,res) => {
    res.status(200).json({ message: 'Api connected sucesfully' })
})



app.listen(PORT, () => {
    console.log(`App is connected and running on http://localhost:${PORT}`)
})

process.on('uncaughtException', (err) => {
    console.log(`Error: ${err.message}`);
})