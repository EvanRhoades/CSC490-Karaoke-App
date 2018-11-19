//Declaring Middleware to use
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaoke490', process.env.garbageman, process.env.bird, {
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    port: 3306,
    dialect: 'mysql'
});

//Defines Schema for User
var User = connection.define ('testMembership', {
    email: {type: Sequelize.STRING, allowNull: false, primaryKey: true},
    username: {type: Sequelize.STRING, allowNull: false},
    firstName: {type: Sequelize.STRING, allowNull: false},
    lastName: {type: Sequelize.STRING, allowNull: false},
    password: {type: Sequelize.STRING, allowNull: false},
    dj_id: {type: Sequelize.STRING, allowNull: false, defaultValue: 0},
    
});

/*
Handles Login requests for Users.
Uses POST request instead of GET so we can take JSON file as a parameter
uses bcryptjs middleware to check hashed passwords
@params JSON email: password:
@returns JSON and HTTP status on true
@return 0 and HTTP status on false
*/
router.post ('/login', (req, res, next) => {
    
    if (User.findOne({where: {email: req.body.email}})){
        User.findOne({where: {email: req.body.email}})
        .then ( user => {
            if (bcrypt.compare(req.body.password, user.password)){                
                res.status(200).json({
                    //message: "Login Successful",
                    djId: user.dj_id                
                })
            } else {                
                res.status(500).json({
                    message: "Invalid Password"                                      
                })               
            }
        })
    } else {        
        res.status(500).json({
            message: "Invalid email"
        })
        
    }
});

/*
POST New Users into the DB.
uses bcryptjs to hash and salt passwords before putting them into DB
@params JSON email: firstName: lastName: password: dj_id:
@returns HTTP status
*/
router.post ('/', (req, res, next) => {
    var salt = bcrypt.genSaltSync(10);
    var hash = bcrypt.hashSync(req.body.password, salt);

    connection.sync({
        force: false
    })
    .then(() => {        
        User.create({
            email: req.body.email,
            username: req.body.username,
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            password: hash,
            //dj_id: 0
                
        })
    })

    res.status(201).json({
        message: "User successfully created"
    })

});

/*GET rout to send the greates DJ ID to web page so that it can send an incremented dj ID for new
 */
router.get ('/max', (req, res, next) => {

    connection.sync({
        force: false
    })
    .then(() =>{
        User.max('dj_id')
        .then( max => {
            res.status(200).json({
                message: max
            })
        })
    })

})

/*Creates a DJ with an auto-incremented ID that is returned
 */
router.post ('/dj', (req, res, next) => {
    var salt = bcrypt.genSaltSync(10);
    var hash = bcrypt.hashSync(req.body.password, salt);
    
    User.max('dj_id')

    connection.sync({
        force: false
    })
    .then(() => {        
        User.create({
            email: req.body.email,
            username: req.body.username,
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            password: hash,
            dj_id: parseInt(req.body.dj_id ),                
        })
        res.status(201)
    })
 
});

module.exports = router;