const express = require('express');
const router = express.Router();
const controller = require('../controllers/candidatesController');


router.get('/address/:address', controller.getCandidatesByAddress);
router.get('/', controller.getAllCandidates);
router.get('/:office', controller.getCandidatesByOffice);
router.get('/:office/:district', controller.getCandidatesByDistrict);

/*
    TODO: get candidates by congressional district,
    need to pass params through Google Civic Info API,
    parse OCID for finding districts attached to address
*/

module.exports = router;