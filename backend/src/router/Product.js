var express = require("express");
var router = express.Router();
const controller = require("../controller/Product");

router.get("/", controller.allProduct);
router.post("/", controller.addProduct);

module.exports = router;
