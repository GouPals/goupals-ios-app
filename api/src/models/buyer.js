const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Buyer = sequelize.define("Buyer", {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      allowNull: false,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        isEmail: true,
      },
    },
    phoneNumber: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    rating: {
      type: DataTypes.DECIMAL(3, 1),
      allowNull: true,
      validate: {
        min: 0,
        max: 5,
      },
    },
    bio: {
      type: DataTypes.STRING,
      allowNull: true,
    },
  });

  return Buyer;
};