const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    username: String,
    email: { type: String, required: true, max: 50 },
    password: { type: String, required: true, min: 8 },
    avatar: { type: String, default: "" },
    token: String,
  },
  { timestamps: true }
);

let user = mongoose.model("User", userSchema);

module.exports = { 
  user,
};
