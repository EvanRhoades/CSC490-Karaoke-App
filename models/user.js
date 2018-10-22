'use strict';
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define('user', {
    email: DataTypes.STRING,
    userId: DataTypes.INTEGER,
    firstName: DataTypes.STRING,
    lastName: DataTypes.STRING,
    dj_id: DataTypes.INTEGER
  }, {});
  User.associate = function(models) {
    // associations can be defined here
  };
  return User;
};