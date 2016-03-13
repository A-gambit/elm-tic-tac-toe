module Game.View where

import Html exposing (Html, div, span, text, input)
import Html.Events exposing (onClick)
import Html.Attributes exposing (type', value, name, min)
import Signal exposing (Address)

import Game.Model exposing (Model, Mark (..), GameStatus (..))
import Game.Update exposing (Action (..))
import Game.Utils as Utils
import Game.Style as Style

view : Address Action -> Model -> Html
view address model =
  div
    [ Style.content <| List.length model.table ]
    [ titleEl
    , sizeEl address model.size
    , winnerEl address model.status
    , tableEl address model.table
    ]

titleEl : Html
titleEl =
  div [ Style.title ] [ span [] [ text "Tic-Tac-Toe!" ] ]


sizeEl : Address Action -> Int -> Html
sizeEl address size =
  div
  [ Style.sizeWrapper ]
  [ span [ Style.sizeLabel ] [ text "Size" ]
  , input
    [ type' "number"
    , value <| toString size
    , Html.Attributes.min "0"
    , Utils.onInput address UpdateSize
    , Style.sizeInput
    ]
    []
  ]

winnerEl : Address Action -> GameStatus -> Html
winnerEl address status =
  let
    statusText =
      if status == InProgress then
        ""
      else if status == Draw then
        "Draw"
      else if status == FirstWinner then
        "First player win"
      else
        "Second player win"
  in
    div
      [ Style.sub ]
      [ span [ Style.win ] [ text statusText ]
      , span [ onClick address Restart, Style.restart ] [ text "Restart" ]
      ]

tableEl : Address Action -> List (List Mark) -> Html
tableEl address table =
  let
    content = List.indexedMap (rowEl address) table
  in
    div [ Style.table <| List.length table ] content

rowEl : Address Action -> Int -> List Mark -> Html
rowEl address i row =
  let
    rows = List.indexedMap (itemEl address i) row
  in
    div [ ] rows

itemEl : Address Action -> Int -> Int -> Mark -> Html
itemEl address i j val =
  let
    symbol =
      case val of
        X -> span [ Style.cross ] [ text "X" ]
        O -> span [ Style.circle ] [ text "O" ]
        _ -> span [ ] [ text "" ]
    action =
      if val == NoN then Move i j else NoOp
  in
    span [ onClick address action, Style.itemWrapper val ] [ symbol ]
