const express = require('express');
const router = express.Router();

const candidates = require('./candidateRoutes');
const elections = require('./electionRoutes');

router.use('/', (req, res) => {res.redirect('https://github.com/frashure/virginia-elections-api')});
router.use('/candidates', candidates);
router.use('/elections', elections);

module.exports = router;