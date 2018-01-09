port module Cognito exposing (signup, errors, signupSuccess)


port signup :
    { email : String
    , password : String
    }
    -> Cmd msg


port errors : (String -> msg) -> Sub msg


port signupSuccess : ({ username : String } -> msg) -> Sub msg