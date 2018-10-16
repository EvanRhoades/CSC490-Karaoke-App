const Sequelize = require ('sequelize');

const connection = new Sequelize( 'karaokeinstance', 'wardadmin', 'Karaoke490');

const Song = connection.define('songList', {
Title: Sequelize.STRING,
Author: Sequelize.STRING,
dj_id: Sequelize.INTEGER
});

connection.sync();