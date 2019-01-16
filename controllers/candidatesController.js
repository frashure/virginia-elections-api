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
        let results = db.query(`select c.first_name, c.last_name, c.website, p.party_name
        from election_candidates ec
            left join candidates c 
                on ec.candidate_id = c.candidate_id
            left join parties p
                on c.party_id = p.party_id
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
    }, // end getCandidatesByOffice

    getCandidatesByDistrict: (req, res) => {
        let results = db.query(`
        SELECT * FROM candidates
        WHERE candidate_id IN (
            SELECT candidate_id
            FROM election_candidates
            WHERE election_id IN (
                SELECT election_id
                FROM elections
                WHERE office_id = ?
                AND district = ?
            ))`, [req.params.office, req.params.district], (err, results) => {
                if (err) {
                    console.log(err);
                    res.send(err);
                }
                else {
                    res.json(results);
                }
            })
    } // end getCandidatesByDistrict

}; // end controller object

module.exports = controller;