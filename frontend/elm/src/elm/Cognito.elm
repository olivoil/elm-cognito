port module Cognito exposing (signup)

port signup :
    { email : String
    , password : String
    }
    -> Cmd msg