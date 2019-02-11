const request = require('request');

var controller = {
    getDistricts: (req, res) => {
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
                    var countryOpenID = '';
                    var stateOpenID = '';
                    var cdOpenID = '';
                    var vahouseOpenID = '';
                    var vasenateOpenID = '';

                     for (let i = 0; i < divisions.length; i++) {
                        if (divisions[i].match(countyPattern) !== null) {
                            countryOpenID = divisions[i];
                            continue;
                        }
                        else if (divisions[i].match(statePattern) !== null) {
                            if (divisions[i].match(vaPattern) !== null) {
                                stateOpenID = divisions[i];
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
                            cdOpenID = divisions[i];
                            continue;
                        }
                        else if (divisions[i].match(housePattern) !== null) {
                            console.log('House pattern matches!');
                            vahouse = divisions[i].match(/ocd-division\/country:us\/state:va\/sldl:(.*)/)[1];
                            vahouseOpenID = divisions[i];
                            continue;
                        }
                        else if (divisions[i].match(senatePattern) !== null) {
                            vasenate = divisions[i].match(/ocd-division\/country:us\/state:va\/sldu:(.*)/)[1];
                            vasenateOpenID = divisions[i];
                        }

                    };
                    if (wrongState) {
                        res.send(wrongState);
                    }
                    else {
                        districts = {
                            "cd": cd,
                            "house": vahouse,
                            "senate": vasenate,
                            "Open Civic Identifiers": {
                                "country": countryOpenID,
                                "state": stateOpenID,
                                "congressional district": cdOpenID,
                                "Virginia Senate": vasenateOpenID,
                                "Virginia House": vahouseOpenID
                            }
                        };
                        
                                res.send(districts);
                        };
                    }
                }); // end request
    } // end getDistricts
} // end controller object

module.exports = controller;