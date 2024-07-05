import Router from 'express';
import Movies from '../controllers/moviesController.js';
import checkAuth from "../middleware/checkAuth.js";

const router = Router();

router
    .route('/')
    .get(checkAuth, Movies.getAllMovies)
    .post(checkAuth, Movies.createMovie);

router
    .route('/:id')
    .get(checkAuth, Movies.getMovie)
    .delete(checkAuth, Movies.deleteMovie)
    .put(checkAuth, Movies.updateMovie);

export default router;