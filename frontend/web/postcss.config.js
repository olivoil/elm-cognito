"use strict";

const path = require("path");
const autoprefixer = require("autoprefixer");
const preCSS = require("precss");
const calc = require("postcss-calc");
const variables = require("./src/styles/variables");

// Get context at startup
const mixinsFiles = path.join(__dirname, "./src/styles/mixins", "*.css");

module.exports = function postcss() {
  return {
    plugins: [
      preCSS({
        variables: {
          variables
        },
        mixins: {
          mixinsFiles
        }
      }),
      calc(),
      autoprefixer({
        flexbox: "no-2009"
      })
    ]
  };
};
