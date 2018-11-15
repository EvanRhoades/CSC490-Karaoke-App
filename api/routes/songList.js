//Declaring Middleware to use
const express = require('express');
const router = express.Router();
const Sequelize = require('sequelize');
const connection = new Sequelize( 'karaoke490', process.env.garbageman, process.env.bird, {
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    port: 3306,
    dialect: 'mysql'
});

//const Op = Sequelize.Op;

//Defines Schema for songs
var Song = connection.define('songtest', {
    Artist: {type: Sequelize.STRING, allowNull: false},
    Title: {type: Sequelize.STRING, allowNull: false},
    dj_id: {type: Sequelize.INTEGER, allowNull: false},
    loweredArtist: {type: Sequelize.STRING, allowNull: false},
    loweredTitle: {type: Sequelize.STRING, allowNull: false}
})


/*Handles finding all songs under a DJ's ID and then returns them as a JSON file 
Uses POST instead of GET because it can take parameters in a much more effeceint fashion
@params Int dj_id
@returns Array of JSONs
*/
router.post ('/event', (req, res, next) => {
    if(parseInt(req.body.dj_id) > 0){
        Song.findAll({where: {dj_id: parseInt(req.body.dj_id)}})
        .then( list => {
            res.status(200).json({                
                listing: list
            })
            return list;
        })
    } else {
        res.status(404).json({
            message: "No list exist for this ID"
        })
        
    }
});

/*Sends a Response to the server containing the song from the app.
@params String Artist
@params String Title
@returns JSON
 */
router.post ('/queue', (req, res, next) => {
    res.status(200).json({
        Artist: req.body.Artist,
        Title: req.body.Title
    })
});
/*Handles inserting songs into the DB via POST
Has the songs passed one at a time so it can parse the dj_id
@params String title: 
@params Int artist: dj_id:
@returns HTTP status
*/
router.post ('/', (req, res, next) => {   
    
    connection.sync({
        force: false
    })
    .then(() => {
        Song.create({
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