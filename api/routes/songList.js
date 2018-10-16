const express = require('express');
const router = express.Router();
const Song = require('../modeling/songs');
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaokeinstance', process.env.garbageman, process.env.bird);


//Handles GET request
router.get ('/', (req, res, next) => {
    const song = new Song ();

    song.connection.sync().then( function () {
        Song.findAll().then( function (song) {
            res.status(200).json({
               Artist: req.body.Author,
               Title: req.body.Title
                
            })
        })
    })

    /*res.status(200).json({
        message: 'Test song title'
    });*/
});

//Handles POST request
router.post ('/', (req, res, next) => {
    const song = new Song();
    

    /*res.status(201).json({
        message: 'Test adding songs function'
    });*/
});

module.exports = router;