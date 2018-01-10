// import main stlyles
import "../styles/main.css";
import * as Elm from "../elm/Main";
import Amplify, { Auth } from "aws-amplify";
import {
  identityPoolId,
  region,
  userPoolId,
  userPoolWebClientId
} from "./config";
import * as uuidv4 from "uuid/v4";

// mount Elm app
const mountNode = document.getElementById("main");
const app = Elm.Main.embed(mountNode);

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
app.ports.signup.subscribe((data: signupRequest) => doSignup(data));

// Signup
function doSignup(data: signupRequest) {
  console.log("doSignup", data);

  Auth.signUp(uuidv4(), data.password, data.email)
    .then(res => app.ports.signupSuccess.send(res.user.getUsername()))
    .catch(err => app.ports.errors.send(err.message));
}
