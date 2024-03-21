const mongoose = require("mongoose");

const productSchema = new mongoose.Schema(
  {
    name: String,
    category: { type: mongoose.Schema.Types.ObjectId, ref: "Category" },
    image: String,
    about: String,
    ingredients: [String],
    price: Number
  },
  { timestamps: true }
);

let product = mongoose.model("Product", productSchema);

module.exports = {
  product,
};
