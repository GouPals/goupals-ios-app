const express = require("express");
const createDatabaseTables = require("./createTables");
const app = express();

const users = require("./routes/userRoutes");
const items = require("./routes/itemRoutes");
const flights = require("./routes/flightRoutes");

//createDatabaseTables();

app.use(express.json());
app.use("/api/users", users);
app.use("/api/items", items);
app.use("/api/flights", flights);

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on port ${port}`));
