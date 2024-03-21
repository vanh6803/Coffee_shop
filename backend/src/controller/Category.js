const categoryModel = require("../models/Category");

const allCategory = async (req, res, next) => {
  try {
    const categories = await categoryModel.category.find();
    return res
      .status(200)
      .json({ code: 200, result: categories, message: "success" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

const addCategory = async (req, res, next) => {
  try {
    const { name } = req.body;
    const newData = new categoryModel.category({ name });
    await newData.save();
    return res.status(201).json({ code: 201, message: "success" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

module.exports = {
  allCategory,
  addCategory,
};
