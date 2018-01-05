const path = require("path");

module.exports = {
  entry: "./src/entry",

  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "build.js"
  },

  module: {
    rules: [
      {
        test: /\.min\.js$/,
        loader: "source-map",
        enforce: "pre"
      },
      {
        test: /\.json$/,
        loader: "json-loader"
      }
    ]
  }
};
