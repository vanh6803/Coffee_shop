const { cart } = require("../models/Cart");
const { order } = require("../models/Order");
const { product } = require("../models/Product");

const createOrder = async (req, res, next) => {
  try {
    const user = req.user;
    const { productOrder } = req.body;
    if (!productOrder) {
      return res.status(400).json({
        message: "productOrder is required",
      });
    }
    console.log(productOrder);

    var orderItem = [];

    productOrder.forEach((item) => {
      orderItem.push({ product: item.product._id, size: item.size });
    });

    let totalPrice = 0;
    for (let item of productOrder) {
      const foundProduct = await product.findById(item.product._id);

      if (!foundProduct) {
        return res
          .status(404)
          .json({ message: `Product with id ${item.product._id} not found` });
      }

      totalPrice += foundProduct.price;
    }

    await cart.deleteMany({ user: user._id });

    const newOrder = new order({
      user: user._id,
      productOrder: orderItem,
      totalPrice,
    });

    await newOrder.save();

    return res.status(201).json({
      message: "Order created successfully",
      // result: newOrder
    });
  } catch (error) {
    console.error("Error creating order:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};
const getAllOrderForUser = async (req, res) => {
  try {
    const orders = await order
      .find()
      .populate({
        path: "productOrder",
        populate: {
          path: "product",
          model: "Product",
          select: "_id name price image",
        },
      })
      .sort({ updatedAt: -1 });
    return res.status(200).json(orders);
  } catch (error) {
    console.error("Error creating order:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

module.exports = {
  createOrder,
  getAllOrderForUser,
};
