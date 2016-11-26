import Html exposing (Html, button, div)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Tuple
import Debug

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { time: Time
  , isPaused: Bool
  }

init : (Model, Cmd Msg)
init =
  (Model 0 False, Cmd.none)


-- UPDATE

type Msg
  = Tick Time
  | Pause

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | time = newTime }, Cmd.none)
    Pause ->
      ({ model | isPaused = True }, Cmd.none)
      


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  if model.isPaused then
    Sub.none
  else
    Time.every second Tick

-- VIEW

view: Model -> Html Msg

view model =
  let
    correctedTime = model.time - (3 * 60 * 60 * 1000)
    minutes =
      (Time.inMinutes correctedTime)

    hours =
      (Time.inHours correctedTime)
    
    halfOfDays =
      hours / 12


  in
    div []
      [ svg [ viewBox "0 0 100 100", width "300px" ]
        [ circle [ cx "50", cy "50", r "45", fill "#0B79CE"] []
        , hand "#FFFFFF" 40 minutes
        , hand "#023963" 40 hours
        , hand "#000000" 30 halfOfDays
        ]
      , button [ onClick Pause ] [ Html.text "pause" ]
      ]

hand: String -> Float -> Float -> Html Msg

hand color length value =
  let
    angle =
      turns (value - 0.25)

    handX =
      toString (50 + length * cos angle)

    handY =
      toString (50 + length * sin angle)
  in
    line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke color] []
