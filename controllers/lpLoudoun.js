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
    },

    list: (req, res) => {
        db.query('SELECT * FROM lplc');
        var members = [];
        if (err) {
            console.log(err);
            res.send(err);
        }
        else {
            for (let i = 1; i < res.length; i++) {
                person = {
                    firstName: res.firstName,
                    lastName: res.lastName,
                    email: res.email,
                    resident: res.resident,
                    date: res.signupDate
                }
                members.push(person);
            }
        }
        res.json(members);
    }

}

module.exports = controller;