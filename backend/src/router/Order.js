var express = require("express");
var router = express.Router();
const controller = require("../controller/Order");
const middleware = require("../middleware/CheckToken");

router.get("/", middleware.checkToken, controller.getAllOrderForUser);
router.post("/", middleware.checkToken, controller.createOrder);

module.exports = router;
