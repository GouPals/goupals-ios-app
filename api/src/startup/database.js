const winston = require("winston");
const sequelize = require("../utils/database.js");

const User = require("../models/userModel.js");
const Flight = require("../models/flightModel.js");
const Item = require("../models/itemModel.js");

module.exports = () => {
  new User();
  new Flight();
  new Item();

  sequelize
    .sync()
    .then(() => {
      winston.info("Database was created successfully.");
    })
    .catch((error) => {
      console.error("Unable to create table : ", error);
    });
};
