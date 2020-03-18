const db = require('../models/db');
const request = require('request');

const controller = {

    signup: (req, res) => {
        var date = 
        db.query(`INSERT INTO LPLC VALUES ?, ?, ?, now()`, [req.params.fName, req.params.lName, req.params.email], (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.send(200)
                }
        });
    }

}

module.exports = controller;