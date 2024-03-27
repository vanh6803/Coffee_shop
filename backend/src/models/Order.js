const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    productOrder: [
      {
        product: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
        size: String,
      },
    ],
    totalPrice: Number,
    status: {
      type: String,
      enum: ["Pending", "Pending delivery", "Delivered", "Cancelled"],
      default: "Pending",
    },
  },
  { timestamps: true }
);

let order = mongoose.model("order", orderSchema);

module.exports = {
  order,
};
