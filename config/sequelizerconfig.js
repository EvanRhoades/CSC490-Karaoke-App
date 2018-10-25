const fs = require('fs');

module.exports = {
  development: {
    username: process.env.garbageman,
    password: process.env.bird,
    database: 'karaoke490',
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    dialect: 'mysql'
    
  },
  test: {
    username: process.env.garbageman,
    password: process.env.bird,
    database: 'karaoke490',
    host: 'karaokeinstance.czurquwpnxuq.us-east-1.rds.amazonaws.com',
    dialect: 'mysql'
  }
}