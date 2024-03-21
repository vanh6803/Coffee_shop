var express = require("express");
var router = express.Router();
const controller = require("../controller/Cart");
const middleware = require("../middleware/CheckToken");

router.get("/", middleware.checkToken, controller.getAllCartFromUser);
router.post("/", middleware.checkToken, controller.addToCart);
router.put("/:id", middleware.checkToken, controller.updateItem);
router.delete("/:id", middleware.checkToken, controller.deleteItem);

module.exports = router;
