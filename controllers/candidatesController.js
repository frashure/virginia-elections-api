const db = require('../models/db');
const request = require('request');

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
            where office_id = ?
            ORDER BY district)`, [req.body.office], (err, results) => {
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
        db.query(`
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
            ))`, [req.body.office, req.body.district], (err, results) => {
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

    getCandidatesByAddress: (req, res) => {
        let address = req.body.address;
        var payload = 'https://www.googleapis.com/civicinfo/v2/representatives?key='+process.env.CIVIC_KEY+'&address='+address;
            request(payload, (error, response, body) => {
                body = JSON.parse(body);
                if (error) {
                    res.send(error);
                }
                else if (body.error) {
                    console.log(body.error.errors)
                    res.send(body.error);
                }
                else if (!body.error) {
                    let divisions = Object.keys(body.divisions);

                    var countyPattern = /ocd-division\/country:us$/
                    var statePattern = /ocd-division\/country:us\/state:(\D{2}$)/;
                    var vaPattern = /ocd-division\/country:us\/state:va$/;
                    var cdPattern = /ocd-division\/country:us\/state:va\/cd:/;
                    var housePattern = /ocd-division\/country:us\/state:va\/sldl:/;
                    var senatePattern = /ocd-division\/country:us\/state:va\/sldu:/;

                    var cd = '';
                    var vahouse = '';
                    var vasenate = '';

                     for (let i = 0; i < divisions.length; i++) {
                        if (divisions[i].match(countyPattern) !== null) {
                            continue;
                        }
                        else if (divisions[i].match(statePattern) !== null) {
                            if (divisions[i].match(vaPattern) !== null) {
                                continue;
                            }
                            else {
                                console.log('Wrong state');
                                var wrongState = 'Please enter an address in Virginia';
                                break;
                            }
                        }
                        else if (divisions[i].match(cdPattern) !== null) {
                            console.log('CD pattern matches!');
                            cd = divisions[i].match(/ocd-division\/country:us\/state:va\/cd:(.*)/)[1];
                            continue;
                        }
                        else if (divisions[i].match(housePattern) !== null) {
                            console.log('House pattern matches!');
                            vahouse = divisions[i].match(/ocd-division\/country:us\/state:va\/sldl:(.*)/)[1];
                            continue;
                        }
                        else if (divisions[i].match(senatePattern) !== null) {
                            vasenate = divisions[i].match(/ocd-division\/country:us\/state:va\/sldu:(.*)/)[1];
                        }

                    };
                    if (wrongState) {
                        res.send(wrongState);
                    }
                    else {
                        districts = {
                            "cd": cd,
                            "house": vahouse,
                            "senate": vasenate
                        };
                        db.query(`SELECT c.*, p.party_name, e.election_id, e.date, e.type, e.district, e.office_id, e.party_id FROM candidates c
                        LEFT JOIN election_candidates ec
                            ON c.candidate_id = ec.candidate_id
                        LEFT JOIN elections e
                            on ec.election_id = e.election_id
                        LEFT JOIN parties p
                            on c.party_id = p.party_id
                        WHERE
                            YEAR(date) = 2019
                        AND (
                            (office_id = 'president')
                        OR
                            (office_id = 'ussenate')
                        OR
                            (office_id = 'ushouse' AND district = ?)
                        OR
                            (office_id = 'vahouse' AND district = ?)
                        OR 
                            (office_id = 'vasenate' AND district = ?))
                        ORDER BY c.last_name`, [districts.cd, districts.house, districts.senate], (err, results) => {
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
                                    candidates[i].party = results[i].party_name;
        
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
                    
                }
                });


    }, // end getCandidatesByAddress

    getCandidatesAndTheirElections: (req, res) => {
        db.query(`SELECT c.*, p.party_name, e.election_id, e.date, e.type, e.district, e.office_id, e.party_id FROM candidates c
            LEFT JOIN election_candidates ec
                ON c.candidate_id = ec.candidate_id
            LEFT JOIN elections e
                ON ec.election_id = e.election_id
            LEFT JOIN parties p
                ON c.candidate_id = p.party_id
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
                            candidates[i].party = results[i].party_name;

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