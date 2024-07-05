import Router from 'express';
import Genres from '../controllers/genresController.js';
import checkAuth from "../middleware/checkAuth.js";

const router = Router();

router
    .route('/')
    .get(checkAuth, Genres.getAllGenres)
    .post(checkAuth, Genres.createGenre);

router
    .route('/:id')
    .get(checkAuth, Genres.getGenre)
    .delete(checkAuth, Genres.deleteGenre)
    .put(checkAuth, Genres.updateGenre);

export default router;