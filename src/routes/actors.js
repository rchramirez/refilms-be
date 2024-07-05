import Router from 'express';
import Actors from '../controllers/actorsController.js';
import checkAuth from "../middleware/checkAuth.js";

const router = Router();

router
    .route("/")
    .get(checkAuth, Actors.getAllActors)
    .post(checkAuth, Actors.createActor);

router
    .route('/:id')
    .get(checkAuth, Actors.getActor)
    .delete(checkAuth, Actors.deleteActor)
    .put(checkAuth, Actors.updateActor);

export default router;