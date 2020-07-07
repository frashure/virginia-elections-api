const db = require('../models/db');
const request = require('request');

const controller = {

    checkKey: (req, res, next) => {
        if (req.body.key === process.env.KEY) {
            return next()
        }
        else {
            res.send(403)
        }
    },

    signup: (req, res) => {
        db.query(`INSERT INTO lplc (firstName, lastName, email, resident, signupDate) VALUES (?, ?, ?, ?, now())`, [req.body.fName, req.body.lName, req.body.email, req.body.resident], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                // res.set('Access-Control-Allow-Origin', '*');
                // res.status(200);
                // let resBody = {
                //     "resCode": 2000
                // };
                res.status(200).send();
                }
        });
    },

    list: (req, res) => {
        db.query('SELECT * FROM lplc', (err, results) => {
            var members = [];
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                for (let i = 1; i < results.length; i++) {
                    person = {
                        firstName: results[i].firstName,
                        lastName: results[i].lastName,
                        email: results[i].email,
                        resident: results[i].resident,
                        date: results[i].signupDate
                    }
                    members.push(person);
                }
            }
            res.json(members);
            });

    }

}

module.exports = controller;