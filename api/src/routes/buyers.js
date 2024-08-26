const express = require("express");
const sequelize = require("../utils/database");
const router = express.Router();

const Buyer = require("../models/buyer")(sequelize);

router.post("/", async (req, res) => {
  try {
    const { name, email, phoneNumber, rating, bio } = req.body;

    const buyer = await Buyer.create({
      name,
      email,
      phoneNumber,
      rating,
      bio,
    });

    res.status(201).json({
      message: "Buyer created successfully",
      data: buyer.dataValues,
    });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.get("/:id", async (req, res) => {
  try {
    const buyer = await Buyer.findByPk(req.params.id);

    if (buyer) res.status(200).json(buyer);
    else res.status(404).json({ error: "Buyer not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const buyer = await Buyer.findByPk(req.params.id);

    if (buyer) {
      await buyer.destroy();
      res.status(200).json({
        message: "Buyer deleted successfully",
        buyer: buyer,
      });
    } else res.status(404).json({ error: "Buyer not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
