module Game.Update where

import String exposing (toInt)
import Result exposing (toMaybe)
import Maybe exposing (withDefault)
import Game.Model exposing (initialModel, Model)

type Action
  = NoOp
  | Restart
  | Move Int Int
  | UpdateSize String


checkDraw : List (List Int) -> Bool
checkDraw table =
  List.all (\row -> List.all (\x -> x /= 0) row) table

checkWin : Int -> List (List Int) -> Bool
checkWin cur table =
  let
    checkItem val =
      val == Just cur
    checkRow row =
       List.sum row == (*) cur (List.length row)
    getItem index row =
      List.head <| List.drop index <| List.take (index + 1) <| row
    getReverseItem index row =
        getItem (List.length row - index - 1) row
    checkItemInRow index row =
      row |> getItem index |> checkItem
  in
    List.any checkRow table
    || List.any (\index -> List.all (checkItemInRow index) table) [0..(List.length table)]
    || List.all checkItem (List.indexedMap getItem table)
    || List.all checkItem (List.indexedMap getReverseItem table)


setMove : Model -> Int -> Int -> Model
setMove model i j =
  let
    updateItem x y val =
        if x == i && y == j then model.cur else val
    updateRow x row =
      List.indexedMap (updateItem x) row
    table = List.indexedMap updateRow model.table
  in
    { model
      | table = table
      , cur = (*) model.cur -1
      , winner = if checkWin model.cur table then model.cur else model.winner
      , draw = checkDraw table
    }


createTable : Int -> List (List Int)
createTable size =
  List.repeat size <| List.repeat size 0

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    UpdateSize size ->
      let
        checkSize val =
          if val < 3 then
            3
          else if val > 100 then
           100
          else
            val
        newSize = toInt size |> toMaybe |> withDefault 0 |> checkSize
      in
        { initialModel
          | size = newSize
          , table = createTable newSize
        }

    Move i j ->
      if model.winner > 0 || model.draw then
        model
      else
        setMove model i j

    Restart ->
      { initialModel
        | size = model.size
        , table = createTable model.size
      }