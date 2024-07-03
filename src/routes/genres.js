import Router from 'express';
import Genres from '../controllers/genresController.js';

const router = Router();

router
    .route('/')
    .get(Genres.getAllGenres)
    .post(Genres.createGenre);

router
    .route('/:id')
    .get(Genres.getGenre)
    .delete(Genres.deleteGenre)
    .put(Genres.updateGenre);

export default router;