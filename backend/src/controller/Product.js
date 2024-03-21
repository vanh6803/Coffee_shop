const productModel = require("../models/Product");

const allProduct = async (req, res, next) => {
  try {
    const { category } = req.query;

    const products = await productModel.product.find(
      category ? { category: category } : null
    );

    return res
      .status(200)
      .json({ code: 200, result: products, message: "success" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

const addProduct = async (req, res, next) => {
  try {
    const { name, category, about, ingredients } = req.body;
    const newData = new productModel.product({
      name,
      category,
      about,
      ingredients,
    });
    await newData.save();
    return res.status(201).json({ code: 201, message: "success" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

module.exports = {
  allProduct,
  addProduct,
};
