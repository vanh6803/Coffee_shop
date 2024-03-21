const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    productOrder: [
      {
        product: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
        size: String,
        quantity: Number,
      },
    ],
    totalPrice: Number,
  },
  { timestamps: true }
);

let order = mongoose.model("order", orderSchema);

module.exports = {
  order,
};
