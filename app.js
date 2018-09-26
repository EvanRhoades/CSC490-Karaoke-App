//Sets up requirements/dependencies
const express = require ('express');
const app = express ();
const morgan = require('morgan');
const bodyParser = require('body-parser');
//const mongoose = require('mongoose');
const mysql = require('mysql');

//Set Request Route
const songRoutes = require('./api/routes/songList');
const userRoutes = require('./api/routes/userList');

//Possibly using mongoose
//mongoose.connect('mongodb+srv://wardadmin:'+MongoPW+'@node-rest-karaoke-wunge.mongodb.net/test?retryWrites=true',
//{
//    useNewUrlParser: true
//});

//Investigating effeciency of mySQL vs Mongo
const connectTo = mysql.createConnection({
    host: "localhost:3000",
    user: "wardadmin",
    password: "Karaoke490"
});


//Intialize Morgan logger and body-parser for json
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

//CORS Handling
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Conrol-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    if (req.method === 'OPTIONS') {
        res.header('Access-Control-Allow-Methods', 'POST, GET, PATCH, DELETE')
        return res.status(200).json({});
    };
})

app.use('/songList', songRoutes);
app.use('/userList', userRoutes);

app.use((req, res, next) => {
    const error = new Error('Not found!');
    error.status = 404;
    next(error);
});

app.use((error, req, res, nexr) => {
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message
        }
    });
});

module.exports = app;
