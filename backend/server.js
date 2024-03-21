const express = require("express");
const cors = require("cors");
const path = require("path");
require("dotenv").config();
require("./src/config/configDB");
const authRouter = require("./src/router/Auth");
const productRouter = require("./src/router/Product");
const categoryRouter = require("./src/router/Category");
const cartRouter = require("./src/router/Cart");

const app = express();
const port = process.env.PORT || 3000;

app.use((req, res, next) => {
  console.log(`[${new Date().toLocaleString()}] ${req.method} ${req.url}`);
  next();
});

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

app.use("/api", authRouter);
app.use("/api/product", productRouter);
app.use("/api/category", categoryRouter);
app.use("/api/cart", cartRouter);

app.listen(port, () => {
  console.log(`http://localhost:${port}`);
});
