const mongoose = require("mongoose");

const cartSchema = new mongoose.Schema(
  {
    product: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    size: String,
    quantity: Number,
  },
  { timestamps: true }
);

let cart = mongoose.model("Cart", cartSchema);

module.exports = {
  cart,
};
