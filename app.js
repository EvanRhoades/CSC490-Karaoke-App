const express = require ('express');
const app = express ();

const songRoutes = require ('./api/routes/songList');

app.use('/songList', songRoutes);

module.exports = app;
