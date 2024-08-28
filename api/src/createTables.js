const sequelize = require("./utils/database.js");

const User = require("./models/userModel");
const Flight = require("./models/flightModel");
const Item = require("./models/itemModel");

module.exports = () => {
  new User();
  new Flight();
  new Item();

  sequelize
    .sync()
    .then(() => {
      console.log("Tables were created successfully!");
    })
    .catch((error) => {
      console.error("Unable to create table : ", error);
    });
};
