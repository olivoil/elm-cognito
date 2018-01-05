const config = require("./config.json");
const {
  CognitoUserPool,
  CognitoUserAttribute,
  CognitoUser
} = require("amazon-cognito-identity-js");

const userPool = new CognitoUserPool({
  UserPoolId: config.UserPoolId.OutputValue,
  ClientId: config.UserPoolClientId.OutputValue
});

console.log(userPool);
