const db =  require('../models/db');

var controller = {

    getAllElections: (req, res) => {
        var results = db.query('SELECT *, DATE(date) FROM elections', (err, results) => {
            if (err) {
                console.log(err);
                res.send(err);
            }
            else {
                res.json(results);
            }
        })
    } // end getAllElecctions

}; // end controller object

module.exports = controller;