import Router from 'express';
import Reviewers from '../controllers/reviewersController.js'
import checkAuth from "../middleware/checkAuth.js";

const router = Router();

router
    .route('/')
    .get(checkAuth, Reviewers.getAllReviewers)
    .post(checkAuth, Reviewers.createReviewer);

router
    .route('/:id')
    .get(checkAuth, Reviewers.getReviewer)
    .delete(checkAuth, Reviewers.deleteReviewer)
    .put(checkAuth, Reviewers.updateReviewer);

export default router;