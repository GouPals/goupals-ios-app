const Sequelize = require("sequelize");
const config = require("config");

const sequelize = new Sequelize(
  config.get("db.database"),
  config.get("db.username"),
  config.get("db.password"),
  {
    dialect: config.get("db.dialect"),
    host: config.get("db.host"),
  }
);

module.exports = sequelize;
