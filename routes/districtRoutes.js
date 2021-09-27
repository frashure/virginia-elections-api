const express = require('express');
const router = express.Router();
const controller = require('../controllers/districtController');

router.get('/address', controller.getDistricts);

module.exports = router;