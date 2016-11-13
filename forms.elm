import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Char
import Debug

main =
  App.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age: String
  , status: (String, String)
  }

model : Model
model =
  Model "" "" "" "" ("", "")


-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Age String
  | Submit


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

    Submit ->
      { model |  status = viewValidation model }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , button [ onClick Submit ] [ text "submit" ]
    , let
          (color, txt) = model.status
      in
        div [ style [ ("color", color)] ] [ text txt ]
    ]

viewValidation : Model -> (String, String)
viewValidation model =
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
