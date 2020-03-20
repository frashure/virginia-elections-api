const db = require('../models/db');
const request = require('request');

const controller = {

    signup: (req, res) => {
        db.query(`INSERT INTO lplc (firstName, lastName, email, resident, signupDate) VALUES (?, ?, ?, ?, now())`, [req.body.fName, req.body.lName, req.body.email, req.body.resident], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.set('Access-Control-Allow-Origin', '*');
                res.status(200);
                let resBody = {
                    "resCode": 2000
                };
                res.send(resBody);
                }
        });
    }

}

module.exports = controller;