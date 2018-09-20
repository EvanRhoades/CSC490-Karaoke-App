const mongoose = require('mongoose');

const userSchema = mongoose.Schema ({
    firstName: String,
    lastName: String,
    email: String,
    //Password: String
})

module.exports = mongoose.model('User', userSchema);