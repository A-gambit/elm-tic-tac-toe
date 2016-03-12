module Game.Update where

import Game.Model exposing (initialModel, Model)


type Action
  = NoOp
  | Move Int Int
  | Restart


checkDraw : List (List Int) -> Bool
checkDraw table =
  List.all (\row -> List.all (\x -> x /= 0) row) table

checkWin : Int -> List (List Int) -> Bool
checkWin cur table =
  let
    checkItem val =
      val == Just cur
    getItem index row =
      List.head <| List.drop index <| List.take (index + 1) <| row
    getReverseItem index row =
        getItem (List.length row - index - 1) row
    checkItemInRow index row =
      row |> getItem index |> checkItem
  in
    List.any (\row -> List.sum row == (*) cur (List.length row)) table
    || List.any (\index -> List.all (checkItemInRow index) table) [0..(List.length table)]
    || List.all checkItem (List.indexedMap getItem table)
    || List.all checkItem (List.indexedMap getReverseItem table)


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Move i j ->
      let
        updateItem x y val =
            if x == i && y == j then model.cur else val
        updateRow x row =
          List.indexedMap (updateItem x) row
        table = List.indexedMap updateRow model.table
        winner =
          if checkWin model.cur table then model.cur else model.winner
      in
        if model.winner > 0 || model.draw then
          model
        else
          { model
            | table = table
            , cur = (*) model.cur -1
            , winner = winner
            , draw = checkDraw table
          }

    Restart ->
      initialModel
