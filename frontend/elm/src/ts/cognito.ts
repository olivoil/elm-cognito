import { default as Amplify, Auth } from "aws-amplify";
import {
  identityPoolId,
  region,
  userPoolId,
  userPoolWebClientId
} from "./config";
import * as uuidv5 from "uuid/v5";

// Configure aws amplify
Amplify.configure({
  Auth: { identityPoolId, region, userPoolId, userPoolWebClientId }
});

// Signup request
interface signupRequest {
  email: string;
  password: string;
}

// Setup elm ports
export function setupPorts(ports) {
  ports.signup.subscribe((data: signupRequest) => onSignup(ports, data));
}

// Signup
function onSignup(ports, data: signupRequest) {
  Auth.signUp(uuidv5(data.email, identityPoolId), data.password, data.email)
    .then(data => ports.signupSuccess.send(data))
    .catch(err => ports.errors.send(err));
}
