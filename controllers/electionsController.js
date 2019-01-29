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
        let results = db.query(`SELECT * FROM elections WHERE office_id = ? AND district = ?`, [req.params.office, req.params.district], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.json(results);
            }
        })
    },

    getAllElectionsCandidates: (req, res) => {
        db.query(`SELECT e.*, c.*, ec.election_id AS candidate_election, p.party_name
            FROM elections e
            LEFT JOIN election_candidates ec
                ON e.election_id = ec.election_id
            LEFT JOIN candidates c 
                ON ec.candidate_id = c.candidate_id
            LEFT JOIN parties p
                ON e.party_id = p.party_id
            WHERE year(date) = 2019
            ORDER BY e.election_id;`, (err, results) => {
                if (err) {
                    console.log(err);
                    res.send(err);
                }
                else {
                    var elections = [];
                    let j = 0;
                    for (let i = 0; i < results.length; i++) {
                        if (results[i-1] != null && results[i].election_id == results[i-1].election_id) {
                            continue;
                        }
                        elections[j] = {};
                        elections[j].electionID = results[i].election_id;
                        elections[j].date = results[i].date;
                        elections[j].type = results[i].type;
                        if (results[i].type == 'primary') {
                            elections[j].party = results[i].party_name;
                        }
                        elections[j].office = results[i].office_id;
                        if (results[i].district != null) {
                            elections[j].district = results[i].district;
                        }
                        j++;
                    }
                    for (let i = 0; i < results.length; i++) {
                        if (results[i].candidate_id) {
                            let k = elections.findIndex(x => x.electionID == results[i].candidate_election);
                            if (!("candidates" in elections[k])) {
                                elections[k].candidates = [];
                            }
                            let newCandidate = {
                                firstName: results[i].first_name,
                                lastName: results[i].last_name,
                                party: results[i].party_name,
                                website: results[i].website
                            }
                            elections[k].candidates.push(newCandidate);

                        }
                    }
                    elections.sort((a, b) => {
                        return a.district - b.district;
                    });
                    res.send(elections);
                }
            })
    }

}; // end controller object

module.exports = controller;