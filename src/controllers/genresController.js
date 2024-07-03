class GenresController {

    static async getAllGenres(req, res) {
        try {
            const [rows] = await req.pool.query('SELECT * FROM genres');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ message: err.message });
        }
    }

    static async createGenre(req, res) {
        const newGenre = req.body;

        try {
            const [result] = await req.pool.query('INSERT INTO genres SET ?', newGenre);
            newGenre.id = result.insertId;
            res.status(201).json({
                message: 'Genre created successfully',
                genre: newGenre
            });
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }

    static async getGenre(req, res) {
        const id = req.params.id;
        try {
            const [rows] = await req.pool.query('SELECT * FROM genres WHERE id = ?', id);
            res.json(rows);
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async deleteGenre(req, res) {
        const id = req.params.id;
        try {
            await req.pool.query('DELETE FROM genres WHERE id = ?', id);
            res.json({
                message: 'Genre deleted successfully'
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async updateGenre(req, res) {
        const id = req.params.id;
        const genre = req.body;
        genre.id = id;

        try {
            await req.pool.query('UPDATE genres SET ? WHERE id = ?', [genre, id]);
            res.json({
                message: 'Genre updated successfully',
                genre: genre
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }
}

export default GenresController;
