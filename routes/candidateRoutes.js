const express = require('express');
const router = express.Router();
const controller = require('../controllers/candidatesController');

router.get('/', controller.getAllCandidates);

module.exports = router;