const express = require('express');
const router = express.Router();

const candidates = require('./candidateRoutes');
const elections = require('./electionRoutes');

router.use('/candidates', candidates);
router.use('/elections', elections);

module.exports = router;