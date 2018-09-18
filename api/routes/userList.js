const express = require('express');
const router = express.Router();

router.get ('/', (req, res, next) => {
    const email = req.body.email;
    res.status(200).json({
        email: email
    });
});

router.post ('/', (req, res, next) => {
    res.status(201).json({
        message: 'Test adding user function'
    });
});

module.exports = router;