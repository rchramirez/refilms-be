import Router from 'express';
import Directors from '../controllers/directorsController.js';

const router = Router();

router
    .route("/")
    .get(Directors.getAllDirectors)
    .post(Directors.createDirector);

router
    .route('/:id')
    .get(Directors.getDirector)
    .delete(Directors.deleteDirector)
    .put(Directors.updateDirector);

export default router;