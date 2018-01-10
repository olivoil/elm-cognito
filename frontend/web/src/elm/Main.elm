port module Main exposing (..)

import Cognito
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onSubmit, onInput)


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , subscriptions =
            \model ->
                Sub.batch
                    [ Cognito.signupSuccess CognitoSignupSuccess
                    , Cognito.errors CognitoError
                    ]
        , update = update
        , view = view
        }


type alias Model =
    { signupFlow : FormState
    }


type FormState
    = SignupForm
            { email : String
            , password : String
            , isSubmitting : Bool
            , error : Maybe String
            }
    | SignupConfirmationForm
            { username : String
            , code : String
            , isSubmitting : Bool
            , error : Maybe String
            }
    | SignedUp


initialModel : Model
initialModel =
    { signupForm =
        { email = "elmcognito-authn-dev-01@mailinator.com"
        , password = "AllThe$3kr37s"
        }
    }



-- update


type Msg
    = DoSignup
    | CognitoError String
    | CognitoSignupSuccess { username : String }
    | SignupEmailChanged String
    | SignupPasswordChanged String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case Debug.log "update" msg of
        DoSignup ->
            ( model
            , Cognito.signup model.signupForm
            )

        CognitoError _ ->
            ( model, Cmd.none )

        CognitoSignupSuccess _ ->
            ( model, Cmd.none )

        SignupEmailChanged _ ->
           ( model, Cmd.none )

        SignupPasswordChanged _ ->
           ( model, Cmd.none )


-- view


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ div [ class "container" ]
            [ h1 []
                [ text "Welcome" ]
            , Html.form [ class "form", onSubmit DoSignup ]
                [ input
                    [ placeholder "Email"
                    , type_ "text"
                    , defaultValue model.signupForm.email
                    , onInput SignupEmailChanged
                    ]
                    []
                , input
                    [ placeholder "Password"
                    , type_ "password"
                    , defaultValue model.signupForm.email
                    , onInput SignupPasswordChanged
                    ]
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
