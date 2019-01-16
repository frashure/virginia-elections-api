const db =  require('../models/db');

var controller = {

    getAllElections: (req, res) => {
        let results = db.query('SELECT * FROM elections', (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.json(results);
            }
        })
    }, // end getAllElecctions

    getElectionsByOffice: (req, res) => {
        let results = db.query(`SELECT * FROM elections WHERE office_id = ?`, [req.params.office], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.json(results);
            }
        })
    }, // end getElectionsByOffice

    getElectionsByYear: (req, res) => {
        let results = db.query(`SELECT * FROM elections WHERE year(date) = ?`, [req.params.year], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.json(results);
            }
        })
    }, // end getElectionsByYear

    getElectionsByDistrict: (req, res) => {
        let results = db.query(`SELECT * FROM elections WHERE office_id = ? AND district = ?`, [req.params.office, req.params.district], (err), results => {
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