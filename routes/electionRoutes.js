const express = require('express');
const router = express.Router();
const controller = require('../controllers/electionsController');

router.get('/', controller.getAllElections);
router.get('/candidates', controller.getAllElectionsCandidates);
router.get('/office/:office', controller.getElectionsByOffice);
router.get('/office/:office/district/:district', controller.getElectionsByDistrict);
router.get('/year/:year', controller.getElectionsByYear);

/*
    TODO: get elections by congressional district,
    need to pass params through Google Civic Info API,
    parse OCID for finding districts attached to address
*/

module.exports = router;