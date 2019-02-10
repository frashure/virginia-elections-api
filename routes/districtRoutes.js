const express = require('express');
const router = express.Router();
const controller = require('../controllers/districtController');

router.get('/address/:address', controller.getDistricts);

module.exports = router;