const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const userModel = require("../models/User");

function generateUsername(email) {
  const atIndex = email.indexOf("@");
  if (atIndex !== -1) {
    return email.slice(0, atIndex);
  } else {
    // Xử lý trường hợp email không có ký tự '@'
    return email;
  }
}

const register = async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email) {
      return res.status(403).json({ code: 403, message: "email is required" });
    }
    if (!password) {
      return res.status(403).json({ code: 403, message: "email is password" });
    }
    const userExists = await userModel.user.findOne({ email: email });
    if (userExists) {
      return res
        .status(409)
        .json({ code: 409, message: "user already exists" });
    }
    const salt = await bcrypt.genSalt(10);
    const newUser = new userModel.user({ email, password });
    newUser.username = generateUsername(email);
    newUser.password = await bcrypt.hash(password, salt);
    await newUser.save();
    return res
      .status(201)
      .json({ code: 201, message: "create account successfully" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ code: 500, success: false, message: "internal error" });
  }
};

const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await userModel.user.findOne({ email });
    if (!user) {
      return res.status(404).json({ code: 404, message: "Email not found" });
    }
    // compare password
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      return res.status(401).json({ code: 401, message: "Incorrect password" });
    }

    // if password matches, create a new token
    const token = jwt.sign({ userId: user._id }, process.env.PRIVATE_KEY);

    // update token to db
    user.token = token;
    await user.save();
    return res.status(200).json({
      code: 200,
      token,
      message: "login successful",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

const detailProfile = (req, res) => {
  try {
    const user = req.user;
    return res
      .status(200)
      .json({ code: 200, result: user, message: "success" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

const changeAvatar = async (req, res) => {
  try {
    const user = req.user;
    let avatar;
    if (!req.file) {
      return res.status(404).json({ code: 404, message: "image not found" });
    }
    avatar = `posts/${req.file.filename}`;
    const dataUpdate = await userModel.user.findByIdAndUpdate(user._id, {
      avatar: avatar,
    });
    return res.status(200).json({
      code: 200,
      result: dataUpdate,
      message: "update avatar successfully",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

const changeProfile = async (req, res) => {
  try {
    const user = req.user;
    const { username } = req.body;
    const dataUpdate = await userModel.user.findByIdAndUpdate(user._id, {
      username: username,
    });
    return res.status(200).json({
      code: 200,
      result: dataUpdate,
      message: "update profile successfully",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

const logout = async (req, res) => {
  try {
    const user = req.user;

    user.token = null;

    await user.save();

    return res.status(200).json({ code: 200, message: "Logout successful" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

module.exports = {
  register,
  login,
  changeAvatar,
  changeProfile,
  detailProfile,
  logout
};
