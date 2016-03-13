module Game.Model where

import Maybe exposing (..)

type Player
  = First
  | Second

type Mark
  = X
  | O
  | NoN

type GameStatus
  = InProgress
  | Draw
  | FirstWinner
  | SecondWinner

type alias Model =
  { table : List (List Mark)
  , player : Player
  , size : Int
  , status: GameStatus
  }

initialModel : Model
initialModel =
  { table =
    [ [ NoN, NoN, NoN ]
    , [ NoN, NoN, NoN ]
    , [ NoN, NoN, NoN ]
    ]
    , player = First
    , size = 3
    , status = InProgress
  }
