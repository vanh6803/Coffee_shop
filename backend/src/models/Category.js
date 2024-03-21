const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema(
  {
    name: String,
  },
  { timestamps: true }
);

let category = mongoose.model("Category", categorySchema);

module.exports = {
  category,
};
