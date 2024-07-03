import jwt from 'jsonwebtoken';
import 'dotenv/config';

const checkAuth = async (req, res, next) => {
    const headerToken = req.headers['authorization']
    console.log(headerToken);

    if (headerToken != undefined && headerToken.startsWith('Bearer')) {
        try {
            const bearerToken = headerToken.slice(7);
            const decoded = jwt.verify(bearerToken, process.env.SECRET_KEY || 'mysecretkey');
            const [rows] = await req.pool.query('SELECT * FROM users WHERE id = ?', decoded.id);
            req.body.user = rows[0];
            next();
        } catch (error) {
            res.status(401).json({
                msg: 'Token invalid!'
            });
        }
    } else {
        res.status(401).json({
            msg: 'Access denied!'
        });
    }
}

export default checkAuth;