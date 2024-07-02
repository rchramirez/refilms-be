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
        const { title, genre, releaseDate, director, synopsis } = req.body;

        try {
            const [result] = await req.pool.query(
                'INSERT INTO movies (title, genre, releaseDate, director, synopsis) VALUES (?, ?, ?, ?, ?)',
                [title, genre, releaseDate, director, synopsis]
            );

            const newMovie = {
                id: result.insertId,
                title,
                genre,
                releaseDate,
                director,
                synopsis
            };

            res.status(201).json(newMovie);
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }
}

export default MoviesController;
