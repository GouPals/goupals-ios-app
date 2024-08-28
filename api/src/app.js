const config = require("config");
const express = require("express");
const createDatabaseTables = require("./createTables");
const app = express();
const users = require("./routes/userRoutes");
const items = require("./routes/itemRoutes");
const flights = require("./routes/flightRoutes");
const auth = require("./controllers/auth");

if (!config.get("jwtPrivateKey")) {
  console.error("FATAL ERROR: jwtPrivateKey is not defined");
  process.exit(1);
}

createDatabaseTables();

app.use(express.json());
app.use("/api/users", users);
app.use("/api/items", items);
app.use("/api/flights", flights);
app.use("/api/auth", auth);

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on port ${port}`));
