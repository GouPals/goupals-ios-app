const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Trip = sequelize.define("Trip", {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    flightNumber: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    arrivalCity: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    departureCity: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    departureDate: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    arrivalDate: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    travelerId: {
      type: DataTypes.UUID,
      references: {
        model: "travelers",
        key: "id",
      },
      allowNull: false,
    },
  });

  return Trip;
};
