const mongoose = require('mongoose');

const songSchema = mongoose.Schema({
    Artist: { type: String, required: true },
    Song: { type: String, required: true },
    Album: { type: String, required: true }
});

module.exports = mongoose.model('Songs', songSchema);