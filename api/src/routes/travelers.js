const express = require("express");
const sequelize = require("../utils/database");
const router = express.Router();

const Traveler = require("../models/traveler")(sequelize);

router.post("/", async (req, res) => {
  try {
    const { name, email, phoneNumber, paymentInfo, bio, rating } = req.body;

    const traveler = await Traveler.create({
      name,
      email,
      phoneNumber,
      paymentInfo,
      bio,
      rating,
    });

    console.log(traveler.dataValues);

    res.status(201).json({
      message: "Traveler created successfully",
      data: traveler.dataValues,
    });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.get("/", (req, res) => {
  res.send("Travelers data");
});

module.exports = router;
