import config from "./config";

import {
  CognitoUserPool,
  CognitoUserAttribute,
  CognitoUser
} from "amazon-cognito-identity-js";

export const userPool = new CognitoUserPool({
  UserPoolId: (<any>config).UserPoolId.OutputValue,
  ClientId: (<any>config).UserPoolClientId.OutputValue
});

console.log(userPool);
