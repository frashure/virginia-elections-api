const express = require('express');
const router = express.Router();

const candidates = require('./candidateRoutes');
const elections = require('./electionRoutes');

router.use('/candidates', candidates);
router.use('/elections', elections);
router.use('/', (req, res) => {res.redirect('https://github.com/frashure/virginia-elections-api')});

module.exports = router;