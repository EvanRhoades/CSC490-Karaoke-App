const Sequelize = require ('sequelize');

const connection = new Sequelize( 'karaokeinstance', process.env.garbageman, process.env.bird);

const Song = connection.define('songList', {
Title: Sequelize.STRING,
Author: Sequelize.STRING,
dj_id: Sequelize.INTEGER
});

connection.sync();