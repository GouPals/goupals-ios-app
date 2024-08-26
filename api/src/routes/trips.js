const express = require("express");
const sequelize = require("../utils/database");
const router = express.Router();

const Trip = require("../models/trip")(sequelize);

router.post("/", async (req, res) => {
  try {
    const {
      flightNumber,
      arrivalCity,
      departureCity,
      departureDate,
      arrivalDate,
      travelerId,
    } = req.body;

    const trip = await Trip.create({
      flightNumber,
      arrivalCity,
      departureCity,
      departureDate,
      arrivalDate,
      travelerId,
    });

    res.status(201).json({
      message: "Traveler created successfully",
      data: trip.dataValues,
    });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.get("/:id", async (req, res) => {
  try {
    const trip = await Trip.findByPk(req.params.id);

    if (trip) res.status(200).json(trip);
    else res.status(404).json({ error: "Trip not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const trip = await Trip.findByPk(req.params.id);

    if (trip) {
      await trip.destroy();
      res.status(200).json({
        message: "Trip deleted successfully",
        trip: trip,
      });
    } else res.status(404).json({ error: "Trip not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
