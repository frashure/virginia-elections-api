const db =  require('../models/db');
const request = require('request');

var controller = {

    getAllElections: (req, res) => {
        db.query(`SELECT e.*, p.party_name FROM elections e
        LEFT JOIN parties p
        ON e.party_id = p.party_id
        LEFT JOIN election_results er
        ON e.election_id = 
        ORDER BY office_id, district`, (err, results) => {
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
        db.query(`SELECT e.*, c.*, ec.election_id AS candidate_election, p.party_name, er.num_votes, er.winner
        FROM elections e
        LEFT JOIN election_candidates ec
            ON e.election_id = ec.election_id
        LEFT JOIN candidates c 
            ON ec.candidate_id = c.candidate_id
        LEFT JOIN parties p
            ON c.party_id = p.party_id
        LEFT JOIN election_results er
            ON c.candidate_id = er.candidate_id
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

                            // need to account for write in votes; requires rewriting sql select
                            if (results[i].num_votes != null) {
                                if (!("results" in elections[k])) {
                                    elections[k].results = [];
                                }

                                let winner;

                                switch (results[i].winner) {
                                    case 0: winner = 'no'
                                    break;
                                    case 1: winner = 'yes'
                                    break;
                                }

                                let candidateResult = {
                                    candidate: results[i].first_name + ' ' + results[i].last_name,
                                    votes: results[i].num_votes,
                                    winner: winner
                                }
                                elections[k].results.push(candidateResult);
                            }

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
        db.query(`SELECT e.*, c.*, ec.election_id AS candidate_election, p.party_name, er.num_votes, er.winner
        FROM elections e
        LEFT JOIN election_candidates ec
            ON e.election_id = ec.election_id
        LEFT JOIN candidates c 
            ON ec.candidate_id = c.candidate_id
        LEFT JOIN parties p
            ON c.party_id = p.party_id
        LEFT JOIN election_results er
            ON c.candidate_id = er.candidate_id
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

                        if (!("results" in elections[k])) {
                            elections[k].results = [];
                        }
                        
                        let winner;
                        
                        switch (results[i].winner) {
                            case 1: winner = 'yes';
                            break;
                            case 0: winner = 'no';
                            break;
                        }

                        let candidateResults = {
                            candidate: results[i].first_name + ' ' + results[i].last_name,
                            party: results[i].party_name,
                            votes: results[i].num_votes,
                            winner: winner
                        };

                        elections[k].results.push(candidateResults);
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
        db.query(`SELECT e.*, c.*, ec.election_id AS candidate_election, p.party_name, er.num_votes, er.winner
        FROM elections e
        LEFT JOIN election_candidates ec
            ON e.election_id = ec.election_id
        LEFT JOIN candidates c 
            ON ec.candidate_id = c.candidate_id
        LEFT JOIN parties p
            ON c.party_id = p.party_id
        LEFT JOIN election_results er
            ON c.candidate_id = er.candidate_id
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

                        if (!("results" in elections[k])) {
                            elections[k].results = [];
                        }

                        let winner;

                        switch (results[i].winner) {
                            case 0: winner = 'no';
                            break;
                            case 1: winner = 'yes';
                            break;
                        }

                        let candidateResult = {
                            candidate: results[i].first_name + ' ' + results[i].last_name,
                            party: results[i].party_name,
                            votes: results[i].num_votes,
                            winner: winner
                        }

                        elections[k].results.push(candidateResult);

                    }
                }
                elections.sort((a, b) => {
                    return a.district - b.district;
                });
                res.send(elections);
            }
        })
    }, // end getCandidatesByDistrict

    getElectionsCandidatesByAddress: (req, res) => {
        let address = req.params.address;
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
                        db.query(`SELECT e.*, c.*, ec.election_id AS candidate_election, p.party_name
                        FROM elections e
                        LEFT JOIN election_candidates ec
                            ON e.election_id = ec.election_id
                        LEFT JOIN candidates c 
                            ON ec.candidate_id = c.candidate_id
                        LEFT JOIN parties p
                            ON c.party_id = p.party_id
                        WHERE YEAR(date) = 2019
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
                        ORDER BY e.election_id`, [districts.cd, districts.house, districts.senate], (err, results) => {
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

                                        if (!("results" in elections[k])) {
                                            elections[k].results = [];
                                        }

                                        let winner;

                                        switch (results[k].winner) {
                                            case 0: winner = 'no';
                                            break;
                                            case 1: winner = 'yes';
                                            break;
                                        }

                                        let candidateResult = {
                                            candidate: results[k].first_name + ' ' + results[k].last_name,
                                            party: results[k].party_name,
                                            votes: result[k].num_votes,
                                            winner: winner
                                        }

                                        elections[k].results.push(candidateResult);        
                                    }
                                }
                                elections.sort((a, b) => {
                                    return a.district - b.district;
                                });
                                res.send(elections);
                            }
                        });
                    }
                    
                }
                });


    }, // end getElectionsCandidatesByAddress

    // getNextElection: select and order by election date,
    // loop as long as election date is equal to row[0].date,
    // otherwise break the loop, send results

    // getNextElectionCandidates

}; // end controller object

module.exports = controller;