import jwt from 'jsonwebtoken';
import 'dotenv/config';

const generateJWT = (id) => {
    return jwt.sign({ id }, process.env.SECRET_KEY || 'mysecretkey', {
        expiresIn: '1h'
    })
}

export default generateJWT;