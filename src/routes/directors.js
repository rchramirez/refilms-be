import Router from 'express';
import Directors from '../controllers/directorsController.js';
import checkAuth from "../middleware/checkAuth.js";

const router = Router();

router
    .route("/")
    .get(checkAuth, Directors.getAllDirectors)
    .post(checkAuth, Directors.createDirector);

router
    .route('/:id')
    .get(checkAuth, Directors.getDirector)
    .delete(checkAuth, Directors.deleteDirector)
    .put(checkAuth, Directors.updateDirector);

export default router;