const { cart } = require("../models/Cart");

const getAllCartFromUser = async (req, res, next) => {
  try {
    const user = req.user;
    const userCart = await cart.find({ user: user._id }).populate("product");
    res.status(200).json(userCart);
  } catch (error) {
    next(error);
  }
};

const addToCart = async (req, res, next) => {
  try {
    const user = req.user;
    const { productId, size } = req.body;
    const newItem = new cart({
      product: productId,
      user: user._id,
      size,
    });
    await newItem.save();
    console.log(newItem);
    res.status(201).json(newItem);
  } catch (error) {
    next(error);
  }
};

const updateItem = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { size, quantity } = req.body;

    let item = await cart.findById(id);
    if (!item) {
      return res.status(404).json({ message: "Item not found" });
    }
    item.size = size;
    item.quantity = quantity;

    await item.save();

    res.status(200).json(item);
  } catch (error) {
    next(error);
  }
};

const deleteItem = async (req, res, next) => {
  try {
    const { id } = req.params;

    await cart.findByIdAndDelete(id);

    res.status(204).json({ message: "Item deleted successfully" });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getAllCartFromUser,
  addToCart,
  updateItem,
  deleteItem,
};
