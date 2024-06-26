import express from 'express';
import pool from './src/config/db.js';

const app = express();
const port = 3000;

app.get('/movies', async (req, res) => {
  try{
    const connection = await pool.getConnection();
    const queryText = 'SELECT * FROM Actor';
    const [rows] = await connection.query(queryText);
    connection.release();
    res.json(rows);
  } catch(error) {
    console.error('Error in query database: ', error);
    res.status(500).send('Error in query database');
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`)
})