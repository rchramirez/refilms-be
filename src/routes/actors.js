import Router from 'express';
import Actors from '../controllers/actorsController.js';
import checkAuth from "../middleware/checkAuth.js";

const router = Router();

router
    .route("/")
    .get(checkAuth, Actors.getAllActors)
    .post(Actors.createActor);

router
    .route('/:id')
    .get(Actors.getActor)
    .delete(Actors.deleteActor)
    .put(Actors.updateActor);

export default router;