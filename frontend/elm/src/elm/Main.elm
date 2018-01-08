module Main exposing (..)

import Cognito
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onSubmit)

main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , subscriptions = \model -> Sub.none
        , update = update
        , view = view
        }

type alias Model =
    { signupForm :
        { email: String
        , password: String
        }
    }

initialModel : Model
initialModel =
    { signupForm =
        { email = "elm-cognito@mailinator.com"
        , password = "password"
        }
    }

 -- update

type Msg
    = DoSignup
    -- | SetEmail String
    -- | SetPassword String

update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case Debug.log "update" msg of
        DoSignup ->
            ( model, Cognito.signup
                model.signupForm
             )


 -- view

view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ div [ class "container" ]
            [ h1 []
                [ text "Welcome" ]
            , Html.form [ class "form", onSubmit DoSignup ]
                [ input [ placeholder "Email", type_ "text", defaultValue model.signupForm.email ]
                    []
                , input [ placeholder "Password", type_ "password", defaultValue model.signupForm.email ]
                    []
                , button [ id "signup-button", type_ "submit" ]
                    [ text "Signup" ]
                ]
            ]
        , ul [ class "bg-bubbles" ]
            [ li []
                []
            , li []
                []
            , li []
                []
            , li []
                []
            , li []
                []
            , li []
                []
            , li []
                []
            , li []
                []
            , li []
                []
            , li []
                []
            ]
        ]