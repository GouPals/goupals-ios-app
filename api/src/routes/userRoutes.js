_ = require("lodash");
const bcrypt = require("bcrypt");
const router = require("express").Router();

const User = require("../models/user");

router.get("/:id", async (req, res) => {
  const user = await User.findByPk(req.params.id);

  if (user) res.status(200).json(user);
  else res.status(404).json({ error: "User not found" });
});

router.post("/", async (req, res) => {
  const data = req.body;

  const { error } = User.validate(data);

  if (error) return res.status(400).send(error.details[0].message);

  let user = await User.findOne({ where: { email: data.email } });

  if (user)
    return res
      .status(400)
      .send("User with same email address already registered");

  const userData = _.pick(data, Object.keys(User.getAttributes()));

  user = new User(userData);

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
});

router.delete("/:id", async (req, res) => {
  const user = await User.findByPk(req.params.id);

  if (user) {
    await user.destroy();
    res.status(200).json({
      message: "User deleted successfully",
      user: user,
    });
  } else res.status(404).json({ error: "User not found" });
});

module.exports = router;
