const sequelize = require ('sequelize');
const mySql = require ('mysql');

const user = sequelize.JSON ({
    email: {type: String, required: true},
    password: { type: String, required: true}
});