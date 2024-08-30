const winston = require("winston");
const sequelize = require("../utils/database.js");

const User = require("../models/user.js");
const Flight = require("../models/flight.js");
const Item = require("../models/item.js");

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
