const jwt = require("jsonwebtoken");
const userModel = require("../models/User");

const checkToken = async (req, res, next) => {
  let header_token = req.header("Authorization");
  if (typeof header_token == "undefined" || typeof header_token == null) {
    return res.status(403).json({ message: "unknown token" });
  }

  const token = header_token.replace("Bearer ", "");

  try {
    const data = jwt.verify(token, process.env.PRIVATE_KEY);
    const user = await userModel.user.findById(data.userId);
    if (!user) {
      return res.status(404).json({ message: "unknown user" });
    }
    req.user = user;
    next();
  } catch (error) {
    console.error(error);
    res.status(401).json({ code: 401, message: error.message });
  }
};

module.exports = {
  checkToken,
};
