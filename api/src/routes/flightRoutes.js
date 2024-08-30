const router = require("express").Router();

const Flight = require("../models/flight");

router.get("/:id", async (req, res) => {
  const flight = await Flight.findByPk(req.params.id);

  if (flight) res.status(200).json(flight);
  else res.status(404).json({ error: "Flight not found" });
});

router.post("/", async (req, res) => {
  const flight = new Flight(req.body);

  await flight.save();

  res.status(201).json({
    message: "Flight created successfully",
    data: flight.dataValues,
  });
});

router.delete("/:id", async (req, res) => {
  const flight = await Flight.findByPk(req.params.id);

  if (flight) {
    await flight.destroy();
    res.status(200).json({
      message: "Flight deleted successfully",
      flight: flight,
    });
  } else res.status(404).json({ error: "Flight not found" });
});

module.exports = router;
