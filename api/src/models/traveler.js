const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Traveler = sequelize.define("Traveler", {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
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
    paymentInfo: {
      type: DataTypes.JSON,
      allowNull: true,
    },
    bio: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    rating: {
      type: DataTypes.DECIMAL(3, 1), // e.g., 4.5
      allowNull: true,
      validate: {
        min: 0.1,
        max: 5.0,
      },
    },
  });

  return Traveler;
};
