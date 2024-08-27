const express = require("express");
const sequelize = require("../utils/database");
const router = express.Router();

const Item = require("../models/itemModel")(sequelize);

router.post("/", async (req, res) => {
  try {
    const {
      photo,
      name,
      description,
      priceOrigin,
      priceDestination,
      taxOrigin,
      taxDestination,
      storeLocation,
      storeHours,
      purchaseMethod,
    } = req.body;

    const item = await Item.create({
      photo,
      name,
      description,
      priceOrigin,
      priceDestination,
      taxOrigin,
      taxDestination,
      storeLocation,
      storeHours,
      purchaseMethod,
    });

    res.status(201).json({
      message: "Item created successfully",
      data: item.dataValues,
    });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.get("/:id", async (req, res) => {
  try {
    const item = await Item.findByPk(req.params.id);

    if (item) res.status(200).json(item);
    else res.status(404).json({ error: "Item not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const item = await Item.findByPk(req.params.id);

    if (item) {
      await item.destroy();
      res.status(200).json({
        message: "Item deleted successfully",
        item: item,
      });
    } else res.status(404).json({ error: "Item not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
