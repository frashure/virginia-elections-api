const db =  require('../models/db');
const request = require('request');

buildElections = (results) => {
    let j = 0;
    var elections = [];
    var primaries = [];

    for (let i = 0; i < results.length; i++) {
        if (results[i].type == 'primary') {

        // if true here, we have already created this primary, need to add the next candidate and result (if exists)
        if (results[i-1] != null && results[i].election_id == results[i-1].election_id) {
            let k = primaries.findIndex(x => x.electionID == results[i].election_id);
                let candidate = {
                    firstName: results[i].first_name,
                    lastName: results[i].last_name,
                    // website: results[i].website
                }
                
                primaries[k].candidates.push(candidate);

                if (results[i].num_votes != null) {
                    let winner;

                    switch (results[i].winner) {
                        case 0: winner = 'no';
                        break;
                        case 1: winner = 'yes';
                        break;
                    }

                    let result = {
                        candidate: results[i].first_name + ' ' + results[i].last_name,
                        numVotes: results[i].num_votes,
                        winner: winner
                    }

                    primaries[k].results.push(result);

                }
                continue;

        }
        // else here means we haven't yet created this primary, need to do so and add first candidate
        else {
            let primary = {
                electionID: results[i].election_id,
                generalID: results[i].primary_for,
                date: results[i].date,
                party: results[i].party_name
            };
            // since this is the first record of the specific election, will need to create the candidate array, add fist candidate;
            // we will also need to check for for election results, create array if necessary
            if (results[i].candidate_id != null) {
                primary.candidates = [];

                let firstCandidate = {
                    firstName: results[i].first_name,
                    lastName: results[i].last_name,
                    website: results[i].website
                }

                primary.candidates.push(firstCandidate);
            }

            if (results[i].num_votes != null) {
                primary.results = [];

                let winner;

                switch (results[i].winner) {
                    case 1: winner = 'yes';
                    break;
                    case 0: winner = 'no';
                    break;
                }

                let firstResult = {
                    candidate: results[i].first_name + ' ' + results[i].last_name,
                    numVotes: results[i].num_votes,
                    winner: winner
                }

                primary.results.push(firstResult);
                
            }

            primaries.push(primary);
            continue;
        }

    } // end primaries creation
        
    // check to see if election has already been created; if so, check for candidates attribute, and add candidate if it exists
    // also need to check for results
    else if (results[i-1] != null && results[i].election_id == results[i-1].election_id) {
        if (results[i].candidate_id != null) {
            let k = elections.findIndex(x => x.electionID == results[i].election_id);

            let candidate = {
                firstName: results[i].first_name,
                lastName: results[i].last_name,
                party: results[i].party_name,
                website: results[i].website
            }

            elections[k].candidates.push(candidate);

            if (results[i].num_votes != null) {

                let winner;

                switch(results[i].winner) {
                    case 0: winner = 'no';
                    break;
                    case 1: winner = 'yes';
                    break;
                }

                let result = {
                    candidate: results[i].first_name + ' ' + results[i].last_name,
                    party: results[i].party_name,
                    numVotes: results[i].num_votes,
                    winner: winner
                };

                elections[k].results.push(result);

            }

        }
        continue;        
    }

        // if we make it this far, the general/special election has not been created, we do so here;
        // also add candidates and results arrays to object if necessary
        elections[j] = {};
        elections[j].electionID = results[i].election_id;
        elections[j].date = results[i].date;
        elections[j].type = results[i].type;
        elections[j].office = results[i].office_id;
        if (results[i].district != null) {
            elections[j].district = results[i].district;
        }
        if (results[i].candidate_id != null) {
            elections[j].candidates = [];

            let firstCandidate = {
                firstName: results[i].first_name,
                lastName: results[i].last_name,
                party: results[i].party_name,
                website: results[i].website
            }

            elections[j].candidates.push(firstCandidate);

            let winner;

            switch(results[i].winner) {
                case 0: winner = 'no';
                break;
                case 1: winner = 'yes';
                break;
            }

            if (results[i].num_votes != null) {
                let firstResult = {
                candidate: firstCandidate.firstName + ' ' + firstCandidate.lastName,
                party: results[i].party_name,
                numVotes: results[i].num_votes,
                winner: winner
                }
                elections[j].results = [];
                elections[j].results.push(firstResult)
            }


        }


        j++
    }

    // attach primary objects to respective general election object
    primaries.forEach((p) => {
        let k = elections.findIndex(x => x.electionID == p.generalID);
        if (!("nominations" in elections[k])) {
            elections[k].nominations = [];
        }
        elections[k].nominations.push(p);
    });


    elections.sort((a, b) => {
        return a.district - b.district;
    });

    return elections;
} // end buildElections function


// controller object
var controller = {

    getAllElections: (req, res) => {
        db.query(`SELECT e.*, p.party_name
        FROM elections e
        LEFT JOIN parties p
            ON e.party_id = p.party_id
        LEFT JOIN election_results er
            ON e.election_id = er.election_id
        ORDER BY election_id`, (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                let elections = buildElections(results);
                res.json(elections);
            }
        })
    }, // end getAllElections

    getElectionsByOffice: (req, res) => {
        db.query(`SELECT *
        FROM elections e
         LEFT JOIN parties p
                ON e.party_id = p.party_id
        WHERE office_id = ?
        ORDER BY election_id`, [req.params.office], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                let elections = buildElections(results);
                res.json(elections);
            }
        })
    }, // end getElectionsByOffice

    getElectionsByYear: (req, res) => {
        db.query(`SELECT *
        FROM elections e
            LEFT JOIN parties p
                ON e.party_id = p.party_id
        WHERE year(date) = ?
        ORDER BY election_id`, [req.params.year], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                let elections = buildElections(results);
                res.json(elections);
            }
        })
    }, // end getElectionsByYear

    getElectionsByDistrict: (req, res) => {
        db.query(`SELECT *
            FROM elections e
                LEFT JOIN parties p
                    ON e.party_id = p.party_id
            WHERE office_id = ? 
            AND district = ?`, [req.params.office, req.params.district], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                let elections = buildElections(results);
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
        ORDER BY e.election_id`, (err, results) => {
                if (err) {
                    console.log(err);
                    res.send(err);
                }
                else {
                    let elections = buildElections(results);
                    res.json(elections);
                } // end main else
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
        ORDER BY e.election_id`, [req.params.office], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                let elections = buildElections(results);
                res.json(elections);
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
        ORDER BY e.election_id`, [req.params.office, req.params.district], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                let elections = buildElections(results);
                res.json(elections);
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
                                let elections = buildElections(results);
                                res.json(elections);
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