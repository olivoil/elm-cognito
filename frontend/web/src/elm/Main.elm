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
                    , Cognito.signupErrors CognitoSignupError
                    , Cognito.signupConfirmationSuccess CognitoSignupConfirmationSuccess
                    , Cognito.signupConfirmationErrors CognitoSignupConfirmationError
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
    { signupFlow =
        SignupForm
            { email = ""
            , password = ""
            , isSubmitting = False
            , error = Nothing
            }
    }



-- update


type Msg
    = SubmitSignupForm
    | ChangeSignupEmail String
    | ChangeSignupPassword String
    | CognitoSignupError String
    | CognitoSignupSuccess { username : String }
    | ChangeSignupConfirmationUsername String
    | ChangeSignupConfirmationCode String
    | SubmitSignupConfirmationForm
    | CognitoSignupConfirmationError String
    | CognitoSignupConfirmationSuccess { username : String }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.signupFlow ) of
        ( ChangeSignupEmail newEmail, SignupForm signupForm ) ->
            ( { model | signupFlow = SignupForm { signupForm | email = newEmail } }
            , Cmd.none
            )

        ( ChangeSignupPassword newPassword, SignupForm signupForm ) ->
            ( { model | signupFlow = SignupForm { signupForm | password = newPassword } }
            , Cmd.none
            )

        ( SubmitSignupForm, SignupForm signupForm ) ->
            ( { model | signupFlow = SignupForm { signupForm | isSubmitting = True } }
            , Cognito.signup
                { email = signupForm.email
                , phone = ""
                , password = signupForm.password
                }
            )

        ( CognitoSignupError error, SignupForm signupForm ) ->
            ( { model | signupFlow = SignupForm { signupForm | error = Just error, isSubmitting = False } }
            , Cmd.none
            )

        ( CognitoSignupSuccess user, SignupForm _ ) ->
            ( { model
                | signupFlow =
                    SignupConfirmationForm
                        { username = user.username
                        , code = ""
                        , isSubmitting = False
                        , error = Nothing
                        }
              }
            , Cmd.none
            )

        ( ChangeSignupConfirmationUsername newUsername, SignupConfirmationForm signupConfirmationForm ) ->
            ( { model | signupFlow = SignupConfirmationForm { signupConfirmationForm | username = newUsername } }
            , Cmd.none
            )

        ( ChangeSignupConfirmationCode newCode, SignupConfirmationForm signupConfirmationForm ) ->
            ( { model | signupFlow = SignupConfirmationForm { signupConfirmationForm | code = newCode } }
            , Cmd.none
            )

        ( SubmitSignupConfirmationForm, SignupConfirmationForm confirmationForm ) ->
            ( model
            , Cognito.confirmSignup
                { username = confirmationForm.username
                , code = confirmationForm.code
                }
            )

        ( CognitoSignupConfirmationError error, SignupConfirmationForm signupConfirmationForm ) ->
            ( { model | signupFlow = SignupConfirmationForm { signupConfirmationForm | error = Just error, isSubmitting = False } }
            , Cmd.none
            )

        _ ->
            Debug.crash "TODO"



-- view


view : Model -> Html Msg
view model =
    case model.signupFlow of
        SignupForm signupForm ->
            div [ class "wrapper" ]
                [ div [ class "container" ]
                    [ h1 []
                        [ text "Welcome" ]
                    , Html.form [ class "form", onSubmit SubmitSignupForm ]
                        [ input
                            [ placeholder "Email"
                            , type_ "text"
                            , defaultValue signupForm.email
                            , onInput ChangeSignupEmail
                            ]
                            []
                        , input
                            [ placeholder "Password"
                            , type_ "password"
                            , defaultValue signupForm.password
                            , onInput ChangeSignupPassword
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

        SignupConfirmationForm confirmationForm ->
            div [ class "wrapper" ]
                [ div [ class "container" ]
                    [ h1 []
                        [ text "Welcome" ]
                    , Html.form [ class "form", onSubmit SubmitSignupConfirmationForm ]
                        [ input
                            [ placeholder "Email or Phone"
                            , type_ "text"
                            , defaultValue confirmationForm.username
                            , onInput ChangeSignupConfirmationUsername
                            ]
                            []
                        , input
                            [ placeholder "Confirmation code"
                            , type_ "text"
                            , defaultValue confirmationForm.code
                            , onInput ChangeSignupConfirmationCode
                            ]
                            []
                        , button [ id "signup-confirmation-button", type_ "submit" ]
                            [ text "Confirm" ]
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

        SignedUp ->
            div [ class "wrapper" ]
                [ div [ class "container" ]
                    [ h1 []
                        [ text "Welcome" ]
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
