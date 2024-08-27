const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Item = sequelize.define("Item", {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4, // Automatically generates a UUID
      primaryKey: true,
    },
    photo: {
      type: DataTypes.STRING, // Array of image URLs
      allowNull: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    description: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    priceOrigin: {
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    priceDestination: {
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    taxOrigin: {
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    taxDestination: {
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    storeLocation: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    storeHours: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    purchaseMethod: {
      type: DataTypes.STRING,
      allowNull: true,
    },
  });

  return Item;
};
