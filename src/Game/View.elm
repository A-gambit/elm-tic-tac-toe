module Game.View where

import Html exposing (Html, div, span, text, input)
import Html.Events exposing (onClick)
import Html.Attributes exposing (type', placeholder, value, name, min, max)
import Signal exposing (Address)

import Game.Model exposing (Model)
import Game.Update exposing (Action (..))
import Game.Utils as Utils
import Game.Style as Style

view : Address Action -> Model -> Html
view address model =
  div
    [ Style.content <| List.length model.table ]
    [ titleEl
    , sizeEl address model.size
    , winnerEl address model.winner model.draw
    , tableEl address model.table
    ]

titleEl : Html
titleEl =
  div [ Style.title ] [ span [] [ text "Tic-Tac-Toe!" ] ]


sizeEl : Address Action ->  Int -> Html
sizeEl address size =
  div
  [ Style.sizeWrapper ]
  [ span [ Style.sizeLabel ] [ text "Size" ]
  , input
    [ type' "number"
    , placeholder "Size"
    , value <| toString size
    , Html.Attributes.min "3"
    , Html.Attributes.max "100"
    , Utils.onInput address UpdateSize
    , Style.sizeInput
    ]
    []
  ]

winnerEl : Address Action -> Int -> Bool -> Html
winnerEl address winner draw =
  let
    showWinner val =
      (++) (if val == 1 then "First" else "Second") " player win"
    result =
      if winner /= 0 then
        showWinner winner
      else if draw then
        "Draw"
      else
        ""
  in
    div
      [ Style.sub ]
      [ span [ Style.win ] [ text result ]
      , span [ onClick address Restart, Style.restart ] [ text "Restart" ]
      ]

tableEl : Address Action -> List (List Int) -> Html
tableEl address table =
  let
    content = List.indexedMap (rowEl address) table
  in
    div [ Style.table <| List.length table ] content

rowEl : Address Action -> Int -> List Int -> Html
rowEl address i row =
  let
    rows = List.indexedMap (itemEl address i) row
  in
    div [ ] rows

itemEl : Address Action -> Int -> Int -> Int -> Html
itemEl address i j val =
  let
    toSymbol val =
      case val of
        1    -> span [ Style.cross ] [ text "X" ]
        (-1) -> span [ Style.circle ] [ text "O" ]
        _    -> span [ ] [ text "" ]
    action =
      if val == 0 then Move i j else NoOp
  in
    span [ onClick address action, Style.itemWrapper val ] [ toSymbol val ]
