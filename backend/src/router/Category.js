var express = require("express");
var router = express.Router();
const controller = require("../controller/Category");

router.get("/", controller.allCategory);
router.post("/", controller.addCategory);

module.exports = router;
