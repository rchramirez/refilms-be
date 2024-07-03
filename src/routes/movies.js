import Router from 'express';
import Movies from '../controllers/moviesController.js';

const router = Router();

router
    .route('/')
    .get(Movies.getAllMovies)
    .post(Movies.createMovie);

router
    .route('/:id')
    .get(Movies.getMovie)
    .delete(Movies.deleteMovie)
    .put(Movies.updateMovie);

export default router;