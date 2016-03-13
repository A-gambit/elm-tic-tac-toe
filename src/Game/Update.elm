module Game.Update where

import String exposing (toInt)
import Game.Model exposing (initialModel, Model, Player (..), Mark (..), GameStatus (..))

type Action
  = NoOp
  | Restart
  | Move Int Int
  | UpdateSize String

checkDraw : List (List Mark) -> Bool
checkDraw table =
  List.all (List.all ((/=) NoN)) table

checkWin : Mark -> List (List Mark) -> Bool
checkWin playerMark table =
  let
    checkItem mark =
      mark == playerMark
    getItem index row =
      Maybe.withDefault NoN
        <| List.head
        <| List.drop index
        <| List.take (index + 1)
        <| row
    getReverseItem index row =
       getItem (List.length row - index - 1) row
    checkItemInRow index row =
      row
        |> getItem index
        |> checkItem
    checkVertical index =
      List.all (checkItemInRow index) table
  in
    List.any (List.all checkItem) table
    || List.any checkVertical [0..(List.length table)]
    || List.all checkItem (List.indexedMap getItem table)
    || List.all checkItem (List.indexedMap getReverseItem table)

setMove : Model -> Int -> Int -> Model
setMove model i j =
  let
    playerMark =
      if model.player == First then X else O
    updateItem x y cur =
      if x == i && y == j then playerMark else cur
    updateRow x row =
      List.indexedMap (updateItem x) row
    table = List.indexedMap updateRow model.table
    isWin = checkWin playerMark table
    player =
      if model.player == First then Second else First
    status =
      if isWin && model.player == First then
        FirstWinner
      else if isWin && model.player == Second then
        SecondWinner
      else if checkDraw table then
        Draw
      else
        InProgress
  in
    { model
      | table = table
      , player = player
      , status = status
    }

createTable : Int -> List (List Mark)
createTable size =
  List.repeat size <| List.repeat size NoN

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    UpdateSize size ->
      let
        newSize =
          toInt size
            |> Result.toMaybe
            |> Maybe.withDefault 0
      in
        { initialModel
          | size = newSize
          , table = createTable newSize
        }

    Move i j ->
      if model.status /= InProgress then
        model
      else
        setMove model i j

    Restart ->
      { initialModel
        | size = model.size
        , table = createTable model.size
      }
