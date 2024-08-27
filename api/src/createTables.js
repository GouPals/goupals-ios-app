const sequelize = require("./utils/database");

const createUserTable = require("./models/userModel");
const createFlightTable = require("./models/flightModel.js");
const createItemTable = require("./models/itemModel");

module.exports = () => {
  createUserTable(sequelize);
  createFlightTable(sequelize);
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
