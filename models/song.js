'use strict';
module.exports = (sequelize, DataTypes) => {
  const Song = sequelize.define('Song', {
    Artist: DataTypes.STRING,
    Title: DataTypes.STRING,
    dj_id: DataTypes.INTEGER
  }, {});
  Song.associate = function(models) {
    // associations can be defined here
  };
  return Song;
};