const express = require('express');
const router = express.Router();
const controller = require('../controllers/candidatesController');

router.get('/', controller.getAllCandidates);
router.get('/elections', controller.getCandidatesAndTheirElections);
router.get('/address/:address', controller.getCandidatesByAddress);
router.get('/:office', controller.getCandidatesByOffice);
router.get('/:office/:district', controller.getCandidatesByDistrict);

module.exports = router;