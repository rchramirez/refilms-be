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
    .get(Users.getUser)
    .delete(Users.deleteUser)
    .put(Users.updateUser);

router.post('/login', Users.authenticate);

export default router;