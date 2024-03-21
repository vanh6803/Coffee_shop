var express = require("express");
var router = express.Router();
const controller = require("../controller/User");
const middleware = require("../middleware/CheckToken");

router.post("/register", controller.register);
router.post("/login", controller.login);

router.get("/user", middleware.checkToken, controller.detailProfile);
router.get("/logout", middleware.checkToken, controller.logout);

module.exports = router;
