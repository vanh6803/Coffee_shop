const mongoose = require("mongoose");

mongoose
  .connect(process.env.URL_MONGODB)
  .then(() => {
    console.log("connect successful !!!");
  })
  .catch(() => {
    console.log("connect failed :(");
  });

module.exports = {
  mongoose,
};
