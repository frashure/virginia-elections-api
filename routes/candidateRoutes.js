const express = require('express');
const router = express.Router();
const controller = require('../controllers/candidatesController');

router.get('/', controller.getAllCandidates);
router.get('/:office', controller.getCandidatesByOffice);

/*
    TODO: get candidates by congressional district,
    need to pass params through Google Civic Info API,
    parse OCID for finding districts attached to address
*/

module.exports = router;