const express = require("express");
const sequelize = require("../utils/database");
const router = express.Router();

const User = require("../models/userModel")(sequelize);

router.post("/", async (req, res) => {
  try {
    const { name, email, phoneNumber, rating, bio } = req.body;

    const user = await User.create({
      name,
      email,
      phoneNumber,
      rating,
      bio,
    });

    res.status(201).json({
      message: "User created successfully",
      data: user.dataValues,
    });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.get("/:id", async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id);

    if (user) res.status(200).json(user);
    else res.status(404).json({ error: "User not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id);

    if (user) {
      await user.destroy();
      res.status(200).json({
        message: "User deleted successfully",
        user: user,
      });
    } else res.status(404).json({ error: "User not found" });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
