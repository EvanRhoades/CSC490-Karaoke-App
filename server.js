//This node sets up Server use and ports
const http = require ('http');
const app = require ('./app');
const express = require('express');
const handler = express ();

//handler.use(express.static('CSC490Website/public_html'));


const port = process.env.port || 3000;

const server = http.createServer(app);

server.listen (port);