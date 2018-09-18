const express = require('express');
const router = express.Router();

router.get ('/', (req, res, next) => {
    res.status(200).json({
        message: 'Test song title'
    });
});

router.post ('/', (req, res, next) => {
    res.status(201).json({
        message: 'Test adding songs function'
    });
});

module.exports = router;