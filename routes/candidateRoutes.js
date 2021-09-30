const express = require('express');
const router = express.Router();
const controller = require('../controllers/candidatesController');

router.get('/', controller.getAllCandidates); // need to remove * from select, tidy up return data
router.get('/elections', controller.getCandidatesAndTheirElections); // should be done
router.get('/address', controller.getCandidatesByAddress); // need to parse district information to use in SQL select
router.get('/office', controller.getCandidatesByOffice);
router.get('/office/district', controller.getCandidatesByDistrict); // TODO: append elections to candidate object; check for multiple districts

module.exports = router;