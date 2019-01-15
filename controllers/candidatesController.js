const db = require('../models/db');

var controller = {

    getAllCandidates: (req, res) => {
        var results = db.query('SELECT * FROM candidates', (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.json(results);
            }
        });
    }, // end getAllCandidates

    getCandidatesByOffice: (req, res) => {
        let results = db.query(`select c.first_name, c.last_name, c.party_id, c.website
        from election_candidates ec
            left join candidates c 
                on ec.candidate_id = c.candidate_id
        where election_id in (
            select election_id
            from elections
            where office_id = ?)`, [req.params.office], (err, results) => {
                if (err) {
                    console.log(err);
                    res.send(err);
                }
                else {
                    res.json(results);
                }
            })
    }

}; // end controller object

module.exports = controller;