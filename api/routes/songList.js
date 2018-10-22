const express = require('express');
const router = express.Router();
//const Song = require('../../models/song');
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaoke490', process.env.garbageman, process.env.bird, {
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    port: 3306,
    dialect: 'mysql'
});

var Song = connection.define('songtest', {
    Artist: {type: Sequelize.STRING, allowNull: false},
    Title: {type: Sequelize.STRING, allowNull: false},
    dj_id: {type: Sequelize.INTEGER, allowNull: false}
})


//Handles GET request
router.get ('/', (req, res, next) => {
    
    res.status(200).json({
        message: 'Test song title'
    });
});

//Handles POST request
router.post ('/', (req, res, next) => {
    /*const dbSong = {
        Artist: req.body.Artist,
        Title: req.body.Title
    };*/
    
    
    connection.sync({
        force: false
    })
    .then(() => {
        Song.create({
            Artist: req.body.Artist,
            Title: req.body.Title,
            dj_id: parseInt(req.body.dj_id)        
        })
    })

    res.status(201).json({
        artist: req.body.Artist,
        title: req.body.Title
    });

    //res.status(201).json({
    //    dbSong: dbSong
    //});
});

module.exports = router;