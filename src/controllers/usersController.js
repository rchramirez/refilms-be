import bcrypt from 'bcryptjs';
import generateJWT from "../helpers/generateJWT.js";
import CustomError from "../utils/customError.js"

class UsersController {

    static async getAllUsers(req, res) {
        try {
            const [rows] = await req.pool.query('SELECT * FROM users');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ message: err.message });
        }
    }

    static async createUser(req, res) {
        const newUser = req.body;

        try {
            const [result] = await req.pool.query('INSERT INTO users SET ?', newUser);
            newUser.id = result.insertId;
            res.status(201).json({
                message: 'User created successfully',
                user: newUser
            });
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }

    static async getUser(req, res) {
        const id = req.params.id;
        try {
            const [rows] = await req.pool.query('SELECT * FROM users WHERE id = ?', id);
            res.json(rows);
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async deleteUser(req, res) {
        const id = req.params.id;
        try {
            await req.pool.query('DELETE FROM users WHERE id = ?', id);
            res.json({
                message: 'User deleted successfully'
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async updateUser(req, res) {
        const id = req.params.id;
        const user = req.body;
        user.id = id;

        try {
            await req.pool.query('UPDATE users SET ? WHERE id = ?', [user, id]);
            res.json({
                message: 'User updated successfully',
                user: user
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async register(req, res, next) {
        const newUser = req.body;

        if (!newUser.username || !newUser.password) {
            return next(new CustomError('Username and password are required', 400));
        }

        try {
            newUser.password = await bcrypt.hash(newUser.password, 10);
            const [result] = await req.pool.query('INSERT INTO users SET ?', newUser);
            newUser.id = result.insertId;
            res.status(201).json({
                message: 'User created successfully',
                user: newUser
            });
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }

    static async authenticate(req, res, next) {
        const { username, password } = req.body;

        const [rows] = await req.pool.query('SELECT * FROM users WHERE username = ?', username);
        const user = rows[0];

        if (!user) {
            return next(new CustomError(`No Invalid Login Details for username ${username}`, 404));
        }

        const isMatch  = await bcrypt.compare(password, user.password);
        if (!isMatch ) {
            return next(new CustomError('Password Incorrect!', 400));
        }

        res.json({
            message: 'Login successful',
            username: user.username,
            email: user.email,
            token: generateJWT(user.id),
        });
    }
}

export default UsersController;
