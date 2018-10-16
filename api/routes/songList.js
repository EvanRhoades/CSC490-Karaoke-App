const express = require('express');
const router = express.Router();
//const Song = require('../modeling/songs');
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaoke490', process.env.garbageman, process.env.bird, {
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    port: 3306,
    dialect: 'mysql'
});

const Song = connection.define('songList', {
    Title: Sequelize.STRING,
    Artist: Sequelize.STRING,
    dj_id: Sequelize.INTEGER
    });

//Handles GET request
router.get ('/', (req, res, next) => {
    res.status(200).json({
        message: 'Test song title'
    });
});

//Handles POST request
router.post ('/', (req, res, next) => {
    const dbSong = {
        Artist: req.body.Artist,
        Title: req.body.Title
    };
    /*
    connection.sync().then(() => Song.create({
        Artist: req.body.Artist,
        title: req.body.Title
    }))
    .then( name => {
        console.log(name.toJSON());
    });
    */

    res.status(201).json({
        dbSong: dbSong
    });
});

module.exports = router;