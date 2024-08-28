const express = require("express");
const users = require("../routes/userRoutes");
const items = require("../routes/itemRoutes");
const flights = require("../routes/flightRoutes");
const auth = require("../controllers/auth");
const error = require("../middleware/error");

module.exports = function (app) {
  app.use(express.json());
  app.use("/api/users", users);
  app.use("/api/items", items);
  app.use("/api/flights", flights);
  app.use("/api/auth", auth);

  //error middleware function should be declared after all other middleware functions
  app.use(error);
};
