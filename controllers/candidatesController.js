const db = require('../models/db');

var controller = {

    getAllCandidates: (req, res) => {
        var results = db.query('SELECT * FROM candidates', (err, results) => {
            if (err) {
                console.log(err);
            }
            else {
                res.json(results);
            }
        });
    } // end getAllCandidates

}; // end controller object

module.exports = controller;