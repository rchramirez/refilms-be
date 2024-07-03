class MoviesController {

    static async getAllMovies(req, res) {
        try {
            const [rows] = await req.pool.query('SELECT * FROM movies');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ message: err.message });
        }
    }

    static async createMovie(req, res) {
        const newMovie = req.body;

        try {
            const [result] = await req.pool.query('INSERT INTO movies SET ?', newMovie);
            newMovie.id = result.insertId;
            res.status(201).json({
                message: 'Movie created successfully',
                movie: newMovie
            });
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }

    static async getMovie(req, res) {
        const id = req.params.id;
        try {
            const [rows] = await req.pool.query('SELECT * FROM movies WHERE id = ?', id);
            res.json(rows);
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async deleteMovie(req, res) {
        const id = req.params.id;
        try {
            await req.pool.query('DELETE FROM movies WHERE id = ?', id);
            res.json({
                message: 'Movie deleted successfully'
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async updateMovie(req, res) {
        const id = req.params.id;
        const movie = req.body;
        movie.id = id;

        try {
            await req.pool.query('UPDATE movies SET ? WHERE id = ?', [movie, id]);
            res.json({
                message: 'Movie updated successfully',
                movie: movie
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }
}

export default MoviesController;
