'use strict';
module.exports = (sequelize, DataTypes) => {
  const Song = sequelize.define('song', {
    Artist: DataTypes.STRING,
    Title: DataTypes.STRING,
    dj_id: DataTypes.INTEGER
  }, {});
  Song.associate = function(models) {
    // associations can be defined here
  };
  return Song;
};