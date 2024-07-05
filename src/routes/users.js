import Router from 'express';
import Users from '../controllers/usersController.js';
import checkAuth from "../middleware/checkAuth.js";

const router = Router();

router
    .route('/')
    .get(checkAuth, Users.getAllUsers)
    .post(Users.register);

router
    .route('/:id')
    .get(checkAuth, Users.getUser)
    .delete(checkAuth, Users.deleteUser)
    .put(checkAuth, Users.updateUser);

router.post('/login', Users.authenticate);

export default router;