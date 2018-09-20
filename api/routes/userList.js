const express = require('express');
const router = express.Router();

router.get ('/', (req, res, next) => {
    const user = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        email: req.body.email
    };

    res.status(200).json({
        userName: user.email
    });
});

router.post ('/', (req, res, next) => {
    res.status(201).json({
        message: 'Test adding user function'
    });
});

router.get ('/:name', (req, res, next) =>{
    const firstName = req.body.firstName;
    const lastName = req.body.lastName;
    res.status(200).json({
        firstName: firstName,
        lastName: lastName
    });
});

module.exports = router;