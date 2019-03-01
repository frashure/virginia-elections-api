const express = require('express');
const router = express.Router();
const controller = require('../controllers/electionsController');

router.get('/', controller.getAllElections);
router.get('/address/:address', controller.getElectionsCandidatesByAddress);
router.get('/office/:office', controller.getElectionsByOffice);
router.get('/office/:office/district/:district', controller.getElectionsByDistrict);
router.get('/year/:year', controller.getElectionsByYear);
router.get('/candidates', controller.getAllElectionsCandidates);
router.get('/candidates/office/:office', controller.getCandidatesByOffice);
router.get('/candidates/office/:office/district/:district', controller.getCandidatesByDistrict);

module.exports = router;