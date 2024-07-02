import Router from 'express';
import Movies from '../controllers/moviesController.js';

const router = Router();

router
    .route('/')
    .get(Movies.getAllMovies)
    .post(Movies.createMovie);

export default router;