const sequelize = require("./utils/database");

const createBuyerTable = require("./models/buyer");
const createTravelerTable = require("./models/traveler");
const createTripTable = require("./models/trip");
const createItemTable = require("./models/item");

module.exports = () => {
  createBuyerTable(sequelize);
  createTravelerTable(sequelize);
  createTripTable(sequelize);
  createItemTable(sequelize);

  sequelize
    .sync()
    .then(() => {
      console.log("Tables were created successfully!");
    })
    .catch((error) => {
      console.error("Unable to create table : ", error);
    });
};
