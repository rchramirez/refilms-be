class ReviewersController {

    static async getAllReviewers(req, res) {
        try {
            const [rows] = await req.pool.query('SELECT * FROM reviewers');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ message: err.message });
        }
    }

    static async createReviewer(req, res) {
        const newReviewer = req.body;

        try {
            const [result] = await req.pool.query('INSERT INTO reviewers SET ?', newReviewer);
            newReviewer.id = result.insertId;
            res.status(201).json({
                message: 'Reviewer created successfully',
                reviewer: newReviewer
            });
        } catch (err) {
            res.status(400).json({ message: err.message });
        }
    }

    static async getReviewer(req, res) {
        const id = req.params.id;
        try {
            const [rows] = await req.pool.query('SELECT * FROM reviewers WHERE id = ?', id);
            res.json(rows);
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async deleteReviewer(req, res) {
        const id = req.params.id;
        try {
            await req.pool.query('DELETE FROM reviewers WHERE id = ?', id);
            res.json({
                message: 'Reviewer deleted successfully'
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }

    static async updateReviewer(req, res) {
        const id = req.params.id;
        const reviewer = req.body;
        reviewer.id = id;

        try {
            await req.pool.query('UPDATE reviewers SET ? WHERE id = ?', [reviewer, id]);
            res.json({
                message: 'Reviewer updated successfully',
                reviewer: reviewer
            });
        } catch (err) {
            res.status(404).json({ message: err.message });
        }
    }
}

export default ReviewersController;
