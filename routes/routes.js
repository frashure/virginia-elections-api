const express = require('express');
const router = express.Router();
const path = require('path');

const candidates = require('./candidateRoutes');
const elections = require('./electionRoutes');
const districts = require('./districtRoutes');

var test = path.join(__dirname, '../test/test.html');

// var whitelist = ['127.0.0.1:8080']
// var corsOptions = {
//   origin: function (origin, callback) {
//     if (whitelist.indexOf(origin) !== -1) {
//       callback(null, true)
//     } else {
//       callback(new Error('Not allowed by CORS'))
//     }
//   }
// }

router.use('/candidates', candidates);
router.use('/elections', elections);
router.use('/districts', districts);
router.use('/test', express.static(test));
router.use('/', (req, res) => {res.redirect('https://github.com/frashure/virginia-elections-api')});

function checkKey(req, res, next) {
    if (req.body.key === process.env.KEY) {
        next()
    }
    else {
        res.send(403)
    }
}

module.exports = router;