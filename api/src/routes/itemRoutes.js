const router = require("express").Router();

const Item = require("../models/itemModel");

router.get("/:id", async (req, res) => {
  const item = await Item.findByPk(req.params.id);

  if (item) res.status(200).json(item);
  else res.status(404).json({ error: "Item not found." });
});

router.post("/", async (req, res) => {
  const item = new Item(req.body);

  await item.save();

  res.status(201).json({
    message: "Item created successfully.",
    data: item.dataValues,
  });
});

router.delete("/:id", async (req, res) => {
  const item = await Item.findByPk(req.params.id);

  if (item) {
    await item.destroy();
    res.status(200).json({
      message: "Item deleted successfully.",
      item: item,
    });
  } else res.status(404).json({ error: "Item not found." });
});

module.exports = router;
