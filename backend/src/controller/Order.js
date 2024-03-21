const { order } = require("./orderModel");
const { product } = require("./productModel");

const createOrder = async (req, res, next) => {
  try {
    const { productOrder } = req.body;

    // Kiểm tra xem productOrder có tồn tại không
    if (
      !productOrder ||
      !Array.isArray(productOrder) ||
      productOrder.length === 0
    ) {
      return res
        .status(400)
        .json({
          message: "productOrder is required and must be a non-empty array",
        });
    }

    // Tính tổng giá trị từ productOrder
    let totalPrice = 0;
    for (const item of productOrder) {
      // Tìm sản phẩm trong cơ sở dữ liệu
      const foundProduct = await product.findById(item.productId);

      // Kiểm tra xem sản phẩm có tồn tại không
      if (!foundProduct) {
        return res
          .status(404)
          .json({ message: `Product with id ${item.productId} not found` });
      }

      // Tính toán giá trị cho sản phẩm và cập nhật tổng giá trị
      totalPrice += foundProduct.price * item.quantity;
    }

    // Tạo đơn hàng mới
    const newOrder = new order({
      productOrder,
      totalPrice,
    });

    // Lưu đơn hàng vào cơ sở dữ liệu
    await newOrder.save();

    return res
      .status(201)
      .json({ message: "Order created successfully", order: newOrder });
  } catch (error) {
    console.error("Error creating order:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};
