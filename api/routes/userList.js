const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

const User = require('../modeling/user')

router.get ('/', (req, res, next) => {
    const user = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        email: req.body.email
    };

    User.findById(user.email)
    .exec()
    .then(doc => {
        console.log(doc);
        res.status(200).json({doc});
    }).catch (err => {
        console.log(err);
        res.status(500).json({error: err});
    })
   
    res.status(200).json({
        userName: user.email
    });
});

router.post ('/', (req, res, next) => {
    const user = new User ({
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        email: req.body.email
    });

    user.save().then(result => {
        console.log(result);
    }).catch(err => console.log(err));

    res.status(201).json({
        message: 'Test adding user function'
    });
});

router.get ('/:name', (req, res, next) =>{
    const user = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        email: req.body.email
    };
    res.status(200).json({
        firstName: firstName,
        lastName: lastName
    });
});

module.exports = router;