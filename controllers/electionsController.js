const db =  require('../models/db');

var controller = {

    getAllElections: (req, res) => {
        db.query('SELECT * FROM elections ORDER BY office_id, district', (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                var elections = [];
                for (let i = 0; i < results.length; i++) {
                    elections[i] = {};
                    elections[i].electionID = results[i].election_id;
                    elections[i].date = results[i].date;
                    elections[i].type = results[i].type;
                    if (results[i].type == 'primary') {
                        elections[i].party = results[i].party_name;
                    }
                    elections[i].office = results[i].office_id;
                    if (results[i].district != null) {
                        elections[i].district = results[i].district;
                    }
                }
                res.json(elections);
            }
        })
    }, // end getAllElecctions

    getElectionsByOffice: (req, res) => {
        db.query(`SELECT * FROM elections WHERE office_id = ? ORDER BY district`, [req.params.office], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                var elections = [];
                for (let i = 0; i < results.length; i++) {
                    elections[i] = {};
                    elections[i].electionID = results[i].election_id;
                    elections[i].date = results[i].date;
                    elections[i].type = results[i].type;
                    if (results[i].type == 'primary') {
                        elections[i].party = results[i].party_name;
                    }
                    elections[i].office = results[i].office_id;
                    if (results[i].district != null) {
                        elections[i].district = results[i].district;
                    }
                }
                res.json(elections);
            }
        })
    }, // end getElectionsByOffice

    getElectionsByYear: (req, res) => {
        db.query(`SELECT * FROM elections WHERE year(date) = ? ORDER BY office_id, district`, [req.params.year], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                var elections = [];
                for (let i = 0; i < results.length; i++) {
                    elections[i] = {};
                    elections[i].electionID = results[i].election_id;
                    elections[i].date = results[i].date;
                    elections[i].type = results[i].type;
                    if (results[i].type == 'primary') {
                        elections[i].party = results[i].party_name;
                    }
                    elections[i].office = results[i].office_id;
                    if (results[i].district != null) {
                        elections[i].district = results[i].district;
                    }
                }
                res.json(elections);
            }
        })
    }, // end getElectionsByYear

    getElectionsByDistrict: (req, res) => {
        db.query(`SELECT * FROM elections WHERE office_id = ? AND district = ?`, [req.params.office, req.params.district], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                var elections = [];
                for (let i = 0; i < results.length; i++) {
                    elections[i] = {};
                    elections[i].electionID = results[i].election_id;
                    elections[i].date = results[i].date;
                    elections[i].type = results[i].type;
                    if (results[i].type == 'primary') {
                        elections[i].party = results[i].party_name;
                    }
                    elections[i].office = results[i].office_id;
                    if (results[i].district != null) {
                        elections[i].district = results[i].district;
                    }
                }
                res.json(elections);
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
    }, // end getAllElectionsCandidates

    getCandidatesByOffice: (req, res) => {
        db.query(`SELECT e.*, c.*, ec.election_id AS candidate_election, p.party_name
        FROM elections e
        LEFT JOIN election_candidates ec
            ON e.election_id = ec.election_id
        LEFT JOIN candidates c 
            ON ec.candidate_id = c.candidate_id
        LEFT JOIN parties p
            ON e.party_id = p.party_id
        WHERE year(date) = 2019
        AND office_id = ?
        AND ec.candidate_id IS NOT NULL
        ORDER BY e.election_id`, [req.params.office], (err, results) => {
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
    }, // end getCandidatesByOffice

    getCandidatesByDistrict: (req, res) => {
        db.query(`SELECT e.*, c.*, ec.election_id AS candidate_election, p.party_name
        FROM elections e
        LEFT JOIN election_candidates ec
            ON e.election_id = ec.election_id
        LEFT JOIN candidates c 
            ON ec.candidate_id = c.candidate_id
        LEFT JOIN parties p
            ON e.party_id = p.party_id
        WHERE year(date) = 2019
        AND office_id = ?
        AND district = ?
        AND ec.candidate_id IS NOT NULL
        ORDER BY e.election_id`, [req.params.office, req.params.district], (err, results) => {
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
    } // end getCandidatesByDistrict

    // getNextElection: select and order by election date,
    // loop as long as election date is equal to row[0].date,
    // otherwise break the loop, send results

    // getNextElectionCandidates

}; // end controller object

module.exports = controller;