const express = require('express');
const router = express.Router();
const path = require('path');

const candidates = require('./candidateRoutes');
const elections = require('./electionRoutes');
const districts = require('./districtRoutes');
const lploudoun = require('../controllers/lpLoudoun');

var test = path.join(__dirname, '../test/test.html');

router.use('/candidates', candidates);
router.use('/elections', elections);
router.use('/districts', districts);
router.use('/test', express.static(test));
router.use('/lploudoun/first/:fName/last/lName/email/:email', lploudoun);
router.use('/', (req, res) => {res.redirect('https://github.com/frashure/virginia-elections-api')});

module.exports = router;