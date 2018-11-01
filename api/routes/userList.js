const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaoke490', process.env.garbageman, process.env.bird, {
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    port: 3306,
    dialect: 'mysql'
});

//object for Schema
var User = connection.define ('testMembership', {
    email: {type: Sequelize.STRING, allowNull: false, primaryKey: true},
    firstName: {type: Sequelize.STRING, allowNull: false},
    lastName: {type: Sequelize.STRING, allowNull: false},
    password: {type: Sequelize.STRING, allowNull: false},
    dj_id: {type: Sequelize.STRING, allowNull: true}
});

//Handles GET requests
router.get ('/', (req, res, next) => {

});

//Handles POST request
router.post ('/', (req, res, next) => {
    var salt = bcrypt.genSaltSync(10);
    var hash = bcrypt.hashSync(req.body.password, salt);


    connection.sync({
        force: false
    })
    .then(() => {        
        User.create({
            email: req.body.email,
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            password: hash,
            dj_id: parseInt(req.body.dj_id )     
        })
    })

    res.status(201).json({
        message: "User successfully created"
    })

});

//Handle GET with a sub-URL
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