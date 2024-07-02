import { createPool } from 'mysql2/promise';
import 'dotenv/config';

const pool = createPool({
    host: process.env.MYSQL_ADDON_HOST,
    user: process.env.MYSQL_ADDON_USER,
    password: process.env.MYSQL_ADDON_PASSWORD,
    database: process.env.MYSQL_ADDON_DB,
    port:process.env.MYSQL_ADDON_PORT,
    connectionLimit: 5
});

pool.getConnection()
    .then(connection => {
        pool.releaseConnection(connection);
        console.log('Database connected!');
    })
    .catch(err => {
        console.error('Error connecting to the database', err);
    });

export default pool;