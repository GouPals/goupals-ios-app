const express = require("express");
const sequelize = require("../utils/database");
const router = express.Router();

const Flight = require("../models/flightModel")(sequelize);

router.post("/", async (req, res) => {
  try {
    const {
      flightNumber,
      arrivalCity,
      departureCity,
      departureDate,
      arrivalDate,
      userId,
    } = req.body;

    const flight = await Flight.create({
      flightNumber,
      arrivalCity,
      departureCity,
      departureDate,
      arrivalDate,
      userId,
    });

    res.status(201).json({
      message: "Flight created successfully",
      data: flight.dataValues,
    });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.get("/:id", async (req, res) => {
  try {
    const flight = await Flight.findByPk(req.params.id);

    if (flight) res.status(200).json(flight);
    else res.status(404).json({ error: "Flight not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const flight = await Flight.findByPk(req.params.id);

    if (flight) {
      await flight.destroy();
      res.status(200).json({
        message: "Flight deleted successfully",
        flight: flight,
      });
    } else res.status(404).json({ error: "Flight not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
