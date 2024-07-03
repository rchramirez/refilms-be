import Router from 'express';
import Reviewers from '../controllers/reviewersController.js'

const router = Router();

router
    .route('/')
    .get(Reviewers.getAllReviewers)
    .post(Reviewers.createReviewer);

router
    .route('/:id')
    .get(Reviewers.getReviewer)
    .delete(Reviewers.deleteReviewer)
    .put(Reviewers.updateReviewer);

export default router;