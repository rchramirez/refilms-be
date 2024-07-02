class ActorsController {

    static async getAllActors(req, res) {
        try {
            const [rows] = await req.pool.query('SELECT * FROM actors');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ message: err.message });
        }
    }

    static async createActor(req, res) {
        const newActor = req.body;

        try {
            const [result] = await req.pool.query('INSERT INTO actors SET ?', newActor);
            newActor.id = result.insertId;
            res.status(201).json({
                message: 'Actor created successfully',
                actor: newActor
            });
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }

    static async getActor(req, res) {
        const id = req.params.id;
        try {
            const [rows] = await req.pool.query('SELECT * FROM actors WHERE id = ?', id);
            res.json(rows);
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async deleteActor(req, res) {
        const id = req.params.id;
        try {
            await req.pool.query('DELETE FROM actors WHERE id = ?', id);
            res.json({
                message: 'Actor deleted successfully'
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async updateActor(req, res) {
        const id = req.params.id;
        const actor = req.body;
        actor.id = id;

        try {
            await req.pool.query('UPDATE actors SET ? WHERE id = ?', [actor, id]);
            res.json({
                message: 'Actor updated successfully',
                actor: actor
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }
}

export default ActorsController;
