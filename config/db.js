import { createPool } from 'mysql2/promise';

// Create a connection pool
const pool = createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'refilmsdb',
    waitForConnections: true,
    connectionLimit: 10
})

pool.getConnection()
    .then(connection => {
        pool.releaseConnection(connection);
        console.log('Database connected!');
    })
    .catch(err => {
        console.error('Hubo un error al conectarse a la DB:', err);
    });

// Function to execute queries
async function executeQuery(query, params) {
    const connection = await pool.getConnection();
    try {
        const [rows] = await connection.query(query, params);
        return rows;
    } catch (error) {
        throw error;
    } finally {
        connection.release();
    }
}

export default pool;