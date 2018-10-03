const http = require ('http');

const port = process.env.port || 3000;

const server = http.createServer(app);

server.listen (port);