class DirectorsController {

    static async getAllDirectors(req, res) {
        try {
            const [rows] = await req.pool.query('SELECT * FROM directors');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ message: err.message });
        }
    }

    static async createDirector(req, res) {
        const newDirector = req.body;

        try {
            const [result] = await req.pool.query('INSERT INTO directors SET ?', newDirector);
            newDirector.id = result.insertId;
            res.status(201).json({
                message: 'Director created successfully',
                director: newDirector
            });
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }

    static async getDirector(req, res) {
        
        const id = req.params.id;
        try {
            const [rows] = await req.pool.query('SELECT * FROM directors WHERE id = ?', id);
            res.json(rows);
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async deleteDirector(req, res) {
        const id = req.params.id;
        try {
            await req.pool.query('DELETE FROM directors WHERE id = ?', id);
            res.json({
                message: 'Director deleted successfully'
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async updateDirector(req, res) {
        const id = req.params.id;
        const director = req.body;
        director.id = id;

        try {
            await req.pool.query('UPDATE directors SET ? WHERE id = ?', [director, id]);
            res.json({
                message: 'Director updated successfully',
                director: director
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }
}

export default DirectorsController;
