import express from 'express';
import pool from './config/db.js';
import 'dotenv/config';

import routesActors from './routes/actors.js'
import routesMovies from './routes/movies.js'

class Server {

    constructor() {        
        this.app = express();
        this.port = process.env.PORT || 3000;

        this.middlewares();
        this.routes();
        this.databaseConnection();
    }

    async databaseConnection() {
        try {
            await pool.getConnection();
            console.log('Conectado a la base de datos MySQL');
        } catch (error) {
            console.error('Error de conexión a MySQL:', error);
        }
    }

    middlewares() {
        this.app.use(express.json());
        this.app.use(express.urlencoded({ extended: true }));
        this.app.use(express.static('public'));

        this.app.use((req, res, next) => {
            req.pool = pool;
            next();
        });
    }

    routes() {
        this.app.use('/refilms/actors', routesActors);
        this.app.use('/refilms/movies', routesMovies);
    }

    listen() {
        this.app.listen(this.port, () => {
            console.log(`Server is running on port ${this.port}`)
        });
    }

}

export default Server;