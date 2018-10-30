const express = require('express');
const router = express.Router();
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaoke490', process.env.garbageman, process.env.bird, {
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    port: 3306,
    dialect: 'mysql'
});

const Op = Sequelize.Op;
var Song = connection.define('songtest', {
    Artist: {type: Sequelize.STRING, allowNull: false},
    Title: {type: Sequelize.STRING, allowNull: false},
    dj_id: {type: Sequelize.INTEGER, allowNull: false},
    loweredArtist: {type: Sequelize.STRING, allowNull: false},
    loweredTitle: {type: Sequelize.STRING, allowNull: false}
})


//Handles GET request
router.get ('/:artistSearch', (req, res, next) => {
    const keyA = req.param.artistSearch;
    
    var songs = Song.findAll({
        where: {
            loweredArtist: {
                [Op.like]: '%'+ keyA +'%'
            }
        }
    }).toJSON();


    res.status(200).json({
        message: songs 
    });
});

//Handles POST request
router.post ('/', (req, res, next) => {
    
    
    connection.sync({
        force: false
    })
    .then(() => {
        Song.bulkCreate({
            Artist: req.body.Artist,
            Title: req.body.Title,
            dj_id: parseInt(req.body.dj_id),
            loweredArtist: req.body.Artist.toLowerCase(),
            loweredTitle: req.body.Title.toLowerCase()        
        })
    })

    res.status(201).json({
        artist: req.body.Artist,
        title: req.body.Title
    });
    
});

module.exports = router;