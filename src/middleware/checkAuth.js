import jwt from 'jsonwebtoken';
import 'dotenv/config';
import validator from 'validator';

const checkAuth = async (req, res, next) => {
    const headerToken = req.headers['authorization']
    if (!headerToken) {
        res.status(401).json({
            message: 'No token provided'
        });
    }
    const bearerToken = headerToken.slice(7);
    if (!validator.isJWT(bearerToken)) {
        res.status(401).json({
            message: 'Invalid token format'
        });
    }
    try {
        const decoded = jwt.verify(bearerToken, process.env.SECRET_KEY || 'mysecretkey');
        const [rows] = await req.pool.query('SELECT * FROM users WHERE id = ?', decoded.id);
        if (!rows) {
            res.status(400).json({
                message: 'User not exist'
            });
        }
        next();
    } catch (error) {
        res.status(401).json({
            message: 'Token invalid!'
        });
    }
}

export default checkAuth;