// import main stlyles
import "../styles/main.css";

import { userPool } from "./cognito";

// mount elm app
import * as Elm from "../elm/Main.elm";
const mountNode = document.getElementById("main");
const app = Elm.Main.embed(mountNode);
