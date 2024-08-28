const router = require("express").Router();
const bcrypt = require("bcrypt");

const User = require("../models/userModel");

router.post("/", async (req, res) => {
  const user = await User.findOne({ where: { email: req.body.email } });

  if (!user) return res.status(400).send("Invalid email or password");

  const validPassword = await bcrypt.compare(req.body.password, user.password);

  if (!validPassword) return res.status(400).send("Invalid email or password");

  const token = user.generateAuthToken();

  res.header("x-auth-token", token);
  res.send(token);
});

module.exports = router;
