const express = require('express');
const router = express.Router();

//Handles GET request
router.get ('/', (req, res, next) => {
    res.status(200).json({
        message: 'Test song title'
    });
});

//Handles POST request
router.post ('/', (req, res, next) => {
    res.status(201).json({
        message: 'Test adding songs function'
    });
});

module.exports = router;