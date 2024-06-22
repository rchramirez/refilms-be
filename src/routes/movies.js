import Router from 'express';
import Movie from '../controllers/MoviesController';

const router = Router();

router
    .route('/')
    .get(Movie.getAllMovies.bind(Movie))
    .post(Movie.createMovie.bind(Movie));

module.exports = router;