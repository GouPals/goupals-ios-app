const express = require("express");
const createDatabaseTables = require("./createTables");
const app = express();

const travelers = require("./routes/travelers");
const trips = require("./routes/trips");
const items = require("./routes/items");
const buyers = require("./routes/buyers");

createDatabaseTables();

app.use(express.json());
app.use("/api/travelers", travelers);
app.use("/api/trips", trips);
app.use("/api/items", items);
app.use("/api/buyers", buyers);

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on port ${port}`));
