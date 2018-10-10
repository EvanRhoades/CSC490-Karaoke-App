const express = require('express');
const router = express.Router();
const bcrypt = require ('bcryptjs');

const User = require ('../modeling/users');


router.post ('/signup', (req, res, next) => {
    bcrypt.hash(req.body.password, 100, (err, hash) =>{
        if (err) {
            return res.status(500).json({
                error: err
            });
        } else {
            const user = new User ({
                email: req.body.email ,
                password: hash
            });
            user
            .save()
            .then (result => {
                console.log(result);
                res.status(201).json({
                    message: 'User Created'
                });
            })
            .catch( err => {
                console.log(err);
                res.status(500).json({
                    error: err
                });
            });
        }
    });
    
});

module.exports = router;