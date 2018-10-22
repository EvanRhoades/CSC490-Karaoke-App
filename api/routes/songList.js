const express = require('express');
const router = express.Router();
const Song = require('../../models/song');
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaoke490', process.env.garbageman, process.env.bird, {
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    port: 3306,
    dialect: 'mysql'
});



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
    
    const song = new Song();

    connection.sync({
        force: true
    })
    .then(function () {
        song.create({
            Artist: req.body.Artist,
            Title: req.body.Title
        })
    })

    res.status(201).json({
        artist: song.body.Artist,
        title: song.body.title
    });

    //res.status(201).json({
    //    dbSong: dbSong
    //});
});

module.exports = router;