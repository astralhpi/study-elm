import Html exposing (li, text, ul)
import Html.Attributes exposing (class)

main =
  ul [class "wish-list"]
    [ li [] [text "new macbook pro"]
    , li [] [text "and nothing"]
    ]
