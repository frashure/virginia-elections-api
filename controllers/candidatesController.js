const db = require('../models/db');
const request = require('request');
const https = require('https');

var controller = {

    getAllCandidates: (req, res) => {
        db.query(`SELECT c.*, p.party_name FROM candidates c
                LEFT JOIN parties p
                    ON c.party_id = p.party_id
                ORDER BY c.last_name`, (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                var candidates = [];
                for (let i = 0; i < results.length; i++) {
                    let candidate = {
                        firstName: results[i].first_name,
                        lastName: results[i].last_name,
                        party: results[i].party_name,
                        website: results[i].website
                    };
                    candidates.push(candidate);
                }
                res.json(candidates);
            }
        });
    }, // end getAllCandidates

    getCandidatesByOffice: (req, res) => {
        db.query(`select c.first_name, c.last_name, c.website, p.party_name
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
                    var candidates = [];
                    for (let i = 0; i < results.length; i++) {
                        let candidate = {
                            firstName: results[i].first_name,
                            lastName: results[i].last_name,
                            party: results[i].party_name,
                            website: results[i].website
                        };
                        candidates.push(candidate);
                    }
                    res.json(candidates);
                }
            })
    }, // end getCandidatesByOffice

    getCandidatesByDistrict: (req, res) => {
        let results = db.query(`
        SELECT c.candidate_id, c.first_name, c.last_name, p.party_name, c.website FROM candidates c
            LEFT JOIN parties p
                ON c.party_id = p.party_id
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
                    var candidates = [];
                    for (let i = 0; i < results.length; i++) {
                        let candidate = {
                            firstName: results[i].first_name,
                            lastName: results[i].last_name,
                            party: results[i].party_name,
                            website: results[i].website
                        };
                        candidates.push(candidate);
                    }
                    res.json(candidates);
                }
            })
    }, // end getCandidatesByDistrict

    getCandidatesByAddress: async (req, res) => {
        let address = req.params.address;
        var payload = 'https://www.googleapis.com/civicinfo/v2/representatives?key='+process.env.CIVIC_KEY+'&address='+address;
            request(payload, (error, response, body) => {
                if (error) {
                    res.send(error);
                }
                else {
                    // console.log(body);
                    body = JSON.parse(body);
                    res.json(body.divisions);
                }
                });


    }, // end getCandidatesByAddress

    getCandidatesAndTheirElections: (req, res) => {
        db.query(`SELECT c.*, e.election_id, e.date, e.type, e.district, e.office_id, e.party_id FROM candidates c
            LEFT JOIN election_candidates ec
                ON c.candidate_id = ec.candidate_id
            LEFT JOIN elections e
                on ec.election_id = e.election_id
            ORDER BY c.last_name`, (err, results) => {
                    if (err) {
                        console.log(err);
                        res.send(err);
                    }
                    else {
                        var candidates = [];
                        for (var i = 0; i < results.length; i++) {
                            candidates[i] = {};
                            candidates[i].candidateID = results[i].candidate_id;
                            candidates[i].firstName = results[i].first_name;
                            candidates[i].lastName = results[i].last_name;
                            candidates[i].party = results[i].party;

                            if (results[i].election_id != null) {
                                candidates[i].election = {};
                                candidates[i].election.electionID = results[i].election_id;
                                candidates[i].election.date = results[i].date;
                                candidates[i].election.type = results[i].type;
                                candidates[i].election.office = results[i].office_id;
                                candidates[i].election.district = results[i].district;
                            }
                        };
                        res.json(candidates);
                    }
                });
    }

}; // end controller object

module.exports = controller;