port module Cognito exposing (..)


port signup :
    { email : String
    , phone : String
    , password : String
    }
    -> Cmd msg


port signupSuccess : ({ username : String } -> msg) -> Sub msg


port confirmSignup :
    { code : String
    , username : String
    }
    -> Cmd msg


port signupConfirmationSuccess : ({ username : String } -> msg) -> Sub msg


port signupErrors : (String -> msg) -> Sub msg


port signupConfirmationErrors : (String -> msg) -> Sub msg
