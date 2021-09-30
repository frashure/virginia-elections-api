const express = require('express');
const router = express.Router();
const controller = require('../controllers/electionsController');

router.get('/', controller.getAllElections);
router.get('/address', controller.getElectionsCandidatesByAddress);
router.get('/office', controller.getElectionsByOffice);
router.get('/office/district', controller.getElectionsByDistrict);
router.get('/year', controller.getElectionsByYear);
router.get('/candidates', controller.getAllElectionsCandidates);
router.get('/candidates/address', controller.getElectionsCandidatesByAddress);
router.get('/candidates/office/', controller.getCandidatesByOffice);
router.get('/candidates/office/district/', controller.getCandidatesByDistrict);

module.exports = router;