import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import Char

main =
  App.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age: String
  }

model : Model
model =
  Model "" "" "" ""


-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Age String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    
    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      { model | age = age }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , viewValidation model
    ]

viewValidation : Model -> Html Msg
viewValidation model =
  let
    (color, message) =
      if not (String.all Char.isDigit model.age) then
        ("red", "Age should be number")
      else if String.length model.password <= 8 then
        ("red", "Password should be longer than 8 characters!")
      else if not (String.any Char.isUpper model.password) then
        ("red", "Password should have upper case")
      else if not (String.any Char.isLower model.password) then
        ("red", "Password should have lower case")
      else if not (String.any Char.isDigit model.password) then
        ("red", "Password should have digit")
      else if not (model.password == model.passwordAgain) then
        ("red", "Passwords do not match!")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]
