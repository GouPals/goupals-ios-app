_ = require("lodash");
const bcrypt = require("bcrypt");
const router = require("express").Router();

const User = require("../models/userModel");

router.post("/", async (req, res) => {
  try {
    const user = new User(req.body);

    // Encrypt password
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password, salt);

    await user.save();

    const keysToReturn = Object.keys(user.dataValues).filter(
      (key) => key !== "password"
    );

    res.status(201).json({
      message: "User created successfully",
      data: _.pick(user.dataValues, keysToReturn),
    });
  } catch (error) {
    res.status(400).send(error);
  }
});

router.get("/:id", async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id);

    if (user) res.status(200).json(user);
    else res.status(404).json({ error: "User not found" });
  } catch (error) {
    res.status(400).send(error);
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
    res.status(400).send(error);
  }
});

module.exports = router;
