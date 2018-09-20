const mongoose = require('mongoose');

const songSchema = mongoose.Schema({
    Artist: String,
    Song: String,
    Album: String
});

module.exports = mongoose.model('Songs', songSchema);